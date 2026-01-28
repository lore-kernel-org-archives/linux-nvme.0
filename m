Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A6BD35697
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jan 2026 10:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ptG40qQKvESqH1YjQN4Y4RzXfVqIoUaSWSWV8LP09xY=; b=g2CCC941pq0pqKz+yfMv1ISoxE
	kCFpcAZuxi09VcipwtJPTKuoy0ku5HebPd9geWfp2UXMKVHpwn7ymXpw78QLQK/ygsQuODvM0N5gT
	+zH585zRuOxyv/gjEtI0QzdYFf6nlreEACJfnNYBZi4kJHzPR25TMusVLPJIP1L+vitXnsCzqtCUN
	Z6kMxwXeZHuLYXOeJhPHhfXYW25CFPCcpFTQ2mqzwhvBdICpN/c9a5OwZWvtCHKqCtkLoHdmNl4fs
	LTT4/cGFXQHECKeeXIi07hoWtH6836CtQr0xAEEeKZIB5hYDK4xOhPHy1oNWSDHhXnrLKX9M6K+Re
	anMCwyRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl2t9-0000000Fq1H-3sV8;
	Wed, 28 Jan 2026 10:35:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl2t7-0000000Fq0G-1Ig9
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jan 2026 10:35:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769596504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptG40qQKvESqH1YjQN4Y4RzXfVqIoUaSWSWV8LP09xY=;
	b=VWWxFkBVF50dhwtXxWDB5qpIENGEcnyahaGzWfRRKRfFk2rN3CoTG6Utz1FmoG5QyIZaxv
	vbd2xvriTDNohAI9Ma3OBaspbiDgXaLbACCLeNjJ+5X0A24eIbArIq+cPqOSBXb+Ax1Su0
	VT1LvyAEFYS6nIIaxQPfTwc2ZpKgcWM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-dj_YkB5rPbmRumtf1R9xGg-1; Wed,
 28 Jan 2026 05:33:31 -0500
X-MC-Unique: dj_YkB5rPbmRumtf1R9xGg-1
X-Mimecast-MFC-AGG-ID: dj_YkB5rPbmRumtf1R9xGg_1769596410
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50A0419792D8;
	Wed, 28 Jan 2026 10:33:28 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.45.224.140])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E0981956095;
	Wed, 28 Jan 2026 10:33:24 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	hare@suse.de,
	jmeneghi@redhat.com,
	emilne@redhat.com,
	mlombard@bsdbackstore.eu
Subject: [PATCH 1/1] nvme: add support for dynamic quirk configuration via module parameter
Date: Wed, 28 Jan 2026 11:33:18 +0100
Message-ID: <20260128103318.76842-2-mlombard@redhat.com>
In-Reply-To: <20260128103318.76842-1-mlombard@redhat.com>
References: <20260128103318.76842-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9xJhkVLfMJagLyAbpxE3vHrEwxRNC-ibt-QEbGUsfAM_1769596410
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260128_023505_423788_51C10D1B 
X-CRM114-Status: GOOD (  23.48  )
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

Introduce support for enabling or disabling specific NVMe quirks at
module load time through the `quirks` module parameter.
This mechanism allows users to apply known quirks dynamically
based on the device's PCI vendor and device IDs,
without requiring to add hardcoded entries in the driver
and recompiling the kernel.

While the generic PCI new_id sysfs interface exists for
dynamic configuration, it is insufficient for scenarios where
the system fails to boot (for example, this has been reported to happen
because of the bogus_nid quirk). The new_id attribute is writable
only after the system has booted and sysfs is mounted.

The `quirks` parameter accepts a list of quirk
specifications separated by a '-' character in the following format:

  <VID>:<DID>:<quirk_names>[-<VID>:<DID>:<quirk_names>-..]

Each quirk is represented by its name and can be prefixed with
`^` to indicate that the quirk should be disabled.
Quirk names are separated by a ',' character.

Example usage (enable BOGUS_NID and BROKEN_MSI, disable DEALLOCATE_ZEROES):

  $ modprobe nvme quirks=7170:2210:bogus_nid,broken_msi,^deallocate_zeroes

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Tested-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 .../admin-guide/kernel-parameters.txt         |  13 ++
 drivers/nvme/host/pci.c                       | 154 ++++++++++++++++++
 2 files changed, 167 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a8d0afde7f85..e559648f97e6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -74,6 +74,7 @@
 	TPM	TPM drivers are enabled.
 	UMS	USB Mass Storage support is enabled.
 	USB	USB support is enabled.
+	NVME	NVMe support is enabled
 	USBHID	USB Human Interface Device support is enabled.
 	V4L	Video For Linux support is enabled.
 	VGA	The VGA console has been enabled.
@@ -4671,6 +4672,18 @@ Kernel parameters
 			This can be set from sysctl after boot.
 			See Documentation/admin-guide/sysctl/vm.rst for details.
 
+	nvme.quirks=    [NVME] A list of quirk entries to augment the built-in
+			nvme quirk list. List entries are separated by a
+			'-' character.
+			Each entry has the form VendorID:ProductID:quirk_names.
+			The IDs are 4-digits hex numbers and quirk_names is a
+			list of quirk names separated by commas. A quirk name can
+			be prefixed by '^', meaning that the specified quirk must
+			be disabled.
+
+			Example:
+			nvme.quirks=7710:2267:bogus_nid,^identify_cns-9900:7711:broken_msi
+
 	ohci1394_dma=early	[HW,EARLY] enable debugging via the ohci1394 driver.
 			See Documentation/core-api/debugging-via-ohci1394.rst for more
 			info.
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9fc4a60280a0..512c5cecc6f0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -72,6 +72,13 @@
 static_assert(MAX_PRP_RANGE / NVME_CTRL_PAGE_SIZE <=
 	(1 /* prp1 */ + NVME_MAX_NR_DESCRIPTORS * PRPS_PER_PAGE));
 
+struct quirk_entry {
+	u16 vendor_id;
+	u16 dev_id;
+	u32 enabled_quirks;
+	u32 disabled_quirks;
+};
+
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
 
@@ -102,6 +109,132 @@ static unsigned int io_queue_depth = 1024;
 module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
 MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2 and < 4096");
 
+static int quirks_param_set(const char *value, const struct kernel_param *kp);
+static char quirks_param[128];
+static const struct kernel_param_ops quirks_param_ops = {
+	.set = quirks_param_set,
+	.get = param_get_string,
+};
+
+static struct kparam_string quirks_param_string = {
+	.maxlen = sizeof(quirks_param),
+	.string = quirks_param,
+};
+
+static struct quirk_entry *quirk_list;
+static unsigned int quirk_count;
+module_param_cb(quirks, &quirks_param_ops, &quirks_param_string, 0644);
+MODULE_PARM_DESC(quirks, "Enable/disable NVMe quirks by specifying quirks=vendorID:deviceID:quirk_names");
+
+static int quirks_param_set(const char *value, const struct kernel_param *kp)
+{
+	char *val, *outer_ptr, *inner_ptr, *field;
+	char *q_name;
+	u16 vid, did;
+	u32 *flags;
+	size_t i = 0, q_len, field_len;
+	int err, b;
+
+	val = kstrdup(value, GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
+
+	err = param_set_copystring(val, kp);
+	if (err)
+		goto exit;
+
+	kfree(quirk_list);
+	quirk_list = NULL;
+
+	if (!*val) {
+		quirk_count = 0;
+		goto exit;
+	}
+
+	for (quirk_count = 1, i = 0; val[i]; i++)
+		if (val[i] == '-')
+			quirk_count++;
+
+	quirk_list = kcalloc(quirk_count, sizeof(struct quirk_entry),
+			     GFP_KERNEL);
+	if (!quirk_list) {
+		quirk_count = 0;
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i = 0;
+	outer_ptr = val;
+	while ((field = strsep(&outer_ptr, "-"))) {
+		inner_ptr = field;
+
+		/* Each entry consists of VID:DID:quirk_names */
+		field = strsep(&inner_ptr, ":");
+		if (!field) {
+			pr_err("nvme: malformed quirks string: %s\n",
+							value);
+			break;
+		}
+
+		if (kstrtou16(field, 16, &vid)) {
+			pr_err("nvme: malformed vendor id: %s\n", field);
+			break;
+		}
+
+		field = strsep(&inner_ptr, ":");
+		if (!field) {
+			pr_err("nvme: malformed quirks string: %s\n",
+							value);
+			break;
+		}
+
+		if (kstrtou16(field, 16, &did)) {
+			pr_err("nvme: malformed device id: %s\n", field);
+			break;
+		}
+
+		while ((field = strsep(&inner_ptr, ",")) && *field) {
+
+			/* Each entry consists of a quirk name */
+
+			if (*field == '^') {
+				flags = &quirk_list[i].disabled_quirks;
+				field++;
+			} else {
+				flags = &quirk_list[i].enabled_quirks;
+			}
+
+			field_len = strlen(field);
+			for (b = 0; ; ++b) {
+				q_name = nvme_quirk_name(BIT(b));
+				q_len = strlen(q_name);
+
+				if (!strcmp(q_name, "unknown")) {
+					pr_err("nvme: unrecognized quirk %s\n",
+									field);
+					break;
+				}
+				if (!strncmp(q_name, field, q_len) &&
+							q_len == field_len) {
+					*flags |= BIT(b);
+					break;
+				}
+			}
+		}
+
+		quirk_list[i].vendor_id = vid;
+		quirk_list[i].dev_id = did;
+		++i;
+	}
+
+	if (i < quirk_count)
+		quirk_count = i;
+
+exit:
+	kfree(val);
+	return err;
+}
+
 static int io_queue_count_set(const char *val, const struct kernel_param *kp)
 {
 	unsigned int n;
@@ -3439,12 +3572,27 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	return 0;
 }
 
+static struct quirk_entry *detect_dynamic_quirks(struct pci_dev *pdev)
+{
+	int i;
+
+	for (i = 0; i < quirk_count; ++i) {
+		if (pdev->vendor == quirk_list[i].vendor_id &&
+		    pdev->device == quirk_list[i].dev_id) {
+			return &quirk_list[i];
+		}
+	}
+
+	return NULL;
+}
+
 static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 		const struct pci_device_id *id)
 {
 	unsigned long quirks = id->driver_data;
 	int node = dev_to_node(&pdev->dev);
 	struct nvme_dev *dev;
+	struct quirk_entry *qentry;
 	int ret = -ENOMEM;
 
 	dev = kzalloc_node(struct_size(dev, descriptor_pools, nr_node_ids),
@@ -3476,6 +3624,11 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 			 "platform quirk: setting simple suspend\n");
 		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
 	}
+	qentry = detect_dynamic_quirks(pdev);
+	if (qentry) {
+		quirks |= qentry->enabled_quirks;
+		quirks &= ~(qentry->disabled_quirks);
+	}
 	ret = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
 			     quirks);
 	if (ret)
@@ -4074,6 +4227,7 @@ static int __init nvme_init(void)
 
 static void __exit nvme_exit(void)
 {
+	kfree(quirk_list);
 	pci_unregister_driver(&nvme_driver);
 	flush_workqueue(nvme_wq);
 }
-- 
2.52.0


