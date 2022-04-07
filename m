Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94510C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IrH9QKkBYO2sku5/sXyHjQuiGiQ0Kahamo2yN6MIlDc=; b=UPDt+8h8m8ndyuBo92Web1nERU
	FWUMDlULfsm5x+ze0+dB0ZJnVvZia+RTGVUlESCt8jxeFnZ62B96HkETvSWeTgru4QtbgasWA/fB4
	fZbxHLZaNQLyxSQXzmsjTR1E2noDDda9mZnLdsc4bcZg/PNYJNXEBmQBSVeMXzq+Z9XKBvtyoQesX
	lnC1kE/wMQdJPtEHSnj3ugcq35Rtwz1Qa6YRnIDqczt4HZNL8d0rsSIfW1auQz8UO92uB7Ud/g/0K
	3eIw6tVTRMPBNiCrnmN1qOI6TgJVVAPFPzxmLQPJhn+mIRSRAJAAqXPl6Byavo7GsvntZQd7kAhEa
	POJ/JclQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncUeo-00CwLl-Tu; Thu, 07 Apr 2022 16:06:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncUJ3-00CmfN-Cy
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 15:44:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B026368AFE; Thu,  7 Apr 2022 17:44:17 +0200 (CEST)
Date: Thu, 7 Apr 2022 17:44:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvmet: make the subsystem type configurable
Message-ID: <20220407154417.GC15988@lst.de>
References: <20220407104808.29007-1-hare@suse.de>
 <20220407104808.29007-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407104808.29007-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_084421_619179_501F4EAE 
X-CRM114-Status: GOOD (  19.57  )
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

On Thu, Apr 07, 2022 at 12:48:06PM +0200, Hannes Reinecke wrote:
> +static ssize_t nvmet_subsys_attr_type_store(struct config_item *item,
> +					    const char *page, size_t count)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +	struct nvmet_port *p;
> +	struct nvmet_subsys_link *s;
> +	int i;
> +
> +	if (subsys->subsys_discovered)
> +		return -EACCES;
> +
> +	/*
> +	 * Do not allow to change the subsystem type if it's
> +	 * already linked to ports; the user should unlink it first.
> +	 */
> +	down_read(&nvmet_config_sem);
> +	list_for_each_entry(p, &nvmet_ports_list, global_entry) {
> +		list_for_each_entry(s, &p->subsystems, entry) {
> +			if (s->subsys == subsys) {
> +				up_read(&nvmet_config_sem);
> +				return -EACCES;
> +			}
> +		}
> +	}
> +	up_read(&nvmet_config_sem);

Does this scale?  Do we want a flag in the subsystem instead?

> +	for (i = 0; i < ARRAY_SIZE(nvmet_subsys_type_map); i++) {
> +		if (sysfs_streq(page, nvmet_subsys_type_map[i].name))
> +			goto found;
> +	}
> +
> +	pr_err("Invalid value '%s' for subsystem type\n", page);
> +	return -EINVAL;
> +
> +found:
> +	down_write(&nvmet_config_sem);
> +	if (nvmet_subsys_type_map[i].type == NVME_NQN_CURR) {
> +		if (!xa_empty(&subsys->namespaces)) {
> +			pr_err("discovery subsystem cannot have namespaces\n");
> +			return -EINVAL;
> +		}
> +	}

We can probably just check this unconditionally, as something that was
a discovery subsystem before by definition can't have namespaces.

