Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16876F99C79
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Apr 2026 11:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pJ5pOiV3uVbrwJIxnnvzTrlyc9egBQkFtQd756B21gY=; b=japlrZRrecXLKU7neh+xMISM2Z
	/miQdHaqCx9Ag1x+1M/NQV2CEG7xpxhzreiVMztr0jsSwt+2iHz6iBAzVryPWPPGjow9Szc1fLChT
	MAzTMRv1cGGOOmBMMBqFpJzeWHw0cnQnkXTkGdutuXxTRnnncguHCPQeL94yIuUNLL+4iSDCmatO6
	/o6husgNbGEgUCVX6e7tKj8/ZBtZ6EbTJC+TtPWNJgwJzqE7hYbdSUGHQpfBKXGTuxsOHkf7tI2vr
	OyRjRR81obD3afrZmSZjH58YFhCWjC0sT6yx1MsaVTuk+Md40r+TidI8N4FN8rroGtkPBLn7TI55+
	sTJTMobw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE44l-00000004xFX-1WpU;
	Sat, 18 Apr 2026 11:43:03 +0000
Received: from out-172.mta1.migadu.com ([95.215.58.172])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE44i-00000004xF6-1sJm
	for linux-nvme@lists.infradead.org;
	Sat, 18 Apr 2026 11:43:01 +0000
Date: Sat, 18 Apr 2026 13:42:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776512577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pJ5pOiV3uVbrwJIxnnvzTrlyc9egBQkFtQd756B21gY=;
	b=CDAgTTSmQsTHUAWzdEUMgIE7TbVCPONiZhpyuG4j9WbItNQtxW/b4JIArBSCRXQg/BoCtN
	42dzAi0IZI4AUDbtM6hFJ3PoYL7rs4/MurPcwOrSgb2y0VVfrn+6q01GoI/gqNHaox5ubu
	94vqGUyQKGNkkO84XgdO2EP/JYL7VsA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nvmet-auth: Don't log DHCHAP keys in
 nvmet_setup_auth()
Message-ID: <aeNuNq8diftLnhUs@linux.dev>
References: <20260303190350.78705-2-thorsten.blum@linux.dev>
 <20260303190350.78705-4-thorsten.blum@linux.dev>
 <2b40f93f-f987-423d-8263-ba9b10a1bcaf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b40f93f-f987-423d-8263-ba9b10a1bcaf@suse.de>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_044300_675772_6D2DCC46 
X-CRM114-Status: GOOD (  21.56  )
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

On Wed, Mar 04, 2026 at 08:19:59AM +0100, Hannes Reinecke wrote:
> On 3/3/26 20:03, Thorsten Blum wrote:
> > When debug logging is enabled, nvmet_setup_auth() logs the host and
> > controller DHCHAP key bytes. Remove the keys from debug logs to avoid
> > exposing key material.
> > 
> > Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >   drivers/nvme/target/auth.c | 10 ++++------
> >   1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> > index 2eadeb7e06f2..f24add0bb86f 100644
> > --- a/drivers/nvme/target/auth.c
> > +++ b/drivers/nvme/target/auth.c
> > @@ -199,10 +199,9 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
> >   		ctrl->host_key = NULL;
> >   		goto out_free_hash;
> >   	}
> > -	pr_debug("%s: using hash %s key %*ph\n", __func__,
> > +	pr_debug("%s: using hash %s\n", __func__,
> >   		 ctrl->host_key->hash > 0 ?
> > -		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none",
> > -		 (int)ctrl->host_key->len, ctrl->host_key->key);
> > +		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none");
> >   	nvme_auth_free_key(ctrl->ctrl_key);
> >   	if (!host->dhchap_ctrl_secret) {
> > @@ -217,10 +216,9 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
> >   		ctrl->ctrl_key = NULL;
> >   		goto out_free_hash;
> >   	}
> > -	pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
> > +	pr_debug("%s: using ctrl hash %s\n", __func__,
> >   		 ctrl->ctrl_key->hash > 0 ?
> > -		 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none",
> > -		 (int)ctrl->ctrl_key->len, ctrl->ctrl_key->key);
> > +		 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none");
> >   out_free_hash:
> >   	if (ret) {
> 
> Without the key the pr_debug calls are pretty much pointless anyway,
> so you might want to remove them, too.
> 
> However, these debug prints really help when trying to figure out
> authentication failures.
> I think it would be better to add a compile-time option to disable
> these outputs entirely.
> 
> I'll send a patch.

Did you ever send a patch? I couldn't find anything.  The code hasn't
changed either and the keys are still logged (same for patch 3/3).

Thanks,
Thorsten

