Return-Path: <SRS0=MSYC=BA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7852FC433F8
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2020 00:39:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A14E208E4
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2020 00:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hpRgPXv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A14E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lVeWX3U74irUd89q+PFhr7CnbukhSv8vGTf5ZcK8aLA=; b=hpRgPXv6aeHK45lLG/UQMrPAr
	icWfLLqZ94BOu3Z6cGgfn0pIapYv8c4xVUKqhZWhCec4eu7Cq06Kz+zAfqaDIu3J5MUiU+ulxF+8S
	tc9ZjkqDaF9WJv4ecDIaV4RMVClCWr7I7uKSNDMAI9zj3V6d65ze4l3DbdMoAwMF/wA08XE9vdA/i
	GltXNQZqTETs49xU0GNf3YFEyBZoaiyzdVW1lIRXCW6NGO079Sg5J3WivmwKmkB0ItJ5p3Aljx/lb
	4b9wiAaMruB2atBwsi9s7nfBddciozir052mbcEJNFa4pvUucH0fk1LthnZ0AfivBfU2ZztzP88NH
	Zv7av9L4A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxgJR-00070Z-Tf; Tue, 21 Jul 2020 00:39:17 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxgJN-0006zU-Ui
 for linux-nvme@lists.infradead.org; Tue, 21 Jul 2020 00:39:15 +0000
Received: by mail-wr1-f65.google.com with SMTP id b6so19473404wrs.11
 for <linux-nvme@lists.infradead.org>; Mon, 20 Jul 2020 17:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WIattoPaCAsVucZKkhcZ7N2CYGctJaZRL7pAstTnc94=;
 b=qTH6FOo6LSC/cH9QWKPMUixncUGMn9iCfs1E6czquX7/11tdEzqYPR6feKFetDjR6V
 aZosIYzFIa3WMZ4xv1wiIYJqIiDMtCm1IrwN1D3bzas4m7AFb9nFiB+1Q4x1Rk6/RXg6
 u5irmU3CUwhvLvhDeXcSzjZKBKBvoEIQ0fhQdZZzuiURgEvhBcdzUjkYad18vlBz4mse
 1PzKkMdCHSDFwhYqNnOXbCHxD0V70dKnC+VjVtzibxfkH29HyIrroZ3gEOMfO+sb3yx7
 +1vf1U7ttwUmzH0l+wo0H6BwJD7fuSc79nBZ1OBYXGcOezxMAjd7os7SwC5nEew+C1hh
 a2xg==
X-Gm-Message-State: AOAM531LEPCtqbv3/wWbXACOcTI4q6mdRYJtqXueGTYkK/MbSGnNQWzL
 8ra0wSzfQhcaA0U7mhFsBgs=
X-Google-Smtp-Source: ABdhPJy0I9jvMNyeDN0EtZsqfs/0P32YscqEU5DPBKoUyiNHWyhY5aPNZvsv90AleasVLDiY7/+w0g==
X-Received: by 2002:a05:6000:1209:: with SMTP id
 e9mr10835605wrx.404.1595291950346; 
 Mon, 20 Jul 2020 17:39:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:81fd:84d6:3c38:f7ef?
 ([2601:647:4802:9070:81fd:84d6:3c38:f7ef])
 by smtp.gmail.com with ESMTPSA id 1sm1267910wmf.21.2020.07.20.17.39.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 17:39:09 -0700 (PDT)
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
To: Keith Busch <kbusch@kernel.org>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com> <20200720141606.GF4627@lst.de>
 <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
 <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
 <2dc39232-4042-1f93-3dcc-3266e70cf6f0@grimberg.me>
 <b8fc47a2-0b53-3316-775f-0e9a8eddfdc2@deltatee.com>
 <20200720231701.GA682160@dhcp-10-100-145-180.wdl.wdc.com>
 <d7596065-f33b-5533-7254-153b82e6b88b@grimberg.me>
 <20200721000630.GA682317@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <be06756a-bb05-ae83-3aea-6eb97d985160@grimberg.me>
Date: Mon, 20 Jul 2020 17:39:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721000630.GA682317@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_203913_997897_517385BC 
X-CRM114-Status: GOOD (  12.67  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Max Gurtovoy <maxg@mellanox.com>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> On Mon, Jul 20, 2020 at 05:01:19PM -0600, Logan Gunthorpe wrote:
>>>> On 2020-07-20 4:35 p.m., Sagi Grimberg wrote:
>>>>
>>>>> passthru commands are in essence REQ_OP_DRV_IN/REQ_OP_DRV_OUT, which
>>>>> means that the driver shouldn't need the ns at all. So if you have a
>>>>> dedicated request queue (mapped to the I/O tagset), you don't need the
>>>>> ns->queue and we can lose the ns lookup altogether.
>>>
>>> We still need a request_queue to dispatch the command. I guess you could
>>> make a generic one for the controller that isn't tied to a namespace,
>>> but we lose the fair shared tag allocation.
>>
>> What do you mean fair shared tag allocation?
> 
> See hctx_may_queue().

Still not following your point... this queue is yet another request
queue on the I/O tagset, e.g.

ctrl->passthru_q = blk_mq_init_queue(ctrl->tagset);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
