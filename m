Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDB9C61D85
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Nov 2023 17:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b3Y3Cc6MSxpKiKAfRlFn/wczfHIRU297DpfT3E8BQjg=; b=QkEMM3TydIkYHJYwb5wKaZb+pb
	FkaKnEdPs6S/SyUwYiZvcJp1GFi0dtxsUo7K6O/4tHXsshDDpf2VdSP7wkKHe2GUnaMKyvHRYSzmv
	DToi6Xd5lGKmfYbkFXKRti4Hx9iM2cUfltBYHZL9BqfD0wA/mchRAWQafg9axcfkwDerJ2cRTTbEF
	o+KsPK+QCGQkacAhpCqK64gqEVW/yy0/hDdQ+LJ6Tw91/0zAunMS4qprFZK3Bcep8NPIkGfmrCaMm
	2WSNo4ew7jH43Wn0NDUnCVbqwK95COSOS76GNrybwrT3MbypZnaZJJD53rN8t4EQA8LydRjvAozVF
	nnFHCI0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5UuC-00HQMn-23;
	Tue, 21 Nov 2023 17:51:24 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5UuA-00HQLz-0A
	for linux-nvme@lists.infradead.org;
	Tue, 21 Nov 2023 17:51:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 82F6ECE1C00;
	Tue, 21 Nov 2023 17:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6C3C433C9;
	Tue, 21 Nov 2023 17:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700589076;
	bh=lUrGC0Cf2mPtPdKtzMmuvM5CGdDSqsmDkgS8uHejk6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5GQvXD/U/7UzaSXgH/IEDlgs7OSr+0VQo1zz6VHgpqqf0rfKCyeCg2o5HLNJmLzU
	 N6eX1p4FSIntIERByCHZlUZeyIAJVsLz9ELDZZuNIJ2WgH9NrYzehzaJJyXEqMCQ6v
	 s1geruyE5tpNBug3v/yIDePiKmWtHuLdWN5snoHlYs+uU1Cr2z8Dy09VM/1r/0pzYg
	 JruFClFufmQplQM9Jovg7HU39yCKkPWv5FZx3VhLeTjqBNKT/vRhQY4naPxYRuFztp
	 kA8/VmWQo0lxBvQMbV58ltjGLKFcuWs1QUokMYOAdv1NQ+UUYiYGYarCGyA7R7Bxbp
	 abKHjh2WxYOow==
Date: Tue, 21 Nov 2023 10:51:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: move nvme_stop_keep_alive() back to original
 position
Message-ID: <ZVzuEX4_nXf3B82h@kbusch-mbp>
References: <20231121080103.23355-1-hare@suse.de>
 <be1195e3-2fca-4d68-8222-45f97a72a349@grimberg.me>
 <87313f89-cdd5-4511-87c3-816f545c4e60@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87313f89-cdd5-4511-87c3-816f545c4e60@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_095122_294067_F54321D4 
X-CRM114-Status: GOOD (  19.69  )
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

On Tue, Nov 21, 2023 at 03:41:52PM +0100, Hannes Reinecke wrote:
> On 11/21/23 10:23, Sagi Grimberg wrote:
> > 
> > > Stopping keep-alive not only stops the keep-alive workqueue,
> > > but also needs to be synchronized with I/O termination as we
> > > must not send a keep-alive command after all I/O had been
> > > terminated.
> > > So to avoid any regressions move the call to stop_keep_alive()
> > > back to its original position and ensure that keep-alive is
> > > correctly stopped failing to setup the admin queue.
> > > 
> > > Fixes: 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
> > 
> > It should be folded in I guess. I suggest to either suggest an
> > alternative phrasing of the patch or resend an alternative patch
> > set.
> > 
> Well, the original patch has already been merged to the nvme-6.7 tree,
> so I've attached the 'Fixes' tag.
> But let me know how you'd like to play it.

It's not just in nvme-6.7; it's merged upstream too. We can't squash it
now, so is it okay to apply this update as-is for the next pull request?
I'm going to send the next one out tomorrow before US holiday.

