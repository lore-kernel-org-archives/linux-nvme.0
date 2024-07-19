Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD7CC3DA5D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 05:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DClR8S6zCP4i4lNEwC1ttqSf524z6Hli7Cj8pFRB1to=; b=VBx3L7waM4cwVK4LNUK9OtkC31
	cme8IvwZfqZ7n1BQZi7DzeFOAF+46UPmd+k55jCMYzuev379BQl+ZUhncJG+YYcAVTxUfkFohyScH
	NdOswEAw7STuq91+deCXIDRqH4hBi3UjP38STtmwiKUU7v1usbsqCKRFCy2sCPn7bx2PV0OhMjxHM
	nTtKH/rlLg6mknQ30PwfIb6KVF1aIlioxHOJ1ZEio8dCj//8AxTkBtrl6r/K/eYR/ghVM1PGqttAc
	s96IAp8+m78R50J045SmRu0I7xhhzTLyrtIS4xfrkDREwW4ZcjxZgIdwK6QU67379FxPm+9LsEmAw
	C3/TsLbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUgQ0-00000001fsk-0D98;
	Fri, 19 Jul 2024 05:44:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUgPw-00000001fs6-2wlT
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 05:44:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47C3168BFE; Fri, 19 Jul 2024 07:44:29 +0200 (CEST)
Date: Fri, 19 Jul 2024 07:44:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/8] nvme-sysfs: add 'tls_configured_key' sysfs
 attribute
Message-ID: <20240719054429.GA21679@lst.de>
References: <20240718144858.19074-1-hare@kernel.org> <20240718144858.19074-6-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718144858.19074-6-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_224432_910881_F5F497D7 
X-CRM114-Status: GOOD (  14.18  )
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

>  #ifdef CONFIG_NVME_TCP_TLS
>  	&dev_attr_tls_key.attr,
> +	&dev_attr_tls_configured_key.attr,
>  #endif
>  	&dev_attr_adm_passthru_err_log_enabled.attr,
>  	NULL
> @@ -741,6 +752,10 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
>  	if (a == &dev_attr_tls_key.attr &&
>  	    (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
>  		return 0;
> +	if (a == &dev_attr_tls_configured_key.attr &&
> +	    (!ctrl->opts || !ctrl->opts->tls_key ||
> +	     strcmp(ctrl->opts->transport, "tcp")))
> +		return 0;
>  #endif

The check for a specific transport hack was ok for a single attribute,
but it probably is time to have a separate attribute_group provided
by the transport now.  Or maybe wait until we get another one..

>  
>  	return a->mode;
> -- 
> 2.35.3
---end quoted text---

