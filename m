Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E58C54754
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C5YIh0inrDclU3R990x6d0mGXLCATxbgyJziBWcySGE=; b=RwRStoaD3du+7D0WLIGfJS6/G3
	0N1bqlRjiic1wNbUzkla7WXEtlg20ZsiZKkaT3MN3oRnxv6gFgMN4BCNEv1Y4ePGvE/GLNls5qM2B
	+9eRcGSuLurxS/9ADVYw3+awVNWCZ8UwBeUQUudWCOPSc+pFbJBRtRv2S/dl1otv/Cyqe+DlUKLDG
	yYxL0M1cHcFCIuA0SW4oEeec53oG6scghFOaxdU1y2XaHt9iaKvXysjCC+6NTAbygLqxrVz7t7z7G
	g3iYnx200M17H2Ikf8HRRIiHgShb7tXrz0ZAp87PpHcJR9//+tZk7xSLXuPegs1Zvb6VqLSb4OguK
	kXAgr6ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFxi7-00000003zAA-2tYC;
	Fri, 16 May 2025 16:14:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFxMA-00000003ui8-3M6l
	for linux-nvme@lists.infradead.org;
	Fri, 16 May 2025 15:52:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747410736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5YIh0inrDclU3R990x6d0mGXLCATxbgyJziBWcySGE=;
	b=M8trXfFUikdxh5Qe8uACME9TCk1E2el3GMF+C+exR138HYioIeDA0SgIY4zgo+sr12jinC
	MLq2JMSIGJxMn8oUZAUWicmkDHLw4+Chmwm9kEKGHxrNQ7TsvYUF91nElKrFiOhQEpaoUe
	+j6s/NfITUfO/7eZ5OLLp/CvGfyqrBM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-sa1p_EQ_N_e5SBk7XQm1gg-1; Fri,
 16 May 2025 11:50:37 -0400
X-MC-Unique: sa1p_EQ_N_e5SBk7XQm1gg-1
X-Mimecast-MFC-AGG-ID: sa1p_EQ_N_e5SBk7XQm1gg_1747410634
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5D32195608F;
	Fri, 16 May 2025 15:50:33 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.42.28.135])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 743C830075D8;
	Fri, 16 May 2025 15:50:31 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	bgurney@redhat.com,
	mlombard@bsdbackstore.eu
Subject: [RFC PATCH 1/1] nvme: add support for dynamic quirk configuration via module parameter
Date: Fri, 16 May 2025 17:50:25 +0200
Message-ID: <20250516155025.44958-2-mlombard@redhat.com>
In-Reply-To: <20250516155025.44958-1-mlombard@redhat.com>
References: <20250516155025.44958-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U27Jpfo-gWZCy5s-L9cF-WnnvSoDZ1WR6DBeKu8EW24_1747410634
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250516_085219_280116_0222288A 
X-CRM114-Status: GOOD (  19.81  )
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

The `quirks` parameter accepts a comma-separated list of quirk
specifications in the following format:

    <vendorID>:<deviceID>:<quirk_flags>[,<vendorID>:<deviceID>:<quirk_flags>,..]

Each quirk flag is represented by a single character, and can be prefixed with
`!` to indicate that the quirk should be disabled.

Example usage (enable BOGUS_NID and BROKEN_MSI, disable DEALLOCATE_ZEROES):

    $ modprobe nvme quirks=7170:2210:sv!c

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/pci.c | 201 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2e30e9be7408..77e21089897c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -45,6 +45,13 @@
 #define NVME_MAX_META_SEGS 15
 #define NVME_MAX_NR_ALLOCATIONS	5
 
+struct quirk_entry {
+	u16 vendor_id;
+	u16 dev_id;
+	u32 enabled_quirks;
+	u32 disabled_quirks;
+};
+
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
 
@@ -75,6 +82,179 @@ static unsigned int io_queue_depth = 1024;
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
+MODULE_PARM_DESC(quirks, "Enable/disable NVMe quirks by specifying quirks=vendorID:deviceID:quirks");
+
+static int quirks_param_set(const char *value, const struct kernel_param *kp)
+{
+	char *val, *p, *field;
+	u16 vid, did;
+	u32 *flags;
+	size_t i;
+	int err;
+	bool neg = false;
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
+		if (val[i] == ',')
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
+	for (i = 0, p = val; p && *p; ++i) {
+		/* Each entry consists of VID:DID:flags */
+		field = strsep(&p, ":");
+		if (!field)
+			break;
+
+		if (kstrtou16(field, 16, &vid))
+			break;
+
+		field = strsep(&p, ":");
+		if (!field)
+			break;
+
+		if (kstrtou16(field, 16, &did))
+			break;
+
+		field = strsep(&p, ",");
+		if (!field || !*field)
+			break;
+
+		/* Collect the flags */
+		for (flags = 0; *field; field++) {
+			if (neg) {
+				flags = &quirk_list[i].disabled_quirks;
+				neg = false;
+			} else {
+				flags = &quirk_list[i].enabled_quirks;
+			}
+			switch (*field) {
+			case 'a':
+				*flags |= NVME_QUIRK_STRIPE_SIZE;
+				break;
+			case 'b':
+				*flags |= NVME_QUIRK_IDENTIFY_CNS;
+				break;
+			case 'c':
+				*flags |= NVME_QUIRK_DEALLOCATE_ZEROES;
+				break;
+			case 'd':
+				*flags |= NVME_QUIRK_DELAY_BEFORE_CHK_RDY;
+				break;
+			case 'e':
+				*flags |= NVME_QUIRK_NO_APST;
+				break;
+			case 'f':
+				*flags |= NVME_QUIRK_NO_DEEPEST_PS;
+				break;
+			case 'g':
+				*flags |= NVME_QUIRK_QDEPTH_ONE;
+				break;
+			case 'h':
+				*flags |= NVME_QUIRK_MEDIUM_PRIO_SQ;
+				break;
+			case 'i':
+				*flags |= NVME_QUIRK_IGNORE_DEV_SUBNQN;
+				break;
+			case 'j':
+				*flags |= NVME_QUIRK_DISABLE_WRITE_ZEROES;
+				break;
+			case 'k':
+				*flags |= NVME_QUIRK_SIMPLE_SUSPEND;
+				break;
+			case 'l':
+				*flags |= NVME_QUIRK_SINGLE_VECTOR;
+				break;
+			case 'm':
+				*flags |= NVME_QUIRK_128_BYTES_SQES;
+				break;
+			case 'n':
+				*flags |= NVME_QUIRK_SHARED_TAGS;
+				break;
+			case 'o':
+				*flags |= NVME_QUIRK_NO_TEMP_THRESH_CHANGE;
+				break;
+			case 'p':
+				*flags |= NVME_QUIRK_NO_NS_DESC_LIST;
+				break;
+			case 'q':
+				*flags |= NVME_QUIRK_DMA_ADDRESS_BITS_48;
+				break;
+			case 'r':
+				*flags |= NVME_QUIRK_SKIP_CID_GEN;
+				break;
+			case 's':
+				*flags |= NVME_QUIRK_BOGUS_NID;
+				break;
+			case 't':
+				*flags |= NVME_QUIRK_NO_SECONDARY_TEMP_THRESH;
+				break;
+			case 'u':
+				*flags |= NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
+				break;
+			case 'v':
+				*flags |= NVME_QUIRK_BROKEN_MSI;
+				break;
+			case 'z':
+				*flags |= NVME_QUIRK_DMAPOOL_ALIGN_512;
+				break;
+			case '!':
+				neg = true;
+				break;
+			default:
+				/* Ignore unrecognized flag characters */
+				break;
+			}
+		}
+
+		quirk_list[i].vendor_id = vid;
+		quirk_list[i].dev_id = did;
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
@@ -3175,12 +3355,27 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
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
 
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
@@ -3211,6 +3406,11 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
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
@@ -3814,6 +4014,7 @@ static int __init nvme_init(void)
 
 static void __exit nvme_exit(void)
 {
+	kfree(quirk_list);
 	pci_unregister_driver(&nvme_driver);
 	flush_workqueue(nvme_wq);
 }
-- 
2.43.5


