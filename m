Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AA9C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 15:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SvWyFJZNYQN+hDCxIRXzzdxVe6wwtRttv3fHKAE+JmM=; b=wAjwH7d0+NTawfv3a0JbB9LkNd
	ka4Y2Ad2SPFhKbsHNOXq8pr8CteZtQKKjvn0H4LhoKMIknMBvvAocHsXuAd3q0bKXnYqckUQmpPf+
	wC+HmMpyySGf1QKMHPaG8kDWZpKJIAO/awy6WPoo0awnQ0hGWRQEUGhemGdbLWZ8eGdjyeMlyGEYg
	Fyz3uhDHjacaLMBzT3mginbgzv6EwKTPetA7yYXGv6pvAvQqAIyXrXgCO7zS42ELl9ibLOWax1GCk
	fRM0aU0CJQZBZJj00wQCpD5DeuHFmJ61TncGoN1RaUT0NPWmI+oAeQw2AHaeXUbG5FYpWt0trSpvD
	AIL244Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAAS6-00000006fGW-3Hrt;
	Thu, 23 May 2024 15:33:58 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAAS3-00000006fG0-06xy
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 15:33:57 +0000
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-36dd6cbad62so4556695ab.3
        for <linux-nvme@lists.infradead.org>; Thu, 23 May 2024 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716478430; x=1717083230; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SvWyFJZNYQN+hDCxIRXzzdxVe6wwtRttv3fHKAE+JmM=;
        b=VLWJ6V7OMtBHS/yANCemMa8pkZeBcXJiNnVRgPgx2vuW5+5ZEhY83qIOXeW2zvkz4K
         TwVY+7ssKk89Jx3dpq/uIl2QYCOoTrDkghg/P+DBpizCt8ZwCmOvwktlfJA04K0lxjQr
         fvblFjojZCkSPf2bnYOzn8XNbSuBm1bX+Y2cYmhSC6WewQG/RjKgp34XWSnsLdbo9a5G
         mrLRzhSVBhiZ0uPCmAqDs5PrVuHGkc9Cu96kLZzR4xXvLf4yV7JrA89Y0u3VeND5tEGD
         Pjw5pclR3yo3sbkwOZNU7PkOiL1JBniECbFCC1QZERcAG8b69Zg60coNmrXUDBRj2B1x
         8sEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716478430; x=1717083230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvWyFJZNYQN+hDCxIRXzzdxVe6wwtRttv3fHKAE+JmM=;
        b=M3R7jS66KqMdH1RiMCpXsJX4HJpjwclGMOpLK/hCR33CuPxgknOpeRFYpL9W7DeT3D
         M3uk/8CVbyVzIGSnrK2Kmih0PtgUx7TSlFEMSJPgGD0dn1W71jdTuqJAhD/sLaOjnNvB
         puZL/3InvB2ibIgLUYR8WHuCzYcNnXrv4ClyQ/XRItCaDBOndrcjiL7ljeQ2zSzeJ1DW
         mgBWQzLxrNztN15G5sS7+19vnZ2jsNELmPjpILQiWCCbFlGSeQCAjx9N/p1GdVg9XzoO
         uoyLVhn04t81UeYMRsIEMKFx3Ri6zlgUTK4LvlKh/B8QTvqf+v4kCoDNn9wtdEuOlkeQ
         u7kA==
X-Forwarded-Encrypted: i=1; AJvYcCWQjJ7qhfiLuvAPYM7gsI+cQjcnQQvPZpw6vRvsxQQ4Ra1zhWHSWC6huS+qvFStiLIpxdw1ybtp9IzZ7X78lfRKrX+M/sG8p3THRPnZ/nk=
X-Gm-Message-State: AOJu0Ywz/AhJsVnb3CJ5zPt3VPUeHllAfwa6itZcQihzYrV0NgD1pSnC
	rjOzDZA+7BijHbGmvYqgTXfwYgiXEy3eNK0YY2oqCv+FQW0EO9klx75oxQ8wB/0=
X-Google-Smtp-Source: AGHT+IF5NcgPaSwej7+H6rkVJpCG1LN6K+ptgamP3mzzVLSM397L3FcGvlEY98JyQtKJbxKK2SxjEw==
X-Received: by 2002:a5d:84ca:0:b0:7de:f48e:36c3 with SMTP id ca18e2360f4ac-7e360c17344mr550273439f.0.1716478428270;
        Thu, 23 May 2024 08:33:48 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489375c13f9sm7936231173.97.2024.05.23.08.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 08:33:47 -0700 (PDT)
Message-ID: <9ef7cff7-1ef5-4a3f-a2d5-5d7e28bb8a44@kernel.dk>
Date: Thu, 23 May 2024 09:33:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: change rq_integrity_vec to respect the iterator
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>,
 Milan Broz <gmazyland@gmail.com>, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com>
 <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com>
 <8522af2f-fb97-4d0b-9e38-868c572da18a@kernel.dk>
 <7060a917-6537-4334-4961-601a182bca54@redhat.com>
 <b1ca89ae-1500-4c3c-bd8a-74e081aa8dd3@kernel.dk>
 <798720bc-bc69-1e1c-8436-474e8a9fb0e8@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <798720bc-bc69-1e1c-8436-474e8a9fb0e8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_083355_207536_4A96F7E7 
X-CRM114-Status: GOOD (  16.26  )
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

On 5/23/24 9:11 AM, Mikulas Patocka wrote:
>>> @@ -853,16 +855,20 @@ static blk_status_t nvme_prep_rq(struct
>>>  			goto out_free_cmd;
>>>  	}
>>>  
>>> +#ifdef CONFIG_BLK_DEV_INTEGRITY
>>>  	if (blk_integrity_rq(req)) {
>>>  		ret = nvme_map_metadata(dev, req, &iod->cmd);
>>>  		if (ret)
>>>  			goto out_unmap_data;
>>>  	}
>>> +#endif
>>
>> 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) && blk_integrity_rq(req)) {
>>
>> ?
> 
> That wouldn't work, because the calls to rq_integrity_vec need to be 
> eliminated by the preprocessor.

Why not just do this incremental? Cleans up the ifdef mess too, leaving
only the one actually using rq_integrity_vec in place.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5f857cbc95c8..bd56416a7fa8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -821,10 +821,10 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	return ret;
 }
 
-#ifdef CONFIG_BLK_DEV_INTEGRITY
 static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
+#ifdef CONFIG_BLK_DEV_INTEGRITY
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct bio_vec bv = rq_integrity_vec(req);
 
@@ -832,9 +832,9 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 	if (dma_mapping_error(dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
+#endif
 	return BLK_STS_OK;
 }
-#endif
 
 static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 {
@@ -855,20 +855,16 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 			goto out_free_cmd;
 	}
 
-#ifdef CONFIG_BLK_DEV_INTEGRITY
-	if (blk_integrity_rq(req)) {
+	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) && blk_integrity_rq(req)) {
 		ret = nvme_map_metadata(dev, req, &iod->cmd);
 		if (ret)
 			goto out_unmap_data;
 	}
-#endif
 
 	nvme_start_request(req);
 	return BLK_STS_OK;
-#ifdef CONFIG_BLK_DEV_INTEGRITY
 out_unmap_data:
 	nvme_unmap_data(dev, req);
-#endif
 out_free_cmd:
 	nvme_cleanup_cmd(req);
 	return ret;

> Should I change rq_integrity_vec to this? Then, we could get rid of the 
> ifdefs and let the optimizer remove all calls to rq_integrity_vec.
> static inline struct bio_vec rq_integrity_vec(struct request *rq)
> {
> 	struct bio_vec bv = { };
> 	return bv;
> }

Only if that eliminates runtime checking for !INTEGRITY, which I don't
thin it will.


-- 
Jens Axboe


