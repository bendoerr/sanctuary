import groovy.xml.XmlUtil
import groovy.xml.StreamingMarkupBuilder

def verbose = false

if(verbose) println "Maven Settings File Updater"

def settingsFile = new File(/${System.getenv("DEV_STTGS")}\mvn\settings.xml/)
if(verbose) println "  Settings file: ${settingsFile}"

def settings = new XmlSlurper().parse(settingsFile)

def repodir = /${System.getenv("DEV_REPOS")}\mvn/
if(verbose) println "  Repo directory: ${repodir}"

// Handle main localRepository.
if(verbose) println "  Found global localRepository: ${settings.localRepository}"
if(settings.localRepository != repodir) {
  if(verbose) println "    Updating global localRepository to: ${repodir}"
  settings.localRepository = repodir
}

// Handle any local.repository elements in profiles.
settings.profiles.profile.findAll { it.properties['local.repository'].text() }.each {
  if(verbose) println "  Found profile setting local.repository: ${it.properties['local.repository']}"
  if(it.properties['local.repository'] != repodir) {
    if(verbose) println "    Updating profile setting local.repository to: ${repodir}"
    it.properties['local.repository'] = repodir
  }
}
settingsFile.write(new XmlUtil().serialize(new StreamingMarkupBuilder().bind{mkp.yield settings}))