Return-Path: <SRS0=9COT=NS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABCEC4320E
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 18:55:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED7D60E73
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 18:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9ED7D60E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MvDjwzkBTHjedL6Ltc/+QTaPwKeodeh7ik4Ag5ohzyk=; b=icUVkTXltkPwcI
	7YAj5Knw62I/xFEE+NPZsnhH/f+iRsrW0rcTptFj6SaAdYxqpcNrDT51k1jn4eEbC2oTC4OJ1LbGz
	z2A6Wt6okZ7f76qnp+jcbXyAB5fv5Qpal5MX0w4pMZ+nTCiumsiD226hZG4dTe7ODxoGfM4isFVb2
	bNAC9XSy13WuxF5AR+8fY+Bzn0lUqXIpYtde9sKvhySWK4waFmo6iBdZsfQohpMLpL9GDVAwiY1X7
	igMD0GBtRZHktrNkJyy5HQNw9JwMLXi+l8lKw+WsxM9wYVc+i9k02KYxWRAuG5bYYS0LXkAdcm5E7
	rPIEbV+M/30ovlvQj0jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJh0Y-00CzWL-2e; Fri, 27 Aug 2021 18:55:18 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mJh0U-00CzW8-NG; Fri, 27 Aug 2021 18:55:14 +0000
Date: Fri, 27 Aug 2021 11:55:14 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
 beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
 swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
 josef@toxicpanda.com, hare@suse.de, bvanassche@acm.org,
 ming.lei@redhat.com, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
 dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] dm: add add_disk() error handling
Message-ID: <YSk1EhUIr9OjIoVv@bombadil.infradead.org>
References: <20210823202930.137278-1-mcgrof@kernel.org>
 <20210823202930.137278-9-mcgrof@kernel.org>
 <YSSP6ujNQttGN2sZ@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YSSP6ujNQttGN2sZ@infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 24, 2021 at 07:21:30AM +0100, Christoph Hellwig wrote:
> On Mon, Aug 23, 2021 at 01:29:28PM -0700, Luis Chamberlain wrote:
> > -	add_disk(md->disk);
> > +	r = add_disk(md->disk);
> > +	if (r)
> > +		goto out_cleanup_disk;
> >  
> >  	r = dm_sysfs_init(md);
> > -	if (r) {
> > -		del_gendisk(md->disk);
> > -		return r;
> > -	}
> > +	if (r)
> > +		goto out_del_gendisk;
> >  	md->type = type;
> >  	return 0;
> > +
> > +out_cleanup_disk:
> > +	blk_cleanup_disk(md->disk);
> > +out_del_gendisk:
> > +	del_gendisk(md->disk);
> > +	return r;
> 
> I think the add_disk should just return r.  If you look at the
> callers they eventualy end up in dm_table_destroy, which does
> this cleanup.

I don't see it. What part of dm_table_destroy() does this?

  Luis

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
