Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4C7E7718F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2025 07:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0bA6qa5mRtLx/JNJepZMf5RGZWm5ti1ameVb2qE56fE=; b=w90TgERF5qJz5cBqUOzmPhf8s0
	cgrvRFaqGWNX15HQw7vvJ3grNNQQk8G6P8FbwoKl1sle4+rHuZvxUF65QOqv3fknB0l1kNc6e33WH
	eum+TKasFP0ILVe8TxEQafl+KvMIEXf+ZPEevulxPfmG1hxbsBIzn5WOoePeXzmCwcUSsy7skCnOn
	e2Vr0q2iTRMnQnx7V086+qS9pT8UTxDSVHWEBkVQZKdyDDknNTi5o/ZfR0ScqGWebFkRQOmvYo576
	UlGXQrV0x7wC1DZW0FJmmbZEDGFQ5XGAVk/hR9DufGLm80/Mv3F7w+nXMX+YTWkFnqK90Ygj10Aaf
	ZxiehiPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTbnL-0000000CIb6-2kYh;
	Fri, 03 Jan 2025 07:08:31 +0000
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tRbsy-00000002G7n-0yK9
	for linux-nvme@lists.infradead.org;
	Sat, 28 Dec 2024 18:50:05 +0000
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-e53c9035003so6682496276.2
        for <linux-nvme@lists.infradead.org>; Sat, 28 Dec 2024 10:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735411803; x=1736016603; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bA6qa5mRtLx/JNJepZMf5RGZWm5ti1ameVb2qE56fE=;
        b=OqJTOMWlAG+C7PpuQqa5x+F0RSuHZaMRI3v/nRtLMPFMAwrxhtmLMMOXW6RGcW7pDc
         8CMiwqQjfI4UfbSEpyBLHFovasbE0lHbrz/EeBL7e45kuKFJOMPyV31J0QVkCUk6AwmY
         b1hRB0hc+ZQebyCpLBfnUERlJVYINJGB1NRd6mW2JsfXSCqtDcpAR2N4k+7n1vttg5N+
         Pm6l8I0ULYVYaVvaewnS6TMyuordiOcSjriVIRiOO5ym7MxjwBrN2tA8AUNw0x3wIC3x
         2W3DQltwmx/JMayPkhSLiM3WY/l36HIi6BmY3DQvMRIggVRX6tQ1QdwGtXYzYOkfgFHi
         VyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735411803; x=1736016603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bA6qa5mRtLx/JNJepZMf5RGZWm5ti1ameVb2qE56fE=;
        b=Ozpwz4LasDctqGce8SZkz3HsS5b6jlNAHwOGut5i1DmLcn8l7ZOr4uYPcp9pjokaVS
         UO6t9dO2YTZs2GxbY5ZesbrmuceUBlSf10x6TGyKbXIqHbftjxu47eDMkjOgWjQpeJ16
         R3VD7FXZgIdPLuV52CWZ6Jed222uU4aHo6I0oSZIwMymALQw5JQriQtTBiCqG2cGIX5N
         rzl3R1eo237/gR8S4mO0Zwn1u97Dg5BLrpVfh3TEk0titzd6DW0gWiwtXVEKSbpTfAHi
         bgVRpnVXzt6o1hLyKNUJJteQYSRUh+c0unQQ9Bg9lVKX7+VxKdlVNIwzwfbH8SFM4oyb
         VQsw==
X-Forwarded-Encrypted: i=1; AJvYcCV9A65O6Rz1j1qAZN3xJFwnOyLqHjA9svjIpkKVXa+VEcs2EUQx/qVFQf/PgkGLbtjp7UXqSU7sEIXJ@lists.infradead.org
X-Gm-Message-State: AOJu0YyT60y0b8YE6zf31Stuq1rDzYYv0g9Y/W4Z5B8hPK828106Qkwa
	1HVZz1Yya1zjif9q17D36zSRb88+u3QP4elS4d+BLjiojzn/1ZBY
X-Gm-Gg: ASbGncu37DZYgbHQUctJrlXEtxtWwcD8Gis/EYLLTMLLcLpIPyuhaapUB0vectok/CV
	1whG6O26d4WTiZzzcIZBynw6ETRH7iXMORfuDm7NUfzqlWknCfEoVRWH7vscn5rHa0VyXMyNalJ
	TVfl11luqPwDeklR87qB0URN4EUoBOmwnFmDvONNGpCxmXnuhrZH1KjXElv52DXUTeniMgcUJKf
	7yf+XwCPm5uaqUqKh1FWD4pDb+3L2eSu8I1L3bbD7Wg+RMlABt+yP4I6cy626qCsrHPanws5g+I
	Kx8pKMXlJISL2qWJ
X-Google-Smtp-Source: AGHT+IEdltlfo7VoM/K9Hx3CK/leMoimfCHWr7pfYR9wsJX7DjblcCmfKrexz0jlZQgTcU9bnrqr/g==
X-Received: by 2002:a05:6902:1a48:b0:e49:5f2d:e71d with SMTP id 3f1490d57ef6-e538c267d16mr23706682276.21.1735411803005;
        Sat, 28 Dec 2024 10:50:03 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cbeba44sm5051923276.7.2024.12.28.10.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 10:50:02 -0800 (PST)
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
Subject: [PATCH 05/14] cpumask: deprecate cpumask_next_wrap()
Date: Sat, 28 Dec 2024 10:49:37 -0800
Message-ID: <20241228184949.31582-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241228184949.31582-1-yury.norov@gmail.com>
References: <20241228184949.31582-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241228_105004_287408_CD571130 
X-CRM114-Status: GOOD (  17.70  )
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

The next patche aligns implementation of cpumask_next_wrap() with the
generic version in find.h which changes function signature.

To make the transition smooth, this patch deprecates current
implementation by adding an _old suffix. The following patches switch
current users to the new implementation one by one.

No functional changes were intended.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/s390/kernel/processor.c        | 2 +-
 drivers/nvme/host/tcp.c             | 2 +-
 drivers/pci/controller/pci-hyperv.c | 2 +-
 drivers/scsi/lpfc/lpfc_init.c       | 2 +-
 include/linux/cpumask.h             | 4 ++--
 kernel/padata.c                     | 2 +-
 lib/cpumask.c                       | 6 +++---
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 5ce9a795a0fe..42ca61909030 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -72,7 +72,7 @@ void notrace stop_machine_yield(const struct cpumask *cpumask)
 	this_cpu = smp_processor_id();
 	if (__this_cpu_inc_return(cpu_relax_retry) >= spin_retry) {
 		__this_cpu_write(cpu_relax_retry, 0);
-		cpu = cpumask_next_wrap(this_cpu, cpumask, this_cpu, false);
+		cpu = cpumask_next_wrap_old(this_cpu, cpumask, this_cpu, false);
 		if (cpu >= nr_cpu_ids)
 			return;
 		if (arch_vcpu_is_preempted(cpu))
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 28c76a3e1bd2..054904376c3c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1578,7 +1578,7 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	if (wq_unbound)
 		queue->io_cpu = WORK_CPU_UNBOUND;
 	else
-		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
+		queue->io_cpu = cpumask_next_wrap_old(n - 1, cpu_online_mask, -1, false);
 }
 
 static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cdd5be16021d..86d1c2be8eb5 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1757,7 +1757,7 @@ static int hv_compose_multi_msi_req_get_cpu(void)
 
 	spin_lock_irqsave(&multi_msi_cpu_lock, flags);
 
-	cpu_next = cpumask_next_wrap(cpu_next, cpu_online_mask, nr_cpu_ids,
+	cpu_next = cpumask_next_wrap_old(cpu_next, cpu_online_mask, nr_cpu_ids,
 				     false);
 	cpu = cpu_next;
 
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 7f57397d91a9..31622fb0614a 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -12876,7 +12876,7 @@ lpfc_irq_rebalance(struct lpfc_hba *phba, unsigned int cpu, bool offline)
 
 	if (offline) {
 		/* Find next online CPU on original mask */
-		cpu_next = cpumask_next_wrap(cpu, orig_mask, cpu, true);
+		cpu_next = cpumask_next_wrap_old(cpu, orig_mask, cpu, true);
 		cpu_select = lpfc_next_online_cpu(orig_mask, cpu_next);
 
 		/* Found a valid CPU */
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 30042351f15f..b267a4f6a917 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -296,7 +296,7 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 
 #if NR_CPUS == 1
 static __always_inline
-unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
+unsigned int cpumask_next_wrap_old(int n, const struct cpumask *mask, int start, bool wrap)
 {
 	cpumask_check(start);
 	if (n != -1)
@@ -312,7 +312,7 @@ unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, boo
 	return cpumask_first(mask);
 }
 #else
-unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
+unsigned int __pure cpumask_next_wrap_old(int n, const struct cpumask *mask, int start, bool wrap);
 #endif
 
 /**
diff --git a/kernel/padata.c b/kernel/padata.c
index d51bbc76b227..454ff2fca40b 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -274,7 +274,7 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
 	if (remove_object) {
 		list_del_init(&padata->list);
 		++pd->processed;
-		pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, -1, false);
+		pd->cpu = cpumask_next_wrap_old(cpu, pd->cpumask.pcpu, -1, false);
 	}
 
 	spin_unlock(&reorder->lock);
diff --git a/lib/cpumask.c b/lib/cpumask.c
index e77ee9d46f71..c9a9b451772a 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -8,7 +8,7 @@
 #include <linux/numa.h>
 
 /**
- * cpumask_next_wrap - helper to implement for_each_cpu_wrap
+ * cpumask_next_wrap_old - helper to implement for_each_cpu_wrap
  * @n: the cpu prior to the place to search
  * @mask: the cpumask pointer
  * @start: the start point of the iteration
@@ -19,7 +19,7 @@
  * Note: the @wrap argument is required for the start condition when
  * we cannot assume @start is set in @mask.
  */
-unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
+unsigned int cpumask_next_wrap_old(int n, const struct cpumask *mask, int start, bool wrap)
 {
 	unsigned int next;
 
@@ -37,7 +37,7 @@ unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, boo
 
 	return next;
 }
-EXPORT_SYMBOL(cpumask_next_wrap);
+EXPORT_SYMBOL(cpumask_next_wrap_old);
 
 /* These are not inline because of header tangles. */
 #ifdef CONFIG_CPUMASK_OFFSTACK
-- 
2.43.0


