Return-Path: <SRS0=7ucB=3X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4758C35247
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2020 17:10:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D5020721
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2020 17:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ATtT1j7x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjoFrGRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D5020721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L++PViwkqaCJ95tP1Lou7j/herKQCLs6ISP5fKnaDmU=; b=ATtT1j7xcF8vN1
	89FKoEJmXzkwQU0MJnTOQfs8Crz/CXha0WSI9mMKcKe9TPCITg+qR84gfTVKGLPVGkpFmknMZY+rc
	ivJr9fcocwCTB8IE0iz484htZj8x77oO23YX6MpkESd08ujtiiELTNMLhUn1th0Nvy7dEyRAtui7M
	d4ABzIanBKro1txcItbN0ZMlm0AraT14QwvroIszu4l3OUY8bXgLgduJ6shXfFWZi8sfSsCWcGWYd
	AdJz5bVfs+AH8ITmOGYhnSc/Y3Pgvf8a7qEhSK2uGm/TVVkFcKm073sZpC2ORHQYGb5hePwAMetHn
	wfJJuy+Op/yg2R/2d9xw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iyfEr-0000TL-Fz; Mon, 03 Feb 2020 17:10:21 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iyfEo-0000Sd-Kp
 for linux-nvme@lists.infradead.org; Mon, 03 Feb 2020 17:10:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580749816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBy7o18ckwBID8Nr4to5kPGdoZKPUsSea8IbVhq8Ows=;
 b=TjoFrGRdoUh4DY81DzPqN7XGroxkwKoCUgAXZ07wc5G1PAv76DiLU1LaOc7wE83AkW+N4h
 vrbJZAYxhAp4QfiWXnUvLnVGrcjs5rX7ovp3Ys+ficlUlCwpxir/G0K3BG+icDp/QjCHT7
 RvaeZMeyZL4Ev7gc+FOivZP4NJYIdfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-DwRWkZDhNjiMykyYkoug-A-1; Mon, 03 Feb 2020 12:08:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D22E318A8CBF;
 Mon,  3 Feb 2020 17:08:19 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C2AF86C4A;
 Mon,  3 Feb 2020 17:08:19 +0000 (UTC)
Date: Mon, 3 Feb 2020 12:08:18 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Victor Gladkov <Victor.Gladkov@kioxia.com>
Subject: Re: [PATCH v2] nvme-fabrics: reject I/O to offline device
Message-ID: <20200203170818.GB11874@redhat.com>
References: <49c2e737f21b4c2795de71c8d8d578ee@kioxia.com>
 <98e76717-1e98-92e1-0d07-d2dac4bd1d76@broadcom.com>
 <8b8454b9b2d44efab22df15af9df0a21@kioxia.com>
 <20200130150852.GB25427@infradead.org>
 <0feb0c25623a42cfb115fbf0590492b4@kioxia.com>
MIME-Version: 1.0
In-Reply-To: <0feb0c25623a42cfb115fbf0590492b4@kioxia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: DwRWkZDhNjiMykyYkoug-A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200203_091018_762178_ADD63FC4 
X-CRM114-Status: GOOD (  21.19  )
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
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 03 2020 at  8:40am -0500,
Victor Gladkov <Victor.Gladkov@kioxia.com> wrote:

> On Sun, Jan 30, 2020 at 17:09, Christoph Hellwig wrote:
> > On Sun, Jan 26, 2020 at 10:06:20AM +0000, Victor Gladkov wrote:
> > > On 1/15/2020 5:43 PM, Victor Gladkov wrote:
> > > > 1. Added multipath support for this patch.
> > > > 2. Small refactoring (according to the review)
> > >
> > > Anyone have any comments on the latest proposed patch?
> > 
> > Where is the latest patch?  I didn't see a repost.  To kick off a discussion
> > please just resent it, in proper patch format and with the proper style to make
> > reviewing it easier.
> 
> Patch updated for branch nvme/for-5.6

Christoph meant you should send a patch with a version bump in subject
(e.g. [PATCH v3]) and a proper patch header. No maintainer can pick this
patch up like you've posted (not without forcing them to do more work
than they should).

Some nits below.

> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index a0ec40a..fd8c7dd 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -15,6 +15,8 @@
>  #define NVMF_DEF_RECONNECT_DELAY	10
>  /* default to 600 seconds of reconnect attempts before giving up */
>  #define NVMF_DEF_CTRL_LOSS_TMO		600
> +/* default to 30 seconds of fail fast IO commands  */
> +#define NVMF_DEF_FAIL_FAST_TMO		0

Your comment says "default to 30 seconds" yet in practice 0 is used?

>  /*
>   * Define a host as seen by the target.  We allocate one at boot, but also
> @@ -56,6 +58,7 @@ enum {
>  	NVMF_OPT_NR_WRITE_QUEUES = 1 << 17,
>  	NVMF_OPT_NR_POLL_QUEUES = 1 << 18,
>  	NVMF_OPT_TOS		= 1 << 19,
> +	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
>  };
> 
>  /**
> @@ -89,6 +92,7 @@ enum {
>   * @nr_write_queues: number of queues for write I/O
>   * @nr_poll_queues: number of queues for polling I/O
>   * @tos: type of service
> + * @fast_fail_tmo_ns: Fast I/O fail timeout in nanoseconds;
>   */
>  struct nvmf_ctrl_options {
>  	unsigned		mask;
> @@ -111,6 +115,7 @@ struct nvmf_ctrl_options {
>  	unsigned int		nr_write_queues;
>  	unsigned int		nr_poll_queues;
>  	int			tos;
> +	unsigned int	fail_fast_tmo;
>  };

Above you document "@fast_fail_tmo_ns" but then add the member with name
"fail_fast_tmo".

>  /*
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 797c183..4edcaf1 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -281,9 +281,11 @@ static bool nvme_available_path(struct nvme_ns_head *head)
> 
>  	list_for_each_entry_rcu(ns, &head->list, siblings) {
>  		switch (ns->ctrl->state) {
> +		case NVME_CTRL_CONNECTING:
> +		    if(test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
> +				break;

James suggested this case order, when he did he included /* fallthru */,
it helps to have it where appropriate (like this case).

>  		case NVME_CTRL_LIVE:
>  		case NVME_CTRL_RESETTING:
> -		case NVME_CTRL_CONNECTING:
>  			/* fallthru */
>  			return true;
>  		default:
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1024fec..b6a199e 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -256,6 +256,7 @@ struct nvme_ctrl {
>  	struct work_struct scan_work;
>  	struct work_struct async_event_work;
>  	struct delayed_work ka_work;
> +	struct delayed_work failfast_work;
>  	struct nvme_command ka_cmd;
>  	struct work_struct fw_act_work;
>  	unsigned long events;
> @@ -289,6 +290,8 @@ struct nvme_ctrl {
>  	u16 icdoff;
>  	u16 maxcmd;
>  	int nr_reconnects;
> +	unsigned long flags;
> +#define NVME_CTRL_FAILFAST_EXPIRED	0
>  	struct nvmf_ctrl_options *opts;
> 
>  	struct page *discard_page;

Seems awkward to define bits for "flags" within the body of the struct;
but I'll defer to others' judgement.

Mike


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
