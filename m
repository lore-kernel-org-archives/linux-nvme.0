Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BDAE77198
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 15:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ildMKudS4PeHxi4Ho7cfphgczFpTJU//d8xImDSBow8=; b=Snxqdc3lNSdtbJKhl53dwE/YnP
	wUzEoFddTpCU1h10dRFOYMntJXd2kmcmfR+uVBZNrGHtseX1ioiOISnz+6FUYHVnTozsiCCzDt59i
	8s31Rb6g0PcPj93y1eFtiR9/bT4T4jEWUT6d2J26lkgek0JFAGKHcsp5wSdojfUUQOX5cFfOy8xgz
	NVn98+3FMHG3OXi5Ncn1ylJpoK6euyGjiAK4BCBu9ipF6v1OhLo88EZRCS4cch8FxXhBStwNVa2Bl
	snDr6hua8HYsgL/+nMhvvWjJmpK8y/uwmvRGGd8SPadWb5pdmDnhvTIuKZDVTUPR2RgEyPcm5Hs42
	JCZGMNqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVBsC-00000005Vln-2cfM;
	Tue, 07 Jan 2025 15:52:04 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVAjG-00000005FWz-1n2x
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 14:38:50 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69B74210FA;
	Tue,  7 Jan 2025 14:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736260723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ildMKudS4PeHxi4Ho7cfphgczFpTJU//d8xImDSBow8=;
	b=QlgldocgQLpEMGfgit5wQWtIytIijphFYxX/dZFLZ9zhUAR5Ur8hI0AQpBZOK/E2oAw5/M
	t5pagqwc9hsFsuDdwjpSBKqX3IJdu/RT2P/GYME1+nhXImbEq4QTsA5+lJZa4NVQWBGLpB
	zCw8+wRIKkSWX8jQnGeQpGn/jnwDF5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736260723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ildMKudS4PeHxi4Ho7cfphgczFpTJU//d8xImDSBow8=;
	b=PH8vcV71F9uciAvWlFJSm9rJ9R3/ZBCF6f8U93Js5ghc/V8+BW1Bz8GLDMomUG1PeqGg3R
	8L1w5vHBK7ZfAWAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736260723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ildMKudS4PeHxi4Ho7cfphgczFpTJU//d8xImDSBow8=;
	b=QlgldocgQLpEMGfgit5wQWtIytIijphFYxX/dZFLZ9zhUAR5Ur8hI0AQpBZOK/E2oAw5/M
	t5pagqwc9hsFsuDdwjpSBKqX3IJdu/RT2P/GYME1+nhXImbEq4QTsA5+lJZa4NVQWBGLpB
	zCw8+wRIKkSWX8jQnGeQpGn/jnwDF5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736260723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ildMKudS4PeHxi4Ho7cfphgczFpTJU//d8xImDSBow8=;
	b=PH8vcV71F9uciAvWlFJSm9rJ9R3/ZBCF6f8U93Js5ghc/V8+BW1Bz8GLDMomUG1PeqGg3R
	8L1w5vHBK7ZfAWAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5823013763;
	Tue,  7 Jan 2025 14:38:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7dKBFXM8fWeZOgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 07 Jan 2025 14:38:43 +0000
Date: Tue, 7 Jan 2025 15:38:38 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] nvme: trigger reset when keep alive fails
Message-ID: <693187ac-9fe2-4ba3-8fcf-e34204fe7247@flourine.local>
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
 <20241129-nvme-fc-handle-com-lost-v3-2-d8967b3cae54@kernel.org>
 <a8c476ee-e639-4886-a2dd-6e7d08060fa2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8c476ee-e639-4886-a2dd-6e7d08060fa2@grimberg.me>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_063846_611675_315C7FD7 
X-CRM114-Status: GOOD (  24.49  )
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

On Tue, Dec 24, 2024 at 12:31:35PM +0200, Sagi Grimberg wrote:
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index bfd71511c85f8b1a9508c6ea062475ff51bf27fe..2a07c2c540b26c8cbe886711abaf6f0afbe6c4df 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1320,6 +1320,12 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
> >   		dev_err(ctrl->device,
> >   			"failed nvme_keep_alive_end_io error=%d\n",
> >   				status);
> > +		/*
> > +		 * The driver reports that we lost the connection,
> > +		 * trigger a recovery.
> > +		 */
> > +		if (status == BLK_STS_TRANSPORT)
> > +			nvme_reset_ctrl(ctrl);
> >   		return RQ_END_IO_NONE;
> >   	}
> > 
> 
> A lengthy explanation that results in nvme core behavior that assumes a very
> specific driver behavior.

I tried to explain exactly what's going on, so we can discuss possible
solutions without communicating past each other.

In the meantime I started on a patch set for the TP4129 related changes
in the spec (KATO Corrections and Clarifications). These changes would
also depend on the kato timeout handler triggering a reset.

I am fine with dropping this change for now and discuss it in the light
of TP4129 if this is what you prefer?

> Isn't the root of the problem that FC is willing to live
> peacefully with a controller
> without any queues/connectivity to it without periodically reconnecting?

The root problem is that the connect lost event gets ignored in the
CONNECTING state for the first connection attempt. All will work fine
for RECONNECTING state.

Maybe something like this instead? (untested)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index c4cbe3ce81f7..1f1d1d62a978 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -148,6 +148,7 @@ struct nvme_fc_rport {
 #define ASSOC_ACTIVE		0
 #define ASSOC_FAILED		1
 #define FCCTRL_TERMIO		2
+#define CONNECTIVITY_LOST	3

 struct nvme_fc_ctrl {
 	spinlock_t		lock;
@@ -785,6 +786,8 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 		"NVME-FC{%d}: controller connectivity lost. Awaiting "
 		"Reconnect", ctrl->cnum);

+	set_bit(CONNECTIVITY_LOST, &ctrl->flags);
+
 	switch (nvme_ctrl_state(&ctrl->ctrl)) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_LIVE:
@@ -3071,6 +3074,8 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	if (nvme_fc_ctlr_active_on_rport(ctrl))
 		return -ENOTUNIQ;

+	clear_bit(CONNECTIVITY_LOST, &ctrl->flags);
+
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: create association : host wwpn 0x%016llx "
 		" rport wwpn 0x%016llx: NQN \"%s\"\n",
@@ -3174,6 +3179,11 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)

 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);

+	if (test_bit(CONNECTIVITY_LOST, &ctrl->flags)) {
+		ret = -EIO;
+		goto out_term_aeo_ops;
+	}
+
 	ctrl->ctrl.nr_reconnects = 0;

 	if (changed)

