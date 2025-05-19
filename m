Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F299C2D0CD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 06:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mcJE8Fh4sSyxsHiW5v4FxwqAmHJwqBEG/dlbQaPTyiI=; b=piWdP3Ij+6Qx+3Rwtdv3ouRSvt
	J3AFjneRqqU/XFZ1QxpNv6Iioj0et7JzPW66/P43SYD8EaMfQt5FHpDItazIdrpD881EesOw+KxiR
	uMXEfz0yx6bPuLJ0EVCFhfTYL0c4CTIT+i5CG2mt6+vLQ7J5ZGJMnkbP5F3GmtQmgkiQTy5yLvLko
	1sCdhrnXR5tDp2SV9eJjKKADj12zbN42py8gjlzpGXwR9yRvDplIfy4O36G361MFTDXphHemCwun0
	nMXZoAF8jbHd9KwC0ghKSWEGuNkuNbi6E+iJ+Y3SkOfrfh13+R/+WlJyG8LM/wZyw75JmLoVjCDOc
	O7yQJaAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGuH9-000000088mE-0AvG;
	Mon, 19 May 2025 06:47:03 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGuH7-000000088lq-1odR
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 06:47:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E6F821FA8;
	Mon, 19 May 2025 06:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747637219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mcJE8Fh4sSyxsHiW5v4FxwqAmHJwqBEG/dlbQaPTyiI=;
	b=PLgUjflu/TGepK3Qpp7BoVCD7f9ays1F6oSw+emxoKJ0fyPhYwrd6ZNaFiUYVvx6wMsEo5
	8vRxt6jjOLaTk8iVC1Y1/2QsAr0Cp63UtjXD19sQTlob1F3w/PoRwHwPL4mV1mgv8Q6T/g
	pR9Z8c9D6W40AgcT3KAsMihmmrd5JmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747637219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mcJE8Fh4sSyxsHiW5v4FxwqAmHJwqBEG/dlbQaPTyiI=;
	b=KWethRK40uEgvwXzGxOvZGx2mUhMnW0BqXdgx1JFSiMD1n6aexUncGF/vXJ64XCfbCOo4R
	oouqXDUeR8Je8QCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PLgUjflu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KWethRK4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747637219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mcJE8Fh4sSyxsHiW5v4FxwqAmHJwqBEG/dlbQaPTyiI=;
	b=PLgUjflu/TGepK3Qpp7BoVCD7f9ays1F6oSw+emxoKJ0fyPhYwrd6ZNaFiUYVvx6wMsEo5
	8vRxt6jjOLaTk8iVC1Y1/2QsAr0Cp63UtjXD19sQTlob1F3w/PoRwHwPL4mV1mgv8Q6T/g
	pR9Z8c9D6W40AgcT3KAsMihmmrd5JmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747637219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mcJE8Fh4sSyxsHiW5v4FxwqAmHJwqBEG/dlbQaPTyiI=;
	b=KWethRK40uEgvwXzGxOvZGx2mUhMnW0BqXdgx1JFSiMD1n6aexUncGF/vXJ64XCfbCOo4R
	oouqXDUeR8Je8QCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B44C13A30;
	Mon, 19 May 2025 06:46:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8bEmAePTKmhTSQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 19 May 2025 06:46:59 +0000
Message-ID: <24fd28cf-43d4-48de-8be1-09dcecd97821@suse.de>
Date: Mon, 19 May 2025 08:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] nvme/063 failure (tcp transport)
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2E6F821FA8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.de:dkim]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250518_234701_615422_396096D1 
X-CRM114-Status: GOOD (  12.68  )
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

On 5/16/25 14:31, Shinichiro Kawasaki wrote:
> Hello all,
> 
> Using the kernel v6.15-rc6 and the latest blktests (git hash 613b8377e4d3), I
> observe the test case nvme/063 fails with tcp transport. Kernel reported WARN in
> blk_mq_unquiesce_queue and KASAN sauf in blk_mq_queue_tag_busy_iter [1]. The
> failure is recreated in stable manner on my test nodes.
> 
> The test case script had a bug then this failure was not found until the bug get
> fixed. I tried the kernel v6.15-rc1, and observed the same failure symptom. This
> test case cannot be run with the kernel v6.14, since it does not have secure
> concatenation feature.
> 
> Actions for fix will be appreciated.
> 
Seems like we are calling 'quiesce' twice:

static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
{
	nvme_tcp_teardown_io_queues(ctrl, shutdown);
	nvme_quiesce_admin_queue(ctrl);
	nvme_disable_ctrl(ctrl, shutdown);
	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
}

static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
		bool remove)
{
	nvme_quiesce_admin_queue(ctrl);
	blk_sync_queue(ctrl->admin_q);
	nvme_tcp_stop_queue(ctrl, 0);


I'll send a patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

