#ClickToFlash

[Download ClickToFlash 1.3 here](http://s3.amazonaws.com/clicktoflash/ClickToFlash-1.3.zip). Currently requires Mac OS X 10.5 Leopard.

ClickToFlash is a WebKit plug-in that prevents automatic loading of Adobe Flash content. If you want to see the content, you can opt-in by clicking on it or adding an entire site to its whitelist.

Try control-clicking (or right-clicking) on a unloaded Flash box to access ClickToFlash's contextual menu which allow you to do advanced things like edit its whitelist.

Please [report bugs and request features](http://rentzsch.lighthouseapp.com/projects/24342-clicktoflash/tickets/new) on the [Lighthouse ClickToFlash project site](http://rentzsch.lighthouseapp.com/projects/24342-clicktoflash/tickets?q=all).

Want to chip in? [Here's what needs to be done](http://rentzsch.lighthouseapp.com/projects/24342-clicktoflash/tickets?q=not-tagged%3Abrokensite+state%3Aopen&filter=).

##Version History

* **1.3** [download](http://s3.amazonaws.com/clicktoflash/ClickToFlash-1.3.zip)
	* [NEW] Flash badge is now drawn in code (vector image), and draws smaller in smaller flash boxes. [bug 12](http://rentzsch.lighthouseapp.com/projects/24342/tickets/12)

	* [NEW] Flash badge rotates counter-clockwise for narrow flash boxes. [bug 12](http://rentzsch.lighthouseapp.com/projects/24342/tickets/12)

	* [NEW] "Add to whitelist" contextual menu item now lists the url that's to be whitelisted. [bug 20](http://rentzsch.lighthouseapp.com/projects/24342/tickets/20-add-to-whitelist-sheet-unnecessary-when-rightclicking) ([Kevin A. Mitchell](http://github.com/kamitchell/clicktoflash/commit/83f121029225b16ae2e4d4f6a2f2bc64d2235b02))

	* [NEW] Extend coverage to `<object>` and `<embed>` tags that lack `type` or `classid` attributes by adding `swf` to the plugin's `WebPluginExtensions` Info.plist key. [bug 19](http://rentzsch.lighthouseapp.com/projects/24342/tickets/19) ([fds](http://rentzsch.lighthouseapp.com/projects/24342/tickets/19#ticket-19-10))

	* [NEW] Kill badge flicker for whitelisted sites ([bug 17](http://rentzsch.lighthouseapp.com/projects/24342/tickets/17)) and load all 
flash boxes when whitelisting one ([bug 10](http://rentzsch.lighthouseapp.com/projects/24342/tickets/10)).

	* [FIX] Remove `-menuForEvent:` as it already returns the NSResponder's `-menu` by default. ([Dave Dribin](http://github.com/ddribin/clicktoflash/commit/5de474bc17332208fd21ec78fe7eaf3a9844d7bf))

	* [FIX] Remove CTFInstaller.m from the bare plugin target. [bug 44](http://rentzsch.lighthouseapp.com/projects/24342-clicktoflash/tickets/44) ([Chris Parker](http://github.com/tgaul/clicktoflash/commit/17d455844a7428471dca018d1461f5c5d1cbb692))

	* [DEV] Make Rakefile honor build products directory. [bug 43](http://rentzsch.lighthouseapp.com/projects/24342/tickets/43) ([Chris Parker](http://github.com/tgaul/clicktoflash/commit/021eebfd274b4e415c31c2ac9e4bb2ffed569ee4))

* **1.2** [download](http://s3.amazonaws.com/clicktoflash/ClickToFlash-1.2.zip)
	* [NEW] Handle `<object>` and `<embed>` that are missing a `type` attribute. That fixes a number of the broken sites. [bug #19](http://rentzsch.lighthouseapp.com/projects/24342/tickets/19-banner-ad-appears-without-whitelisting) ([Jason Foreman](http://github.com/threeve/clicktoflash/commit/e4a7ad83c312bcc3d7400562905122951ae85763))

	* [NEW] Activate on mouse-up, instead of mouse-down. Draw as "pressed in" during mouse-down, tracking the mouse like normal button. (Peter Hosey)

	* [NEW] Added a seperator to the context menu.

	* [FIX] Release build-time script that includes the project's entire build directory. ([Peter Hosey](http://github.com/boredzo/clicktoflash/commit/0b063cd0987254fd61aaa2b317ef2d79f30a44a8))

* **1.1** [download](http://s3.amazonaws.com/clicktoflash/ClickToFlash-1.1.zip)
	* [NEW] Tasteful "Flash" icon now drawn on top of the gradient to make it more clear that it's blocked Flash content. ([Ricky Romero, Justin Williams](http://rentzsch.lighthouseapp.com/projects/24342/tickets/3-flash-boxes-are-not-always-obvious))

	* [NEW] Contextual menu and simple whitelist editor. ([Dave Dribin](http://github.com/ddribin/clicktoflash))

	* [NEW] Show the Flash box's source as a tooltip. ([Jason Foreman](http://github.com/threeve/clicktoflash/commit/a54c97c7be43e0adfbb0aad317c6020666d2a2e3))

	* [NEW] Installer can update older versions. (rentzsch)

	* [NEW] Rakefile to compile & upgrade the plugin by running 'rake' in the directory. ([Ale Muñoz](http://github.com/bomberstudios/clicktoflash/commit/2807f05aafe829e942f0c945ab914c0830652f73))

	* [NEW] Localization support. ([Eric Czarny](http://github.com/eczarny/clicktoflash/commit/beefab38bdb881fd78ac6e844e1e1d53206b118c))

	* [DEV] Clean-up. Nonatomic properties, remove unused methods, `unsigned` => `NSUInteger`. (Jim Correia)

	* [DEV] Change CFBundleIdentifier from com.google.code.p.clicktoflash to com.github.rentzsch.clicktoflash. (rentzsch)

	* [FIX] Installer now quits when canceling. (rentzsch)

	* [FIX] Removed the container image from the installer. ([Eric Czarny](http://github.com/eczarny/clicktoflash/commit/d25675cd97e4709b9a794029c06794d87ac8c9af))

* *original Google code project deleted. This fork takes on official-ish mantle.*

* **1.0+rentzsch** [download](http://s3.amazonaws.com/clicktoflash/ClickToFlash%2Brentzsch-1.0.zip)

	* Forked from original Google code project (Jonathan 'Wolf' Rentzsch)

	* [NEW] Site whitelisting by holding down option key when clicking a flash box. (Gus Mueller)

	* [FIX] Use `-[NSEvent modifierFlags]` instead of Carbon's `GetCurrentKeyModifiers()`. (Chris Parker)

	* [DEV] Store white-listed sites in an array instead of composite keys. ([Jean-Francois Roy](https://twitter.com/jfroy/status/1150564777))

* **1.0** original Google Code release
