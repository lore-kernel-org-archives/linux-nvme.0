Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381A5C32771
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 05:05:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A539206ED
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 05:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C2WNbZSz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OE4vY4hW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A539206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qtjv1my9NfIzgGZQnK6YAbQmf9+o1Nj31ThqEVYbD5A=; b=C2WNbZSzwhydyo
	8HWbDYMIQzlfjGImCIzJtcMKVNMkKpjQZ4SmGCZEPE+jKJk+WkpR+h/SeoaAqg7NC4F64SQ0lsYcX
	dqbslEIGIW6LdYbiT4y0009Hc3IaK9ryMjz2KFeZFQ1hxTxNyJYINmtX1SxsQGVsTMiy4bvy+D2G2
	QXFRU1HWZuWQmuNulVr+UGM4HiicJ3Qij2V5NmsXcdrk1ArCPWyGsnlyTFgQK/B8CjBIBi0N1O3dQ
	ldiFzskaNLtAHpUjc+yi+k7QfAiTQmqH08LA1mOhByAhpknf6JAfpH0EQMa49is7dBveTNANCcV+6
	0r56vz81jG47686ulCqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipQ0f-000607-IE; Thu, 09 Jan 2020 05:05:29 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipQ0C-0004UL-6W
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 05:05:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1578546300; x=1610082300;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HTSLqX0/CNO70621Moysch9qPo8EcbPQUmEUYWI4yJ0=;
 b=OE4vY4hWXdH7X+XemIOqNCZI9j8ZLnUJSqxaOzhTH9KnxTP1sHLqBQWi
 0YL7wch6Tcof/3WG/Nr1I3CHwgysb+qvqgVqsABtD9wLhOiZ6BAMforVr
 aWiErXrIc64tBMRuwOv0XQFnHjfsK6vMMHdcRM35kr2fnxq48WcEQsDn3
 sDCLBk56yjbVbEMozR3Nk3zHa+LxbIg1MZfaAoahJoIymRceCkFU1dIOj
 RZYGitBVZErY5GeiPImhmNMRJ2pzjsdYsLTlXj6S1uqDalJLZK0qfeDPj
 gatXeAd/rm2ohW+KhNA+bN5zAOLY0xNM1tcP+pKPfI+EYjn+LaMlUR4CS Q==;
IronPort-SDR: CVx77rwNISKQFAzCD/cHfuEaA7Ln1O8HMMSguDXWYjLRy01ulLsjg73dDq/k9vCLklx0hK2N2W
 DMxsIvYPTvQJlKD7ARKQI6isWgkntcz/99YaQHX3i9NwIGgDWLIQ2+j4KSj0qE2AKumctRMEHH
 urh8uPHHJzRbYCDPSo1GEmTEplZ3vlvCCt9L4ErzbWgUt9NsQPWFAilzi3G5E2Z/rBQK60NDXb
 3tYznPyMFUB+JNGLC4ospGS2g1yRhPQ295Gc0ULi7LbB7KcevBFNdvUwCH/GqX2qgWF10l2ZNT
 xg8=
X-IronPort-AV: E=Sophos;i="5.69,412,1571673600"; d="scan'208";a="128585961"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2020 13:04:52 +0800
IronPort-SDR: HB3DZnIayLYhI2Do5fmHu4mtukkcQy3uaFy2Wy/C2rq/rJBrzfwa/YpbE1A5PyGJhud3axZPlM
 nsBakLuw3Wn/8hmeYMo6Fu4TTYoWshxb9nMjcm6fcYsZlo/2U24kl3eJn5KcRGx3b3rGHne/Jo
 zuSII7FdQ6ZiO1uskL0EhrEx0yrcsz6ZINaaZI8uuQJAhsQ1vI1dxzQPzzFkbM7Kt+7Ce3mFlB
 e37vnCEEgZS7mNGsOCgtxL0PhEv19lc599KEPpb0ZsOxsT9L1vJjCM2AKB52+9Sdn/mEiBOXM3
 y2CcVwOR1Op0d1qN3R6KewKo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2020 20:58:38 -0800
IronPort-SDR: QXlP4xJF8SOjXJs/dJJ/95XthzjvhkZ0uLaAbRgvXHHhww8B/ewVeTG7fsfuXhCJDAOKoKw73y
 6tn6Rw/sCRXSQxzMVMgeqtk4Xe/DrGXBDpcHeAGClj9oUtFaBHG3m42Z9oYEYwnlCMlaNT+u0n
 JyzpN1R6M8M2vo3eIET8e8OJFO5g9Rbdj9NoNAPngAn7KqCGQ73idI1gU/rZDKwFv9oV6CvJFt
 zq7mdTg1388az0DaGoblYKvdF4i7PEx/JtqyWc205a4JM8a8gtR0MQklRL8XThccxp9jvNjaSz
 +ak=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Jan 2020 21:04:52 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH RESEND 2/2] nvmetcli: allow setting of the subsystem model
Date: Wed,  8 Jan 2020 21:04:48 -0800
Message-Id: <20200109050448.5758-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200109050448.5758-1-chaitanya.kulkarni@wdc.com>
References: <20200109050448.5758-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_210500_272689_5EDA63D7 
X-CRM114-Status: UNSURE (   9.40  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Mark Ruijter <MRuijter@onestopsystems.com>

This patch allows users to set the subsystem's model.

Signed-off-by: Mark Ruijter <MRuijter@onestopsystems.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 nvmetcli | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/nvmetcli b/nvmetcli
index 4fdac53..ea17f95 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -157,6 +157,7 @@ class UISubsystemNode(UINode):
         'serial': ('string', 'Export serial number to hosts'),
         'cntlid_min': ('number', 'Set min ctrl id'),
         'cntlid_max': ('number', 'Set max ctrl id'),
+        'model': ('string', 'Set a model description'),
         'version': ('string', 'Export version number to hosts'),
     }
 
@@ -189,6 +190,13 @@ class UISubsystemNode(UINode):
         if cntlid_max != "n/a":
             info.append("cntlid_max=" + cntlid_max)
 
+        try:
+            model = str(self.cfnode.get_attr("attr", "model"))
+        except Exception as e:
+            model = "n/a"
+        if model != "n/a":
+            info.append("model=" + model)
+
         return (", ".join(info), True)
 
 
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
