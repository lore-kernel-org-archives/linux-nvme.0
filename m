Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46327D3A66E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 15:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=axD7yliWMpqLv9QC5nK0vZ/kdx9HrO3eq13gzxX2ivM=; b=mGEv6x5p4eLD/dv91ENEfMmvS8
	rStQ11O7yK+uxjXUZ227VTkQKWfjJucHgu0gjq4PudETmfnwnr9XUxB6C9GxSJ/NN7bqMZeNEUJeo
	NicDUiRPe4eEHkkB9165xzejujcII+rNTPlEKos4xPX9t34y7sj1KrydKBpzMTrssuzHktCRWvRpj
	ZCak9UyYx6tG5HuNq9daysqdYPT7zFL1Ks1itQJaozV6DibIvrgquMjxVfh8y2JRyjwN+qyg6dSQq
	e+RvOp4bugTRPFCcpOfTdj4ldugqG/tNJc1v1aTlxlfH+A4ljFg4yxAwzgYJJwbZbEAedVjdAp/sj
	6YstYeiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5oXg-0000000F1Cv-2eeT;
	Tue, 29 Oct 2024 15:54:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5oIy-0000000ExBS-3sos
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 15:38:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1BF3F5C5D63;
	Tue, 29 Oct 2024 15:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1287DC4CECD;
	Tue, 29 Oct 2024 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730216327;
	bh=sXQtAmjaRkJY/tMHB3LMtb+TU/s2sXJm8psXkmJttmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nOFAkX4N8peSxGFTiKARoXGk8lIlrqPHSIHgtZvmxpCuHZQ7Wb/jrxA6nfyscj/nI
	 XF9iVuZh6jQxKRCIleVbMYQ5x2+tECaPwiaqLwl6tqHjkD37GALGQtuS0jXC8BJ5J1
	 6KKUWAy8SNR50r6VVVOjXWcBqBSW22594PWuQJYSTUrN9yyatlymsV7T8pmJMFzoyK
	 lpKc1RaOm78+UvO/8xf9yhgehdlGn0WbbpFBgHO+KSpnoSzMpOujXf1qDaSPBmZEfw
	 yatwrJZqfQurKzhw1M0l/ddZL0Xf9xs3YJw8pLegbrigBevP1F7/QkkpkZERt+9FrI
	 WsJuzYsYaUEGg==
Date: Tue, 29 Oct 2024 09:38:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <ZyEBhOoDHKJs4EEY@kbusch-mbp>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241029151922.459139-10-kbusch@meta.com>
 <20241029152654.GC26431@lst.de>
 <ZyEAb-zgvBlzZiaQ@kbusch-mbp>
 <20241029153702.GA27545@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029153702.GA27545@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_083849_030160_BA9972E0 
X-CRM114-Status: GOOD (  13.88  )
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

On Tue, Oct 29, 2024 at 04:37:02PM +0100, Christoph Hellwig wrote:
> On Tue, Oct 29, 2024 at 09:34:07AM -0600, Keith Busch wrote:
> > So then don't use it that way? I still don't know what change you're
> > expecting to happen with this feedback. What do you want the kernel to
> > do differently here?
> 
> Same as before:  don't expose them as write streams, because they
> aren't.  A big mess in this series going back to the versions before
> your involvement is that they somehow want to tie up the temperature
> hints with the stream separation, which just ends up very messy.

They're not exposed as write streams. Patch 7/9 sets the feature if it
is a placement id or not, and only nvme sets it, so scsi's attributes
are not claiming to be a write stream.

