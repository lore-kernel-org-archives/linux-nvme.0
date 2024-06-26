Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC1CC30653
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 09:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tdQ9fZhcrJ+7xcDCCpXg0hy2/6w1C7giB5mrC8R92Dg=; b=MZhQgcMFULNDmlqlsnkepxcd6h
	KBia+NPox8Rixs/Azstfyvghbf1CSZAAOGxhUzPnNpTkh4i+U1b70eEuM1i+dCf1B3NwbL1g9dOWO
	1823JDldRd9Y17x/VWXSrDldPjTZIEHDJg4CBPJYozorSVfEXP8bZ/IdIn26MX33QZHSvOqfiuI+c
	rHSveHItKP4LpbtPUS1+Ko7dUgFpooSPdc247KgRWeCgKJQIbCstFm71Rn8/HZ5TtN/lI3Ns4ECZl
	eOmcT0ROb6FKD9IAwDRO9/nPnJMjx/8+mbmo/zvpaUekcPcY5LCtIt1Ba047XkycRXZnRJ2smXtbK
	QImbOs2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMOvl-000000068lV-0FeI;
	Wed, 26 Jun 2024 09:27:09 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMOvf-000000068jg-3Tia
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 09:27:07 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46ACC21AB3;
	Wed, 26 Jun 2024 09:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719394018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdQ9fZhcrJ+7xcDCCpXg0hy2/6w1C7giB5mrC8R92Dg=;
	b=j0KfIxuK/lyh87i+02JWzfx1AExMWGBFUbO4hN6DykU9Up/BDh/IryokNHHGalccGcPD5u
	H24BM9EWPFYevp3u3WUaETeIK3JvxzXbl7mId3xrwtsu1YImF75HtQ7An5DckAl9EU3Sa2
	oNCaqn9Q+ns4H1sDEOMUGo1WDBFzvdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719394018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdQ9fZhcrJ+7xcDCCpXg0hy2/6w1C7giB5mrC8R92Dg=;
	b=G0k6n9c3pje799ayCUXWaoVxa/9zf9KubnTUE3qG9PrIU08M38H7YaH7atOyMsKb8Ap5Vx
	1p/FD3W8fF6BT8DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=j0KfIxuK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=G0k6n9c3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719394018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdQ9fZhcrJ+7xcDCCpXg0hy2/6w1C7giB5mrC8R92Dg=;
	b=j0KfIxuK/lyh87i+02JWzfx1AExMWGBFUbO4hN6DykU9Up/BDh/IryokNHHGalccGcPD5u
	H24BM9EWPFYevp3u3WUaETeIK3JvxzXbl7mId3xrwtsu1YImF75HtQ7An5DckAl9EU3Sa2
	oNCaqn9Q+ns4H1sDEOMUGo1WDBFzvdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719394018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdQ9fZhcrJ+7xcDCCpXg0hy2/6w1C7giB5mrC8R92Dg=;
	b=G0k6n9c3pje799ayCUXWaoVxa/9zf9KubnTUE3qG9PrIU08M38H7YaH7atOyMsKb8Ap5Vx
	1p/FD3W8fF6BT8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CE3613AAD;
	Wed, 26 Jun 2024 09:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G6n3CeLee2aycQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 26 Jun 2024 09:26:58 +0000
Date: Wed, 26 Jun 2024 11:26:53 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v1 2/2] nvme-fc: fix race with connectivity loss with
 nvme_fc_create_association
Message-ID: <52b6ws3otzilnc5g5hco2luwksfcqctbobgra5hsogpz7jp7am@t4oowjyy6av6>
References: <20240611190647.11856-1-dwagner@suse.de>
 <20240611190647.11856-3-dwagner@suse.de>
 <cdf73c47-ec71-4c8f-a127-891d7215bf4f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdf73c47-ec71-4c8f-a127-891d7215bf4f@grimberg.me>
X-Rspamd-Queue-Id: 46ACC21AB3
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_022704_137902_1816782F 
X-CRM114-Status: GOOD (  17.44  )
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

On Wed, Jun 26, 2024 at 11:28:33AM GMT, Sagi Grimberg wrote:
> > +static void nvme_fc_defer_reset_work(struct work_struct *work)
> > +{
> > +	struct nvme_fc_ctrl *ctrl =
> > +		container_of(work, struct nvme_fc_ctrl, fc_reset_work);
> > +
> > +	nvme_reset_ctrl(&ctrl->ctrl);
> > +}
> 
> I'm not entirely sure I understand what you're trying to solve here,
> but scheduling a work that in turn schedules a work looks bogus.

nvme_fc_ctrl_connectivity_loss is called from a interrupt context. If we
are in the connecting state we know that connect work job is still
executing. I figured we should wait until it has finished (see next
paragraph) and then issue an reset. If nvme_fc_ctrl_connectivity_loss
was called from normal context a flushed_delayed_work would do the
trick. The nvme_fc_defer_reset_work is queued/executed on the normal
nvme_wq thus the connecting work has finished.

The other idea I had was to issue the reset immediately and handle the
fallouts in the connect code path. But it turns out the connect path is
somewhat expecting errors and just ignores them on purpose and thus
still reaches the connected state.

I agree, it's dodgy but I haven't found any better solution so far. Any
good idea how to solve this are highly appreciated.

