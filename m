Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8478C48BEB
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 18:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BCKZ1UBP4Wj/w6fEAFQYv1+qM8ci73Vx/Xa7GoifUw8=; b=0e5SNiHVUUzMC3yKJiOaZZPeR3
	NN3j+H9M1gDY7g2ea11xYXr4xRbUhzFjc1roXa8B7oY9zQekXLNXFlb57x7e9dlcrxK+GIrGzKpgM
	EPJSGD2p7/hcHMB8QDGgm03A0DzF2BZJu93PBFi4xHdfgVgL0s/uKlDgYbb+FsvMauHAKoFijF8CO
	eEojbC7czk4cj1rByCk9479+Lum1ZTEEMj1MYyxcfHLteKlB64dhVfpz9Lunk3mrzYrbPvW250z4Y
	//r5LY29EnCAlEI8DUIIFLiRxbN2+An3wSom+0C/SGBDvS8eS+RXLX2bq7hnA6m80O/791GKR60F9
	SMSblOhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcrOR-000000027Ef-3S8P;
	Wed, 21 Feb 2024 18:32:31 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcrO1-000000027Ck-1ypC;
	Wed, 21 Feb 2024 18:32:05 +0000
Date: Wed, 21 Feb 2024 10:32:05 -0800
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
Subject: Re: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Message-ID: <ZdZBpb4vMMVoLfhs@bombadil.infradead.org>
References: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
 <bh5s6a4fhhlje42bzj2t22k3jpmruzkx234ks4ytuhd62tonzj@zn6h5foaqrof>
 <jfydrbb277d7ad2ypu5dottiqh4rtzm5ipf72wcjo34mmpvnl7@mjlqomulsq3q>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jfydrbb277d7ad2ypu5dottiqh4rtzm5ipf72wcjo34mmpvnl7@mjlqomulsq3q>
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

On Tue, Jan 23, 2024 at 04:07:48PM +0100, Daniel Wagner wrote:
> On Wed, Jan 17, 2024 at 09:50:50AM +0100, Daniel Wagner wrote:
> > On Tue, Jan 09, 2024 at 06:30:46AM +0000, Chaitanya Kulkarni wrote:
> > > For storage track, I would like to propose a session dedicated to
> > > blktests. It is a great opportunity for the storage developers to gather
> > > and have a discussion about:-
> > > 
> > > 1. Current status of the blktests framework.
> > > 2. Any new/missing features that we want to add in the blktests.
> > > 3. Any new kernel features that could be used to make testing easier?
> > > 4. DM/MD Testcases.
> > > 5. Potentially adding VM support in the blktests.
> > 
> > I am interested in such a session.
> 
> One discussion point I'd like to add is
> 
>   - running blktest against real hardare/target

We've resolved this in fstests with canonicalizing device symlinks, and
through kdevops its possible to even use PCIe passthrough onto a guest
using dynamic kconfig (ie, specific to the host).

It should be possible to do that in blktests too, but the dynamic
kconfig thing is outside of scope, but this is a long winded way of
suggestin that if we extend blktests to add a canonon-similar device
function, then since kdevops supports blktests you get that pcie
passthrough for free too.

  Luis

