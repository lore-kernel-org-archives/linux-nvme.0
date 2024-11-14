Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737D4D6A226
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 18:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VXVbts4lXvoeKrC/LpKw9ZV7Am+rAqJw0bxQd44XtIQ=; b=20pHyJWWyJ7kJ57HyqGKxsAkTz
	VlgBZGjxkd2VJQ7YGmD7CrQt3Zuxt0n0OWeh5o7krADfn5oF2OGKRtzCp9+4vM3UOj4umWdYD7IUD
	ZPw/3aDI63AbtpMUBrgkkPFQDJC+sIRrX8rsNum0zJfMtrergFGkryxGWiITFeCMyEIUT5r/o95KB
	EsH23caT7stusBDEEfAgy0QhcfSmxJ+A03DVqORX+V1iDHScst39++5Wrq6unGtsAY5YEZy/HLnuG
	wFdorOOX5gDzCXq1tQfrLzYTZPf6EVON5S2CpAUi+lFbeoj9GfTw9/3+65O+KNvJ7kHbyfbZ4uvaA
	RiezBMGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBemq-00000000Vkm-2rkN;
	Thu, 14 Nov 2024 18:41:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBemp-00000000VkC-0mZK
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 18:41:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6F3105C53F0;
	Thu, 14 Nov 2024 18:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11997C4CECD;
	Thu, 14 Nov 2024 18:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731609706;
	bh=SIUiMf5isIrqlY+FZc0cBtFYH8rPHcIuoEJBpAOrI18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JiOrqj5NLT4/f1WuYm9J+r9+VGJVLjppAiGLHM1iHjz/Mr+sArF8vk0yQ9P5AOqPW
	 ulpwOdOFMfGeqUwK9KFO9nt/OWbDRILggCn6c4MA0pl5k0oUWPPxeqOGkK63qtcm/T
	 5Z5qzJ5nlGHSRY+iK4w8xPCegjG8Oa6+9VJD41hDv/afR3ft0CvJMiu+L1SaVBpLEn
	 id6Xxw5VqzEwjhjD7HnEJR/Es9+Z27NeW4V5u2tvKNmEplCZPlmuk1qovLvLLn8YWE
	 ootxG4HDePeZ3DWzZj8yfq69Yu8VodP1PUK6Gbu/A/orS1+a0kp3Qybv7roKGaI1wU
	 yhfYYUObW8HHA==
Date: Thu, 14 Nov 2024 11:41:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fix for Linux 6.12
Message-ID: <ZzZEZ2AJDl4U7vxl@kbusch-mbp>
References: <ZzY_Q785-p12Bl14@kbusch-mbp>
 <058d94f1-da1d-49d4-aeb9-10fda3069c99@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <058d94f1-da1d-49d4-aeb9-10fda3069c99@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_104147_276230_D340B005 
X-CRM114-Status: GOOD (  15.39  )
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

On Thu, Nov 14, 2024 at 11:28:15AM -0700, Jens Axboe wrote:
> On 11/14/24 11:19 AM, Keith Busch wrote:
> > Same fix as the last week's nvme fix, but for nvme-multipath. It should
> > have been included with our previous pull-request, but I did see the
> > message in my queue until too late.
> 
> Just to avoid yet another merge conflict, can we please just push this
> to 6.13 instead and just mark it stable? We probably should've done that
> with the other one as well, it's not like they are important fixes.

I was sending this now because I thought it would make it easier for
stable to pick up without having to back out unrelated 6.13 conflicts. I
just tried to merge upstream with this and block-6.13, and it actually
looks like there aren't any conflicts anywa, so it doesn't matter.

So yes, let's drop this and I'll send it with the next nvme-6.13 pull
request next week.

