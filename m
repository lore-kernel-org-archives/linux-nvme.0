Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A537FC4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Dec 2022 18:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MiaU0h+bdhLcyz46u9rPXY7SBRUUk1LjjV2sWNv5RLY=; b=Bag09XrvP2idaa41DwlbayU+Tl
	0COi1BkJj0jESDhdNLJemHucOTDypn0R0POA4JeluI4tw5LXHBaIawvijJQF0rybhAxLS7NQr+JWt
	2f/O7ULVVGXXdbq3sS4nDxHzUJDjJ6SiD1B9or+4WJlVCYKTg9NJNkWTNbSb3t1hCBLKFOPUOHL0w
	qjj8bOf0Edc0qSBZa5E441Yi0w4ooXeZB1cZCc67dvJ1jsCK8IivyOQ2w4MtrjhFu1AW0yjWmx69y
	12fd6GTNUxO293MLlR129g4m0PHTT0lFgqA+n7UoNVWI/DPTwupzW2DzyEmLsrqtwjOCKefZJa/Lp
	8LbMwEsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2G8P-008Lvy-DO; Mon, 05 Dec 2022 18:24:09 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2G8L-008Luu-H9
	for linux-nvme@lists.infradead.org; Mon, 05 Dec 2022 18:24:07 +0000
Received: by mail-pg1-x529.google.com with SMTP id h193so11196514pgc.10
        for <linux-nvme@lists.infradead.org>; Mon, 05 Dec 2022 10:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MiaU0h+bdhLcyz46u9rPXY7SBRUUk1LjjV2sWNv5RLY=;
        b=UBAKgIuuOhTG3tpp18QArd1BLiZIqIsmrc+4/lD5AsoySzR1qItFUrsUCuFBWW+V7W
         NN2KIHP7x2TpFYLEpDAVnAYN+9qZ+/AX/nXjLFuLwIwASDZ5TCrrY6Icl9kLCXsJnFp2
         2nI8qClHrISNzrvTysGS6mWOe77CE/lEituW6eRdhOSEvyhqLcQtgnSDhdmtwzRZq3H3
         t9gh6367wtD+fMwzVdZQHcjkEtEIZUGmsUbF+1sZ059635xeS4MW7dzCg2dwPJ9UAzdV
         UHJpkdFPOBH9kWrxNGtG9EH15d6tA7E5U5gRClOLHJ2QLOn49p6zl6y4+YgaYg17wO/n
         Dyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiaU0h+bdhLcyz46u9rPXY7SBRUUk1LjjV2sWNv5RLY=;
        b=ll60aBkofpGxwEPFewRl9OcjYV+6JReKx1bad+cT4oLZG30YxPDeIiW4RcrMV67zdi
         42zlGOoApOcL/HFnYp4eEKvGv6wnkCpinl/+BzVuPtKcs2HlPAZIrk6wy3/O9HqdUw3V
         UZV0GYYGZrczX78aHa3oL7ziKmIlfgg0F8wavt0Si6lBYnA0mZkIA28h7f5azoyhOxBO
         /NJ7wx3Do2axNlDhbtocJ/J2DH4XdL5koek9DPHXj9jV3hjrT2A/Wx2dr6c6+iAddQh1
         qEsZ3NJoL9Vgb2iQYb8yqK4Fc0Iz8MhIz0TbU7y92YyBsnsrtWUxys3jgOIaxA7cUlA+
         LhZQ==
X-Gm-Message-State: ANoB5pnuaXEkXaJ2YIu2SY3ACzWRXPWuNIouM6LmyQC9OWP0Lb7YK65M
	mHnplVG5TP02iCWSQ+XB/wcLoQ==
X-Google-Smtp-Source: AA0mqf6jZL7CMm0mQFuDdI6JgmGYYwGjfVoJPowXsYQWIx6DQ5YO6ZYAjPvSltOjb7zYJtxe7LeLEA==
X-Received: by 2002:a05:6a00:2396:b0:56c:318a:f808 with SMTP id f22-20020a056a00239600b0056c318af808mr68347160pfc.11.1670264643685;
        Mon, 05 Dec 2022 10:24:03 -0800 (PST)
Received: from ?IPV6:2600:380:4a37:5fe7:dac6:a7fe:6a6b:c11a? ([2600:380:4a37:5fe7:dac6:a7fe:6a6b:c11a])
        by smtp.gmail.com with ESMTPSA id 72-20020a62154b000000b0056283e2bdbdsm4726356pfv.138.2022.12.05.10.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 10:24:03 -0800 (PST)
Message-ID: <fe2800f1-aaae-33e8-aaf0-83fd034162d5@kernel.dk>
Date: Mon, 5 Dec 2022 11:24:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Content-Language: en-US
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_102405_807374_E3A5B161 
X-CRM114-Status: GOOD (  15.56  )
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

On 12/5/22 9:20 AM, Alvaro Karsz wrote:
> Implement the VIRTIO_BLK_F_LIFETIME feature for VirtIO block devices.
> 
> This commit introduces a new ioctl command, VBLK_LIFETIME.
> 
> VBLK_LIFETIME ioctl asks for the block device to provide lifetime
> information by sending a VIRTIO_BLK_T_GET_LIFETIME command to the device.
> 
> lifetime information fields:
> 
> - pre_eol_info: specifies the percentage of reserved blocks that are
> 		consumed.
> 		optional values following virtio spec:
> 		*) 0 - undefined.
> 		*) 1 - normal, < 80% of reserved blocks are consumed.
> 		*) 2 - warning, 80% of reserved blocks are consumed.
> 		*) 3 - urgent, 90% of reserved blocks are consumed.
> 
> - device_lifetime_est_typ_a: this field refers to wear of SLC cells and
> 			     is provided in increments of 10used, and so
> 			     on, thru to 11 meaning estimated lifetime
> 			     exceeded. All values above 11 are reserved.
> 
> - device_lifetime_est_typ_b: this field refers to wear of MLC cells and is
> 			     provided with the same semantics as
> 			     device_lifetime_est_typ_a.
> 
> The data received from the device will be sent as is to the user.
> No data check/decode is done by virtblk.

Is this based on some spec? Because it looks pretty odd to me. There
can be a pretty wide range of two/three/etc level cells with wildly
different ranges of durability. And there's really not a lot of slc
for generic devices these days, if any.

-- 
Jens Axboe



