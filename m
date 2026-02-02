Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29165E7DF16
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 17:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ALF3IEb4VsM2UoXpHzVJkAIy6JYwvHXFMA32qVy/WX8=; b=dXjmkMSi6mx8h9wLYhFCOzaxIY
	vutAtrp5kA/xFWSOEt+Ivl41hTjxz86vo7l++yo0wOT4Qb+XwG8WNQQzcYRIAKEcSzISztF+RGtO0
	v7B0wtzB7tlpt+UXmPnvyD7TqxApDmpDfzLV9j05yh8xawb/BG4N6kYE8qkZif1Vqd5J+d3rRi1Rl
	FQu3ErjdsNZ9Eu/OfUekrkPnEGn4FGjmTasWJGWKQZwMtuauwfL43d+vfFc01rc4PCisnt0ooxvXF
	DsJtLQqIoA9MsmJ6Zi/llbN67GRQdVbSla3qFljdUg9BnFzhfHiCuJ5n3teDYFebiRHCx79SzSnct
	h280tvFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmxtM-00000005N4x-13NQ;
	Mon, 02 Feb 2026 17:39:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmxtI-00000005N3q-3ce4
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 17:39:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770053951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALF3IEb4VsM2UoXpHzVJkAIy6JYwvHXFMA32qVy/WX8=;
	b=ev2OGB5DqLRO7n8C1ech5jVghaPaO4oKal39y4pl4QVYWSCBNNCC4ohIx45VA74CrIg/xk
	h9lvYCEC3r2YeiBukSm8gxdETw57u/ifTkvLEDGGxv9o7s2R4BKnLEEjfyUenp5HGHKWyG
	kKmHqw6c/b0s8SUe2yxf9Q8gyTEbxMw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-yL_1Hq7YNv295qFGG7y2uA-1; Mon,
 02 Feb 2026 12:39:08 -0500
X-MC-Unique: yL_1Hq7YNv295qFGG7y2uA-1
X-Mimecast-MFC-AGG-ID: yL_1Hq7YNv295qFGG7y2uA_1770053947
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA9011955F44;
	Mon,  2 Feb 2026 17:39:06 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.196])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC30F1955F66;
	Mon,  2 Feb 2026 17:39:03 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	hare@suse.de,
	jmeneghi@redhat.com,
	emilne@redhat.com,
	mlombard@bsdbackstore.eu
Subject: [PATCH V2 1/1] nvme: add support for dynamic quirk configuration via module parameter
Date: Mon,  2 Feb 2026 18:38:57 +0100
Message-ID: <20260202173857.759565-2-mlombard@redhat.com>
In-Reply-To: <20260202173857.759565-1-mlombard@redhat.com>
References: <20260202173857.759565-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d9-LTBAsk4AbNsmr_q_Za-Am4JBHJ8d9txe0opLzIXw_1770053947
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_093912_974183_B25D25C5 
X-CRM114-Status: GOOD (  24.08  )
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

Introduce support for enabling or disabling specific NVMe quirks at module
load time through the `quirks` module parameter.
This mechanism allows users to apply known quirks dynamically based on the
device's PCI vendor and device IDs, without requiring to add hardcoded
entries in the driver and recompiling the kernel.

While the generic PCI new_id sysfs interface exists for dynamic
configuration, it is insufficient for scenarios where the system fails
to boot (for example, this has been reported to happen because of the
bogus_nid quirk). The new_id attribute is writable only after the system
has booted and sysfs is mounted.

The `quirks` parameter accepts a list of quirk specifications separated by
a '-' character in the following format:

<VID>:<DID>:<quirk_names>[-<VID>:<DID>:<quirk_names>-..]

Each quirk is represented by its name and can be prefixed with `^` to
indicate that the quirk should be disabled; quirk names are separated by
a ',' character.

Example: enable BOGUS_NID and BROKEN_MSI, disable DEALLOCATE_ZEROES:

   $ modprobe nvme quirks=7170:2210:bogus_nid,broken_msi,^deallocate_zeroes

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Tested-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

V2: split quirk_param_set() to increase readability.
    Prefer post-increments.
    Remove braces where it makes sense.
    Avoid the BIT() macro.
    Use nvme_pci_ prefix for global variables.
    Break overly long lines, use 75-chars length consistently
    set 0444 perms to quirks param to prevent the user from changing it

 .../admin-guide/kernel-parameters.txt         |  13 ++
 drivers/nvme/host/pci.c                       | 164 ++++++++++++++++++
 2 files changed, 177 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1058f2a6d6a8..cb689fcfbc6f 100644
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
@@ -4706,6 +4707,18 @@ Kernel parameters
 			This can be set from sysctl after boot.
 			See Documentation/admin-guide/sysctl/vm.rst for details.
 
+	nvme.quirks=    [NVME] A list of quirk entries to augment the built-in
+			nvme quirk list. List entries are separated by a
+			'-' character.
+			Each entry has the form VendorID:ProductID:quirk_names.
+			The IDs are 4-digits hex numbers and quirk_names is a
+			list of quirk names separated by commas. A quirk name
+			can be prefixed by '^', meaning that the specified
+			quirk must be disabled.
+
+			Example:
+			nvme.quirks=7710:2267:bogus_nid,^identify_cns-9900:7711:broken_msi
+
 	ohci1394_dma=early	[HW,EARLY] enable debugging via the ohci1394 driver.
 			See Documentation/core-api/debugging-via-ohci1394.rst for more
 			info.
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4bf3435c47a8..b20c540c970a 100644
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
 
@@ -102,6 +109,144 @@ static unsigned int io_queue_depth = 1024;
 module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
 MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2 and < 4096");
 
+static struct quirk_entry *nvme_pci_quirk_list;
+static unsigned int nvme_pci_quirk_count;
+
+/* Helper to parse individual quirk names */
+static int nvme_parse_quirk_names(char *quirk_str, struct quirk_entry *entry)
+{
+	int i;
+	size_t field_len;
+	bool disabled, found;
+	char *p = quirk_str, *field;
+
+	while ((field = strsep(&p, ",")) && *field) {
+		disabled = false;
+		found = false;
+
+		if (*field == '^') {
+			/* Skip the '^' character */
+			disabled = true;
+			field++;
+		}
+
+		field_len = strlen(field);
+		for (i = 0; i < 32; i++) {
+			unsigned int bit = 1U << i;
+			char *q_name = nvme_quirk_name(bit);
+			size_t q_len = strlen(q_name);
+
+			if (!strcmp(q_name, "unknown"))
+				break;
+
+			if (!strcmp(q_name, field) &&
+				    q_len == field_len) {
+				if (disabled)
+					entry->disabled_quirks |= bit;
+				else
+					entry->enabled_quirks |= bit;
+				found = true;
+				break;
+			}
+		}
+
+		if (!found) {
+			pr_err("nvme: unrecognized quirk %s\n", field);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+/* Helper to parse a single VID:DID:quirk_names entry */
+static int nvme_parse_quirk_entry(char *s, struct quirk_entry *entry)
+{
+	char *field;
+
+	field = strsep(&s, ":");
+	if (!field || kstrtou16(field, 16, &entry->vendor_id))
+		return -EINVAL;
+
+	field = strsep(&s, ":");
+	if (!field || kstrtou16(field, 16, &entry->dev_id))
+		return -EINVAL;
+
+	field = strsep(&s, ":");
+	if (!field)
+		return -EINVAL;
+
+	return nvme_parse_quirk_names(field, entry);
+}
+
+static int quirks_param_set(const char *value, const struct kernel_param *kp)
+{
+	int qcount, err, i;
+	struct quirk_entry *qlist= NULL;
+	char *field, *val = NULL;
+	char *sep_ptr;
+
+	err = param_set_copystring(value, kp);
+	if (err)
+		goto exit;
+
+	val = kstrdup(value, GFP_KERNEL);
+	if (!val) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	if (!*val)
+		goto exit;
+
+	qcount = 1;
+	for (i = 0; val[i]; i++) {
+		if (val[i] == '-')
+			qcount++;
+	}
+
+	qlist = kcalloc(qcount, sizeof(*qlist), GFP_KERNEL);
+	if (!qlist) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i = 0;
+	sep_ptr = val;
+	while ((field = strsep(&sep_ptr, "-"))) {
+		if (nvme_parse_quirk_entry(field, &qlist[i])) {
+			pr_err("nvme: failed to parse quirk string %s\n",
+								value);
+			goto exit;
+		}
+
+		i++;
+	}
+
+	nvme_pci_quirk_count = qcount;
+	nvme_pci_quirk_list  = qlist;
+	kfree(val);
+	return 0;
+exit:
+	kfree(val);
+	kfree(qlist);
+	return err;
+}
+
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
+module_param_cb(quirks, &quirks_param_ops, &quirks_param_string, 0444);
+MODULE_PARM_DESC(quirks, "Enable/disable NVMe quirks by specifying "
+						"quirks=VID:DID:quirk_names");
+
 static int io_queue_count_set(const char *val, const struct kernel_param *kp)
 {
 	unsigned int n;
@@ -3442,12 +3587,25 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	return 0;
 }
 
+static struct quirk_entry *detect_dynamic_quirks(struct pci_dev *pdev)
+{
+	int i;
+
+	for (i = 0; i < nvme_pci_quirk_count; i++)
+		if (pdev->vendor == nvme_pci_quirk_list[i].vendor_id &&
+		    pdev->device == nvme_pci_quirk_list[i].dev_id)
+			return &nvme_pci_quirk_list[i];
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
@@ -3479,6 +3637,11 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 			 "platform quirk: setting simple suspend\n");
 		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
 	}
+	qentry = detect_dynamic_quirks(pdev);
+	if (qentry) {
+		quirks |= qentry->enabled_quirks;
+		quirks &= ~qentry->disabled_quirks;
+	}
 	ret = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
 			     quirks);
 	if (ret)
@@ -4079,6 +4242,7 @@ static int __init nvme_init(void)
 
 static void __exit nvme_exit(void)
 {
+	kfree(nvme_pci_quirk_list);
 	pci_unregister_driver(&nvme_driver);
 	flush_workqueue(nvme_wq);
 }
-- 
2.52.0


