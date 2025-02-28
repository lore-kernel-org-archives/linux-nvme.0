Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C646C19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 08:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h60l+rmxIm+Odu0LGaD3tkJXLpfS0xRKP/H1pgU79QU=; b=WWfZXlTvhTPzQeawwUazF+LJKk
	7/PTqb9I/JQiXsSF3LOpiqOUtCVAiOunGJVOW55z+Bh8uiNY6iwlyU0v8GEPOgHgtWYsRbaN6eUk+
	be3czUrhtpQtBvsWvtmqZLGk246eg1mwEM8577jL0B1B9p/55zt5UKT5vU+r/t8iOa1ZK04AOCEnm
	AKWw6neYhEiiTpJfQ33/Sj297ZQSnb1n0C+N/HnfIzpds0vFGDOdCrFQZxlMEcoUmeKyb3Rl9SiL4
	l/g4tGt4YFySu28v/z+yDTXb4boi07tpdVe+seBB3A0/e27WBi5mdK9Wm5hZq/TMjt0Wke8bfuqoM
	oic1oDKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnvzg-0000000AERZ-3z3n;
	Fri, 28 Feb 2025 08:45:16 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnvze-0000000AEQm-1k56
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 08:45:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D9021F38F;
	Fri, 28 Feb 2025 08:45:13 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F26A813888;
	Fri, 28 Feb 2025 08:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id swBhOph3wWe7PwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 28 Feb 2025 08:45:12 +0000
Date: Fri, 28 Feb 2025 09:45:12 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] nvmet-fc: take tgtport reference only once
Message-ID: <7ab71df0-e9e8-4035-a215-f5259c69fe88@flourine.local>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-8-c0bd83d43e6a@kernel.org>
 <f944fdb3-081f-474a-9193-f482fe87f72b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f944fdb3-081f-474a-9193-f482fe87f72b@suse.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 0D9021F38F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_004514_598954_B7242B9C 
X-CRM114-Status: GOOD (  18.55  )
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

On Fri, Feb 28, 2025 at 08:34:51AM +0100, Hannes Reinecke wrote:
> On 2/26/25 19:46, Daniel Wagner wrote:
> > The reference counting code can be simplified. Instead taking a tgtport
> > refrerence at the beginning of nvmet_fc_alloc_hostport and put it back
> > if not a new hostport object is allocated, only take it when a new
> > hostport object is allocated.
> > 
> Can it really?
> Main point of this operation is that 'tgtport' isn't going away during while
> we're figuring out whether we need it.
> 
> With this patch it means that

The tgtport is not going away. nvmet_fc_alloc_hostport can only be
called with reference on tgtport being hold:

nvmet_fc_rcv_ls_req
  nvmet_fc_tgtport_get(tgtport)
  nvmet_fc_handle_ls_rqst_work
    nvmet_fc_handle_ls_rqst
      nvmet_fc_ls_create_association
        nvmet_fc_alloc_target_assoc
          nvmet_fc_alloc_hostport

The goal with this patch here is to make it simpler to read where we
take a ref. IMO, there is not really anything gained by the existing
logic, though I agree it's not obvious that the tgtport is not going
away. Would it be okay to add a comment?

