Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F943606A31B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=j5fdyWEm;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=aMD4140M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8QAiaS4n20R6Be5/OEFRscYsIl59MRsTRHc5xWVH89k=; b=j5fdyWEmGBs1hYzIbwZmB3lwuw
	4N1jw+VuM6CC65zBmz0wLr8/xT0ZZjKcQ2kR2UMnP+Ct4UrDUpcNVrMXFohT1Zr2lbWc3m6fK3W3I
	mgLrYo5wpNCNdBzPWSC22QC8jtlp+bBZNaiF3/2nvOpoKKoNS78cDKN4G1G7MvCCQz9n2MNEjZIW1
	joUQP6XcRU8iKfqSdRchp092Gmo9ARG4sOboOk8RXCTe7FLQyWQnzpvaXQzeIrzWoxX4Vd1JnNU3/
	CEaPTmKao984SmDDHQwaEiEhCoE/ibsQbygoHzcbKM2cRYCXuTD3FxTbi1K/1WOlhaNTTK/opwQQY
	wTTj8tZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2Ey-0000000A8rQ-1I2x;
	Thu, 05 Nov 2026 18:31:12 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2Dq-0000000A8dv-1uct
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 18:30:42 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5ITiHT462662
	for <linux-nvme@lists.infradead.org>; Thu, 5 Nov 2026 10:30:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=8QAiaS4n20R6Be5/OEFRscYsIl59MRsTRHc5x
	WVH89k=; b=aMD4140MsfuES1+z6UsommAf5FK3cMfW9MowPfXjn+Fc833WyFtEc
	ZXapLiZUe0BhDqs8d9xofiizTeAB0brgcn3Y8EszxfjcrGzKiflrF07rKIYj5gl6
	UZLaTHrneXO5LO0g5gDAKtqq49B8YBgi0fOcHUHXuQlDQz5juWq6z9kRT0BQOzwc
	o6B31gj+qZ64RxomZugBEI2N2r4tWERVvhZBkCAHex11UTFOuL73sGnlzAuRUG/i
	BeE+xgVIX8DBedFH1G7h+2wY8a2p0BxMU3rbKvo010Ox/incAVeTumJoDqAQxbkM
	D+4af1IMOV98d84k5O/LCg74tv7x6rbGg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hrb4egaep-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 05 Nov 2026 10:30:01 -0800 (PST)
Received: from twshared8585.02.snb3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 18:30:00 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id DD6C72E80C125; Thu,  5 Nov 2026 10:27:06 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <tglx@kernel.org>, <bhelgaas@google.com>
CC: <maz@kernel.org>, <lrizzo@google.com>, <hch@lst.de>,
        <changfengnan@bytedance.com>, <namjain@linux.microsoft.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] genirq: Add disable_irq_noflush()
Date: Thu, 5 Nov 2026 10:27:05 -0800
Message-ID: <20261105182706.3700908-2-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261105182706.3700908-1-kbusch@meta.com>
References: <20261105182706.3700908-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: nSB9k9P-TsdlA83wMsu_kk4mcrTYcgRW
X-Proofpoint-ORIG-GUID: nSB9k9P-TsdlA83wMsu_kk4mcrTYcgRW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX4FT524YbVvj3
 n66fpNK53kDzAADKB0Jza+heqqOlhBrf2P3h1lH3CUnKZl1UkZOLBQ2NYJM8gZbKqhm6fzYH1Gn
 iPXKq4Qr71VrkU/aGUlJLCYT3Zm2yVo=
X-Authority-Analysis: v=2.4 cv=DJ8acCNb c=1 sm=1 tr=0 ts=6aeccb29 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=VwQbUJbxAAAA:8 a=aOCmZ3BWbme0XkIVnlwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfXypokhUQ3rt+P
 Glrxzx/ymXOeqJKKm0SK4n5aMOItDfQYlY8lTbJQXWJ2sjyilOXOatjczQfV4v42iTF+KQtyqSF
 RZw7kZRO+TkNKR4M1dJqWsZW/Qo1qDypPKr/bO4046ZGYYf/vkD+HNV+7bWOuQt9vVbPK40aDo1
 TI1CoPZR0+eIqgd6MgsFf6P3Rfo66ohQ821lvrmTZTefqrErBzzX8aYUKL5IC57hhSuRHt31b5a
 uSefy835M5gP2XAEs752xAvttJUKMASl8Zx43IQFprMXNW1WBrt5URNP53GLZSxOAdpo9tbmzRm
 vk4/22YOmoiX3iMUz7mgGpKCmEpzWkGBfq4aqEInIdSNsPsL2TI8b7MQ/mmBuVK0HE+Zmt9VGpU
 e8kKgiEnyq6nAVcgxO6lUzR6TZ0k/tIn0MScVyB6c99yfFP1h3Pvp1DpZRHbOGXFpWq4pD3wgYO
 Md54hz569FLhy+kvIlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_103006_164305_5E7ED956 
X-CRM114-Status: GOOD (  18.83  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Busch <kbusch@kernel.org>

Drivers that switch between interrupt and polled completions don't need
the mask write flushed to the device; the disabled state already
keeps their handler from running and a late interrupt is replayed on
enable. Add an optional irq_chip::irq_mask_noflush() callback, falling
back to irq_mask(), and disable_irq_noflush() to mask through it right
away rather than lazily.

Suggested-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/interrupt.h |  1 +
 include/linux/irq.h       |  3 +++
 kernel/irq/chip.c         | 31 +++++++++++++++++++++++++++++++
 kernel/irq/internals.h    |  1 +
 kernel/irq/manage.c       | 21 +++++++++++++++++++++
 5 files changed, 57 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index ee2dd5349697d..6cfa1f8f3d400 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -233,6 +233,7 @@ extern void devm_free_irq(struct device *dev, unsigne=
d int irq, void *dev_id);
=20
 bool irq_has_action(unsigned int irq);
 extern void disable_irq_nosync(unsigned int irq);
+extern void disable_irq_noflush(unsigned int irq);
 extern bool disable_hardirq(unsigned int irq);
 extern void disable_irq(unsigned int irq);
 extern void disable_percpu_irq(unsigned int irq);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index f485369b1b4f7..3a428dad6666e 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -455,6 +455,8 @@ static inline irq_hw_number_t irqd_to_hwirq(struct ir=
q_data *d)
  * @irq_disable:	disable the interrupt
  * @irq_ack:		start of a new interrupt
  * @irq_mask:		mask an interrupt source
+ * @irq_mask_noflush:	mask an interrupt source without flushing the writ=
e
+ *			to the hardware (optional, falls back to @irq_mask)
  * @irq_mask_ack:	ack and mask an interrupt source
  * @irq_unmask:		unmask an interrupt source
  * @irq_eoi:		end of interrupt
@@ -505,6 +507,7 @@ struct irq_chip {
=20
 	void		(*irq_ack)(struct irq_data *data);
 	void		(*irq_mask)(struct irq_data *data);
+	void		(*irq_mask_noflush)(struct irq_data *data);
 	void		(*irq_mask_ack)(struct irq_data *data);
 	void		(*irq_unmask)(struct irq_data *data);
 	void		(*irq_eoi)(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index de754db414d1d..28285d7274e69 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -399,6 +399,37 @@ void irq_disable(struct irq_desc *desc)
 	__irq_disable(desc, irq_settings_disable_unlazy(desc));
 }
=20
+static void mask_irq_noflush(struct irq_desc *desc)
+{
+	if (irqd_irq_masked(&desc->irq_data))
+		return;
+
+	if (desc->irq_data.chip->irq_mask_noflush) {
+		desc->irq_data.chip->irq_mask_noflush(&desc->irq_data);
+		irq_state_set_masked(desc);
+	} else {
+		mask_irq(desc);
+	}
+}
+
+/**
+ * irq_disable_noflush - Mark interrupt disabled and mask it without flu=
shing
+ * @desc:	irq descriptor which should be disabled
+ *
+ * Like irq_disable() with lazy disable turned off, but the hardware may
+ * still deliver an interrupt after this returns. The flow handler deals
+ * with that the same way it does for a lazily disabled interrupt.
+ */
+void irq_disable_noflush(struct irq_desc *desc)
+{
+	if (desc->irq_data.chip->irq_disable) {
+		__irq_disable(desc, true);
+		return;
+	}
+	irq_state_set_disabled(desc);
+	mask_irq_noflush(desc);
+}
+
 void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu)
 {
 	if (desc->irq_data.chip->irq_enable)
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 703a062be8783..7995970babb77 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -101,6 +101,7 @@ extern void irq_startup_managed(struct irq_desc *desc=
);
 extern void irq_shutdown(struct irq_desc *desc);
 extern void irq_shutdown_and_deactivate(struct irq_desc *desc);
 extern void irq_disable(struct irq_desc *desc);
+extern void irq_disable_noflush(struct irq_desc *desc);
 extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
 extern void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu);
 extern void mask_irq(struct irq_desc *desc);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ec3ecb0e48cec..152dabea3102b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -706,6 +706,27 @@ void disable_irq_nosync(unsigned int irq)
 }
 EXPORT_SYMBOL(disable_irq_nosync);
=20
+/**
+ * disable_irq_noflush - mask an irq without flushing the mask to the ha=
rdware
+ * @irq: Interrupt to disable
+ *
+ * Like disable_irq_nosync(), but masks the interrupt at the chip right =
away
+ * instead of lazily, and does not flush the mask write to the hardware.=
 An
+ * interrupt that still arrives is held pending and replayed by enable_i=
rq().
+ * Use this when an extra interrupt is cheaper than flushing the mask, e=
.g.
+ * switching from interrupts to polling.
+ *
+ * This function may be called from IRQ context.
+ */
+void disable_irq_noflush(unsigned int irq)
+{
+	scoped_irqdesc_get_and_buslock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+		if (!scoped_irqdesc->depth++)
+			irq_disable_noflush(scoped_irqdesc);
+	}
+}
+EXPORT_SYMBOL_GPL(disable_irq_noflush);
+
 /**
  * disable_irq - disable an irq and wait for completion
  * @irq: Interrupt to disable
--=20
2.52.0


