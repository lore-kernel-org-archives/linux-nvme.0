Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43FDD68BDD
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Nov 2024 00:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6fEvnB/0DvA5J7aDwzFBOzgtc2nt3FFpkE1z+zopewE=; b=wUhSi6XFlccSPJHXlRLQd3fB44
	rE1Qmi4SmgszA5Cpb8MwCros/HoR7X+Y0ErdNS+206GVsHhxEoJ6c/6rxrjqQH/1mE6/2DeYXLYIr
	MamUBssKvFTsv8Unyuasnlkt+eu+HNwxx6ma1ZiM+YfDICyrF+ETRR5KLdBw65y/5FRWZ7NsnMOD/
	dQAheNxj1Gq2vxCygO8B/Xu3cPj33yetEEsHjo0fN85pp4tzFU/Hr0AFmNjUIgNBAc29C/CKadlhg
	khVWLsIzaWqbeLXlikuadxJ5fVj/IxPvL/KRlbzNXLEqpwz9DDqKHJcfBLucmGmNXSp3o8kac7BXQ
	HjKAGL0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tC772-00000004gXS-3O2T;
	Sat, 16 Nov 2024 00:56:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tC76z-00000004gWg-2YmD
	for linux-nvme@lists.infradead.org;
	Sat, 16 Nov 2024 00:56:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 236E15C51B4;
	Sat, 16 Nov 2024 00:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F985C4CECF;
	Sat, 16 Nov 2024 00:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731718587;
	bh=Xa+jsxKIIUiyRDcaHr5OHl3DkSRKwaUQOtVa7NR/iEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DzCsczpXSrtPGZvbfN3t3YT5SSe3HtJ67sPlwmNJdN83ww/NSfuv07IIwedHocbBj
	 AEfPf9ZfNZe/hAT65jA0UVkl/aOVPaVL0NH8ImHk3bFKfrMq4tEHNWcBB3JeqTSmQD
	 AFLbwJJBzW5v/G//+OzQPzFTW33crY/3Qa4Sf5NOAWs8zELzN8PP65lurohsHPzNLd
	 B9RjniqQ4f5B0S2GTa3bomy26m4lPYsmr8TrDYXgSCQpUg05UaQcaiNl+6dcj/ehR3
	 VB8EaQnf9/PkkW/WFv5lEWoYpf2w97po2vMQPSwry3XK+LNjPQBSgeUcFY43ZWa63q
	 fccGDH5EFOr9Q==
Date: Fri, 15 Nov 2024 17:56:24 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
Subject: Re: [PATCH 4/6] block: add a rq_list type
Message-ID: <20241116005624.GA1178909@thelio-3990X>
References: <20241113152050.157179-1-hch@lst.de>
 <20241113152050.157179-5-hch@lst.de>
 <20241114201103.GA2036469@thelio-3990X>
 <9f646b56-ebbf-4f2d-bceb-6ce1deb5d515@kernel.dk>
 <be0d06e4-a61a-47e3-8d50-f37f9b6fc719@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be0d06e4-a61a-47e3-8d50-f37f9b6fc719@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_165629_691461_C128CE64 
X-CRM114-Status: GOOD (  13.50  )
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

On Fri, Nov 15, 2024 at 12:38:46PM -0700, Jens Axboe wrote:
> On 11/15/24 5:49 AM, Jens Axboe wrote:
> > Fix looks fine, but I can't apply a patch that hasn't been signed off.
> > Please send one, or I'll just have to sort it out manually as we're
> > really close to this code shipping.
> 
> I fixed it up myself, it's too close to me sending out 6.13 changes
> to let it linger:
> 
> https://git.kernel.dk/cgit/linux/commit/?h=for-6.13/block&id=957860cbc1dc89f79f2acc193470224e350dfd03

Thanks, I was going to send a patch amidst my travels today but by the
time I got to it, I saw you had already tackled it on your branch.

Cheers,
Nathan

