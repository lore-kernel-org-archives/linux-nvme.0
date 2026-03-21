Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66731094463
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2026 10:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8gSvEXvLNrFWzXilQr1NHH72SCF5cRdSmCN6DzRuhF4=; b=L3njSpG3xZFaN0IQyF3CNDKZG/
	P5cchZWOoWvAFGlddUVENupzFfNZrvVfL6EdACLZ4mOL8KpHKP0mKTc8ZkIJv2wO9OvIUcKdEf2s9
	oah6gCl+u1cNOBuitDUuTyT70VqxhzdguGFXSHiGwAqvomY/8dC+io7vUyaJUx6H05y+fi7O1zsvJ
	sXm5nbcKT7t3C337Zxms0ZcIxBUOGYKq8mpLSj6IBeZToBQtxZljrwH/chsZpvQ0Qk3zhUj9tXkU1
	eyVERlFD/wXRqGHe9nNp7hwBj3lZS3ML0twouEu7eDPVGX3adFuQdnKrwC79fMHr7C7Wkf9SUdX1g
	dwmcXetw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3tXN-0000000EM0B-2Bfp;
	Sat, 21 Mar 2026 10:26:33 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3tXL-0000000ELzr-1fsk
	for linux-nvme@lists.infradead.org;
	Sat, 21 Mar 2026 10:26:32 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-43b49819938so751220f8f.0
        for <linux-nvme@lists.infradead.org>; Sat, 21 Mar 2026 03:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774088789; x=1774693589; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gSvEXvLNrFWzXilQr1NHH72SCF5cRdSmCN6DzRuhF4=;
        b=uEqmokMjRahxOsuJe/60SvD1oTqudYAIQs9oVlGkb/wqxR2G49qAZtM0GW0BGeXfJT
         e35UAnj+JciSTVP+K8/x5Tb1YO+7+PwoIIBBXYbxFI+LBunNs2MeyoVvaUJx9ggFjRH7
         phxv7M6auO9D6ft6SbTeU5+Ghjj+80BPGLgVg7MyXIMg2PIctouqTLUSK01Jy50pH5h7
         5GuePLz5ymhIDT5o5HtfWhPh8wuR+Vn+/YNp5eP63zC7q8SAXWFEQuL/zc3D3jymOXvA
         X8Z7YwUET7yXpw6MZ70jrhfuRgGntDskl0cxeq0U2KHXEvQTb8aMVgTWSjchmflDKbSS
         fxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774088789; x=1774693589;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gSvEXvLNrFWzXilQr1NHH72SCF5cRdSmCN6DzRuhF4=;
        b=elo9w7XsOBMExD7t0QoK6zUFNP36rlPhwghCGfxXmBb+3FacG3BXwR6uGNbiz/hhvE
         Y5aBbRMLOcDRwgeh//JWRl/v4BRuMkcz06HvZtdB5nyxlZqCJFVME7mEVv+NK0hg42rl
         Eg6kiXvdtQUBGD72dmUyk2au6nyIFWDscTKh33Pf0eevP4ncxenBEa6qT+VCgmUq3W4i
         EI/PUOCvOfugUh/9sEadL73hpMjFn79vt4c4tac8tuNMqOaCAbwvVHCsYuVO0hqvCsuU
         HehDDHH6Yy1+UR9MNDpPhRNlOfCmrqHftQZf4NN9hGj3hmLryeS0Yb8DeYnq4m4HMzKD
         TIvg==
X-Forwarded-Encrypted: i=1; AJvYcCU5/iXgAOgz2apX3wkvnrZ56CxnnhkW277EcbojSSmveeUxPmAgtaKpfAzTew8MqnWrXOwIh6vlDE16@lists.infradead.org
X-Gm-Message-State: AOJu0YxwSoiuS8o7yEdTXTxcOlg6Qus7Eq/Q9mQj/2GNEza2Td2TjKNd
	uZT7EQge2pMrow56XqndPez7uJPMAEFGdtZ7H3fsPdP1VSTyzTwZATRPeHdef2JPY2s=
X-Gm-Gg: ATEYQzzlaGjyCN6qAdiL4QunVzzXlJBKGy0LYB3AbvsLFTGkCbBTksFhxll1qE9IO1H
	iWIBSEwbBappk5/iOCENN+87W2EFlD4cjnT0cd2Jp7TxlPNmwaaIbPW45YiPQ6zRElnNmxLt1n6
	1T94wDVQu62GtmlxhQTT1/yTY8xY1pB/XmM7uhoSa7pDpQ2+w7Rof2FU6nzxPrfCtD7xgr+G3zc
	PzgvK34hkgcCL4Z0UoKLhxpxFBiltKMfukYmWYWUq2TXxzaEGXdbpPplgEv5XeH/i9joDPU2hiu
	gysnpRyY0RJYjAl3kyrsV8NWK2p8cMjWr5Rr4On+ZMiz7ye53KTGplm5dDGxnRQRhQnjzp+jXek
	Hj+KRuKkC3TUtrYMcNUJn9SghN873vSy/hclvmpZUNJAQCl2LXdrDzQ9ZmjVaGhZMVeSylY4D78
	RInMZrzudhI8yw0O/uXPiiO/+LtO9ijpuQjojrCqQ=
X-Received: by 2002:a05:6000:2310:b0:43b:53c0:f6f with SMTP id ffacd0b85a97d-43b6428ad3fmr9710653f8f.54.1774088789134;
        Sat, 21 Mar 2026 03:26:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae016sm12771163f8f.4.2026.03.21.03.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 03:26:28 -0700 (PDT)
Date: Sat, 21 Mar 2026 13:26:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Keith Busch <kbusch@kernel.org>, Sungwoo Kim <iam@sung-woo.kim>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH] nvme: remove bogus check in nvme_pr_read_keys()
Message-ID: <ab5yUf3BqtlN3K-P@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_032631_475044_45CF8422 
X-CRM114-Status: GOOD (  12.98  )
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

This check for if (rse_len > U32_MAX) is confusing because if
rse_len is > INT_MAX, that will trigger a WARN() in kvzalloc().
Fortunately, the caller blkdev_pr_read_keys(), puts a limit on num_keys.
The number of keys can't be more than PR_KEYS_MAX (65536) and the
condition is impossible.

Delete the confusing, dead code.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/nvme/host/pr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index fe7dbe264815..abab2746f0f8 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -239,9 +239,6 @@ static int nvme_pr_read_keys(struct block_device *bdev,
 	 * enough to get enough keys to fill the return keys buffer.
 	 */
 	rse_len = struct_size(rse, regctl_eds, num_keys);
-	if (rse_len > U32_MAX)
-		return -EINVAL;
-
 	rse = kvzalloc(rse_len, GFP_KERNEL);
 	if (!rse)
 		return -ENOMEM;
-- 
2.51.0


