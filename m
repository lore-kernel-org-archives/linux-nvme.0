Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A281AC624D0
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 10:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8VYt+Swf7f2JxKTrpup+hGsy7FUyoTXOh650Q22FDNU=; b=QkmspRQwSiU5QU3u+MN9hxqF0r
	ZFUP+dQGlx8brLmKtX4CRvg1JCZnjldgZM8xBD2ddGnl6f29uA+q8dDzVekXgj1aA2RorwJT/iXEC
	qwadPLtsilmcj9PdsK7cnoqFv86aXMRgbdQpH1Eemn9siw13YrPmCi44dibsxhVPylpKa6RR0Z7GV
	OzSI5XBXXODDZNjE7HQdRVV7UitmQZKWaQtop0RDt+1iHxtRIC/vzNnMZ+04RsxmtdU/tu+628K5z
	73oRFK26NZEd07apnj/U0XvTle4XSZ6zCw7ZNDr9CvM0PkeFOLpImiOnDyZ6/93aIF9n69s6cfkoP
	K2nW1BoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1iSn-0000000EO1T-1NIv;
	Wed, 02 Sep 2026 10:45:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1iSl-0000000EO0s-0V3A
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 10:45:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1AFF68BEB; Wed,  2 Sep 2026 12:44:57 +0200 (CEST)
Date: Wed, 2 Sep 2026 12:44:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: raoxu <raoxu@uniontech.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH nvme-7.3 3/4] nvme-fabrics: add helpers for subsystem
 and host identity options
Message-ID: <20260902104456.GD8206@lst.de>
References: <29BB44C32FF06823+20260821062142.1932160-1-raoxu@uniontech.com> <450E21059686C852+20260821062529.1936914-1-raoxu@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450E21059686C852+20260821062529.1936914-1-raoxu@uniontech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_034503_308302_5F4A0DE8 
X-CRM114-Status: GOOD (  15.43  )
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

On Fri, Aug 21, 2026 at 02:25:28PM +0800, raoxu wrote:
> +static int nvmf_parse_subsysnqn(struct nvmf_ctrl_options *opts, substring_t *args)
> +{
> +	char *nqn;
> +
> +	nqn = match_strdup(args);
> +	if (!nqn)
> +		return -ENOMEM;
> +
> +	kfree(opts->subsysnqn);
> +	opts->subsysnqn = nqn;
> +	if (strlen(opts->subsysnqn) >= NVMF_NQN_SIZE) {
> +		pr_err("%s needs to be < %d bytes\n",
> +		       opts->subsysnqn, NVMF_NQN_SIZE);
> +		return -EINVAL;
> +	}

I think we should only update opts->subsysnqn after the sanity check. The
current code doesn't do that, but we should use the chance to fix that
up as well.

> +	nqn = match_strdup(args);
> +	if (!nqn)
> +		return -ENOMEM;
> +
> +	if (strlen(nqn) >= NVMF_NQN_SIZE) {
> +		pr_err("%s needs to be < %d bytes\n", nqn, NVMF_NQN_SIZE);
> +		kfree(nqn);
> +		return -EINVAL;
> +	}
> +
> +	strscpy(hostnqn, nqn, NVMF_NQN_SIZE);
> +	kfree(nqn);

This already gets is right.  Also does anyone rememeber why we handled
the host vs subsys NQN so differently?


