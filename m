Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17424C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Dec 2022 17:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y9KYzF4BhQqvtnv+0YNM4AnjYPUg53FLlvPZu0nHcyQ=; b=roU27ItLN6YyF2tZiS1PGNqAh0
	UZPGoaIe+BCQXXL3ky0JlMp7JIeMZevQRVX2p2yk9koPHc4dAS9ZOoTwokSrvveBlqJp5U+iHR8mi
	BNuwnMQcyG1qFp/HPbw1gOjF12jRFp9AuAFajlX8jYT3Ru/bA4NopG/iNhaJpTUKhwMuuTiz4G+kd
	Xfiq8qzfsqMe4ABZllYIqE2GjacbcSKhOTkOEVJTtQnMMSg5LPcQNen4TL8xU01CVsm6bAduUPfEJ
	fg4x9kI63CdVSw4u+4shXC1lDz3D+XBDjWri8zFYpcfAE5kg61oRUfq5i3Q14u0rNHH2EpTX2KbYu
	M7mD0qIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5s7l-00AaY2-7x; Thu, 15 Dec 2022 17:34:25 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5s7i-00AaVL-N5
	for linux-nvme@lists.infradead.org; Thu, 15 Dec 2022 17:34:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5827B61E63;
	Thu, 15 Dec 2022 17:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9D6C433D2;
	Thu, 15 Dec 2022 17:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671125660;
	bh=yw4uz2eLuZgGnF14wa6C87SbhDDrGqPmpYj/psOowDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gi5PKVHc8okRurg5DvbSv2gdmHDuQBs0fejFcdcYAnaBB5lG0GOd4fP4Vkghn2TEA
	 AnjkWquzIkvTLiPEEmq0v8FeW6Lvylo4ZpQN2Ve2d4TgcTf2VDen4UctVLPkJdPpsC
	 g0NBqSMtX+Go3vsHVWAHbs2t6bREoiChN7ozEVUTRLQvDH4ooKAimQlW+h9irRIluE
	 w8/Dembva4GnVjOJhDb/UyGHbJtPWvJAbrN6V/J7L3O9tSFDDVlO4wleIuZXoZhRJs
	 imWsz25G2r7Brh3U6ZEpPwi0dstStMdrto79l9N6NyYPvB5uUJiPRhEJ0ZQIw77MmR
	 lk8iViYeiK2Lw==
Date: Thu, 15 Dec 2022 10:34:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: "J. Hart" <jfhart085@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	axboe@fb.com, sagi@grimberg.me
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source
 drive corruption observed
Message-ID: <Y5tambspBYRHU5B4@kbusch-mbp.dhcp.thefacebook.com>
References: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com>
 <20221215082344.GB3816@lst.de>
 <d4c4eea9-e573-df0c-cca5-536bcff6c0a9@gmail.com>
 <20221215090941.GA5062@lst.de>
 <3c22a234-f042-4859-a3ab-f911874696b1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c22a234-f042-4859-a3ab-f911874696b1@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_093422_832466_224C1D97 
X-CRM114-Status: UNSURE (   8.77  )
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

On Thu, Dec 15, 2022 at 10:33:30PM +0900, J. Hart wrote:
> [ +26.890018] nvme nvme0: I/O 0 (Write) QID 1 timeout, aborting
> [Dec15 21:35] nvme nvme0: I/O 0 QID 1 timeout, reset controller
> [ +30.719998] nvme nvme0: I/O 13 QID 0 timeout, reset controller
> [Dec15 21:38] nvme nvme0: Device not ready; aborting reset, CSTS=0x1
> [  +0.014796] nvme nvme0: Abort status: 0x371
> [Dec15 21:40] nvme nvme0: Device not ready; aborting reset, CSTS=0x1
> [  +0.000024] nvme nvme0: Removing after probe failure status: -19
> [Dec15 21:42] nvme nvme0: Device not ready; aborting reset, CSTS=0x1
> [  +0.000324] nvme0n1: detected capacity change from 976773168 to 0

This looks like your device is completely unresponsive: no ack to IO
commands, admin commands, or reset sequences. Unfortunately these are
typically firmware bugs. Without additional guidance from the vendor,
we don't really have many options to try from the driver: just disabling
some optional power and performance capabilities, though that often
doesn't help either.

