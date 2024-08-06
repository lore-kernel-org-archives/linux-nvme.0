Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A0CC3DA64
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 11:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fHiZ+PFRqs1/hmP4Agz1q9bVDs/trfYb4QdMaRjdeLk=; b=XMgz5Rj80xKKYy6qLc0waGWD0N
	yIY3YqMP5MQe5odIdfvaaLyRwubZQCXWL11vqBhN5nFJtISGXvXRoI3HwwLM9OZ0klzbeZEO9TQDR
	NE0rZzQtt153oWpynKE4l6yM6mMVfYTQw6dtyouJeSqDN6eHAidiDBwU5TdIAgVEQnKWmEK+ZhtbS
	LF7K/W8aEtlt2ILun8pmnMrpWcSPfPmNlfNufhaxoSnxLjtBzuDcm0RoG+UDTV4myftaJJE9m79ph
	VV0jg9vBdkZDliLOYCsvALsTTmSYrv34B3qL43OWWzPEKnWJfTQNpmM1tIXNu17hdDfmIt0XRBUS5
	WlKK/b5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIae-00000001O0c-2vj4;
	Tue, 06 Aug 2024 11:42:56 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIaA-00000001NmC-3tuh
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 11:42:55 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B025421C50;
	Tue,  6 Aug 2024 11:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722944543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHiZ+PFRqs1/hmP4Agz1q9bVDs/trfYb4QdMaRjdeLk=;
	b=WcWzGrV13QpS9AjXALF1d6DyPDnelGU3K1drmaaYlpQXqRpUhyAC8oYC/3Z6ULYxFa4gj2
	Whbc1WjAarTI9U3yJF95M7F+pdnaGxKagbdhVCe0wg7o2PRyclpopYRJdw+EDGe5i0/Jzu
	eiwcMnVTSbzBV7zWz73oCCmTq8uHQDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722944543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHiZ+PFRqs1/hmP4Agz1q9bVDs/trfYb4QdMaRjdeLk=;
	b=kx/63zbkbZwJb4PXZmw+GyFK9hXZ4qvp80oPhPb9ZFKwFsf3AiFKKevhPDTJ5SDhdUvWvw
	JdIqVynbMoFiHWDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WcWzGrV1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="kx/63zbk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722944543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHiZ+PFRqs1/hmP4Agz1q9bVDs/trfYb4QdMaRjdeLk=;
	b=WcWzGrV13QpS9AjXALF1d6DyPDnelGU3K1drmaaYlpQXqRpUhyAC8oYC/3Z6ULYxFa4gj2
	Whbc1WjAarTI9U3yJF95M7F+pdnaGxKagbdhVCe0wg7o2PRyclpopYRJdw+EDGe5i0/Jzu
	eiwcMnVTSbzBV7zWz73oCCmTq8uHQDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722944543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHiZ+PFRqs1/hmP4Agz1q9bVDs/trfYb4QdMaRjdeLk=;
	b=kx/63zbkbZwJb4PXZmw+GyFK9hXZ4qvp80oPhPb9ZFKwFsf3AiFKKevhPDTJ5SDhdUvWvw
	JdIqVynbMoFiHWDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9362613981;
	Tue,  6 Aug 2024 11:42:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j3eOIh8MsmYLKAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 06 Aug 2024 11:42:23 +0000
Date: Tue, 6 Aug 2024 13:42:22 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Eric Robinson <eric.robinson@psmnv.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Disk Says It is Full But There's Nothing on It
Message-ID: <zsyfgzmoyvjgvywkbkgtxchpfei3pyfcaf2mzu4gltraf34ymx@vocftyxjmedn>
References: <SJ0PR03MB65014AE3AD77A352D0C88855FABE2@SJ0PR03MB6501.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR03MB65014AE3AD77A352D0C88855FABE2@SJ0PR03MB6501.namprd03.prod.outlook.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B025421C50
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_044227_143582_E6E85584 
X-CRM114-Status: UNSURE (   8.42  )
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

On Mon, Aug 05, 2024 at 11:30:02PM GMT, Eric Robinson wrote:
> What's up with this?

There was a bug in nvme-cli which got the usage sizes reporting wrong.
Could you check with the lastest upstream version?

