Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFD8C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 19:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aP+sRyqjiJck3nF00KFz6cvLIN38Ozm1Q/g2weDJD/c=; b=O/uEuYSxzlZM+VgBK/cohjm5HK
	dMMpIj5IQ/nFIIqK0owcZv/xf1Hx2KRwJ9lrFiaha2q4huI8yIIZKxl/EfmpzhiNLLqHhvVFG+55C
	TCJt3bytUXAN/bhegYcuzdR+yt4lPx1D36PFZoZaWy3R6PCdq4efX7t6UlaHJFiB3qqE2w/NXky4s
	P6m3M2bAc8gXM/Wl9vx95irA9DvcAFeTsf4I1Mec1R0LIT0hwiQmLLrpdR31A91FYWjvoft0jtdOT
	QgkHM3+VdBzn2OsP3mKlpE2xedL2yHPg2U2dVVJOOEHWjh1gLFOG3goRqldwgY6QU9Y8xZsjwLsoZ
	OjLnHREw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmgl4-00HRhS-50; Thu, 05 May 2022 19:03:26 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmgl0-00HRgI-Cr
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 19:03:25 +0000
Received: by mail-pj1-x1034.google.com with SMTP id
 w17-20020a17090a529100b001db302efed6so4899583pjh.4
 for <linux-nvme@lists.infradead.org>; Thu, 05 May 2022 12:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=aP+sRyqjiJck3nF00KFz6cvLIN38Ozm1Q/g2weDJD/c=;
 b=nuTXi4Gks8zLZQTUikN10ntUHm93mhBNnjy6gt1M7Uah/Dxdvs4vjo75/q/ZdnipWm
 jzppcJIQkTx987/dZIGj31IqkwC/MZHBHGLemoJ4OV0JCLxDmAjG2Qq/zwc/hDZ1I/sA
 AUvr3W6ouV7Bx/bPPxsTOkHCRw3iGg2f3FtFI8gR0sPKssVP/S2Z8m0VXKzX4c+UbFUi
 sd1+I45O8pusIMnmRlB6bsz2U9wcmnXYM8pDVjsVu0GXVo5Sy+wd3Yw/qYwgCcQdlSLg
 mUU1+AhKMZzxaU4cMa2iyAMKIDN/o1t8SO3t7t1J1UhDkgnI13tC0X9bQUfYgTf3ODnl
 x4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=aP+sRyqjiJck3nF00KFz6cvLIN38Ozm1Q/g2weDJD/c=;
 b=nm+qjn4dAHu5ANRvc0dZZ5pWnoMYozhABmoZIK8K7CZkx1UicQSDX2jTy6GbUXveQ0
 oRffd38zvDL9LJPLioN/1rils2BnG9+RyzpVRsRGcmE62ZLdqWmUSZ2qLBFRJTVstESA
 0bKVXKnhlEMGuua5SdgfHkxVWve0pMG0KRkpcxqHwmcGcDv6ZSPF0LtLzvtMU9St+E4I
 IX7eZm6AzZ+8EVH1H0FzMD3z8zXL9Wlu/zbnHpE5JqhV5WmdP8eVh04faFMAGTq8Rl4l
 3+QFz0rw5ABmL4tbBz9qR7rjzNnAfEKPR1Yxbw6PADROBVAoPbFHe/sxwA1QrkkNxIh/
 HFlQ==
X-Gm-Message-State: AOAM532tA2d+xSBpF477jmYxQ5YWLi4egu8/UwfGMrv+mxG4aY3AkQot
 6i3jjhhK4n+ZMvdDcJR7fqKKxg==
X-Google-Smtp-Source: ABdhPJzDmj6HX/+1D0KDhpk6zS+5xDYteqaTRmNPNypBuaLzlwXlzfKr6TghC+yZ9YL2/KhcyNlEpQ==
X-Received: by 2002:a17:903:244e:b0:15e:b3f7:9509 with SMTP id
 l14-20020a170903244e00b0015eb3f79509mr16796803pls.42.1651777399239; 
 Thu, 05 May 2022 12:03:19 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a170902b40500b0015e8d4eb29bsm1875955plr.229.2022.05.05.12.03.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 May 2022 12:03:18 -0700 (PDT)
Message-ID: <ce25812c-9cf4-efe5-ac9e-13afd5803e64@kernel.dk>
Date: Thu, 5 May 2022 13:03:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 3/5] nvme: refactor nvme_submit_user_cmd()
Content-Language: en-US
To: Clay Mayers <Clay.Mayers@kioxia.com>, Kanchan Joshi
 <joshi.k@samsung.com>, "hch@lst.de" <hch@lst.de>
Cc: "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "asml.silence@gmail.com" <asml.silence@gmail.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "mcgrof@kernel.org" <mcgrof@kernel.org>, "shr@fb.com" <shr@fb.com>,
 "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061148epcas5p188618b5b15a95cbe48c8c1559a18c994@epcas5p1.samsung.com>
 <20220505060616.803816-4-joshi.k@samsung.com>
 <80cde2cfd566454fa4b160492c7336c2@kioxia.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <80cde2cfd566454fa4b160492c7336c2@kioxia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_120322_482988_5BC48057 
X-CRM114-Status: GOOD (  15.60  )
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

On 5/5/22 12:37 PM, Clay Mayers wrote:
>> From: Kanchan Joshi
>> Sent: Wednesday, May 4, 2022 11:06 PM
>> ---
> 
>>  drivers/nvme/host/ioctl.c | 47 ++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 42 insertions(+), 5 deletions(-)
>>
>> +static int nvme_execute_user_rq(struct request *req, void __user
>> *meta_buffer,
>> +		unsigned meta_len, u64 *result)
>> +{
>> +	struct bio *bio = req->bio;
>> +	bool write = bio_op(bio) == REQ_OP_DRV_OUT;
> 
> I'm getting a NULL ptr access on the first ioctl(NVME_IOCTL_ADMIN64_CMD)
> I send - it has no ubuffer so I think there's no req->bio.

Does this work?

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 8fe7ad18a709..f615a791a7cd 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -205,7 +205,6 @@ static int nvme_execute_user_rq(struct request *req, void __user *meta_buffer,
 		unsigned meta_len, u64 *result)
 {
 	struct bio *bio = req->bio;
-	bool write = bio_op(bio) == REQ_OP_DRV_OUT;
 	int ret;
 	void *meta = nvme_meta_from_bio(bio);
 
@@ -213,11 +212,13 @@ static int nvme_execute_user_rq(struct request *req, void __user *meta_buffer,
 
 	if (result)
 		*result = le64_to_cpu(nvme_req(req)->result.u64);
-	if (meta && !ret && !write) {
-		if (copy_to_user(meta_buffer, meta, meta_len))
+	if (meta) {
+		bool write = bio_op(bio) == REQ_OP_DRV_OUT;
+
+		if (!ret && !write && copy_to_user(meta_buffer, meta, meta_len))
 			ret = -EFAULT;
+		kfree(meta);
 	}
-	kfree(meta);
 	if (bio)
 		blk_rq_unmap_user(bio);
 	blk_mq_free_request(req);

-- 
Jens Axboe


