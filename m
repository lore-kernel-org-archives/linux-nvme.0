Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE35CC6B15
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 22:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=29WxjFdkcrrKHHzPghLMhnd38n3Qp1IUXwKe6tO1r7g=; b=0cFrF4KGfukxLmhDr3rmitDtKv
	EAHB8KzKIibQhwRf9jqM0FHNpK8te0mlNhyOGliXgEMO96CWE4Eff6HZeIUdmX+UlvxaSLhIQiskL
	zW7F7uGW6JbmngJswTTtlQ8VAmepcH0ahQq+LtrFfC1BT3tvhAGeRmuAvA2bn6u5p7oyJIoPJk8o3
	GpkAXCj2dCTUkzeP3SwN7RwRHYp0vS0TjVcmGrwhTM928rmN0+95RQh1O8pSEFettC291YAQkkJ15
	qwUEsEJMwdF857mBgScpoVkZAVjEx/fDQb8R2HDFFcqbUL8o2rdSELKPx4hWAM+w7RuNDq0x2iXXm
	BabUGLKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGl6a-0000000E8rU-27Kw;
	Tue, 13 Oct 2026 22:36:20 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGl6W-0000000E8p7-43xA
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 22:36:18 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69DKWqUs4152197
	for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 15:36:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=29WxjFdkcrrKHHzPghLMhnd38n3Qp1IUXwKe6
	tO1r7g=; b=BnAK/aF2wsV6EEfgrNBxfxx6n3H6ZPvGJP9M7Vvnm2a270Nrdwowr
	dz5erj/F/Rs0P5AFCNCBD/JaB3voU6g/fkO3SKw8CgHE9qbcC3lctay69sbdY2QW
	GYQrj1UqiLM04AbbGs6V7FPkeCkKRBoT/tmhpTM+DXcUry1NrVW1LSc0QQ0MK8OV
	n8jP8j3UDq3GpQcM0OUe5eLxKmY6fnLOTEEPvG1fE26o2KMhBISdFZWmODziAFQv
	jN19S21zmN8TI3FKlFWdo2xBb3GZE1dsGJKfI9fuA6Y5xRQJQykX0otdWPXGlRRc
	VcX4k9XwFjftxNl+bgoihYxEJtnrzEiXA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4h9q77m0kh-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 15:36:15 -0700 (PDT)
Received: from twshared134145.14.frc2.facebook.com (2620:10d:c085:208::7cb7)
 by mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 13 Oct 2026 22:36:12 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 659352D52CB78; Tue, 13 Oct 2026 15:35:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <changfengnan@bytedance.com>, <linux-pci@vger.kernel.org>,
        <tglx@kernel.org>, <namjain@linux.microsoft.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [RFC PATCH 1/3] genirq: Add disable_irq_nowait()
Date: Tue, 13 Oct 2026 15:35:41 -0700
Message-ID: <20261013223543.395054-2-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261013223543.395054-1-kbusch@meta.com>
References: <20261013223543.395054-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3mWFDc31IhRE6iHyX_oydYUjQGOxmvVl
X-Authority-Analysis: v=2.4 cv=OvbaWC/t c=1 sm=1 tr=0 ts=6aceb25f cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=VwQbUJbxAAAA:8 a=6pG0410DK98tSDJBP48A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4OSBTYWx0ZWRfXzj2JK6Nojviq
 BK2zemgkmm1mnOx6tchAI8E01B0LYmEVsoXFEKdBoXht+aoJdQKGxGvbXZ5J6rH+9sjdRgk3BcP
 rQyYx2bqQ2GcNgpq7667hbhC+A6ktLA=
X-Proofpoint-GUID: 3mWFDc31IhRE6iHyX_oydYUjQGOxmvVl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4OSBTYWx0ZWRfX3NSB4tqxKHMu
 n9oAcxzFZ8Lrqsg8E3pnm+WEpkP6sWq4VKtUJ/AjmhmiJIjg90PnKqmwHomR3D4P7EL3xoVEgpP
 SlpDtxC+3hhKktT1oXvhniW3SEYAeeHjAP+1s4FoZmpFEbdsgUTESA1F0iuYkdGVErll/Ly1WLN
 BNH+merxejZS9EXhH7PwmbnjFzBGYpZC7pWfDgXcmlAJx1nVB5p2bNc1Y3G3Zhi7vgCmv8R4P2x
 d6ksA8V/ug+KxPPz2zP6+rjiA/iEVHdfI4uyFLY9T58MqLGCwEfR+qrwL5ad0KUWzw2KHVv3/IH
 yhTYdE7JL4ha+y0V4g1dtnBHcfdwvHN3GCKoAAD3YMqURm69xDPR/UcQPq0VnxKhAd7SjQNUAhV
 zSKeQEH9uDtDbCbYON4U7LhE2N1IFenk9Vh2IHz2mmwK2WJ7eJOONW70mRfUquYdpyHuD7Q9vPu
 ho4w+qccm9oriyvGWAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_153617_147639_20805150 
X-CRM114-Status: GOOD (  19.09  )
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

From: Keith Busch <kbusch@kernel.org>

Drivers that switch between interrupt and polled completions don't need
to wait for the mask to reach the device; the disabled state already
keeps their handler from running and a late interrupt is replayed on
enable. Add an optional irq_chip irq_mask_nowait() callback, falling
back to irq_mask(), and disable_irq_nowait() to mask through it right
away rather than lazily.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/interrupt.h |  1 +
 include/linux/irq.h       |  4 ++++
 kernel/irq/chip.c         | 31 +++++++++++++++++++++++++++++++
 kernel/irq/internals.h    |  1 +
 kernel/irq/manage.c       | 21 +++++++++++++++++++++
 5 files changed, 58 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 3bf969ad8fe07..d40c992ddb8a1 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -231,6 +231,7 @@ extern void devm_free_irq(struct device *dev, unsigne=
d int irq, void *dev_id);
=20
 bool irq_has_action(unsigned int irq);
 extern void disable_irq_nosync(unsigned int irq);
+extern void disable_irq_nowait(unsigned int irq);
 extern bool disable_hardirq(unsigned int irq);
 extern void disable_irq(unsigned int irq);
 extern void disable_percpu_irq(unsigned int irq);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index f485369b1b4f7..de095299f20ed 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -455,6 +455,9 @@ static inline irq_hw_number_t irqd_to_hwirq(struct ir=
q_data *d)
  * @irq_disable:	disable the interrupt
  * @irq_ack:		start of a new interrupt
  * @irq_mask:		mask an interrupt source
+ * @irq_mask_nowait:	mask an interrupt source without waiting for the
+ *			hardware to acknowledge it (optional, falls back to
+ *			@irq_mask)
  * @irq_mask_ack:	ack and mask an interrupt source
  * @irq_unmask:		unmask an interrupt source
  * @irq_eoi:		end of interrupt
@@ -505,6 +508,7 @@ struct irq_chip {
=20
 	void		(*irq_ack)(struct irq_data *data);
 	void		(*irq_mask)(struct irq_data *data);
+	void		(*irq_mask_nowait)(struct irq_data *data);
 	void		(*irq_mask_ack)(struct irq_data *data);
 	void		(*irq_unmask)(struct irq_data *data);
 	void		(*irq_eoi)(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index de754db414d1d..4e76f025b5f68 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -399,6 +399,37 @@ void irq_disable(struct irq_desc *desc)
 	__irq_disable(desc, irq_settings_disable_unlazy(desc));
 }
=20
+static void mask_irq_nowait(struct irq_desc *desc)
+{
+	if (irqd_irq_masked(&desc->irq_data))
+		return;
+
+	if (desc->irq_data.chip->irq_mask_nowait) {
+		desc->irq_data.chip->irq_mask_nowait(&desc->irq_data);
+		irq_state_set_masked(desc);
+	} else {
+		mask_irq(desc);
+	}
+}
+
+/**
+ * irq_disable_nowait - Mark interrupt disabled and mask it without wait=
ing
+ * @desc:	irq descriptor which should be disabled
+ *
+ * Like irq_disable() with lazy disable turned off, but the hardware may
+ * still deliver an interrupt after this returns. The flow handler deals
+ * with that the same way it does for a lazily disabled interrupt.
+ */
+void irq_disable_nowait(struct irq_desc *desc)
+{
+	if (desc->irq_data.chip->irq_disable) {
+		__irq_disable(desc, true);
+		return;
+	}
+	irq_state_set_disabled(desc);
+	mask_irq_nowait(desc);
+}
+
 void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu)
 {
 	if (desc->irq_data.chip->irq_enable)
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 0ce21dd454047..3ba13932ba831 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -98,6 +98,7 @@ extern void irq_startup_managed(struct irq_desc *desc);
 extern void irq_shutdown(struct irq_desc *desc);
 extern void irq_shutdown_and_deactivate(struct irq_desc *desc);
 extern void irq_disable(struct irq_desc *desc);
+extern void irq_disable_nowait(struct irq_desc *desc);
 extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
 extern void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu);
 extern void mask_irq(struct irq_desc *desc);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 57eff26fa646a..7a4d7f1024133 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -705,6 +705,27 @@ void disable_irq_nosync(unsigned int irq)
 }
 EXPORT_SYMBOL(disable_irq_nosync);
=20
+/**
+ * disable_irq_nowait - mask an irq without waiting for the hardware
+ * @irq: Interrupt to disable
+ *
+ * Like disable_irq_nosync(), but masks the interrupt at the chip right =
away
+ * instead of lazily, and does not wait for the hardware to acknowledge =
the
+ * mask. An interrupt that still arrives is held pending and replayed by
+ * enable_irq(). Use this when an extra interrupt is cheaper than flushi=
ng
+ * the mask, e.g. switching from interrupts to polling.
+ *
+ * This function may be called from IRQ context.
+ */
+void disable_irq_nowait(unsigned int irq)
+{
+	scoped_irqdesc_get_and_buslock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+		if (!scoped_irqdesc->depth++)
+			irq_disable_nowait(scoped_irqdesc);
+	}
+}
+EXPORT_SYMBOL_GPL(disable_irq_nowait);
+
 /**
  * disable_irq - disable an irq and wait for completion
  * @irq: Interrupt to disable
--=20
2.52.0


