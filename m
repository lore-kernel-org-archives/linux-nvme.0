Return-Path: <SRS0=dgXS=5F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4393C4332D
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 20:41:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B9E20724
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 20:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G51+6sIQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9Powxae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B9E20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OBigGTYYobZsBwIzGnrZMIdJdg+MjFBd2EDflMnm8BM=; b=G51+6sIQKxPIwO
	dWzkKA/Pt2+j8bAIdxFP1/LX43n9tZJ4UoStjQg6GaFPSkf0nbZVHy5E6uv9/5Dcj4+OtGjuHPGOT
	cYjyR2+8SX8PSqZuTFRVv8yovBtz+5e1lvOCxNeLd595WvozXIO0+KZjiie6LBUfaFAfimragAbcn
	OSW8J9cXxy96stNKn3m8MaE7UnRWSsHptRlZiIMkGUzY0PkEsQ31mUWxTodeZutKW8Gj0P/axRGgh
	XXUnsyv/kQf+I+P2YTli78qMVgh6cUnu0FjAHMvmBEc0I2kwn723BIna5bsygEtFAi8p2VeNiyPes
	KcFRTnYtaVSuQDwiU9nQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFOSg-0007SB-C9; Fri, 20 Mar 2020 20:41:46 +0000
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFOSc-0007QW-DP
 for linux-nvme@lists.infradead.org; Fri, 20 Mar 2020 20:41:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584736900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4qpWg7q0TTy0XE/W/wgkIpXZCrB5fNaDHKQbH0OVps=;
 b=i9PowxaeAgzsoizP/iR8/jTDPOSwKI2j69Gm+iD2k3r+Qy69+UMCs+MLZO4YTEXFbJWVxa
 uKILm9VsiN87XPSv1jonX9GPgtV4E3V3viAGWgvOcR630v6KWpL/4Z7Ub+9MVU+QC43+KL
 AN3KVCMGYmuFkKOaRKmk++lblayBh7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-nOnfs79jOwu5o2eJpfxRrA-1; Fri, 20 Mar 2020 16:39:54 -0400
X-MC-Unique: nOnfs79jOwu5o2eJpfxRrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 321FD477
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 20:39:53 +0000 (UTC)
Received: from sulaco.redhat.com (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B381A90817
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 20:39:52 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 6/6] test_nvmet.py: Use string.ascii_lowercase
Date: Fri, 20 Mar 2020 15:39:46 -0500
Message-Id: <20200320203946.37338-7-tasleson@redhat.com>
In-Reply-To: <20200320203946.37338-1-tasleson@redhat.com>
References: <20200320203946.37338-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_134142_532599_E63595EE 
X-CRM114-Status: GOOD (  10.39  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This exists for both py2 & py3.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 nvmet/test_nvmet.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvmet/test_nvmet.py b/nvmet/test_nvmet.py
index 5caa546..aae4a86 100644
--- a/nvmet/test_nvmet.py
+++ b/nvmet/test_nvmet.py
@@ -391,7 +391,7 @@ class TestNvmet(unittest.TestCase):
                           nqn='/', mode='create')
 
         for l in [ 257, 512, 1024, 2048 ]:
-            toolong = ''.join(random.choice(string.lowercase)
+            toolong = ''.join(random.choice(string.ascii_lowercase)
                               for i in range(l))
             self.assertRaises(nvme.CFSError, nvme.Subsystem,
                               nqn=toolong, mode='create')
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
