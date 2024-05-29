Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E084C25B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 06:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aIRNNezid8K3P+PkD9l/VwzqiXgvq0Dfrh6w2mXrdDI=; b=4CUycrEvP/ptCN7mAPuU44gl7f
	ugDlUwWyuSV3vyn7vBTTQBmbaiYMU2nrYL8St06YdS2o4pQzmMKu2KlRzNh86IUBFxAcxRwxLAk/R
	QycIgFRIDBjIIFznuA3f+07fJP9kY7dJHZdTPhmctQ+FGnSpQXMLpjU6s2YjF7c/Q5G57cgMs/gLJ
	afeCABf5oDIP3u21vB6rg8kq9XXk/GWKfWY1rlneZizKMg6SQ4F5g7UHyJxqHIjpoLGiLAHGy5ccS
	VQphWvM9/tCyKkHKudWeEgjK1fQXbL3/AE4VLE81BuuBEygclZIN2CQXAZ4auoWwHHSzW6//vmsnW
	Yg3ebrWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCCRn-00000002xOd-0VQP;
	Wed, 29 May 2024 06:06:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCCRh-00000002xOB-3VW5
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 06:05:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4491B6269E;
	Wed, 29 May 2024 06:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C32BC2BD10;
	Wed, 29 May 2024 06:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716962756;
	bh=cMeCo2Wv/H8lM/gi80oDYtFefeaUPGECO5IUqO8vWfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXsRvcJpIs8UvENjyDVODCcVLUb0y8EYZkISMz5gehg1/3CvC46plee4dMnttg5Rn
	 JYXIyPB2g4R6TA+sQqKuyNPwm7rxDlYmu9+CgQR5frsxuvIY1Rq7v1EUlsAXCwTq3w
	 SnKZiPl67tvnvYs1eVz/esSwWK7kQy/AaoSeQfSw=
Date: Wed, 29 May 2024 08:06:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stuart hayes <stuart.w.hayes@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tanjore Suresh <tansuresh@google.com>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v6 3/4] driver core: shut down devices asynchronously
Message-ID: <2024052951-buffalo-humongous-df1f@gregkh>
References: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
 <20240516154920.221445-4-stuart.w.hayes@gmail.com>
 <20240528063109.GA29965@lst.de>
 <f480f2a4-2958-4b08-ae32-ce307c3c63aa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f480f2a4-2958-4b08-ae32-ce307c3c63aa@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_230558_037367_A692F55E 
X-CRM114-Status: GOOD (  19.11  )
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

On Tue, May 28, 2024 at 10:35:27PM -0500, stuart hayes wrote:
> 
> 
> On 5/28/2024 1:31 AM, Christoph Hellwig wrote:
> > On Thu, May 16, 2024 at 10:49:19AM -0500, Stuart Hayes wrote:
> > > Add /sys/kernel/async_shutdown to allow user control of this feature:
> > > 
> > >    safe: shut down all devices synchronously, unless driver prefers async
> > > 	shutdown (driver opt-in) (default)
> > >    on:	shut down all devices asynchronously, unless disabled by the driver
> > > 	(driver opt-out)
> > >    off:	shut down all devices synchronously
> > 
> > The on option seems very odd.  IMHO safe is the only really sensible
> > option, and maybe we have to support off as a bandaid due to userspace
> > behavior dependent on synchronous shutdown, but I'd rather try even
> > without that first.
> > 
> 
> I added the option because of comments from Greg K-H on the v4 submission
> of this patch--see
> 
> https://lore.kernel.org/lkml/2023102151-rejoicing-studio-6126@gregkh/T/#m5d0459480bc0fda4563040cab2036839bcbb79a8).
> 
> I thought it would be nice to have the option for testing, even if it gets
> removed later, but I'll certainly remove it now if necessary.

Opt-in is the requirement here, that's all I asked for.  The "on" can
probably be removed, and by doing that, you can make this option simpler
as well.

thanks,

greg k-h

