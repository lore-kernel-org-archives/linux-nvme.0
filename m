Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654E2C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 14:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GWr7o71sQMwFqcKXA8+RJoouKBa8brCDPFdGjvFtJOs=; b=T0tkB3JBwlsvtn2DoOETV9R+1N
	g8sMtfwvcjKI+KVIVX/O3PAo5yGaVZeH6lqXnbFdS6oMc7fEPXEELTxNlj0rHn0JVtm147NG9C+oY
	mlHn1t5dHOtHOdiTbJ0LZLucBIr4DAcaJQyGtlLOHT5/xYTxOdbZORhinYWK5Xaj+5OurSeDe3Wgj
	0PeHNvMNbTeOLYESm/uQriShc7jaP01yaep02Kkxt9AUOh0Jl04O+pEhLbNXEL8aqIeNSrWACgDQA
	n66Uoj3gQbXsldE0UlEpg6AsNzkMx2XKEXE+G3RLyUteSanWr1t6dtp+BwBThafSnCr5wfAyJaYL+
	1xUhWeYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuXY3-000000067T8-2CrH;
	Tue, 18 Mar 2025 14:04:03 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuXVe-000000066rH-29LK
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 14:01:38 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CB011FD16;
	Tue, 18 Mar 2025 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742306492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GWr7o71sQMwFqcKXA8+RJoouKBa8brCDPFdGjvFtJOs=;
	b=v9hqxq63DCxLTradvk/kwqurZlTJk+077UFHE/GHhtN9JKCtoz+AUMe74KaF/jBDD/9eZW
	I1fI7soJi0CR6JaZFIUtUspE/KS6qBu1rh6IHI3tRolj6fZp3CFC7vHBLSeteOq0Gjfk7c
	eU/QqaLdf7CUeehpYjNJ8oeD67J9l+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742306492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GWr7o71sQMwFqcKXA8+RJoouKBa8brCDPFdGjvFtJOs=;
	b=0+KX8ytfF0yZw007bk9QxkJYretMKbViZ8s9sjUpLRUKogNStSL/X0YysMoXNMrlY4N9QE
	Y/DK4qT4Ggd03BAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=v9hqxq63;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0+KX8ytf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742306492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GWr7o71sQMwFqcKXA8+RJoouKBa8brCDPFdGjvFtJOs=;
	b=v9hqxq63DCxLTradvk/kwqurZlTJk+077UFHE/GHhtN9JKCtoz+AUMe74KaF/jBDD/9eZW
	I1fI7soJi0CR6JaZFIUtUspE/KS6qBu1rh6IHI3tRolj6fZp3CFC7vHBLSeteOq0Gjfk7c
	eU/QqaLdf7CUeehpYjNJ8oeD67J9l+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742306492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GWr7o71sQMwFqcKXA8+RJoouKBa8brCDPFdGjvFtJOs=;
	b=0+KX8ytfF0yZw007bk9QxkJYretMKbViZ8s9sjUpLRUKogNStSL/X0YysMoXNMrlY4N9QE
	Y/DK4qT4Ggd03BAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E660F13A82;
	Tue, 18 Mar 2025 14:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DPhSN7t82WdlAgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 18 Mar 2025 14:01:31 +0000
Date: Tue, 18 Mar 2025 15:01:31 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 18/18] nvme-fc: do not reference lsrsp after failure
Message-ID: <9ad5635d-48b2-45d5-9ba2-9e1fead2ea14@flourine.local>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-18-05fec0fc02f6@kernel.org>
 <e4d7f84a-dd29-4b7a-a831-a8555125bf43@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4d7f84a-dd29-4b7a-a831-a8555125bf43@suse.de>
X-Rspamd-Queue-Id: 0CB011FD16
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,flourine.local:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_070134_703452_3586AEF6 
X-CRM114-Status: GOOD (  12.98  )
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

On Tue, Mar 18, 2025 at 12:33:22PM +0100, Hannes Reinecke wrote:
>         ret = lport->ops->xmt_ls_rsp(&lport->localport, &rport->remoteport,
>                                      lsop->lsrsp);
>         if (ret) {
>                 dev_warn(lport->dev,
>                         "LLDD rejected LS RSP xmt: LS %d status %d\n",
>                         w0->ls_cmd, ret);
>                 nvme_fc_xmt_ls_rsp_done(lsop->lsrsp);
>                 return;
>         }
> 
> so ->xmt_ls_rsp() would have invalidated one of the arguments.
> Plus 'nvme_fc_xmt_ls_rsp_done()' is now a wrapper around
> 'nvme_fc_xmt_ls_rsp_free()'.
> So why not go the full length and kill nvme_fc_xmt_ls_rsp_done()
> completely?

nvme_fc_xmt_ls_rsp_done will be called when the LS has been processed.
We still need it.

> Hmm?

It is very confusing with all these callbacks and the name scheme.

