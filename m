Return-Path: <SRS0=5LEM=CT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85033C2BB84
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 05:26:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE51207FB
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 05:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iYr0bdly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE51207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UF1haUChl3oXqPNhFTLUXa6/8vU53d/3tA6NTqJtv6U=; b=iYr0bdlyyTP0WqIrYlXyLgjgE
	it7QxebRKM7M3wmw90NmHxQshKarkQpiEX7YAe9ev9NhWwR9FGvSlHx4iI0nXmi0DUYZP92gojssB
	BsAvlBJlxLvVVK5TvkhsyxWNj4YiUdNYlWm5VD8F4SiQYjaGi/bYFJooPhisqcmPRTJFjP1mD587k
	jOP3c+fc/1ha//FV/ZbHWOwnJVF9oBXZuA3VybYhKYl3wr2roqW8O5c26EHr2IIGshvabZZ4YJj0J
	XPTkdiinBQFc6CBuCM4OkGetDASdf56mp4jo3j6f1TrpJsXhT47ZqQCIufK5FGMPpoESOz0THWThy
	m2/wn7u+Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGF6g-0003zJ-2q; Thu, 10 Sep 2020 05:26:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGF6c-0003y9-Kr
 for linux-nvme@lists.infradead.org; Thu, 10 Sep 2020 05:26:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D7CB268B02; Thu, 10 Sep 2020 07:26:43 +0200 (CEST)
Date: Thu, 10 Sep 2020 07:26:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: translate zns errors to blk_status_t
Message-ID: <20200910052643.GA18283@lst.de>
References: <20200909203324.3356679-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200909203324.3356679-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200910_012646_797830_E3A322AB 
X-CRM114-Status: GOOD (  15.58  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 09, 2020 at 01:33:24PM -0700, Keith Busch wrote:
> EBUSY is the appropriate errno for commands that complete with zone
> resource errors.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ea1fa41fbba8..aff556837115 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -249,6 +249,9 @@ static blk_status_t nvme_error_status(u16 status)
>  		return BLK_STS_NEXUS;
>  	case NVME_SC_HOST_PATH_ERROR:
>  		return BLK_STS_TRANSPORT;
> +	case NVME_SC_ZONE_TOO_MANY_ACTIVE:
> +	case NVME_SC_ZONE_TOO_MANY_OPEN:
> +		return BLK_STS_DEV_RESOURCE;

I'm not sure this is the best idea, we probably need specific error codes
if we want file systems to be aware of the limit.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
