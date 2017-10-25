From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 24 Oct 2017 18:31:02 -0700
Subject: [PATCH V2 45/46] nvmftests: add class documentation and sequence
 diagram
In-Reply-To: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <1508895063-6280-46-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 tools/testing/selftests/nvmftests/doc/Makefile     |  7 ++
 .../selftests/nvmftests/doc/sequence-diag/Makefile |  7 ++
 .../nvmftests/doc/sequence-diag/nvmftests.plantuml | 98 ++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/doc/Makefile
 create mode 100644 tools/testing/selftests/nvmftests/doc/sequence-diag/Makefile
 create mode 100644 tools/testing/selftests/nvmftests/doc/sequence-diag/nvmftests.plantuml

diff --git a/tools/testing/selftests/nvmftests/doc/Makefile b/tools/testing/selftests/nvmftests/doc/Makefile
new file mode 100644
index 0000000..868b34a
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/doc/Makefile
@@ -0,0 +1,7 @@
+doc:
+	@epydoc -v --output=Documentation ../nvmf/*py ../tests/*py ../utils/*py
+	@make -C sequence-diag/
+
+clean:
+	@make -C sequence-diag/ clean
+	@rm -fr Documentation
diff --git a/tools/testing/selftests/nvmftests/doc/sequence-diag/Makefile b/tools/testing/selftests/nvmftests/doc/sequence-diag/Makefile
new file mode 100644
index 0000000..4a25c61
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/doc/sequence-diag/Makefile
@@ -0,0 +1,7 @@
+SRC=nvmftests
+
+all:
+	@plantuml ${SRC}.plantuml
+
+clean:
+	@rm -fr ${SRC}.png
diff --git a/tools/testing/selftests/nvmftests/doc/sequence-diag/nvmftests.plantuml b/tools/testing/selftests/nvmftests/doc/sequence-diag/nvmftests.plantuml
new file mode 100644
index 0000000..f3df765
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/doc/sequence-diag/nvmftests.plantuml
@@ -0,0 +1,98 @@
+ at startuml
+autonumber
+
+title nvmftest Sequence
+
+box "testcase.py" #LightBlue
+participant "Testcase" as tc
+end box
+
+box "target.py " #LightYellow
+participant "Target subsystems" as t
+end box
+
+box "target_subsystem.py" #LightBlue
+participant "Target namespace" as ts
+
+end box
+
+box "target_ns.py" #Gray
+participant "target namespace processing" as tns
+end box
+
+activate tc
+tc->t : initialize target object
+
+activate t
+t->ts : read config file and create target subsystem config_loop_target()
+ts->ts : initialize the target subsystem init()
+activate ts
+
+activate tns
+tns->tns : create and initialize namespace(s) init()
+tns->tns : initialize with device nguid
+tns->tns : initialize with device path
+tns->tns : enable ns enable_ns()
+
+tns->ts :
+ts->t :
+t->t : initialize port and assign subsystems to the port init()
+t->tc
+
+box "host.py " #LightYellow
+participant "host subsystems" as h
+end box
+
+box "host_subsystem.py" #LightBlue
+participant "host Namespace" as hs
+end box
+
+box "host_ns.py" #Gray
+participant "host namespace processing" as hns
+end box
+
+activate tc
+tc->h : initialize and configure host config()
+
+activate h
+h->hs : read config file and create host subsystem config_loop()
+hs->hs : initialize the host subsystem, connect to target init_ctrl()
+
+activate hs
+hs->hns : create and initialize namespace init_ctrl_ns()
+hns->hns : validate sysfs entries
+
+activate hns
+hns->hns : validate host namespace as a block device init()
+hns->hns : validate sysfs entries validate_sysfs_ns()
+
+hns->hs :
+hs->h :
+h->tc
+
+tc->tc : execute test case operations
+
+tc->h : delete host delete()
+h->hs : delete host system delete()
+hs->hns : delete host namespace delete()
+
+hns->hs :
+deactivate hns
+hs->h :
+deactivate hs
+h->tc
+deactivate h
+
+tc->t : delete target delete()
+t->t : delete port delete()
+t->ts : delete target subsystem delete()
+ts->tns : delete target namespaces delete()
+tns->ts
+deactivate tns
+deactivate ts
+ts->t
+deactivate t
+t->tc
+deactivate tc
+
+ at enduml
-- 
1.8.3.1
