Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C085C369DC
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 16:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dGFevV1XuXxal2xhv+HitVmJiBMaC4glTQ70ybBHFbg=; b=W+cLXksx+wXW9gtD75qaCdLEsZ
	gePX6n/7sd8PHPDrUZkoqVPKulMorHGK5Ir0zojoA40Lek1ZF8M7de3Fu7oPBa/gBCGnfglZasE7c
	0O9Hc79qEmI3llbYJZynPL/BnaT4UxVcDtnkXreIMpN5omfUC5GKqDaVYOHDRwXbN6IXjSRX6HFNo
	HLr0fa3lXAZ3chOlLy4aXlQuhilsI8mya4WJ1nYnaJZwbaHmn3XuMAO1N9hn1rYpCiHUiOzY5AKgm
	v9iiU1/nkmWJyD/0DiZ50iAZVCfootUAi/N/tbQjIPY+nPyysWYxEkweujiZieBXwFhDP47ZXqnI3
	KW4vBHog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7z31-0000000EZiC-3v3H;
	Thu, 24 Apr 2025 16:03:35 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7unb-0000000DreQ-2leg
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 11:31:24 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E7FF1F452;
	Thu, 24 Apr 2025 11:31:22 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 319421393C;
	Thu, 24 Apr 2025 11:31:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PQi1CQohCmgwPQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 24 Apr 2025 11:31:22 +0000
Date: Thu, 24 Apr 2025 13:31:13 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/14] nvmet-fcloop: access fcpreq only when holding
 reqlock
Message-ID: <c86e1da9-0525-4b4a-a32e-03d60f78d8fb@flourine.local>
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
 <20250423-nvmet-fcloop-v5-7-3d7f968728a5@kernel.org>
 <9444ac93-b0f7-4198-ad0f-d8c950b5d0ec@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9444ac93-b0f7-4198-ad0f-d8c950b5d0ec@suse.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 4E7FF1F452
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_043123_837529_F0543711 
X-CRM114-Status: GOOD (  12.34  )
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

On Thu, Apr 24, 2025 at 12:15:20PM +0200, Hannes Reinecke wrote:
> > @@ -663,9 +667,10 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
> >   	unsigned long flags;
> >   	spin_lock_irqsave(&tfcp_req->reqlock, flags);
> > -	fcpreq = tfcp_req->fcpreq;
> >   	switch (tfcp_req->inistate) {
> >   	case INI_IO_ABORTED:
> > +		fcpreq = tfcp_req->fcpreq;
> > +		tfcp_req->fcpreq = NULL;
> >   		break;
> >   	case INI_IO_COMPLETED:
> >   		completed = true;
> > @@ -688,10 +693,6 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
> >   		nvmet_fc_rcv_fcp_abort(tfcp_req->tport->targetport,
> >   					&tfcp_req->tgt_fcp_req);
> > -	spin_lock_irqsave(&tfcp_req->reqlock, flags);
> > -	tfcp_req->fcpreq = NULL;
> > -	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
> > -
> What happens for INI_IO_COMPLETED?

The request was completed before the abort handler was running. Thus
nothing to do here.

> Don't we need to clear the 'fcpreq' pointer in that case, too?

The normal code path has already taken care of this request and the only
thing left to do is to give back the refcount on the tfcp_req to free
the memory.

