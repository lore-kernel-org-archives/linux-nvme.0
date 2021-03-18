Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BD0C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 18:44:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D08764E64
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 18:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D08764E64
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eJrX9fScTbHWrFaGNGFKO/6laU2T3DOfzOZTRdicRy4=; b=hGf6S7hMV0c2+/KnAAbg4Fhs5
	vAxGIaJb1DEzdN8+wfV4+QU5uR2Jg4aYfO+23GC+y3EmFKB/Z4c7XRWExsZpeiPOLMPW+Q36VpE8s
	7u7gMsJCIDte8KZCVvlPHUVRR9AXc9OCUrlUnCsxiXrpV4wGsHA1V1AguEZOoGv+VfGD0NE/z11/a
	zlfpzGhEswWTD2EsOAdiLGqx3BNdpWjPTkm+0UEsei6PHfYI412OGfFkOHtKB9wjEDouM4TAzXOTD
	5LTWz2+oYc0F1sB28GCtP1OBmX2cJ3aqlyi9NXYFVvmG7op/2kWJh7OCB/nrmrLbNl4pWpbgbkz34
	hqgGJrImg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMxd4-005s5b-Vx; Thu, 18 Mar 2021 18:44:19 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMxcz-005s4g-W3
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 18:44:16 +0000
Received: by mail-io1-xd33.google.com with SMTP id r193so3385094ior.9
 for <linux-nvme@lists.infradead.org>; Thu, 18 Mar 2021 11:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dcg1y//+DoAkTXSWSFL8u0Yi01QGJS6gRj6Nwc1cgM0=;
 b=XQq4hQ2GavpXdun8/b2ixrOFx72Uj8N6FzkAUpld3TlamNL/NCe51NW51nf3XK0EQ+
 XlCae3vEus8x4R09b5N9bLEfpcjTlQNlL2QdoIWDSElrOvJBm1B0x9xPlHjmXZVRoSxg
 t5fQvaef+Bw3tVOpXtMXmoTrYxD3Dm9GVPfh8sh1lCS9DokUrfsPTs88d8m8Rx94p07r
 XzN9C7XNNqoZINkJhHE50uolL8hMQfFWJ7BU4xX/CvseFVvCPF+uSZZ1vrHdJaJE3AA7
 +DBd087MLPOuBVQWkH3Et97XXwwHvnBrL+KmulR9axC7BIDb7x5UNNB1TrlMv4L+AXBu
 bPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dcg1y//+DoAkTXSWSFL8u0Yi01QGJS6gRj6Nwc1cgM0=;
 b=ZOoqF5kCgKeyxT4jaOUBwMzMSOM42vNvu8OgT3f0t9OW/hmP86MR95nDocdGLos/VT
 i9X6xunU9M5r9N3LuUol1+q7ki29wPTjNtQLblx3KG6y5KO1ePPFy4Ak81NmosXtcbwa
 IJNyaewN9/ozFRrNVUzR3pH4RwoDXlk3Tq49gh0+zCjHVmaaxogQ/KltAmAulpaQAFnR
 YtwwaNjWjlal2+yhwt/E3V6n1qKjG/1oxUAQyE4uy4XMo6i9Te/EsfGA490C3b0ILmNB
 wBwiFI8JBhnsfMT+T1gXHP7o0bbrc5nPF30QvGk+8fshZEtri9DUiOM2ZBzISLrIncgN
 /mKQ==
X-Gm-Message-State: AOAM5302cpUVlR5pO+DOieBdymdNS65l7Me/eFhMMOiqXebSFFuvIW0h
 Zp3o5r391Y+gXIx1jlCtGuJypQ==
X-Google-Smtp-Source: ABdhPJwJRyLj13ds04OCULiOrI0adobTqekGYabE96Pj6mEQ6XF1RKXSQgUlmGiYA2ymNnQkUeD7yA==
X-Received: by 2002:a6b:3bc7:: with SMTP id
 i190mr11572503ioa.163.1616093052890; 
 Thu, 18 Mar 2021 11:44:12 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id h6sm1366812ild.79.2021.03.18.11.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Mar 2021 11:44:12 -0700 (PDT)
Subject: Re: [PATCH 6/8] block: add example ioctl
To: Christoph Hellwig <hch@lst.de>
Cc: io-uring@vger.kernel.org, joshi.k@samsung.com, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, metze@samba.org
References: <20210317221027.366780-1-axboe@kernel.dk>
 <20210317221027.366780-7-axboe@kernel.dk> <20210318054506.GE28063@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <df428685-0729-8d7c-b079-97e9efd6ae15@kernel.dk>
Date: Thu, 18 Mar 2021 12:44:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210318054506.GE28063@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_184414_511275_2234A69C 
X-CRM114-Status: GOOD (  16.05  )
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

On 3/17/21 11:45 PM, Christoph Hellwig wrote:
> On Wed, Mar 17, 2021 at 04:10:25PM -0600, Jens Axboe wrote:
>> +static int blkdev_uring_ioctl(struct block_device *bdev,
>> +			      struct io_uring_cmd *cmd)
>> +{
>> +	struct block_uring_cmd *bcmd = (struct block_uring_cmd *) &cmd->pdu;
>> +
>> +	switch (bcmd->ioctl_cmd) {
>> +	case BLKBSZGET:
>> +		return block_size(bdev);
>> +	default:
>> +		return -ENOTTY;
>> +	}
>> +}
>> +
>>  static int blkdev_uring_cmd(struct io_uring_cmd *cmd,
>>  			    enum io_uring_cmd_flags flags)
>>  {
>>  	struct block_device *bdev = I_BDEV(cmd->file->f_mapping->host);
>>  
>> +	switch (cmd->op) {
>> +	case BLOCK_URING_OP_IOCTL:
>> +		return blkdev_uring_ioctl(bdev, cmd);
> 
> I don't think the two level dispatch here makes any sense.  Then again
> I don't think this code makes sense either except as an example..

That's all it is, an example. And, for me, just a quick way to test
that everything stacks and layers appropriately. But yes, once we have
something more concrete, this POC can be dropped and then re-introduced
when there's a real use case.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
