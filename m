Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5A9C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 19:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NRC1O6LjHoTRFcyJrr+TbaOvQh6OliquRDaYmBL6vQo=; b=K3cqsMi6TnEd3uEFZ6VX165XXB
	wuBr4V8ZkZjBWIXtM1r2HC9Ngy9/bzb7jX2fsAu3JBygx1Ado+JHY5FD22R4D68HDnpbnuCcDgWLt
	G0/OOFB1xJ5qc+IKWCVnQL0M1DA4paId6djpKwE1rlcFXIGofQppmF6uSWKMJUgDrRBS3it4Luri0
	btR9AC7DP5fM8OIy3d2VX5Eq1lIZLNXBFwJe5ASHDpxeGCwRE37ymLWPmt45SZ6LagUIOg66d9bCT
	9HO/JedmZiXVJPryWGO80PIqva+2yGAue8Gu56XSoVeaaZTdv4mzQese3/WXgHPz3hk7rL1TI8jvt
	bBhmgmcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEyfv-00DWkY-Uj; Tue, 01 Feb 2022 19:18:47 +0000
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEyfs-00DWjy-Sg
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 19:18:46 +0000
Received: by mail-pf1-f178.google.com with SMTP id e6so16744708pfc.7
 for <linux-nvme@lists.infradead.org>; Tue, 01 Feb 2022 11:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=NRC1O6LjHoTRFcyJrr+TbaOvQh6OliquRDaYmBL6vQo=;
 b=22s7OooaRYsCYVMWNg3YYKG8PSDRvDxIW9ttSHyHyCibkuyeW+zovxYp/TuzBP+N23
 BKGK6GlnLyjgEbuiKf+KiNKD8o5sTXiHfhceewsrWIH8b9TX7gTbzs9LDp38Eo4qdTHD
 DXEciybjGPtXozofIf/hx6A4YswG3yoRfLw2RQeIQhoMi7a+MK05CsAgiudsQ+ujOopp
 oSyORX+SgaJFMSq601lD9VEIrMDexN0U2rzfx6+ToHcZdkjdSAF7aQBstDILOkKM2kWe
 evWnfZ/v22/7Bxe3BhKcDiVR+fnwu9S+Y/ZJA10CbeIKG7Ct4cDXtVKiqKgBGPwoPTKL
 5+bw==
X-Gm-Message-State: AOAM532vk4yzoSRMoeXrbj9723027b82w2iJ4jLI6rnUG2Q5HnIIHATo
 TRHaYcqSvcyOLkuuZH0EBvYHm3Isxho=
X-Google-Smtp-Source: ABdhPJzdZuuT3zl/4KWMi39wXS4EFCvsDMKJDeuJ1g6HI0TEGyb2bJY3A35suFFqhBI5SCopxvLvag==
X-Received: by 2002:a63:9307:: with SMTP id b7mr22131054pge.616.1643743123461; 
 Tue, 01 Feb 2022 11:18:43 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id nv13sm4083647pjb.17.2022.02.01.11.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Feb 2022 11:18:42 -0800 (PST)
Message-ID: <efd2e976-4d2d-178e-890d-9bde1a89c47f@acm.org>
Date: Tue, 1 Feb 2022 11:18:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 1/3] block: add copy offload support
Content-Language: en-US
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011331570.22481@file01.intranet.prod.int.rdu2.redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <alpine.LRH.2.02.2202011331570.22481@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_111844_960709_9E5CB606 
X-CRM114-Status: GOOD (  13.54  )
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

On 2/1/22 10:32, Mikulas Patocka wrote:
>   /**
> + * blk_queue_max_copy_sectors - set maximum copy offload sectors for the queue
> + * @q:  the request queue for the device
> + * @size:  the maximum copy offload sectors
> + */
> +void blk_queue_max_copy_sectors(struct request_queue *q, unsigned int size)
> +{
> +	q->limits.max_copy_sectors = size;
> +}
> +EXPORT_SYMBOL_GPL(blk_queue_max_copy_sectors);

Please either change the unit of 'size' into bytes or change its type 
into sector_t.

> +extern int blkdev_issue_copy(struct block_device *bdev1, sector_t sector1,
> +		      struct block_device *bdev2, sector_t sector2,
> +		      sector_t nr_sects, sector_t *copied, gfp_t gfp_mask);
> +

Only supporting copying between contiguous LBA ranges seems restrictive 
to me. I expect garbage collection by filesystems for UFS devices to 
perform better if multiple LBA ranges are submitted as a single SCSI 
XCOPY command.

A general comment about the approach: encoding the LBA range information 
in a bio payload is not compatible with bio splitting. How can the dm 
driver implement copy offloading without the ability to split copy 
offload bio's?

> +int blkdev_issue_copy(struct block_device *bdev1, sector_t sector1,
> +		      struct block_device *bdev2, sector_t sector2,
> +		      sector_t nr_sects, sector_t *copied, gfp_t gfp_mask)
> +{
> +	struct page *token;
> +	sector_t m;
> +	int r = 0;
> +	struct completion comp;

Consider using DECLARE_COMPLETION_ONSTACK() instead of a separate 
declaration and init_completion() call.

Thanks,

Bart.

