From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Sun, 11 Jun 2017 20:26:10 -0700
Subject: [PATCH] selftests: nvmftests: unittest framework for NVMe Over
 Fabrics.
In-Reply-To: <20170612032610.4176-1-chaitanya.kulkarni@hgst.com>
References: <20170612032610.4176-1-chaitanya.kulkarni@hgst.com>
Message-ID: <20170612032610.4176-2-chaitanya.kulkarni@hgst.com>

This adds NVMe Over Fabrics unittests framework.
---
 tools/testing/selftests/nvmftests/Makefile         |  45 +++
 tools/testing/selftests/nvmftests/README.md        | 140 +++++++
 tools/testing/selftests/nvmftests/host.py          | 254 +++++++++++++
 tools/testing/selftests/nvmftests/host_ns.py       | 285 ++++++++++++++
 .../testing/selftests/nvmftests/host_subsystem.py  | 420 +++++++++++++++++++++
 tools/testing/selftests/nvmftests/loop.json        | 248 ++++++++++++
 tools/testing/selftests/nvmftests/loopback.py      | 116 ++++++
 tools/testing/selftests/nvmftests/nvmf_test.py     |  85 +++++
 .../selftests/nvmftests/nvmf_test_logger.py        |  50 +++
 tools/testing/selftests/nvmftests/port.py          | 139 +++++++
 tools/testing/selftests/nvmftests/target.py        | 209 ++++++++++
 tools/testing/selftests/nvmftests/target_ns.py     | 132 +++++++
 .../selftests/nvmftests/target_subsystem.py        | 148 ++++++++
 .../nvmftests/test_nvmf_create_delete_fabric.py    |  72 ++++
 .../selftests/nvmftests/test_nvmf_create_host.py   |  67 ++++
 .../selftests/nvmftests/test_nvmf_create_target.py |  59 +++
 .../selftests/nvmftests/test_nvmf_host_template.py |  69 ++++
 .../selftests/nvmftests/test_nvmf_id_ctrl.py       |  69 ++++
 .../testing/selftests/nvmftests/test_nvmf_id_ns.py |  69 ++++
 .../testing/selftests/nvmftests/test_nvmf_mkfs.py  |  70 ++++
 .../selftests/nvmftests/test_nvmf_parallel_io.py   |  71 ++++
 .../selftests/nvmftests/test_nvmf_random_io.py     |  71 ++++
 .../selftests/nvmftests/test_nvmf_simple_io.py     |  71 ++++
 .../selftests/nvmftests/test_nvmf_smart_log.py     |  69 ++++
 .../nvmftests/test_nvmf_target_template.py         |  64 ++++
 25 files changed, 3092 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/Makefile
 create mode 100644 tools/testing/selftests/nvmftests/README.md
 create mode 100644 tools/testing/selftests/nvmftests/host.py
 create mode 100644 tools/testing/selftests/nvmftests/host_ns.py
 create mode 100644 tools/testing/selftests/nvmftests/host_subsystem.py
 create mode 100644 tools/testing/selftests/nvmftests/loop.json
 create mode 100644 tools/testing/selftests/nvmftests/loopback.py
 create mode 100644 tools/testing/selftests/nvmftests/nvmf_test.py
 create mode 100644 tools/testing/selftests/nvmftests/nvmf_test_logger.py
 create mode 100644 tools/testing/selftests/nvmftests/port.py
 create mode 100644 tools/testing/selftests/nvmftests/target.py
 create mode 100644 tools/testing/selftests/nvmftests/target_ns.py
 create mode 100644 tools/testing/selftests/nvmftests/target_subsystem.py
 create mode 100644 tools/testing/selftests/nvmftests/test_nvmf_create_delete_fabric.py
 create mode 100644 tools/testing/selftests/nvmftests/test_nvmf_create_host.py
 create mode 100644 tools/testing/selftests/nvmftests/test_nvmf_create_target.py
 create mode 100644 tools/testing/selftests/nvmftests/test_nvmf_host_template.py
 create mode 100644 tools/testing/selftests/nvmftests/test_nvmf_id_ctrl.py
 create mode 100644 tools/testing/selftests/nvmftests/test_nvmf_id_ns.py
 create mode 100644 tools/testing/selftests/nvmftests/test_nvmf_mkfs.py
 create mode 100644 tools/testing/selftests/nvmftests/test_nvmf_parallel_io.py
 create mode 100644 tools/testing/selftests/nvmftests/test_nvmf_random_io.py
 create mode 100644 tools/testing/selftests/nvmftests/test_nvmf_simple_io.py
 create mode 100644 tools/testing/selftests/nvmftests/test_nvmf_smart_log.py
 create mode 100644 tools/testing/selftests/nvmftests/test_nvmf_target_template.py

diff --git a/tools/testing/selftests/nvmftests/Makefile b/tools/testing/selftests/nvmftests/Makefile
new file mode 100644
index 0000000..c4a929d1
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/Makefile
@@ -0,0 +1,45 @@
+###############################################################################
+#
+#    Makefile : Allows user to run testcases, generate documentation, and
+#               perform static code analysis.
+#
+###############################################################################
+
+NOSE2_OPTIONS="--verbose"
+
+help: all
+
+all:
+	@echo "Usage:"
+	@echo
+	@echo "  make run         - Run all testcases."
+	@echo "  make doc         - Generate Documentation."
+	@echo "  make cleanall    - removes *pyc, documentation."
+	@echo "  make static_check- runs pep8, flake8, pylint on code."
+
+doc:
+	@epydoc -v --output=Documentation *.py
+
+run:
+	nose2 ${NOSE2_OPTIONS}
+
+static_check:
+	@for i in `ls *.py`; \
+	do \
+		echo "Pylint :- " ; \
+		printf "%10s    " $${i}; \
+		pylint $${i} 2>&1  | grep "^Your code" |  awk '{print $$7}';\
+		echo "--------------------------------------------";\
+		pep8 $${i}; \
+		echo "pep8 :- "; \
+		echo "flake8 :- "; \
+		flake8 $${i}; \
+	done
+
+cleanall: clean
+	@rm -fr Documentation logs/*
+
+clean_logs:
+	@rm -fr logs/*
+clean:
+	@rm -fr *.pyc
diff --git a/tools/testing/selftests/nvmftests/README.md b/tools/testing/selftests/nvmftests/README.md
new file mode 100644
index 0000000..f5e5409
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/README.md
@@ -0,0 +1,140 @@
+nvmftests
+=========
+
+
+1. Introduction
+---------------
+
+    This contains NVMe Over Fabrics unit test framework. The purpose of this
+    framework is to provide a platform to create different scenarios and test
+    specific functionality for NVMe Over Fabrics Subsystem.
+
+2. Overview
+-----------
+
+    The main objective of this framework is to have a platform in place which
+    can provide :-
+        1. Classes and methods for each component in the NVMeOF subsystem.
+        2. Ability to build NVMeOF subsystem based on the configuration file.
+        3. Ability to issue sequential and parallel commands to the different
+           namespaces and controllers from the host side.
+
+    All the testcases are written in python nose2 format. This framework
+    follows a simple class hierarchy. Each test is a direct subclass or indirect
+    subclass of NVMeOFTest. To write a new testcase one can copy an existing
+    template test_nvmf_target_template.py or test_nvmf_host_template.py and
+    start adding new testcase specific functionality.
+
+3. Class hierarchy and Design Considerations
+--------------------------------------------
+
+    3.1. Core Classes :-
+       Target Classes :-
+           NVMeOFTarget :- Represents Target.
+           NVMeOFTargetSubsystem :- Represents a Target Subsystem.
+           NVMeOFTargetNamespace :- Represents a Target Namespace.
+           NVMeOFTargetPort :- Represents a Target Port.
+       Host Classes
+           NVMeOFHost :- Represents Host.
+           NVMeOFHostController :- Represents a Host Controller.
+           NVMeOFHostNamespace :- Represents a Host Namespace.
+
+       We divide host and target side components into two different class
+       hierarchies. On the host side, we have a controller represented as a
+       character device and each namespace as a block device. In order to
+       add any new functionality to the framework please modify core classes
+       for each component and propagate new interfaces to the top
+       level (in host.py/target.py). On the target side, we have subsystem(s),
+       namespace(s), and port(s) which is mainly configured using configfs.
+       For detailed class hierarchy please look into Documentation/index.html.
+    3.2. Testcase class:-
+        NVMeOFTest :- Base class for each testcase, contains common functions.
+
+4. Adding new testcases
+-----------------------
+
+    4.1. Please refer host or target template testcase.
+    4.2. Copy the template file with your testcase name.
+    4.3. Update the class name with testcase name.
+    4.4. Update the test case function name.
+    4.5. If necessary update the core files and add new functionality.
+    4.6. Add testcase main function to determine success or failure.
+    4.7. Update setUp() and tearDown() to add pre and post functionality.
+    4.8. Once testcase is ready make sure :-
+         4.8.1. Run pep8, flake8, pylint and fix errors/warnings.
+                -Example "$ make static_check" will run pep8, flake8 and pylint
+                 on all the python files in current directory.
+         4.8.2. Execute make doc to generate the documentation.
+                -Example "$ make doc" will create and update existing
+                 documentation.
+
+5. Running testcases with framework
+-----------------------------------
+
+    Here are some examples of running testcases with nose2 :-
+        5.1. Running single testcase with nose2 :-
+            # nose2 --verbose test_nvmf_create_target
+            # nose2 --verbose test_nvmf_create_host
+
+        5.2. Running all the testcases :-
+            # nose2 --verbose
+
+    Some notes on execution:-
+        In the current implementation, it uses file backed loop device on the
+        target side. For each testcase execution, new file is created and linked
+        with loop device. It expects that "/mnt/" has enough space available to
+        store backend files which are used for target namespaces. Please edit
+        the target subsystems and namespace configuration in loop.json and
+        size of the loop device on the target side in the nvmf_test.py
+        according to your need.
+
+        For host and target setup you may have to configure timeout (sleep())
+        values in the code to make sure previous steps are completed
+        successfully and resources are online before executing next the steps.
+
+6. Logging
+----------
+
+    For each testcase, it will create a separate log directory with the test
+    name under logs/. This directory will be used for temporary files and
+    storing execution logs of each testcase. Current implementation stores
+    stdout and stderr for each testcase under log directory, e.g.:-
+        logs/
+        |-- TestNVMeOFParallelFabric
+        |       |-- stderr.log
+        |       |-- stdout.log
+        |-- TestNVMeOFRandomFabric
+        |       |-- stderr.log
+        |       |-- stdout.log
+        |--- TestNVMeOFSeqFabric
+                |-- stderr.log
+                |-- stdout.log
+                .
+                .
+                .
+
+7. Dependencies
+---------------
+
+    6.1. Python(>= 2.7.5 or >= 3.3)
+    6.2. nose(http://nose.readthedocs.io/en/latest/)
+    6.3. nose2(Installation guide http://nose2.readthedocs.io/)
+    6.4. pep8(https://pypi.python.org/pypi/setuptools-pep8)
+    6.5. flake8(https://pypi.python.org/pypi/flake8)
+    6.6. pylint(https://www.pylint.org/)
+    6.7. Epydoc(http://epydoc.sourceforge.net/)
+    6.8. nvme-cli(https://github.com/linux-nvme/nvme-cli.git)
+
+    Python package management system pip can be used to install most of the
+    listed packages(https://pip.pypa.io/en/stable/installing/) :-
+
+    $ pip install nose nose2 natsort pep8 flake8 pylint epydoc
+
+8. Future Work
+--------------
+
+    7.1. Add support for thread safe logging.
+    7.2. Improve error handling for host namespaces.
+    7.3. Improve support for parallel command submission and return code.
+    7.4. Report generation mechanism.
+    7.5  Add support for better testcase configuration.
diff --git a/tools/testing/selftests/nvmftests/host.py b/tools/testing/selftests/nvmftests/host.py
new file mode 100644
index 0000000..c0866c6
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/host.py
@@ -0,0 +1,254 @@
+# Copyright (c) 2016-2017 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+""" Represents NVMe Over Fabric Host Subsystem.
+"""
+
+import json
+import random
+import subprocess
+
+from host_subsystem import NVMeOFHostController
+
+
+class NVMeOFHost(object):
+
+    """
+    Represents a host.
+        - Attributes :
+              - target_type : rdma/loop/fc. (only loop supported now)
+              - ctrl_list : list of the host controllers.
+    """
+    def __init__(self, target_type):
+        """ Constructor for NVMeOFHost.
+            - Args :
+                  - target_type : represents target transport type.
+                  - ctrl_list : list of host controllers.
+            - Returns :
+                  - None.
+        """
+        self.target_type = target_type
+        self.ctrl_list = []
+        self.err_str = "ERROR : " + self.__class__.__name__ + " : "
+        self.load_modules()
+
+    def load_modules(self):
+        """ Wrapper for Loading NVMeOF Host modules.
+            - Args :
+                  - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        ret = self.exec_cmd("modprobe nvme-fabrics")
+        if ret is False:
+            print self.err_str + "unable to load nvme-fabrics."
+            return False
+        return True
+
+    def exec_cmd(self, cmd):
+        """ Wrapper for executing a shell command.
+            - Args :
+                - cmd : command to execute.
+            - Returns :
+                - True if cmd returns 0, False otherwise.
+        """
+        proc = None
+        try:
+            proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
+        except Exception, err:
+            print self.err_str + str(err)
+            return False
+
+        return True if proc.wait() == 0 else False
+
+    def config_loop_host(self, config_file):
+        """ Configure host for loop target :-
+            1. Load Loop module(s).
+            2. Load config from json file.
+            3. Create Controller list.
+            - Args :
+                  - None
+            -Returns :
+                  - True on success, False on failure.
+        """
+        ret = self.exec_cmd("modprobe nvme-loop")
+        if ret is False:
+            print self.err_str + "failed to load nvme-loop."
+            return False
+        try:
+            config_file_handle = open(config_file, "r")
+            config = json.loads(config_file_handle.read())
+            config_file_handle.close()
+        except Exception, err:
+            print self.err_str + str(err)
+            return False
+
+        for sscfg in config['subsystems']:
+            ctrl = NVMeOFHostController(sscfg['nqn'], "loop")
+            ret = ctrl.init_ctrl()
+            if ret is False:
+                print self.err_str + "failed init_ctrl() " + \
+                      str(ctrl.ctrl_dev) + "."
+                return False
+            self.ctrl_list.append(ctrl)
+        return True
+
+    def run_ios_parallel(self, iocfg):
+        """ Run parallel IOs on all host controller(s) and
+            wait for completion.
+            - Args :
+                  - iocfg : io configuration.
+            - Returns :
+                  - None.
+        """
+        print "Starting IOs parallelly on all controllers ..."
+        for ctrl in self.ctrl_list:
+            if ctrl.run_io_all_ns(iocfg) is False:
+                return False
+
+        print "Waiting for all threads to finish the IOs..."
+        for ctrl in self.ctrl_list:
+            ctrl.wait_io_all_ns()
+
+        return True
+
+    def run_ios_seq(self, iocfg):
+        """ Run IOs on all host controllers one by one.
+            - Args :
+                  - None.
+            - Returns :
+                  - None.
+        """
+        print "Starting IOs seq ..."
+        ret = None
+        for ctrl in self.ctrl_list:
+            ret = ctrl.run_io_seq(iocfg)
+            if ret is False:
+                break
+
+        return ret
+
+    def run_ios_random(self, iocfg):
+        """ Select a controller from the list of controllers
+            randomly and run IOs. Exhaust entire list.
+            - Args :
+                  - None.
+            - Returns :
+                  - None.
+        """
+        ctrl_list = range(0, len(self.ctrl_list))
+
+        ret = True
+        for i in range(0, len(self.ctrl_list)):
+            random.shuffle(ctrl_list)
+            ctrl_id = ctrl_list.pop()
+            ctrl = self.ctrl_list[ctrl_id]
+            if ctrl.run_io_random(iocfg) is False:
+                ret = False
+                break
+
+        return ret
+
+    def smart_log(self):
+        """ Execute smart log.
+            - Args :
+                  - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        ret = True
+        for ctrl in self.ctrl_list:
+            if ctrl.smart_log() is False:
+                ret = False
+                break
+
+        return ret
+
+    def id_ctrl(self):
+        """ Execute id-ctrl on all the controllers(s).
+            - Args :
+                  - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        ret = True
+        for ctrl in self.ctrl_list:
+            if ctrl.id_ctrl() is False:
+                ret = False
+                break
+
+        return ret
+
+    def id_ns(self):
+        """ Execute id-ns on controllers(s) and all its namespace(s).
+            - Args :
+                  - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        ret = True
+        for ctrl in self.ctrl_list:
+            if ctrl.id_ns() is False:
+                ret = False
+                break
+
+        return ret
+
+    def mkfs_seq(self):
+        """ Run mkfs, mount fs, run IOs.
+            - Args :
+                  - None.
+            - Returns :
+                  - None.
+        """
+        ret = True
+        for ctrl in self.ctrl_list:
+            if ctrl.run_mkfs_seq() is False:
+                ret = False
+                break
+
+        return ret
+
+    def config_host(self, config_file="loop.json"):
+        """ Configure Host based on the target transport.
+            - Args :
+                  - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        ret = False
+        if self.target_type == "loop":
+            print "Configuring loop host"
+            ret = self.config_loop_host(config_file)
+        else:
+            print self.err_str + "only loop target type is supported."
+        return ret
+
+    def del_host(self):
+        """ Delete all the Host Controllers.
+            - Args :
+                  - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        ret = True
+        for subsys in self.ctrl_list:
+            if subsys.del_ctrl() is False:
+                ret = False
+        return ret
diff --git a/tools/testing/selftests/nvmftests/host_ns.py b/tools/testing/selftests/nvmftests/host_ns.py
new file mode 100644
index 0000000..ef475e7
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/host_ns.py
@@ -0,0 +1,285 @@
+
+# Copyright (c) 2016-2017 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+""" Represents NVMe Over Fabric Host Namespace.
+"""
+
+import os
+import Queue
+import threading
+import subprocess
+
+
+class NVMeOFNSThread(threading.Thread):
+    """
+    Represents a worker thread.
+
+        - Attributes :
+            - target : thread Target.
+            - workq : workqueue shared between producer and worker thread.
+    """
+    def __init__(self, group=None, target=None, name=None,
+                 args=[None], kwargs=None, verbose=None):
+        """Default Thread Constructor."""
+        super(NVMeOFNSThread, self).__init__()
+        self.target = target
+        self.name = name
+        self.workq = args[0]
+
+    def run(self):
+        """ Default Thread Function """
+        while True:
+            if not self.workq.empty():
+                item = self.workq.get()
+                if item is None:
+                    break
+                ret = item['THREAD'](item)
+                self.workq.task_done()
+                # On Error just shutdown the worker thread.
+                # Need to implement qid based work queue implementation.
+                if ret is False:
+                    self.workq.put(None)
+
+
+class NVMeOFHostNamespace(object):
+    """
+    Represents a host namespace.
+
+        - Attributes :
+            - ns_dev : block device associated with this namespace.
+            - lbaf_cnt : logical block format count.
+            - ns_dict : namespace attributes.
+            - lbaf : dictionary for logical block format.
+            - ms : dictionary to store medata size information.
+            - lbads : dictionary to store LBA Data Size.
+            - rp : dictionary to store relative performance.
+            - mount_path : mounted directory.
+            - worker_thread : handle for io worker thread.
+            - workq : workqueue shared between producer and worker thread.
+    """
+    def __init__(self, ns_dev):
+        self.ns_dev = ns_dev
+        self.lbaf_cnt = 0
+        self.ns_dict = {}
+        self.lbaf = {}
+        self.ms = {}
+        self.lbads = {}
+        self.rp = {}
+        self.mount_path = None
+        self.worker_thread = None
+        self.workq = Queue.Queue()
+
+        self.err_str = "ERROR : " + self.__class__.__name__ + " : "
+
+    def exec_cmd(self, cmd):
+        """ Wrapper for executing a shell command.
+            - Args :
+                - cmd : command to execute.
+            - Returns :
+                - True if cmd returns 0, False otherwise.
+        """
+        proc = None
+        try:
+            proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
+        except Exception, err:
+            print self.err_str + str(err)
+            return False
+
+        return True if proc.wait() == 0 else False
+
+    def init_ns(self):
+        """ Initialize nameapce, create worker thread and
+            build controller attributes.
+            - Args :
+                  - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        if self.id_ns() is False:
+            return False
+
+        # Create IO worker thread for this ns
+        self.worker_thread = NVMeOFNSThread(args=[self.workq])
+        self.worker_thread.setDaemon(True)
+        self.worker_thread.start()
+        return True
+
+    def id_ns(self):
+        """ Wrapper for id-ns command.
+            - Args :
+                  - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        id_ctrl_cmd = "nvme id-ns " + self.ns_dev
+        proc = subprocess.Popen(id_ctrl_cmd,
+                                shell=True,
+                                stdout=subprocess.PIPE)
+        ret = proc.wait()
+        if ret != 0:
+            print self.err_str + "nvme id-ctrl failed"
+            return False
+
+        i = 0
+        for line in proc.stdout:
+            if line.startswith('subnqn') or \
+               line.startswith('NVME Identify Nameapce'):
+                continue
+            if line.startswith('lbaf'):
+                self.lbaf[i] = line.split(':')[0].split('  ')[1]
+                self.ms[i] = line.split(':')[2].split('  ')[0]
+                self.lbads[i] = line.split(':')[3].split(' ')[0]
+                self.rp[i] = line.split(':')[4].split(' ')[0]
+                i += 1
+                continue
+
+            key, value = line.split(':')
+            self.ns_dict[key.strip()] = value.strip()
+        return True
+
+    def get_value(self, k):
+        """ Access nvme namespace attribute's value based on the key.
+            - Args :
+                  - k : represents namespace's attribute.
+            - Returns :
+                  - None.
+        """
+        return self.ns_dict[k]
+
+    def mkfs_seq(self):
+        """ Format namespace with file system and mount on the unique
+            namespace directory.
+            - Args :
+                  - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        cmd = "mkfs.ext4 " + self.ns_dev
+        print "Running " + cmd + "."
+        ret = self.exec_cmd(cmd)
+        if ret is False:
+            print self.err_str + "mkfs.ext4 failed " + self.ns_dev + "."
+            return False
+
+        self.mount_path = "/mnt/" + self.ns_dev.split("/")[2]
+        if os.path.exists(self.mount_path) is True:
+            print self.err_str + "path " + self.mount_path + " exists."
+            return False
+
+        try:
+            os.makedirs(self.mount_path)
+        except Exception, err:
+            print self.err_str + str(err)
+            return False
+
+        ret = self.exec_cmd("mount " + self.ns_dev + " " + self.mount_path)
+        if ret is False:
+            print self.err_str + "mount failed " + self.ns_dev + "."
+            return False
+
+        print "mount " + self.ns_dev + " " + self.mount_path + "successful."
+        return True
+
+    def is_mounted(self):
+        """ Check if namespace is mounted.
+            - Args :
+                  - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        ret = False
+        if self.mount_path is not None:
+            ret = self.exec_cmd("mountpoint -q " + self.mount_path)
+
+        return ret
+
+    def unmount_cleanup(self):
+        """ Unmount the namespace and cleanup the mount path.
+            - Args :
+                  - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        if self.is_mounted() is False:
+            print self.err_str + self.ns_dev + " is not mounted."
+            return False
+
+        cmd = "umount " + self.mount_path
+        ret = self.exec_cmd(cmd)
+        if ret is False:
+            print self.err_str + "umount failed " + self.ns_dev + "."
+            return False
+
+        print "##### UNMOUNT SUCCESS " + cmd + "."
+        try:
+            os.rmdir(self.mount_path)
+        except Exception, err:
+            print self.err_str + str(err)
+            ret = False
+
+        return ret
+
+    def start_io(self, iocfg):
+        """ Add new work item to workqueue. Triggers wake up in worker thread.
+            - Args :
+                  - IO Configuration passed to worker thread.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        if iocfg['IODIR'] == "read":
+            iocfg['IF'] = self.ns_dev
+        elif iocfg['IODIR'] == "write":
+            iocfg['OF'] = self.ns_dev
+        else:
+            print self.err_str + "io config " + iocfg + " not supported."
+            return False
+
+        if self.worker_thread.is_alive():
+            self.workq.put(iocfg)
+        else:
+            print self.err_str + "worker thread is not running."
+            return False
+
+        return True
+
+    def wait_io(self):
+        """ Wait until all the items are completed from workqueue.
+            - Args :
+                  - None.
+            - Returns :
+                  - None.
+        """
+        print "Checking for worker thread " + self.ns_dev + "."
+        if self.worker_thread.is_alive():
+            print "Waiting for thread completion " + self.ns_dev + "."
+            self.workq.join()
+        print "# WAIT COMPLETE " + self.ns_dev + "."
+
+    def del_ns(self):
+        """ Namespace clanup.
+            - Args :
+                  - None.
+            - Returns :
+                  - None.
+        """
+        print "##### Deleting Namespace "
+        self.workq.put(None)
+        if self.is_mounted() is True:
+            self.unmount_cleanup()
diff --git a/tools/testing/selftests/nvmftests/host_subsystem.py b/tools/testing/selftests/nvmftests/host_subsystem.py
new file mode 100644
index 0000000..4c0d3e9
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/host_subsystem.py
@@ -0,0 +1,420 @@
+# Copyright (c) 2016-2017 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+""" Represents NVMe Over Fabric Host Controller.
+"""
+
+import re
+import os
+import stat
+import time
+import random
+import string
+import subprocess
+from natsort import natsorted
+
+from host_ns import NVMeOFHostNamespace
+
+
+class NVMeOFHostController(object):
+    """
+    Represents a host controller.
+
+        - Attributes :
+            - nqn : ctrltem nqn.
+            - ctrl_dev : controller device.
+            - ctrl_dict : controller attributes.
+            - ns_list : list of namespaces.
+            - ns_dev_list : namespace device list.
+            - transport : transport type.
+    """
+    def __init__(self, nqn, transport):
+        self.nqn = nqn
+        self.ctrl_dev = None
+        self.ctrl_dict = {}
+        self.ns_list = []
+        self.ns_dev_list = []
+        self.transport = transport
+        self.err_str = "ERROR : " + self.__class__.__name__ + " : "
+
+    def exec_cmd(self, cmd):
+        """ Wrapper for executing a shell command.
+            - Args :
+                - cmd : command to execute.
+            - Returns :
+                - True if cmd returns 0, False otherwise.
+        """
+        proc = None
+        try:
+            proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
+        except Exception, err:
+            print self.err_str + str(err)
+            return False
+
+        return True if proc.wait() == 0 else False
+
+    def run_io_all_ns(self, iocfg):
+        """ Start IOs on all the namespaces of this controller parallelly.
+            - Args :
+                  - iocfg : io configuration.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        ret = True
+        for host_ns in self.ns_list:
+            if host_ns.start_io(iocfg) is False:
+                print "start IO " + host_ns.ns_dev + " failed."
+                ret = False
+                break
+            print "start IO " + host_ns.ns_dev + " SUCCESS."
+
+        return ret
+
+    def wait_io_all_ns(self):
+        """ Wait until workqueue is empty.
+            - Args :
+                  - None.
+            - Returns :
+                  - None.
+        """
+        for host_ns in self.ns_list:
+            host_ns.wait_io()
+
+    def run_io_seq(self, iocfg):
+        """ Issue IOs to each namespace and wait, repeat for all the
+            namespaces of this controller.
+            - Args :
+                  - iocfg : io configuration.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        ret = True
+        for host_ns in self.ns_list:
+            if host_ns.start_io(iocfg) is False:
+                print "start IO " + host_ns.ns_dev + " failed."
+                ret = False
+            host_ns.wait_io()
+        return ret
+
+    def run_mkfs_seq(self):
+        """ Run mkfs, mount fs.
+            - Args :
+                  - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        ret = True
+        for host_ns in self.ns_list:
+            if host_ns.mkfs_seq() is False:
+                ret = False
+                break
+
+        return ret
+
+    def run_io_random(self, iocfg):
+        """ Select the namespce randomely and wait for the IOs completion,
+            repeat this for all the namespaces.
+            - Args :
+                  - iocfg : io configuration.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        num_list = range(0, len(self.ns_list))
+
+        for i in range(0, len(self.ns_list)):
+            random.shuffle(num_list)
+            ns_id = num_list.pop()
+
+            host_ns = self.ns_list[ns_id]
+            if host_ns.start_io(iocfg) is False:
+                return False
+            host_ns.wait_io()
+
+        return True
+
+    def exec_smart_log(self, nsid="0xFFFFFFFF"):
+        """ Wrapper for nvme smart-log command.
+            - Args :
+                  - None.
+            - Returns:
+                  - True on success, False on failure.
+        """
+        smart_log_cmd = "nvme smart-log " + self.ctrl_dev + " -n " + str(nsid)
+        print smart_log_cmd
+        proc = subprocess.Popen(smart_log_cmd,
+                                shell=True,
+                                stdout=subprocess.PIPE)
+        err = proc.wait()
+        if err != 0:
+            print self.err_str + "nvme smart log failed"
+            return False
+
+        for line in proc.stdout:
+            if "data_units_read" in line:
+                data_units_read = \
+                    string.replace(line.split(":")[1].strip(), ",", "")
+            if "data_units_written" in line:
+                data_units_written = \
+                    string.replace(line.split(":")[1].strip(), ",", "")
+            if "host_read_commands" in line:
+                host_read_commands = \
+                    string.replace(line.split(":")[1].strip(), ",", "")
+            if "host_write_commands" in line:
+                host_write_commands = \
+                    string.replace(line.split(":")[1].strip(), ",", "")
+
+        print "data_units_read " + data_units_read
+        print "data_units_written " + data_units_written
+        print "host_read_commands " + host_read_commands
+        print "host_write_commands " + host_write_commands
+        return True
+
+    def smart_log(self):
+        """ Execute smart-log command.
+            - Args :
+                  - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        self.exec_smart_log()
+        i = 1
+        for namespace in self.ns_list:
+            if self.exec_smart_log(i) is False:
+                return False
+            i += 1
+        return True
+
+    def validate_sysfs_host_ctrl_ns(self, ctrl):
+        """ Validate sysfs entries for the host controller and namespace(s)
+            - Args :
+                  - ctrl : controller id.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        # Validate ctrl in the sysfs
+        cmd = "basename $(dirname $(grep -ls " + self.nqn + \
+              " /sys/class/nvme-fabrics/ctl/*/subsysnqn))"
+        proc = subprocess.Popen(cmd,
+                                shell=True,
+                                stdout=subprocess.PIPE)
+        for line in proc.stdout:
+            line = line.strip('\n')
+            if line != ctrl.split("/")[2]:
+                print self.err_str + "host ctrl " + ctrl + " not present."
+                return False
+        dir_list = os.listdir("/sys/class/nvme-fabrics/ctl/" +
+                              ctrl.split("/")[2] + "/")
+
+        pat = re.compile("^" + ctrl.split("/")[2] + "+n[0-9]+$")
+        for line in dir_list:
+            line = line.strip('\n')
+            if pat.match(line):
+                if not "/dev/" + line in self.ns_dev_list:
+                    print self.err_str + "ns " + line + " not found in sysfs."
+                    return False
+
+        print "sysfs entries for ctrl and ns created successfully."
+        return True
+
+    def build_ctrl_ns_list(self):
+        """ Generate next available controller and namespace id on the fly.
+            Build the ns list for this controller.
+            - Args :
+                  - None.
+            - Returns :
+                  - ctrl and ns list on success, None on failure.
+        """
+        ctrl = "XXX"
+        ns_list = []
+        try:
+            dev_list = os.listdir("/dev/")
+        except Exception, err:
+            print self.err_str + str(err)
+            return None, None
+        dev_list = natsorted(dev_list, key=lambda y: y.lower())
+        # we assume that atleast one namespace is created on target
+        # find ctrl
+        pat = re.compile("^nvme[0-9]+$")
+        for line in dev_list:
+            line = line.strip('\n')
+            if pat.match(line):
+                ctrl = line
+
+        if ctrl == "XXX":
+            print self.err_str + "controller '/dev/nvme*' not found."
+            return None, None
+
+        # find namespace(s) associated with ctrl
+        try:
+            dir_list = os.listdir("/dev/")
+        except Exception, err:
+            print self.err_str + str(err)
+            return None, None
+        pat = re.compile("^" + ctrl + "+n[0-9]+$")
+        for line in dir_list:
+            line = line.strip('\n')
+            if pat.match(line):
+                ns_list.append("/dev/" + line)
+
+        if len(ns_list) == 0:
+            print self.err_str + "host ns not found for ctrl " + ctrl + "."
+            return None, None
+
+        ctrl = "/dev/" + ctrl
+        return ctrl, ns_list
+
+    def get_value(self, k):
+        """ Access nvme controller attribute's value based on the kay.
+            - Args :
+                  - k : represents controller's attribute.
+            - Returns :
+                  - value of controller's attribute.
+        """
+        return self.ctrl_dict[k]
+
+    def init_ctrl_ns(self):
+        """ Initialize and build namespace list and validate sysfs entries.
+            - Args :
+                  - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        for ns_dev in self.ns_dev_list:
+            if not stat.S_ISBLK(os.stat(ns_dev).st_mode):
+                print self.err_str + "expected block dev " + ns_dev + "."
+                return False
+
+            print "Found NS " + ns_dev
+            host_ns = NVMeOFHostNamespace(ns_dev)
+            host_ns.init_ns()
+            self.ns_list.append(host_ns)
+        time.sleep(1)
+        ret = self.validate_sysfs_host_ctrl_ns(self.ctrl_dev)
+        print "Host sysfs entries are validated " + str(ret)
+        return ret
+
+    def init_ctrl(self):
+        """ Initialize controller and build controller attributes.
+            - Args :
+                  - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        # initialize nqn and transport
+        cmd = "echo  \"transport=" + self.transport + ",nqn=" + \
+              self.nqn + "\" > /dev/nvme-fabrics"
+        print "CMD :- " + cmd
+        if self.exec_cmd(cmd) is False:
+            return False
+        time.sleep(1)
+        self.ctrl_dev, self.ns_dev_list = self.build_ctrl_ns_list()
+
+        if not stat.S_ISCHR(os.stat(self.ctrl_dev).st_mode):
+            print self.err_str + "failed to find char device for host ctrl."
+            return False
+
+        ret = self.id_ctrl()
+        if ret is False:
+            return False
+
+        return self.init_ctrl_ns()
+
+    def id_ctrl(self):
+        """ Wrapper for executing id-ctrl command.
+            - Args :
+                  - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        id_ctrl_cmd = "nvme id-ctrl " + self.ctrl_dev
+        proc = subprocess.Popen(id_ctrl_cmd,
+                                shell=True,
+                                stdout=subprocess.PIPE)
+        err = proc.wait()
+        if err != 0:
+            print self.err_str + "nvme id-ctrl failed"
+            return False
+
+        for line in proc.stdout:
+            if line.startswith('subnqn') or \
+               line.startswith('NVME Identify Controller'):
+                continue
+            if line.startswith("ps ") or line.startswith("          rwt"):
+                continue
+            key, val = line.split(':')
+            self.ctrl_dict[key.strip()] = val.strip()
+
+        print self.ctrl_dict
+        print "--------------------------------------------------"
+        return True
+
+    def id_ns(self):
+        """ Wrapper for executing id-ns command on all namespaces of this
+            controller.
+            - Args :
+                  - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        for host_ns in self.ns_list:
+            host_ns.id_ns()
+            print "--------------------------------------------------"
+        return True
+
+    def generate_next_ns_id(self):
+        """ Return next namespace id.
+            - Args :
+                  - None.
+            - Returns :
+                  - next namespace id.
+        """
+        return len(self.ns_list) + 1
+
+    def del_ctrl(self):
+        """ Delete subsystem and associated namespace(s).
+            - Args :
+                  - None.
+            - Returns :
+                 - True on success, False on failure.
+        """
+        print "Deleting subsystem " + self.nqn
+        for host_ns in self.ns_list:
+            host_ns.del_ns()
+        cmd = "dirname $(grep -ls " + self.nqn + \
+              " /sys/class/nvme-fabrics/ctl/*/subsysnqn)"
+        try:
+            proc = subprocess.Popen(cmd,
+                                    shell=True,
+                                    stdout=subprocess.PIPE)
+            for line in proc.stdout:
+                line = line.strip('\n')
+                if not os.path.isdir(line):
+                    print self.err_str + "host ctrl dir " + self.nqn + \
+                          " not present."
+                    return False
+                ret = self.exec_cmd("echo > " + line + "/delete_controller")
+                if ret is False:
+                    print self.err_str + "failed to delete ctrl " + \
+                          self.nqn + "."
+                    return False
+        except Exception, err:
+            print self.err_str + str(err)
+            return False
+
+        return True
diff --git a/tools/testing/selftests/nvmftests/loop.json b/tools/testing/selftests/nvmftests/loop.json
new file mode 100644
index 0000000..4aecfc3
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/loop.json
@@ -0,0 +1,248 @@
+{
+  "hosts": [
+    {
+      "nqn": "hostnqn"
+    }
+  ],
+  "ports": [
+    {
+      "addr": {
+        "adrfam": "",
+        "traddr": "",
+        "treq": "not specified",
+        "trsvcid": "",
+        "trtype": "loop"
+      },
+      "portid": 1,
+      "referrals": [],
+      "subsystems": [
+        "testnqn1",
+        "testnqn2",
+        "testnqn3",
+        "testnqn4",
+        "testnqn5",
+        "testnqn6",
+        "testnqn7",
+        "testnqn8"
+      ]
+    }
+  ],
+  "subsystems": [
+    {
+      "allowed_hosts": [
+        "hostnqn"
+      ],
+      "attr": {
+        "allow_any_host": "1"
+      },
+      "namespaces": [
+        {
+          "device": {
+            "nguid": "ef90689c-6c46-d44c-89c1-4067801309a8",
+            "path": "/dev/loop0"
+          },
+          "enable": 1,
+          "nsid": 1
+        },
+        {
+          "device": {
+            "nguid": "6c46-d44c-89c1-4067801309a8",
+            "path": "/dev/loop1"
+          },
+          "enable": 1,
+          "nsid": 2
+        }
+      ],
+      "nqn": "testnqn1"
+    },
+    {
+      "allowed_hosts": [
+        "hostnqn"
+      ],
+      "attr": {
+        "allow_any_host": "1"
+      },
+      "namespaces": [
+        {
+          "device": {
+            "nguid": "d44c-89c1-4067801309a8",
+            "path": "/dev/loop2"
+          },
+          "enable": 1,
+          "nsid": 1
+        },
+        {
+          "device": {
+            "nguid": "89c1-4067801309a8",
+            "path": "/dev/loop3"
+          },
+          "enable": 1,
+          "nsid": 2
+        }
+      ],
+      "nqn": "testnqn2"
+    },
+    {
+      "allowed_hosts": [
+        "hostnqn"
+      ],
+      "attr": {
+        "allow_any_host": "1"
+      },
+      "namespaces": [
+        {
+          "device": {
+            "nguid": "89c1-4067801309a8",
+            "path": "/dev/loop4"
+          },
+          "enable": 1,
+          "nsid": 1
+        },
+        {
+          "device": {
+            "nguid": "067801309a8",
+            "path": "/dev/loop5"
+          },
+          "enable": 1,
+          "nsid": 2
+        }
+      ],
+      "nqn": "testnqn3"
+    },
+    {
+      "allowed_hosts": [
+        "hostnqn"
+      ],
+      "attr": {
+        "allow_any_host": "1"
+      },
+      "namespaces": [
+        {
+          "device": {
+            "nguid": "89c1-4067801309a8",
+            "path": "/dev/loop6"
+          },
+          "enable": 1,
+          "nsid": 1
+        },
+        {
+          "device": {
+            "nguid": "067801309a8",
+            "path": "/dev/loop7"
+          },
+          "enable": 1,
+          "nsid": 2
+        }
+      ],
+      "nqn": "testnqn4"
+    },
+    {
+      "allowed_hosts": [
+        "hostnqn"
+      ],
+      "attr": {
+        "allow_any_host": "1"
+      },
+      "namespaces": [
+        {
+          "device": {
+            "nguid": "89c1-4067801309a8",
+            "path": "/dev/loop8"
+          },
+          "enable": 1,
+          "nsid": 1
+        },
+        {
+          "device": {
+            "nguid": "067801309a8",
+            "path": "/dev/loop9"
+          },
+          "enable": 1,
+          "nsid": 2
+        }
+      ],
+      "nqn": "testnqn5"
+    },
+    {
+      "allowed_hosts": [
+        "hostnqn"
+      ],
+      "attr": {
+        "allow_any_host": "1"
+      },
+      "namespaces": [
+        {
+          "device": {
+            "nguid": "89c1-4067801309a8",
+            "path": "/dev/loop0"
+          },
+          "enable": 1,
+          "nsid": 1
+        },
+        {
+          "device": {
+            "nguid": "067801309a8",
+            "path": "/dev/loop1"
+          },
+          "enable": 1,
+          "nsid": 2
+        }
+      ],
+      "nqn": "testnqn6"
+    },
+    {
+      "allowed_hosts": [
+        "hostnqn"
+      ],
+      "attr": {
+        "allow_any_host": "1"
+      },
+      "namespaces": [
+        {
+          "device": {
+            "nguid": "89c1-4067801309a8",
+            "path": "/dev/loop2"
+          },
+          "enable": 1,
+          "nsid": 1
+        },
+        {
+          "device": {
+            "nguid": "067801309a8",
+            "path": "/dev/loop3"
+          },
+          "enable": 1,
+          "nsid": 2
+        }
+      ],
+      "nqn": "testnqn7"
+    },
+    {
+      "allowed_hosts": [
+        "hostnqn"
+      ],
+      "attr": {
+        "allow_any_host": "1"
+      },
+      "namespaces": [
+        {
+          "device": {
+            "nguid": "89c1-4067801309a8",
+            "path": "/dev/loop4"
+          },
+          "enable": 1,
+          "nsid": 1
+        },
+        {
+          "device": {
+            "nguid": "067801309a8",
+            "path": "/dev/loop5"
+          },
+          "enable": 1,
+          "nsid": 2
+        }
+      ],
+      "nqn": "testnqn8"
+    }
+  ]
+}
diff --git a/tools/testing/selftests/nvmftests/loopback.py b/tools/testing/selftests/nvmftests/loopback.py
new file mode 100644
index 0000000..5716974
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/loopback.py
@@ -0,0 +1,116 @@
+# Copyright (c) 2016-2017 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+""" Represents Loopback driver block devices.
+"""
+
+import os
+import time
+import subprocess
+
+
+class Loopback:
+    """
+    Represents Loopback driver block devices.
+
+        - Attributes :
+            - path : path to create backend files.
+            - dev_size : device file size.
+            - block size : block size to create file.
+            - max_loop : max loop devices.
+            - dev_list : list of loop back files.
+    """
+    def __init__(self, path, dev_size, block_size, max_loop):
+        """ Constructor for Loopback.
+            - Args :
+                  path : directory path where backend file is stired.
+                  dev_size : device size.
+                  block_size : block size to write backend file.
+                  max_loop : number of loop back devices.
+        """
+        self.path = path
+        self.dev_size = dev_size
+        self.block_size = block_size
+        self.max_loop = max_loop
+        self.dev_list = []
+
+        self.exec_cmd("losetup -D")
+        self.exec_cmd("modprobe -r loop")
+        self.exec_cmd("modprobe loop max_loop=" + str(max_loop))
+
+    def exec_cmd(self, cmd):
+        """ Wrapper for executing a shell command.
+            - Args :
+                - cmd : command to execute.
+            - Returns :
+                - Value of the command.
+        """
+        proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
+        return proc.wait()
+
+    def init_loopback(self):
+        """ Create and initialize Loopback.
+            - Args :
+                - None.
+            - Returns :
+                - True on success, False on failure.
+        """
+        count = self.dev_size / self.block_size
+
+        for i in range(0, self.max_loop):
+            dev = self.path + "/test" + str(i)
+            cmd = "dd if=/dev/zero of=" + dev + \
+                " count=" + str(count) + " bs=" + str(self.block_size)
+            print cmd
+            ret = self.exec_cmd(cmd)
+            if ret != 0:
+                print "ERROR : file creation " + self.dev_list[i]
+                self.del_loopback()
+                return False
+            cmd = "losetup /dev/loop" + str(i) + " " + dev
+            print cmd
+            if self.exec_cmd(cmd) != 0:
+                print "ERROR : " + cmd + " failed."
+                return False
+
+            self.dev_list.append(dev)
+        return True
+
+    def del_loopback(self):
+        """ Delete this Loopback.
+            - Args :
+                - None.
+            -Returns :
+                - True on success, False on failure.
+        """
+        ret = True
+        loop_cnt = 0
+        for i in self.dev_list:
+            cmd = "losetup -d /dev/loop" + str(loop_cnt)
+            print cmd
+            self.exec_cmd(cmd)
+            os.remove(i)
+            loop_cnt += 1
+
+        time.sleep(1)
+        if self.exec_cmd("modprobe -r loop") != 0:
+            print "ERROR : failed to remove loop module."
+            ret = False
+
+        return ret
diff --git a/tools/testing/selftests/nvmftests/nvmf_test.py b/tools/testing/selftests/nvmftests/nvmf_test.py
new file mode 100644
index 0000000..bcafcb1
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/nvmf_test.py
@@ -0,0 +1,85 @@
+# Copyright (c) 2016-2017 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+""" Base Class for all NVMeOF testcases.
+"""
+
+import os
+import sys
+import subprocess
+from nvmf_test_logger import NVMeOFLogger
+
+
+def __dd_worker__(iocfg):
+    """ dd worker thread function.
+        - Args :
+                - iocfg : io configuration.
+        - Returns :
+                - None.
+    """
+    cmd = "dd if=" + iocfg['IF'] + " of=" + iocfg['OF'] + \
+        " bs=" + iocfg['BS'] + " count=" + iocfg['COUNT']
+    print " Running IOs now CMD :------- " + cmd
+    proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
+    ret = True
+    if proc.wait() != iocfg['RC']:
+        print "ERROR : Failed to execute " + cmd + "."
+        ret = False
+
+    return ret
+
+
+class NVMeOFTest(object):
+
+    def __init__(self):
+        self.data_size = 128 * 1024 * 1024
+        self.block_size = 4096
+        self.nr_devices = 10
+        self.mount_path = "/mnt/nvme0n1/"
+        self.test_log_dir = "XXX"
+        self.log_dir = "./logs/" + self.__class__.__name__ + "/"
+
+        self.dd_read = {"IODIR": "read",
+                        "THREAD": __dd_worker__,
+                        "IF": None,
+                        "OF": "/dev/null",
+                        "BS": "4K",
+                        "COUNT": str(self.data_size / self.block_size),
+                        "RC": 0}
+
+        self.dd_write = {"IODIR": "write",
+                         "THREAD": __dd_worker__,
+                         "IF": "/dev/zero",
+                         "OF": None,
+                         "BS": "4K",
+                         "COUNT": str(self.data_size / self.block_size),
+                         "RC": 0}
+
+    def setup_log_dir(self, test_name):
+        """ Set up the log directory for a testcase
+            Args:
+              - test_name : name of the testcase.
+            Returns:
+              - None
+        """
+        self.test_log_dir = self.log_dir + "/" + test_name
+        if not os.path.exists(self.test_log_dir):
+            os.makedirs(self.test_log_dir)
+        sys.stdout = NVMeOFLogger(self.test_log_dir + "/" + "stdout.log")
+        sys.stderr = NVMeOFLogger(self.test_log_dir + "/" + "stderr.log")
diff --git a/tools/testing/selftests/nvmftests/nvmf_test_logger.py b/tools/testing/selftests/nvmftests/nvmf_test_logger.py
new file mode 100644
index 0000000..9ca7fc6
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/nvmf_test_logger.py
@@ -0,0 +1,50 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+"""Logger for NVMe Test Framwwork.
+"""
+import sys
+
+
+class NVMeOFLogger(object):
+    """ Represents Logger for NVMe Testframework.  """
+    def __init__(self, log_file_path):
+        """ Logger setup
+            - Args:
+                log_file_path : path to store the log.
+        """
+        self.terminal = sys.stdout
+        self.log = open(log_file_path, "w")
+
+    def write(self, log_message):
+        """ Logger setup
+            - Args:
+                log_message: string to write in the log file.
+            - Returns:
+                None
+        """
+        self.terminal.write(log_message)
+        self.log.write(log_message)
+
+    def flush(self):
+        """ This flush method is needed for python 3 compatibility.
+            this handles the flush command by doing nothing.
+            you might want to specify some extra behavior here.
+        """
+        pass
diff --git a/tools/testing/selftests/nvmftests/port.py b/tools/testing/selftests/nvmftests/port.py
new file mode 100644
index 0000000..67ef7fc
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/port.py
@@ -0,0 +1,139 @@
+# Copyright (c) 2016-2017 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+""" Represents NVMe Over Fabric Target Port.
+"""
+
+import os
+import shutil
+import subprocess
+
+
+class NVMeOFTargetPort(object):
+    """
+    Represents a target port.
+
+        - Attributes :
+            - cfgfs : configfs mountpoint.
+            - port_id : port identification number.
+            - port_conf : dictionary to hold the port attributes.
+    """
+    def __init__(self, cfgfs, port_id, **port_conf):
+        """ Constructor for NVMeOFTargetPort.
+            - Args :
+                  - cfgfs : configfs path.
+                  - port_id : port identifier.
+                  - port_conf : port configuration list.
+        """
+        self.cfgfs = cfgfs
+        self.port_id = port_id
+        self.port_conf = {}
+        self.port_path = self.cfgfs + "/nvmet/ports/" + port_id + "/"
+        self.port_conf['addr_treq'] = port_conf['addr_treq']
+        self.port_conf['addr_traddr'] = port_conf['addr_traddr']
+        self.port_conf['addr_trtype'] = port_conf['addr_trtype']
+        self.port_conf['addr_adrfam'] = port_conf['addr_adrfam']
+        self.port_conf['addr_trsvcid'] = port_conf['addr_trsvcid']
+        self.port_conf['referrals'] = "XXX"
+        self.port_conf['subsystems'] = port_conf['subsystems']
+        self.err_str = "ERROR : " + self.__class__.__name__ + " : "
+
+    def init_port(self):
+        """ Create and initialize port.
+            - Args :
+                - None.
+            - Returns :
+                - True on success, False on failure.
+        """
+        if self.port_conf['addr_trtype'] != "loop":
+            print self.err_str + "only loop transport type is supported."
+            return False
+
+        ret = self.exec_cmd("mkdir -p " + self.port_path)
+        if ret is False:
+            print self.err_str + "failed to create " + self.port_path + "."
+            return False
+
+        # initialize transport type
+        print "Port " + self.port_path + " created successfully."
+
+        ret = self.exec_cmd("echo -n \"" + self.port_conf['addr_trtype'] +
+                            "\" > " + self.port_path + "/addr_trtype")
+        status = "Port " + self.port_path + " initialized successfully."
+        if ret is False:
+            status = self.err_str + "trtype " + self.port_path + " failed."
+
+        print status
+        return ret
+
+    def exec_cmd(self, cmd):
+        """ Wrapper for executing a shell command.
+            - Args :
+                - cmd : command to execute.
+            - Returns :
+                - Value of the command.
+        """
+        proc = None
+        try:
+            proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
+        except Exception, err:
+            print self.err_str + str(err) + "."
+            return False
+
+        return True if proc.wait() == 0 else False
+
+    def add_subsys(self, subsys_name):
+        """ Link Subsystem to this port.
+            - Args :
+                 - subsys_name : subsstem nqn to be linked
+            - Returns :
+                  - True on success, False on failure.
+        """
+        src = self.cfgfs + "/nvmet/subsystems/" + subsys_name
+        if not os.path.exists(src):
+            print self.err_str + "subsystem '" + src + "' not present."
+            return False
+        dest = self.port_path + "/subsystems/"
+        ret = self.exec_cmd("ln -s " + src + " " + dest)
+        return ret
+
+    def del_port(self):
+        """ Delete this port.
+            - Args :
+                - None
+            -Returns :
+                  - True on success, False on failure.
+        """
+        print "Deleeting port " + self.port_id
+        subsys_symlink = self.port_path + "/subsystem/"
+        try:
+
+            if os.path.isdir(subsys_symlink):
+                shutil.rmtree(subsys_symlink, ignore_errors=True)
+                print "Unlink subsystem fromn port successfully."
+
+            if os.path.isdir(self.port_path):
+                shutil.rmtree(self.port_path, ignore_errors=True)
+
+        except Exception, err:
+            print self.err_str + str(err) + "."
+            return False
+
+        print "Removed port " + self.port_path + " successfully."
+        return True
diff --git a/tools/testing/selftests/nvmftests/target.py b/tools/testing/selftests/nvmftests/target.py
new file mode 100644
index 0000000..717764e
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/target.py
@@ -0,0 +1,209 @@
+# Copyright (c) 2016-2017 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+""" Represents NVMe Over Fabric Target.
+"""
+
+import sys
+import json
+import time
+import subprocess
+from nose.tools import assert_equal
+from port import NVMeOFTargetPort
+from target_subsystem import NVMeOFTargetSubsystem
+
+
+class NVMeOFTarget(object):
+
+    """
+    Represents a target subsystem.
+
+        - Attributes:
+            - subsys_list : list of the subsystem.
+            - port_list : list of the ports.
+            - target_type : target type for ports.
+            - cfgfs : configfs mount point.
+    """
+    def __init__(self, target_type):
+        self.subsys_list = []
+        self.port_list = []
+        self.target_type = target_type
+        self.cfgfs = "/sys/kernel/config/"
+        self.err_str = "ERROR : " + self.__class__.__name__ + " : "
+
+        assert_equal(self.load_configfs(), True)
+
+    def exec_cmd(self, cmd):
+        """ Wrapper for executing a shell command.
+            - Args :
+                - cmd : command to execute.
+            - Returns :
+                - True if cmd returns 0, False otherwise.
+        """
+        proc = None
+        try:
+            proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
+        except Exception, err:
+            print self.err_str + str(err) + "."
+            return False
+
+        return True if proc.wait() == 0 else False
+
+    def load_configfs(self):
+        """ Load configfs.
+            - Args :
+                  - None
+            -Returns :
+                  - True on success, False on failure.
+        """
+        ret = self.exec_cmd("mountpoint -q " + self.cfgfs)
+        if ret is False:
+            ret = self.exec_cmd("mount -t configfs none " + self.cfgfs)
+            if ret is False:
+                print self.err_str + "failed to mount configfs."
+                sys.exit(ret)
+            ret = self.exec_cmd("mountpoint -q " + self.cfgfs)
+            if ret is True:
+                print "Configfs mounted at " + self.cfgfs + "."
+                ret = True
+            else:
+                print self.err_str + "unable to mount configfs at " + \
+                    self.cfgfs + "."
+                ret = False
+        return ret
+
+    def config_loop_target(self, config_file):
+        """ Configure loop target :-
+            1. Create subsystem(s) and respective namespace(s).
+            2. Create port(s) and linked them to respective subsystem(s).
+            3. Create in memory configuration from JSON config file.
+            - Args :
+                  - None
+            -Returns :
+                  - True on success, False on failure.
+        """
+        ret = self.exec_cmd("modprobe nvme-loop")
+        if ret is False:
+            print self.err_str + "failed to load nvme-loop."
+            return False
+
+        try:
+            config_file_handle = open(config_file, "r")
+            config = json.loads(config_file_handle.read())
+            config_file_handle.close()
+        except Exception, err:
+            print self.err_str + str(err)
+            return False
+
+        # Subsystem
+        for sscfg in config['subsystems']:
+            # Create Subsystem
+            subsys = NVMeOFTargetSubsystem(self.cfgfs,
+                                           sscfg['nqn'],
+                                           sscfg['allowed_hosts'][0],
+                                           sscfg['attr']['allow_any_host'])
+            ret = subsys.init_subsys()
+            if ret is False:
+                # call unwind code here.
+                return False
+
+            self.subsys_list.append(subsys)
+
+            for nscfg in sscfg['namespaces']:
+                ns_attr = {}
+                ns_attr['device_nguid'] = str(nscfg['device']['nguid'])
+                ns_attr['device_path'] = str(nscfg['device']['path'])
+                ns_attr['enable'] = str(nscfg['enable'])
+                ns_attr['nsid'] = str(nscfg['nsid'])
+                ret = subsys.create_ns(**ns_attr)
+                if ret is False:
+                    # call unwind code here.
+                    return False
+
+        # Port
+        for pcfg in config['ports']:
+            port_cfg = {}
+            port_cfg['addr_treq'] = pcfg['addr']['treq']
+            port_cfg['addr_traddr'] = pcfg['addr']['traddr']
+            port_cfg['addr_trtype'] = pcfg['addr']['trtype']
+            port_cfg['addr_adrfam'] = pcfg['addr']['adrfam']
+            port_cfg['addr_trsvcid'] = pcfg['addr']['trsvcid']
+            port_cfg['portid'] = str(pcfg['portid'])
+            port_cfg['subsystems'] = pcfg['subsystems']
+
+            port = NVMeOFTargetPort(self.cfgfs, port_cfg['portid'], **port_cfg)
+            ret = port.init_port()
+            if ret is False:
+                # call unwind code here.
+                return False
+
+            self.port_list.append(port)
+
+            for subsys in port_cfg['subsystems']:
+                ret = port.add_subsys(subsys)
+                if ret is False:
+                    # call unwind code here.
+                    return False
+
+        return True
+
+    def config_target(self, config_file="loop.json"):
+        """ Wrapper for creating target configuration.
+            - Args :
+                - None
+            -Returns :
+                - None
+        """
+        ret = self.exec_cmd("modprobe nvmet")
+        if ret is False:
+            print self.err_str + "unable to load nvmet module."
+            return False
+
+        ret = False
+        if self.target_type == "loop":
+            print "Configuring loop target"
+            ret = self.config_loop_target(config_file)
+        else:
+            print self.err_str + "only loop target type is supported."
+
+        return ret
+
+    def del_target(self):
+        """ Target Cleanup.
+            - Args :
+                - None
+            -Returns :
+                - None
+        """
+        print "Cleanup is in progress..."
+
+        for port in self.port_list:
+            port.del_port()
+
+        for subsys in self.subsys_list:
+            subsys.del_subsys()
+
+        time.sleep(1)
+        print "Removing Modules :- "
+        self.exec_cmd("modprobe -r nvme_loop")
+        time.sleep(1)
+        self.exec_cmd("modprobe -r nvmet")
+        time.sleep(1)
+        self.exec_cmd("modprobe -r nvme_fabrics")
+        print "DONE."
diff --git a/tools/testing/selftests/nvmftests/target_ns.py b/tools/testing/selftests/nvmftests/target_ns.py
new file mode 100644
index 0000000..f8c0935
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/target_ns.py
@@ -0,0 +1,132 @@
+# Copyright (c) 2016-2017 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+""" Represents NVMe Over Fabric Target Namespace.
+"""
+
+import os
+import shutil
+import subprocess
+
+
+class NVMeOFTargetNamespace(object):
+    """
+    Represents a target namespace.
+
+        - Attributes :
+            - ns_attr : namespace attributes.
+            - cfgfs : configfs path
+            - nqn : subsystem nqn
+            - ns_id : namespace identifier.
+            - ns_path : namespace path in configfs path.
+            - ns_attr : namespace attributes.
+    """
+    def __init__(self, cfgfs, nqn, ns_id, **ns_attr):
+        self.ns_attr = {}
+        self.cfgfs = cfgfs
+        self.nqn = nqn
+        self.ns_id = ns_id
+        self.ns_path = (self.cfgfs + "/nvmet/subsystems/" +
+                        nqn + "/namespaces/" + str(ns_id) + "/")
+        self.ns_attr['device_nguid'] = ns_attr['device_nguid']
+        self.ns_attr['device_path'] = ns_attr['device_path']
+        self.ns_attr['enable'] = ns_attr['enable']
+        self.err_str = "ERROR : " + self.__class__.__name__ + " : "
+
+    def init_ns(self):
+        """ Create and initialize namespace.
+            - Args :
+                - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        print "####Creating ns " + self.ns_path
+        try:
+            os.makedirs(self.ns_path)
+        except Exception, err:
+            print self.err_str + str(err) + "."
+            return False
+
+        cmd = "echo -n " + self.ns_attr['device_path'] + " > " + \
+              self.ns_path + "/device_path"
+        ret = self.exec_cmd(cmd)
+        if ret is False:
+            print self.err_str + "failed to configure device path."
+            return False
+
+        if self.ns_attr['enable'] == '1':
+            ret = self.ns_enable()
+            if ret is False:
+                print self.err_str + "enable ns " + self.ns_path + " failed."
+                return False
+
+        print "NS " + self.ns_path + " enabled."
+        return True
+
+    def exec_cmd(self, cmd):
+        """ Wrapper for executing a shell command.
+            - Args :
+                - cmd : command to execute.
+            - Returns :
+                - True if cmd returns 0, False otherwise.
+        """
+        proc = None
+        try:
+            proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
+        except Exception, err:
+            print self.err_str + str(err) + "."
+            return False
+
+        return True if proc.wait() == 0 else False
+
+    def ns_disable(self):
+        """ Disable Namespace.
+            - Args :
+                - None.
+            - Returns :
+                - True on success, False on failure.
+        """
+        self.ns_attr['enable'] = "0"
+        return self.exec_cmd("echo 0 > " + self.ns_path + "/enable")
+
+    def ns_enable(self):
+        """ Enable Namespace.
+            - Args :
+                - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        self.ns_attr['enable'] = "1"
+        return self.exec_cmd("echo 1 > " + self.ns_path + "/enable")
+
+    def del_ns(self):
+        """ Delete This Namespace.
+            - Args :
+                - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        print "Removing NS " + self.ns_path
+        ret = os.path.exists(self.ns_path)
+        if ret is True:
+            # TODO : improve cleanup funcitonality.
+            shutil.rmtree(self.ns_path, ignore_errors=True)
+        else:
+            print self.err_str + "path " + self.ns_path + " doesn't exists."
+        return ret
diff --git a/tools/testing/selftests/nvmftests/target_subsystem.py b/tools/testing/selftests/nvmftests/target_subsystem.py
new file mode 100644
index 0000000..0d5d6d5
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/target_subsystem.py
@@ -0,0 +1,148 @@
+# Copyright (c) 2016-2017 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+""" Represents NVMe Over Fabric Target Subsystem.
+"""
+
+import os
+import shutil
+import subprocess
+
+from target_ns import NVMeOFTargetNamespace
+
+
+class NVMeOFTargetSubsystem(object):
+    """
+    Represents a target controller.
+
+        - Attributes :
+            - ns_list : list of namespaces.
+            - cfgfs : configfs path.
+            - nqn : subsystem nqn.
+            - subsys_path : subsystem path in configfs.
+            - allowed_hosts : configfs allowed host attribute.
+            - attr_allow_any_host : configfs allow any host attribute.
+    """
+    def __init__(self, cfgfs, nqn, allowed_hosts, attr_allow_any_host):
+        self.ns_list = []
+        self.cfgfs = cfgfs
+        self.nqn = nqn
+        self.subsys_path = self.cfgfs + "/nvmet/subsystems/" + nqn + "/"
+        self.allowed_hosts = allowed_hosts
+        self.attr_allow_any_host = attr_allow_any_host
+        self.err_str = "ERROR : " + self.__class__.__name__ + " : "
+
+    def init_subsys(self):
+        """ create and initialize subsystem.
+            - Args :
+                - None.
+            - Returns :
+                  - True on success, False on failure.
+        """
+        print "Loading nvme-loop module ..."
+        ret = self.exec_cmd("modprobe nvme-loop")
+        if ret is False:
+            print self.err_str + "unable to load nvme-loop module."
+            return False
+        # create subsystem dir
+        print "Creating subsys path " + self.subsys_path + "."
+        try:
+            os.makedirs(self.subsys_path)
+        except Exception, err:
+            print self.err_str + str(err)
+            return False
+        # allow any host
+        print "Configuring allowed hosts ..."
+        ret = self.exec_cmd("echo " + self.attr_allow_any_host + " >" +
+                            self.subsys_path + "/attr_allow_any_host")
+        status = "Target Subsys " + self.subsys_path + " created successfully."
+        if ret is False:
+            status = self.err_str + "create " + self.subsys_path + " failed."
+        print status
+
+        return ret
+
+    def exec_cmd(self, cmd):
+        """ Wrapper for executing a shell command.
+            - Args :
+                - cmd : command to execute.
+            - Returns :
+                - True if cmd returns 0, False otherwise.
+        """
+        proc = None
+        try:
+            proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
+        except Exception, err:
+            print self.err_str + str(err) + "."
+            return False
+
+        return True if proc.wait() == 0 else False
+
+    def create_ns(self, **ns_attr):
+        """ Create, initialize and store namespace in subsystem's list.
+            - Args :
+                - ns_attr : namespace attributes.
+            - Returns :
+                - namespace handle on success, None on error.
+        """
+        ns_id = self.generate_next_ns_id()
+
+        ns = NVMeOFTargetNamespace(self.cfgfs, self.nqn, ns_id, **ns_attr)
+        if ns.init_ns() is False:
+            return None
+        self.ns_list.append(ns)
+        return ns
+
+    def del_ns(self, ns):
+        """ Delete single namespace.
+            - Args :
+                - None.
+            - Returns :
+                - None.
+        """
+        print "Deleting namespace " + self.nqn + " : " + ns.ns_path
+
+        ret = ns.del_ns()
+        if ret is False:
+            print "ERROR : delete ns failed for " + ns.ns_path + "."
+
+        return ret
+
+    def del_subsys(self):
+        """ Delete subsystem and associated namespace(s).
+            - Args :
+                - None.
+            - Returns :
+                - None.
+        """
+        print "Deleting subsystem " + self.nqn
+        for ns in self.ns_list:
+            self.del_ns(ns)
+
+        if os.path.exists(self.subsys_path):
+            shutil.rmtree(self.subsys_path, ignore_errors=True)
+
+    def generate_next_ns_id(self):
+        """ Return next namespace id.
+            - Args :
+                - None.
+            - Returns :
+                - next namespace id.
+        """
+        return len(self.ns_list) + 1
diff --git a/tools/testing/selftests/nvmftests/test_nvmf_create_delete_fabric.py b/tools/testing/selftests/nvmftests/test_nvmf_create_delete_fabric.py
new file mode 100644
index 0000000..4c1df6c
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/test_nvmf_create_delete_fabric.py
@@ -0,0 +1,72 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+"""
+NVMeOF Create/Delete Host, Target :-
+
+    1. From the config file create Target.
+    2. From the config file create host and connect to target.
+    3. Delete Host.
+    4. Delete Target.
+"""
+
+import time
+from loopback import Loopback
+from nvmf_test import NVMeOFTest
+from target import NVMeOFTarget
+from host import NVMeOFHost
+from nose.tools import assert_equal
+
+
+class TestNVMFCreateDeleteFabric(NVMeOFTest):
+
+    """ Represents Create Delete Fabric testcase """
+
+    def __init__(self):
+        NVMeOFTest.__init__(self)
+        self.loopdev = None
+        self.host_subsys = None
+        self.target_subsys = None
+
+        self.setup_log_dir(self.__class__.__name__)
+        self.loopdev = Loopback(self.mount_path, self.data_size,
+                                self.block_size, self.nr_devices)
+        time.sleep(1)
+
+    def setUp(self):
+        print "configuering loopback"
+        self.loopdev.init_loopback()
+        time.sleep(1)
+        target_type = "loop"
+        self.target_subsys = NVMeOFTarget(target_type)
+        self.target_subsys.config_target()
+        self.host_subsys = NVMeOFHost(target_type)
+
+    def tearDown(self):
+        time.sleep(1)
+        self.host_subsys.del_host()
+        time.sleep(1)
+        self.target_subsys.del_target()
+        print "deleting loopback"
+        self.loopdev.del_loopback()
+
+    def test_create_delete_fabric(self):
+        """ Testcase main """
+        ret = self.host_subsys.config_host()
+        assert_equal(ret, True, "ERROR : config host failed")
diff --git a/tools/testing/selftests/nvmftests/test_nvmf_create_host.py b/tools/testing/selftests/nvmftests/test_nvmf_create_host.py
new file mode 100644
index 0000000..c918932
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/test_nvmf_create_host.py
@@ -0,0 +1,67 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+"""
+NVMeOF Create/Delete Host, Target :-
+
+    1. From the config file create Target.
+    2. From the config file create host and connect to target.
+    3. Delete Host.
+    4. Delete Target.
+"""
+
+from loopback import Loopback
+from nvmf_test import NVMeOFTest
+from target import NVMeOFTarget
+from host import NVMeOFHost
+from nose.tools import assert_equal
+
+
+class TestNVMFCreateHost(NVMeOFTest):
+
+    """ Represents Create Delete Fabric testcase """
+
+    def __init__(self):
+        NVMeOFTest.__init__(self)
+        self.loopdev = None
+        self.host_subsys = None
+        self.target_subsys = None
+
+        self.setup_log_dir(self.__class__.__name__)
+        self.loopdev = Loopback(self.mount_path, self.data_size,
+                                self.block_size, self.nr_devices)
+
+    def setUp(self):
+        """ Pre section of testcase """
+        self.loopdev.init_loopback()
+        target_type = "loop"
+        self.target_subsys = NVMeOFTarget(target_type)
+        self.target_subsys.config_target()
+        self.host_subsys = NVMeOFHost(target_type)
+
+    def tearDown(self):
+        """ Post section of testcase """
+        self.host_subsys.del_host()
+        self.target_subsys.del_target()
+        self.loopdev.del_loopback()
+
+    def test_create_host(self):
+        """ Testcase main """
+        ret = self.host_subsys.config_host()
+        assert_equal(ret, True, "ERROR : config host failed")
diff --git a/tools/testing/selftests/nvmftests/test_nvmf_create_target.py b/tools/testing/selftests/nvmftests/test_nvmf_create_target.py
new file mode 100644
index 0000000..82ebf83
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/test_nvmf_create_target.py
@@ -0,0 +1,59 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+"""
+NVMeOF Create/Delete Target :-
+
+    1. From the config file create Target.
+    2. Delete Target.
+"""
+
+from loopback import Loopback
+from nvmf_test import NVMeOFTest
+from target import NVMeOFTarget
+from nose.tools import assert_equal
+
+
+class TestNVMFCreateTarget(NVMeOFTest):
+
+    """ Represents Create Delete Target testcase """
+
+    def __init__(self):
+        NVMeOFTest.__init__(self)
+        self.target_subsys = None
+        self.loopdev = None
+        self.setup_log_dir(self.__class__.__name__)
+        self.loopdev = Loopback(self.mount_path, self.data_size,
+                                self.block_size, self.nr_devices)
+
+    def setUp(self):
+        """ Pre section of testcase """
+        self.loopdev.init_loopback()
+        target_type = "loop"
+        self.target_subsys = NVMeOFTarget(target_type)
+
+    def tearDown(self):
+        """ Post section of testcase """
+        self.target_subsys.del_target()
+        self.loopdev.del_loopback()
+
+    def test_create_target(self):
+        """ Testcase main """
+        ret = self.target_subsys.config_target()
+        assert_equal(ret, True, "ERROR : config target failed.")
diff --git a/tools/testing/selftests/nvmftests/test_nvmf_host_template.py b/tools/testing/selftests/nvmftests/test_nvmf_host_template.py
new file mode 100644
index 0000000..c1cb054
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/test_nvmf_host_template.py
@@ -0,0 +1,69 @@
+
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+"""
+NVMeOF host template :-
+
+    1. From the config file create Target.
+    2. From the config file create host and connect to target.
+    3. Write testcase code here.
+    4. Delete Host.
+    5. Delete Target.
+"""
+
+from loopback import Loopback
+from nvmf_test import NVMeOFTest
+from target import NVMeOFTarget
+from host import NVMeOFHost
+from nose.tools import assert_equal
+
+
+class TestNVMFHostTemplate(NVMeOFTest):
+
+    """ Represents host template testcase """
+
+    def __init__(self):
+        NVMeOFTest.__init__(self)
+        self.loopdev = None
+        self.host_subsys = None
+        self.target_subsys = None
+
+        self.setup_log_dir(self.__class__.__name__)
+        self.loopdev = Loopback(self.mount_path, self.data_size,
+                                self.block_size, self.nr_devices)
+
+    def setUp(self):
+        """ Pre section of testcase """
+        self.loopdev.init_loopback()
+        target_type = "loop"
+        self.target_subsys = NVMeOFTarget(target_type)
+        self.target_subsys.config_target()
+        self.host_subsys = NVMeOFHost(target_type)
+        self.host_subsys.config_host()
+
+    def tearDown(self):
+        """ Post section of testcase """
+        self.host_subsys.del_host()
+        self.target_subsys.del_target()
+        self.loopdev.del_loopback()
+
+    def test_mkfs(self):
+        """ Testcase main """
+        assert_equal(0, 0, "")
diff --git a/tools/testing/selftests/nvmftests/test_nvmf_id_ctrl.py b/tools/testing/selftests/nvmftests/test_nvmf_id_ctrl.py
new file mode 100644
index 0000000..76849b3
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/test_nvmf_id_ctrl.py
@@ -0,0 +1,69 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+"""
+NVMeOF test id-ctrl on each controller :-
+
+    1. From the config file create Target.
+    2. From the config file create host and connect to target.
+    3. Execute id-ctrl on all controllers.
+    4. Delete Host.
+    5. Delete Target.
+"""
+
+from loopback import Loopback
+from nvmf_test import NVMeOFTest
+from target import NVMeOFTarget
+from host import NVMeOFHost
+from nose.tools import assert_equal
+
+
+class TestNVMFIdentifyController(NVMeOFTest):
+
+    """ Represents Identify Controller Test testcase """
+
+    def __init__(self):
+        NVMeOFTest.__init__(self)
+        self.loopdev = None
+        self.host_subsys = None
+        self.target_subsys = None
+
+        self.setup_log_dir(self.__class__.__name__)
+        self.loopdev = Loopback(self.mount_path, self.data_size,
+                                self.block_size, self.nr_devices)
+
+    def setUp(self):
+        """ Pre section of testcase """
+        self.loopdev.init_loopback()
+        target_type = "loop"
+        self.target_subsys = NVMeOFTarget(target_type)
+        self.target_subsys.config_target()
+        self.host_subsys = NVMeOFHost(target_type)
+        self.host_subsys.config_host()
+
+    def tearDown(self):
+        """ Post section of testcase """
+        self.host_subsys.del_host()
+        self.target_subsys.del_target()
+        self.loopdev.del_loopback()
+
+    def test_identify_controller(self):
+        """ Testcase main """
+        ret = self.host_subsys.id_ctrl()
+        assert_equal(ret, True, "ERROR : id controller failed.")
diff --git a/tools/testing/selftests/nvmftests/test_nvmf_id_ns.py b/tools/testing/selftests/nvmftests/test_nvmf_id_ns.py
new file mode 100644
index 0000000..900f3c9
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/test_nvmf_id_ns.py
@@ -0,0 +1,69 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+"""
+NVMeOF test id-ns on each namespace :-
+
+    1. From the config file create Target.
+    2. From the config file create host and connect to target.
+    3. Execute id-ns namespaces.
+    4. Delete Host.
+    5. Delete Target.
+"""
+
+from loopback import Loopback
+from nvmf_test import NVMeOFTest
+from target import NVMeOFTarget
+from host import NVMeOFHost
+from nose.tools import assert_equal
+
+
+class TestNVMFIdentifyNamespace(NVMeOFTest):
+
+    """ Represents Identify Namespace Test testcase """
+
+    def __init__(self):
+        NVMeOFTest.__init__(self)
+        self.loopdev = None
+        self.host_subsys = None
+        self.target_subsys = None
+
+        self.setup_log_dir(self.__class__.__name__)
+        self.loopdev = Loopback(self.mount_path, self.data_size,
+                                self.block_size, self.nr_devices)
+
+    def setUp(self):
+        """ Pre section of testcase """
+        self.loopdev.init_loopback()
+        target_type = "loop"
+        self.target_subsys = NVMeOFTarget(target_type)
+        self.target_subsys.config_target()
+        self.host_subsys = NVMeOFHost(target_type)
+        self.host_subsys.config_host()
+
+    def tearDown(self):
+        """ Post section of testcase """
+        self.host_subsys.del_host()
+        self.target_subsys.del_target()
+        self.loopdev.del_loopback()
+
+    def test_identify_namespace(self):
+        """ Testcase main """
+        ret = self.host_subsys.id_ns()
+        assert_equal(ret, True, "ERROR : id ns failed.")
diff --git a/tools/testing/selftests/nvmftests/test_nvmf_mkfs.py b/tools/testing/selftests/nvmftests/test_nvmf_mkfs.py
new file mode 100644
index 0000000..cfc0d60
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/test_nvmf_mkfs.py
@@ -0,0 +1,70 @@
+
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+"""
+NVMeOF test mkfs on each subsystem :-
+
+    1. From the config file create Target.
+    2. From the config file create host and connect to target.
+    3. Execute mkfs on all controllers and its namespaces.
+    4. Delete Host.
+    5. Delete Target.
+"""
+
+from loopback import Loopback
+from nvmf_test import NVMeOFTest
+from target import NVMeOFTarget
+from host import NVMeOFHost
+from nose.tools import assert_equal
+
+
+class TestNVMFMKFS(NVMeOFTest):
+
+    """ Represents mkfs testcase """
+
+    def __init__(self):
+        NVMeOFTest.__init__(self)
+        self.loopdev = None
+        self.host_subsys = None
+        self.target_subsys = None
+
+        self.setup_log_dir(self.__class__.__name__)
+        self.loopdev = Loopback(self.mount_path, self.data_size,
+                                self.block_size, self.nr_devices)
+
+    def setUp(self):
+        """ Pre section of testcase """
+        self.loopdev.init_loopback()
+        target_type = "loop"
+        self.target_subsys = NVMeOFTarget(target_type)
+        self.target_subsys.config_target()
+        self.host_subsys = NVMeOFHost(target_type)
+        self.host_subsys.config_host()
+
+    def tearDown(self):
+        """ Post section of testcase """
+        self.host_subsys.del_host()
+        self.target_subsys.del_target()
+        self.loopdev.del_loopback()
+
+    def test_mkfs(self):
+        """ Testcase main """
+        ret = self.host_subsys.mkfs_seq()
+        assert_equal(ret, True, "ERROR : mkfs failed.")
diff --git a/tools/testing/selftests/nvmftests/test_nvmf_parallel_io.py b/tools/testing/selftests/nvmftests/test_nvmf_parallel_io.py
new file mode 100644
index 0000000..ba70f03
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/test_nvmf_parallel_io.py
@@ -0,0 +1,71 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+"""
+NVMeOF test parallel IOs on all controllers :-
+
+    1. From the config file create Target.
+    2. From the config file create host and connect to target.
+    3. Run parallel IOs on all available controller(s) and its nvmespace(s).
+    4. Delete Host.
+    5. Delete Target.
+"""
+
+from loopback import Loopback
+from nvmf_test import NVMeOFTest
+from target import NVMeOFTarget
+from host import NVMeOFHost
+from nose.tools import assert_equal
+
+
+class TestNVMeOFParallelFabric(NVMeOFTest):
+
+    """ Represents Parallel Subsystem IO testcase """
+
+    def __init__(self):
+        NVMeOFTest.__init__(self)
+        self.loopdev = None
+        self.host_subsys = None
+        self.target_subsys = None
+
+        self.setup_log_dir(self.__class__.__name__)
+        self.loopdev = Loopback(self.mount_path, self.data_size,
+                                self.block_size, self.nr_devices)
+
+    def setUp(self):
+        """ Pre section of testcase """
+        self.loopdev.init_loopback()
+        target_type = "loop"
+        self.target_subsys = NVMeOFTarget(target_type)
+        self.target_subsys.config_target()
+        self.host_subsys = NVMeOFHost(target_type)
+        self.host_subsys.config_host()
+
+    def tearDown(self):
+        """ Post section of testcase """
+        self.host_subsys.del_host()
+        self.target_subsys.del_target()
+        self.loopdev.del_loopback()
+
+    def test_parallel_io(self):
+        """ Testcase main """
+        ret = self.host_subsys.run_ios_parallel(self.dd_read)
+        assert_equal(ret, True, "ERROR : running IOs failed.")
+        ret = self.host_subsys.run_ios_parallel(self.dd_write)
+        assert_equal(ret, True, "ERROR : running IOs failed.")
diff --git a/tools/testing/selftests/nvmftests/test_nvmf_random_io.py b/tools/testing/selftests/nvmftests/test_nvmf_random_io.py
new file mode 100644
index 0000000..d3d125b
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/test_nvmf_random_io.py
@@ -0,0 +1,71 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+"""
+NVMeOF randomly select a controller and run IOs :-
+
+    1. From the config file create Target.
+    2. From the config file create host and connect to target.
+    3. Randomly select the controller and its  namespaces(s) for IOs.
+    4. Delete Host.
+    5. Delete Target.
+"""
+
+from loopback import Loopback
+from nvmf_test import NVMeOFTest
+from target import NVMeOFTarget
+from host import NVMeOFHost
+from nose.tools import assert_equal
+
+
+class TestNVMeOFRandomFabric(NVMeOFTest):
+
+    """ Represents Random Susbsytem IO testcase """
+
+    def __init__(self):
+        NVMeOFTest.__init__(self)
+        self.loopdev = None
+        self.host_subsys = None
+        self.target_subsys = None
+
+        self.setup_log_dir(self.__class__.__name__)
+        self.loopdev = Loopback(self.mount_path, self.data_size,
+                                self.block_size, self.nr_devices)
+
+    def setUp(self):
+        """ Pre section of testcase """
+        self.loopdev.init_loopback()
+        target_type = "loop"
+        self.target_subsys = NVMeOFTarget(target_type)
+        self.target_subsys.config_target()
+        self.host_subsys = NVMeOFHost(target_type)
+        self.host_subsys.config_host()
+
+    def tearDown(self):
+        """ Post section of testcase """
+        self.host_subsys.del_host()
+        self.target_subsys.del_target()
+        self.loopdev.del_loopback()
+
+    def test_random_io(self):
+        """ Testcase main """
+        ret = self.host_subsys.run_ios_random(self.dd_read)
+        assert_equal(ret, True, "ERROR : running IOs failed.")
+        ret = self.host_subsys.run_ios_random(self.dd_write)
+        assert_equal(ret, True, "ERROR : running IOs failed.")
diff --git a/tools/testing/selftests/nvmftests/test_nvmf_simple_io.py b/tools/testing/selftests/nvmftests/test_nvmf_simple_io.py
new file mode 100644
index 0000000..cc0428e
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/test_nvmf_simple_io.py
@@ -0,0 +1,71 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+"""
+NVMeOF sequntially select a controller and run IOs:-
+
+    1. From the config file create Target.
+    2. From the config file create host and connect to target.
+    3. Run IOs sequentially iterating over controller(s) ans its namespaces(s).
+    3. Delete Host.
+    4. Delete Target.
+"""
+
+from loopback import Loopback
+from nvmf_test import NVMeOFTest
+from target import NVMeOFTarget
+from host import NVMeOFHost
+from nose.tools import assert_equal
+
+
+class TestNVMeOFSeqFabric(NVMeOFTest):
+
+    """ Represents Sequential Subsystem IO testcase """
+
+    def __init__(self):
+        NVMeOFTest.__init__(self)
+        self.loopdev = None
+        self.host_subsys = None
+        self.target_subsys = None
+
+        self.setup_log_dir(self.__class__.__name__)
+        self.loopdev = Loopback(self.mount_path, self.data_size,
+                                self.block_size, self.nr_devices)
+
+    def setUp(self):
+        """ Pre section of testcase """
+        self.loopdev.init_loopback()
+        target_type = "loop"
+        self.target_subsys = NVMeOFTarget(target_type)
+        self.target_subsys.config_target()
+        self.host_subsys = NVMeOFHost(target_type)
+        self.host_subsys.config_host()
+
+    def tearDown(self):
+        """ Post section of testcase """
+        self.host_subsys.del_host()
+        self.target_subsys.del_target()
+        self.loopdev.del_loopback()
+
+    def test_seq_io(self):
+        """ Testcase main """
+        ret = self.host_subsys.run_ios_seq(self.dd_read)
+        assert_equal(ret, True, "ERROR : running IOs failed.")
+        ret = self.host_subsys.run_ios_seq(self.dd_write)
+        assert_equal(ret, True, "ERROR : running IOs failed.")
diff --git a/tools/testing/selftests/nvmftests/test_nvmf_smart_log.py b/tools/testing/selftests/nvmftests/test_nvmf_smart_log.py
new file mode 100644
index 0000000..172e0a8
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/test_nvmf_smart_log.py
@@ -0,0 +1,69 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+"""
+NVMeOF test smart log on all controllers :-
+
+    1. From the config file create Target.
+    2. From the config file create host and connect to target.
+    3. Execute smart-log on all controllers and its namespaces.
+    4. Delete Host.
+    5. Delete Target.
+"""
+
+from loopback import Loopback
+from nvmf_test import NVMeOFTest
+from target import NVMeOFTarget
+from host import NVMeOFHost
+from nose.tools import assert_equal
+
+
+class TestNVMFSmartLog(NVMeOFTest):
+
+    """ Represents Smart Log testcase """
+
+    def __init__(self):
+        NVMeOFTest.__init__(self)
+        self.loopdev = None
+        self.host_subsys = None
+        self.target_subsys = None
+
+        self.setup_log_dir(self.__class__.__name__)
+        self.loopdev = Loopback(self.mount_path, self.data_size,
+                                self.block_size, self.nr_devices)
+
+    def setUp(self):
+        """ Pre section of testcase """
+        self.loopdev.init_loopback()
+        target_type = "loop"
+        self.target_subsys = NVMeOFTarget(target_type)
+        self.target_subsys.config_target()
+        self.host_subsys = NVMeOFHost(target_type)
+        self.host_subsys.config_host()
+
+    def tearDown(self):
+        """ Post section of testcase """
+        self.host_subsys.del_host()
+        self.target_subsys.del_target()
+        self.loopdev.del_loopback()
+
+    def test_smart_log(self):
+        """ Testcase main """
+        ret = self.host_subsys.smart_log()
+        assert_equal(ret, True, "ERROR : running smart log failed.")
diff --git a/tools/testing/selftests/nvmftests/test_nvmf_target_template.py b/tools/testing/selftests/nvmftests/test_nvmf_target_template.py
new file mode 100644
index 0000000..2358a8d
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/test_nvmf_target_template.py
@@ -0,0 +1,64 @@
+
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
+#
+"""
+NVMeOF host template :-
+
+    1. From the config file create Target.
+    2. From the config file create host and connect to target.
+    3. Write testcase code here.
+    4. Delete Host.
+    5. Delete Target.
+"""
+
+from loopback import Loopback
+from nvmf_test import NVMeOFTest
+from target import NVMeOFTarget
+from nose.tools import assert_equal
+
+
+class TestNVMFTargetTemplate(NVMeOFTest):
+
+    """ Represents target template testcase """
+
+    def __init__(self):
+        NVMeOFTest.__init__(self)
+        self.loopdev = None
+        self.target_subsys = None
+
+        self.setup_log_dir(self.__class__.__name__)
+        self.loopdev = Loopback(self.mount_path, self.data_size,
+                                self.block_size, self.nr_devices)
+
+    def setUp(self):
+        """ Pre section of testcase """
+        self.loopdev.init_loopback()
+        target_type = "loop"
+        self.target_subsys = NVMeOFTarget(target_type)
+        self.target_subsys.config_target()
+
+    def tearDown(self):
+        """ Post section of testcase """
+        self.target_subsys.del_target()
+        self.loopdev.del_loopback()
+
+    def test_mkfs(self):
+        """ Testcase main """
+        assert_equal(0, 0, "")
-- 
2.7.4
