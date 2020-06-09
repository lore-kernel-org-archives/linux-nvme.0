Return-Path: <SRS0=KBoe=7W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFD6C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2020 23:32:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E182E206C3
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2020 23:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZzKy3RG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E182E206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GIsJxfayDTIvE5x7dFH4tJHEeHx/MXZcidFOKKTvqX0=; b=ZzKy3RG81cDEv8IVUfjVIk3uS
	w5olOaM+9n5449HRgG2iFBK+aJGBhVJbXsCqAKA9c9YsrcA7tGpYsHtP+i1+2m0DfTbprWMFcHbhc
	f6UJ1QUhmbmyypr8x7S8lsv0O/dRyjS9IJEBUhkB2JwgkhoGYYHRovMcF6dceCF+pA4DeLH1bSV/T
	Wnhq7nVz0GgQMEFmmfBUm6uMIqOW5XIvV71CZ/okxtGAVe+ja8lJlnfBaplhcj4ISr2bxFgmH7McD
	WK36OfoZuJw4MKvG/lpTvDIqcUDcklArgRaktxiPGZx8ofYx1Q7RsdVtLkrATxLlQfkCTGxXsdHTI
	A9BfdpyLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jinjF-0001tM-Lw; Tue, 09 Jun 2020 23:32:25 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jinjD-0001t1-B5
 for linux-nvme@lists.infradead.org; Tue, 09 Jun 2020 23:32:24 +0000
Received: by mail-pj1-f67.google.com with SMTP id h95so69149pje.4
 for <linux-nvme@lists.infradead.org>; Tue, 09 Jun 2020 16:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IY3GGuvdWot1yxE5PxKFuvBuCFhXjfneiKlboDkV8cc=;
 b=OLXHL3ZkzkbFtT/5dBLZ9G4GSDP8NuZUCtvVHdrWOgUFRztAKrT/B3o5CRG//mdhac
 ve/Ayz8H89XILqBBezLUBBqBN6+hp15CQAm1rA/ddsFwRKlwqYT7o3mUGpqYrpbojGei
 G+Y+z7PQkJ+G6giWELSm39hTsPrq5rRcjVy2dr+x+l4lnG8bs6T8pJgXE0uBOa4Zjl4S
 kJ91IjJ0iCRLn6vbuKvwd6IAxjQyTnt7xqpRaqr9S6QctOs93d3+A3eIZTfV60HD9KaJ
 m1meX63CdqMfXQOzeXZp9QOzVqM2Q5LmJQpYhp0v64mkJIHFFKnTCZBrxOArNibZeDPw
 xzCw==
X-Gm-Message-State: AOAM531+WVbpihNAcJ7RSYwmQZ2Y5MZciKoffFO3V6lTMvGQJ6Tq8qCT
 YuBkVWDFCspp+0jJlXoHWN8=
X-Google-Smtp-Source: ABdhPJxq+4vJANDoA66Ja6K2Eo5AX+rEnTx/TMxDrAbBGx2LZs2nk31u7U5hI1FVXmQ6KuzZbL7pTw==
X-Received: by 2002:a17:90b:23c8:: with SMTP id
 md8mr216779pjb.72.1591745541936; 
 Tue, 09 Jun 2020 16:32:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8d09:1feb:aaa3:3f03?
 ([2601:647:4802:9070:8d09:1feb:aaa3:3f03])
 by smtp.gmail.com with ESMTPSA id w17sm11601762pff.27.2020.06.09.16.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 16:32:19 -0700 (PDT)
Subject: Re: [PATCH V2] nvmet: fail outstanding host posted AEN req
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20200609231942.47808-1-chaitanya.kulkarni@wdc.com>
 <183bd810-3904-5be5-3457-d63d5291c247@grimberg.me>
 <BYAPR04MB4965E53A28ACA2407DC878D986820@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e3530187-4d1b-6346-208c-aebc38395f82@grimberg.me>
Date: Tue, 9 Jun 2020 16:32:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965E53A28ACA2407DC878D986820@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200609_163223_379817_B2DE8683 
X-CRM114-Status: GOOD (  11.87  )
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
Cc: "hch@lst.de" <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> -	if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq)
>>> +	if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq) {
>>>     		nvmet_async_events_process(ctrl, status);
>> Why do we need this at all now?
> 
> The call to nvmet_async_events_process() is needed when we have
> ctrl->aen_list populated and we have ctrl->async_event_cmds[] posted
> by host.

But you don't use them? you just fail the commands without looking
into the AENs. We free any remainings on the aen_list when we free
the controller in nvmet_async_events_free.

  The next call nvmet_async_events_failall() will process
> not handled ctrl->async_event_cmds[] in nvmet_async_events_process().

I think we can just keep the failall variant...

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
