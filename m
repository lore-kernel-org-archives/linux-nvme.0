Return-Path: <SRS0=2FDT=7Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F032C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 19:19:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D40206A4
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 19:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fEMYU3J3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Y1cJBAK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D40206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4zDp3wtGqUrFJ4MslK1qyS4oU/yqHBnUqdIH+iZZN1w=; b=fEMYU3J3f3tpsI
	+BlcHitv1GdlUt3yRhPoROQ/jFzgDX+6CkoHVhZQsmXQqANQolnYtBI46kKA1DejTPI6R82nDgkdl
	xczxE/IcTC8losqHRjvGEoeFKm/a6vAFKG3Y5nEgO7/ddSDUSXovUO1ErkJvitBjGCEfsvdnoqfc1
	ReM5cEoljb6PtLiva0P+fGJYAZkmy2Y+OONauslzrvRte60g/QCCCqDYDzb9kyeOhQjVXpzIHzGnZ
	Gtmxbk00RXFUIMLp6SFf9Schvq9bk05TPFTj46TUmIA34rn98V5tmMyOH/NSXblKHbCAQOvPet9kP
	WwrCLFxAH6BbysGLm/kQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jjSji-0006rc-KD; Thu, 11 Jun 2020 19:19:38 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjSjf-0006rA-Sc
 for linux-nvme@lists.infradead.org; Thu, 11 Jun 2020 19:19:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Iul3mhrear09phmCu8JOZ2yhnz8/T9YMeSEnL8Miao0=; b=Y1cJBAK8vNbryfPIus+U/Dma8B
 i9banNR5DsvyXjk4Tsu/Pdq2z1YMAZRkMwetYqGGCELrWYoUbzaurNF4w2d6qpznr/8sbiZjCZNUv
 S28/T6ox5aly2VhOIDJuARkPfJZMx6RxbyjwuFGLQwV/wAOFDo8rWC+JPzfnwT3wD4ZvQKQXia7fb
 jZn2LBT+g9zg28zvTzs5/kF+WNn6DazAyCLruKhMp14UK2xCMPFPzL02MbywHPyWkSblTtH4ffFSW
 w4PHDUQG+ZZO1TbwkzKyS+2kpivcHW2f2U7kXrM65CQhtJKG2gKUWF3K5GtqXY9Puab32WEnRZkUK
 o4AsM/dw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1jjSjV-0004uU-IV; Thu, 11 Jun 2020 13:19:26 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20200514172253.6445-1-logang@deltatee.com>
 <BYAPR04MB4965CEDB8E3AE4B7F4C527AF86800@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <973eb071-45ad-26f1-17d0-325d637a9750@deltatee.com>
Date: Thu, 11 Jun 2020 13:19:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965CEDB8E3AE4B7F4C527AF86800@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, axboe@fb.com,
 kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v13 0/9] nvmet: add target passthru commands support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200611_121935_971012_7F0EB7D4 
X-CRM114-Status: GOOD (  14.77  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-06-11 1:16 p.m., Chaitanya Kulkarni wrote:
> On 5/14/20 10:23 AM, Logan Gunthorpe wrote:
>> This is v13 of the passthru patchset which is mostly a resend of v12
>> with Sagi's reviewed-by tags collected.
>>
>> Below, I'll reiterrate some points I made previously that haven't been
>> responded to:
>>
>> I don't think cloning the ctrl_id or the subsysnqn is a good idea.
>> I sent an email trying to explain why here[1] but there was no response.
>> In short, I think cloning the ctrl_id will break multipathing over
>> fabrics and copying the subsysnqn only has the effect of breaking
>> loopback; the user can always copy the underlying subsysnqn if it
>> makes sense for their overall system.
>>
>> I maintain overriding the CMIC bit in the ctrl id is necessary to
>> allow multipath over fabrics even if the underlying device did
>> not support multipath.
>>
>> I also think the black list for admin commands is appropriate, and I
>> added it based on Sagi's feedback[2]. There are plenty of commands that
>> may be dangerous like firmware update and format NVM commands, and NS
>> attach commands won't work out of the box because we don't copy the
>> ctrl_id. It seems like there's more commands to be careful of than ones
>> that are that are obviously acceptable. So, I think the prudent course
>> is blacklisting by default until someone has a usecase and can show
>> the command is safe seems and makes sense. For our present use cases,
>> the identify, log page and vendor specific commands are all that we
>> care about.
>>
>> A git branch is available here and is based on v5.7-rc5:
>>
>> https://github.com/sbates130272/linux-p2pmem  nvmet_passthru_v13
>>
>> [1]https://lore.kernel.org/linux-block/247eca47-c3bc-6452-fb19-f7aa27b05a60@deltatee.com/
>> [2]https://lore.kernel.org/linux-block/e4430207-7def-8776-0289-0d58689dc0cd@grimberg.me/
>>
>> --
>>
>> v13 Changes:
>>    1. Rebased onto v5.7-rc5
>>    2. Collected Sagi's Reviewed-by tags
> 
> Are you planning to send V14 based on nvme-5.9 branch ?
> 

I don't have any plans to yet, but I certainly can. I usually wait until
after the merge window to resend. I can certainly look at rebasing onto
nvme-5.9 for next time.

Logan

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
