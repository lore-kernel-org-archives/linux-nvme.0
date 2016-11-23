From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Wed, 23 Nov 2016 10:01:11 -0800
Subject: [PATCH 1/3] nvmetcli: Adding manpage/html generation
In-Reply-To: <1479924073-6952-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1479924073-6952-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1479924073-6952-2-git-send-email-james_p_freyensee@linux.intel.com>

Signed-off-by: Jay Freyensee <james.p.freyensee at intel.com>
---
 Documentation/Makefile     |  21 ++++
 Documentation/nvmetcli.txt | 237 +++++++++++++++++++++++++++++++++++++++++++++
 Makefile                   |  15 ++-
 3 files changed, 271 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/Makefile
 create mode 100644 Documentation/nvmetcli.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
new file mode 100644
index 0000000..432731a
--- /dev/null
+++ b/Documentation/Makefile
@@ -0,0 +1,21 @@
+PKGNAME = nvmetcli
+MANPAGE = ${PKGNAME}.1
+HTMLFILE = ${PKGNAME}.html
+XMLFILE = ${PKGNAME}.xml
+
+ASCIIDOC = asciidoc
+XMLTO = xmlto --skip-validation
+
+DOCDATA = ${XMLFILE} ${HTMLFILE}
+ 
+${MANPAGE}: ${DOCDATA}
+	${XMLTO} man $<
+ 
+%.xml: %.txt
+	${ASCIIDOC} -b docbook -d manpage -o $@ $<
+ 
+%.html: %.txt
+	${ASCIIDOC} -a toc -o $@ $<
+ 
+clean:
+	-rm -f ${MANPAGE} ${HTMLFILE} ${XMLFILE}
diff --git a/Documentation/nvmetcli.txt b/Documentation/nvmetcli.txt
new file mode 100644
index 0000000..8ec66eb
--- /dev/null
+++ b/Documentation/nvmetcli.txt
@@ -0,0 +1,237 @@
+nvmetcli(1)
+===========
+
+NAME
+----
+nvmetcli - Configure NVMe Target for NVMe-over-Fabrics solution.
+
+USAGE
+------
+[verse]
+nvmetcli
+nvmetcli [cmd] [file]
+
+DESCRIPTION
+-----------
+*nvmetcli* is a python-based program used for viewing, editing, saving,
+and starting a Linux kernel NVMe Target, used for an NVMe-over-Fabrics
+network configuration.  It enables an administrator to assign local
+storage resources backed by either local NVMe devices, OS files, or
+system volumes and export them to remote systems via network fabrics
+based on the NVMe-over-Fabrics specification from http://www.nvmexpress.org.
+
+*nvmetcli* is run as root and has two modes:
+
+1. An interactive configuration shell
+2. Command-line mode which uses an argument
+
+nvmetcli manages only one NVMe Target as there is only one Linux kernel
+NVMe Target per system.
+
+BACKGROUND
+----------
+The term *NQN* used throughout this man page is the *NVMe Qualified
+Name* format which an NVMe endpoint (device, subsystem, etc) must
+follow to guarantee a unique name under the NVMe standard.  Any
+name in a network system setup can be used, but if it does not
+follow the NQN format, it may not be unique on an NVMe-over-Fabrics network.
+
+Note that some of the fields set for an NVMe Target port under
+interactive mode are defined in the "Discovery Log Page" section of
+NVMe-over-Fabrics specification. Each NVMe Target has a
+discovery controller mechanism that an NVMe Host can use to determine
+the NVM subsystems it can access.  *nvmetcli* can be used to add
+a new record to the discovery controller upon each new subsystem
+entry and port entry that the newly created subsystem entry binds
+to (see *OPTIONS* and *EXAMPLES* sections).  Each NVMe
+Host only gets to see the discovery entries defined in
+*/subsystems/[NQN NAME]/allowed_hosts* and the IP port it is connected
+to the NVMe Target.  An NVMe Host can retrieve these discovery logs via
+the nvme-cli tool (https://github.com/linux-nvme/nvme-cli).
+
+OPTIONS
+-------
+*Interactive Configuration Shell*
+
+To start the interactive configuration shell, type *nvmetcli* on
+the command-line.  nvmetcli interacts with the Linux kernel
+NVMe Target configfs subsystem starting at base
+nvmetcli directories **/port**, **/subsystem**, and **/host**.
+Configuration changes entered by the administrator are made
+immediately to the kernel target configuration.  The
+following commands can be used while in the interactive configuration
+shell mode:
+[]
+|==================
+| cd                    | Same as Linux, allows to move around the tree. 
+| ls                    | Similar as Linux, lists contents of current tree node.
+| create [NQN name]/[#] | Create a new object using the specified name
+                          or number. If a [NQN name]/[#] is not specified,
+                          a random entry will be used.
+| delete [NQN name]/[#] | Delete an object with the specified name or number.
+| set attr allow_any_host=[0/1] | Used under */subsystems/[NQN name]* to
+                                  specify if any NVMe Host can connect to
+                                  the subsystem.
+| set device path=[device path] | Used under
+                                  */subsystems/[NQN name]/namespaces*
+                                  to set the (storage) device to be used.
+| set device nguid=[string]     | Used under
+                                  */subsystems/[NQN name]/namespaces*
+                                  to set the unique id of the device to
+                                  the defined namespace.
+| enable/disable                | Used under
+                                  */subsystems/[NQN name]/namespaces*
+                                  to enable and disable the namespace.
+| set addr [discovery log page field]=[string] | Used under */ports/[#]*
+                                                 to create a port which
+                                                 access is allowed. See
+                                                 *EXAMPLES* for more
+                                                 information.
+| saveconfig [filename.json]    | Save the NVMe Target configuration in .json
+                                  format.  Without specifying the
+                                  filename this will save as
+                                  */etc/nvmet/config.json*.  This file
+                                  is in JSON format and can be edited directly
+                                  using a prefered file editor.
+| exit                          | Quits interactive configuration shell mode.
+|==================
+
+*Command Line Mode*
+
+Typing *nvmetcli [cmd]* on the command-line will execute a command
+and not enter the interactive configuration shell.
+
+[]
+|==================
+| restore [filename.json] | Loads a saved NVMe Target configuration.
+                            Without specifying the filename this will use
+                            */etc/nvmet/config.json*.
+| clear                   | Clears a current NVMe Target configuration.
+|==================
+
+EXAMPLES
+--------
+
+Make sure to run nvmetcli as root, the nvmet module is loaded,
+your devices and all dependent modules are loaded,
+and configfs is mounted on /sys/kernel/config
+using:
+
+	mount -t configs none /sys/kernel/config
+
+The following section walks through a configuration example.
+
+* To get started with the interactive mode and the nvmetcli command prompt,
+type (in root):
+--------------
+# ./nvmetcli
+...>
+--------------
+
+* Create a subsystem.  If you do not specify a name a NQN will be generated,
+which is probably the best choice. We don't do it here as the name
+would be random:
+--------------
+> cd /subsystems
+...> create testnqn
+--------------
+
+* Add access for a specific NVMe Host by it's NQN:
+--------------
+...> cd /hosts
+...> create hostnqn
+...> cd /subsystems/testnqn
+...> set attr allow_any_host=0
+...> cd /subsystems/testnqn/allowed_hosts/
+...> create hostnqn
+--------------
+
+* Remove access of a subsystem by deleting the Host NQN:
+--------------
+...> cd /subsystems/testnqn/allowed_hosts/
+...> delete hostnqn
+--------------
+
+* Alternatively this allows any Host to connect to the subsystsem.  Only
+use this in tightly controlled environments:
+--------------
+...> cd /subsystems/testnqn/
+...> set attr allow_any_host=1
+--------------
+
+* Create a new namespace.  If you do not specify a namespace ID the fist
+unused one will be used:
+--------------
+...> cd /subsystems/testnqn/namespaces
+...> create 1
+...> cd 1
+...> set device path=/dev/nvme0n1
+...> enable
+--------------
+
+Note that in the above setup the 'device_nguid' attribute
+does not have to be set for correct NVMe Target functionality (but
+to correctly match a namespace to the exact device upon
+clear and restore operations, it is advised to set the
+'device_nguid' parameter).
+
+* Create a loopback port that can be used with nvme-loop module
+on the same physical machine...
+--------------
+...> cd /ports/
+...> create 1
+...> cd 1/
+...> set addr trtype=loop
+...> cd subsystems/
+...> create testnqn
+--------------
+
+* or create an RDMA (IB, RoCE, iWarp) port using IPv4 addressing. 4420 is the
+IANA assigned default port for NVMe over Fabrics using RDMA:
+--------------
+...> cd /ports/
+...> create 2
+...> cd 2/
+...> set addr trtype=rdma
+...> set addr adrfam=ipv4
+...> set addr traddr=192.168.6.68
+...> set addr trsvcid=4420
+...> cd subsystems/
+...> create testnqn
+--------------
+
+* Saving the NVMe Target configuration:
+--------------
+./nvmetcli
+...> saveconfig test.json
+--------------
+
+* Loading an NVMe Target configuration:
+--------------
+  ./nvmetcli restore test.json
+--------------
+
+* Clearing a current NVMe Target configuration:
+--------------
+  ./nvmetcli clear
+--------------
+
+ADDITIONAL INFORMATION
+----------------------
+nvmetcli has the ability to start and stop the NVMe Target configuration
+on boot and shutdown through the *systemctl* Linux utility via a .service file.
+
+AUTHORS
+-------
+This was written by mailto:james.p.freyensee at intel.com[Jay Freyensee]
+for mailto:hch at infradead.org[Christoph Hellwig].
+
+REPORTING BUGS & DEVELOPMENT
+-----------------------------
+Please send patches to linux-nvme at lists.infradead.org for review and acceptance.
+
+LICENSE
+-------
+nvmetcli is licensed under the *Apache License, Version 2.0*. Software
+distributed under this license is distributed on an "AS IS" BASIS, WITHOUT
+WARRANTIES OR CONDITIONS OF ANY KIND, either expressed or implied.
diff --git a/Makefile b/Makefile
index a8dc916..10faa4e 100644
--- a/Makefile
+++ b/Makefile
@@ -2,6 +2,7 @@ PKGNAME = nvmetcli
 NAME = nvmet
 GIT_BRANCH = $$(git branch | grep \* | tr -d \*)
 VERSION = $$(basename $$(git describe --tags | tr - . | sed 's/^v//'))
+DOCDIR = ./Documentation
 
 all:
 	@echo "Usage:"
@@ -9,13 +10,23 @@ all:
 	@echo "  make deb         - Builds debian packages."
 	@echo "  make rpm         - Builds rpm packages."
 	@echo "  make release     - Generates the release tarball."
+	@echo "  make doc         - Builds manpages & html docs in ${DOCDIR}."
 	@echo
 	@echo "  make clean       - Cleanup the local repository build files."
-	@echo "  make cleanall    - Also remove dist/*"
+	@echo "  make cleandoc    - Cleanup auto-generated docs in ${DOCDIR}."
+	@echo "  make cleanall    - Remove dist/*, build files, auto-gen docs."
 
 test:
 	@nose2 -C --coverage ./nvmet
 
+doc: ${NAME}
+	${MAKE} -C ${DOCDIR}
+
+cleandoc:
+	@rm -f ${DOCDIR}/${PKGNAME}.1
+	@rm -f ${DOCDIR}/${PKGNAME}.html
+	@rm -f ${DOCDIR}/${PKGNAME}.xml
+	
 clean:
 	@rm -fv ${NAME}/*.pyc ${NAME}/*.html
 	@rm -frv doc
@@ -25,7 +36,7 @@ clean:
 	@rm -frv ${PKGNAME}-*
 	@echo "Finished cleanup."
 
-cleanall: clean
+cleanall: clean cleandoc
 	@rm -frv dist
 
 release: build/release-stamp
-- 
2.7.4
