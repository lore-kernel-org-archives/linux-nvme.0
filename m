Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB31FF8861
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 09:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QhugfmNL0pqaCL8rS9UPnPsygSrJtiIUMw3OjMc/jpc=; b=nlwrJdXOgIdgMwW/KZ9lv0DRUE
	P5wlM8cIVzbPiKrsjDq2jmJqy1/TB/dMah+wcFaPVSCbls2iuWKvs99Vj2zY/5CtJa4QrY234uaWS
	MfCl9oMpRtfY+6Dm+Rl+5uOBlJ6BJGd/iNJ8Q+TRKsw6f50w5z700SkUooyTgJYxUuz9NEXxj2UmK
	jMygjuyULsDDND9nYxMixwC9YBfa6VBm4FrDwALKWh9Y4oitOZ8Md0+7LcCF1ENm6rrwWKi5rrspg
	G/EFICFUAPjZ3v6n/I1QKLFE0pdlplWBDYI5F18XnD02iLasBTxW3rmX+RDSQTyac757rw/yAENtj
	p/cnmVVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHIN2-0000000GbFO-01Iv;
	Mon, 27 Apr 2026 09:35:16 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHIN0-0000000GbEy-0nZX
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 09:35:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45C296A819;
	Mon, 27 Apr 2026 09:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777282511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhugfmNL0pqaCL8rS9UPnPsygSrJtiIUMw3OjMc/jpc=;
	b=tXJedjjmll26ANkJpB4YFjYAP0YXImsk1UH1wYGPa0vIVCY7fEqnBNWBThJMvZURQcnEuY
	1lgz+SiXzf2erb9/2IW5k2MNOnjX/DcJPhPzowPDLAREWkRZpHRhS6DEZd6KqT0oA6Pco3
	q8n6xnZZPd1w9m495QkHJugf0HN8BHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777282511;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhugfmNL0pqaCL8rS9UPnPsygSrJtiIUMw3OjMc/jpc=;
	b=vEQOY65b22I5Ssn06ebWQbcQmVurHWUnbUnFtDmLUsbSLeVSZp7hWWaPuMROyA2rMZtXre
	I0PMIiRNyckaQjDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tXJedjjm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vEQOY65b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777282511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhugfmNL0pqaCL8rS9UPnPsygSrJtiIUMw3OjMc/jpc=;
	b=tXJedjjmll26ANkJpB4YFjYAP0YXImsk1UH1wYGPa0vIVCY7fEqnBNWBThJMvZURQcnEuY
	1lgz+SiXzf2erb9/2IW5k2MNOnjX/DcJPhPzowPDLAREWkRZpHRhS6DEZd6KqT0oA6Pco3
	q8n6xnZZPd1w9m495QkHJugf0HN8BHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777282511;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhugfmNL0pqaCL8rS9UPnPsygSrJtiIUMw3OjMc/jpc=;
	b=vEQOY65b22I5Ssn06ebWQbcQmVurHWUnbUnFtDmLUsbSLeVSZp7hWWaPuMROyA2rMZtXre
	I0PMIiRNyckaQjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FA25593B0;
	Mon, 27 Apr 2026 09:35:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tQtwCs8t72nGXgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 Apr 2026 09:35:11 +0000
Date: Mon, 27 Apr 2026 11:35:10 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com, 
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org, mlombard@arkamax.eu, 
	mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V3 6/8] nvme-core: align fabrics_q teardown with admin_q
 in nvme_free_ctrl
Message-ID: <2341c607-1b46-480d-a8bc-7620b881cd34@flourine.local>
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-7-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410073924.61078-7-mlombard@redhat.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 45C296A819
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_023514_397646_E4D7DAC7 
X-CRM114-Status: UNSURE (   8.84  )
X-CRM114-Notice: Please train this message.
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

On Fri, Apr 10, 2026 at 09:39:22AM +0200, Maurizio Lombardi wrote:
> Currently, the final reference for the fabrics admin queue (fabrics_q)
> is dropped inside nvme_remove_admin_tag_set(). However, the primary
> admin queue (admin_q) defers dropping its final reference until
> nvme_free_ctrl().
> 
> Move the blk_put_queue() call for fabrics_q from nvme_remove_admin_tag_set()
> to nvme_free_ctrl(). This aligns the lifecycle management of both admin
> queues, ensuring they are freed symmetrically when the controller is finally
> torn down.

Looks good to me.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

