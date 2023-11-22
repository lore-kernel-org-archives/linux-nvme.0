Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABA6C61D99
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Nov 2023 16:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tQwgl9N+qy1l5SsCu9+OI0ebnpSMJ+qzPLqqFwpuvDo=; b=mnOV7HcOT6VJmVQga60D8t74Ba
	qH6j/5nByVJasPevpRYNgOKtWaxy48j1XYrlxeG6D+13CGvmZMGeH0yMIaDbVMucYgv0HHn3muXld
	KXF5Ylw0QgSsvlG+HAB7KICpdlzpZUy5Ap02V2atXr4xKQjZqgbnTZD/VGEbObAxGYDE/0R70fesz
	mcv10S4FBhhNGTGcJKFogYc4ob9tQ2Sdcpsx0nWDE8zKiljAyDQ39rCq4GUb6DNw4HwgIsPlsokz7
	+tynqpA3Rnp8Nnccpvy9eMtdn9nZY5TMlnEBw/XoUG2OrfniXtnCfMhqe3/KtS7CIuCJTt3l44MRZ
	GejQAoLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5plC-002NkV-39;
	Wed, 22 Nov 2023 16:07:30 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5pl9-002NjD-2F
	for linux-nvme@lists.infradead.org;
	Wed, 22 Nov 2023 16:07:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 59B58CE201E;
	Wed, 22 Nov 2023 16:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103FCC433C8;
	Wed, 22 Nov 2023 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700669244;
	bh=Qwh6LgwCNwN1llI5pw/66EcQAqpIQdWql2EIajrhDVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+l/Ld5UJCtuourlCB3X49ny5kXSK/jK+D+20BAwIZVckR0J5NYHp0MN4BcD0Qpgv
	 /C33x3ZsT350n/HDCGxK64LHto54mAHK9gTk5f7NxXSFfEAkC3cOijFxeaJlpV8Ux0
	 YxWbr4C2KtRhGXmiHHQkQm4sDQ60UeqGbW4kUDw4dDk8WQg583OCJgFz/YETOvPrl3
	 KWUULkKvSsUBjxnsQ46wELhwxMgPFJf4MC2ckUHltEhRkbx/OPpdwKhf+sO1/zL9Rv
	 eMxggdx7//b8Uj1kLGttaRS4a34xcD4OP2A8Os0gVMlS9//gLH7oPR7IcKkifTxWZo
	 A5onL7KPkVESA==
Date: Wed, 22 Nov 2023 09:07:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: move nvme_stop_keep_alive() back to original
 position
Message-ID: <ZV4nOW-tcmGx1Bgs@kbusch-mbp.dhcp.thefacebook.com>
References: <20231121080103.23355-1-hare@suse.de>
 <be1195e3-2fca-4d68-8222-45f97a72a349@grimberg.me>
 <87313f89-cdd5-4511-87c3-816f545c4e60@suse.de>
 <ZVzuEX4_nXf3B82h@kbusch-mbp>
 <cb505cf1-598b-4e81-8f5b-2240e1ee6cc0@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb505cf1-598b-4e81-8f5b-2240e1ee6cc0@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_080727_962490_49BD6CCC 
X-CRM114-Status: GOOD (  23.06  )
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

On Wed, Nov 22, 2023 at 10:16:09AM +0200, Sagi Grimberg wrote:
> 
> > > > > Stopping keep-alive not only stops the keep-alive workqueue,
> > > > > but also needs to be synchronized with I/O termination as we
> > > > > must not send a keep-alive command after all I/O had been
> > > > > terminated.
> > > > > So to avoid any regressions move the call to stop_keep_alive()
> > > > > back to its original position and ensure that keep-alive is
> > > > > correctly stopped failing to setup the admin queue.
> > > > > 
> > > > > Fixes: 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
> > > > 
> > > > It should be folded in I guess. I suggest to either suggest an
> > > > alternative phrasing of the patch or resend an alternative patch
> > > > set.
> > > > 
> > > Well, the original patch has already been merged to the nvme-6.7 tree,
> > > so I've attached the 'Fixes' tag.
> > > But let me know how you'd like to play it.
> > 
> > It's not just in nvme-6.7; it's merged upstream too. We can't squash it
> > now, so is it okay to apply this update as-is for the next pull request?
> > I'm going to send the next one out tomorrow before US holiday.
> 
> Right, I didn't reach the PR email that was sent. Lets send the patch
> as is. You can add my:
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Thanks, queued up now for nvme-6.7.

