Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEA3C48BF8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Feb 2024 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1HpmxAKzkYfraoLdEHEm+a3ZNMRSibqqtuuwE9JPZYI=; b=UN6kjPX4PQ9Z86sspdHJ21JlOD
	TYLTmuviLwSgo70Z0kYYiWbBObQUraxc6En4jK1+27vEU0lHapQyiRQOpt6WOH/9tz+sLZos2rTl9
	BLPaflyqn2DXcKLF1ZJtzJxPVQuMHM2wyTh77xxDk/eJHPndsNSrUXpVPuZ9I4hfF5fiQCiG+24Xz
	+jD+4HbmuzQQVfqYzzLmFAo0cqkKYBY8LU8N/ey7O4TYiNrC+vXuiVLCY6Hj1mfLrLt8pMlhKskVf
	u+NOZdj2b3hNh3ztMVCw3p8HwTd++o7SWzd2r4qP8KBn7Tc6z0sl3Hr1aaUKyfroU89BJ8/YT3SyW
	ajyWF3bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdBP0-00000005V38-2LOg;
	Thu, 22 Feb 2024 15:54:26 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdBOs-00000005V2s-0lCt;
	Thu, 22 Feb 2024 15:54:18 +0000
Date: Thu, 22 Feb 2024 07:54:18 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org >> linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"jack@suse.com" <jack@suse.com>, Ming Lei <ming.lei@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>, Theodore Ts'o <tytso@mit.edu>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Message-ID: <ZdduKnjJx3tJsQGY@bombadil.infradead.org>
References: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
 <bh5s6a4fhhlje42bzj2t22k3jpmruzkx234ks4ytuhd62tonzj@zn6h5foaqrof>
 <jfydrbb277d7ad2ypu5dottiqh4rtzm5ipf72wcjo34mmpvnl7@mjlqomulsq3q>
 <ZdZBpb4vMMVoLfhs@bombadil.infradead.org>
 <g5c3kwbalxru7gykmzdymrzf43fkriofiqtgdgcswbf4hrg65r@wdduaccaswhe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g5c3kwbalxru7gykmzdymrzf43fkriofiqtgdgcswbf4hrg65r@wdduaccaswhe>
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

On Thu, Feb 22, 2024 at 10:31:53AM +0100, Daniel Wagner wrote:
> On Wed, Feb 21, 2024 at 10:32:05AM -0800, Luis Chamberlain wrote:
> > > One discussion point I'd like to add is
> > > 
> > >   - running blktest against real hardare/target
> > 
> > We've resolved this in fstests with canonicalizing device symlinks, and
> > through kdevops its possible to even use PCIe passthrough onto a guest
> > using dynamic kconfig (ie, specific to the host).
> > 
> > It should be possible to do that in blktests too, but the dynamic
> > kconfig thing is outside of scope, but this is a long winded way of
> > suggestin that if we extend blktests to add a canonon-similar device
> > function, then since kdevops supports blktests you get that pcie
> > passthrough for free too.
> 
> I should have been more precise here, I was trying to say supporting
> real fabrics targets. blktests already has some logic for PCI targets
> with $TEST_DEV but I haven't really looked into this part yet.

Do fabric targets have a symlink which remains static?

  Luis

