Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9AAC433E4
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 22:35:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A783920702
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 22:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aDOgRD2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A783920702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BKBEe4xfl1V2O0crAKSA5T3XP9Q+TGFG8A0RH2dRmC0=; b=aDOgRD2CWajs8bod8EkoB9ScW
	b94xL9qaLKoywk4IJQwyn4VUNvkP3iuosnUWMAaXmjhSsIFSvbehz1CjOlDgj1yuRCPMXhm4CbwPT
	r9/nC57EVaEEXCu+gRQzy6e19Tv9FBYjJ6ru0eK4Eb4qpoQaZ5yQK5Hrd3tlByfPXCHw+7eHsBAJF
	J95Hld9u7aZtb23z0ipBoq6aES/2DkelvcrBWgh+5gaIrImF+6wqarVEGhI3g9JAkjFMVRAuny78d
	B5CvLJzh6b2s3N09HBeV+pn3uCBV49vlkUxro5kI8xOs7z5epj/2CFHTQ55T6eU3T66ENH6esNkY7
	pxvbqFbMQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxeNY-0004aA-81; Mon, 20 Jul 2020 22:35:24 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxeNV-0004ZH-GJ
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 22:35:22 +0000
Received: by mail-pf1-f195.google.com with SMTP id a14so9785402pfi.2
 for <linux-nvme@lists.infradead.org>; Mon, 20 Jul 2020 15:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qVsb3irT98yWXpJxhGCe+v3RWy+B0oryB1ExGX84sUM=;
 b=Ucmm5oV6d/oNY3aDenYlywYJvWLegEO+n7kkI+cYytDcNH/6RrcumeTbxjIRX7fpwQ
 EI8JNefe5gBOERhxuircABnjHgqlJHattQWi0auARc2NcOAoxzeMYntpj9X7DLTgpucZ
 b2H5iv3ESsQmnn5cPdxNItGTh3V2R3NGuy7IVzZNPqa9xXmdicsQYPalFTY/OiHhHqPJ
 OxCDlhVc9DLlc1sAtnXIAAVXoaF5jAkRCaxSmVI2ajxrkq8s5MtoOPpuAlPeqCYPOxQE
 fKh14AVWT+kRjY94lSH9kMlCv6z5B4fsu3xvsSKNfxGlmNoJ5JbYK5hZ+PzalvZ8XmC3
 bUnQ==
X-Gm-Message-State: AOAM532IdCtAMrRWjKMYaKu5Ujx8KdfqM5GYjh+70j2ykya7Lf2E+WJw
 nPrbhDHdTD2E22iCfe8kWTw=
X-Google-Smtp-Source: ABdhPJwLwOv2cDyLT2iUdhQRRdhgA++8oV1eJMBcYxZCfKoAYMj9H4ko3IsgMSax1T8I4JGHAJibWw==
X-Received: by 2002:a63:5d1:: with SMTP id 200mr20793955pgf.59.1595284520130; 
 Mon, 20 Jul 2020 15:35:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:81fd:84d6:3c38:f7ef?
 ([2601:647:4802:9070:81fd:84d6:3c38:f7ef])
 by smtp.gmail.com with ESMTPSA id o128sm18201897pfg.127.2020.07.20.15.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 15:35:19 -0700 (PDT)
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
To: Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com> <20200720141606.GF4627@lst.de>
 <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
 <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2dc39232-4042-1f93-3dcc-3266e70cf6f0@grimberg.me>
Date: Mon, 20 Jul 2020 15:35:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_183521_563728_A112B279 
X-CRM114-Status: GOOD (  22.43  )
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
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Thanks for the review Christoph. I think I should be able to make all
> the requested changes in the next week or two.
> 
> On 2020-07-20 1:35 p.m., Sagi Grimberg wrote:
>>
>>> I'm still not so happy about having to look up the namespace and still
>>> wonder if we should generalize the connect_q to a passthrough_q.  But
>>> I guess we can do that later and then reduce some of the exports here..
>>
>> That is a neat idea! should be easy to do (and we can then lose the host
>> xarray stuff). I don't mind having it on a later patch, but it should be
>> easy enough to do even before...
>>
> 
> I sort of follow this. I can try to work something up but it will
> probably take me a few iterations to get it to where you want it. So,
> roughly, we'd create a passthrough_q in core with the controller's IO
> tagset and then cleanup the fabrics hosts to use that instead of each
> independently creating their connect_q?
> 
> Though, I don't understand how this relates to the host xarray stuff
> that Sagi mentioned...

passthru commands are in essence REQ_OP_DRV_IN/REQ_OP_DRV_OUT, which
means that the driver shouldn't need the ns at all. So if you have a
dedicated request queue (mapped to the I/O tagset), you don't need the
ns->queue and we can lose the ns lookup altogether.

The only part is to check the effects, but that can probably be handled
when we setup the passthru controller or something...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
