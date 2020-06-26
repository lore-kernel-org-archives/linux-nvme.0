Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555B8C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:29:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35F0207E8
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kaCfUDpD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="w0WxvLqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35F0207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7sW8nGclaTkjggMOvaLY+QB6xY8UKDxAfmc1hk+JT8s=; b=kaCfUDpDFw89pRAnikPz5Mq7U
	HovtBDMpHOU4CWMDUsCpkZe/H30yXrRSdAVAKYvKtE4M0rwBCNWd/hCoDUcjrrEFNsJ6++FSnC4GT
	6vsvbup8bffXOkhtUNaj0/tv/Wq6KRMQvU7v1MlwGUO6NE9feTZS0qKqlhQlw6kGbn+uGq9EKDSqh
	Yf34ejlmSrxt4KgpsZArTuN/NRb9lpr0AAazBO6WIszOVJY3FUL1z3FpwvWj/M9Svp6xMssKo7h/Z
	UPjjmyKVW11eumQvEtXzFxe/hP61iwCNfmjN8susZ7B3rLjkm0AiPkYmSDLrMVyKmgJ8AKZVQnb7/
	WJ676t7Jg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jonTG-0006bD-PA; Fri, 26 Jun 2020 12:28:42 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolAN-0007o7-A6
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:01:19 +0000
Received: by mail-ed1-x543.google.com with SMTP id cy7so6449327edb.5
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 03:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=qUl1b6ZKOKu+8M/8iIs9MV6jOq39RM7yd/5UXrQhPBg=;
 b=w0WxvLqZGuf7NzsEdBXumLQ4Dq0bASQTtoSlE2yk+jztzvPZukgMaGjduN8Kzm/cET
 xYYHn80gxOlrs+uIRaJhaRa6D6waGxvec1mpxEMnKyxbCswaggT0JGYQLLcEvSNUTAvo
 j8Vxr2Tkuv5yqCNFgDx4vWaj5FcVl0yVq5ZIEdgiGYPHSz8UinpTzGX4HvMulT0QbaRT
 NMWveSYkx35tdCw6eRZPtF/JZy0qciGwWTBgaAbmeE0s0vXT6fSSxcXJTnT1SXEhvLpX
 LhhdvX2W+utTQ9W8+K6s1oEIp0KxH8tVPcA53GuW+6Tq8WrJcZauPXpGtLtNTVRLAENY
 P2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qUl1b6ZKOKu+8M/8iIs9MV6jOq39RM7yd/5UXrQhPBg=;
 b=mf+/dXYmgd/Gbd7hEATkk5LbVZkAmQfVzzxvXdarYgDup/KfsVyGsGgi30mDX48RZN
 InI/MTcvHKuPLl2wjdvZ+11MNBhcdaS4VTqyqeX6wxqblSAVFRMdcuqxR6OBzXsfl0a8
 E4F701vRR2ghBO5EYFOtnzMUKDpkUzWtBiCntwSTK8/3P0NX+yuv57DKlXznUBteRXyt
 rNU62d/f7m7a3K3Z3XfvLvs4oNt8NtQzeZtMgVCGHt3XwDw28Se3rMCUrPzsFYBKBFdm
 YHh/hBxN1N/N5uDlYn12l4H0S/y19ewm0McmkDcluXleJaZAiIj1VAjB2KY/F38HlqqA
 KG5Q==
X-Gm-Message-State: AOAM530x0clU5TyTw61NUDCp4oRTEzTbMwmJ6b3bKxn7CJPtKSFZRpfN
 j8Ys/9/DZKfAl1FecgegYHZu7g==
X-Google-Smtp-Source: ABdhPJyX6ZGJUOZGR+giWfiEzv594FPvMsFiqAPf1gxFoZ4PsqFMv1gWz5Lx85XAqx/Mk5z895sgGQ==
X-Received: by 2002:aa7:c609:: with SMTP id h9mr2548655edq.43.1593165661688;
 Fri, 26 Jun 2020 03:01:01 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id w18sm1030748ejc.62.2020.06.26.03.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 03:01:01 -0700 (PDT)
Date: Fri, 26 Jun 2020 12:01:00 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/6] block: add zone attr. to zone mgmt IOCTL struct
Message-ID: <20200626100100.gxwdmww7h4kmfxsq@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-6-javier@javigon.com>
 <20200626091427.GC26616@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200626091427.GC26616@lst.de>
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
Cc: axboe@kernel.dk, SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org,
 Nitesh Shetty <nj.shetty@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 26.06.2020 11:14, Christoph Hellwig wrote:
>> + * Zone Attributes
>> + */
>> +enum blk_zone_attr {
>> +	BLK_ZONE_ATTR_ZFC	= 1 << 0,
>> +	BLK_ZONE_ATTR_FZR	= 1 << 1,
>> +	BLK_ZONE_ATTR_RZR	= 1 << 2,
>> +	BLK_ZONE_ATTR_ZDEV	= 1 << 7,
>> +};
>
>I have no ^$^$#$%#% idea what this is supposed to be.  If you add
>userspace ABIs you need to document them in detail.  Until I've seen
>that documentation I can't even comment if they make sense.

Understood. I'll add the ZAC/ZBC attributes and document this properly
on V2.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
