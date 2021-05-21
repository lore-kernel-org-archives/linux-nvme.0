Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55384C43461
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 07:35:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52696135B
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 07:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52696135B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m+TvK1IWwUix6FhMYea2YlSbJ76eCQeY6i220MRPDIc=; b=RmYiv0OqznvST3A5jlEWwj3mVm
	IsRIdFqX+cx5glIE+x09uGQQAbcPM4voUdSG/PjwQd6docyR3gMyQ1mvjZ39W/7wJ2xZmXCXau9dT
	hC0+YT+PFGj6kgDHnmslIFBh5Uhq7x8cwIcdbsfU/CnkHLvTwY84htuqqwJ2DnJFSSVG0KEpsZy5g
	aBVsJAZUcY0M0rUfww0nhngaiYpC+IbMccKHs4dms1ajgytEyMPjfJOKH/LFDqMpcMUra2OYfV9HZ
	DocyOvX9ZZZkKn/Hl6BPq5QFpPqBYiuZJFs/3SC+9DTI4+UPsrhc5JUtsgB3Mk34BTlu4ker81xI/
	Nx7vKlyQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljzgY-004Egx-6V; Fri, 21 May 2021 07:35:06 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljzgP-004EeP-HQ
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 07:35:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=ahZMgEXc2Ijz925wVcobBNHitqFzajxGSq7zfoSlga0=; b=pgpyDgTV4j9QEKd1A6TZ/rgXxH
 rTMbu2MSXBYw2g6VefxXp460Q2NgSlXV07yN/d/znC0JV0VC37RhsK6j1o53gUbqIfWDnXmwxPcZX
 pCXJslwkr1zdq7qAlZWYejllJ0ikZ2q+/aOts32+1CQ/N4WrNzod6gMhu4zf4ijXfMZ/EKODT3Qoy
 9SOVtimzkI4ZNSdhiQjqRLllaHrgR05ToNnnId7a6JF2exBSBNAAqVTy5VY0EVyB1yqdLJ3GZ8TG1
 haOEA0QU6doYBblyd1AdxhgXgVJM0VxxpLNJZZCEWfhW3t5kk0HZS912EaKzeBZtiYGHF2X0R9nhD
 xrNjl1og==;
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljzgN-00Guq3-0Z
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 07:34:56 +0000
Received: by mail-pf1-x434.google.com with SMTP id s19so12048111pfe.8
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 00:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ahZMgEXc2Ijz925wVcobBNHitqFzajxGSq7zfoSlga0=;
 b=CEXZ+5g7vfNgvrlZha8oiKnecQxYZ8QYRpWLIcsq1X4sk2t8UH/Jzf+yBsxzN+eYso
 yfsBZ/GJbgiWVL5TbDtLTs6QO1n2e75izXs5JAqm4rJIAKBRFYH5OFNuEAxNB7wijpOd
 qr4hRGRAWE5U+lOQMKO2m2s+fd3RT33rCHCKrBMlSOM5LVt3uCJY4qNspcAyisebW9bZ
 Pi3TEUJSlwzCGlTB4UYe01iihzVnZfK5FYhleCU2yCcKhiG587tWfIqbab+klkHhF4rm
 cn+UJuDt6gR42o6FqaQl9PgaowJnrKzbRTDVstQkWeYHZQ3VZ0STBCNNqqL8JbFI0Wcw
 x49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ahZMgEXc2Ijz925wVcobBNHitqFzajxGSq7zfoSlga0=;
 b=JXHLPEJoOT6ckd4TBzaH9yhL39mfL1g1+l/dSwuXJbqcZepMzrnh2Vv3/3G86N/LmA
 YdeJTLJy0Z8sVHQeDZsubePf2LX9WuHVAEpMABcTlLRW7RTqPvcTME98Q64KyV/K6NMX
 6Wy5RFIoYSoh2VeHDCNtXf/1muKiMvfmKc9powBLcg8LyHEBF/r89myPHh8LFss7a+t7
 r6e7KxvW8cd69Bi4ufWxwm2GeDHSRhDMseVakhKn1OBV0pRialLvEqnZTzWLdzVj/vhA
 aRTX0aoSUuiZGLIpLxv3WyKwdVuuQfiNqvnwE71rBOjiNC7opZR0d1JtPVR6J3QAiIIl
 YrUQ==
X-Gm-Message-State: AOAM532WAF/s6zSaM6cRmxUcnkXHOY9Y7xhaKIRLVHfcFw1XptR16p6R
 qSLeHTo7/iC5Y1cShGo7pLI=
X-Google-Smtp-Source: ABdhPJw3rTg47rxiqiUc1OI6GatvEAnnhCmv1ey73sB6sc95K7XCR8WxRX7p7oHe0Ac/u6x09+gU3Q==
X-Received: by 2002:a05:6a00:26eb:b029:2db:6b23:18e9 with SMTP id
 p43-20020a056a0026ebb02902db6b2318e9mr9096356pfw.56.1621582492971; 
 Fri, 21 May 2021 00:34:52 -0700 (PDT)
Received: from localhost.localdomain ([89.187.161.155])
 by smtp.gmail.com with ESMTPSA id m2sm3717266pgu.85.2021.05.21.00.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 May 2021 00:34:52 -0700 (PDT)
From: Guoqing Jiang <jgq516@gmail.com>
X-Google-Original-From: Guoqing Jiang <jiangguoqing@kylinos.cn>
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 javier.gonz@samsung.com, minwoo.im.dev@gmail.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: fix potential memory leaks in nvme_cdev_add
Date: Fri, 21 May 2021 15:32:39 +0800
Message-Id: <20210521073239.722341-1-jiangguoqing@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_003455_093386_152A6329 
X-CRM114-Status: GOOD (  10.80  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We need to call put_device if cdev_device_add failed, otherwise
kmemleak has below report.

[<0000000024c71758>] kmem_cache_alloc_trace+0x233/0x480
[<00000000ad2813ed>] device_add+0x7ff/0xe10
[<0000000035bc54c4>] cdev_device_add+0x72/0xa0
[<000000006c9aa1e8>] nvme_cdev_add+0xa9/0xf0 [nvme_core]
[<000000003c4d492d>] nvme_mpath_set_live+0x251/0x290 [nvme_core]
[<00000000889a58da>] nvme_mpath_add_disk+0x268/0x320 [nvme_core]
[<00000000192e7161>] nvme_alloc_ns+0x669/0xac0 [nvme_core]
[<000000007a1a6041>] nvme_validate_or_alloc_ns+0x156/0x280 [nvme_core]
[<000000003a763c35>] nvme_scan_work+0x221/0x3c0 [nvme_core]
[<000000009ff10706>] process_one_work+0x5cf/0xb10
[<000000000644ee25>] worker_thread+0x7a/0x680
[<00000000285ebd2f>] kthread+0x1c6/0x210
[<00000000e297c6ea>] ret_from_fork+0x22/0x30

Fixes: 2637baed7801 ("nvme: introduce generic per-namespace chardev")
Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 522c9b229f80..2e8da13c842c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3485,8 +3485,10 @@ int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
 	cdev_init(cdev, fops);
 	cdev->owner = owner;
 	ret = cdev_device_add(cdev, cdev_device);
-	if (ret)
+	if (ret) {
+		put_device(cdev_device);
 		ida_simple_remove(&nvme_ns_chr_minor_ida, minor);
+	}
 	return ret;
 }
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
