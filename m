Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3DCC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 05:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KS00i+Lbt7eenxWaV8jMTu1rg+7OnnV0OTdxx1kzSaA=; b=TMH7rs8/D1TJ00pyCtrlf8I4OJ
	zW12ayrYxy6+wXo0Q5/UftCQTAxap8Mo4O1AGBXefSP63127Fi9Ty1yS9YFgElHrJ7yZWxjE3vbEw
	4HjonlteHGxmlBKKSHpmRgH95Wwc48Py4celJYTg0KcV+biiMM5JblgXATeMWJSr2w7IFOs69L1Xb
	xAsniDNuiCGWh8noieurAl+gDBmn7g1wA/Erx+cuOYLiIxDHpZYDqe67A4PF7Qp2ODIP758SUz3qF
	Ul4ONoqWyLSv3PJrNFtlFoDDyIoItm4s94m/4bYOWj3DjYrUyq9e/OO+vL00oBSXqsz27V0OcvnBP
	ehP9WvgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbc0f-00HBvz-7c; Tue, 05 Apr 2022 05:45:45 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbc0c-00HBuI-Bd
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 05:45:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B960068AFE; Tue,  5 Apr 2022 07:45:36 +0200 (CEST)
Date: Tue, 5 Apr 2022 07:45:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvmet: check for subsystem type in
 nvmet_find_get_subsys()
Message-ID: <20220405054536.GB23466@lst.de>
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317142634.49324-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_224542_581267_868D42DD 
X-CRM114-Status: GOOD (  24.24  )
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



On Thu, Mar 17, 2022 at 03:26:32PM +0100, Hannes Reinecke wrote:
> When looking for a subsystem we have two ways of finding the
> subsystem: either looking for the subsystem NQN itself, or check
> the type of the subsystem when looking for a discovery controller.
> This patch implements this check, and also moves the check for
> the static discovery controller to the end such that we can
> return unique discovery controllers.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/target/core.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index b0dc6230d1b9..83eba511d098 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1508,12 +1508,6 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
>  	if (!port)
>  		return NULL;
>  
> -	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
> -		if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
> -			return NULL;
> -		return nvmet_disc_subsys;
> -	}
> -
>  	down_read(&nvmet_config_sem);
>  	list_for_each_entry(p, &port->subsystems, entry) {
>  		if (!strncmp(p->subsys->subsysnqn, subsysnqn,
> @@ -1523,8 +1517,22 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
>  			up_read(&nvmet_config_sem);
>  			return p->subsys;
>  		}
> +		if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn) &&
> +		    nvmet_is_disc_subsys(p->subsys)) {

I don't get this.  The strcmp is on the passed in subqnen that we are
looking for.  So with this patch we now do the fairly expensive string
compare for every subsystem in the loop, and the just retuns the first
discovery subsystems when we look for the well known discovery
subsystem.  As-is there is only one, so this is pointless.  If we add
discovery subsystems with different names (as I assume the later patches
do), this changes beahvior in a rather unexpected way.

