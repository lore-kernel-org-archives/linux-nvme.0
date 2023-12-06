Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302FDC4167B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Dec 2023 15:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HbXWWctyqiPOqHmHbyqkaXrSpJqT5SrM2tPXrmIvafI=; b=UG3bxpv1C3PZUt6sF8zpCsj3hw
	ZM1lSOeIVVFWqySEuHmDMgiSSxQBYEHTuUrroR6S0/Byokp4oMq2BnyBSOUAZjzRfL7P0mzGWYbNP
	tb7z8Q5oLauPWimu3UjONFivrW+kJF4tbrAbhF7CyHx0XaY8kH7s1thPuaufoQlY6UxduFC+5hjHw
	w85QjGYxIyoK2hsygBiqIeuoJsDnlUkMAQMNi70PUqpJm1iC4qVC3yTTgT7ydJ9Q0XNBdvEJh/U4x
	/5vde2nbkf1FTE83V/5ZlR02ZOXKDw3VMUgKeBOHbl9joKpKblDQDcK3T1tPrUJICfFvPuzs5fLun
	DDtgk+PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAtsZ-00AdEe-1K;
	Wed, 06 Dec 2023 15:32:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAtsV-00AdDh-0Z
	for linux-nvme@lists.infradead.org;
	Wed, 06 Dec 2023 15:32:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 888EF61D55;
	Wed,  6 Dec 2023 15:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FA1C433C7;
	Wed,  6 Dec 2023 15:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701876718;
	bh=hAqLNmw1CUfJ61iCun+b5KBpjW9OiI64D5DKsIg/2B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GTmU6kHKUVBNZbTEGud+JA0mzs+8si27WjOy2KPVoJWYTiTW5RXUCHFEIQAHHJWDU
	 mHpbhVvMzsIpqDSzpqQtFtkUMzTi0vC779plDPuAH1lKgmZz2YjLPpgBlD5omS40K4
	 JzrDMkx0k5XlPQHgDoRuXUPPcDke/D6VK5oaeRo7kAjKf/CddpHGC4RzFR009LXE4j
	 TtQBOapJ4WWYkuAyGMSE2nAV35S2ABsD4qhxJXKiptIGjBsd2lGFQLiP/dfs1Z4WHO
	 UFTph6l6OdP14Clz5qFzU3DSWlqGMOXbU8aTDEgvEAGzneuXxMuVAaBB3iqj/1+yZf
	 dlflsS7oX59oQ==
Date: Wed, 6 Dec 2023 08:31:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jeff Moyer <jmoyer@redhat.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	asml.silence@gmail.com, linux-security-module@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
Message-ID: <ZXCT6mpt2Tq0k-Nw@kbusch-mbp>
References: <20231204175342.3418422-1-kbusch@meta.com>
 <x49zfypstdx.fsf@segfault.usersys.redhat.com>
 <ZW4hM0H6pjbCpIg9@kbusch-mbp>
 <ZW6jjiq9wXHm5d10@fedora>
 <ZW6nmR2ytIBApXE0@kbusch-mbp>
 <ZW60WPf/hmAUoxPv@fedora>
 <ZW9FhsBXdPlN6qrU@kbusch-mbp>
 <ZW/loVJu0+11+boh@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW/loVJu0+11+boh@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_073159_260222_87C31380 
X-CRM114-Status: GOOD (  20.82  )
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

On Wed, Dec 06, 2023 at 11:08:17AM +0800, Ming Lei wrote:
> On Tue, Dec 05, 2023 at 08:45:10AM -0700, Keith Busch wrote:
> > 
> > It's not necessarily about the read/write passthrough commands. It's for
> > commands we don't know about today. Do we want to revisit this problem
> > every time spec provides another operation? Are vendor unique solutions
> > not allowed to get high IOPs access?
> 
> Except for read/write, what other commands are performance sensitive?

It varies by command set, but this question is irrelevant. I'm not
interested in gatekeeping the fast path.
 
> > Secondly, some people have rediscovered you can abuse this interface to
> > corrupt kernel memory, so there are considerations to restricting this
> 
> Just wondering why ADMIN won't corrupt kernel memory, and only normal
> user can, looks it is kernel bug instead of permission related issue.

Admin can corrupt memory as easily as a normal user through this
interface. We just don't want such capabilities to be available to
regular users.

And it's a user bug: user told the kernel to map buffer of size X, but
the device transfers size Y into it. Kernel can't do anything about that
(other than remove the interface, but such an action will break many
existing users) because we fundamentally do not know the true transfer
size of a random command. Many NVMe commands don't explicitly encode
transfer lengths, so disagreement between host and device on implicit
lengths risk corruption. It's a protocol "feature".

> > to CAP_SYS_ADMIN anyway, so there's no cheap check available today if we
> > have to go that route.
> 
> If capable(CAP_SYS_ADMIN) is really slow, I am wondering why not
> optimize it in task_struct?

That's an interesting point to look into. I was hoping to not touch such
a common struct, but I'm open to all options.

