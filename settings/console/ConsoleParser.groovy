import groovy.xml.XmlUtil
import groovy.xml.StreamingMarkupBuilder

def verbose = false

if(verbose) println "Console Settings File Updater"

def settingsFile = new File(/${System.getenv("DEV_STTGS")}\console\console.xml/)
if(verbose) println "  Settings file: ${settingsFile}"

def settings = new XmlSlurper().parse(settingsFile)

def devHomeDir = /${System.getenv("DEV_HOME")}/
if(verbose) println "  Development home directory: ${devHomeDir}"

def winDepTab = """
<tab title="WinDEP">
	<console shell="%comspec% /k ${devHomeDir}dev-setup.bat" init_dir="${devHomeDir}"/>
	<cursor style="0" r="255" g="255" b="255"/>
	<background type="0" r="0" g="0" b="0">
		<image file="" relative="0" extend="0" position="0">
			<tint opacity="0" r="0" g="0" b="0"/>
		</image>
	</background>
</tab>
 """
def foundWinDepTab = false

// Update the root console with the correct shell/starting directory.
settings.console.'@shell' = "%comspec% /k ${devHomeDir}dev-setup.bat"
settings.console.'@init_dir' = "${devHomeDir}"

// Update WinDEP tabs, or add a default tab one doesn't already exist.
settings.tabs.tab.findAll { it.'@title'.text() }.each {
  if(verbose) println "  Found tab setting: ${it.'@title'.text()}"

  if(it.'@title'.toString().contains("WinDEP")) {
    if(verbose) println "    Updating WinDEP tab directory settings to: ${devHomeDir}"
    it.console.'@shell' = "%comspec% /k ${devHomeDir}dev-setup.bat"
	it.console.'@init_dir' = "${devHomeDir}"
	foundWinDepTab = true
  }
  
}

if(!foundWinDepTab) {
	if(verbose) println "  No WinDEP tabs found. Adding default WinDEP tab setttings."
	settings.tabs.appendNode(new XmlSlurper().parseText(winDepTab))
}

settingsFile.write(new XmlUtil().serialize(new StreamingMarkupBuilder().bind{mkp.yield settings}))
