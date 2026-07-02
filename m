Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D530C43327
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 09:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TqQirHw2qBmg81uFLIEoRsWXee6/JuErpAeck/jh1XM=; b=4AqFzlo7L3HmdjRRxC7oqsGoUx
	NBd9LblYuJWctd3JBEAtKnLk8MazPmQZk5YDlFPOHclLBZLjjooCgKc4PdCE+S9w4mN3vHrEXzAa5
	ht8n8fzeoVP97flbVacI5+q8K6sk14vrjd32okTzim6USFEd6dkvH5a3WZ/PHHf77cBJA5WXI/68T
	pFpbnDbq2xnZP8BhM4iHGOhK9IrkiNo7UZklK1UTNCckCW33iy1aTqYnzDIWP2x1dY2kznHKUMVla
	Xl1uGrcyk19bqNZ4uHehAE4Af17lZfnzpyX9f16eFFafccRyp0dH9qG66DUeUtjZiv7no/23+6q/w
	9NA3+9pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfE9D-000000046Mg-1mGe;
	Thu, 02 Jul 2026 09:55:55 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfE98-000000046Kp-43SB
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 09:55:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782986149; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TqQirHw2qBmg81uFLIEoRsWXee6/JuErpAeck/jh1XM=;
	b=lGJThOn184ODn2qR3cyeKVNixfNpGc1h7qS1JSbsE5We5pcDDhdT5WRUg3C/XGqn9p9gsmf84KCdrKlBI6QR/xCnKXPBtzQawyzv02BRkaCQ8ZgpeipFjI+duBEsNSlNj7EDfIuV+0BPT6wNiEtpobZBXaZ47Q+kwRvJ7+nqv2E=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6DxMdk_1782986148;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6DxMdk_1782986148 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Jul 2026 17:55:48 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v2 2/3] nvmet: add ABI documentation for target configfs interfaces
Date: Thu,  2 Jul 2026 17:55:40 +0800
Message-ID: <20260702095541.1145128-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260702095541.1145128-1-kanie@linux.alibaba.com>
References: <20260702095541.1145128-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_025551_337430_BB7A21D6 
X-CRM114-Status: GOOD (  19.12  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add Documentation/ABI/testing/configfs-nvmet documenting all NVMe
target configfs attributes, covering port attributes, subsystem
attributes, namespace attributes, host authentication, passthrough
mode, and ANA configuration.

Each entry has been traced to its original introducing commit to
provide accurate Date, KernelVersion, and Contact information.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
v1->v2:
 - Group attributes by object type (ports, subsystems, hosts).
 - Merge dhchap_dhgroup into the DH-HMAC-CHAP host authentication entry.
 - Split the combined ANA and PI-enable entries into separate port and
   subsystem entries.

 Documentation/ABI/testing/configfs-nvmet | 352 +++++++++++++++++++++++
 1 file changed, 352 insertions(+)
 create mode 100644 Documentation/ABI/testing/configfs-nvmet

diff --git a/Documentation/ABI/testing/configfs-nvmet b/Documentation/ABI/testing/configfs-nvmet
new file mode 100644
index 000000000000..36b587404ee7
--- /dev/null
+++ b/Documentation/ABI/testing/configfs-nvmet
@@ -0,0 +1,352 @@
+What:		/config/nvmet/ports/N/addr_adrfam
+What:		/config/nvmet/ports/N/addr_portid
+What:		/config/nvmet/ports/N/addr_traddr
+What:		/config/nvmet/ports/N/addr_trsvcid
+What:		/config/nvmet/ports/N/addr_trtype
+What:		/config/nvmet/ports/N/addr_treq
+Date:		June 2016
+KernelVersion:	4.8
+Contact:	Christoph Hellwig <hch@lst.de>
+Description:
+		Address attributes for an NVMe-oF target port.
+
+		addr_adrfam: Shows or sets the address family. Accepted
+		values: "pcie", "ipv4", "ipv6", "ib", "fc", "pci", "loop".
+
+		addr_portid: Shows or sets the port identifier (u16).
+
+		addr_traddr: Shows or sets the transport address string.
+
+		addr_trsvcid: Shows or sets the transport service identifier.
+
+		addr_trtype: Shows or sets the transport type. Accepted
+		values: "rdma", "fc", "tcp", "pci", "loop". Also
+		initializes default TSAS values.
+
+		addr_treq: Shows or sets the transport security requirements.
+		Accepted values: "not specified", "required",
+		"not required". For TCP with TLS1.3, "not specified" is
+		rejected.
+
+		All attributes require the port to be disabled before
+		modification.
+
+What:		/config/nvmet/ports/N/referrals/NAME/addr_adrfam
+What:		/config/nvmet/ports/N/referrals/NAME/addr_portid
+What:		/config/nvmet/ports/N/referrals/NAME/addr_traddr
+What:		/config/nvmet/ports/N/referrals/NAME/addr_trsvcid
+What:		/config/nvmet/ports/N/referrals/NAME/addr_trtype
+What:		/config/nvmet/ports/N/referrals/NAME/addr_treq
+What:		/config/nvmet/ports/N/referrals/NAME/enable
+Date:		June 2016
+KernelVersion:	4.8
+Contact:	Christoph Hellwig <hch@lst.de>
+Description:
+		Address attributes and enable control for a referral entry
+		under a port. The addr_* attributes have the same semantics
+		as the corresponding port-level attributes. The enable
+		attribute shows or sets whether this referral is enabled
+		(boolean).
+
+What:		/config/nvmet/ports/N/param_inline_data_size
+Date:		June 2018
+KernelVersion:	4.19
+Contact:	Steve Wise <swise@opengridcomputing.com>
+Description:
+		Shows or sets the inline data size for this port. Default
+		is -1 which lets the transport choose. The port must be
+		disabled before modification.
+
+What:		/config/nvmet/ports/N/ana_groups/ID/ana_state
+Date:		June 2018
+KernelVersion:	4.19
+Contact:	Christoph Hellwig <hch@lst.de>
+Description:
+		Shows or sets the ANA (Asymmetric Namespace Access) state
+		for this group on this port. Accepted values: "optimized",
+		"non-optimized", "inaccessible", "persistent-loss",
+		"change". Changes trigger an ANA change event.
+
+What:		/config/nvmet/ports/N/param_pi_enable
+Date:		May 2020
+KernelVersion:	5.8
+Contact:	Israel Rukshin <israelr@mellanox.com>
+Description:
+		Shows or sets whether protection information (PI) is
+		enabled/supported for this port. Accepts boolean value.
+		Only available when CONFIG_BLK_DEV_INTEGRITY is enabled.
+		The port must be disabled before modification.
+
+What:		/config/nvmet/ports/N/addr_tsas
+Date:		August 2023
+KernelVersion:	6.7
+Contact:	Hannes Reinecke <hare@suse.de>
+Description:
+		Shows or sets the transport-specific address subtype. For
+		TCP transport, accepted values: "none", "tls1.3" (requires
+		CONFIG_NVME_TARGET_TCP_TLS). For RDMA transport, shows the
+		QP type: "connected" or "datagram". The port must be
+		disabled before modification.
+
+What:		/config/nvmet/ports/N/param_max_queue_size
+Date:		January 2024
+KernelVersion:	6.9
+Contact:	Max Gurtovoy <mgurtovoy@nvidia.com>
+Description:
+		Shows or sets the maximum queue size for this port. Default
+		is -1 which lets the transport choose. The port must be
+		disabled before modification.
+
+What:		/config/nvmet/ports/N/param_mdts
+Date:		April 2026
+KernelVersion:	7.1
+Contact:	Aurelien Aptel <aaptel@nvidia.com>
+Description:
+		Shows or sets the maximum data transfer size for this port.
+		Default is -1 which lets the transport choose. The port
+		must be disabled before modification.
+
+What:		/config/nvmet/subsystems/NAME/attr_allow_any_host
+Date:		June 2016
+KernelVersion:	4.8
+Contact:	Christoph Hellwig <hch@lst.de>
+Description:
+		Shows or sets whether any host is allowed to connect.
+		Accepts boolean value. Cannot be set to 1 if explicit
+		hosts are linked in the allowed_hosts/ directory.
+
+What:		/config/nvmet/subsystems/NAME/namespaces/NSID/device_path
+What:		/config/nvmet/subsystems/NAME/namespaces/NSID/device_nguid
+What:		/config/nvmet/subsystems/NAME/namespaces/NSID/enable
+Date:		June 2016
+KernelVersion:	4.8
+Contact:	Christoph Hellwig <hch@lst.de>
+Description:
+		Namespace attributes added with the initial NVMe target.
+
+		device_path: Shows or sets the backend block device path.
+		The namespace must be disabled before modification.
+
+		device_nguid: Shows or sets the NGUID (128-bit identifier).
+		Accepts 32 hex digits with optional "-" or ":" separators.
+		The namespace must be disabled before modification.
+
+		enable: Shows or sets whether this namespace is enabled
+		(boolean).
+
+What:		/config/nvmet/subsystems/NAME/namespaces/NSID/device_uuid
+Date:		June 2017
+KernelVersion:	4.13
+Contact:	Johannes Thumshirn <jthumshirn@suse.de>
+Description:
+		Shows or sets the UUID for this namespace. The namespace
+		must be disabled before modification.
+
+What:		/config/nvmet/subsystems/NAME/attr_version
+What:		/config/nvmet/subsystems/NAME/attr_serial
+Date:		July 2017
+KernelVersion:	4.13
+Contact:	Johannes Thumshirn <jthumshirn@suse.de>
+Description:
+		attr_version: Shows or sets the NVMe version reported by
+		this subsystem. Format: "major.minor" or
+		"major.minor.tertiary". Cannot be changed after the
+		subsystem has been discovered.
+
+		attr_serial: Shows or sets the serial number. Must be a
+		1-20 byte ASCII string (characters 0x20-0x7e). Cannot be
+		changed after the subsystem has been discovered.
+
+What:		/config/nvmet/subsystems/NAME/namespaces/NSID/ana_grpid
+Date:		June 2018
+KernelVersion:	4.19
+Contact:	Christoph Hellwig <hch@lst.de>
+Description:
+		Shows or sets the ANA (Asymmetric Namespace Access) Group
+		ID for this namespace. Must be between 1 and 128. Changing
+		triggers an ANA event notification.
+
+What:		/config/nvmet/subsystems/NAME/namespaces/NSID/buffered_io
+Date:		June 2018
+KernelVersion:	4.19
+Contact:	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
+Description:
+		Shows or sets whether buffered I/O is used for this
+		namespace. Accepts boolean value. The namespace must be
+		disabled before modification.
+
+What:		/config/nvmet/subsystems/NAME/namespaces/NSID/p2pmem
+Date:		October 2018
+KernelVersion:	4.20
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:
+		Shows or sets the P2P DMA memory device for this namespace.
+		Accepts a PCI device BDF, "auto", or "none". The namespace
+		must be disabled before modification. Only available when
+		CONFIG_PCI_P2PDMA is enabled.
+
+What:		/config/nvmet/subsystems/NAME/attr_cntlid_min
+What:		/config/nvmet/subsystems/NAME/attr_cntlid_max
+Date:		January 2020
+KernelVersion:	5.7
+Contact:	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
+Description:
+		attr_cntlid_min: Shows or sets the minimum controller ID
+		(u16). Must be nonzero and not greater than attr_cntlid_max.
+
+		attr_cntlid_max: Shows or sets the maximum controller ID
+		(u16). Must be nonzero and not less than attr_cntlid_min.
+
+What:		/config/nvmet/subsystems/NAME/attr_model
+Date:		January 2020
+KernelVersion:	5.7
+Contact:	Mark Ruijter <MRuijter@onestopsystems.com>
+Description:
+		Shows or sets the model number for this subsystem. Must
+		be a 1-40 byte ASCII string (characters 0x20-0x7e).
+		Cannot be changed after the subsystem has been discovered.
+
+What:		/config/nvmet/subsystems/NAME/attr_pi_enable
+Date:		May 2020
+KernelVersion:	5.8
+Contact:	Israel Rukshin <israelr@mellanox.com>
+Description:
+		Shows or sets whether protection information (PI) is
+		enabled/supported for this subsystem. Accepts boolean
+		value. Only available when CONFIG_BLK_DEV_INTEGRITY is
+		enabled.
+
+What:		/config/nvmet/subsystems/NAME/namespaces/NSID/revalidate_size
+Date:		May 2020
+KernelVersion:	5.8
+Contact:	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
+Description:
+		Write-only. Writing 1 triggers namespace size revalidation.
+		If the size has changed, a namespace changed AEN is sent.
+		The namespace must be enabled.
+
+What:		/config/nvmet/subsystems/NAME/passthru/device_path
+What:		/config/nvmet/subsystems/NAME/passthru/enable
+Date:		July 2020
+KernelVersion:	5.9
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:
+		Passthrough mode attributes.
+
+		device_path: Shows or sets the NVMe controller character
+		device path (e.g., /dev/nvme0). Cannot be changed while
+		the passthrough controller is active.
+
+		enable: Shows or sets whether passthrough mode is enabled
+		(boolean).
+
+		Only available when CONFIG_NVME_TARGET_PASSTHRU is enabled.
+
+What:		/config/nvmet/subsystems/NAME/passthru/admin_timeout
+What:		/config/nvmet/subsystems/NAME/passthru/io_timeout
+Date:		November 2020
+KernelVersion:	5.11
+Contact:	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
+Description:
+		admin_timeout: Shows or sets the admin command timeout for
+		passthrough mode, in jiffies.
+
+		io_timeout: Shows or sets the I/O command timeout for
+		passthrough mode, in jiffies.
+
+		Only available when CONFIG_NVME_TARGET_PASSTHRU is enabled.
+
+What:		/config/nvmet/subsystems/NAME/passthru/clear_ids
+Date:		June 2022
+KernelVersion:	5.19
+Contact:	Alan Adamson <alan.adamson@oracle.com>
+Description:
+		Shows or sets whether to clear identify data IDs in
+		passthrough mode. Only available when
+		CONFIG_NVME_TARGET_PASSTHRU is enabled.
+
+What:		/config/nvmet/subsystems/NAME/attr_qid_max
+Date:		August 2022
+KernelVersion:	6.1
+Contact:	Daniel Wagner <dwagner@suse.de>
+Description:
+		Shows or sets the maximum queue ID (number of I/O queues,
+		u16). Must be between 1 and 128. Changing this value
+		forces reconnection of all connected controllers.
+
+What:		/config/nvmet/subsystems/NAME/attr_ieee_oui
+Date:		November 2022
+KernelVersion:	6.2
+Contact:	Aleksandr Miloserdov <a.miloserdov@yadro.com>
+Description:
+		Shows or sets the IEEE OUI for this subsystem. Displayed
+		in "0x%06x" format. Must be a 24-bit value. Cannot be
+		changed after the subsystem has been discovered.
+
+What:		/config/nvmet/subsystems/NAME/attr_firmware
+Date:		November 2022
+KernelVersion:	6.2
+Contact:	Aleksandr Miloserdov <a.miloserdov@yadro.com>
+Description:
+		Shows or sets the firmware revision string for this
+		subsystem. Must be a 1-8 byte ASCII string (characters
+		0x20-0x7e). Cannot be changed after the subsystem has
+		been discovered.
+
+What:		/config/nvmet/subsystems/NAME/namespaces/NSID/resv_enable
+Date:		November 2024
+KernelVersion:	6.13
+Contact:	Guixin Liu <kanie@linux.alibaba.com>
+Description:
+		Shows or sets whether persistent reservation support is
+		enabled for this namespace. Accepts boolean value. The
+		namespace must be disabled before modification.
+
+What:		/config/nvmet/subsystems/NAME/attr_vendor_id
+What:		/config/nvmet/subsystems/NAME/attr_subsys_vendor_id
+Date:		January 2025
+KernelVersion:	6.14
+Contact:	Damien Le Moal <dlemoal@kernel.org>
+Description:
+		attr_vendor_id: Shows or sets the PCI vendor ID reported
+		by this subsystem. Displayed in "0x%x" format.
+
+		attr_subsys_vendor_id: Shows or sets the PCI subsystem
+		vendor ID. Displayed in "0x%x" format.
+
+What:		/config/nvmet/hosts/HOSTNQN/dhchap_key
+What:		/config/nvmet/hosts/HOSTNQN/dhchap_ctrl_key
+What:		/config/nvmet/hosts/HOSTNQN/dhchap_hash
+What:		/config/nvmet/hosts/HOSTNQN/dhchap_dhgroup
+Date:		June 2022
+KernelVersion:	6.0
+Contact:	Hannes Reinecke <hare@suse.de>
+Description:
+		DH-HMAC-CHAP authentication attributes.
+
+		dhchap_key: Shows or sets the host secret key. Accepts a
+		key string in "DHHC-1:" format.
+
+		dhchap_ctrl_key: Shows or sets the controller secret key
+		for bidirectional authentication. Same format as dhchap_key.
+
+		dhchap_hash: Shows or sets the HMAC hash algorithm.
+		Accepted values: "hmac(sha256)", "hmac(sha384)",
+		"hmac(sha512)".
+
+		dhchap_dhgroup: Shows or sets the Diffie-Hellman group for
+		DH-HMAC-CHAP key exchange. Accepted values: "null",
+		"ffdhe2048", "ffdhe3072", "ffdhe4096", "ffdhe6144".
+		Non-null groups require the corresponding KPP crypto
+		algorithm to be available.
+
+		Only available when CONFIG_NVME_TARGET_AUTH is enabled.
+
+What:		/config/nvmet/discovery_nqn
+Date:		April 2024
+KernelVersion:	6.9
+Contact:	Hannes Reinecke <hare@kernel.org>
+Description:
+		Shows or sets the NQN of the discovery subsystem. The
+		value must be unique and not duplicate any existing
+		subsystem name.
-- 
2.43.7


