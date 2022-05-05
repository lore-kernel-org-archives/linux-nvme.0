Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C49EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 19:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HXBtYNEiiGr36yW2oPCyC28YGPtQYlQmBj0I/dHrOhM=; b=pj/CeTXR/vyJBMg0MVd/B8Ug1N
	V65JF7mYLPw8jXgLmhI3eEJTWnIXtZn6/zXSEi72xBZscpkyY6KUMmjQwlciPlMIOVZXpl4HpNaLQ
	7tGq8xevQQLEpveAhNJavW3HeS0mOxNqBChBsXxXbXXH9Cz80LmMYlntCoSKHGWO+oz0mst0gfK1P
	7XbmBzyPkPYIpVJ3rMonxTtleOhZlZkR4UX7iLmvToVYZEvDwYraf+/gQGR9bGnDXRah7TXnXGs/1
	W1DL1dxUcLuvLrH+HR4Yo4bOlOPe5RdqDYZUoX3+g0FJ/GeNGtWX5VqiIJZcgEcPGEDrpPURwPEha
	vK3BlsBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmgsb-00HSku-OI; Thu, 05 May 2022 19:11:13 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmgsZ-00HSjr-Bs
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 19:11:12 +0000
Received: by mail-pf1-x434.google.com with SMTP id bo5so4388981pfb.4
 for <linux-nvme@lists.infradead.org>; Thu, 05 May 2022 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=HXBtYNEiiGr36yW2oPCyC28YGPtQYlQmBj0I/dHrOhM=;
 b=OUAbkaks+yvM3DtQVdmaNUM1XSdBgNI0yzKqP27uXLLn/szGtmPaPtIxtTUkZyMb/Z
 D8OL2MZMesLq6doSNR9iEtiP3ehxbM2sSSVGqCscgzZQ3qBDlgd30F0YqdYm0/7Iqqsq
 fQNDjLrHU4E+eZAu0vHzdyvyRQuY3/A3y/IqgY5dKnPfI7hCm294RZEk3fEvrW1LDt20
 x2goc4Bv2WDyx6ZUOVop/O8s2SCHovptaQbjxcrWUjG7JeA+9IJNdbd+cZwfO1iWgYKw
 7lOW+NbG7ybtAXj4CvSo6v0Ffl+PGxilxLJTThUIadPsZtm+u5gsjMVDJRhqHnwECCbK
 8ufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=HXBtYNEiiGr36yW2oPCyC28YGPtQYlQmBj0I/dHrOhM=;
 b=xaY7o0J8ZnWqohcfKleoG0aYmua2QtptMzwfEbIhb8xhSOFVx9CLMvuh8v/IcL+vYI
 PKLbuOUwBPwoEHNr+5xg9i8vLeYNSFCGWK8GBPPuKDTl9SfpT2ukNWr1gVdlo+YqpAFZ
 nH+mU8ocjtVdJLtdf81HFEEjLFnyB9m1TUK3CZdZMlC0xz1iYqzJw0pPRfvlyTt9l+Pw
 g3dipY84rb57FObYEEPYTi6DYyk/XL/ErQ850dvFWPTlFT/YUkSSwt7cJr4petqVQKXC
 BnTlWupzjA9JxduuuEEkU9riZ849c2Iv4bCw0/+Y/JnjRWEosXjB251DXlZWU7z9m5Nx
 iK/w==
X-Gm-Message-State: AOAM530lLCTxtaJhkLpyT5q+2X3zNNTXdrTwmaatkfi6bOJly66HiwTL
 2nXOd0kXxU683BKCUc2RbSniKNVFpR9M5Q==
X-Google-Smtp-Source: ABdhPJzFCnYOZXGucw65UIthd+Nw8r8hqArXNb2HHgNadpWvS0eO30S5s5Av/G7fI6pV3uGkKSKw0Q==
X-Received: by 2002:a63:d00b:0:b0:3c1:6c87:2135 with SMTP id
 z11-20020a63d00b000000b003c16c872135mr22631515pgf.93.1651777870404; 
 Thu, 05 May 2022 12:11:10 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 185-20020a6219c2000000b0050dc762815esm1715203pfz.56.2022.05.05.12.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 May 2022 12:11:09 -0700 (PDT)
Message-ID: <93e697b1-42c5-d2f4-8fb8-7b5d1892e871@kernel.dk>
Date: Thu, 5 May 2022 13:11:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 3/5] nvme: refactor nvme_submit_user_cmd()
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
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
 <ce25812c-9cf4-efe5-ac9e-13afd5803e64@kernel.dk>
In-Reply-To: <ce25812c-9cf4-efe5-ac9e-13afd5803e64@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_121111_456670_4E7419FA 
X-CRM114-Status: GOOD (  17.09  )
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

On 5/5/22 1:03 PM, Jens Axboe wrote:
> On 5/5/22 12:37 PM, Clay Mayers wrote:
>>> From: Kanchan Joshi
>>> Sent: Wednesday, May 4, 2022 11:06 PM
>>> ---
>>
>>>  drivers/nvme/host/ioctl.c | 47 ++++++++++++++++++++++++++++++++++-----
>>>  1 file changed, 42 insertions(+), 5 deletions(-)
>>>
>>> +static int nvme_execute_user_rq(struct request *req, void __user
>>> *meta_buffer,
>>> +		unsigned meta_len, u64 *result)
>>> +{
>>> +	struct bio *bio = req->bio;
>>> +	bool write = bio_op(bio) == REQ_OP_DRV_OUT;
>>
>> I'm getting a NULL ptr access on the first ioctl(NVME_IOCTL_ADMIN64_CMD)
>> I send - it has no ubuffer so I think there's no req->bio.
> 
> Does this work?

This might be better, though you'd only notice if you had integrity
enabled. Christoph, I'm folding this in with patch 3...


diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 8fe7ad18a709..3d827789b536 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -21,9 +21,13 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 
 static inline void *nvme_meta_from_bio(struct bio *bio)
 {
-	struct bio_integrity_payload *bip = bio_integrity(bio);
+	if (bio) {
+		struct bio_integrity_payload *bip = bio_integrity(bio);
 
-	return bip ? bvec_virt(bip->bip_vec) : NULL;
+		return bip ? bvec_virt(bip->bip_vec) : NULL;
+	}
+
+	return NULL;
 }
 
 /*
@@ -205,19 +209,20 @@ static int nvme_execute_user_rq(struct request *req, void __user *meta_buffer,
 		unsigned meta_len, u64 *result)
 {
 	struct bio *bio = req->bio;
-	bool write = bio_op(bio) == REQ_OP_DRV_OUT;
-	int ret;
 	void *meta = nvme_meta_from_bio(bio);
+	int ret;
 
 	ret = nvme_execute_passthru_rq(req);
 
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


