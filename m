Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4A6C43327
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 12:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OTB1A/EEfq3n6WQvgiifoOHUPAwpCie6I2ssPdTySVE=; b=MYI397NMODbcUMmIIXE3395iF/
	Q8qLDhTpKi/h8Db6qyeHoRJXmDxa8SQ2Rwz5W1aBUa64qIs4bCLeg+JnI9w4jeE1Gt4VDK9NdrhC/
	1NiN2SQhPZwYLmYfBa2hOKBId1Wf4qYOTBIRYDW9wxmCCJev8efAS250mRVo8LigO6YXquFLet0He
	BskI79h7cT7eix92Go5w/Ioc3df4V4aonBhcW9O8kvPdxdYmcFcxqURPV0yRdtFrW9qU0pTMsQxHB
	CB0EygQl4NZnFTZj18Ney9+BI9NGAb2CN87WhfBHMIspL8ZidxhnCZhr4FoV3AlSZDstUivPXwY06
	uBxpc4cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfGko-00000004SUc-2PVS;
	Thu, 02 Jul 2026 12:42:54 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfGkl-00000004STO-0V16
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 12:42:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782996168; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OTB1A/EEfq3n6WQvgiifoOHUPAwpCie6I2ssPdTySVE=;
	b=NsTgasIaPhw7xUDJpGnjtVQGHfnXWfw9/uH61NLBWTUK5pbJATDM63V99/Yc+aCW0WglkwuACAGAWk/9dhZIr9NQ141aAfeKoJelkJNjzbE7wlxAzbVV3SFhvr6Os79TuuFdZVTvT1m9jKNGvPeUBjEMR43FqQa94sk/2ejV1Ro=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X6EmiYR_1782996167;
Received: from 30.221.145.62(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0X6EmiYR_1782996167 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Jul 2026 20:42:48 +0800
Message-ID: <941afcdb-ee39-4649-901d-3c7a0d15b0f3@linux.alibaba.com>
Date: Thu, 2 Jul 2026 20:42:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] nvmet-tcp: fix race between ICReq handling and
 queue teardown
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, gregkh@linuxfoundation.org,
 skumar47@syr.edu, kumar.shivam43666@gmail.com, kbusch@kernel.org,
 dust.li@linux.alibaba.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260701134933.66838-1-lulie@linux.alibaba.com>
 <stable-reply-nvmet-tcp-icreq-20260701193800@kernel.org>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <stable-reply-nvmet-tcp-icreq-20260701193800@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_054252_281683_18447A34 
X-CRM114-Status: UNSURE (   5.65  )
X-CRM114-Notice: Please train this message.
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



On 7/2/26 8:38 AM, Sasha Levin wrote:

> 
> Would you be able to send backports for 6.1.y/5.15.y/5.10.y as well?
> Your 6.6 adaptation looks like it should carry over with minimal
> context changes.
> 

The 6.6 version can be applied cleanly for 6.1.y/5.15.y/5.10.y. And I 
just sent out those 3 patches :)

Thanks.

-- 
Philo


