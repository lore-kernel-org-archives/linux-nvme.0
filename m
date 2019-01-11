From: Dong.Ho@wdc.com (Dong Ho)
Date: Fri, 11 Jan 2019 00:37:06 +0000
Subject: [PATCH 1/2] wdc: Change device capability checking
Message-ID: <1547167007-2374-1-git-send-email-dong.ho@wdc.com>

Changes the way device VID and type are checked for compatibility
purposes. Other minor changes for command names, update the respective
documentation file names, and remove deprecated C1 log functionality.
---
 Documentation/nvme-wdc-clear-pcie-corr.txt         |  40 --
 .../nvme-wdc-clear-pcie-correctable-errors.txt     |  40 ++
 Documentation/nvme-wdc-smart-add-log.txt           | 268 -------------
 Documentation/nvme-wdc-vs-smart-add-log.txt        | 268 +++++++++++++
 plugins/wdc/wdc-nvme.c                             | 444 +++++++--------------
 plugins/wdc/wdc-nvme.h                             |   6 +-
 6 files changed, 460 insertions(+), 606 deletions(-)
 delete mode 100644 Documentation/nvme-wdc-clear-pcie-corr.txt
 create mode 100644 Documentation/nvme-wdc-clear-pcie-correctable-errors.txt
 delete mode 100644 Documentation/nvme-wdc-smart-add-log.txt
 create mode 100644 Documentation/nvme-wdc-vs-smart-add-log.txt

diff --git a/Documentation/nvme-wdc-clear-pcie-corr.txt b/Documentation/nvme-wdc-clear-pcie-corr.txt
deleted file mode 100644
index a65978e..0000000
--- a/Documentation/nvme-wdc-clear-pcie-corr.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-nvme-wdc-clear-pcie-corr(1)
-===========================
-
-NAME
-----
-nvme-wdc-clear-pcie-corr - Clears the pcie correctable errors field returned in the smart-log-add command.
-
-SYNOPSIS
---------
-[verse]
-'nvme wdc clear-pcie-corr' <device> 
-
-DESCRIPTION
------------
-For the NVMe device given, sends the wdc vendor unique clear pcie 
-correctable errors command.
-
-The <device> parameter is mandatory and may be either the NVMe
-character device (ex: /dev/nvme0), or a namespace block device (ex:
-/dev/nvme0n1).
-
-This will only work on WDC devices supporting this feature.
-Results for any other device are undefined.
-
-OPTIONS
--------
-None
-
-EXAMPLES
---------
-* Clears the PCIe Correctable Error Count field returned in the smart-log-add command:
-+
-------------
-# nvme wdc clear-pcie-corr /dev/nvme0
-------------
-
-
-NVME
-----
-Part of the nvme-user suite
diff --git a/Documentation/nvme-wdc-clear-pcie-correctable-errors.txt b/Documentation/nvme-wdc-clear-pcie-correctable-errors.txt
new file mode 100644
index 0000000..4788f1f
--- /dev/null
+++ b/Documentation/nvme-wdc-clear-pcie-correctable-errors.txt
@@ -0,0 +1,40 @@
+nvme-wdc-clear-pcie-correctable-errors(1)
+=========================================
+
+NAME
+----
+nvme-wdc-clear-pcie-correctable-errors - Clears the pcie correctable errors field returned in the smart-log-add command.
+
+SYNOPSIS
+--------
+[verse]
+'nvme wdc clear-pcie-correctable-errors' <device>
+
+DESCRIPTION
+-----------
+For the NVMe device given, sends the wdc vendor unique clear pcie
+correctable errors command.
+
+The <device> parameter is mandatory and may be either the NVMe
+character device (ex: /dev/nvme0), or a namespace block device (ex:
+/dev/nvme0n1).
+
+This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.
+
+OPTIONS
+-------
+None
+
+EXAMPLES
+--------
+* Clears the PCIe Correctable Error Count field returned in the smart-log-add command:
++
+------------
+# nvme wdc clear-pcie-correctable-errors /dev/nvme0
+------------
+
+
+NVME
+----
+Part of the nvme-user suite
diff --git a/Documentation/nvme-wdc-smart-add-log.txt b/Documentation/nvme-wdc-smart-add-log.txt
deleted file mode 100644
index e82debf..0000000
--- a/Documentation/nvme-wdc-smart-add-log.txt
+++ /dev/null
@@ -1,268 +0,0 @@
-nvme-wdc-smart-add-log(1)
-=========================
-
-NAME
-----
-nvme-wdc-smart-add-log - Send NVMe WDC smart-add-log Vendor Unique Command, return result
-
-SYNOPSIS
---------
-[verse]
-'nvme wdc smart-add-log' <device> [--interval=<NUM>, -i <NUM>] [--output-format=<normal|json> -o <normal|json>]
-
-DESCRIPTION
------------
-For the NVMe device given, send a Vendor Unique WDC smart-add-log command and
-provide the additional smart log. The --interval option will return performance
-statistics from the specified reporting interval.
-
-The <device> parameter is mandatory and may be either the NVMe character
-device (ex: /dev/nvme0).
-
-This will only work on WDC devices supporting this feature.
-Results for any other device are undefined.
-
-On success it returns 0, error code otherwise.
-
-OPTIONS
--------
--i <NUM>::
---interval=<NUM>::
-	Return the statistics from specific interval, defaults to 14
-
--o <format>::
---output-format=<format>::
-	Set the reporting format to 'normal', or
-	'json'. Only one output format can be used at a time.
-	Default is normal.
-
-Valid Interval values and description :-
-
-[cols="2*", frame="topbot", align="center", options="header"]
-|===
-|Value |Description
-
-|*1*
-|Most recent five (5) minute accumulated set.
-
-|*2-12*
-|Previous five (5) minute accumulated sets.
-
-|*13*
-|The accumulated total of sets 1 through 12 that contain the previous hour of
-accumulated statistics.
-
-|*14*
-|The statistical set accumulated since power-up.
-
-|*15*
-|The statistical set accumulated during the entire lifetime of the device.
-|===
-
-CA Log Page Data Output Explanation
------------------------------------
-[cols="2*", frame="topbot", align="center", options="header"]
-|===
-|Field |Description
-
-|*Physical NAND bytes written.*
-|The number of bytes written to NAND.  16 bytes - hi/lo
-
-|*Physical NAND bytes read*
-|The number of bytes read from NAND.  16 bytes - hi/lo
-
-|*Bad NAND Block Count*
-|Raw and normalized count of the number of NAND blocks that have been
-retired after the drives manufacturing tests (i.e. grown back blocks).
-2 bytes normalized, 6 bytes raw count
-
-|*Uncorrectable Read Error Count*
-|Total count of NAND reads that were not correctable by read retries, all
-levels of ECC, or XOR (as applicable).  8 bytes
-
-|*Soft ECC Error Count*
-|Total count of NAND reads that were not correctable by read retries, or
-first-level ECC.  8 bytes
-
-|*SSD End to End Detection Count*
-|A count of the detected errors by the SSD end to end error correction which
-includes DRAM, SRAM, or other storage element ECC/CRC protection mechanism (not
-NAND ECC).  4 bytes
-
-|*SSD End to End Correction Count*
-|A count of the corrected errors by the SSD end to end error correction which
-includes DRAM, SRAM, or other storage element ECC/CRC protection mechanism (not
-NAND ECC).  4 bytes
-
-|*System Data % Used*
-|A normalized cumulative count of the number of erase cycles per block since
-leaving the factory for the system (FW and metadata) area. Starts at 0 and
-increments. 100 indicates that the estimated endurance has been consumed.
-
-|*User Data Max Erase Count*
-|The maximum erase count across all NAND blocks in the drive.  4 bytes
-
-|*User Data Min Erase Count*
-|The minimum erase count across all NAND blocks in the drive.  4 bytes
-
-|*Refresh Count*
-|A count of the number of blocks that have been re-allocated due to
-background operations only.  8 bytes
-
-|*Program Fail Count*
-|Raw and normalized count of total program failures. Normalized count
-starts at 100 and shows the percent of remaining allowable failures.
-2 bytes normalized, 6 bytes raw count
-
-|*User Data Erase Fail Count*
-|Raw and normalized count of total erase failures in the user area.
-Normalized count starts at 100 and shows the percent of remaining
-allowable failures.  2 bytes normalized, 6 bytes raw count
-
-|*System Area Erase Fail Count*
-|Raw and normalized count of total erase failures in the system area.
-Normalized count starts at 100 and shows the percent of remaining
-allowable failures.  2 bytes normalized, 6 bytes raw count
-
-|*Thermal Throttling Status*
-|The current status of thermal throttling (enabled or disabled).
-2 bytes
-
-|*Thermal Throttling Count*
-|A count of the number of thermal throttling events.  2 bytes
-
-|*PCIe Correctable Error Count*
-|Summation counter of all PCIe correctable errors (Bad TLP, Bad
-DLLP, Receiver error, Replay timeouts, Replay rollovers).  8 bytes
-|===
-
-
-C1 Log Page Data Output Explanation
------------------------------------
-[cols="2*", frame="topbot", align="center", options="header"]
-|===
-|Field |Description
-
-|*Host Read Commands*
-|Number of host read commands received during the reporting period.
-
-|*Host Read Blocks*
-|Number of 512-byte blocks requested during the reporting period.
-
-|*Average Read Size*
-|Average Read size is calculated using (Host Read Blocks/Host Read Commands).
-
-|*Host Read Cache Hit Commands*
-|Number of host read commands that serviced entirely from the on-board read
-cache during the reporting period. No access to the NAND flash memory was required.
-This count is only updated if the entire command was serviced from the cache memory.
-
-|*Host Read Cache Hit Percentage*
-|Percentage of host read commands satisfied from the cache.
-
-|*Host Read Cache Hit Blocks*
-|Number of 512-byte blocks of data that have been returned for Host Read Cache Hit
-Commands during the reporting period. This count is only updated with the blocks
-returned for host read commands that were serviced entirely from cache memory.
-
-|*Average Read Cache Hit Size*
-|Average size of read commands satisfied from the cache.
-
-|*Host Read Commands Stalled*
-|Number of host read commands that were stalled due to a lack of resources within
-the SSD during the reporting period (NAND flash command queue full, low cache page count,
-cache page contention, etc.). Commands are not considered stalled if the only reason for
-the delay was waiting for the data to be physically read from the NAND flash. It is normal
-to expect this count to equal zero on heavily utilized systems.
-
-|*Host Read Commands Stalled Percentage*
-|Percentage of read commands that were stalled. If the figure is consistently high,
-then consideration should be given to spreading the data across multiple SSDs.
-
-|*Host Write Commands*
-|Number of host write commands received during the reporting period.
-
-|*Host Write Blocks*
-|Number of 512-byte blocks written during the reporting period.
-
-|*Average Write Size*
-|Average Write size calculated using (Host Write Blocks/Host Write Commands).
-
-|*Host Write Odd Start Commands*
-|Number of host write commands that started on a non-aligned boundary during
-the reporting period. The size of the boundary alignment is normally 4K; therefore
-this returns the number of commands that started on a non-4K aligned boundary.
-The SSD requires slightly more time to process non-aligned write commands than it
-does to process aligned write commands.
-
-|*Host Write Odd Start Commands Percentage*
-|Percentage of host write commands that started on a non-aligned boundary. If this
-figure is equal to or near 100%, and the NAND Read Before Write value is also high,
-then the user should investigate the possibility of offsetting the file system. For
-Microsoft Windows systems, the user can use Diskpart. For Unix-based operating systems,
-there is normally a method whereby file system partitions can be placed where required.
-
-|*Host Write Odd End Commands*
-|Number of host write commands that ended on a non-aligned boundary during the
-reporting period. The size of the boundary alignment is normally 4K; therefore this
-returns the number of commands that ended on a non-4K aligned boundary.
-
-|*Host Write Odd End Commands Percentage*
-|Percentage of host write commands that ended on a non-aligned boundary.
-
-|*Host Write Commands Stalled*
-|Number of host write commands that were stalled due to a lack of resources within the
-SSD during the reporting period. The most likely cause is that the write data was being
-received faster than it could be saved to the NAND flash memory. If there was a large
-volume of read commands being processed simultaneously, then other causes might include
-the NAND flash command queue being full, low cache page count, or cache page contention, etc.
-It is normal to expect this count to be non-zero on heavily utilized systems.
-
-|*Host Write Commands Stalled Percentage*
-|Percentage of write commands that were stalled. If the figure is consistently high, then
-consideration should be given to spreading the data across multiple SSDs.
-
-|*NAND Read Commands*
-|Number of read commands issued to the NAND devices during the reporting period.
-This figure will normally be much higher than the host read commands figure, as the data
-needed to satisfy a single host read command may be spread across several NAND flash devices.
-
-|*NAND Read Blocks*
-|Number of 512-byte blocks requested from NAND flash devices during the reporting period.
-This figure would normally be about the same as the host read blocks figure
-
-|*Average NAND Read Size*
-|Average size of NAND read commands.
-
-|*NAND Write Commands*
-|Number of write commands issued to the NAND devices during the reporting period.
-There is no real correlation between the number of host write commands issued and the
-number of NAND Write Commands.
-
-|*NAND Write Blocks*
-|Number of 512-byte blocks written to the NAND flash devices during the reporting period.
-This figure would normally be about the same as the host write blocks figure.
-
-|*Average NAND Write Size*
-|Average size of NAND write commands. This figure should never be greater than 128K, as
-this is the maximum size write that is ever issued to a NAND device.
-
-|*NAND Read Before Write*
-|This is the number of read before write operations that were required to process
-non-aligned host write commands during the reporting period. See Host Write Odd Start
-Commands and Host Write Odd End Commands. NAND Read Before Write operations have
-a detrimental effect on the overall performance of the device.
-|===
-
-
-EXAMPLES
---------
-* Has the program issue WDC smart-add-log Vendor Unique Command with default interval (14) :
-+
-------------
-# nvme wdc smart-add-log /dev/nvme0
-------------
-
-NVME
-----
-Part of the nvme-user suite.
diff --git a/Documentation/nvme-wdc-vs-smart-add-log.txt b/Documentation/nvme-wdc-vs-smart-add-log.txt
new file mode 100644
index 0000000..a9c4ead
--- /dev/null
+++ b/Documentation/nvme-wdc-vs-smart-add-log.txt
@@ -0,0 +1,268 @@
+nvme-wdc-vs-smart-add-log(1)
+============================
+
+NAME
+----
+nvme-wdc-vs-smart-add-log - Send NVMe WDC vs-smart-add-log Vendor Unique Command, return result
+
+SYNOPSIS
+--------
+[verse]
+'nvme wdc vs-smart-add-log' <device> [--interval=<NUM>, -i <NUM>] [--output-format=<normal|json> -o <normal|json>]
+
+DESCRIPTION
+-----------
+For the NVMe device given, send a Vendor Unique WDC vs-smart-add-log command and
+provide the additional smart log. The --interval option will return performance
+statistics from the specified reporting interval.
+
+The <device> parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0).
+
+This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.
+
+On success it returns 0, error code otherwise.
+
+OPTIONS
+-------
+-i <NUM>::
+--interval=<NUM>::
+	Return the statistics from specific interval, defaults to 14
+
+-o <format>::
+--output-format=<format>::
+	Set the reporting format to 'normal', or
+	'json'. Only one output format can be used at a time.
+	Default is normal.
+
+Valid Interval values and description :-
+
+[cols="2*", frame="topbot", align="center", options="header"]
+|===
+|Value |Description
+
+|*1*
+|Most recent five (5) minute accumulated set.
+
+|*2-12*
+|Previous five (5) minute accumulated sets.
+
+|*13*
+|The accumulated total of sets 1 through 12 that contain the previous hour of
+accumulated statistics.
+
+|*14*
+|The statistical set accumulated since power-up.
+
+|*15*
+|The statistical set accumulated during the entire lifetime of the device.
+|===
+
+CA Log Page Data Output Explanation
+-----------------------------------
+[cols="2*", frame="topbot", align="center", options="header"]
+|===
+|Field |Description
+
+|*Physical NAND bytes written.*
+|The number of bytes written to NAND.  16 bytes - hi/lo
+
+|*Physical NAND bytes read*
+|The number of bytes read from NAND.  16 bytes - hi/lo
+
+|*Bad NAND Block Count*
+|Raw and normalized count of the number of NAND blocks that have been
+retired after the drives manufacturing tests (i.e. grown back blocks).
+2 bytes normalized, 6 bytes raw count
+
+|*Uncorrectable Read Error Count*
+|Total count of NAND reads that were not correctable by read retries, all
+levels of ECC, or XOR (as applicable).  8 bytes
+
+|*Soft ECC Error Count*
+|Total count of NAND reads that were not correctable by read retries, or
+first-level ECC.  8 bytes
+
+|*SSD End to End Detection Count*
+|A count of the detected errors by the SSD end to end error correction which
+includes DRAM, SRAM, or other storage element ECC/CRC protection mechanism (not
+NAND ECC).  4 bytes
+
+|*SSD End to End Correction Count*
+|A count of the corrected errors by the SSD end to end error correction which
+includes DRAM, SRAM, or other storage element ECC/CRC protection mechanism (not
+NAND ECC).  4 bytes
+
+|*System Data % Used*
+|A normalized cumulative count of the number of erase cycles per block since
+leaving the factory for the system (FW and metadata) area. Starts at 0 and
+increments. 100 indicates that the estimated endurance has been consumed.
+
+|*User Data Max Erase Count*
+|The maximum erase count across all NAND blocks in the drive.  4 bytes
+
+|*User Data Min Erase Count*
+|The minimum erase count across all NAND blocks in the drive.  4 bytes
+
+|*Refresh Count*
+|A count of the number of blocks that have been re-allocated due to
+background operations only.  8 bytes
+
+|*Program Fail Count*
+|Raw and normalized count of total program failures. Normalized count
+starts at 100 and shows the percent of remaining allowable failures.
+2 bytes normalized, 6 bytes raw count
+
+|*User Data Erase Fail Count*
+|Raw and normalized count of total erase failures in the user area.
+Normalized count starts at 100 and shows the percent of remaining
+allowable failures.  2 bytes normalized, 6 bytes raw count
+
+|*System Area Erase Fail Count*
+|Raw and normalized count of total erase failures in the system area.
+Normalized count starts at 100 and shows the percent of remaining
+allowable failures.  2 bytes normalized, 6 bytes raw count
+
+|*Thermal Throttling Status*
+|The current status of thermal throttling (enabled or disabled).
+2 bytes
+
+|*Thermal Throttling Count*
+|A count of the number of thermal throttling events.  2 bytes
+
+|*PCIe Correctable Error Count*
+|Summation counter of all PCIe correctable errors (Bad TLP, Bad
+DLLP, Receiver error, Replay timeouts, Replay rollovers).  8 bytes
+|===
+
+
+C1 Log Page Data Output Explanation
+-----------------------------------
+[cols="2*", frame="topbot", align="center", options="header"]
+|===
+|Field |Description
+
+|*Host Read Commands*
+|Number of host read commands received during the reporting period.
+
+|*Host Read Blocks*
+|Number of 512-byte blocks requested during the reporting period.
+
+|*Average Read Size*
+|Average Read size is calculated using (Host Read Blocks/Host Read Commands).
+
+|*Host Read Cache Hit Commands*
+|Number of host read commands that serviced entirely from the on-board read
+cache during the reporting period. No access to the NAND flash memory was required.
+This count is only updated if the entire command was serviced from the cache memory.
+
+|*Host Read Cache Hit Percentage*
+|Percentage of host read commands satisfied from the cache.
+
+|*Host Read Cache Hit Blocks*
+|Number of 512-byte blocks of data that have been returned for Host Read Cache Hit
+Commands during the reporting period. This count is only updated with the blocks
+returned for host read commands that were serviced entirely from cache memory.
+
+|*Average Read Cache Hit Size*
+|Average size of read commands satisfied from the cache.
+
+|*Host Read Commands Stalled*
+|Number of host read commands that were stalled due to a lack of resources within
+the SSD during the reporting period (NAND flash command queue full, low cache page count,
+cache page contention, etc.). Commands are not considered stalled if the only reason for
+the delay was waiting for the data to be physically read from the NAND flash. It is normal
+to expect this count to equal zero on heavily utilized systems.
+
+|*Host Read Commands Stalled Percentage*
+|Percentage of read commands that were stalled. If the figure is consistently high,
+then consideration should be given to spreading the data across multiple SSDs.
+
+|*Host Write Commands*
+|Number of host write commands received during the reporting period.
+
+|*Host Write Blocks*
+|Number of 512-byte blocks written during the reporting period.
+
+|*Average Write Size*
+|Average Write size calculated using (Host Write Blocks/Host Write Commands).
+
+|*Host Write Odd Start Commands*
+|Number of host write commands that started on a non-aligned boundary during
+the reporting period. The size of the boundary alignment is normally 4K; therefore
+this returns the number of commands that started on a non-4K aligned boundary.
+The SSD requires slightly more time to process non-aligned write commands than it
+does to process aligned write commands.
+
+|*Host Write Odd Start Commands Percentage*
+|Percentage of host write commands that started on a non-aligned boundary. If this
+figure is equal to or near 100%, and the NAND Read Before Write value is also high,
+then the user should investigate the possibility of offsetting the file system. For
+Microsoft Windows systems, the user can use Diskpart. For Unix-based operating systems,
+there is normally a method whereby file system partitions can be placed where required.
+
+|*Host Write Odd End Commands*
+|Number of host write commands that ended on a non-aligned boundary during the
+reporting period. The size of the boundary alignment is normally 4K; therefore this
+returns the number of commands that ended on a non-4K aligned boundary.
+
+|*Host Write Odd End Commands Percentage*
+|Percentage of host write commands that ended on a non-aligned boundary.
+
+|*Host Write Commands Stalled*
+|Number of host write commands that were stalled due to a lack of resources within the
+SSD during the reporting period. The most likely cause is that the write data was being
+received faster than it could be saved to the NAND flash memory. If there was a large
+volume of read commands being processed simultaneously, then other causes might include
+the NAND flash command queue being full, low cache page count, or cache page contention, etc.
+It is normal to expect this count to be non-zero on heavily utilized systems.
+
+|*Host Write Commands Stalled Percentage*
+|Percentage of write commands that were stalled. If the figure is consistently high, then
+consideration should be given to spreading the data across multiple SSDs.
+
+|*NAND Read Commands*
+|Number of read commands issued to the NAND devices during the reporting period.
+This figure will normally be much higher than the host read commands figure, as the data
+needed to satisfy a single host read command may be spread across several NAND flash devices.
+
+|*NAND Read Blocks*
+|Number of 512-byte blocks requested from NAND flash devices during the reporting period.
+This figure would normally be about the same as the host read blocks figure
+
+|*Average NAND Read Size*
+|Average size of NAND read commands.
+
+|*NAND Write Commands*
+|Number of write commands issued to the NAND devices during the reporting period.
+There is no real correlation between the number of host write commands issued and the
+number of NAND Write Commands.
+
+|*NAND Write Blocks*
+|Number of 512-byte blocks written to the NAND flash devices during the reporting period.
+This figure would normally be about the same as the host write blocks figure.
+
+|*Average NAND Write Size*
+|Average size of NAND write commands. This figure should never be greater than 128K, as
+this is the maximum size write that is ever issued to a NAND device.
+
+|*NAND Read Before Write*
+|This is the number of read before write operations that were required to process
+non-aligned host write commands during the reporting period. See Host Write Odd Start
+Commands and Host Write Odd End Commands. NAND Read Before Write operations have
+a detrimental effect on the overall performance of the device.
+|===
+
+
+EXAMPLES
+--------
+* Has the program issue WDC vs-smart-add-log Vendor Unique Command with default interval (14) :
++
+------------
+# nvme wdc vs-smart-add-log /dev/nvme0
+------------
+
+NVME
+----
+Part of the nvme-user suite.
diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index 5ef965d..d198571 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -52,18 +52,33 @@
 #define WDC_NVME_LOG_SIZE_HDR_LEN			0x08
 
 /* Device Config */
-#define WDC_NVME_VID  					0x1c58
-#define WDC_NVME_SN100_DEV_ID			0x0003
-#define WDC_NVME_SN200_DEV_ID			0x0023
-#define WDC_NVME_VID_2        			0x1b96
-#define WDC_NVME_SN310_DEV_ID			0x2200
-#define WDC_NVME_SN510_DEV_ID			0x2300
-
-#define WDC_NVME_SNDK_VID		        0x15b7
-#define WDC_NVME_SXSLCL_DEV_ID  		0x2001
-#define WDC_NVME_SN520_DEV_ID_1  		0x5003
-#define WDC_NVME_SN520_DEV_ID_2  		0x5005
-#define WDC_NVME_SN720_DEV_ID   		0x5002
+#define WDC_NVME_VID					0x1c58
+#define WDC_NVME_VID_2					0x1b96
+#define WDC_NVME_SNDK_VID			        0x15b7
+
+#define WDC_NVME_SN100_DEV_ID				0x0003
+#define WDC_NVME_SN200_DEV_ID				0x0023
+#define WDC_NVME_SN630_DEV_ID				0x2200
+#define WDC_NVME_SN630_DEV_ID_1				0x2201
+#define WDC_NVME_SN840_DEV_ID				0x2300
+#define WDC_NVME_SN640_DEV_ID				0x2400
+#define WDC_NVME_SN640_DEV_ID_1				0x2401
+#define WDC_NVME_SN640_DEV_ID_2				0x2402
+#define WDC_NVME_SXSLCL_DEV_ID				0x2001
+#define WDC_NVME_SN520_DEV_ID				0x5003
+#define WDC_NVME_SN520_DEV_ID_1				0x5004
+#define WDC_NVME_SN520_DEV_ID_2				0x5005
+#define WDC_NVME_SN720_DEV_ID				0x5002
+
+#define WDC_DRIVE_CAP_CAP_DIAG				0x0000000000000001
+#define WDC_DRIVE_CAP_INTERNAL_LOG			0x0000000000000002
+#define WDC_DRIVE_CAP_CA_LOG_PAGE			0x0000000000000008
+#define WDC_DRIVE_CAP_DRIVE_STATUS			0x0000000000000020
+#define WDC_DRIVE_CAP_CLEAR_ASSERT			0x0000000000000040
+#define WDC_DRIVE_CAP_CLEAR_PCIE			0x0000000000000080
+
+#define WDC_DRIVE_CAP_DRIVE_ESSENTIALS			0x0000000100000000
+#define WDC_DRIVE_CAP_DUI_DATA				0x0000000200000000
 
 /* Capture Diagnostics */
 #define WDC_NVME_CAP_DIAG_HEADER_TOC_SIZE	WDC_NVME_LOG_SIZE_DATA_LEN
@@ -323,7 +338,7 @@ static int wdc_purge(int argc, char **argv,
 static int wdc_purge_monitor(int argc, char **argv,
 		struct command *command, struct plugin *plugin);
 static int wdc_nvme_check_supported_log_page(int fd, __u8 log_id);
-static int wdc_clear_pcie_corr(int argc, char **argv, struct command *command,
+static int wdc_clear_pcie_correctable_errors(int argc, char **argv, struct command *command,
 		struct plugin *plugin);
 static int wdc_do_drive_essentials(int fd, char *dir, char *key);
 static int wdc_drive_essentials(int argc, char **argv, struct command *command,
@@ -427,17 +442,6 @@ struct __attribute__((__packed__)) wdc_ssd_ca_perf_stats {
 	__le32	rsvd2;						/* 0x7C - Reserved							*/
 };
 
-static double safe_div_fp(double numerator, double denominator)
-{
-	return denominator ? numerator / denominator : 0;
-}
-
-static double calc_percent(uint64_t numerator, uint64_t denominator)
-{
-	return denominator ?
-		(uint64_t)(((double)numerator / (double)denominator) * 100) : 0;
-}
-
 static int wdc_get_pci_ids(int *device_id, int *vendor_id)
 {
 	int fd, ret = -1;
@@ -525,40 +529,85 @@ static bool wdc_check_device(int fd)
 
 	supported = false;
 
-	/* WDC : Use PCI Vendor and Device ID's to identify WDC Devices */
-	if ((le32_to_cpu(read_vendor_id) == WDC_NVME_VID) &&
-		((le32_to_cpu(read_device_id) == WDC_NVME_SN100_DEV_ID) ||
-		(le32_to_cpu(read_device_id) == WDC_NVME_SN200_DEV_ID)))
-		supported = true;
-	else if ((le32_to_cpu(read_vendor_id) == WDC_NVME_SNDK_VID) &&
-			(le32_to_cpu(read_device_id) == WDC_NVME_SXSLCL_DEV_ID))
-		supported = true;
-	else if ((le32_to_cpu(read_vendor_id) == WDC_NVME_VID_2) &&
-			((le32_to_cpu(read_device_id) == WDC_NVME_SN310_DEV_ID) ||
-			 (le32_to_cpu(read_device_id) == WDC_NVME_SN510_DEV_ID)))
+	if ((le32_to_cpu(read_vendor_id) == WDC_NVME_VID) ||
+			(le32_to_cpu(read_vendor_id) == WDC_NVME_VID_2) ||
+			(le32_to_cpu(read_vendor_id) == WDC_NVME_SNDK_VID))
 		supported = true;
 	else
-		fprintf(stderr, "WARNING : WDC not supported, Vendor ID = 0x%x, Device ID = 0x%x\n",
+		fprintf(stderr, "ERROR : WDC: unsupported WDC device, Vendor ID = 0x%x, Device ID = 0x%x\n",
 				le32_to_cpu(read_vendor_id), le32_to_cpu(read_device_id));
 
 	return supported;
 }
 
-static bool wdc_check_device_match(int fd, int vendor_id, int device_id)
-{
+static __u64 wdc_get_drive_capabilities(int fd) {
 	int ret;
 	int read_device_id, read_vendor_id;
+	__u64 capabilities = 0;
 
 	ret = wdc_get_pci_ids((int *)&read_device_id, (int *)&read_vendor_id);
 	if (ret < 0)
-		return false;
+		return capabilities;
 
-	/* WDC : Use PCI Vendor and Device ID's to identify WDC Devices */
-	if ((le32_to_cpu(read_vendor_id) == vendor_id) &&
-		(le32_to_cpu(read_device_id) == device_id))
-		return true;
-	else
-		return false;
+	switch (read_vendor_id) {
+	case WDC_NVME_VID:
+		switch (read_device_id) {
+		case WDC_NVME_SN100_DEV_ID:
+			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG);
+			break;
+		case WDC_NVME_SN200_DEV_ID:
+			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG |
+					WDC_DRIVE_CAP_CA_LOG_PAGE);
+			break;
+		default:
+			capabilities = 0;
+		}
+		break;
+	case WDC_NVME_VID_2:
+		switch (read_device_id) {
+		case WDC_NVME_SN630_DEV_ID:
+		/* FALLTHRU */
+		case WDC_NVME_SN630_DEV_ID_1:
+		/* FALLTHRU */
+		case WDC_NVME_SN640_DEV_ID:
+		/* FALLTHRU */
+		case WDC_NVME_SN640_DEV_ID_1:
+		/* FALLTHRU */
+		case WDC_NVME_SN640_DEV_ID_2:
+		/* FALLTHRU */
+		case WDC_NVME_SN840_DEV_ID:
+			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG |
+					WDC_DRIVE_CAP_CA_LOG_PAGE | WDC_DRIVE_CAP_DRIVE_STATUS |
+					WDC_DRIVE_CAP_CLEAR_ASSERT);
+			break;
+		default:
+			capabilities = 0;
+		}
+		break;
+	case WDC_NVME_SNDK_VID:
+		switch (read_device_id) {
+		case WDC_NVME_SXSLCL_DEV_ID:
+			capabilities = WDC_DRIVE_CAP_DRIVE_ESSENTIALS;
+			break;
+		case WDC_NVME_SN520_DEV_ID:
+		/* FALLTHRU */
+		case WDC_NVME_SN520_DEV_ID_1:
+		/* FALLTHRU */
+		case WDC_NVME_SN520_DEV_ID_2:
+		/* FALLTHRU */
+		case WDC_NVME_SN720_DEV_ID:
+			capabilities = WDC_DRIVE_CAP_DUI_DATA;
+			break;
+		default:
+			capabilities = 0;
+		}
+
+		break;
+	default:
+		capabilities = 0;
+	}
+
+	return capabilities;
 }
 
 static int wdc_get_serial_name(int fd, char *file, size_t len, const char *suffix)
@@ -585,12 +634,11 @@ static int wdc_get_serial_name(int fd, char *file, size_t len, const char *suffi
 		ctrl.sn[i] = '\0';
 		i--;
 	}
-
 	if (ctrl.sn[sizeof (ctrl.sn) - 1] == '\0') {
 		ctrl_sn_len = strlen(ctrl.sn);
 	}
 
-	res_len = snprintf(file, len, "%s%.*s%s.bin", orig, ctrl_sn_len, ctrl.sn, suffix);
+	res_len = snprintf(file, len, "%s%.*s%s", orig, ctrl_sn_len, ctrl.sn, suffix);
 	if (len <= res_len) {
 		fprintf(stderr, "ERROR : WDC : cannot format serial number due to data "
 				"of unexpected length\n");
@@ -957,6 +1005,7 @@ static int wdc_cap_diag(int argc, char **argv, struct command *command,
 	char f[PATH_MAX] = {0};
 	__u32 xfer_size = 0;
 	int fd;
+	__u64 capabilities = 0;
 
 	struct config {
 		char *file;
@@ -969,10 +1018,10 @@ static int wdc_cap_diag(int argc, char **argv, struct command *command,
 	};
 
 	const struct argconfig_commandline_options command_line_options[] = {
-		{"output-file", 'o', "FILE", CFG_STRING, &cfg.file, required_argument, file},
-		{"transfer-size", 's', "NUM", CFG_POSITIVE, &cfg.xfer_size, required_argument, size},
-		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc},
-		{NULL}
+			{"output-file", 'o', "FILE", CFG_STRING, &cfg.file, required_argument, file},
+			{"transfer-size", 's', "NUM", CFG_POSITIVE, &cfg.xfer_size, required_argument, size},
+			{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc},
+			{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
@@ -990,19 +1039,17 @@ static int wdc_cap_diag(int argc, char **argv, struct command *command,
 		return -1;
 	}
 
-	if (wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN100_DEV_ID) ||
-		wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN200_DEV_ID) ||
-		wdc_check_device_match(fd, WDC_NVME_VID_2, WDC_NVME_SN310_DEV_ID) ||
-		wdc_check_device_match(fd, WDC_NVME_VID_2, WDC_NVME_SN510_DEV_ID)) {
+	capabilities = wdc_get_drive_capabilities(fd);
+	if ((capabilities & WDC_DRIVE_CAP_CAP_DIAG) == WDC_DRIVE_CAP_CAP_DIAG) {
+		snprintf(f + strlen(f), PATH_MAX, "%s", ".bin");
 		return wdc_do_cap_diag(fd, f, xfer_size);
-	} else {
-		fprintf(stderr, "ERROR : WDC: unsupported device for cap-diag command\n");
-	}
+	} else
+		fprintf(stderr, "ERROR : WDC: unsupported device for this command\n");
 
 	return 0;
 }
 
-static int wdc_internal_fw_log(int argc, char **argv, struct command *command,
+static int wdc_vs_internal_fw_log(int argc, char **argv, struct command *command,
                struct plugin *plugin)
 {
 	char *desc = "Internal Firmware Log.";
@@ -1014,6 +1061,7 @@ static int wdc_internal_fw_log(int argc, char **argv, struct command *command,
 	int fd;
 	UtilsTimeInfo             timeInfo;
 	__u8                      timeStamp[MAX_PATH_LEN];
+	__u64 capabilities = 0;
 
 	struct config {
 		char *file;
@@ -1036,6 +1084,8 @@ static int wdc_internal_fw_log(int argc, char **argv, struct command *command,
 	if (fd < 0)
 		return fd;
 
+	if (!wdc_check_device(fd))
+		return -1;
 	if (cfg.xfer_size != 0) {
 		xfer_size = cfg.xfer_size;
 	}
@@ -1057,13 +1107,12 @@ static int wdc_internal_fw_log(int argc, char **argv, struct command *command,
 	}
 	fprintf(stderr, "%s: filename = %s\n", __func__, f);
 
-	if (wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN100_DEV_ID) ||
-		wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN200_DEV_ID) ||
-		wdc_check_device_match(fd, WDC_NVME_VID_2, WDC_NVME_SN310_DEV_ID) ||
-		wdc_check_device_match(fd, WDC_NVME_VID_2, WDC_NVME_SN510_DEV_ID)) {
+	capabilities = wdc_get_drive_capabilities(fd);
+	if ((capabilities & WDC_DRIVE_CAP_INTERNAL_LOG) == WDC_DRIVE_CAP_INTERNAL_LOG) {
+		snprintf(f + strlen(f), PATH_MAX, "%s", ".bin");
 		return wdc_do_cap_diag(fd, f, xfer_size);
 	} else {
-		fprintf(stderr, "ERROR : WDC: unsupported device for internal_fw_log command\n");
+		fprintf(stderr, "ERROR : WDC: unsupported device for this command\n");
 		return -1;
 	}
 }
@@ -1226,7 +1275,8 @@ static int wdc_drive_log(int argc, char **argv, struct command *command,
 	if (fd < 0)
 		return fd;
 
-	wdc_check_device(fd);
+	if (!wdc_check_device(fd))
+		return -1;
 	if (cfg.file != NULL) {
 		strncpy(f, cfg.file, PATH_MAX - 1);
 	}
@@ -1243,6 +1293,7 @@ static int wdc_get_crash_dump(int argc, char **argv, struct command *command,
 	const char *desc = "Get Crash Dump.";
 	const char *file = "Output file pathname.";
 	int fd;
+	int ret;
 	struct config {
 		char *file;
 	};
@@ -1261,21 +1312,22 @@ static int wdc_get_crash_dump(int argc, char **argv, struct command *command,
 	if (fd < 0)
 		return fd;
 
-	if (wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN100_DEV_ID) ||
-		wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN200_DEV_ID) ) {
-		return wdc_crash_dump(fd, cfg.file, WDC_NVME_CRASH_DUMP_TYPE);
-	} else {
-		fprintf(stderr, "ERROR : WDC: unsupported device for get-crash-dump command\n");
+	if (!wdc_check_device(fd))
 		return -1;
+	ret = wdc_crash_dump(fd, cfg.file, WDC_NVME_CRASH_DUMP_TYPE);
+	if (ret != 0) {
+		fprintf(stderr, "ERROR : WDC : failed to read crash dump\n");
 	}
+	return ret;
 }
 
 static int wdc_get_pfail_dump(int argc, char **argv, struct command *command,
-	struct plugin *plugin)
+		struct plugin *plugin)
 {
 	char *desc = "Get Pfail Crash Dump.";
 	char *file = "Output file pathname.";
 	int fd;
+	int ret;
 	struct config {
 		char *file;
 	};
@@ -1294,13 +1346,13 @@ static int wdc_get_pfail_dump(int argc, char **argv, struct command *command,
 	if (fd < 0)
 		return fd;
 
-	if (wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN100_DEV_ID) ||
-		wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN200_DEV_ID) ) {
-		return wdc_crash_dump(fd, cfg.file, WDC_NVME_PFAIL_DUMP_TYPE);
-	} else {
-		fprintf(stderr, "ERROR : WDC: unsupported device for get-pfail-dump command\n");
+	if (!wdc_check_device(fd))
 		return -1;
+	ret = wdc_crash_dump(fd, cfg.file, WDC_NVME_PFAIL_DUMP_TYPE);
+	if (ret != 0) {
+		fprintf(stderr, "ERROR : WDC : failed to read pfail crash dump\n");
 	}
+	return ret;
 }
 
 static void wdc_do_id_ctrl(__u8 *vs, struct json_object *root)
@@ -1372,7 +1424,8 @@ static int wdc_purge(int argc, char **argv,
 	if (fd < 0)
 		return fd;
 
-	wdc_check_device(fd);
+	if (!wdc_check_device(fd))
+		return -1;
 	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
 	if (ret > 0) {
 		switch (ret) {
@@ -1419,7 +1472,8 @@ static int wdc_purge_monitor(int argc, char **argv,
 	if (fd < 0)
 		return fd;
 
-	wdc_check_device(fd);
+	if (!wdc_check_device(fd))
+		return -1;
 	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
 	if (ret == 0) {
 		mon = (struct wdc_nvme_purge_monitor_data *) output;
@@ -1436,136 +1490,6 @@ static int wdc_purge_monitor(int argc, char **argv,
 	return ret;
 }
 
-static void wdc_print_log_normal(struct wdc_ssd_perf_stats *perf)
-{
-	printf("  C1 Log Page Performance Statistics :- \n");
-	printf("  Host Read Commands                             %20"PRIu64"\n",
-			(uint64_t)le64_to_cpu(perf->hr_cmds));
-	printf("  Host Read Blocks                               %20"PRIu64"\n",
-			(uint64_t)le64_to_cpu(perf->hr_blks));
-	printf("  Average Read Size                              %20lf\n",
-			safe_div_fp((le64_to_cpu(perf->hr_blks)), (le64_to_cpu(perf->hr_cmds))));
-	printf("  Host Read Cache Hit Commands                   %20"PRIu64"\n",
-			(uint64_t)le64_to_cpu(perf->hr_ch_cmds));
-	printf("  Host Read Cache Hit_Percentage                 %20"PRIu64"%%\n",
-			(uint64_t) calc_percent(le64_to_cpu(perf->hr_ch_cmds), le64_to_cpu(perf->hr_cmds)));
-	printf("  Host Read Cache Hit Blocks                     %20"PRIu64"\n",
-			(uint64_t)le64_to_cpu(perf->hr_ch_blks));
-	printf("  Average Read Cache Hit Size                    %20f\n",
-			safe_div_fp((le64_to_cpu(perf->hr_ch_blks)), (le64_to_cpu(perf->hr_ch_cmds))));
-	printf("  Host Read Commands Stalled                     %20"PRIu64"\n",
-			(uint64_t)le64_to_cpu(perf->hr_st_cmds));
-	printf("  Host Read Commands Stalled Percentage          %20"PRIu64"%%\n",
-			(uint64_t)calc_percent((le64_to_cpu(perf->hr_st_cmds)), le64_to_cpu(perf->hr_cmds)));
-	printf("  Host Write Commands                            %20"PRIu64"\n",
-			(uint64_t)le64_to_cpu(perf->hw_cmds));
-	printf("  Host Write Blocks                              %20"PRIu64"\n",
-			(uint64_t)le64_to_cpu(perf->hw_blks));
-	printf("  Average Write Size                             %20f\n",
-			safe_div_fp((le64_to_cpu(perf->hw_blks)), (le64_to_cpu(perf->hw_cmds))));
-	printf("  Host Write Odd Start Commands                  %20"PRIu64"\n",
-			(uint64_t)le64_to_cpu(perf->hw_os_cmds));
-	printf("  Host Write Odd Start Commands Percentage       %20"PRIu64"%%\n",
-			(uint64_t)calc_percent((le64_to_cpu(perf->hw_os_cmds)), (le64_to_cpu(perf->hw_cmds))));
-	printf("  Host Write Odd End Commands                    %20"PRIu64"\n",
-			(uint64_t)le64_to_cpu(perf->hw_oe_cmds));
-	printf("  Host Write Odd End Commands Percentage         %20"PRIu64"%%\n",
-			(uint64_t)calc_percent((le64_to_cpu(perf->hw_oe_cmds)), (le64_to_cpu((perf->hw_cmds)))));
-	printf("  Host Write Commands Stalled                    %20"PRIu64"\n",
-		(uint64_t)le64_to_cpu(perf->hw_st_cmds));
-	printf("  Host Write Commands Stalled Percentage         %20"PRIu64"%%\n",
-		(uint64_t)calc_percent((le64_to_cpu(perf->hw_st_cmds)), (le64_to_cpu(perf->hw_cmds))));
-	printf("  NAND Read Commands                             %20"PRIu64"\n",
-		(uint64_t)le64_to_cpu(perf->nr_cmds));
-	printf("  NAND Read Blocks Commands                      %20"PRIu64"\n",
-		(uint64_t)le64_to_cpu(perf->nr_blks));
-	printf("  Average NAND Read Size                         %20f\n",
-		safe_div_fp((le64_to_cpu(perf->nr_blks)), (le64_to_cpu((perf->nr_cmds)))));
-	printf("  Nand Write Commands                            %20"PRIu64"\n",
-			(uint64_t)le64_to_cpu(perf->nw_cmds));
-	printf("  NAND Write Blocks                              %20"PRIu64"\n",
-			(uint64_t)le64_to_cpu(perf->nw_blks));
-	printf("  Average NAND Write Size                        %20f\n",
-			safe_div_fp((le64_to_cpu(perf->nw_blks)), (le64_to_cpu(perf->nw_cmds))));
-	printf("  NAND Read Before Write                         %20"PRIu64"\n",
-			(uint64_t)le64_to_cpu(perf->nrbw));
-}
-
-static void wdc_print_log_json(struct wdc_ssd_perf_stats *perf)
-{
-	struct json_object *root;
-
-	root = json_create_object();
-	json_object_add_value_int(root, "Host Read Commands", le64_to_cpu(perf->hr_cmds));
-	json_object_add_value_int(root, "Host Read Blocks", le64_to_cpu(perf->hr_blks));
-	json_object_add_value_int(root, "Average Read Size",
-			safe_div_fp((le64_to_cpu(perf->hr_blks)), (le64_to_cpu(perf->hr_cmds))));
-	json_object_add_value_int(root, "Host Read Cache Hit Commands",
-			(uint64_t)le64_to_cpu(perf->hr_ch_cmds));
-	json_object_add_value_int(root, "Host Read Cache Hit Percentage",
-			(uint64_t) calc_percent(le64_to_cpu(perf->hr_ch_cmds), le64_to_cpu(perf->hr_cmds)));
-	json_object_add_value_int(root, "Host Read Cache Hit Blocks",
-			(uint64_t)le64_to_cpu(perf->hr_ch_blks));
-	json_object_add_value_int(root, "Average Read Cache Hit Size",
-			safe_div_fp((le64_to_cpu(perf->hr_ch_blks)), (le64_to_cpu(perf->hr_ch_cmds))));
-	json_object_add_value_int(root, "Host Read Commands Stalled",
-			(uint64_t)le64_to_cpu(perf->hr_st_cmds));
-	json_object_add_value_int(root, "Host Read Commands Stalled Percentage",
-			(uint64_t)calc_percent((le64_to_cpu(perf->hr_st_cmds)), le64_to_cpu(perf->hr_cmds)));
-	json_object_add_value_int(root, "Host Write Commands",
-			(uint64_t)le64_to_cpu(perf->hw_cmds));
-	json_object_add_value_int(root, "Host Write Blocks",
-			(uint64_t)le64_to_cpu(perf->hw_blks));
-	json_object_add_value_int(root, "Average Write Size",
-			safe_div_fp((le64_to_cpu(perf->hw_blks)), (le64_to_cpu(perf->hw_cmds))));
-	json_object_add_value_int(root, "Host Write Odd Start Commands",
-			(uint64_t)le64_to_cpu(perf->hw_os_cmds));
-	json_object_add_value_int(root, "Host Write Odd Start Commands Percentage",
-			(uint64_t)calc_percent((le64_to_cpu(perf->hw_os_cmds)), (le64_to_cpu(perf->hw_cmds))));
-	json_object_add_value_int(root, "Host Write Odd End Commands",
-			(uint64_t)le64_to_cpu(perf->hw_oe_cmds));
-	json_object_add_value_int(root, "Host Write Odd End Commands Percentage",
-			(uint64_t)calc_percent((le64_to_cpu(perf->hw_oe_cmds)), (le64_to_cpu((perf->hw_cmds)))));
-	json_object_add_value_int(root, "Host Write Commands Stalled",
-		(uint64_t)le64_to_cpu(perf->hw_st_cmds));
-	json_object_add_value_int(root, "Host Write Commands Stalled Percentage",
-		(uint64_t)calc_percent((le64_to_cpu(perf->hw_st_cmds)), (le64_to_cpu(perf->hw_cmds))));
-	json_object_add_value_int(root, "NAND Read Commands",
-		(uint64_t)le64_to_cpu(perf->nr_cmds));
-	json_object_add_value_int(root, "NAND Read Blocks Commands",
-		(uint64_t)le64_to_cpu(perf->nr_blks));
-	json_object_add_value_int(root, "Average NAND Read Size",
-		safe_div_fp((le64_to_cpu(perf->nr_blks)), (le64_to_cpu((perf->nr_cmds)))));
-	json_object_add_value_int(root, "Nand Write Commands",
-			(uint64_t)le64_to_cpu(perf->nw_cmds));
-	json_object_add_value_int(root, "NAND Write Blocks",
-			(uint64_t)le64_to_cpu(perf->nw_blks));
-	json_object_add_value_int(root, "Average NAND Write Size",
-			safe_div_fp((le64_to_cpu(perf->nw_blks)), (le64_to_cpu(perf->nw_cmds))));
-	json_object_add_value_int(root, "NAND Read Before Written",
-			(uint64_t)le64_to_cpu(perf->nrbw));
-	json_print_object(root, NULL);
-	printf("\n");
-	json_free_object(root);
-}
-
-static int wdc_print_log(struct wdc_ssd_perf_stats *perf, int fmt)
-{
-	if (!perf) {
-		fprintf(stderr, "ERROR : WDC : Invalid buffer to read perf stats\n");
-		return -1;
-	}
-	switch (fmt) {
-	case NORMAL:
-		wdc_print_log_normal(perf);
-		break;
-	case JSON:
-		wdc_print_log_json(perf);
-		break;
-	}
-	return 0;
-}
-
 static void wdc_print_ca_log_normal(struct wdc_ssd_ca_perf_stats *perf)
 {
 	uint64_t converted = 0;
@@ -1709,7 +1633,8 @@ static int wdc_get_ca_log_page(int fd, char *format)
 	struct wdc_ssd_ca_perf_stats *perf;
 
 
-	wdc_check_device(fd);
+	if (!wdc_check_device(fd))
+		return -1;
 	fmt = validate_output_format(format);
 	if (fmt < 0) {
 		fprintf(stderr, "ERROR : WDC : invalid output format\n");
@@ -1746,70 +1671,14 @@ static int wdc_get_ca_log_page(int fd, char *format)
 	return ret;
 }
 
-static int wdc_get_c1_log_page(int fd, char *format, uint8_t interval)
-{
-	int ret = 0;
-	int fmt = -1;
-	__u8 *data;
-	__u8 *p;
-	int i;
-	int skip_cnt = 4;
-	int total_subpages;
-	struct wdc_log_page_header *l;
-	struct wdc_log_page_subpage_header *sph;
-	struct wdc_ssd_perf_stats *perf;
-
-	wdc_check_device(fd);
-	fmt = validate_output_format(format);
-	if (fmt < 0) {
-		fprintf(stderr, "ERROR : WDC : invalid output format\n");
-		return fmt;
-	}
-
-	if (interval < 1 || interval > 15) {
-		fprintf(stderr, "ERROR : WDC : interval out of range [1-15]\n");
-		return -1;
-	}
-
-	if ((data = (__u8*) malloc(sizeof (__u8) * WDC_ADD_LOG_BUF_LEN)) == NULL) {
-		fprintf(stderr, "ERROR : WDC : malloc : %s\n", strerror(errno));
-		return -1;
-	}
-	memset(data, 0, sizeof (__u8) * WDC_ADD_LOG_BUF_LEN);
-
-	ret = nvme_get_log(fd, 0x01, WDC_NVME_ADD_LOG_OPCODE,
-			   false, WDC_ADD_LOG_BUF_LEN, data);
-	if (strcmp(format, "json"))
-		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
-	if (ret == 0) {
-		l = (struct wdc_log_page_header*)data;
-		total_subpages = l->num_subpages + WDC_NVME_GET_STAT_PERF_INTERVAL_LIFETIME - 1;
-		for (i = 0, p = data + skip_cnt; i < total_subpages; i++, p += skip_cnt) {
-			sph = (struct wdc_log_page_subpage_header *) p;
-			if (sph->spcode == WDC_GET_LOG_PAGE_SSD_PERFORMANCE) {
-				if (sph->pcset == interval) {
-					perf = (struct wdc_ssd_perf_stats *) (p + 4);
-					ret = wdc_print_log(perf, fmt);
-					break;
-				}
-			}
-			skip_cnt = le32_to_cpu(sph->subpage_length) + 4;
-		}
-		if (ret) {
-			fprintf(stderr, "ERROR : WDC : Unable to read data from buffer\n");
-		}
-	}
-	free(data);
-	return ret;
-}
-
-static int wdc_smart_add_log(int argc, char **argv, struct command *command,
+static int wdc_vs_smart_add_log(int argc, char **argv, struct command *command,
 		struct plugin *plugin)
 {
 	const char *desc = "Retrieve additional performance statistics.";
 	const char *interval = "Interval to read the statistics from [1, 15].";
 	int fd;
 	int ret;
+	__u64 capabilities = 0;
 
 	struct config {
 		uint8_t interval;
@@ -1832,38 +1701,20 @@ static int wdc_smart_add_log(int argc, char **argv, struct command *command,
 	if (fd < 0)
 		return fd;
 
-
-	if (wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN100_DEV_ID)) {
-		// Get the C1 Log Page
-		ret = wdc_get_c1_log_page(fd, cfg.output_format, cfg.interval);
-
-		if (ret) {
-			fprintf(stderr, "ERROR : WDC : Unable to read C1 Log Page data from buffer\n");
-			return ret;
-		}
-	}
-	else if (wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN200_DEV_ID)) {
-		// Get the CA and C1 Log Page
+	capabilities = wdc_get_drive_capabilities(fd);
+	if ((capabilities & (WDC_DRIVE_CAP_CA_LOG_PAGE)) == (WDC_DRIVE_CAP_CA_LOG_PAGE)) {
+		// Get the CA Log Page
 		ret = wdc_get_ca_log_page(fd, cfg.output_format);
 		if (ret) {
-			fprintf(stderr, "ERROR : WDC : Unable to read CA Log Page data from buffer\n");
+			fprintf(stderr, "ERROR : WDC : Unable to read CA Log Page\n");
 			return ret;
 		}
-
-		ret = wdc_get_c1_log_page(fd, cfg.output_format, cfg.interval);
-		if (ret) {
-			fprintf(stderr, "ERROR : WDC : Unable to read C1 Log Page data from buffer\n");
-			return ret;
-		}
-	}
-	else {
-		fprintf(stderr, "INFO : WDC : Command not supported in this device\n");
-	}
-
+	} else
+		fprintf(stderr, "ERROR : WDC: unsupported device for this command\n");
 	return 0;
 }
 
-static int wdc_clear_pcie_corr(int argc, char **argv, struct command *command,
+static int wdc_clear_pcie_correctable_errors(int argc, char **argv, struct command *command,
 		struct plugin *plugin)
 {
 	char *desc = "Clear PCIE Correctable Errors.";
@@ -1879,7 +1730,8 @@ static int wdc_clear_pcie_corr(int argc, char **argv, struct command *command,
 	if (fd < 0)
 		return fd;
 
-	wdc_check_device(fd);
+	if (!wdc_check_device(fd))
+		return -1;
 
 	memset(&admin_cmd, 0, sizeof (admin_cmd));
 	admin_cmd.opcode = WDC_NVME_CLEAR_PCIE_CORR_OPCODE;
@@ -2610,13 +2462,15 @@ static int wdc_drive_essentials(int argc, char **argv, struct command *command,
 			{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc},
 			{NULL}
 	};
+	__u64 capabilities = 0;
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
 	if (fd < 0)
 		return fd;
 
-	if (!wdc_check_device_match(fd, WDC_NVME_SNDK_VID, WDC_NVME_SXSLCL_DEV_ID)) {
-		fprintf(stderr, "WARNING : WDC : Device not supported\n");
+	capabilities = wdc_get_drive_capabilities(fd);
+	if ((capabilities & WDC_DRIVE_CAP_DRIVE_ESSENTIALS) != WDC_DRIVE_CAP_DRIVE_ESSENTIALS) {
+		fprintf(stderr, "ERROR : WDC: unsupported device for this command\n");
 		return -1;
 	}
 
diff --git a/plugins/wdc/wdc-nvme.h b/plugins/wdc/wdc-nvme.h
index c2d892b..4fcc33b 100644
--- a/plugins/wdc/wdc-nvme.h
+++ b/plugins/wdc/wdc-nvme.h
@@ -15,9 +15,9 @@ PLUGIN(NAME("wdc", "Western Digital vendor specific extensions"),
 		ENTRY("id-ctrl", "WDC identify controller", wdc_id_ctrl)
 		ENTRY("purge", "WDC Purge", wdc_purge)
 		ENTRY("purge-monitor", "WDC Purge Monitor", wdc_purge_monitor)
-		ENTRY("vs-internal-log", "WDC Internal Firmware Log", wdc_internal_fw_log)
-		ENTRY("smart-add-log", "WDC Additional Smart Log", wdc_smart_add_log)
-		ENTRY("clear-pcie-corr", "WDC Clear PCIe Correctable Error Count", wdc_clear_pcie_corr)
+		ENTRY("vs-internal-log", "WDC Internal Firmware Log", wdc_vs_internal_fw_log)
+		ENTRY("vs-smart-add-log", "WDC Additional Smart Log", wdc_vs_smart_add_log)
+		ENTRY("clear-pcie-correctable-errors", "WDC Clear PCIe Correctable Error Count", wdc_clear_pcie_correctable_errors)
 		ENTRY("drive-essentials", "WDC Drive Essentials", wdc_drive_essentials)
 	)
 );
-- 
2.7.4
