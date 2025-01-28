Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF91C0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mPo0Qmhd/LgFOJoY/TurPrp2onCgGxY+Z0rc3zytFz4=; b=SD9jK/dKPLL179V4MV/iOyRJ4K
	5VooqHa1RHqUMKIqb8ONfiGvD6uKCCHPW+P0hkh6XZWXg0audlbvjDJ0HVettLOVBpGZply/9yHiz
	Olso0I8/vHe9vliB9v6VUFty1lplDy6S7RnMskpylzeUf/6oCRFYp2O2QkzLPEsExAcrnvQUNUnxt
	zl/tucVvopX9eNErhbjZmhv/Tx7R6iFhwsh+fxv3Jd18prcHsXUFHb5hhONa4i21UItYKQlwEUuHW
	P8oAZPmH7MNKJLrRAjM4yx16y6TDp6uqYmhtdyo3UCTBJzqfBsAMYMTQHkeoPmOIxycy7W5qqXcvb
	qXSjKwZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcpG7-00000005QiB-3zKZ;
	Tue, 28 Jan 2025 17:20:19 +0000
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcoju-00000005N7b-0Fp2
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 16:47:03 +0000
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so8132106276.2
        for <linux-nvme@lists.infradead.org>; Tue, 28 Jan 2025 08:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738082821; x=1738687621; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPo0Qmhd/LgFOJoY/TurPrp2onCgGxY+Z0rc3zytFz4=;
        b=JDqH5hr0VUVe4eUyWF3mdhzU22lrrdsT4mcQ9NL7kdNXYxQv9UQzsG+f0NoaTW80Un
         KHyffiMAV7We+GpBkxxdtmIiHdDXqHP2bUeYTTmESOY9yzebt7+ps5kRTQAtsnaHgDTh
         JkOEsL1q6KEU7x1xZXngk5KL9pCcqyGOxJh87xQb6gol07ogWhU+hC8odc4VbJ3z3CbS
         AoqwBdqN5k0Ax1KzS9GRDSV1Qvk3utJ2JreWoVKv/ZU/hsLK3mgOjMqZrIhZx/nlkOl7
         qc7c93u+heYv0KA9Kquq9axRphsP0xH0QC0SWbShUdpF7lU0skmFEXELHB5Pc0ex13Nh
         7y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738082821; x=1738687621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPo0Qmhd/LgFOJoY/TurPrp2onCgGxY+Z0rc3zytFz4=;
        b=A24+WnnBqvsLBNpPamg7FyTp8PMijnSjjcJv+bbGwZHEK5nMAPioLoSBvy4l6rD2x1
         VtML/cK5dICrHXhPhEbFi30nTyr5/1IeB09o9DiIV7yj5wpllI5JDSKfSQXtr9km+jS+
         jxP4xUgdZZjSS5Yzeh9OsbBl9rLqvrLdfdHu/Rll5CIXJzsEbEdM45UD4MsziJgs4883
         KexBZqXfGWrPw23+TNPhISKFYRRzzI6BA/CMVw7b5Dl0eBKCkwLn0ttIOhMU+sDIp5nL
         8s9pMgt7TUsNp0rLJg/R7+n/rmGrLlrd/tWho4tl9lfle0wgWORhns21YlUhHg7CmbpL
         Yipg==
X-Forwarded-Encrypted: i=1; AJvYcCXh7/nF3qKC8fv3TArwcCBjwWcsQ4TLsSBlhvLQMtsJC906P517gNpsUFVtVdwHhF3SmtQxAqpG6wYC@lists.infradead.org
X-Gm-Message-State: AOJu0Yxxk0Sth5ik1H3w6Cc0DSxQOU5QqpEg4ihlQ/2duVHnfuBMxgRy
	96snvhzs16hyoM3uBumrOZzAWtrtnTG+qrud5r2z/q8x9EzUdSLH
X-Gm-Gg: ASbGncvTrzddsvfrhK637zwy2rgucO4an5rWE1rtsMmf11eC5j2wSYoWC4djZlHvfDD
	hqsL9Z98TMx9W0A/r/msG8qgYch/tThS4DX97jJpAsoh5CgevZEMCAsW1SApxikjPT1mgzTxwcO
	qbYhzOVZwMTFoo9ciXPM8L5zgCJbZVhhLOThIfcJEvn4mZZDjvJ8cnQ+NyZXT4N9V4p2SGE7hiz
	BBZAdAsHZilE52/qWVPCnXyRKPFIUkf64+NuTYELYa5Q+N3hZq1NW9SqkT+HygwsjWKzkKjHBOE
	q2Pm6Kj3JywTueNBg54vdAMWN5WVaSSn8p7oFinmKzO+y1hEwbw=
X-Google-Smtp-Source: AGHT+IEbCDwztaXs4775wdhVhgVxaydy6EUMlQBUSRYIasXW3lx4ypNqxsjWkznwG36W84zpcNPfgw==
X-Received: by 2002:a05:6902:982:b0:e58:306f:e83a with SMTP id 3f1490d57ef6-e58306fe89cmr14077851276.29.1738082820769;
        Tue, 28 Jan 2025 08:47:00 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e589a2260a9sm196205276.37.2025.01.28.08.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:47:00 -0800 (PST)
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
Cc: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2 06/13] cpumask: re-introduce cpumask_next{,_and}_wrap()
Date: Tue, 28 Jan 2025 11:46:35 -0500
Message-ID: <20250128164646.4009-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250128164646.4009-1-yury.norov@gmail.com>
References: <20250128164646.4009-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_084702_098133_11C40A1F 
X-CRM114-Status: GOOD (  15.81  )
X-Mailman-Approved-At: Tue, 28 Jan 2025 09:20:17 -0800
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

cpumask_next_wrap_old() has two additional parameters, comparing to its
generic counterpart find_next_bit_wrap(). The reason for that is
historical.

Before 4fe49b3b97c262 ("lib/bitmap: introduce for_each_set_bit_wrap()
macro"), cpumask_next_wrap() was used to implement for_each_cpu_wrap()
iterator. Now that the iterator is an alias to generic
for_each_set_bit_wrap(), the additional parameters aren't used and may
confuse readers.

All existing users call cpumask_next_wrap() in a way that makes it
possible to turn it to straight and simple alias to find_next_bit_wrap().

In a couple of places kernel users opencode missing cpumask_next_and_wrap().
Add it as well.

CC: Alexander Gordeev <agordeev@linux.ibm.com>
CC: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index b267a4f6a917..4f3d8d66e86e 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -284,6 +284,44 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 		small_cpumask_bits, n + 1);
 }
 
+/**
+ * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
+ *			   @n+1. If nothing found, wrap around and start from
+ *			   the beginning
+ * @n: the cpu prior to the place to search (i.e. search starts from @n+1)
+ * @src1p: the first cpumask pointer
+ * @src2p: the second cpumask pointer
+ *
+ * Return: next set bit, wrapped if needed, or >= nr_cpu_ids if @src1p & @src2p is empty.
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
+/**
+ * cpumask_next_wrap - get the next cpu in *src, starting from @n+1. If nothing
+ *		       found, wrap around and start from the beginning
+ * @n: the cpu prior to the place to search (i.e. search starts from @n+1)
+ * @src: cpumask pointer
+ *
+ * Return: next set bit, wrapped if needed, or >= nr_cpu_ids if @src is empty.
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


