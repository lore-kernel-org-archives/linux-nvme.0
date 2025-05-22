Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72F6C54E65
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 22:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PXNkyv1cMcFm62uPZ5bPnN71VaivhCYFVh8kFLjzrmc=; b=1EfNzwAlYOLN61BBHVrv5+gB3d
	P3zi+Kziwwcp5K84HgIiutZWQazMn0+264O1IeV/qtsgwqgsjEA4Sq9zewUkEyJ/7uZkq9z5xryp8
	i9LYsQRFL31d54GO2LIVJYatspevX3VoXU2KgjddWDg0NcQJpyI4U95AeLoH9hSjTNmn5v1vINWU1
	tyM9DMlXqcOU20ElMXK59fEWR/VEZ2krC6mjYUZEfrLU6rERSke/j5q17cYMGsM76MYg8MLwE/WW9
	gZ2wEEHgQmm0Lchxp2npUWjLw45/hQ0dzcwfQ1fFvooiWAc45tmh1JBG3Q/sfmKU4ZOuYdXTPp5iQ
	90nLRg8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIE5J-00000002GBt-3OJm;
	Thu, 22 May 2025 22:08:17 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIE4N-00000002G8w-1jK4
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 22:07:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 54485A4F232;
	Thu, 22 May 2025 22:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C423AC4CEEB;
	Thu, 22 May 2025 22:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747951638;
	bh=+LIhm/gUEdsndlQ1m4IaPMfjGt9PDcNg9W15gpdJY7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frfFZ9bJ7qpp2Dkp23MmFVgC2mnW6dBCTC9hRbZZLtrYML1yj3zxtbapa3JvtBcX6
	 KlBPkWAqum3YB2Xc04Mv5WVC0g4fdAkNUB0nrzdrka4GsqmzO3Fct5rhEreHoPmGJP
	 Wx3XSdOEfmBRwmdfchgnU09Vid012TsFm2dY9/5vbJtsuFbPDOjmxpeTkvyuqaBQfX
	 a2vpRYgxjYP6zJQ46LVaKES4w/Q+w6YSSsck9fDKyMkLaJbOM/cG2Zniw/c3jQUobh
	 hEvKN9apL7vqryEDk9qqS7Ab02tCJG2CPBCtWXNQj4IQF2WtJViJnKGaZwGMTPpT6w
	 3Wdro80gQh+ng==
Date: Thu, 22 May 2025 16:07:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Andrea Mencarelli <andrea3000@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: APST not working on Intel p1600x
Message-ID: <aC-gEw88-Wk0DT08@kbusch-mbp>
References: <0DCCBCB0-EBDE-402C-94BF-50A3CA6D58B7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0DCCBCB0-EBDE-402C-94BF-50A3CA6D58B7@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_150719_518734_58C0CCAF 
X-CRM114-Status: GOOD (  11.12  )
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

On Thu, May 22, 2025 at 11:20:10PM +0200, Andrea Mencarelli wrote:
> I´m reaching out for help regarding APST not working with an Intel p1600x 118GB drive.

Neat device you got there.
 
> get-feature:0x0c (Autonomous Power State Transition), Current value:0x00000001
>         Autonomous Power State Transition Enable (APSTE): Enabled
>         Auto PST Entries        .................
>         Entry[ 0]
>         .................
>         Idle Time Prior to Transition (ITPT): 0 ms
>         Idle Transition Power State   (ITPS): 0
>         .................
>         Entry[ 1]
>         .................
>         Idle Time Prior to Transition (ITPT): 0 ms
>         Idle Transition Power State   (ITPS): 0
>         .................
>         Entry[ 2]
>         .................
>         Idle Time Prior to Transition (ITPT): 0 ms
>         Idle Transition Power State   (ITPS): 0
> 
> As you can see, APST is enabled. If I understand correctly, this table should show idle times only for non-operative power state, is that correct? Or is this the first clue that something is wrong?

The driver does indeed skip operational power states from enabling the
APST feature; from nvme_configure_apst():

	if (!(ctrl->psd[state].flags & NVME_PS_FLAGS_NON_OP_STATE))
		continue;

As to why the driver does this, spec section 8.1.17.2 "Autonomous Power
State Transitions" has the answer:

	The power state to transition to shall be a non-operational
	power state

I'm not sure why the spec decided on that behavior. And it makes no
sense that a controller with only operational power states would even
advertise APST capabilities given that spec requirement.

