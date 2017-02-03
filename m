From: scott.bauer@intel.com (Scott Bauer)
Date: Fri,  3 Feb 2017 12:50:31 -0700
Subject: [PATCH v6 2/3] block: Add Sed-opal library
In-Reply-To: <1486151432-3431-1-git-send-email-scott.bauer@intel.com>
References: <1486151432-3431-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1486151432-3431-3-git-send-email-scott.bauer@intel.com>

This patch implements the necessary logic to bring an Opal
enabled drive out of a factory-enabled into a working
Opal state.

This patch set also enables logic to save a password to
be replayed during a resume from suspend.

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli at intel.com>
---
 MAINTAINERS              |   11 +
 block/Kconfig            |    7 +
 block/Makefile           |    1 +
 block/opal_proto.h       |  429 ++++++++
 block/sed-opal.c         | 2448 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sed-opal.h |  178 ++++
 6 files changed, 3074 insertions(+)
 create mode 100644 block/opal_proto.h
 create mode 100644 block/sed-opal.c
 create mode 100644 include/linux/sed-opal.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a3c419..c3bdd43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11090,6 +11090,17 @@ L:	linux-mmc at vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-spear.c
 
+SECURE ENCRYPTING DEVICE (SED) OPAL DRIVER
+M:	Scott Bauer <scott.bauer at intel.com>
+M:	Jonathan Derrick <jonathan.derrick at intel.com>
+M:	Rafael Antognolli <rafael.antognolli at intel.com>
+L:	linux-nvme at lists.infradead.org
+S:	Supported
+F:	block/sed*
+F:	block/opal_proto.h
+F:	include/linux/sed*
+F:	include/uapi/linux/sed*
+
 SECURITY SUBSYSTEM
 M:	James Morris <james.l.morris at oracle.com>
 M:	"Serge E. Hallyn" <serge at hallyn.com>
diff --git a/block/Kconfig b/block/Kconfig
index b97d7f6..a2a92e5 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -164,6 +164,13 @@ config BLK_DEBUG_FS
 	Unless you are building a kernel for a tiny system, you should
 	say Y here.
 
+config BLK_SED_OPAL
+	bool "Logic for interfacing with Opal enabled SEDs"
+	---help---
+	Builds Logic for interfacing with Opal enabled controllers.
+	Enabling this option enables users to setup/unlock/lock
+	Locking ranges for SED devices using the Opal protocol.
+
 menu "Partition Types"
 
 source "block/partitions/Kconfig"
diff --git a/block/Makefile b/block/Makefile
index 38f26ca..2ad7c30 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_BLK_MQ_PCI)	+= blk-mq-pci.o
 obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
 obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
 obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
+obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
diff --git a/block/opal_proto.h b/block/opal_proto.h
new file mode 100644
index 0000000..af9abc5
--- /dev/null
+++ b/block/opal_proto.h
@@ -0,0 +1,429 @@
+/*
+ * Copyright ? 2016 Intel Corporation
+ *
+ * Authors:
+ *    Rafael Antognolli <rafael.antognolli at intel.com>
+ *    Scott  Bauer      <scott.bauer at intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+#include <linux/types.h>
+
+#ifndef _OPAL_PROTO_H
+#define _OPAL_PROTO_H
+
+#define DTAERROR_NO_METHOD_STATUS 0x89
+#define GENERIC_HOST_SESSION_NUM 0x41
+
+#define TPER_SYNC_SUPPORTED 0x01
+
+#define TINY_ATOM_DATA_MASK 0x3F
+#define TINY_ATOM_SIGNED 0x40
+
+#define SHORT_ATOM_ID 0x80
+#define SHORT_ATOM_BYTESTRING 0x20
+#define SHORT_ATOM_SIGNED 0x10
+#define SHORT_ATOM_LEN_MASK 0xF
+
+#define MEDIUM_ATOM_ID 0xC0
+#define MEDIUM_ATOM_BYTESTRING 0x10
+#define MEDIUM_ATOM_SIGNED 0x8
+#define MEDIUM_ATOM_LEN_MASK 0x7
+
+#define LONG_ATOM_ID 0xe0
+#define LONG_ATOM_BYTESTRING 0x2
+#define LONG_ATOM_SIGNED 0x1
+
+/* Derived from TCG Core spec 2.01 Section:
+ * 3.2.2.1
+ * Data Type
+ */
+#define TINY_ATOM_BYTE   0x7F
+#define SHORT_ATOM_BYTE  0xBF
+#define MEDIUM_ATOM_BYTE 0xDF
+#define LONG_ATOM_BYTE   0xE3
+
+#define OPAL_INVAL_PARAM 12
+#define OPAL_MANUFACTURED_INACTIVE 0x08
+#define OPAL_DISCOVERY_COMID 0x0001
+
+#define LOCKING_RANGE_NON_GLOBAL 0x03
+/*
+ * User IDs used in the TCG storage SSCs
+ * Derived from: TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
+ * Section: 6.3 Assigned UIDs
+ */
+#define OPAL_UID_LENGTH 8
+#define OPAL_METHOD_LENGTH 8
+#define OPAL_MSID_KEYLEN 15
+#define OPAL_UID_LENGTH_HALF 4
+
+/* Enum to index OPALUID array */
+enum opal_uid {
+	/* users */
+	OPAL_SMUID_UID,
+	OPAL_THISSP_UID,
+	OPAL_ADMINSP_UID,
+	OPAL_LOCKINGSP_UID,
+	OPAL_ENTERPRISE_LOCKINGSP_UID,
+	OPAL_ANYBODY_UID,
+	OPAL_SID_UID,
+	OPAL_ADMIN1_UID,
+	OPAL_USER1_UID,
+	OPAL_USER2_UID,
+	OPAL_PSID_UID,
+	OPAL_ENTERPRISE_BANDMASTER0_UID,
+	OPAL_ENTERPRISE_ERASEMASTER_UID,
+	/* tables */
+	OPAL_LOCKINGRANGE_GLOBAL,
+	OPAL_LOCKINGRANGE_ACE_RDLOCKED,
+	OPAL_LOCKINGRANGE_ACE_WRLOCKED,
+	OPAL_MBRCONTROL,
+	OPAL_MBR,
+	OPAL_AUTHORITY_TABLE,
+	OPAL_C_PIN_TABLE,
+	OPAL_LOCKING_INFO_TABLE,
+	OPAL_ENTERPRISE_LOCKING_INFO_TABLE,
+	/* C_PIN_TABLE object ID's */
+	OPAL_C_PIN_MSID,
+	OPAL_C_PIN_SID,
+	OPAL_C_PIN_ADMIN1,
+	/* half UID's (only first 4 bytes used) */
+	OPAL_HALF_UID_AUTHORITY_OBJ_REF,
+	OPAL_HALF_UID_BOOLEAN_ACE,
+	/* omitted optional parameter */
+	OPAL_UID_HEXFF,
+};
+
+#define OPAL_METHOD_LENGTH 8
+
+/* Enum for indexing the OPALMETHOD array */
+enum opal_method {
+	OPAL_PROPERTIES,
+	OPAL_STARTSESSION,
+	OPAL_REVERT,
+	OPAL_ACTIVATE,
+	OPAL_EGET,
+	OPAL_ESET,
+	OPAL_NEXT,
+	OPAL_EAUTHENTICATE,
+	OPAL_GETACL,
+	OPAL_GENKEY,
+	OPAL_REVERTSP,
+	OPAL_GET,
+	OPAL_SET,
+	OPAL_AUTHENTICATE,
+	OPAL_RANDOM,
+	OPAL_ERASE,
+};
+
+enum opal_token {
+	/* Boolean */
+	OPAL_TRUE = 0x01,
+	OPAL_FALSE = 0x00,
+	OPAL_BOOLEAN_EXPR = 0x03,
+	/* cellblocks */
+	OPAL_TABLE = 0x00,
+	OPAL_STARTROW = 0x01,
+	OPAL_ENDROW = 0x02,
+	OPAL_STARTCOLUMN = 0x03,
+	OPAL_ENDCOLUMN = 0x04,
+	OPAL_VALUES = 0x01,
+	/* authority table */
+	OPAL_PIN = 0x03,
+	/* locking tokens */
+	OPAL_RANGESTART = 0x03,
+	OPAL_RANGELENGTH = 0x04,
+	OPAL_READLOCKENABLED = 0x05,
+	OPAL_WRITELOCKENABLED = 0x06,
+	OPAL_READLOCKED = 0x07,
+	OPAL_WRITELOCKED = 0x08,
+	OPAL_ACTIVEKEY = 0x0A,
+	/* locking info table */
+	OPAL_MAXRANGES = 0x04,
+	 /* mbr control */
+	OPAL_MBRENABLE = 0x01,
+	OPAL_MBRDONE = 0x02,
+	/* properties */
+	OPAL_HOSTPROPERTIES = 0x00,
+	/* atoms */
+	OPAL_STARTLIST = 0xf0,
+	OPAL_ENDLIST = 0xf1,
+	OPAL_STARTNAME = 0xf2,
+	OPAL_ENDNAME = 0xf3,
+	OPAL_CALL = 0xf8,
+	OPAL_ENDOFDATA = 0xf9,
+	OPAL_ENDOFSESSION = 0xfa,
+	OPAL_STARTTRANSACTON = 0xfb,
+	OPAL_ENDTRANSACTON = 0xfC,
+	OPAL_EMPTYATOM = 0xff,
+	OPAL_WHERE = 0x00,
+};
+
+/* Locking state for a locking range */
+enum opal_lockingstate {
+	OPAL_LOCKING_READWRITE = 0x01,
+	OPAL_LOCKING_READONLY = 0x02,
+	OPAL_LOCKING_LOCKED = 0x03,
+};
+
+/* Packets derived from:
+ * TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
+ * Secion: 3.2.3 ComPackets, Packets & Subpackets
+ */
+
+/* Comm Packet (header) for transmissions. */
+struct opal_compacket {
+	__be32 reserved0;
+	u8 extendedComID[4];
+	__be32 outstandingData;
+	__be32 minTransfer;
+	__be32 length;
+};
+
+/* Packet structure. */
+struct opal_packet {
+	__be32 tsn;
+	__be32 hsn;
+	__be32 seq_number;
+	__be16 reserved0;
+	__be16 ack_type;
+	__be32 acknowledgment;
+	__be32 length;
+};
+
+/* Data sub packet header */
+struct opal_data_subpacket {
+	u8 reserved0[6];
+	__be16 kind;
+	__be32 length;
+};
+
+/* header of a response */
+struct opal_header {
+	struct opal_compacket cp;
+	struct opal_packet pkt;
+	struct opal_data_subpacket subpkt;
+};
+
+#define FC_TPER       0x0001
+#define FC_LOCKING    0x0002
+#define FC_GEOMETRY   0x0003
+#define FC_ENTERPRISE 0x0100
+#define FC_DATASTORE  0x0202
+#define FC_SINGLEUSER 0x0201
+#define FC_OPALV100   0x0200
+#define FC_OPALV200   0x0203
+
+/*
+ * The Discovery 0 Header. As defined in
+ * Opal SSC Documentation
+ * Section: 3.3.5 Capability Discovery
+ */
+struct d0_header {
+	__be32 length; /* the length of the header 48 in 2.00.100 */
+	__be32 revision; /**< revision of the header 1 in 2.00.100 */
+	__be32 reserved01;
+	__be32 reserved02;
+	/*
+	 * the remainder of the structure is vendor specific and will not be
+	 * addressed now
+	 */
+	u8 ignored[32];
+};
+
+/*
+ * TPer Feature Descriptor. Contains flags indicating support for the
+ * TPer features described in the OPAL specification. The names match the
+ * OPAL terminology
+ *
+ * code == 0x001 in 2.00.100
+ */
+struct d0_tper_features {
+	/*
+	 * supported_features bits:
+	 * bit 7: reserved
+	 * bit 6: com ID management
+	 * bit 5: reserved
+	 * bit 4: streaming support
+	 * bit 3: buffer management
+	 * bit 2: ACK/NACK
+	 * bit 1: async
+	 * bit 0: sync
+	 */
+	u8 supported_features;
+	/*
+	 * bytes 5 through 15 are reserved, but we represent the first 3 as
+	 * u8 to keep the other two 32bits integers aligned.
+	 */
+	u8 reserved01[3];
+	__be32 reserved02;
+	__be32 reserved03;
+};
+
+/*
+ * Locking Feature Descriptor. Contains flags indicating support for the
+ * locking features described in the OPAL specification. The names match the
+ * OPAL terminology
+ *
+ * code == 0x0002 in 2.00.100
+ */
+struct d0_locking_features {
+	/*
+	 * supported_features bits:
+	 * bits 6-7: reserved
+	 * bit 5: MBR done
+	 * bit 4: MBR enabled
+	 * bit 3: media encryption
+	 * bit 2: locked
+	 * bit 1: locking enabled
+	 * bit 0: locking supported
+	 */
+	u8 supported_features;
+	/*
+	 * bytes 5 through 15 are reserved, but we represent the first 3 as
+	 * u8 to keep the other two 32bits integers aligned.
+	 */
+	u8 reserved01[3];
+	__be32 reserved02;
+	__be32 reserved03;
+};
+
+/*
+ * Geometry Feature Descriptor. Contains flags indicating support for the
+ * geometry features described in the OPAL specification. The names match the
+ * OPAL terminology
+ *
+ * code == 0x0003 in 2.00.100
+ */
+struct d0_geometry_features {
+	/*
+	 * skip 32 bits from header, needed to align the struct to 64 bits.
+	 */
+	u8 header[4];
+	/*
+	 * reserved01:
+	 * bits 1-6: reserved
+	 * bit 0: align
+	 */
+	u8 reserved01;
+	u8 reserved02[7];
+	__be32 logical_block_size;
+	__be64 alignment_granularity;
+	__be64 lowest_aligned_lba;
+};
+
+/*
+ * Enterprise SSC Feature
+ *
+ * code == 0x0100
+ */
+struct d0_enterprise_ssc {
+	__be16 baseComID;
+	__be16 numComIDs;
+	/* range_crossing:
+	 * bits 1-6: reserved
+	 * bit 0: range crossing
+	 */
+	u8 range_crossing;
+	u8 reserved01;
+	__be16 reserved02;
+	__be32 reserved03;
+	__be32 reserved04;
+};
+
+/*
+ * Opal V1 feature
+ *
+ * code == 0x0200
+ */
+struct d0_opal_v100 {
+	__be16 baseComID;
+	__be16 numComIDs;
+};
+
+/*
+ * Single User Mode feature
+ *
+ * code == 0x0201
+ */
+struct d0_single_user_mode {
+	__be32 num_locking_objects;
+	/* reserved01:
+	 * bit 0: any
+	 * bit 1: all
+	 * bit 2: policy
+	 * bits 3-7: reserved
+	 */
+	u8 reserved01;
+	u8 reserved02;
+	__be16 reserved03;
+	__be32 reserved04;
+};
+
+/*
+ * Additonal Datastores feature
+ *
+ * code == 0x0202
+ */
+struct d0_datastore_table {
+	__be16 reserved01;
+	__be16 max_tables;
+	__be32 max_size_tables;
+	__be32 table_size_alignment;
+};
+
+/*
+ * OPAL 2.0 feature
+ *
+ * code == 0x0203
+ */
+struct d0_opal_v200 {
+	__be16 baseComID;
+	__be16 numComIDs;
+	/* range_crossing:
+	 * bits 1-6: reserved
+	 * bit 0: range crossing
+	 */
+	u8 range_crossing;
+	/* num_locking_admin_auth:
+	 * not aligned to 16 bits, so use two u8.
+	 * stored in big endian:
+	 * 0: MSB
+	 * 1: LSB
+	 */
+	u8 num_locking_admin_auth[2];
+	/* num_locking_user_auth:
+	 * not aligned to 16 bits, so use two u8.
+	 * stored in big endian:
+	 * 0: MSB
+	 * 1: LSB
+	 */
+	u8 num_locking_user_auth[2];
+	u8 initialPIN;
+	u8 revertedPIN;
+	u8 reserved01;
+	__be32 reserved02;
+};
+
+/* Union of features used to parse the discovery 0 response */
+struct d0_features {
+	__be16 code;
+	/*
+	 * r_version bits:
+	 * bits 4-7: version
+	 * bits 0-3: reserved
+	 */
+	u8 r_version;
+	u8 length;
+	u8 features[];
+};
+
+#endif /* _OPAL_PROTO_H */
diff --git a/block/sed-opal.c b/block/sed-opal.c
new file mode 100644
index 0000000..bf1406e
--- /dev/null
+++ b/block/sed-opal.c
@@ -0,0 +1,2448 @@
+/*
+ * Copyright ? 2016 Intel Corporation
+ *
+ * Authors:
+ *    Scott  Bauer      <scott.bauer at intel.com>
+ *    Rafael Antognolli <rafael.antognolli at intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ":OPAL: " fmt
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/genhd.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <uapi/linux/sed-opal.h>
+#include <linux/sed-opal.h>
+#include <linux/string.h>
+#include <linux/kdev_t.h>
+
+#include "opal_proto.h"
+
+static const u8 opaluid[][OPAL_UID_LENGTH] = {
+	/* users */
+	[OPAL_SMUID_UID] =
+		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff },
+	[OPAL_THISSP_UID] =
+		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01 },
+	[OPAL_ADMINSP_UID] =
+		{ 0x00, 0x00, 0x02, 0x05, 0x00, 0x00, 0x00, 0x01 },
+	[OPAL_LOCKINGSP_UID] =
+		{ 0x00, 0x00, 0x02, 0x05, 0x00, 0x00, 0x00, 0x02 },
+	[OPAL_ENTERPRISE_LOCKINGSP_UID] =
+		{ 0x00, 0x00, 0x02, 0x05, 0x00, 0x01, 0x00, 0x01 },
+	[OPAL_ANYBODY_UID] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x01 },
+	[OPAL_SID_UID] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x06 },
+	[OPAL_ADMIN1_UID] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x01, 0x00, 0x01 },
+	[OPAL_USER1_UID] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x03, 0x00, 0x01 },
+	[OPAL_USER2_UID] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x03, 0x00, 0x02 },
+	[OPAL_PSID_UID] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x01, 0xff, 0x01 },
+	[OPAL_ENTERPRISE_BANDMASTER0_UID] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x80, 0x01 },
+	[OPAL_ENTERPRISE_ERASEMASTER_UID] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x84, 0x01 },
+
+	/* tables */
+
+	[OPAL_LOCKINGRANGE_GLOBAL] =
+		{ 0x00, 0x00, 0x08, 0x02, 0x00, 0x00, 0x00, 0x01 },
+	[OPAL_LOCKINGRANGE_ACE_RDLOCKED] =
+		{ 0x00, 0x00, 0x00, 0x08, 0x00, 0x03, 0xE0, 0x01 },
+	[OPAL_LOCKINGRANGE_ACE_WRLOCKED] =
+		{ 0x00, 0x00, 0x00, 0x08, 0x00, 0x03, 0xE8, 0x01 },
+	[OPAL_MBRCONTROL] =
+		{ 0x00, 0x00, 0x08, 0x03, 0x00, 0x00, 0x00, 0x01 },
+	[OPAL_MBR] =
+		{ 0x00, 0x00, 0x08, 0x04, 0x00, 0x00, 0x00, 0x00 },
+	[OPAL_AUTHORITY_TABLE] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x00},
+	[OPAL_C_PIN_TABLE] =
+		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x00},
+	[OPAL_LOCKING_INFO_TABLE] =
+		{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x01 },
+	[OPAL_ENTERPRISE_LOCKING_INFO_TABLE] =
+		{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x00 },
+
+	/* C_PIN_TABLE object ID's */
+
+        [OPAL_C_PIN_MSID] =
+		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x84, 0x02},
+	[OPAL_C_PIN_SID] =
+		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x01},
+	[OPAL_C_PIN_ADMIN1] =
+		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x01, 0x00, 0x01},
+
+	/* half UID's (only first 4 bytes used) */
+
+	[OPAL_HALF_UID_AUTHORITY_OBJ_REF] =
+		{ 0x00, 0x00, 0x0C, 0x05, 0xff, 0xff, 0xff, 0xff },
+	[OPAL_HALF_UID_BOOLEAN_ACE] =
+		{ 0x00, 0x00, 0x04, 0x0E, 0xff, 0xff, 0xff, 0xff },
+
+	/* special value for omitted optional parameter */
+	[OPAL_UID_HEXFF] =
+		{ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+};
+
+/*
+ * TCG Storage SSC Methods.
+ * Derived from: TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
+ * Section: 6.3 Assigned UIDs
+ */
+static const u8 opalmethod[][OPAL_UID_LENGTH] = {
+	[OPAL_PROPERTIES] =
+		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x01 },
+	[OPAL_STARTSESSION] =
+		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x02 },
+	[OPAL_REVERT] =
+		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x02, 0x02 },
+	[OPAL_ACTIVATE] =
+		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x02, 0x03 },
+	[OPAL_EGET] =
+		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x06 },
+	[OPAL_ESET] =
+		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x07 },
+	[OPAL_NEXT] =
+		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x08 },
+	[OPAL_EAUTHENTICATE] =
+		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x0c },
+	[OPAL_GETACL] =
+		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x0d },
+	[OPAL_GENKEY] =
+		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x10 },
+	[OPAL_REVERTSP] =
+		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x11 },
+	[OPAL_GET] =
+		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x16 },
+	[OPAL_SET] =
+		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x17 },
+	[OPAL_AUTHENTICATE] =
+		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x1c },
+	[OPAL_RANDOM] =
+		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x06, 0x01 },
+	[OPAL_ERASE] =
+		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x08, 0x03 },
+};
+
+typedef int (cont_fn)(struct opal_dev *dev);
+
+static int end_opal_session_error(struct opal_dev *dev);
+
+struct opal_suspend_data {
+	struct opal_lock_unlock unlk;
+	u8 lr;
+	struct list_head node;
+};
+
+/*
+ * Derived from:
+ * TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
+ * Section: 5.1.5 Method Status Codes
+ */
+static const char * const opal_errors[] = {
+	"Success",
+	"Not Authorized",
+	"Unknown Error",
+	"SP Busy",
+	"SP Failed",
+	"SP Disabled",
+	"SP Frozen",
+	"No Sessions Available",
+	"Uniqueness Conflict",
+	"Insufficient Space",
+	"Insufficient Rows",
+	"Invalid Function",
+	"Invalid Parameter",
+	"Invalid Reference",
+	"Unknown Error",
+	"TPER Malfunction",
+	"Transaction Failure",
+	"Response Overflow",
+	"Authority Locked Out",
+};
+
+static const char *opal_error_to_human(int error)
+{
+	if (error == 0x3f)
+		return "Failed";
+
+	if (error >= ARRAY_SIZE(opal_errors) || error < 0)
+		return "Unknown Error";
+
+	return opal_errors[error];
+}
+
+static void print_buffer(const u8 *ptr, u32 length)
+{
+#ifdef DEBUG
+	print_hex_dump_bytes("OPAL: ", DUMP_PREFIX_OFFSET, ptr, length);
+	pr_debug("\n");
+#endif
+}
+
+static bool check_tper(const void *data)
+{
+	const struct d0_tper_features *tper = data;
+	u8 flags = tper->supported_features;
+
+	if (!(flags & TPER_SYNC_SUPPORTED)) {
+		pr_err("TPer sync not supported. flags = %d\n",
+		       tper->supported_features);
+		return false;
+	}
+
+	return true;
+}
+
+static bool check_sum(const void *data)
+{
+	const struct d0_single_user_mode *sum = data;
+	u32 nlo = be32_to_cpu(sum->num_locking_objects);
+
+	if (nlo == 0) {
+		pr_err("Need at least one locking object.\n");
+		return false;
+	}
+
+	pr_debug("Number of locking objects: %d\n", nlo);
+
+	return true;
+}
+
+static u16 get_comid_v100(const void *data)
+{
+	const struct d0_opal_v100 *v100 = data;
+
+	return be16_to_cpu(v100->baseComID);
+}
+
+static u16 get_comid_v200(const void *data)
+{
+	const struct d0_opal_v200 *v200 = data;
+
+	return be16_to_cpu(v200->baseComID);
+}
+
+static int opal_send_cmd(struct opal_dev *dev)
+{
+	return dev->send_recv(dev, dev->comid, TCG_SECP_01,
+			      dev->cmd, IO_BUFFER_LENGTH,
+			      true);
+}
+
+static int opal_recv_cmd(struct opal_dev *dev)
+{
+	return dev->send_recv(dev, dev->comid, TCG_SECP_01,
+			      dev->resp, IO_BUFFER_LENGTH,
+			      false);
+}
+
+static int opal_recv_check(struct opal_dev *dev)
+{
+	size_t buflen = IO_BUFFER_LENGTH;
+	void *buffer = dev->resp;
+	struct opal_header *hdr = buffer;
+	int ret;
+
+	do {
+		pr_debug("Sent OPAL command: outstanding=%d, minTransfer=%d\n",
+			 hdr->cp.outstandingData,
+			 hdr->cp.minTransfer);
+
+		if (hdr->cp.outstandingData == 0 ||
+		    hdr->cp.minTransfer != 0)
+			return 0;
+
+		memset(buffer, 0, buflen);
+		ret = opal_recv_cmd(dev);
+	} while (!ret);
+
+	return ret;
+}
+
+static int opal_send_recv(struct opal_dev *dev, cont_fn *cont)
+{
+	int ret;
+
+	ret = opal_send_cmd(dev);
+	if (ret)
+		return ret;
+	ret = opal_recv_cmd(dev);
+	if (ret)
+		return ret;
+	ret = opal_recv_check(dev);
+	if (ret)
+		return ret;
+	return cont(dev);
+}
+
+static void check_geometry(struct opal_dev *dev, const void *data)
+{
+	const struct d0_geometry_features *geo = data;
+
+	dev->align = geo->alignment_granularity;
+	dev->lowest_lba = geo->lowest_aligned_lba;
+}
+
+static int next(struct opal_dev *dev)
+{
+	opal_step func;
+	int error = 0;
+
+	do {
+		func = dev->funcs[dev->state];
+		if (!func)
+			break;
+
+		error = func(dev);
+		if (error) {
+			pr_err("Error on step function: %d with error %d: %s\n",
+			       dev->state, error,
+			       opal_error_to_human(error));
+
+			/* For each OPAL command we do a discovery0 then we
+			 * start some sort of session.
+			 * If we haven't passed state 1 then there was an error
+			 * on discovery0 or during the attempt to start a
+			 * session. Therefore we shouldn't attempt to terminate
+			 * a session, as one has not yet been created.
+			 */
+			if (dev->state > 1)
+				return end_opal_session_error(dev);
+		}
+		dev->state++;
+	} while (!error);
+
+	return error;
+}
+
+static int opal_discovery0_end(struct opal_dev *dev)
+{
+	bool found_com_id = false, supported = true, single_user = false;
+	const struct d0_header *hdr = (struct d0_header *)dev->resp;
+	const u8 *epos = dev->resp, *cpos = dev->resp;
+	u16 comid = 0;
+
+	print_buffer(dev->resp, be32_to_cpu(hdr->length));
+
+	epos += be32_to_cpu(hdr->length); /* end of buffer */
+	cpos += sizeof(*hdr); /* current position on buffer */
+
+	while (cpos < epos && supported) {
+		const struct d0_features *body =
+			(const struct d0_features *)cpos;
+
+		switch (be16_to_cpu(body->code)) {
+		case FC_TPER:
+			supported = check_tper(body->features);
+			break;
+		case FC_SINGLEUSER:
+			single_user = check_sum(body->features);
+			break;
+		case FC_GEOMETRY:
+			check_geometry(dev, body);
+			break;
+		case FC_LOCKING:
+		case FC_ENTERPRISE:
+		case FC_DATASTORE:
+			/* some ignored properties */
+			pr_debug("Found OPAL feature description: %d\n",
+				 be16_to_cpu(body->code));
+			break;
+		case FC_OPALV100:
+			comid = get_comid_v100(body->features);
+			found_com_id = true;
+			break;
+		case FC_OPALV200:
+			comid = get_comid_v200(body->features);
+			found_com_id = true;
+			break;
+		case 0xbfff ... 0xffff:
+			/* vendor specific, just ignore */
+			break;
+		default:
+			pr_debug("OPAL Unknown feature: %d\n",
+				 be16_to_cpu(body->code));
+
+		}
+		cpos += body->length + 4;
+	}
+
+	if (!supported) {
+		pr_err("This device is not Opal enabled. Not Supported!\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!single_user)
+		pr_warn("Device doesn't support single user mode\n");
+
+
+	if (!found_com_id) {
+		pr_warn("Could not find OPAL comid for device. Returning early\n");
+		return -EOPNOTSUPP;;
+	}
+
+	dev->comid = comid;
+
+	return 0;
+}
+
+static int opal_discovery0(struct opal_dev *dev)
+{
+	int ret;
+
+	memset(dev->resp, 0, IO_BUFFER_LENGTH);
+	dev->comid = OPAL_DISCOVERY_COMID;
+	ret = opal_recv_cmd(dev);
+	if (ret)
+		return ret;
+	return opal_discovery0_end(dev);
+}
+
+static void add_token_u8(int *err, struct opal_dev *cmd, u8 tok)
+{
+	if (*err)
+		return;
+	if (cmd->pos >= IO_BUFFER_LENGTH - 1) {
+		pr_err("Error adding u8: end of buffer.\n");
+		*err = -ERANGE;
+		return;
+	}
+	cmd->cmd[cmd->pos++] = tok;
+}
+
+static void add_short_atom_header(struct opal_dev *cmd, bool bytestring,
+				  bool has_sign, int len)
+{
+	u8 atom;
+	int err = 0;
+
+	atom = SHORT_ATOM_ID;
+	atom |= bytestring ? SHORT_ATOM_BYTESTRING : 0;
+	atom |= has_sign ? SHORT_ATOM_SIGNED : 0;
+	atom |= len & SHORT_ATOM_LEN_MASK;
+
+	add_token_u8(&err, cmd, atom);
+}
+
+static void add_medium_atom_header(struct opal_dev *cmd, bool bytestring,
+				   bool has_sign, int len)
+{
+	u8 header0;
+
+	header0 = MEDIUM_ATOM_ID;
+	header0 |= bytestring ? MEDIUM_ATOM_BYTESTRING : 0;
+	header0 |= has_sign ? MEDIUM_ATOM_SIGNED : 0;
+	header0 |= (len >> 8) & MEDIUM_ATOM_LEN_MASK;
+	cmd->cmd[cmd->pos++] = header0;
+	cmd->cmd[cmd->pos++] = len;
+}
+
+static void add_token_u64(int *err, struct opal_dev *cmd, u64 number)
+{
+
+	size_t len;
+	int msb;
+	u8 n;
+
+	if (!(number & ~TINY_ATOM_DATA_MASK)) {
+		add_token_u8(err, cmd, number);
+		return;
+	}
+
+	msb = fls(number);
+	len = DIV_ROUND_UP(msb, 4);
+
+	if (cmd->pos >= IO_BUFFER_LENGTH - len - 1) {
+		pr_err("Error adding u64: end of buffer.\n");
+		*err = -ERANGE;
+		return;
+	}
+	add_short_atom_header(cmd, false, false, len);
+	while (len--) {
+		n = number >> (len * 8);
+		add_token_u8(err, cmd, n);
+	}
+}
+
+static void add_token_bytestring(int *err, struct opal_dev *cmd,
+				 const u8 *bytestring, size_t len)
+{
+	size_t header_len = 1;
+	bool is_short_atom = true;
+
+	if (*err)
+		return;
+
+	if (len & ~SHORT_ATOM_LEN_MASK) {
+		header_len = 2;
+		is_short_atom = false;
+	}
+
+	if (len >= IO_BUFFER_LENGTH - cmd->pos - header_len) {
+		pr_err("Error adding bytestring: end of buffer.\n");
+		*err = -ERANGE;
+		return;
+	}
+
+	if (is_short_atom)
+		add_short_atom_header(cmd, true, false, len);
+	else
+		add_medium_atom_header(cmd, true, false, len);
+
+	memcpy(&cmd->cmd[cmd->pos], bytestring, len);
+	cmd->pos += len;
+
+}
+
+static int build_locking_range(u8 *buffer, size_t length, u8 lr)
+{
+	if (length > OPAL_UID_LENGTH) {
+		pr_err("Can't build locking range. Length OOB\n");
+		return -ERANGE;
+	}
+
+	memcpy(buffer, opaluid[OPAL_LOCKINGRANGE_GLOBAL], OPAL_UID_LENGTH);
+
+	if (lr == 0)
+		return 0;
+	buffer[5] = LOCKING_RANGE_NON_GLOBAL;
+	buffer[7] = lr;
+
+	return 0;
+}
+
+static int build_locking_user(u8 *buffer, size_t length, u8 lr)
+{
+	if (length > OPAL_UID_LENGTH) {
+		pr_err("Can't build locking range user, Length OOB\n");
+		return -ERANGE;
+	}
+
+	memcpy(buffer, opaluid[OPAL_USER1_UID], OPAL_UID_LENGTH);
+
+	buffer[7] = lr + 1;
+
+	return 0;
+}
+
+static void set_comid(struct opal_dev *cmd, u16 comid)
+{
+	struct opal_header *hdr = (struct opal_header *)cmd->cmd;
+
+	hdr->cp.extendedComID[0] = comid >> 8;
+	hdr->cp.extendedComID[1] = comid;
+	hdr->cp.extendedComID[2] = 0;
+	hdr->cp.extendedComID[3] = 0;
+}
+
+static int cmd_finalize(struct opal_dev *cmd, u32 hsn, u32 tsn)
+{
+	struct opal_header *hdr;
+	int err = 0;
+
+	add_token_u8(&err, cmd, OPAL_ENDOFDATA);
+	add_token_u8(&err, cmd, OPAL_STARTLIST);
+	add_token_u8(&err, cmd, 0);
+	add_token_u8(&err, cmd, 0);
+	add_token_u8(&err, cmd, 0);
+	add_token_u8(&err, cmd, OPAL_ENDLIST);
+
+	if (err) {
+		pr_err("Error finalizing command.\n");
+		return -EFAULT;
+	}
+
+	hdr = (struct opal_header *) cmd->cmd;
+
+	hdr->pkt.tsn = cpu_to_be32(tsn);
+	hdr->pkt.hsn = cpu_to_be32(hsn);
+
+	hdr->subpkt.length = cpu_to_be32(cmd->pos - sizeof(*hdr));
+	while (cmd->pos % 4) {
+		if (cmd->pos >= IO_BUFFER_LENGTH) {
+			pr_err("Error: Buffer overrun\n");
+			return -ERANGE;
+		}
+		cmd->cmd[cmd->pos++] = 0;
+	}
+	hdr->pkt.length = cpu_to_be32(cmd->pos - sizeof(hdr->cp) -
+				      sizeof(hdr->pkt));
+	hdr->cp.length = cpu_to_be32(cmd->pos - sizeof(hdr->cp));
+
+	return 0;
+}
+
+static enum opal_response_token token_type(const struct parsed_resp *resp,
+					   int n)
+{
+	const struct opal_resp_tok *tok;
+
+	if (n >= resp->num) {
+		pr_err("Token number doesn't exist: %d, resp: %d\n",
+		       n, resp->num);
+		return OPAL_DTA_TOKENID_INVALID;
+	}
+
+	tok = &resp->toks[n];
+	if (tok->len == 0) {
+		pr_err("Token length must be non-zero\n");
+		return OPAL_DTA_TOKENID_INVALID;
+	}
+
+	return tok->type;
+}
+
+/*
+ * This function returns 0 in case of invalid token. One should call
+ * token_type() first to find out if the token is valid or not.
+ */
+static enum opal_token response_get_token(const struct parsed_resp *resp,
+					  int n)
+{
+	const struct opal_resp_tok *tok;
+
+	if (n >= resp->num) {
+		pr_err("Token number doesn't exist: %d, resp: %d\n",
+		       n, resp->num);
+		return 0;
+	}
+
+	tok = &resp->toks[n];
+	if (tok->len == 0) {
+		pr_err("Token length must be non-zero\n");
+		return 0;
+	}
+
+	return tok->pos[0];
+}
+
+static size_t response_parse_tiny(struct opal_resp_tok *tok,
+				  const u8 *pos)
+{
+	tok->pos = pos;
+	tok->len = 1;
+	tok->width = OPAL_WIDTH_TINY;
+
+	if (pos[0] & TINY_ATOM_SIGNED) {
+		tok->type = OPAL_DTA_TOKENID_SINT;
+	} else {
+		tok->type = OPAL_DTA_TOKENID_UINT;
+		tok->stored.u = pos[0] & 0x3f;
+	}
+
+	return tok->len;
+}
+
+static size_t response_parse_short(struct opal_resp_tok *tok,
+				   const u8 *pos)
+{
+	tok->pos = pos;
+	tok->len = (pos[0] & SHORT_ATOM_LEN_MASK) + 1;
+	tok->width = OPAL_WIDTH_SHORT;
+
+	if (pos[0] & SHORT_ATOM_BYTESTRING) {
+		tok->type = OPAL_DTA_TOKENID_BYTESTRING;
+	} else if (pos[0] & SHORT_ATOM_SIGNED) {
+		tok->type = OPAL_DTA_TOKENID_SINT;
+	} else {
+		u64 u_integer = 0;
+		int i, b = 0;
+
+		tok->type = OPAL_DTA_TOKENID_UINT;
+		if (tok->len > 9) {
+			pr_warn("uint64 with more than 8 bytes\n");
+			return -EINVAL;
+		}
+		for (i = tok->len - 1; i > 0; i--) {
+			u_integer |= ((u64)pos[i] << (8 * b));
+			b++;
+		}
+		tok->stored.u = u_integer;
+	}
+
+	return tok->len;
+}
+
+static size_t response_parse_medium(struct opal_resp_tok *tok,
+				    const u8 *pos)
+{
+	tok->pos = pos;
+	tok->len = (((pos[0] & MEDIUM_ATOM_LEN_MASK) << 8) | pos[1]) + 2;
+	tok->width = OPAL_WIDTH_MEDIUM;
+
+	if (pos[0] & MEDIUM_ATOM_BYTESTRING)
+		tok->type = OPAL_DTA_TOKENID_BYTESTRING;
+	else if (pos[0] & MEDIUM_ATOM_SIGNED)
+		tok->type = OPAL_DTA_TOKENID_SINT;
+	else
+		tok->type = OPAL_DTA_TOKENID_UINT;
+
+	return tok->len;
+}
+
+static size_t response_parse_long(struct opal_resp_tok *tok,
+				  const u8 *pos)
+{
+	tok->pos = pos;
+	tok->len = ((pos[1] << 16) | (pos[2] << 8) | pos[3]) + 4;
+	tok->width = OPAL_WIDTH_LONG;
+
+	if (pos[0] & LONG_ATOM_BYTESTRING)
+		tok->type = OPAL_DTA_TOKENID_BYTESTRING;
+	else if (pos[0] & LONG_ATOM_SIGNED)
+		tok->type = OPAL_DTA_TOKENID_SINT;
+	else
+		tok->type = OPAL_DTA_TOKENID_UINT;
+
+	return tok->len;
+}
+
+static size_t response_parse_token(struct opal_resp_tok *tok,
+				   const u8 *pos)
+{
+	tok->pos = pos;
+	tok->len = 1;
+	tok->type = OPAL_DTA_TOKENID_TOKEN;
+	tok->width = OPAL_WIDTH_TOKEN;
+
+	return tok->len;
+}
+
+static int response_parse(const u8 *buf, size_t length,
+			  struct parsed_resp *resp)
+{
+	const struct opal_header *hdr;
+	struct opal_resp_tok *iter;
+	int num_entries = 0;
+	int total;
+	size_t token_length;
+	const u8 *pos;
+
+	if (!buf)
+		return -EFAULT;
+
+	if (!resp)
+		return -EFAULT;
+
+	hdr = (struct opal_header *)buf;
+	pos = buf;
+	pos += sizeof(*hdr);
+
+	pr_debug("Response size: cp: %d, pkt: %d, subpkt: %d\n",
+		 be32_to_cpu(hdr->cp.length),
+		 be32_to_cpu(hdr->pkt.length),
+		 be32_to_cpu(hdr->subpkt.length));
+
+	if (hdr->cp.length == 0 || hdr->pkt.length == 0 ||
+	    hdr->subpkt.length == 0) {
+		pr_err("Bad header length. cp: %d, pkt: %d, subpkt: %d\n",
+		       be32_to_cpu(hdr->cp.length),
+		       be32_to_cpu(hdr->pkt.length),
+		       be32_to_cpu(hdr->subpkt.length));
+		print_buffer(pos, sizeof(*hdr));
+		return -EINVAL;
+	}
+
+	if (pos > buf + length)
+		return -EFAULT;
+
+	iter = resp->toks;
+	total = be32_to_cpu(hdr->subpkt.length);
+	print_buffer(pos, total);
+	while (total > 0) {
+		if (pos[0] <= TINY_ATOM_BYTE) /* tiny atom */
+			token_length = response_parse_tiny(iter, pos);
+		else if (pos[0] <= SHORT_ATOM_BYTE) /* short atom */
+			token_length = response_parse_short(iter, pos);
+		else if (pos[0] <= MEDIUM_ATOM_BYTE) /* medium atom */
+			token_length = response_parse_medium(iter, pos);
+		else if (pos[0] <= LONG_ATOM_BYTE) /* long atom */
+			token_length = response_parse_long(iter, pos);
+		else /* TOKEN */
+			token_length = response_parse_token(iter, pos);
+
+		if (token_length == -EINVAL)
+			return -EINVAL;
+
+		pos += token_length;
+		total -= token_length;
+		iter++;
+		num_entries++;
+	}
+
+	if (num_entries == 0) {
+		pr_err("Couldn't parse response.\n");
+		return -EINVAL;
+	}
+	resp->num = num_entries;
+
+	return 0;
+}
+
+static size_t response_get_string(const struct parsed_resp *resp, int n,
+				  const char **store)
+{
+	*store = NULL;
+	if (!resp) {
+		pr_err("Response is NULL\n");
+		return 0;
+	}
+
+	if (n > resp->num) {
+		pr_err("Response has %d tokens. Can't access %d\n",
+		       resp->num, n);
+		return 0;
+	}
+
+	if (resp->toks[n].type != OPAL_DTA_TOKENID_BYTESTRING) {
+		pr_err("Token is not a byte string!\n");
+		return 0;
+	}
+
+	*store = resp->toks[n].pos + 1;
+	return resp->toks[n].len - 1;
+}
+
+static u64 response_get_u64(const struct parsed_resp *resp, int n)
+{
+	if (!resp) {
+		pr_err("Response is NULL\n");
+		return 0;
+	}
+
+	if (n > resp->num) {
+		pr_err("Response has %d tokens. Can't access %d\n",
+		       resp->num, n);
+		return 0;
+	}
+
+	if (resp->toks[n].type != OPAL_DTA_TOKENID_UINT) {
+		pr_err("Token is not unsigned it: %d\n",
+		       resp->toks[n].type);
+		return 0;
+	}
+
+	if (!(resp->toks[n].width == OPAL_WIDTH_TINY ||
+	      resp->toks[n].width == OPAL_WIDTH_SHORT)) {
+		pr_err("Atom is not short or tiny: %d\n",
+		       resp->toks[n].width);
+		return 0;
+	}
+
+	return resp->toks[n].stored.u;
+}
+
+static u8 response_status(const struct parsed_resp *resp)
+{
+	if (token_type(resp, 0) == OPAL_DTA_TOKENID_TOKEN &&
+	    response_get_token(resp, 0) == OPAL_ENDOFSESSION) {
+		return 0;
+	}
+
+	if (resp->num < 5)
+		return DTAERROR_NO_METHOD_STATUS;
+
+	if (token_type(resp, resp->num - 1) != OPAL_DTA_TOKENID_TOKEN ||
+	    token_type(resp, resp->num - 5) != OPAL_DTA_TOKENID_TOKEN ||
+	    response_get_token(resp, resp->num - 1) != OPAL_ENDLIST ||
+	    response_get_token(resp, resp->num - 5) != OPAL_STARTLIST)
+		return DTAERROR_NO_METHOD_STATUS;
+
+	return response_get_u64(resp, resp->num - 4);
+}
+
+/* Parses and checks for errors */
+static int parse_and_check_status(struct opal_dev *dev)
+{
+	int error;
+
+	print_buffer(dev->cmd, dev->pos);
+
+	error = response_parse(dev->resp, IO_BUFFER_LENGTH, &dev->parsed);
+	if (error) {
+		pr_err("Couldn't parse response.\n");
+		return error;
+	}
+
+	return response_status(&dev->parsed);
+}
+
+static void clear_opal_cmd(struct opal_dev *dev)
+{
+	dev->pos = sizeof(struct opal_header);
+	memset(dev->cmd, 0, IO_BUFFER_LENGTH);
+}
+
+static int start_opal_session_cont(struct opal_dev *dev)
+{
+	u32 hsn, tsn;
+	int error = 0;
+
+	error = parse_and_check_status(dev);
+	if (error)
+		return error;
+
+	hsn = response_get_u64(&dev->parsed, 4);
+	tsn = response_get_u64(&dev->parsed, 5);
+
+	if (hsn == 0 && tsn == 0) {
+		pr_err("Couldn't authenticate session\n");
+		return -EPERM;
+	}
+
+	dev->hsn = hsn;
+	dev->tsn = tsn;
+	return 0;
+}
+
+static void add_suspend_info(struct opal_dev *dev,
+			     struct opal_suspend_data *sus)
+{
+	struct opal_suspend_data *iter;
+
+	list_for_each_entry(iter, &dev->unlk_lst, node) {
+		if (iter->lr == sus->lr) {
+			list_del(&iter->node);
+			kfree(iter);
+			break;
+		}
+	}
+	list_add_tail(&sus->node, &dev->unlk_lst);
+}
+
+static int end_session_cont(struct opal_dev *dev)
+{
+	dev->hsn = 0;
+	dev->tsn = 0;
+	return parse_and_check_status(dev);
+}
+
+static int finalize_and_send(struct opal_dev *dev, cont_fn cont)
+{
+	int ret;
+
+	ret = cmd_finalize(dev, dev->hsn, dev->tsn);
+	if (ret) {
+		pr_err("Error finalizing command buffer: %d\n", ret);
+		return ret;
+	}
+
+	print_buffer(dev->cmd, dev->pos);
+
+	return opal_send_recv(dev, cont);
+}
+
+static int gen_key(struct opal_dev *dev)
+{
+	const u8 *method;
+	u8 uid[OPAL_UID_LENGTH];
+	int err = 0;
+
+	clear_opal_cmd(dev);
+	set_comid(dev, dev->comid);
+
+	memcpy(uid, dev->prev_data, min(sizeof(uid), dev->prev_d_len));
+	method = opalmethod[OPAL_GENKEY];
+	kfree(dev->prev_data);
+	dev->prev_data = NULL;
+
+	add_token_u8(&err, dev, OPAL_CALL);
+	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
+	add_token_bytestring(&err, dev, opalmethod[OPAL_GENKEY],
+			     OPAL_UID_LENGTH);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+
+	if (err) {
+		pr_err("Error building gen key command\n");
+		return err;
+
+	}
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
+static int get_active_key_cont(struct opal_dev *dev)
+{
+	const char *activekey;
+	size_t keylen;
+	int error = 0;
+
+	error = parse_and_check_status(dev);
+	if (error)
+		return error;
+	keylen = response_get_string(&dev->parsed, 4, &activekey);
+	if (!activekey) {
+		pr_err("%s: Couldn't extract the Activekey from the response\n",
+		       __func__);
+		return OPAL_INVAL_PARAM;
+	}
+	dev->prev_data = kmemdup(activekey, keylen, GFP_KERNEL);
+
+	if (!dev->prev_data)
+		return -ENOMEM;
+
+	dev->prev_d_len = keylen;
+
+	return 0;
+}
+
+static int get_active_key(struct opal_dev *dev)
+{
+	u8 uid[OPAL_UID_LENGTH];
+	int err = 0;
+	u8 *lr;
+
+	clear_opal_cmd(dev);
+	set_comid(dev, dev->comid);
+	lr = dev->func_data[dev->state];
+
+	err = build_locking_range(uid, sizeof(uid), *lr);
+	if (err)
+		return err;
+
+	err = 0;
+	add_token_u8(&err, dev, OPAL_CALL);
+	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
+	add_token_bytestring(&err, dev, opalmethod[OPAL_GET], OPAL_UID_LENGTH);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, 3); /* startCloumn */
+	add_token_u8(&err, dev, 10); /* ActiveKey */
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, 4); /* endColumn */
+	add_token_u8(&err, dev, 10); /* ActiveKey */
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+	if (err) {
+		pr_err("Error building get active key command\n");
+		return err;
+	}
+
+	return finalize_and_send(dev, get_active_key_cont);
+}
+
+static int generic_lr_enable_disable(struct opal_dev *dev,
+				     u8 *uid, bool rle, bool wle,
+				     bool rl, bool wl)
+{
+	int err = 0;
+
+	add_token_u8(&err, dev, OPAL_CALL);
+	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
+	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
+
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_VALUES);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, 5); /* ReadLockEnabled */
+	add_token_u8(&err, dev, rle);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, 6); /* WriteLockEnabled */
+	add_token_u8(&err, dev, wle);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_READLOCKED);
+	add_token_u8(&err, dev, rl);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_WRITELOCKED);
+	add_token_u8(&err, dev, wl);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+	return err;
+}
+
+static inline int enable_global_lr(struct opal_dev *dev, u8 *uid,
+				   struct opal_user_lr_setup *setup)
+{
+	int err;
+
+	err = generic_lr_enable_disable(dev, uid, !!setup->RLE, !!setup->WLE,
+					0, 0);
+	if (err)
+		pr_err("Failed to create enable global lr command\n");
+	return err;
+}
+
+static int setup_locking_range(struct opal_dev *dev)
+{
+	u8 uid[OPAL_UID_LENGTH];
+	struct opal_user_lr_setup *setup;
+	u8 lr;
+	int err = 0;
+
+	clear_opal_cmd(dev);
+	set_comid(dev, dev->comid);
+
+	setup = dev->func_data[dev->state];
+	lr = setup->session.opal_key.lr;
+	err = build_locking_range(uid, sizeof(uid), lr);
+	if (err)
+		return err;
+
+	if (lr == 0)
+		err = enable_global_lr(dev, uid, setup);
+	else {
+		add_token_u8(&err, dev, OPAL_CALL);
+		add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
+		add_token_bytestring(&err, dev, opalmethod[OPAL_SET],
+				     OPAL_UID_LENGTH);
+
+		add_token_u8(&err, dev, OPAL_STARTLIST);
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u8(&err, dev, OPAL_VALUES);
+		add_token_u8(&err, dev, OPAL_STARTLIST);
+
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u8(&err, dev, 3); /* Ranges Start */
+		add_token_u64(&err, dev, setup->range_start);
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u8(&err, dev, 4); /* Ranges length */
+		add_token_u64(&err, dev, setup->range_length);
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u8(&err, dev, 5); /*ReadLockEnabled */
+		add_token_u64(&err, dev, !!setup->RLE);
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u8(&err, dev, 6); /*WriteLockEnabled*/
+		add_token_u64(&err, dev, !!setup->WLE);
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+
+		add_token_u8(&err, dev, OPAL_ENDLIST);
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+		add_token_u8(&err, dev, OPAL_ENDLIST);
+
+	}
+	if (err) {
+		pr_err("Error building Setup Locking range command.\n");
+		return err;
+
+	}
+
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
+static int start_generic_opal_session(struct opal_dev *dev,
+				      enum opal_uid auth,
+				      enum opal_uid sp_type,
+				      const char *key,
+				      u8 key_len)
+{
+	u32 hsn;
+	int err = 0;
+
+	if (key == NULL && auth != OPAL_ANYBODY_UID) {
+		pr_err("%s: Attempted to open ADMIN_SP Session without a Host" \
+		       "Challenge, and not as the Anybody UID\n", __func__);
+		return OPAL_INVAL_PARAM;
+	}
+
+	clear_opal_cmd(dev);
+
+	set_comid(dev, dev->comid);
+	hsn = GENERIC_HOST_SESSION_NUM;
+
+	add_token_u8(&err, dev, OPAL_CALL);
+	add_token_bytestring(&err, dev, opaluid[OPAL_SMUID_UID],
+			     OPAL_UID_LENGTH);
+	add_token_bytestring(&err, dev, opalmethod[OPAL_STARTSESSION],
+			     OPAL_UID_LENGTH);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u64(&err, dev, hsn);
+	add_token_bytestring(&err, dev, opaluid[sp_type], OPAL_UID_LENGTH);
+	add_token_u8(&err, dev, 1);
+
+	switch (auth) {
+	case OPAL_ANYBODY_UID:
+		add_token_u8(&err, dev, OPAL_ENDLIST);
+		break;
+	case OPAL_ADMIN1_UID:
+	case OPAL_SID_UID:
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u8(&err, dev, 0); /* HostChallenge */
+		add_token_bytestring(&err, dev, key, key_len);
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u8(&err, dev, 3); /* HostSignAuth */
+		add_token_bytestring(&err, dev, opaluid[auth],
+				     OPAL_UID_LENGTH);
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+		add_token_u8(&err, dev, OPAL_ENDLIST);
+		break;
+	default:
+		pr_err("Cannot start Admin SP session with auth %d\n", auth);
+		return OPAL_INVAL_PARAM;
+	}
+
+	if (err) {
+		pr_err("Error building start adminsp session command.\n");
+		return err;
+	}
+
+	return finalize_and_send(dev, start_opal_session_cont);
+}
+
+static int start_anybodyASP_opal_session(struct opal_dev *dev)
+{
+	return start_generic_opal_session(dev, OPAL_ANYBODY_UID,
+					  OPAL_ADMINSP_UID, NULL, 0);
+}
+
+static int start_SIDASP_opal_session(struct opal_dev *dev)
+{
+	int ret;
+	const u8 *key = dev->prev_data;
+	struct opal_key *okey;
+
+	if (!key) {
+		okey = dev->func_data[dev->state];
+		ret = start_generic_opal_session(dev, OPAL_SID_UID,
+						 OPAL_ADMINSP_UID,
+						 okey->key,
+						 okey->key_len);
+	} else {
+		ret = start_generic_opal_session(dev, OPAL_SID_UID,
+						 OPAL_ADMINSP_UID,
+						 key, dev->prev_d_len);
+		kfree(key);
+		dev->prev_data = NULL;
+	}
+	return ret;
+}
+
+static inline int start_admin1LSP_opal_session(struct opal_dev *dev)
+{
+	struct opal_key *key = dev->func_data[dev->state];
+
+	return start_generic_opal_session(dev, OPAL_ADMIN1_UID,
+					  OPAL_LOCKINGSP_UID,
+					  key->key, key->key_len);
+}
+
+static int start_auth_opal_session(struct opal_dev *dev)
+{
+	u8 lk_ul_user[OPAL_UID_LENGTH];
+	int err = 0;
+
+	struct opal_session_info *session = dev->func_data[dev->state];
+	size_t keylen = session->opal_key.key_len;
+	u8 *key = session->opal_key.key;
+	u32 hsn = GENERIC_HOST_SESSION_NUM;
+
+	clear_opal_cmd(dev);
+	set_comid(dev, dev->comid);
+
+	if (session->sum) {
+		err = build_locking_user(lk_ul_user, sizeof(lk_ul_user),
+					 session->opal_key.lr);
+		if (err)
+			return err;
+
+	} else if (session->who != OPAL_ADMIN1 && !session->sum) {
+		err = build_locking_user(lk_ul_user, sizeof(lk_ul_user),
+					 session->who - 1);
+		if (err)
+			return err;
+	} else
+		memcpy(lk_ul_user, opaluid[OPAL_ADMIN1_UID], OPAL_UID_LENGTH);
+
+	add_token_u8(&err, dev, OPAL_CALL);
+	add_token_bytestring(&err, dev, opaluid[OPAL_SMUID_UID],
+			     OPAL_UID_LENGTH);
+	add_token_bytestring(&err, dev, opalmethod[OPAL_STARTSESSION],
+			     OPAL_UID_LENGTH);
+
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u64(&err, dev, hsn);
+	add_token_bytestring(&err, dev, opaluid[OPAL_LOCKINGSP_UID],
+			     OPAL_UID_LENGTH);
+	add_token_u8(&err, dev, 1);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, 0);
+	add_token_bytestring(&err, dev, key, keylen);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, 3);
+	add_token_bytestring(&err, dev, lk_ul_user, OPAL_UID_LENGTH);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+
+	if (err) {
+		pr_err("Error building STARTSESSION command.\n");
+		return err;
+	}
+
+	return finalize_and_send(dev, start_opal_session_cont);
+}
+
+static int revert_tper(struct opal_dev *dev)
+{
+	int err = 0;
+
+	clear_opal_cmd(dev);
+	set_comid(dev, dev->comid);
+
+	add_token_u8(&err, dev, OPAL_CALL);
+	add_token_bytestring(&err, dev, opaluid[OPAL_ADMINSP_UID],
+			     OPAL_UID_LENGTH);
+	add_token_bytestring(&err, dev, opalmethod[OPAL_REVERT],
+			     OPAL_UID_LENGTH);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+	if (err) {
+		pr_err("Error building REVERT TPER command.\n");
+		return err;
+	}
+
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
+static int internal_activate_user(struct opal_dev *dev)
+{
+	struct opal_session_info *session = dev->func_data[dev->state];
+	u8 uid[OPAL_UID_LENGTH];
+	int err = 0;
+
+	clear_opal_cmd(dev);
+	set_comid(dev, dev->comid);
+
+	memcpy(uid, opaluid[OPAL_USER1_UID], OPAL_UID_LENGTH);
+	uid[7] = session->who;
+
+	add_token_u8(&err, dev, OPAL_CALL);
+	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
+	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_VALUES);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, 5); /* Enabled */
+	add_token_u8(&err, dev, OPAL_TRUE);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+
+	if (err) {
+		pr_err("Error building Activate UserN command.\n");
+		return err;
+	}
+
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
+static int erase_locking_range(struct opal_dev *dev)
+{
+	struct opal_session_info *session;
+	u8 uid[OPAL_UID_LENGTH];
+	int err = 0;
+
+	clear_opal_cmd(dev);
+	set_comid(dev, dev->comid);
+	session = dev->func_data[dev->state];
+
+	if (build_locking_range(uid, sizeof(uid), session->opal_key.lr) < 0)
+		return -ERANGE;
+
+	add_token_u8(&err, dev, OPAL_CALL);
+	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
+	add_token_bytestring(&err, dev, opalmethod[OPAL_ERASE],
+			     OPAL_UID_LENGTH);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+
+	if (err) {
+		pr_err("Error building Erase Locking Range Command.\n");
+		return err;
+	}
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
+static int set_mbr_done(struct opal_dev *dev)
+{
+	u8 mbr_done_tf = *(u8 *)dev->func_data[dev->state];
+	int err = 0;
+
+	clear_opal_cmd(dev);
+	set_comid(dev, dev->comid);
+
+	add_token_u8(&err, dev, OPAL_CALL);
+	add_token_bytestring(&err, dev, opaluid[OPAL_MBRCONTROL],
+			     OPAL_UID_LENGTH);
+	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_VALUES);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, 2); /* Done */
+	add_token_u8(&err, dev, mbr_done_tf); /* Done T or F */
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+
+	if (err) {
+		pr_err("Error Building set MBR Done command\n");
+		return err;
+	}
+
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
+static int set_mbr_enable_disable(struct opal_dev *dev)
+{
+	u8 mbr_en_dis = *(u8 *)dev->func_data[dev->state];
+	int err = 0;
+
+	clear_opal_cmd(dev);
+	set_comid(dev, dev->comid);
+
+	add_token_u8(&err, dev, OPAL_CALL);
+	add_token_bytestring(&err, dev, opaluid[OPAL_MBRCONTROL],
+			     OPAL_UID_LENGTH);
+	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_VALUES);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, 1);
+	add_token_u8(&err, dev, mbr_en_dis);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+
+	if (err) {
+		pr_err("Error Building set MBR done command\n");
+		return err;
+	}
+
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
+static int generic_pw_cmd(u8 *key, size_t key_len, u8 *cpin_uid,
+			  struct opal_dev *dev)
+{
+	int err = 0;
+
+	clear_opal_cmd(dev);
+	set_comid(dev, dev->comid);
+
+	add_token_u8(&err, dev, OPAL_CALL);
+	add_token_bytestring(&err, dev, cpin_uid, OPAL_UID_LENGTH);
+	add_token_bytestring(&err, dev, opalmethod[OPAL_SET],
+			     OPAL_UID_LENGTH);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_VALUES);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, 3); /* PIN */
+	add_token_bytestring(&err, dev, key, key_len);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+
+	return err;
+}
+
+static int set_new_pw(struct opal_dev *dev)
+{
+	u8 cpin_uid[OPAL_UID_LENGTH];
+	struct opal_session_info *usr = dev->func_data[dev->state];
+
+
+	memcpy(cpin_uid, opaluid[OPAL_C_PIN_ADMIN1], OPAL_UID_LENGTH);
+
+	if (usr->who != OPAL_ADMIN1) {
+		cpin_uid[5] = 0x03;
+		if (usr->sum)
+			cpin_uid[7] = usr->opal_key.lr + 1;
+		else
+			cpin_uid[7] = usr->who;
+	}
+
+	if (generic_pw_cmd(usr->opal_key.key, usr->opal_key.key_len,
+			   cpin_uid, dev)) {
+		pr_err("Error building set password command.\n");
+		return -ERANGE;
+	}
+
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
+static int set_sid_cpin_pin(struct opal_dev *dev)
+{
+	u8 cpin_uid[OPAL_UID_LENGTH];
+	struct opal_key *key = dev->func_data[dev->state];
+
+	memcpy(cpin_uid, opaluid[OPAL_C_PIN_SID], OPAL_UID_LENGTH);
+
+	if (generic_pw_cmd(key->key, key->key_len, cpin_uid, dev)) {
+		pr_err("Error building Set SID cpin\n");
+		return -ERANGE;
+	}
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
+static int add_user_to_lr(struct opal_dev *dev)
+{
+	u8 lr_buffer[OPAL_UID_LENGTH];
+	u8 user_uid[OPAL_UID_LENGTH];
+	struct opal_lock_unlock *lkul;
+	int err = 0;
+
+	clear_opal_cmd(dev);
+	set_comid(dev, dev->comid);
+
+	lkul = dev->func_data[dev->state];
+
+	memcpy(lr_buffer, opaluid[OPAL_LOCKINGRANGE_ACE_RDLOCKED],
+	       OPAL_UID_LENGTH);
+
+	if (lkul->l_state == OPAL_RW)
+		memcpy(lr_buffer, opaluid[OPAL_LOCKINGRANGE_ACE_WRLOCKED],
+		       OPAL_UID_LENGTH);
+
+	lr_buffer[7] = lkul->session.opal_key.lr;
+
+	memcpy(user_uid, opaluid[OPAL_USER1_UID], OPAL_UID_LENGTH);
+
+	user_uid[7] = lkul->session.who;
+
+	add_token_u8(&err, dev, OPAL_CALL);
+	add_token_bytestring(&err, dev, lr_buffer, OPAL_UID_LENGTH);
+	add_token_bytestring(&err, dev, opalmethod[OPAL_SET],
+			     OPAL_UID_LENGTH);
+
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_VALUES);
+
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, 3);
+
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_bytestring(&err, dev,
+			     opaluid[OPAL_HALF_UID_AUTHORITY_OBJ_REF],
+			     OPAL_UID_LENGTH/2);
+	add_token_bytestring(&err, dev, user_uid, OPAL_UID_LENGTH);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_bytestring(&err, dev,
+			     opaluid[OPAL_HALF_UID_AUTHORITY_OBJ_REF],
+			     OPAL_UID_LENGTH/2);
+	add_token_bytestring(&err, dev, user_uid, OPAL_UID_LENGTH);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_bytestring(&err, dev, opaluid[OPAL_HALF_UID_BOOLEAN_ACE],
+			     OPAL_UID_LENGTH/2);
+	add_token_u8(&err, dev, 1);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+
+	if (err) {
+		pr_err("Error building add user to locking range command.\n");
+		return err;
+	}
+
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
+static int lock_unlock_locking_range(struct opal_dev *dev)
+{
+	u8 lr_buffer[OPAL_UID_LENGTH];
+	const u8 *method;
+	struct opal_lock_unlock *lkul;
+	u8 read_locked = 1, write_locked = 1;
+	int err = 0;
+
+	clear_opal_cmd(dev);
+	set_comid(dev, dev->comid);
+
+	method = opalmethod[OPAL_SET];
+	lkul = dev->func_data[dev->state];
+	if (build_locking_range(lr_buffer, sizeof(lr_buffer),
+				lkul->session.opal_key.lr) < 0)
+		return -ERANGE;
+
+	switch (lkul->l_state) {
+	case OPAL_RO:
+		read_locked = 0;
+		write_locked = 1;
+		break;
+	case OPAL_RW:
+		read_locked = 0;
+		write_locked = 0;
+		break;
+	case OPAL_LK:
+		/* vars are initalized to locked */
+		break;
+	default:
+		pr_err("Tried to set an invalid locking state... returning to uland\n");
+		return OPAL_INVAL_PARAM;
+	}
+
+	add_token_u8(&err, dev, OPAL_CALL);
+	add_token_bytestring(&err, dev, lr_buffer, OPAL_UID_LENGTH);
+	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_VALUES);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_READLOCKED);
+	add_token_u8(&err, dev, read_locked);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_WRITELOCKED);
+	add_token_u8(&err, dev, write_locked);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+
+	if (err) {
+		pr_err("Error building SET command.\n");
+		return err;
+	}
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
+
+static int lock_unlock_locking_range_sum(struct opal_dev *dev)
+{
+	u8 lr_buffer[OPAL_UID_LENGTH];
+	u8 read_locked = 1, write_locked = 1;
+	const u8 *method;
+	struct opal_lock_unlock *lkul;
+	int ret;
+
+	clear_opal_cmd(dev);
+	set_comid(dev, dev->comid);
+
+	method = opalmethod[OPAL_SET];
+	lkul = dev->func_data[dev->state];
+	if (build_locking_range(lr_buffer, sizeof(lr_buffer),
+				lkul->session.opal_key.lr) < 0)
+		return -ERANGE;
+
+	switch (lkul->l_state) {
+	case OPAL_RO:
+		read_locked = 0;
+		write_locked = 1;
+		break;
+	case OPAL_RW:
+		read_locked = 0;
+		write_locked = 0;
+		break;
+	case OPAL_LK:
+		/* vars are initalized to locked */
+		break;
+	default:
+		pr_err("Tried to set an invalid locking state.\n");
+		return OPAL_INVAL_PARAM;
+	}
+	ret = generic_lr_enable_disable(dev, lr_buffer, 1, 1,
+					read_locked, write_locked);
+
+	if (ret < 0) {
+		pr_err("Error building SET command.\n");
+		return ret;
+	}
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
+static int activate_lsp(struct opal_dev *dev)
+{
+	struct opal_lr_act *opal_act;
+	u8 user_lr[OPAL_UID_LENGTH];
+	u8 uint_3 = 0x83;
+	int err = 0, i;
+
+	clear_opal_cmd(dev);
+	set_comid(dev, dev->comid);
+
+	opal_act = dev->func_data[dev->state];
+
+	add_token_u8(&err, dev, OPAL_CALL);
+	add_token_bytestring(&err, dev, opaluid[OPAL_LOCKINGSP_UID],
+			     OPAL_UID_LENGTH);
+	add_token_bytestring(&err, dev, opalmethod[OPAL_ACTIVATE],
+			     OPAL_UID_LENGTH);
+
+
+	if (opal_act->sum) {
+		err = build_locking_range(user_lr, sizeof(user_lr),
+					  opal_act->lr[0]);
+		if (err)
+			return err;
+
+		add_token_u8(&err, dev, OPAL_STARTLIST);
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u8(&err, dev, uint_3);
+		add_token_u8(&err, dev, 6);
+		add_token_u8(&err, dev, 0);
+		add_token_u8(&err, dev, 0);
+
+		add_token_u8(&err, dev, OPAL_STARTLIST);
+		add_token_bytestring(&err, dev, user_lr, OPAL_UID_LENGTH);
+		for (i = 1; i < opal_act->num_lrs; i++) {
+			user_lr[7] = opal_act->lr[i];
+			add_token_bytestring(&err, dev, user_lr, OPAL_UID_LENGTH);
+		}
+		add_token_u8(&err, dev, OPAL_ENDLIST);
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+		add_token_u8(&err, dev, OPAL_ENDLIST);
+
+	} else {
+		add_token_u8(&err, dev, OPAL_STARTLIST);
+		add_token_u8(&err, dev, OPAL_ENDLIST);
+	}
+
+	if (err) {
+		pr_err("Error building Activate LockingSP command.\n");
+		return err;
+	}
+
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
+static int get_lsp_lifecycle_cont(struct opal_dev *dev)
+{
+	u8 lc_status;
+	int error = 0;
+
+	error = parse_and_check_status(dev);
+	if (error)
+		return error;
+
+	lc_status = response_get_u64(&dev->parsed, 4);
+	/* 0x08 is Manufacured Inactive */
+	/* 0x09 is Manufactured */
+	if (lc_status != OPAL_MANUFACTURED_INACTIVE) {
+		pr_err("Couldn't determine the status of the Lifcycle state\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/* Determine if we're in the Manufactured Inactive or Active state */
+static int get_lsp_lifecycle(struct opal_dev *dev)
+{
+	int err = 0;
+
+	clear_opal_cmd(dev);
+	set_comid(dev, dev->comid);
+
+	add_token_u8(&err, dev, OPAL_CALL);
+	add_token_bytestring(&err, dev, opaluid[OPAL_LOCKINGSP_UID],
+			     OPAL_UID_LENGTH);
+	add_token_bytestring(&err, dev, opalmethod[OPAL_GET], OPAL_UID_LENGTH);
+
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, 3); /* Start Column */
+	add_token_u8(&err, dev, 6); /* Lifecycle Column */
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, 4); /* End Column */
+	add_token_u8(&err, dev, 6); /* Lifecycle Column */
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+
+	if (err) {
+		pr_err("Error Building GET Lifecycle Status command\n");
+		return err;
+	}
+
+	return finalize_and_send(dev, get_lsp_lifecycle_cont);
+}
+
+static int get_msid_cpin_pin_cont(struct opal_dev *dev)
+{
+	const char *msid_pin;
+	size_t strlen;
+	int error = 0;
+
+	error = parse_and_check_status(dev);
+	if (error)
+		return error;
+
+	strlen = response_get_string(&dev->parsed, 4, &msid_pin);
+	if (!msid_pin) {
+		pr_err("%s: Couldn't extract PIN from response\n", __func__);
+		return OPAL_INVAL_PARAM;
+	}
+
+	dev->prev_data = kmemdup(msid_pin, strlen, GFP_KERNEL);
+	if (!dev->prev_data)
+		return -ENOMEM;
+
+	dev->prev_d_len = strlen;
+
+	return 0;
+}
+
+static int get_msid_cpin_pin(struct opal_dev *dev)
+{
+	int err = 0;
+
+	clear_opal_cmd(dev);
+	set_comid(dev, dev->comid);
+
+
+	add_token_u8(&err, dev, OPAL_CALL);
+	add_token_bytestring(&err, dev, opaluid[OPAL_C_PIN_MSID],
+			     OPAL_UID_LENGTH);
+	add_token_bytestring(&err, dev, opalmethod[OPAL_GET], OPAL_UID_LENGTH);
+
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, 3); /* Start Column */
+	add_token_u8(&err, dev, 3); /* PIN */
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, 4); /* End Column */
+	add_token_u8(&err, dev, 3); /* Lifecycle Column */
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+
+	if (err) {
+		pr_err("Error building Get MSID CPIN PIN command.\n");
+		return err;
+	}
+
+	return finalize_and_send(dev, get_msid_cpin_pin_cont);
+}
+
+static int build_end_opal_session(struct opal_dev *dev)
+{
+	int err = 0;
+
+	clear_opal_cmd(dev);
+
+	set_comid(dev, dev->comid);
+	add_token_u8(&err, dev, OPAL_ENDOFSESSION);
+	return err;
+}
+
+static int end_opal_session(struct opal_dev *dev)
+{
+	int ret = build_end_opal_session(dev);
+
+	if (ret < 0)
+		return ret;
+	return finalize_and_send(dev, end_session_cont);
+}
+
+static int end_opal_session_error(struct opal_dev *dev)
+{
+	const opal_step error_end_session[] = {
+		end_opal_session,
+		NULL,
+	};
+	dev->funcs = error_end_session;
+	dev->state = 0;
+	return next(dev);
+}
+
+static inline void setup_opal_dev(struct opal_dev *dev,
+				  const opal_step *funcs)
+{
+	dev->state = 0;
+	dev->funcs = funcs;
+	dev->tsn = 0;
+	dev->hsn = 0;
+	dev->func_data = NULL;
+	dev->prev_data = NULL;
+}
+
+static int check_opal_support(struct opal_dev *dev)
+{
+	static const opal_step funcs[] = {
+		opal_discovery0,
+		NULL
+	};
+	int ret;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev, funcs);
+	ret = next(dev);
+	dev->supported = !ret;
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
+void init_opal_dev(struct opal_dev *opal_dev, sec_send_recv *send_recv)
+{
+	if (opal_dev->initialized)
+		return;
+	INIT_LIST_HEAD(&opal_dev->unlk_lst);
+	mutex_init(&opal_dev->dev_lock);
+	opal_dev->send_recv = send_recv;
+	if (check_opal_support(opal_dev) < 0)
+		pr_warn("Opal is not supported on this device\n");
+	opal_dev->initialized = true;
+}
+EXPORT_SYMBOL(init_opal_dev);
+
+static int opal_secure_erase_locking_range(struct opal_dev *dev,
+					   struct opal_session_info *opal_session)
+{
+	void *data[3] = { NULL };
+	static const opal_step erase_funcs[] = {
+		opal_discovery0,
+		start_auth_opal_session,
+		get_active_key,
+		gen_key,
+		end_opal_session,
+		NULL,
+	};
+	int ret;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev, erase_funcs);
+
+	dev->func_data = data;
+	dev->func_data[1] = opal_session;
+	dev->func_data[2] = &opal_session->opal_key.lr;
+
+	ret = next(dev);
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
+static int opal_erase_locking_range(struct opal_dev *dev,
+				    struct opal_session_info *opal_session)
+{
+	void *data[3] = { NULL };
+	static const opal_step erase_funcs[] = {
+		opal_discovery0,
+		start_auth_opal_session,
+		erase_locking_range,
+		end_opal_session,
+		NULL,
+	};
+	int ret;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev, erase_funcs);
+
+	dev->func_data = data;
+	dev->func_data[1] = opal_session;
+	dev->func_data[2] = opal_session;
+
+	ret = next(dev);
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
+static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
+					  struct opal_mbr_data *opal_mbr)
+{
+	void *func_data[6] = { NULL };
+	static const opal_step mbr_funcs[] = {
+		opal_discovery0,
+		start_admin1LSP_opal_session,
+		set_mbr_done,
+		end_opal_session,
+		start_admin1LSP_opal_session,
+		set_mbr_enable_disable,
+		end_opal_session,
+		NULL,
+	};
+	int ret;
+
+	if (opal_mbr->enable_disable != OPAL_MBR_ENABLE &&
+	    opal_mbr->enable_disable != OPAL_MBR_DISABLE)
+		return -EINVAL;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev, mbr_funcs);
+	dev->func_data = func_data;
+	dev->func_data[1] = &opal_mbr->key;
+	dev->func_data[2] = &opal_mbr->enable_disable;
+	dev->func_data[4] = &opal_mbr->key;
+	dev->func_data[5] = &opal_mbr->enable_disable;
+	ret = next(dev);
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
+static int opal_save(struct opal_dev *dev, struct opal_lock_unlock *lk_unlk)
+{
+	struct opal_suspend_data *suspend;
+
+	suspend = kzalloc(sizeof(*suspend), GFP_KERNEL);
+	if (!suspend)
+		return -ENOMEM;
+
+	suspend->unlk = *lk_unlk;
+	suspend->lr = lk_unlk->session.opal_key.lr;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev, NULL);
+	add_suspend_info(dev, suspend);
+	mutex_unlock(&dev->dev_lock);
+	return 0;
+}
+
+static int opal_add_user_to_lr(struct opal_dev *dev,
+			       struct opal_lock_unlock *lk_unlk)
+{
+	void *func_data[3] = { NULL };
+	static const opal_step funcs[] = {
+		opal_discovery0,
+		start_admin1LSP_opal_session,
+		add_user_to_lr,
+		end_opal_session,
+		NULL
+	};
+	int ret;
+
+	if (lk_unlk->l_state != OPAL_RO &&
+	    lk_unlk->l_state != OPAL_RW) {
+		pr_err("Locking state was not RO or RW\n");
+		return -EINVAL;
+	}
+	if (lk_unlk->session.who < OPAL_USER1 &&
+	    lk_unlk->session.who > OPAL_USER9) {
+		pr_err("Authority was not within the range of users: %d\n",
+		       lk_unlk->session.who);
+		return -EINVAL;
+	}
+	if (lk_unlk->session.sum) {
+		pr_err("%s not supported in sum. Use setup locking range\n",
+		       __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev, funcs);
+	dev->func_data = func_data;
+	dev->func_data[1] = &lk_unlk->session.opal_key;
+	dev->func_data[2] = lk_unlk;
+	ret = next(dev);
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
+static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal)
+{
+	void *data[2] = { NULL };
+	static const opal_step revert_funcs[] = {
+		opal_discovery0,
+		start_SIDASP_opal_session,
+		revert_tper, /* controller will terminate session */
+		NULL,
+	};
+	int ret;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev, revert_funcs);
+	dev->func_data = data;
+	dev->func_data[1] = opal;
+	ret = next(dev);
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
+static int __opal_lock_unlock_sum(struct opal_dev *dev)
+{
+	static const opal_step ulk_funcs_sum[] = {
+		opal_discovery0,
+		start_auth_opal_session,
+		lock_unlock_locking_range_sum,
+		end_opal_session,
+		NULL
+	};
+
+	dev->funcs = ulk_funcs_sum;
+	return next(dev);
+}
+
+static int __opal_lock_unlock(struct opal_dev *dev)
+{
+	static const opal_step _unlock_funcs[] = {
+		opal_discovery0,
+		start_auth_opal_session,
+		lock_unlock_locking_range,
+		end_opal_session,
+		NULL
+	};
+
+	dev->funcs = _unlock_funcs;
+	return next(dev);
+}
+
+static int opal_lock_unlock(struct opal_dev *dev, struct opal_lock_unlock *lk_unlk)
+{
+	void *func_data[3] = { NULL };
+	int ret;
+
+	if (lk_unlk->session.who < OPAL_ADMIN1 ||
+	    lk_unlk->session.who > OPAL_USER9)
+		return -EINVAL;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev, NULL);
+	dev->func_data = func_data;
+	dev->func_data[1] = &lk_unlk->session;
+	dev->func_data[2] = lk_unlk;
+
+	if (lk_unlk->session.sum)
+		ret = __opal_lock_unlock_sum(dev);
+	else
+		ret = __opal_lock_unlock(dev);
+
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
+static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
+{
+	static const opal_step owner_funcs[] = {
+		opal_discovery0,
+		start_anybodyASP_opal_session,
+		get_msid_cpin_pin,
+		end_opal_session,
+		start_SIDASP_opal_session,
+		set_sid_cpin_pin,
+		end_opal_session,
+		NULL
+	};
+	void *data[6] = { NULL };
+	int ret;
+
+	if (!dev)
+		return -ENODEV;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev, owner_funcs);
+	dev->func_data = data;
+	dev->func_data[4] = opal;
+	dev->func_data[5] = opal;
+	ret = next(dev);
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
+static int opal_activate_lsp(struct opal_dev *dev, struct opal_lr_act *opal_lr_act)
+{
+	void *data[4] = { NULL };
+	static const opal_step active_funcs[] = {
+		opal_discovery0,
+		start_SIDASP_opal_session, /* Open session as SID auth */
+		get_lsp_lifecycle,
+		activate_lsp,
+		end_opal_session,
+		NULL
+	};
+	int ret;
+
+	if (!opal_lr_act->num_lrs || opal_lr_act->num_lrs > OPAL_MAX_LRS)
+		return -EINVAL;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev, active_funcs);
+	dev->func_data = data;
+	dev->func_data[1] = &opal_lr_act->key;
+	dev->func_data[3] = opal_lr_act;
+	ret = next(dev);
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
+static int opal_setup_locking_range(struct opal_dev *dev,
+				    struct opal_user_lr_setup *opal_lrs)
+{
+	void *data[3] = { NULL };
+	static const opal_step lr_funcs[] = {
+		opal_discovery0,
+		start_auth_opal_session,
+		setup_locking_range,
+		end_opal_session,
+		NULL,
+	};
+	int ret;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev, lr_funcs);
+	dev->func_data = data;
+	dev->func_data[1] = &opal_lrs->session;
+	dev->func_data[2] = opal_lrs;
+	ret = next(dev);
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
+static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
+{
+	static const opal_step pw_funcs[] = {
+		opal_discovery0,
+		start_auth_opal_session,
+		set_new_pw,
+		end_opal_session,
+		NULL
+	};
+	void *data[3] = { NULL };
+	int ret;
+
+	if (opal_pw->session.who < OPAL_ADMIN1 ||
+	    opal_pw->session.who > OPAL_USER9  ||
+	    opal_pw->new_user_pw.who < OPAL_ADMIN1 ||
+	    opal_pw->new_user_pw.who > OPAL_USER9)
+		return -EINVAL;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev, pw_funcs);
+	dev->func_data = data;
+	dev->func_data[1] = (void *) &opal_pw->session;
+	dev->func_data[2] = (void *) &opal_pw->new_user_pw;
+
+	ret = next(dev);
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
+static int opal_activate_user(struct opal_dev *dev,
+			      struct opal_session_info *opal_session)
+{
+	static const opal_step act_funcs[] = {
+		opal_discovery0,
+		start_admin1LSP_opal_session,
+		internal_activate_user,
+		end_opal_session,
+		NULL
+	};
+	void *data[3] = { NULL };
+	int ret;
+
+	/* We can't activate Admin1 it's active as manufactured */
+	if (opal_session->who < OPAL_USER1 &&
+	    opal_session->who > OPAL_USER9) {
+		pr_err("Who was not a valid user: %d\n", opal_session->who);
+		return -EINVAL;
+	}
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev, act_funcs);
+	dev->func_data = data;
+	dev->func_data[1] = &opal_session->opal_key;
+	dev->func_data[2] = opal_session;
+	ret = next(dev);
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
+bool opal_unlock_from_suspend(struct opal_dev *dev)
+{
+	struct opal_suspend_data *suspend;
+	void *func_data[3] = { NULL };
+	bool was_failure = false;
+	int ret = 0;
+
+	if (!dev)
+		return false;
+	if (!dev->supported)
+		return false;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev, NULL);
+	dev->func_data = func_data;
+
+	list_for_each_entry(suspend, &dev->unlk_lst, node) {
+		dev->state = 0;
+		dev->func_data[1] = &suspend->unlk.session;
+		dev->func_data[2] = &suspend->unlk;
+		dev->tsn = 0;
+		dev->hsn = 0;
+
+		if (suspend->unlk.session.sum)
+			ret = __opal_lock_unlock_sum(dev);
+		else
+			ret = __opal_lock_unlock(dev);
+		if (ret) {
+			pr_warn("Failed to unlock LR %hhu with sum %d\n",
+				suspend->unlk.session.opal_key.lr,
+				suspend->unlk.session.sum);
+			was_failure = true;
+		}
+	}
+	mutex_unlock(&dev->dev_lock);
+	return was_failure;
+}
+EXPORT_SYMBOL(opal_unlock_from_suspend);
+
+int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
+{
+	void __user *arg = (void __user *)ptr;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (!dev->supported) {
+		pr_err("Not supported\n");
+		return -ENOTSUPP;
+	}
+
+	switch (cmd) {
+	case IOC_OPAL_SAVE: {
+		struct opal_lock_unlock lk_unlk;
+
+		if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
+			return -EFAULT;
+		return opal_save(dev, &lk_unlk);
+	}
+	case IOC_OPAL_LOCK_UNLOCK: {
+		struct opal_lock_unlock lk_unlk;
+
+		if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
+			return -EFAULT;
+		return opal_lock_unlock(dev, &lk_unlk);
+	}
+	case IOC_OPAL_TAKE_OWNERSHIP: {
+		struct opal_key opal_key;
+
+		if (copy_from_user(&opal_key, arg, sizeof(opal_key)))
+			return -EFAULT;
+		return opal_take_ownership(dev, &opal_key);
+	}
+	case IOC_OPAL_ACTIVATE_LSP: {
+		struct opal_lr_act opal_lr_act;
+
+		if (copy_from_user(&opal_lr_act, arg, sizeof(opal_lr_act)))
+			return -EFAULT;
+		return opal_activate_lsp(dev, &opal_lr_act);
+	}
+	case IOC_OPAL_SET_PW: {
+		struct opal_new_pw opal_pw;
+
+		if (copy_from_user(&opal_pw, arg, sizeof(opal_pw)))
+			return -EFAULT;
+		return opal_set_new_pw(dev, &opal_pw);
+	}
+	case IOC_OPAL_ACTIVATE_USR: {
+		struct opal_session_info session;
+
+		if (copy_from_user(&session, arg, sizeof(session)))
+			return -EFAULT;
+		return opal_activate_user(dev, &session);
+	}
+	case IOC_OPAL_REVERT_TPR: {
+		struct opal_key opal_key;
+
+		if (copy_from_user(&opal_key, arg, sizeof(opal_key)))
+			return -EFAULT;
+		return opal_reverttper(dev, &opal_key);
+	}
+	case IOC_OPAL_LR_SETUP: {
+		struct opal_user_lr_setup lrs;
+
+		if (copy_from_user(&lrs, arg, sizeof(lrs)))
+			return -EFAULT;
+		return opal_setup_locking_range(dev, &lrs);
+	}
+	case IOC_OPAL_ADD_USR_TO_LR: {
+		struct opal_lock_unlock lk_unlk;
+
+		if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
+			return -EFAULT;
+		return opal_add_user_to_lr(dev, &lk_unlk);
+	}
+	case IOC_OPAL_ENABLE_DISABLE_MBR: {
+		struct opal_mbr_data mbr;
+
+		if (copy_from_user(&mbr, arg, sizeof(mbr)))
+			return -EFAULT;
+		return opal_enable_disable_shadow_mbr(dev, &mbr);
+	}
+	case IOC_OPAL_ERASE_LR: {
+		struct opal_session_info session;
+
+		if (copy_from_user(&session, arg, sizeof(session)))
+			return -EFAULT;
+		return opal_erase_locking_range(dev, &session);
+	}
+	case IOC_OPAL_SECURE_ERASE_LR: {
+		struct opal_session_info session;
+
+		if (copy_from_user(&session, arg, sizeof(session)))
+			return -EFAULT;
+		return opal_secure_erase_locking_range(dev, &session);
+	}
+	default:
+		pr_warn("No such Opal Ioctl %u\n", cmd);
+	}
+	return -ENOTTY;
+}
+EXPORT_SYMBOL_GPL(sed_ioctl);
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
new file mode 100644
index 0000000..af1a85e
--- /dev/null
+++ b/include/linux/sed-opal.h
@@ -0,0 +1,178 @@
+/*
+ * Copyright ? 2016 Intel Corporation
+ *
+ * Authors:
+ *    Rafael Antognolli <rafael.antognolli at intel.com>
+ *    Scott  Bauer      <scott.bauer at intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef LINUX_OPAL_H
+#define LINUX_OPAL_H
+
+#include <uapi/linux/sed-opal.h>
+#include <linux/kernel.h>
+
+/*
+ * These constant values come from:
+ * SPC-4 section
+ * 6.30 SECURITY PROTOCOL IN command / table 265.
+ */
+enum {
+	TCG_SECP_00 = 0,
+	TCG_SECP_01,
+};
+struct opal_dev;
+
+#define IO_BUFFER_LENGTH 2048
+#define MAX_TOKS 64
+
+typedef int (*opal_step)(struct opal_dev *dev);
+typedef int (sec_send_recv)(struct opal_dev *ctx, u16 spsp, u8 secp,
+			    void *buffer, size_t len, bool send);
+
+
+enum opal_atom_width {
+	OPAL_WIDTH_TINY,
+	OPAL_WIDTH_SHORT,
+	OPAL_WIDTH_MEDIUM,
+	OPAL_WIDTH_LONG,
+	OPAL_WIDTH_TOKEN
+};
+
+/*
+ * Token defs derived from:
+ * TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
+ * 3.2.2 Data Stream Encoding
+ */
+enum opal_response_token {
+	OPAL_DTA_TOKENID_BYTESTRING = 0xe0,
+	OPAL_DTA_TOKENID_SINT = 0xe1,
+	OPAL_DTA_TOKENID_UINT = 0xe2,
+	OPAL_DTA_TOKENID_TOKEN = 0xe3, /* actual token is returned */
+	OPAL_DTA_TOKENID_INVALID = 0X0
+};
+
+/*
+ * On the parsed response, we don't store again the toks that are already
+ * stored in the response buffer. Instead, for each token, we just store a
+ * pointer to the position in the buffer where the token starts, and the size
+ * of the token in bytes.
+ */
+struct opal_resp_tok {
+	const u8 *pos;
+	size_t len;
+	enum opal_response_token type;
+	enum opal_atom_width width;
+	union {
+		u64 u;
+		s64 s;
+	} stored;
+};
+
+/*
+ * From the response header it's not possible to know how many tokens there are
+ * on the payload. So we hardcode that the maximum will be MAX_TOKS, and later
+ * if we start dealing with messages that have more than that, we can increase
+ * this number. This is done to avoid having to make two passes through the
+ * response, the first one counting how many tokens we have and the second one
+ * actually storing the positions.
+ */
+struct parsed_resp {
+	int num;
+	struct opal_resp_tok toks[MAX_TOKS];
+};
+
+/**
+ * struct opal_dev - The structure representing a OPAL enabled SED.
+ * @supported: Whether or not OPAL is supported on this controller.
+ * @send_recv: The combined sec_send/sec_recv function pointer.
+ * @opal_step: A series of opal methods that are necessary to complete a command.
+ * @func_data: An array of parameters for the opal methods above.
+ * @state: Describes the current opal_step we're working on.
+ * @dev_lock: Locks the entire opal_dev structure.
+ * @parsed: Parsed response from controller.
+ * @prev_data: Data returned from a method to the controller.
+ * @unlk_lst: A list of Locking ranges to unlock on this device during a resume.
+ */
+struct opal_dev {
+	bool initialized;
+	bool supported;
+	sec_send_recv *send_recv;
+
+	const opal_step *funcs;
+	void **func_data;
+	int state;
+	struct mutex dev_lock;
+	u16 comid;
+	u32 hsn;
+	u32 tsn;
+	u64 align;
+	u64 lowest_lba;
+
+	size_t pos;
+	u8 cmd[IO_BUFFER_LENGTH];
+	u8 resp[IO_BUFFER_LENGTH];
+
+	struct parsed_resp parsed;
+	size_t prev_d_len;
+	void *prev_data;
+
+	struct list_head unlk_lst;
+};
+
+#ifdef CONFIG_BLK_SED_OPAL
+bool opal_unlock_from_suspend(struct opal_dev *dev);
+void init_opal_dev(struct opal_dev *opal_dev, sec_send_recv *send_recv);
+int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr);
+
+static inline bool is_sed_ioctl(unsigned int cmd)
+{
+	switch (cmd) {
+	case IOC_OPAL_SAVE:
+	case IOC_OPAL_LOCK_UNLOCK:
+	case IOC_OPAL_TAKE_OWNERSHIP:
+	case IOC_OPAL_ACTIVATE_LSP:
+	case IOC_OPAL_SET_PW:
+	case IOC_OPAL_ACTIVATE_USR:
+	case IOC_OPAL_REVERT_TPR:
+	case IOC_OPAL_LR_SETUP:
+	case IOC_OPAL_ADD_USR_TO_LR:
+	case IOC_OPAL_ENABLE_DISABLE_MBR:
+	case IOC_OPAL_ERASE_LR:
+	case IOC_OPAL_SECURE_ERASE_LR:
+		return true;
+	}
+	return false;
+}
+#else
+static inline bool is_sed_ioctl(unsigned int cmd)
+{
+	return false;
+}
+
+static inline int sed_ioctl(struct opal_dev *dev, unsigned int cmd,
+			    unsigned long ptr)
+{
+	return 0;
+}
+static inline bool opal_unlock_from_suspend(struct opal_dev *dev)
+{
+	return false;
+}
+static inline void init_opal_dev(struct opal_dev *opal_dev,
+				 sec_send_recv *send_recv)
+{
+	opal_dev->supported = false;
+	opal_dev->initialized = true;
+}
+#endif /* CONFIG_BLK_SED_OPAL */
+#endif /* LINUX_OPAL_H */
-- 
2.7.4
