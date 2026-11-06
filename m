Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8A606A332
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UNoDy3Ie;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=QKrB1xVm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8QAiaS4n20R6Be5/OEFRscYsIl59MRsTRHc5xWVH89k=; b=UNoDy3Ie350jxJMg3ETGIsOokd
	gjjKRUYx8FxjnlDv/9JfMkLXXO5ItxQplMq2kGqVyauuNNXEUcgW33UUNdwLT5oZ/06gbUCX10AH3
	AZJg4SXd7DVYpKcT74JxsTsFlps0EeHQJyJS7KVPMIz49CCyjaxTplWFoqRJNdJoVxBvTRjOVfZWJ
	ypnx+jYZ1kmHwKObujVm1DTeA8X8h4CoCfo3xBaNz4Y/wTlrRIGf7W5WGnjsZszybfinnpY3mWDHJ
	cCjGOUHb6lY9GgTWw6TMpxleSFvynLN2TVtjVEeaehMQSX9cNN18ZNCeASXSimVvEtmk0rROveMss
	Aox9usEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPNtG-0000000DFsr-1cXV;
	Fri, 06 Nov 2026 17:38:14 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPNtC-0000000DFr3-2puW
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 17:38:12 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6HWTbJ1219991
	for <linux-nvme@lists.infradead.org>; Fri, 6 Nov 2026 09:38:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=8QAiaS4n20R6Be5/OEFRscYsIl59MRsTRHc5x
	WVH89k=; b=QKrB1xVmgcQ9yaWQ00XVASIQvGqbjtqtCuwO4s+Y0cDOGAVwdfJxH
	kRXbRHgfpEy6bxfTd2pVV1QLxFAs+8ckfugy2W2rskwBhRuCz/zRG9IJwCIlI3kL
	b7VVcqlMF/HeEdZNv0eSFO0Mj6VBI5zQ0Uy8nNrr4ZAJrjzDme3IFsB4Zpl16iox
	+KYzvN5U2volmy7tgFReA5voOwHfaBV/a9DWGMbIr/++x0K/a/w9X3+osNyw5I9G
	Qb2HNoI6dMflxaHg3XXqAOuROSljPJp9yfkv+30uawrF+VhL06gs5I+5C01SEVQ6
	HIRJJE2pIiHVvmM1GbTlysBIZEjHDqVGw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hs3r6nnrv-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2026 09:38:10 -0800 (PST)
Received: from twshared98006.17.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 17:38:09 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A46CF2E8DCBEA; Fri,  6 Nov 2026 09:34:50 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <tglx@kernel.org>, <bhelgaas@google.com>
CC: <maz@kernel.org>, <lrizzo@google.com>, <hch@lst.de>,
        <changfengnan@bytedance.com>, <namjain@linux.microsoft.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 1/2] genirq: Add disable_irq_noflush()
Date: Fri, 6 Nov 2026 09:34:47 -0800
Message-ID: <20261106173448.34794-2-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261106173448.34794-1-kbusch@meta.com>
References: <20261106173448.34794-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfX9C6deGfvQtaW
 pkMe8Ax/GC1xGrbtXMxU1T21aLJygsXfyIu3j0c54m95P8wltP3pRc6qoGSjSQYDXZQ2H+2aN1U
 Fl2aGE/TE6qiZvYKDsfqQ+u/1YUXHrnU+rNw8fSuIwRggkHw3Qot+KZaG6S/+9NLWghMLj7SJoV
 6T3Nu59r13U+RIQmgygs3QcXUAyAQjaCPPcLST/AqTzIyYoQ1jdMpNg4CmJLuQVKAM1v5iwAXdm
 cLNY2TKjiGHfOVIyIe0ys+O3648YbtsRD48Himb59VkHkSX/2uZeX48cBJVy3HWHGKT8fu4OKBI
 Ep3kBBRFznHmBNvayQjgDhf3O+KhhLZLc8PAJeANHImnfrSbORHwYE1DEQNOZrOz3mPexM/V1eR
 tWoNO5L4DkMuxMf+wjKp4/bgBqmY/YFSDR7vYwJ4dDWF7I3X/guVg9uewnwG5jjFZu9oHmTkBkn
 CZp2Mtbi6sZnonjyopw==
X-Authority-Analysis: v=2.4 cv=IsGL47/g c=1 sm=1 tr=0 ts=6aee1082 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VwQbUJbxAAAA:8 a=aOCmZ3BWbme0XkIVnlwA:9
X-Proofpoint-GUID: _WW9I31TMOFH1TRJ7gTWH8zdgxsOsyK-
X-Proofpoint-ORIG-GUID: _WW9I31TMOFH1TRJ7gTWH8zdgxsOsyK-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfX+yk1ZOZaJlII
 3+X0Ix/tUjEEllzQqNHJlgEPse1KaktQPYzqLnWzH94GocR/vx4waI7dqjbpzM6N5NVAWqYTD3e
 B/CxjPltvliQ2akRkMyOwIsOltmG7l0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_093810_743246_54A17EFE 
X-CRM114-Status: GOOD (  18.82  )
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


