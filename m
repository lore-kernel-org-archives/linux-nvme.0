From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 24 Oct 2017 18:30:17 -0700
Subject: [PATCH V2 00/46] nvmftests: NVMe Over Fabrics Unit Test Framework
Message-ID: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Hi,

This contains second version of the NVMe Over Fabrics unit test framework (nvmftests).

Changes since V1:-
    1. Addition of new testcases to improve the coverage.
    2. Improved directory structure for code clarity.
    3. Libification of the common code.
    4. Support to use different block devices on the target side.
    5. Centralize test configuration management.
    6. Support to execute File System related operations on the host side.
    7. Adjust the code to incorporate the comments received for the
       first version.
    8. Support for setting different log levels for each component.
    9. Support for quick performance measurements.
    10. Class hierarchy documentation and sequence diagram.
    11. Improved workqueue management for host namesapce to
        run parallel commands.

It will be great if I can get some feedback, I'll be happy to incorporate
the comments and make it more usable.

Following is the code repository for current code:-
    https://github.com/ChaitanayaKulkarni/nvmftests/releases

For the purpose of review, this patch series is generated against
$KERN_SRC/tools/testing/selftests/.

Regards,
-Chaitanya

Chaitanya Kulkarni (46):
  nvmftests: add nvmftests README file
  nvmftests-utils: add utility class to define constants
  nvmftests-utils: add shell command package
  nvmftests-utils: add log package
  nvmftests-utils: add diskio package
  nvmftests-utils: add fs package
  nvmftests-utils: add misc package
  nvmftests: add utils package
  nvmftests-nvmf: add target config generator
  nvmftests-nvmf: add support for target ns
  nvmftests-nvmf: add support for target port
  nvmftests-nvmf: add support for target subsystem
  nvmftests-nvmf: add support for target
  nvmftests-nvmf: add target package
  nvmftests-nvmf: add support for host ns
  nvmftests-nvmf: add support for host subsystem
  nvmftests-nvmf: add support for host
  nvmftests-nvmf: add host package
  nvmftests-nvmf: add nvmf core package
  nvmftests-tests: add user config file
  nvmftests-tests: add support for test logger
  nvmftests-tests: add a parent class for tests
  nvmftests-tests: add a test for generic block device
  nvmftests-tests: add a test for ns-descs
  nvmftests-tests: add a test for create/delete host
  nvmftests-tests: add a test for NVMe PCIe target ns
  nvmftests-tests: add a test to create and delete target
  nvmftests-tests: add a test for controller rescan
  nvmftests-tests: add a test for controller reset
  nvmftests-tests: add a test for get-ns-id
  nvmftests-tests: add a test for identify controller
  nvmftests-tests: add a test for identify namespace
  nvmftests-tests: add a test for smart-log
  nvmftests-tests: add a test to run IOs with dd
  nvmftests-tests: add a test to run IOs parallely with dd
  nvmftests-tests: add a test to run mkfs and fio
  nvmftests-tests: add a test to enable/disable target ns
  nvmftests-tests: add a test to run IOs with dd randomly
  nvmftests-tests: add a test to scan host ctrls and ns
  nvmftests-tests: add a test to scan target subsys/ns
  nvmftests-tests: add a target template
  nvmftests-tests: add a host template
  nvmftests-tests: add a test to run traffic and disable ns
  nvmftests-tests: add a test to measure perf with fio
  nvmftests: add class documentation and sequence diagram
  nvmftests: add Makefile

 tools/testing/selftests/nvmftests/Makefile         |  63 +++
 tools/testing/selftests/nvmftests/README.md        | 177 +++++++
 tools/testing/selftests/nvmftests/doc/Makefile     |   7 +
 .../selftests/nvmftests/doc/sequence-diag/Makefile |   7 +
 .../nvmftests/doc/sequence-diag/nvmftests.plantuml |  98 ++++
 tools/testing/selftests/nvmftests/nvmf/__init__.py |  28 ++
 .../selftests/nvmftests/nvmf/host/__init__.py      |  23 +
 .../testing/selftests/nvmftests/nvmf/host/host.py  | 365 ++++++++++++++
 .../selftests/nvmftests/nvmf/host/host_ns.py       | 262 ++++++++++
 .../nvmftests/nvmf/host/host_subsystem.py          | 527 +++++++++++++++++++++
 .../selftests/nvmftests/nvmf/target/__init__.py    |  25 +
 .../selftests/nvmftests/nvmf/target/port.py        | 122 +++++
 .../selftests/nvmftests/nvmf/target/target.py      | 210 ++++++++
 .../nvmf/target/target_config_generator.py         | 222 +++++++++
 .../selftests/nvmftests/nvmf/target/target_ns.py   | 117 +++++
 .../nvmftests/nvmf/target/target_subsystem.py      | 140 ++++++
 .../nvmftests/tests/config/nvmftests.json          |  83 ++++
 .../testing/selftests/nvmftests/tests/nvmf_test.py | 204 ++++++++
 .../selftests/nvmftests/tests/nvmf_test_logger.py  |  50 ++
 .../nvmftests/tests/test_nvmf_create_gen_blk.py    |  71 +++
 .../nvmftests/tests/test_nvmf_create_host.py       |  71 +++
 .../nvmftests/tests/test_nvmf_create_pci_target.py |  70 +++
 .../nvmftests/tests/test_nvmf_create_target.py     |  62 +++
 .../nvmftests/tests/test_nvmf_ctrl_rescan.py       |  63 +++
 .../nvmftests/tests/test_nvmf_ctrl_reset.py        |  63 +++
 .../nvmftests/tests/test_nvmf_get_ns_id.py         |  63 +++
 .../nvmftests/tests/test_nvmf_host_template.py     |  62 +++
 .../selftests/nvmftests/tests/test_nvmf_id_ctrl.py |  63 +++
 .../selftests/nvmftests/tests/test_nvmf_id_ns.py   |  63 +++
 .../selftests/nvmftests/tests/test_nvmf_io.py      |  65 +++
 .../selftests/nvmftests/tests/test_nvmf_mkfs.py    |  65 +++
 .../nvmftests/tests/test_nvmf_ns_descs.py          |  63 +++
 .../nvmftests/tests/test_nvmf_ns_enable_disable.py |  83 ++++
 .../nvmftests/tests/test_nvmf_parallel_io.py       |  65 +++
 .../selftests/nvmftests/tests/test_nvmf_perf.py    |  63 +++
 .../nvmftests/tests/test_nvmf_random_io.py         |  65 +++
 .../nvmftests/tests/test_nvmf_run_host_traffic.py  | 111 +++++
 .../nvmftests/tests/test_nvmf_scan_host.py         |  76 +++
 .../nvmftests/tests/test_nvmf_scan_target.py       |  76 +++
 .../nvmftests/tests/test_nvmf_smart_log.py         |  63 +++
 .../nvmftests/tests/test_nvmf_target_template.py   |  64 +++
 .../testing/selftests/nvmftests/utils/__init__.py  |  32 ++
 .../selftests/nvmftests/utils/const/__init__.py    |  21 +
 .../selftests/nvmftests/utils/const/const.py       |  50 ++
 .../selftests/nvmftests/utils/diskio/__init__.py   |  21 +
 .../testing/selftests/nvmftests/utils/diskio/dd.py |  50 ++
 .../selftests/nvmftests/utils/diskio/fio.py        |  74 +++
 .../selftests/nvmftests/utils/fs/__init__.py       |  21 +
 .../testing/selftests/nvmftests/utils/fs/ext4fs.py | 108 +++++
 .../selftests/nvmftests/utils/fs/filesystem.py     | 122 +++++
 .../selftests/nvmftests/utils/log/__init__.py      |  20 +
 tools/testing/selftests/nvmftests/utils/log/log.py |  58 +++
 .../selftests/nvmftests/utils/misc/__init__.py     |  23 +
 .../nvmftests/utils/misc/generic_blk_dev.py        |  58 +++
 .../selftests/nvmftests/utils/misc/loopback.py     | 103 ++++
 .../selftests/nvmftests/utils/misc/nvme_pci.py     | 114 +++++
 .../selftests/nvmftests/utils/shell/__init__.py    |  20 +
 .../testing/selftests/nvmftests/utils/shell/cmd.py |  47 ++
 58 files changed, 5182 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/Makefile
 create mode 100644 tools/testing/selftests/nvmftests/README.md
 create mode 100644 tools/testing/selftests/nvmftests/doc/Makefile
 create mode 100644 tools/testing/selftests/nvmftests/doc/sequence-diag/Makefile
 create mode 100644 tools/testing/selftests/nvmftests/doc/sequence-diag/nvmftests.plantuml
 create mode 100644 tools/testing/selftests/nvmftests/nvmf/__init__.py
 create mode 100644 tools/testing/selftests/nvmftests/nvmf/host/__init__.py
 create mode 100644 tools/testing/selftests/nvmftests/nvmf/host/host.py
 create mode 100644 tools/testing/selftests/nvmftests/nvmf/host/host_ns.py
 create mode 100644 tools/testing/selftests/nvmftests/nvmf/host/host_subsystem.py
 create mode 100644 tools/testing/selftests/nvmftests/nvmf/target/__init__.py
 create mode 100644 tools/testing/selftests/nvmftests/nvmf/target/port.py
 create mode 100644 tools/testing/selftests/nvmftests/nvmf/target/target.py
 create mode 100644 tools/testing/selftests/nvmftests/nvmf/target/target_config_generator.py
 create mode 100644 tools/testing/selftests/nvmftests/nvmf/target/target_ns.py
 create mode 100644 tools/testing/selftests/nvmftests/nvmf/target/target_subsystem.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/config/nvmftests.json
 create mode 100644 tools/testing/selftests/nvmftests/tests/nvmf_test.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/nvmf_test_logger.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_create_gen_blk.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_create_host.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_create_pci_target.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_create_target.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_ctrl_rescan.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_ctrl_reset.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_get_ns_id.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_host_template.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_id_ctrl.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_id_ns.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_io.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_mkfs.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_ns_descs.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_ns_enable_disable.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_parallel_io.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_perf.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_random_io.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_run_host_traffic.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_scan_host.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_scan_target.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_smart_log.py
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_target_template.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/__init__.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/const/__init__.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/const/const.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/diskio/__init__.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/diskio/dd.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/diskio/fio.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/fs/__init__.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/fs/ext4fs.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/fs/filesystem.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/log/__init__.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/log/log.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/misc/__init__.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/misc/generic_blk_dev.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/misc/loopback.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/misc/nvme_pci.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/shell/__init__.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/shell/cmd.py

-- 
1.8.3.1
