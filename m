Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46BEC433E5
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 19:35:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 967B0207DF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 19:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ExO/DYDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967B0207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5cjF12APqPjHib7nSc5HvSnGiVumi4tXXQW1gbBH5wI=; b=ExO/DYDJt/cZdkTTYxVKlPJui
	SeDH5zQMCv1xSR7p5J8bvKUVvcnEK8OsIkQrIFCOoPvKkZkfIMdtuhE09C8h1Y8lbTsLT/Hi7aSGL
	k1WyxlJXtJhaQcTYjd3FhaMWHOjaYw6TKnWgq+OvhKrgqxKz+zn2lAHms4YtgbKEzxYajJuIasCtA
	/rZJFoM5pNB/E52jDBbSO1LHX44KOlQ++KqAApYfItsivZMgF9cUAYiYNJkFy9UoCmNpiBjVgwKWB
	PFyuYdRYQJOmYLzixKtOjIASJf+cFrHskGTRuNYNI0VEI9nsmy+hOkb85FkcMExD4/yjpcfoSbhl+
	LbnIKy9QA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxbZI-0000sU-RH; Mon, 20 Jul 2020 19:35:20 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxbZG-0000rn-Dt
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 19:35:19 +0000
Received: by mail-pj1-f67.google.com with SMTP id k1so336298pjt.5
 for <linux-nvme@lists.infradead.org>; Mon, 20 Jul 2020 12:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FAwXDOVMSGZi/I7ZWIkACyNz/hh5wQgkUbg94T7/lP0=;
 b=XZarWXRrAdyjIjWzAjfy6Oic2EZ1jqMb1SKh7GVzYlWi2KnsIdO+0mMKn9buHwpfes
 HdnrUzSzzRI22WaET8ceASJlY+oumJ6RkTg5ZTXCfCbw0UqFd5/PTXTehCbcg30/rwot
 xyY6Z/7eVIIrmCkhapKkKMlRd6ssK3anYIgBA4Mgp6gED+/wHKA52EPGzQ1rlne00l/p
 wEL/FK9sJpbIgmA+c5J5fNmcmiAcd2KAtPpsTQJvCpdzsvnnwR1JQxoZUQcSdrb8zwde
 fckR9Oc5VSKIgj3ffnklPm6fWkePMEHPjBPD103A5jDfusfd8Mh+QNiN7mqotcUysuaZ
 oPbQ==
X-Gm-Message-State: AOAM532RVSFCWkVnizdGFQT/CXuWJLoYZ1IdZO+hyf9uHEsCz1kuKO/g
 h1zC+bFWUrdCCJh4juDunHU=
X-Google-Smtp-Source: ABdhPJzdF+z//mhwQF07S3PExCuzsCXpZ0Kr+4nTeKZkNUDuKlHK2ZkqoHFZKnlhXhd+E6guqCWxDw==
X-Received: by 2002:a17:90b:283:: with SMTP id az3mr992221pjb.38.1595273714639; 
 Mon, 20 Jul 2020 12:35:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:81fd:84d6:3c38:f7ef?
 ([2601:647:4802:9070:81fd:84d6:3c38:f7ef])
 by smtp.gmail.com with ESMTPSA id n15sm388993pjf.12.2020.07.20.12.35.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 12:35:13 -0700 (PDT)
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
To: Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com> <20200720141606.GF4627@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
Date: Mon, 20 Jul 2020 12:35:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720141606.GF4627@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_153518_501647_D46D59DE 
X-CRM114-Status: GOOD (  18.04  )
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


>> Add passthru command handling capability for the NVMeOF target and
>> export passthru APIs which are used to integrate passthru
>> code with nvmet-core.
>>
>> The new file passthru.c handles passthru cmd parsing and execution.
>> In the passthru mode, we create a block layer request from the nvmet
>> request and map the data on to the block layer request.
>>
>> Admin commands and features are on a white list as there are a number
>> of each that don't make too much sense with passthrough. We use a
>> white list so that new commands can be considered before being blindly
>> passed through. In both cases, vendor specific commands are always
>> allowed.
>>
>> We also blacklist reservation IO commands as the underlying device
>> cannot differentiate between multiple hosts behind a fabric.
> 
> I'm still not so happy about having to look up the namespace and still
> wonder if we should generalize the connect_q to a passthrough_q.  But
> I guess we can do that later and then reduce some of the exports here..

That is a neat idea! should be easy to do (and we can then lose the host
xarray stuff). I don't mind having it on a later patch, but it should be
easy enough to do even before...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
