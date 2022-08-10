Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08B9C00140
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 18:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=30VFo5a7JeVy/w8TY1J+NJC1egtewPVjD1FM6RGYwBg=; b=nl4JS7005RKVqJea0wn/pMHeEU
	G3Wl1tyGA6SfBhlViS71g2O/U7qWCTIyD0zNJKCfYtrv+fkp1UjW6eB6eDelq9bMePCkUdOOFDjeh
	+xHSv0urfWuUuROjrxEzuydmpl60rOsEtbFRxbbzg4mpK86BfsB1u5q+Ho9KV20huA4km7EQyxYOv
	zFonViREQ43qTDs75nNnJtWITuiZHKxCwJifIr9bCOYwsRiSh4/hDI3LAItkGUOumf3ybr1P7Ti7T
	GOQgxjw+BlhHBCuJJl+KH8Yd5P1RBv9y4UoI8hM7BAxDu1HCNbX/Inj8ffDFSHzV+su1NbDSDZkZb
	ITxnjTzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLqoe-00DuH9-O0; Wed, 10 Aug 2022 18:52:28 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLqoc-00DuFN-CR; Wed, 10 Aug 2022 18:52:26 +0000
Date: Wed, 10 Aug 2022 11:52:26 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
	casey@schaufler-ca.com, joshi.k@samsung.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	a.manzanares@samsung.com, javier@javigon.com
Subject: Re: [PATCH v2] lsm,io_uring: add LSM hooks for the new uring_cmd
 file op
Message-ID: <YvP+aiGcBsik+v3y@bombadil.infradead.org>
References: <20220715191622.2310436-1-mcgrof@kernel.org>
 <a56d191e-a3a3-76b9-6ca3-782803d2600c@kernel.dk>
 <YvP1jK/J4m8TE8BZ@bombadil.infradead.org>
 <CAHC9VhQnQqP1ww7fvCzKp_o1n7iMyYb564HSZy1Ed7k1-nD=jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQnQqP1ww7fvCzKp_o1n7iMyYb564HSZy1Ed7k1-nD=jQ@mail.gmail.com>
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

On Wed, Aug 10, 2022 at 02:39:54PM -0400, Paul Moore wrote:
> On Wed, Aug 10, 2022 at 2:14 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Fri, Jul 15, 2022 at 01:28:35PM -0600, Jens Axboe wrote:
> > > On 7/15/22 1:16 PM, Luis Chamberlain wrote:
> > > > io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> > > > add infrastructure for uring-cmd"), this extended the struct
> > > > file_operations to allow a new command which each subsystem can use
> > > > to enable command passthrough. Add an LSM specific for the command
> > > > passthrough which enables LSMs to inspect the command details.
> > > >
> > > > This was discussed long ago without no clear pointer for something
> > > > conclusive, so this enables LSMs to at least reject this new file
> > > > operation.
> > >
> > > From an io_uring perspective, this looks fine to me. It may be easier if
> > > I take this through my tree due to the moving of the files, or the
> > > security side can do it but it'd have to then wait for merge window (and
> > > post io_uring branch merge) to do so. Just let me know. If done outside
> > > of my tree, feel free to add:
> > >
> > > Acked-by: Jens Axboe <axboe@kernel.dk>
> >
> > Paul, Casey, Jens,
> >
> > should this be picked up now that we're one week into the merge window?
> 
> Your timing is spot on!  I wrapped up a SELinux/SCTP issue by posting
> the patches yesterday and started on the io_uring/CMD patches this
> morning :)
> 
> Give me a few days to get this finished, tested, etc. and I'll post a
> patchset with your main patch, the Smack patch from Casey, the SELinux
> patch, and the /dev/null patch so we can all give it a quick sanity
> check before I merge it into the LSM/stable branch and send it to
> Linus.  Does that sound okay?

Works with me! But just note I'll be away on vacation starting tomorrow
in the woods looking for Bigfoot with my dog, so I won't be around. And
I suspect Linus plans to release 6.0 on Sunday, if the phb-crystall-ball [0]
is still as accurate.

[0] http://deb.tandrin.de/phb-crystal-ball.htm

  Luis

