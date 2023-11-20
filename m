Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C0EC197A0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mWquuOcVx7Yb+A2ZASDM/DDlit/7w3EhDL8RNPzICX8=; b=DYPNkrJfDZsDJxPwRkY1ILugJ3
	YQ4GvbvEJNEnLE9E3hK4PGl77Zf72l8hb5FUoPQ+4Tb2+R7rjqiodeh2u2FCzpTFGnKNL7J+apwoz
	DzEjhuq+ut6SWoGfyx2mdXxHLcU60PiCgpedPzp/Wz8GpwF4MA41cP7oq9xVB0nnMfHJPvpj1G8mB
	Xmk5QIGkpsVj6xSKcp8CGRjQnmzWQlvYksswfqJmFd66+51Dl0xkAThc1itn5Os1T4mt1fGmHXqVd
	jrOXFVHXVHhV882OUEHPVkAeEH33h8Zx+YdT0yms07re6CY7BCVUOdANdEz017jdZW7bEF8J2ycPd
	wTWgQsKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5829-00DmlU-0a;
	Mon, 20 Nov 2023 17:26:05 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5826-00Dmhs-06
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 17:26:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 81A026135C;
	Mon, 20 Nov 2023 17:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3FFC433C7;
	Mon, 20 Nov 2023 17:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700501159;
	bh=eRekRoXX1EaktI62aW72qagDFWfqpZth5CSWYD29CHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYO8DAyLEyjM1onSrAuz7eMYcblKEdp6M/VxoIkt8GqfK1MyOcr5+hU9lEoJglqo0
	 2X/NRaQWS+jfDFmEnN/+rSHEGp32d3njvlf9GH/89KKKO6a2fAJ3UnWEqSrnXmyAbj
	 /TWnWWF10A9hoBum9vMUIPULP7M0Zc1Evcy7Rj2hyXD5BbvfzMrbELyfPMKnxRKAsJ
	 9nGKnWpszehZiQWNvZSlYtQy7To+yQFIIEUJkFte8si+uSUOm1FuL2hP88G8eHo1vF
	 AZfBE/YhVHJmGK+/qcBOJB/upB7OWjkTx8/8tIeHrCHIUotJwjTtsyCfS1NY5O+r3b
	 kCO3Bakhj1LqA==
Date: Mon, 20 Nov 2023 10:25:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Maurizio Lombardi <mlombard@redhat.com>
Subject: Re: [PATCHv3] nvmet-tcp: always initialize tls_handshake_tmo_work
Message-ID: <ZVuWpEwQks0HuUg1@kbusch-mbp.dhcp.thefacebook.com>
References: <20231020050606.9464-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020050606.9464-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_092602_130794_D20E2AC6 
X-CRM114-Status: UNSURE (   7.29  )
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

On Fri, Oct 20, 2023 at 07:06:06AM +0200, Hannes Reinecke wrote:
> The TLS handshake timeout work item should always be
> initialized to avoid a crash when cancelling the workqueue.
> 
> Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
> Suggested-by: Maurizio Lombardi <mlombard@redhat.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Applied for nvme-6.7, thanks!

