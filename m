Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE895C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 08:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C7jNttpSfzkkO/zkDoejnzHTBlkR4Y9ZyTl0ptZhHQs=; b=21bBhMCwVQp3NI9aPd0kYI1KQK
	yb2R8GXyvlRllSyoc5bH208kR2iYPH9DE02BfC31uS6rlj+Vk0x04z2mmDvAFDp0WBy81XWtgrVkA
	HkPeUbNr14FgSaCQZh9VCF3kVdi9RQG9+10QrvlkjpvAysWEeZx3r4mEPe9Au1JMiJxPEAyXq2rAT
	AXoj1ac4YP61866o1frOIF3K4XTBNAASuIEH/V7dOMYgaS7VJYPqMFHgF/aKGJZqe4Wd4459nhjZF
	nwNaAkdNoFTALbAmBSlBckJDaUfPugDDAoGgYRy9JnKTIiMBzu9DVa8rgDb8LHhtrvKeSQ4CJhUOH
	ZOfF6adg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0IRq-00EWxc-2o; Wed, 30 Nov 2022 08:28:06 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0IRm-00EWuc-Rx
	for linux-nvme@lists.infradead.org; Wed, 30 Nov 2022 08:28:04 +0000
Received: by mail-wm1-f46.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so830590wms.0
        for <linux-nvme@lists.infradead.org>; Wed, 30 Nov 2022 00:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7jNttpSfzkkO/zkDoejnzHTBlkR4Y9ZyTl0ptZhHQs=;
        b=gKrPQo3r2hrMeeWSGhmxuiupT6VJ1OhrVRSXgHYVwKUci62zAMOvljG+AjwyeY/EZB
         W64fOJJ0MD99tPOx9tl6IjY3E0/EFPSNuyzruB1azUi8zsT7hnVxsbAYgs8yw5Pm6UxL
         WKTf1VPuN+P3Ib/gxpQ61NxCkJt585Q1UCgIYm5zr8kaKCzdyBSV0rgJj77wYnqylY4e
         ASc7g5X+KZv0JI/bNt2i6FbuwWGJAHld4N3IDAthKA7TGp65f8DBMnTQEHX0k67HcF7f
         GhM9bdb1IoTM87+9DMpyIvBtLKWR6aDuBxnFu30gUmQQ59qKpUypFknOq+GMnHgEL+bO
         pEXA==
X-Gm-Message-State: ANoB5pnXW2AzUh4MF830R9TQoObksBHqhwb+ti/Z8rczDDY5zUpRILtR
	mBOsAxtnrvrlBa0vnx+BCbY=
X-Google-Smtp-Source: AA0mqf7trKy3nT7Q7O/aslDeI99rhqscy1946a0pRQvj4NEfV+bLNdxDyfDYK5p6BJALKm1eCPq48w==
X-Received: by 2002:a05:600c:3110:b0:3cf:b07a:cd56 with SMTP id g16-20020a05600c311000b003cfb07acd56mr45620372wmo.143.1669796880932;
        Wed, 30 Nov 2022 00:28:00 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 10-20020a1c020a000000b003cfa26c410asm4797239wmc.20.2022.11.30.00.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 00:28:00 -0800 (PST)
Message-ID: <fcbbf3ac-97a3-f14a-2b8e-4367715b8b1a@grimberg.me>
Date: Wed, 30 Nov 2022 10:27:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme: don't call blk_mq_{,un}quiesce_tagset when
 ctrl->tagset is NULL
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, lengchao@huawei.com, linux-nvme@lists.infradead.org,
 Gerd Bayer <gbayer@linux.ibm.com>
References: <20221116072711.1903536-1-hch@lst.de>
 <e5de54b2-4906-9902-c150-732718a77571@grimberg.me>
 <20221116132225.GA8071@lst.de>
 <1ee364d8-4aef-acf6-1cf9-38787ddac288@grimberg.me>
 <20221116132805.GA8496@lst.de>
 <2b6bae87-b008-6f8d-3c70-2334b5bd48b7@grimberg.me>
 <20221122123154.GA5610@lst.de> <20221129090457.GA27310@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221129090457.GA27310@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_002802_956756_82C32CA0 
X-CRM114-Status: GOOD (  12.30  )
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


>> This would be the queue_count version.  I have to say I much prefer
>> the tagset check, as it is self-documenting and matches what
>> nvme_queue_scan, nvme_cancel_tagset and nvme_cancel_admin_tagset
>> do.
> 
> So no comments so far.  Unless I hear more feedback I'd prefer to
> go with the ->tagset checks that matches what the other code is
> doing and also is more readable.

OK, I'm not opposed to that anymore. We can take care of this
area on a different occasion.

