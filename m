Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532D3CAC5A7
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Sep 2025 16:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I5XBEq8QoZNrsUfm/LIlDnw2hOYxn9vY9Sj8fl398cE=; b=XTX3I4SSCRALgKDVtJMXJCyjnP
	qsOgEXjlduhTHLNX5nfVVo0A4fotMCFbEOtbGeT1YAPzZOjArar2pEgPka2II4pIj5WxZT6fy4Gzr
	cEhlUNE/zNq83BKz9XWI6AERPB5yaG2vRycxvpxtPPWpcdKm2Ip12e6dOoAUJ2UJ6bcN1eNCZUU9u
	byuFMUwk0IuhsB9L22UJ6Qg8pEx8H9Kmsa4zaRwJ/V5PJhqeCSxTPMZYKR6/plw3PBNyb5wnsOWCf
	aQ6DYi6TgFP8ZCP38R6Du6EzmMjFZwz8eFvN5oekke9nqRMhSP5Cmx3/iS+qGpf7YYzgi8Rp8sBj4
	r4NNbK7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1oNw-0000000Aupd-3PCn;
	Thu, 25 Sep 2025 15:59:56 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1oNt-0000000Aumv-3Q7N
	for linux-nvme@lists.infradead.org;
	Thu, 25 Sep 2025 15:59:55 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-77f32d99a97so1173214b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 25 Sep 2025 08:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758815993; x=1759420793; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5XBEq8QoZNrsUfm/LIlDnw2hOYxn9vY9Sj8fl398cE=;
        b=KjnkTqnf05DFn8uGtm9UDJlHZ7dPqYxyu+L7r1NcBEbLn7iXksBLUDKsr8oNKvr9SK
         OFb73aQw1EU2HO+5Sv4i6jWCCIE+eF0NBJ+klQIgKotqpyv+v9uYZttSG+ZJv9Spbq5B
         yBerHjahYjrDL8wMHTLGqb3Mf4TiyYJrYee1EY3eqG3r7CoVnmk7LxOWwzzLKDF3PdE9
         1CqYrvQkookJTggrdnThAiqJOccJSbfv1bOxaLP5DSlq5yJ39ATbcIS7/eL/Um2yS3DV
         g914fdtttHRyGZ5CWLmXwx1cvmQDphd+DB9547S1TC7VqqLwFGMfsmpKs2quNEyAGBCb
         YW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758815993; x=1759420793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5XBEq8QoZNrsUfm/LIlDnw2hOYxn9vY9Sj8fl398cE=;
        b=Eo5ddfASTK6/XtLoWJd8wJf1yPUu0lmRwvmbkFxTdPI72JHmZ/tvzp3gMTSdibOC0w
         yJSEXCn3ekua2qrnSA7QYisy9eqWrLiDI4rYBYFWoTAqkz3N4lnTan/yY8uE/rdQRcm9
         0bB2M0UCOQn1J4/9f64ynd7bCw7/FRpmDNgGt+ph+QOhdCqdqqrehGN/e9iWuMxvRyNT
         o9N3K+7DZcf1zdXkOULmaOIXzpMfEUzxI9HTa1euyqNGP+i2bnYy1BAwOH+BAoahl/UY
         iTnz39TSrRpGIuqSNRKpf96WpN6bwMJ6rB3HeMHTd4Huv4amugs1bJRHLHDMf6F/V36j
         IabQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMZfbr2KH1bicv1C9WetENjiL3eIxM+LFK5Qa62wZeyxiA3wamJv8bnf4v0gWok5dBtFjnUNwC32A4@lists.infradead.org
X-Gm-Message-State: AOJu0YwPR/oUT5aS4o4mgzgCi1884qosWYW4janCTlY/+NPaqQ5Leez9
	eT8X9qFRqPs33W7M/xf0ZgbmU+/KqoHRU7IofnccofSlZ0MwsPes3S/+dMQvV97K9jE=
X-Gm-Gg: ASbGncs2ozZh+nIRozD7DnZCRxyu5ZDKv3eKO1vcnt9Vf6Wtmn4btFwYcb7KI7DE53h
	Buep5tyzc30OlSI0k7iK5rVhDjc41W+MCkBjhuLp986OalN/EV5VLuhPjPnXtYS5ITOzVU5rX64
	QeoyQbve6azVN6EdLhYtl+zPsDbMAcUL4swZmUxn4b7fbTxs4U/5+zNHK9Xf75gYjGOPnfzoyBK
	RaeKyl4RCQIdAG2cgcaBA19y799xOeiKN2ttBNLeispuv4IVtHShXFGNdNY/88dlnftGl7+kcHj
	KMIr2Ahlta5crw0WLWvRjYVoEIMpqAlvSU+WpLV0mfA+elQ+r0s+WZIOfSshO4UFToF9qS0Cig+
	emrzlfOFOU+BMBGL2svfbj4aGbhxl
X-Google-Smtp-Source: AGHT+IE3MC+4196hdWgsoD1Z2JwahZdWiuJ/E8gO1X15jtnyZAibsQAfl1r6vLcaWOJ2ok+XUXafKg==
X-Received: by 2002:a05:6a20:7f97:b0:2cb:5f15:ebfa with SMTP id adf61e73a8af0-2e7dab12a8dmr3887775637.60.1758815992627;
        Thu, 25 Sep 2025 08:59:52 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::bed8])
        by smtp.googlemail.com with UTF8SMTPSA id d2e1a72fcca58-78102b250bfsm2310854b3a.61.2025.09.25.08.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:59:52 -0700 (PDT)
Date: Thu, 25 Sep 2025 08:59:50 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Amit Chaudhary <achaudhary@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, randyj@purestorage.com,
	jmeneghi@redhat.com, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-multipath: Skip nr_active increments in RETRY
 disposition
Message-ID: <20250925155950.GA4013-mkhalfella@purestorage.com>
References: <20250924224319.4557-1-achaudhary@purestorage.com>
 <aNR4m9wrO5cgFZIe@kbusch-mbp>
 <20250925011427.GC3269-mkhalfella@purestorage.com>
 <aNVVIP3WE7POT498@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNVVIP3WE7POT498@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_085954_162169_FF569E0E 
X-CRM114-Status: GOOD (  27.25  )
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

On 2025-09-25 08:43:44 -0600, Keith Busch wrote:
> On Wed, Sep 24, 2025 at 06:14:27PM -0700, Mohamed Khalfella wrote:
> > On 2025-09-24 17:02:51 -0600, Keith Busch wrote:
> > > On Wed, Sep 24, 2025 at 03:43:18PM -0700, Amit Chaudhary wrote:
> > > >  static inline void nvme_start_request(struct request *rq)
> > > >  {
> > > > -	if (rq->cmd_flags & REQ_NVME_MPATH)
> > > > +	if ((rq->cmd_flags & REQ_NVME_MPATH) && (!nvme_req(rq)->retries))
> > > >  		nvme_mpath_start_request(rq);
> > > >  	blk_mq_start_request(rq);
> > > >  }
> > > 
> > > Using "retries" is bit indirect as a proxy for multipath active counts.
> > > Could this be moved to the mpath start instead, directly using the flag
> > > that accounts for the path? This also helps to keep track if the command
> > > gets retried across a user toggling the policy to "qd".
> > > 
> > > ---
> > > diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> > > index 3da980dc60d91..1c630967ddd40 100644
> > > --- a/drivers/nvme/host/multipath.c
> > > +++ b/drivers/nvme/host/multipath.c
> > > @@ -182,7 +182,8 @@ void nvme_mpath_start_request(struct request *rq)
> > >         struct nvme_ns *ns = rq->q->queuedata;
> > >         struct gendisk *disk = ns->head->disk;
> > > 
> > > -       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
> > > +       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD &&
> > > +           !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
> > >                 atomic_inc(&ns->ctrl->nr_active);
> > >                 nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
> > >         }
> > > --
> > 
> > 193         nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
> > 194         nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
> > 195                                                       jiffies);
> > 
> > Doing it this way might messup with stats accounting because the two
> > lines above will be executed on request retry. I do not think we need
> > that, right?
> 
> Yeah, but we can use the other flag to know if it's already been
> accounted:
> 
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -182,12 +182,14 @@ void nvme_mpath_start_request(struct request *rq)
>         struct nvme_ns *ns = rq->q->queuedata;
>         struct gendisk *disk = ns->head->disk;
> 
> -       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
> +       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD &&
> +           !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
>                 atomic_inc(&ns->ctrl->nr_active);
>                 nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
>         }
> 
> -       if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
> +       if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
> +           nvme_req(rq)->flags & NVME_MPATH_IO_STATS)
>                 return;
> 
>         nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;

This works. However, I find Amit's change more straight forward to
understand. nvme_mpath_start_request()/nvme_mpath_end_request() are
called when request started/ended respectively. For a request that has
been retried on the same path nvme_mpath_start_request() need not be
called again. Such retry should be transparent to multipath layer.

