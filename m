Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF605C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 16:45:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8556A64D9A
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 16:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8556A64D9A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AZClM/pw1cb8QVtT7ARxXnMrMCTzDAdCQlApWFu6YDU=; b=zgkYS2L9etamMLfU9WVkjREkS
	2ATo6yHtLG8gmzwR7n6xHo8Kf/Osseiw/R/6xY5ZByzfhQ8kn+KHZF+F/bLBSCNc/Hy+fhJZbmghk
	CmCJnuJuaC1a47US3VB/1Gg6K2qEySF5CQmw4TBNLL4TUwfFfodpIzD6TvjcKv5ifZtf31H4mO7Fn
	iQVjmsxcGkK7Sg/e4QNwRtUiacaHvpkuM4wVrMN//LCFVA4ltxJVYTkTUq5UhpPvN2JJVXMTkd98R
	pMcrZ2CnxXk60yLPmixyOQNANfeOYgGYC6gtPSIvfw9F4ezlLsqjYrNHch96u1hAdljeQP20ltvzA
	Y6e0KLrqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lExHz-0005od-91; Wed, 24 Feb 2021 16:45:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lExHx-0005oA-Fs
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 16:45:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DD25468AFE; Wed, 24 Feb 2021 17:45:23 +0100 (CET)
Date: Wed, 24 Feb 2021 17:45:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: javier@javigon.com
Subject: Re: [PATCH V5 2/2] nvme: allow open for nvme-generic char device
Message-ID: <20210224164523.GB11338@lst.de>
References: <20210222190107.8479-1-javier.gonz@samsung.com>
 <20210222190107.8479-3-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210222190107.8479-3-javier.gonz@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_114525_675552_77869506 
X-CRM114-Status: UNSURE (   9.55  )
X-CRM114-Notice: Please train this message.
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, minwoo.im.dev@gmail.com, kbusch@kernel.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 22, 2021 at 08:01:07PM +0100, javier@javigon.com wrote:
> @@ -1885,7 +1885,7 @@ static int nvme_ns_open(struct nvme_ns *ns)
>  {
>  #ifdef CONFIG_NVME_MULTIPATH
>  	/* should never be called due to GENHD_FL_HIDDEN */
> -	if (WARN_ON_ONCE(ns->head->disk))
> +	if (WARN_ON_ONCE(!nvme_ns_is_generic(ns) && ns->head->disk))
>  		goto fail;

Maybe just move the check into the block device caller instead?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
