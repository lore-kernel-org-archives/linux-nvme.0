Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2D1C4167B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Dec 2023 09:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YOc8omLyXTHNKl9606IgIyBqFjM+R34Gq8X0TbUDYXM=; b=lG8/SyZmiXa0dfZH44FGeOPPv3
	Pcg6w/0ezdS/A33wd+Pgwlqw3Vf6Mw85XVLfIIL6pX/XeLKGCl163z2skRibPq/iLIm6VTpyaJygh
	mv/OV7kuwntdEJ2v9IxqLc91RkDSxbMjKbQiccCvOV4ZotFUq7C56kXQQqEs6f0CEqyBvb6NChJa5
	fhPkdTBtYyvoF9wtsrBXH3JN1lDr4sEs14Wr0lEOcxrx0CAC4QBRDLTTclgHCUl9WQ/53Htv2Lanh
	qe85cu2QF/UWtTWJqjcNrRfyJoCh/9Uw2LjORzM+G+mAVVbOKD9iJoHGVJRDZ+Q3wUq6cjpLrRlRy
	v3NYGG1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBWsS-00F64t-13;
	Fri, 08 Dec 2023 09:10:32 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBWsN-00F649-0D
	for linux-nvme@lists.infradead.org;
	Fri, 08 Dec 2023 09:10:28 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE2931FDAC;
	Fri,  8 Dec 2023 09:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702026618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YOc8omLyXTHNKl9606IgIyBqFjM+R34Gq8X0TbUDYXM=;
	b=osl9birKMM66uWyq2hQZZ0lzfwOuKSzuPEBBCPiiYk5N0HZt74zX7jbeqZkZKpn3E4xz4R
	dybgL6g1G8x9nn9ZZs8F2E21dwngJNPtLwmGKQkKti0ga2I8WFhnOvYzi+HcYUiJXZaz/V
	KWIWFB9we1Zxwgp2vOQXph0vVaZx0Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702026618;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YOc8omLyXTHNKl9606IgIyBqFjM+R34Gq8X0TbUDYXM=;
	b=uGM/7ORDfohEhNHTL7xY2TiFCv2s99iHoenZ/onr56wNIyYhpJuw9z1nQFiOQVjqIHpyqj
	5gM1zlYAm3beaUCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702026618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YOc8omLyXTHNKl9606IgIyBqFjM+R34Gq8X0TbUDYXM=;
	b=osl9birKMM66uWyq2hQZZ0lzfwOuKSzuPEBBCPiiYk5N0HZt74zX7jbeqZkZKpn3E4xz4R
	dybgL6g1G8x9nn9ZZs8F2E21dwngJNPtLwmGKQkKti0ga2I8WFhnOvYzi+HcYUiJXZaz/V
	KWIWFB9we1Zxwgp2vOQXph0vVaZx0Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702026618;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YOc8omLyXTHNKl9606IgIyBqFjM+R34Gq8X0TbUDYXM=;
	b=uGM/7ORDfohEhNHTL7xY2TiFCv2s99iHoenZ/onr56wNIyYhpJuw9z1nQFiOQVjqIHpyqj
	5gM1zlYAm3beaUCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 96D74138FF;
	Fri,  8 Dec 2023 09:10:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oyNGI3rdcmUQOQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 08 Dec 2023 09:10:18 +0000
Date: Fri, 8 Dec 2023 10:10:17 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 0/4] nvme: add csi, ms and nuse to sysfs
Message-ID: <ijrqwufzr67dcemmswmlco2mbrajb3ueoeqhcqwvxqas2evzrx@wn25othf4377>
References: <20231207123624.29959-4-dwagner@suse.de>
 <hryojvgqgmhie6s3ykr6242bqybb2hnzfiywwaij4cmennvb6r@xs5ibnslvhg5>
 <20231207123624.29959-1-dwagner@suse.de>
 <20231207123624.29959-4-dwagner@suse.de>
 <20231207123624.29959-1-dwagner@suse.de>
 <20231207123624.29959-3-dwagner@suse.de>
 <20231207123624.29959-1-dwagner@suse.de>
 <20231207123624.29959-2-dwagner@suse.de>
 <20231207123624.29959-1-dwagner@suse.de>
 <20231207153138.GA20644@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207153138.GA20644@lst.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231208_011027_265677_4CE2A1A1 
X-CRM114-Status: GOOD (  19.34  )
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

Hi Christoph,

On Thu, Dec 07, 2023 at 04:31:38PM +0100, Christoph Hellwig wrote:
> this looks generally good to me.  A few comments, all but one are
> cosmetic.
> 
> > @@ -1676,9 +1678,9 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
> 
> This an now take the ns_head instead of the ns.

Okay

> > @@ -1776,11 +1778,11 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
> 
> This can take a ctrl and ns_head instead of the ns.

Okay

> > @@ -1835,8 +1837,8 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
> 
> This as well after updating nvme_ns_has_pi to take the ns_head.

Okay

> > @@ -1898,7 +1900,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
> >  		struct nvme_ns *ns, struct nvme_id_ns *id)
> 
> This as well after fixing up nvme_lba_to_sect to take the ns_head.

Okay

> 
> > @@ -2052,7 +2055,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
> 
> This one as well.

When trying to refactor this function I run into a bit of trouble with
dependencies. Basically, we would need to pass through nvme_ctrl,
request_queue, gendisk and nvme_ns_head and still need nvme_ns in
nvme_update_zone_info:

nvme_update_ns_info_block
  blk_mq_freeze_queue(ns->disk->queue)
  nvme_set_chuck_sector(ns->queue)
  nvme_update_zone_info()
    set_bit(NVME_NS_FORCE_RO, ns->flags)
    blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);

I suggest we don't refactor this part now. At least it I don't see an
good way to avoid passing down nvme_ns as we still need this data
structure in deeper down the call chain.

> > @@ -128,7 +129,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
> >  				   sizeof(struct nvme_zone_descriptor);
> >  
> >  	nr_zones = min_t(unsigned int, nr_zones,
> > -			 get_capacity(ns->disk) >> ilog2(ns->zsze));
> > +			 get_capacity(ns->head->disk) >> ilog2(ns->head->zsze));
> 
> This doesn't work, as the head disk doesn't exist for !multipath
> setups.

I was a bit trigger happy here. Changed it back to 'get_capacity(ns->disk)'.

> > @@ -162,7 +163,7 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
> 
> This could do with ctrl + ns_head now

Okay.

Thanks,
Daniel

