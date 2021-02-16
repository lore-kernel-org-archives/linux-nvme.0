Return-Path: <SRS0=dBpD=HS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F314C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 11:46:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7805B64DA5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 11:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7805B64DA5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yfbanElUAByMbsP3PPICMf8ijxtuQ0QGCEfw7+ukUxg=; b=e618QfDaD0C/gmm7GZUY+CPJJ
	uQsmBz3JBgkvnPj7kvSGZWm/Q50dNB5bOsAxsGgg/RZdMw4miFbzjfP1XdDbNu6TrKVPyDBu/OhGC
	b70/uB/RQJ0oY3IwwQtIYVaCAq4xCfGOJuNoWC3dFO0a6MLRjFtenNBGhUO+WHtEX/dccMozf6On5
	hZFblmF1JV8Nd5p5FP5/HpLGhTXfoa9KK5SIURJ3hYZCsIQZf7G5LPsEsle320JOOb9Ztp2dVF/6R
	BoHCl32BnNUKfZ89YNWGHNceLqD5DNc/kNHtbtFKJfpECTdVX45G7t7PaC2GEraw2IJAC6rCQUOGr
	JChnelMyQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lByoL-0007Ym-HR; Tue, 16 Feb 2021 11:46:33 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lByoH-0007Y3-LA
 for linux-nvme@lists.infradead.org; Tue, 16 Feb 2021 11:46:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5738667373; Tue, 16 Feb 2021 12:46:24 +0100 (CET)
Date: Tue, 16 Feb 2021 12:46:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 12/78] dm: use set_capacity_and_notify
Message-ID: <20210216114624.GA1221@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-13-hch@lst.de>
 <CAMM=eLfD0_Am3--X+PsKPTfc9qzejxpMNjYwEh=WtjSa-iSncg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMM=eLfD0_Am3--X+PsKPTfc9qzejxpMNjYwEh=WtjSa-iSncg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_064629_811941_86C33B76 
X-CRM114-Status: GOOD (  21.90  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Justin Sanders <justin@coraid.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
 Song Liu <song@kernel.org>, device-mapper development <dm-devel@redhat.com>,
 Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 12, 2021 at 10:45:32AM -0500, Mike Snitzer wrote:
> On Mon, Nov 16, 2020 at 10:05 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Use set_capacity_and_notify to set the size of both the disk and block
> > device.  This also gets the uevent notifications for the resize for free.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > ---
> >  drivers/md/dm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index c18fc25485186d..62ad44925e73ec 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -1971,8 +1971,7 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
> >         if (size != dm_get_size(md))
> >                 memset(&md->geometry, 0, sizeof(md->geometry));
> >
> > -       set_capacity(md->disk, size);
> > -       bd_set_nr_sectors(md->bdev, size);
> > +       set_capacity_and_notify(md->disk, size);
> >
> >         dm_table_event_callback(t, event_callback, md);
> >
> 
> Not yet pinned down _why_ DM is calling set_capacity_and_notify() with
> a size of 0 but, when running various DM regression tests, I'm seeing
> a lot of noise like:
> 
> [  689.240037] dm-2: detected capacity change from 2097152 to 0
> 
> Is this pr_info really useful?  Should it be moved to below: if
> (!capacity || !size) so that it only prints if a uevent is sent?

In general I suspect such a size change might be interesting to users
if it e.g. comes from a remote event.  So I'd be curious why this happens
with DM, and if we can detect some higher level gendisk state to supress
it if it is indeed spurious.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
