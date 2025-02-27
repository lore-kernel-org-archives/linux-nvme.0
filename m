Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCD9C197BF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 19:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sUR5yr5xrKYtwisJP33yULREbphDWSStzk3gHg4/86Y=; b=TKh0u46ypohmgOfqT7+JsSlJVf
	oRYIc98S1Sv9UYIIoFtnGyWjcYWTEYF+I+MBGIEHTMZSW1uSPRtXjCeMmGhN6K4SQ0Jr0XiNP3Vi1
	W6JxjaWlokEoQfxbr72+Y2b8qEWiO/48qA21iXdyxYLPM4VSSbBjNVgIRSmnCqJHuoitL2D32Z1UW
	MvwWk69pC45xBRSGWXZrAbLpL8cj2oYozrag3itdx0cGnVZf2FpTV1URJpEHs6Ay05exTLWP8/g8k
	Y9qePD5mv9uNC+hyeKZFWEljZFooMiVsIuUhcnyinjA2pFyWmn+LFNbNkY3Idy5jOl1/Lx/Rhk467
	IUd419Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnjjM-00000008Y38-3jVH;
	Thu, 27 Feb 2025 19:39:36 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tngm6-000000084nP-3AKw
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 16:30:16 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 500BA21179;
	Thu, 27 Feb 2025 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740673811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUR5yr5xrKYtwisJP33yULREbphDWSStzk3gHg4/86Y=;
	b=m6Ehxif86p9b9oNITYwyp1MjXjGLoPJ0mdop+VruoWE7WXUsGzOliFi7YOzJI9lMuPWDu7
	+VD4dH9+DzGdTDm/tWdfi68rTbHXrGugQAlfR16C6sB4Oq8/gFop+zgatzZwdbEkbmKbbr
	sYB2KTarMfwQgXfXXlvJcc0NnPeURdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740673811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUR5yr5xrKYtwisJP33yULREbphDWSStzk3gHg4/86Y=;
	b=wlToCjRyUSxIxbMMlobgiLETK7yjwIRVXWR/naJbibjZy2XSKTmP8ePo/N5HpwXfr3vAUh
	RlhPg4PJ6++NcVDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=m6Ehxif8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wlToCjRy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740673811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUR5yr5xrKYtwisJP33yULREbphDWSStzk3gHg4/86Y=;
	b=m6Ehxif86p9b9oNITYwyp1MjXjGLoPJ0mdop+VruoWE7WXUsGzOliFi7YOzJI9lMuPWDu7
	+VD4dH9+DzGdTDm/tWdfi68rTbHXrGugQAlfR16C6sB4Oq8/gFop+zgatzZwdbEkbmKbbr
	sYB2KTarMfwQgXfXXlvJcc0NnPeURdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740673811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUR5yr5xrKYtwisJP33yULREbphDWSStzk3gHg4/86Y=;
	b=wlToCjRyUSxIxbMMlobgiLETK7yjwIRVXWR/naJbibjZy2XSKTmP8ePo/N5HpwXfr3vAUh
	RlhPg4PJ6++NcVDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F7D41376A;
	Thu, 27 Feb 2025 16:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +HQ6DxOTwGceIgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 27 Feb 2025 16:30:11 +0000
Date: Thu, 27 Feb 2025 17:30:10 +0100
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] nvmet-fcloop: track resources via reference
 counting
Message-ID: <25fbe7c0-3602-41e8-b216-fec19568830b@flourine.local>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
X-Rspamd-Queue-Id: 500BA21179
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_083014_959361_5A804374 
X-CRM114-Status: GOOD (  13.78  )
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

On Wed, Feb 26, 2025 at 07:45:52PM +0100, Daniel Wagner wrote:
> static void nvmet_port_subsys_drop_link(struct config_item *parent,
> 		struct config_item *target)
> {
> 	[...]
> found:
> 	list_del(&p->entry);
> 	nvmet_port_del_ctrls(port, subsys);
> 	nvmet_port_disc_changed(port, subsys);   /* XXX triggers the above UAF */
> 
> 	if (list_empty(&port->subsystems))
> 		nvmet_disable_port(port);
> 	up_write(&nvmet_config_sem);
> 	kfree(p);
> }
> 
> The nvmet_port_disc_changed is a bit useless, because these event will
> never be seen by the host. Anyway, more debugging is necessary.

The problem is there is no ref counting for pe->tgtport. And in
nvmet_port_disc_changed needs to take a ref on hostport. I am doing some
more testing and it looks promising. Hopefully this is one of those
famous lost words.

