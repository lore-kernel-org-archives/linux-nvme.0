Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DF3C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 16:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tVFYyyUhSs/BkYPl7bEWRiGqDAOmQn/Y9yN/F/0CVEY=; b=KYQGEEQXX8+T3V/9I4TTHsW1yf
	a2aJK+PYrd8wBvCW2CtrbptF4i0bqMZv4TWaEz3yqofj8+vIln4GhiBu4O1MyWdpgbYFl6GvReu3X
	ZcpHMzDA73kOCnQVLJilz8u/h7H6G1/6SouTdwICIRoeFJXdc2SXzOBiXAuUvY9ObUBYKkGXl7FFd
	P4jzyX29n4B2UyWXjdNNgj+KlA423RRW7AK7Avv0+jw/6fcE3maOpDltx5WJ2G+v09NYis+QYa3wV
	/elSgRXAbjxkW90mU7WVDCpgGGZm9fiD9mWvaMvMomMZKBDURZFLZCpeNsZsh5Rrd5TLtfTDTBOn1
	o3JwdpsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFfLk-0022uB-P5; Thu, 03 Feb 2022 16:52:48 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFfLh-0022s9-B4
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 16:52:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E02DAB834DE;
 Thu,  3 Feb 2022 16:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6E2C340E8;
 Thu,  3 Feb 2022 16:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643907162;
 bh=iaJxhtwIma6dUrbx3J2yiskIUAG+/AQHCMEnNS5R1Zo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ObXVLD8ZVfN8qLcAA/cwoT+F0WWY34fjcADHx5mxOicfMCp8LmOGroDLA0lzLs2+b
 Szc599IvtTtOtG5u3jWUjJia4KUNl++iTz8H9EtbTS8+8ihtbUNLjCQz8bBNy6zEhW
 tJ/k1LRfKEKD/xNnBjpj1Y90bf9/d8eACkulsewXmQ+dI70vPQfQJJe38hpojfYcBi
 +cYzFIxxxvCItLLi907bFuQgWEak+eRpVROajgoWHfmOqFSCwPBJWZbiAfVVIc1bgQ
 ocAeiEZLhJSmQ3RJ2JgSQsCmFy6VhcH9r3hvQ/7f6brbnG7hwKcBtPGM+YF8UnNvux
 WHcaWzUgxRwag==
Date: Thu, 3 Feb 2022 08:52:38 -0800
From: Keith Busch <kbusch@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>,
 "martin.petersen@oracle.com >> Martin K. Petersen"
 <martin.petersen@oracle.com>, 
 "roland@purestorage.com" <roland@purestorage.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
 "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
 Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Message-ID: <20220203165238.GA142129@dhcp-10-100-145-180.wdc.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
 <20220203153843.szbd4n65ru4fx5hx@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203153843.szbd4n65ru4fx5hx@garbanzo>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_085245_661261_89352D09 
X-CRM114-Status: GOOD (  23.05  )
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

On Thu, Feb 03, 2022 at 07:38:43AM -0800, Luis Chamberlain wrote:
> On Wed, Feb 02, 2022 at 08:00:12AM +0000, Chaitanya Kulkarni wrote:
> > Mikulas,
> > 
> > On 2/1/22 10:33 AM, Mikulas Patocka wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > This patch adds a new driver "nvme-debug". It uses memory as a backing
> > > store and it is used to test the copy offload functionality.
> > > 
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > 
> > 
> > 
> > NVMe Controller specific memory backed features needs to go into
> > QEMU which are targeted for testing and debugging, just like what
> > we have done for NVMe ZNS QEMU support and not in kernel.
> > 
> > I don't see any special reason to make copy offload an exception.
> 
> One can instantiate scsi devices with qemu by using fake scsi devices,
> but one can also just use scsi_debug to do the same. I see both efforts
> as desirable, so long as someone mantains this.
> 
> For instance, blktests uses scsi_debug for simplicity.
> 
> In the end you decide what you want to use.

Can we use the nvme-loop target instead?

