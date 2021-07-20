Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F8EC07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 00:26:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F359A610D0
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 00:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F359A610D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jd+BfbDTalWXbnPhRZnnjkCv9/S5iep7sY0vtp0ifUc=; b=BdyikFTo5FxH7Qi31qYVSdnu1h
	UkCoP7Q+8K+kR+IV6RI0UoxNizHl39oUUADSAcavwJKTnB7JqwNPvQbHgWULBXr/6VnSkSmW6J8HS
	lfSd8B745F8BW7S0i+j/PZ5b9xc79hK2UvU5R6hZa+CeILs/tohz2gIno26AnoEelN3rwIkKbyp4n
	0Tjpn5l1O7ST7vt2KsDkrHDENx8KnPVqTSSiScjVGSdHr5I3n3JfnrNjDVbMZbwoOx/p23ALm1ndX
	xPzhkHTebyJ433mZMfMH4yGBlyJCSn+59n28Lzf6mNzmEFLHTYhif1PbUQOVJyI25WsRbBXyqrnfO
	jdCdByYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5dZp-00BXjV-8m; Tue, 20 Jul 2021 00:25:37 +0000
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5dZm-00BXjA-Jq
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 00:25:35 +0000
Received: by mail-pj1-f49.google.com with SMTP id
 d9-20020a17090ae289b0290172f971883bso904902pjz.1
 for <linux-nvme@lists.infradead.org>; Mon, 19 Jul 2021 17:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X6Bxq20yqPpabQK0xLppK1xD83QnoZKSuMOI1TDcoDE=;
 b=oUaX8uepiVK8RZl5miEoJ7SU/T/HTXA7zfc2gIE0ZlNicae7UtA9g6n4aQOGcfHqV2
 xbbTAGodnujDMl/Ig4W4Ovv1x9AFbKQPgp1r5C5nRVcTKZLcsWTwl5wQ9QZlyBENKgB6
 EFFzKTbxlfG5cLH2DXe3pg8bccHUQ4iKR1+anuzKKqcLrCV87UFeWowEiWreEjq8gQ9S
 N3d4XLLSoBKrUJEXZNuqyEt1drX2Km3Gf2W1vhDPhmzsRq2S0UOidGiws+gx8Kk2ssHF
 Y/f3hqewDqaHrqgZiWcgd9lWvScJT8phkIGH+rm96mFFRm2J7beFtbTRJPj4gmjdyDbE
 A1qQ==
X-Gm-Message-State: AOAM5308Tnn2WnyFSSTen1LKddW5nT6JplAX4i0xY0jNNjAe4NBbkSlF
 favepqp2o9u3SNZbxfKn/MQ=
X-Google-Smtp-Source: ABdhPJw9p9mHG8DKdnPHomTvGlNh2/v3ACJYLSOKVJk+TrG9OsTimiDdbIZxpwdHK1mSEUBu3tqJSA==
X-Received: by 2002:a17:902:e8ce:b029:12b:3d80:a028 with SMTP id
 v14-20020a170902e8ceb029012b3d80a028mr21333421plg.47.1626740733753; 
 Mon, 19 Jul 2021 17:25:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:eaf8:322c:314f:2eb7?
 ([2601:647:4802:9070:eaf8:322c:314f:2eb7])
 by smtp.gmail.com with ESMTPSA id n22sm20984264pfo.125.2021.07.19.17.25.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jul 2021 17:25:33 -0700 (PDT)
Subject: Re: [PATCH 1/1] nvme: introduce nvme_transport_sgl_desc structure
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org,
 james.smart@broadcom.com, oren@nvidia.com
References: <20210719095309.7777-1-mgurtovoy@nvidia.com>
 <20210719095703.GA1880@lst.de>
 <51a5f3c5-9360-f241-8fe4-6a5d53df99b2@grimberg.me>
 <08dab863-7c7a-c6ed-180d-f8ffcd3b962e@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6562b107-ffb3-722b-f7fc-fed04e1d6198@grimberg.me>
Date: Mon, 19 Jul 2021 17:25:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <08dab863-7c7a-c6ed-180d-f8ffcd3b962e@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_172534_708962_6786566C 
X-CRM114-Status: GOOD (  14.92  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> Currently the tcp and fc transports use nvme_sgl_desc structure to
>>>> describe transport data blocks. Replace it with a new structure that
>>>> describes the Transport SGL Data Block according to the NVMe
>>>> specification.
>>>
>>> What is the point?
>>
>> I think its ok to be more aligned to the spec, and have the transport
>> sgl represented in the code. Don't see any harm in that.
>>
>>> Note that we should probably still clear the reserved space anyway.
>>
>> Definitely we should clear it.
> 
> don't you think it's cleared already ?
> 
> if not, lets clear also other rsvd fields while we're here.
> 
> Each driver call nvme_setup_cmd before mapping the data and this 
> function clears the SQE (if (!(req->rq_flags & RQF_DONTPREP)))..

Yea, I guess its fine to rely on nvme_setup_cmd for it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
