Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF76C8303C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 00:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RwsGD4p276Gv5LW5rcDh7wHX2IDD80LU4H8lxJ+kEyM=; b=JYQQAmF+2CbP6B2olf+PZ6Qu8f
	PgiOX2bAvxegnGoShZwe00k3aSpi6WvleWJwIGVYT58hM7KwaNAwt2Sj+wleQNKJ1DJgsYeFUnFLk
	lF2hYQF5sJzk7NeYYDyyRgSzfFGPKg3XB7M9+8QJ9vO2VeBas01hvSZcgnJjYHojT2At8Cb/QR4VB
	Exf/ILKt4nAaJQTsDWHS42CPF1ayY8PD4qYEURlOaIVJI5DiYt+mKIfn7dG59c/LGjLzuG0cnUMFf
	W8HzJSQi+YrOtZ8QTMNYsiHhDuTcVQnJfMHTAbbofy8SGpEh2t8QDuryXLYikCjlcRNbJN7SgZKnC
	Jlxv2Omw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX7Or-00000009qFn-1kK8;
	Thu, 03 Jul 2025 00:02:01 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX7Op-00000009qFP-0XYG
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 00:02:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3D4D1A530BA;
	Thu,  3 Jul 2025 00:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28D2C4CEE7;
	Thu,  3 Jul 2025 00:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751500917;
	bh=2gFhDpWkVfMr3D/JXrWFs9vuiy+VIOgn7cNm5cwE534=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aQUTAErYmf2mdhGNxat/1G/cWZ8O9Rro4KLtNqA91Ps40Yn7x3yUzYZNyvXApAyTe
	 6mMfqNkSKXpi7uBd5QF72q3yfL02Qo5JHjXlTM1LR5usLxrOXbhYldW3zZKv9PnCAP
	 OTBmICoCai5Ve6Y7a6UKZOYGJQtvG+ml9WuYyhrn1bKKFIVvsONDLOmGSJVqfZF3tu
	 zuS3iPzuk0pt1kEjZyywYJgQWgysIVG4VnjLltMq4ChaTfOJHLZv+rCYHj2v4qUKAK
	 VmGOYTG8NbuafhA8jrpOmOBDiJoYkRoSM67f+lWXszZ4bBbcFVHFEcTkaNWFP1B5/3
	 tfSVhW+26e+Bw==
Message-ID: <63310a08-e01f-464d-9f46-54bb817f2121@kernel.org>
Date: Thu, 3 Jul 2025 08:59:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nvme: prevent ioq creation for discovery
 controllers
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
 <axboe@kernel.dk>, hch <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "cassel@kernel.org" <cassel@kernel.org>
References: <20250702005830.889217-1-kamaljit.singh1@wdc.com>
 <20250702005830.889217-4-kamaljit.singh1@wdc.com>
 <c168acff-66ff-4692-b21e-093c0aa592a1@kernel.org>
 <MN2PR04MB68626BDAC087B4CC8CC1A1A9BC40A@MN2PR04MB6862.namprd04.prod.outlook.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <MN2PR04MB68626BDAC087B4CC8CC1A1A9BC40A@MN2PR04MB6862.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_170159_237387_6B9F9B42 
X-CRM114-Status: GOOD (  13.64  )
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

On 7/3/25 3:09 AM, Kamaljit Singh wrote:
> Hi Damien,
>  
> On 7/1/25 19:18, Damien Le Moal wrote:
>>>   /*
>>> - * An admin controller has one admin queue, but no I/O queues.
>>> + * An admin or discovery controller has one admin queue, but no I/O queues.
>>>    * Override queue_count so it only creates an admin queue.
>>>    */
>>>   void nvme_override_prohibited_io_queues(struct nvme_ctrl *ctrl)
>>>   {
>>> -     if (nvme_admin_ctrl(ctrl))
>>> +     if (nvme_admin_ctrl(ctrl) || nvme_discovery_ctrl(ctrl))
>>>                ctrl->queue_count = 1;
>>>   }
>>>   EXPORT_SYMBOL_GPL(nvme_override_prohibited_io_queues);
>>
>> Repeating comment on patch 1. Can't we do this in nvme_init_subsystem() or may
>> be better, in nvme_set_queue_count() or nvme_init_ctrl_finish() ?
> nvme_set_queue_count() won’t even be called in this case, as its only used to
> configure IO queues, which are not being configured for an admin controller.
>  
> If we move nvme_override_prohibited_io_queues() up the stack into either of your
> suggested core.c functions, it will affect apple & fc drivers, which I don’t have any
> means of testing. Any suggestions?

Why would the controller vendor or its fabric matter ?
If the controller type is admin or discovery, you want queue_count set to 1. So
I do not think there is any problem.


-- 
Damien Le Moal
Western Digital Research

