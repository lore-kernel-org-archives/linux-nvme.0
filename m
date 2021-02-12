Return-Path: <SRS0=EAhk=HO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353E4C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 21:09:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F4B64E01
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 21:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F4B64E01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BGLpiI9bTiyKTgYszqE0Hlg+3Rw37WAxms4IqSBwpHU=; b=meKE/j1m1szVI1L6D6pFBkLF2
	RPgagrwujQmCaLp0zC1KuLSD02FtIgsTGt+OIrkaX6rMSD9eb+CO19hXVn6tTTXAeJBKFlkfqaXUO
	d29Je3rcViEmL/TDxlZKd9pY7AUMgAnDTZQ5h9T3zbh1kUxqpc/C9BpV+tLleLGUkdlcQj2M6DdL2
	UHqMasAIuQRsd9zQkQud3sgRZfskWSYh4nu75vVBJLrMG1mG0DZBP+0aXSIbp0rcNW5RxzZu+yDW7
	S1xW7yVlbzFObUR70On0DODj5dFSvjplB1RWb5LnEQ236pMeQm8MhUbR3hOl6LIIC3PxSCtd7+PNy
	55tKfwbqw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAfh6-0002OM-78; Fri, 12 Feb 2021 21:09:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAfh3-0002NS-D0
 for linux-nvme@lists.infradead.org; Fri, 12 Feb 2021 21:09:38 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03AC2601FF;
 Fri, 12 Feb 2021 21:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613164175;
 bh=N7rA3qpnhmgAC9fBXPMGsTbgAXD+uXqgcADbmEmU+fk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X9TCwDkmT1MOrBScgC8MjYopMkdsdvRZ8MlKH6FOphxn3fLA0gK/4nMeEbll+VE2V
 kIdooVHtYQQ+K+WKVb1bU8Ek7e3QjQH/m/kg0a4bfFnCxhKo+6W93WhE7BSgX/GweI
 hCRKk1iZXrLDEBvSO/bYdIP1Ehgs3cFHicqbp69QRN3H5aRLBUgoKvkljVdloURUHy
 TBoARgrNRtQQxgOcaQCyjQyMPAkvnReTX+9gyR2ezwrLr+1D+otTnRnezVBCPs5dxF
 sf3Iak7D8+D5nNvFwZnl8IuNGxcvK9dG6f1ACO3Sqqudq1BXIPPdNBsZ0scqdwImqd
 q1qZrcKf68Qow==
Date: Sat, 13 Feb 2021 06:09:29 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
Message-ID: <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
References: <20210212181738.79274-1-dwagner@suse.de>
 <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210212_160937_553712_DE5ADF78 
X-CRM114-Status: GOOD (  13.22  )
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
Cc: Daniel Wagner <dwagner@suse.de>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 12, 2021 at 12:58:27PM -0800, Sagi Grimberg wrote:
> > blk_mq_tag_to_rq() will always return a request if the command_id is
> > in the valid range. Check if the request has been started. If we
> > blindly process the request we might double complete a request which
> > can be fatal.
> 
> How did you get to this one? did the controller send a completion for
> a completed/bogus request?

If that is the case, then that must mean it's possible the driver could
have started the command id just before the bogus completion check. Data
iorruption, right?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
