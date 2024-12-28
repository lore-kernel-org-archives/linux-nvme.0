Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5699E77198
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2025 07:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S9g5yzfm32qCCSZ9hYX8RFrDFECwqUd1W8h8dBnaZOA=; b=uWEjFnTENsSNa5HOuyUbyPQUbl
	e7MQitHEPdz/HcXY2GSHJ39rjg1l6n0uOz8KXlMBca8CpdPnfjKkoYvO4mpAvx3wou79qYhf7y4z8
	UAAmLuhauxwOoIwTeZSkNi/tv//XVyQit42AjCL1iSZ+ewjbnoTDllD2z12KSto3VCNdxztzvmD5g
	8ZeQzoLHrj5aPlHm/Zsfgibqzrw3vxuHy5fw7FQZuLDUoULI0mRbQC4T8J1puD8atiT3PvlPy8Obn
	wSeNJDoTtCTPZ3GIKcukZMatzAvm5qKu40lWON9kKGGs2SdM97iz0ZeERwCFL3e5At2cg8Dxx6lHZ
	gMAD10eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTbnM-0000000CIbp-1J8W;
	Fri, 03 Jan 2025 07:08:32 +0000
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tRbsz-00000002G8E-2Z7f
	for linux-nvme@lists.infradead.org;
	Sat, 28 Dec 2024 18:50:06 +0000
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-e3f78f5fc07so7668755276.2
        for <linux-nvme@lists.infradead.org>; Sat, 28 Dec 2024 10:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735411804; x=1736016604; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9g5yzfm32qCCSZ9hYX8RFrDFECwqUd1W8h8dBnaZOA=;
        b=DtRGAHxxRqMbCi6SJelpJAr2PwfHdf2IQmqygqIVuPnhMYN6Ystqh/fpw9H6w2p+3D
         7I0yjYfyZm2yQ0T3WtGN2+d/NXZUOnQYDVilRu4zvgq3EBsu+WC106i2sIPuRH5IPd9N
         09AKjA1BDiPLqcvyCh0Y958+VnCxjh50/+y27FlzGRw8r8Pf65xgPksOmIswzaLpkpfs
         OxyjILQo7XLKakg+wPlk/3RZa4wRYSV4AyRsLHrNYb1swgk0aApWn8mRcgUaILWesw+r
         rQBAnulWCWbv0Z0xNAdfRscbHHtR0fA8qACcwQ7EoBRDBvD5enszaYBS/mLnf8F8oB4L
         Ym6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735411804; x=1736016604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9g5yzfm32qCCSZ9hYX8RFrDFECwqUd1W8h8dBnaZOA=;
        b=Jrwy4lfQlRke+lwn8uDwfLJsq96+MxCUXHHDZwZ8v/2mwJUlewEpQTxV8NTFJrMTsY
         GYuv6SYZ1bTeCo/vQzdLC7eeft8h6j7cOxi60YaEQcpXeaslsXT5JtSuE55NQsG1QZmg
         MsIgSmjP4xVR0g7s1IZLDLeGGvxhklvaRSiZcUdB2+4wrsRSg+YcOpeuCjumSY/qO4jJ
         ClwERxqujPhsoopwkOv1Tsu8dCCbalu/1UUfey/7KTeO5MkYWWP0VWt7IrOM6wf17HBK
         sOZbKd+dXk0x5icUoC9N9OdXni6KnXRAoNnJ8u25oAEK6apWjkna3+cU7+jqL60yoCCo
         qyGA==
X-Forwarded-Encrypted: i=1; AJvYcCUhpKFiOulCBLIq35Jj+01R98RR/eX7EHkL5S3XcrQsLLdhr/PFnxvqaa3kvs2uCQ8o330WT/dGKF8b@lists.infradead.org
X-Gm-Message-State: AOJu0YyhepO57gLoFVEENzzdXQamP8CU1FDLBcDggInIoONqsL3cKg6f
	nwEY+Z1FT0pm1x48ovKQET4vnoH4xzBYjmnI5Rp0P/yE2+2L+GQb
X-Gm-Gg: ASbGncsubVeAvJHX3fy+konkEXRlL9Hbj36UyUTEMAbETmrYrluAL7uQ6VbrFwOYeOx
	DaQhkzhLaggnWhCsqDMxa4Zz4rTCypuaeS874Jy0hzHcG0kq2u4F1FDfoXQo2eUxcSfF1GAmBcS
	RL/NCZ7iHlvUUSk47E9bNM6OOoRC2ZEk7vyKfGsBsjZEVZVNq9AhhvSuNtCAWTdL+2CUibvaDL6
	gbXoqU7FIEoLHhaeBDto3Qp57oNtM1gdmoX3GVoZCrbB0qNh23bfuIiwOxEjrRqRVkb/TA/Rj/y
	OHH/nB1+WwDwmoHl
X-Google-Smtp-Source: AGHT+IFRAv4ES1nGe5GZzQSCr0JvuQEh3E1vBTb1UadMisfKYeWtlE6qWVQlRiPBMv3C59QKs6b8rQ==
X-Received: by 2002:a25:cc1:0:b0:e53:4d98:7459 with SMTP id 3f1490d57ef6-e538c3cfd9dmr14310782276.40.1735411804331;
        Sat, 28 Dec 2024 10:50:04 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cf73675sm5102193276.51.2024.12.28.10.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 10:50:03 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kurz <groug@kaod.org>,
	Peter Xu <peterx@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [PATCH 06/14] cpumask: re-introduce cpumask_next{,_and}_wrap()
Date: Sat, 28 Dec 2024 10:49:38 -0800
Message-ID: <20241228184949.31582-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241228184949.31582-1-yury.norov@gmail.com>
References: <20241228184949.31582-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241228_105005_657398_D9113838 
X-CRM114-Status: GOOD (  14.35  )
X-Mailman-Approved-At: Thu, 02 Jan 2025 23:08:30 -0800
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

cpumask_next_wrap_old() has two additional parameters, comparing to it's
analogue in linux/find.h find_next_bit_wrap(). The reason for that is
historical.

Before 4fe49b3b97c262 ("lib/bitmap: introduce for_each_set_bit_wrap()
macro"), cpumask_next_wrap() was used to implement for_each_cpu_wrap()
iterator. Now that the iterator is an alias to generic
for_each_set_bit_wrap(), the additional parameters aren't used and may
confuse readers.

All existing users call cpumask_next_wrap() in a way that makes it
possible to turn it to straight and simple alias to find_next_bit_wrap().

In a couple places kernel users opencode missing cpumask_next_and_wrap().
Add it as well.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index b267a4f6a917..18c9908d50c4 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -284,6 +284,43 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 		small_cpumask_bits, n + 1);
 }
 
+/**
+ * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
+ *			   @n and wrapping around, if needed
+ * @n: the cpu prior to the place to search (i.e. return will be > @n)
+ * @src1p: the first cpumask pointer
+ * @src2p: the second cpumask pointer
+ *
+ * Return: >= nr_cpu_ids if no further cpus set in both.
+ */
+static __always_inline
+unsigned int cpumask_next_and_wrap(int n, const struct cpumask *src1p,
+			      const struct cpumask *src2p)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_and_bit_wrap(cpumask_bits(src1p), cpumask_bits(src2p),
+		small_cpumask_bits, n + 1);
+}
+
+/*
+ * cpumask_next_wrap - get the next cpu in *src, starting from
+ *			   @n and wrapping around, if needed
+ * @n: the cpu prior to the place to search
+ * @src: cpumask pointer
+ *
+ * Return: >= nr_cpu_ids if no further cpus set in both.
+ */
+static __always_inline
+unsigned int cpumask_next_wrap(int n, const struct cpumask *src)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_bit_wrap(cpumask_bits(src), small_cpumask_bits, n + 1);
+}
+
 /**
  * for_each_cpu - iterate over every cpu in a mask
  * @cpu: the (optionally unsigned) integer iterator
-- 
2.43.0


