Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0278CC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 05:35:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E01C64EED
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 05:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E01C64EED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eqWnAzhZWjvty0yTOb0DJsoHqIKh3eSUX4peqbswIdM=; b=N2vDnoqa45RFr0swGYr/gCCpa
	ws9WggVC00/CVR7kC2nUH3vBU5uShVZ9nHc66pkk9arDJxW8sMl4xTO4CagMmtco9U9NIT2+fbLBu
	1+f8hE9Qw1QOVUXFAmNq0yLIJ2v9oOV+HDD/mbJk5AC7F4XhGIig62+4SJY1lrjC/AWTdU6lAFpjE
	1jxifpTr0qEgJWHYOXUnF761MWMew7UqHzkR7KXZ/uRrygv4SP79U0wZ53lV4bMi4VVsnk0+WA5xl
	HO498RofUXiG9zdhOMZk4HsDEVJxGtjOfmKVOSoZmIQEAH/tIRzOEFZZiedqpssnz8WoQC3wn+DmX
	IppP8ZpZQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMlJG-004X9r-FG; Thu, 18 Mar 2021 05:35:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMlJB-004X9A-23
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 05:34:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0838368C4E; Thu, 18 Mar 2021 06:34:54 +0100 (CET)
Date: Thu, 18 Mar 2021 06:34:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, joshi.k@samsung.com, hch@lst.de,
 kbusch@kernel.org, linux-nvme@lists.infradead.org, metze@samba.org
Subject: Re: [PATCH 1/8] io_uring: split up io_uring_sqe into hdr + main
Message-ID: <20210318053454.GA28063@lst.de>
References: <20210317221027.366780-1-axboe@kernel.dk>
 <20210317221027.366780-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210317221027.366780-2-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_053457_353700_33B79C4B 
X-CRM114-Status: GOOD (  18.31  )
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

> @@ -14,11 +14,22 @@
>  /*
>   * IO submission data structure (Submission Queue Entry)
>   */
> +struct io_uring_sqe_hdr {
> +	__u8	opcode;		/* type of operation for this sqe */
> +	__u8	flags;		/* IOSQE_ flags */
> +	__u16	ioprio;		/* ioprio for the request */
> +	__s32	fd;		/* file descriptor to do IO on */
> +};
> +
>  struct io_uring_sqe {
> +#ifdef __KERNEL__
> +	struct io_uring_sqe_hdr	hdr;
> +#else
>  	__u8	opcode;		/* type of operation for this sqe */
>  	__u8	flags;		/* IOSQE_ flags */
>  	__u16	ioprio;		/* ioprio for the request */
>  	__s32	fd;		/* file descriptor to do IO on */
> +#endif
>  	union {
>  		__u64	off;	/* offset into file */
>  		__u64	addr2;

Please don't do that ifdef __KERNEL__ mess.  We never guaranteed
userspace API compatbility, just ABI compatibility.

But we really do have a biger problem here, and that is ioprio is
a field that is specific to the read and write commands and thus
should not be in the generic header.  On the other hand the
personality is.

So I'm not sure trying to retrofit this even makes all that much sense.

Maybe we should just define io_uring_sqe_hdr the way it makes
sense:

struct io_uring_sqe_hdr {
	__u8	opcode;	
	__u8	flags;
	__u16	personality;
	__s32	fd;
	__u64	user_data;
};

and use that for all new commands going forward while marking the
old ones as legacy.

io_uring_cmd_sqe would then be:

struct io_uring_cmd_sqe {
        struct io_uring_sqe_hdr	hdr;
	__u33			ioc;
	__u32 			len;
	__u8			data[40];
};

for example.  Note the 32-bit opcode just like ioctl to avoid
getting into too much trouble due to collisions.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
