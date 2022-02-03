Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A30C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 19:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YFLdf+yXWDyqnOqAs6w9z7uJ08NBv+2fURUugK0F1GY=; b=mb5vg4eITvN/s9vdcvOjTP5c/H
	sPuFzj4JUZm2JfcKUL/9eEPRrwsq0JAsNCXlXhSh4844iswEUxrSmsnnET00oLqsxVEC2/MATLJAn
	xHT3IZaEyl787bCHJp18PaboWlJ+ncTkner6+XdKfUkeAwdDbIaj5PhhMU1aerUAo76YQ5TmGu4Zg
	nGcW4MPkoJw/P0kBhW1f+0OdPPqeoo5fASSjUH1RH5Os1AsNk9YOUUSambQXGwN9lb8MG5fvWhUyP
	kNOOazY++a4o9QmWlJIM2mngMGglSs7JeIZAHRVfVc2aaCK0bBtQTxh0VdOh54rhAP5ADEuzBRow2
	ijjF8+dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFhtl-002bNJ-G0; Thu, 03 Feb 2022 19:36:05 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nFhsB-002b1R-NQ; Thu, 03 Feb 2022 19:34:27 +0000
Date: Thu, 3 Feb 2022 11:34:27 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Adam Manzanares <a.manzanares@samsung.com>,
 Vincent Fu <vincent.fu@samsung.com>, Mikulas Patocka <mpatocka@redhat.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>,
 "martin.petersen@oracle.com >> Martin K. Petersen"
 <martin.petersen@oracle.com>, 
 "roland@purestorage.com" <roland@purestorage.com>,
 Hannes Reinecke <hare@suse.de>,
 "kbus @imap.gmail.com>> Keith Busch" <kbusch@kernel.org>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
 "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
 Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Message-ID: <YfwuQxS79wl8l/a0@bombadil.infradead.org>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <CGME20220201183359uscas1p2d7e48dc4cafed3df60c304a06f2323cd@uscas1p2.samsung.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <20220202060154.GA120951@bgt-140510-bm01>
 <20220203160633.rdwovqoxlbr3nu5u@garbanzo>
 <20220203161534.GA15366@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203161534.GA15366@lst.de>
X-Mailman-Approved-At: Thu, 03 Feb 2022 11:36:04 -0800
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

On Thu, Feb 03, 2022 at 05:15:34PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 03, 2022 at 08:06:33AM -0800, Luis Chamberlain wrote:
> > On Wed, Feb 02, 2022 at 06:01:13AM +0000, Adam Manzanares wrote:
> > > BTW I think having the target code be able to implement simple copy without 
> > > moving data over the fabric would be a great way of showing off the command.
> > 
> > Do you mean this should be implemented instead as a fabrics backend
> > instead because fabrics already instantiates and creates a virtual
> > nvme device? And so this would mean less code?
> 
> It would be a lot less code.  In fact I don't think we need any new code
> at all.  Just using nvme-loop on top of null_blk or brd should be all
> that is needed.

Mikulas,

That begs the question why add this instead of using null_blk with
nvme-loop?

  Luis

