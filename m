Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF7BC433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Oct 2022 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yS7g/5OeTU+xWvwmAYIPBS9gpsBHcwt23EncKv/VYtk=; b=jEexRBGC94FB6q8zZL6Sg0epuB
	BJ0wCYNF1zKloKgPOxX/2RFv3RHgntFTHBCxaF7j7dRbsZqFY+cXkwGhTOkf5vhXpFPKFZXwukfSO
	gltkUXNaTYUhMdqdRn0GrXx0j/6LvHl4RumQ8ZHitfdm1ONKy4l4jM+YvRkofbARXqyGtVyJqbg3o
	gJwCDAkCbGcZuYwDbDFoeDsQbepf1i2PoYM6k5aLIrxoedUUn53AqS1R5J0/ZYuarsAqT2Di8b3IY
	NJoY7ggaohwCdzN5O6XfMFZIJ75Ttb8Q4fRYyZ3NLDB2C0uy8t2EhYjkEdYD0KIAuNdUdwUjnt9ux
	MFPzWgGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogQxq-002h86-Oc; Thu, 06 Oct 2022 13:31:02 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogQxl-002h4w-T5
	for linux-nvme@lists.infradead.org; Thu, 06 Oct 2022 13:31:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 963261F94E;
	Thu,  6 Oct 2022 13:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1665063054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yS7g/5OeTU+xWvwmAYIPBS9gpsBHcwt23EncKv/VYtk=;
	b=CJgXcZVbh5jIkVp0rKYjUBR1MiVBErOFeMuWzBF7IBJuiSFsQOC7jIGEt1uDtA5+TUlZl+
	cbU/HJ/Z8zeIxsn4j91X9OJmS0y12Gg6vqzQBFdturYQ225X+ABmsE36fUnidNEcdqxfo9
	iZvO72uqdGVi7H2nrND9660sT83/oCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1665063054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yS7g/5OeTU+xWvwmAYIPBS9gpsBHcwt23EncKv/VYtk=;
	b=eHZO0i+4cUIsu1B4WgtvyPDjrcbcxU8ONKjAFjkNXC+pwZZeUD76kK0+KBwVtUkrtKMDwK
	i6LnsjZHnWGODmCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EA801376E;
	Thu,  6 Oct 2022 13:30:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id h8/eHo7YPmO6SwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 06 Oct 2022 13:30:54 +0000
Date: Thu, 6 Oct 2022 15:30:53 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Pankaj Raghav <pankydev8@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	yi.zhang@redhat.com, Tomas Bzatek <tbzatek@redhat.com>,
	Alan Adamson <alan.adamson@oracle.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v1] nvme: do not log errors for user commands
Message-ID: <20221006133053.mmzw7m7wbfsapqbx@carbon.lan>
References: <20221006093628.22089-1-dwagner@suse.de>
 <20221006121635.awoafzxyu6nkrqfj@quentin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006121635.awoafzxyu6nkrqfj@quentin>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221006_063058_116212_B089010A 
X-CRM114-Status: GOOD (  14.55  )
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

On Thu, Oct 06, 2022 at 02:16:35PM +0200, Pankaj Raghav wrote:
> > +	req->rq_flags |= RQF_QUIET;
> 
> With this, we are disabling logging for ADMIN and IO commands via the
> ioctl. IMO, the error logging for IO commands could be useful for
> debugging. But I do understand your regression argument here.

I do get the debugging argument, but this clearly regresses production
code. Ideally, this code should be opt-in. The only way I see how to make
this work is by introducing a new API which allows enable this
feature.

> >  	ret = nvme_execute_passthru_rq(req, &effects);
> >  
> >  	if (result)
> 
> We can also send admin commands via the uring_cmd interface:
> nvme_dev_uring_cmd(). Should we also enable RQF_QUIET flags for them?

Good point, this path is likely to have the same problem.
 
> P.S: I sent a patch today that touches the error logging in NVMe that
> sets the starting LBA as zero for IO passthrough requests.
> https://lore.kernel.org/linux-nvme/20221006091053.36611-1-p.raghav@samsung.com/

Yes, saw your patch, but with this patch it wont do match afterwards :)


