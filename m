Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7DAC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 16:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=we2/YqKgvYSpEuTpt8VykcZhZfNa6w15BIr7Hv57F8A=; b=eYpSiCaajeB9W/ZmuYosbk+EZ8
	1CqI0idba7GZAktc6mnLT9mVtpdgrck0PueIMiWFqdy7RDw9OexjYFnHP1/FvOq9WwOoThCpkFNBH
	+/76xazwXf/LgGePknr9l+qyLbOTQ/t2pnXwj/1CC9dLConb9Bs5I1Ac5lmxG0Cqq4LRHrioMq24K
	pOeo5Lm4kGa0MOiTV0rIwG3FLeTHhxEWxhTbG890ele93aYsAc9oCo2dMzzsq0/vMVr2u942nWR1j
	iKJv8L0dN6TY0s+g14K3rT69PbrskLcqytT5wSiHnLnZFaNvWiFR6jjwQSLmosalPD0iH/Q4YvzzU
	e2BwCh+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncUxo-00D3FS-Q8; Thu, 07 Apr 2022 16:26:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncUO0-00Coj9-QT
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 15:49:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BDEB568AFE; Thu,  7 Apr 2022 17:49:24 +0200 (CEST)
Date: Thu, 7 Apr 2022 17:49:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvmet: per-port discovery subsystem
Message-ID: <20220407154924.GD15988@lst.de>
References: <20220407104808.29007-1-hare@suse.de>
 <20220407104808.29007-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407104808.29007-3-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_084929_064403_B20DC0EA 
X-CRM114-Status: GOOD (  20.22  )
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

On Thu, Apr 07, 2022 at 12:48:07PM +0200, Hannes Reinecke wrote:
> Add a 'disc_subsys' pointer to each port to specify which discovery
> subsystem to use.
> The pointer is set when a discovery subsystem is linked into a port,
> and reset to the original, built-in discovery subsystem if that link
> is removed.

This doesn't really make much sense stanadlone without the next
patch, so I'd be tempted to say they should be merged.

>  	down_write(&nvmet_config_sem);
> +	if (subsys->type == NVME_NQN_CURR &&
> +	    port->disc_subsys != nvmet_disc_subsys) {

Curious, would NULL not be a better encoding for the default discovery
subsystem?

> +++ b/drivers/nvme/target/core.c
> @@ -1496,9 +1496,9 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
>  		return NULL;
>  
>  	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
> -		if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
> -			return NULL;
> -		return nvmet_disc_subsys;
> +		if (!kref_get_unless_zero(&port->disc_subsys->ref))
> +				return NULL;
> +		return port->disc_subsys;

This has an extra tab indent.  But: should we even redirect from the
well known discovery NQN for a configured discovery subsystem here?
If yes at least this needs a big fat comment explaining why we do it.

> +	if (req->port->disc_subsys == nvmet_disc_subsys)
> +		entries++;

> +	if (req->port->disc_subsys == nvmet_disc_subsys) {
> +		nvmet_format_discovery_entry(hdr, req->port,
> +				nvmet_disc_subsys->subsysnqn,
> +				traddr, NVME_NQN_CURR, numrec);
> +		numrec++;
> +	}

Why don't we report the current discovery subsystem for if it isn't
the well known one?

