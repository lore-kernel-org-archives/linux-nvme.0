Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDA5F36B91
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2026 06:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SP14yjqM3G1o9lLcvgSzra2xXV+TFnFEx5nS87UOZ/U=; b=Kzaljw0iLna7r411MMpwROWFs+
	QIuFIGhoFDCZRwvmdMvjy1dO9adarFPMWoEZ6PVshUAwqznMsV8bLGSKbpMmr5601hJv0Id3MVEVS
	EkIQwXRI4uEXTIO9fSAwM0YWGFfxK8SnNtrYG4TX8WQfRTu2G6+7cIpQ0JL/2hnuCDVR23JwvIFKi
	Kgk2+04IHe/pXpf6ojMQS6T2lWgla3utxC8PwuKdY7fy/iGE7/LdF5MlYCVPqhGxdWotNRSo6S51r
	qnP095gS8AYuuY6vstBm2aJtXZ57tnfHgRzmnNVDWHu1X6MgAxCj5islShzGDmTY9tfu0hx/ApA0h
	vkVOhfKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB5Ev-0000000BfkJ-1J8f;
	Fri, 10 Apr 2026 06:21:13 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB5Eq-0000000Bfk3-0ZYw
	for linux-nvme@lists.infradead.org;
	Fri, 10 Apr 2026 06:21:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 27DB060125;
	Fri, 10 Apr 2026 06:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50894C19421;
	Fri, 10 Apr 2026 06:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775802066;
	bh=F6j3wwEl/bPkCawkmBKeBxS4pT/N3iFnYY5Ag3UnvH4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=vP35bOCURpBPC8EnceSmJKCY4UNuuB4RGH4DFKl1iBnFtBXT4Ntb41Korbq38Q1lS
	 a4gNbIIt8h6SVQWFB9piGRxC0PvCPJHEEyqA6e4aEDmMK/DIjlW4UXXe9Yo3adIVBO
	 9oLIZ1NIVe8LUv5xBurlOtgQ9cja9UR5ZoeNEW1EJvOdoYEaF/taaaOty0FW/6JnaI
	 5trr7J1MHh+J8J8TqDWPYoSWn/j7x/fUuRRNulqU2XVUFQpH2vnjqL1MxPwSFPNEzW
	 S2EoaMXBFnEsgRPJV7bkiNi+XH/iFpPLE5HLztAP31QFDO1KaX8c9JrzWOHlBFXLJb
	 kR7ftnDa5SZrw==
Message-ID: <f4a46cfdb0c15c9d2167577ccbbaec28216e2803.camel@kernel.org>
Subject: Re: [PATCH] nvme: add missing MODULE_ALIAS for fabrics transports
From: Geliang Tang <geliang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Justin Tee <justin.tee@broadcom.com>, Naresh Gottumukkala	
 <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, Keith
 Busch	 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg	
 <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Geliang Tang	
 <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org
Date: Fri, 10 Apr 2026 14:20:55 +0800
In-Reply-To: <20260408061028.GA24559@lst.de>
References: <e3076c80ee2e0c4a2cae0374afb617a3365946ea.1774944415.git.tanggeliang@kylinos.cn>
	 <20260408061028.GA24559@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Christoph,

On Wed, 2026-04-08 at 08:10 +0200, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> > Recently, I've been working on adding MPTCP support for NVMe over
> > TCP, so
> > I added a new transport called "nvme-mptcp". The AI review in [1]
> > reminded
> > me that I should add MODULE_ALIAS("nvme-mptcp"). Then I checked the
> > other
> > transports and found that they were all missing the MODULE_ALIAS as
> > well.
> > I felt it was necessary to add them, so I sent this patch.
> 
> As a reminder:  if you want that to go anywhere you need to engage
> with
> the nvme technical working group, which requires a nvme membership
> first.  There will be no point in posting or even discussing this on
> Linux mailing lists if it isn't approved by nvme.
> 

Thank you for the reminder - that was extremely helpful. I've been
struggling to figure out how to get nvme mptcp support upstream.

I left SUSE two years ago, and my current employer does not have a nvme
membership. I will work internally to push the company to apply for
one, and then try to join the nvme technical working group to move this
forward.

By the way, I will be presenting a topic on nvme mptcp [1] at next
month's LSF/MM/BPF 2026 conference. If anyone has any thoughts or
feedback on this topic, please feel free to share them with me.

Thank you very much.
-Geliang

[1]
https://lore.kernel.org/linux-nvme/a9f115aa5719e1088702a3fdeee766a3166611b1.camel@kernel.org/

