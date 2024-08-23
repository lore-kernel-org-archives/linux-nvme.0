Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90228C531DC
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 06:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7YnTMPnFUmVk5sJ6YFirqIg/tDNnRDD7NtEPmuaWoY0=; b=q8K4fj8US8pKpe6611zwjV2fWX
	RSowQEQ8FvYKfF6W7nAqtP7lZPlaIIRk+V4M66Mv3AAU3wtRQR/pgcblXioxhrugNsClAFhhVknUF
	GK8cgNhB1u/vGBXYAslw/ymqaHR9BnB9S4H3gj/5nI9xcpWm5Gq0i5RFr47hyZcELuWQ5l7BCL/1k
	/P3ZqF0mzAHY58z2q6DjdkBdIEV2nOCVIyMq6GHTZ5g+uOwMTlMZlv7hCeZ7mKMmFIbuFFNYRr5+1
	BbX3pXbHYdBWliv503k6XAv5QBLwgcD7ZkVQxXbtE9Zi9DC3kMGVSLq2trlrW3svpx0Yd1zd4xED3
	oBeHaD5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shO4N-0000000FW6b-1ENd;
	Fri, 23 Aug 2024 06:46:47 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shO3t-0000000FVwZ-3HGm
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 06:46:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4D8C2202D4;
	Fri, 23 Aug 2024 06:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724395576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YnTMPnFUmVk5sJ6YFirqIg/tDNnRDD7NtEPmuaWoY0=;
	b=wC0whvHgA85IyszC1Axtzu+HSOOnSNuA6uPPYCFFNqWVRDH8yfv3LbySgkLfsFnLvUsS0/
	U0PSxezBrc/MapGzsDCaA052K/Y3wP1o63ttIWkKPYTFbVqoTJMJUcjc+qBKxVdDazi7BC
	ZNTjPFwzdodcEm7wa+gXT4MnxclGyE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724395576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YnTMPnFUmVk5sJ6YFirqIg/tDNnRDD7NtEPmuaWoY0=;
	b=v/huvvyFzMVL0csnraERH8JEnSGzCtG/KJK+KhRN7pzqokt0lLK963KAAgiLEin5aI+TrM
	h0+PwzoD8YcUW8DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wC0whvHg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="v/huvvyF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724395576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YnTMPnFUmVk5sJ6YFirqIg/tDNnRDD7NtEPmuaWoY0=;
	b=wC0whvHgA85IyszC1Axtzu+HSOOnSNuA6uPPYCFFNqWVRDH8yfv3LbySgkLfsFnLvUsS0/
	U0PSxezBrc/MapGzsDCaA052K/Y3wP1o63ttIWkKPYTFbVqoTJMJUcjc+qBKxVdDazi7BC
	ZNTjPFwzdodcEm7wa+gXT4MnxclGyE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724395576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YnTMPnFUmVk5sJ6YFirqIg/tDNnRDD7NtEPmuaWoY0=;
	b=v/huvvyFzMVL0csnraERH8JEnSGzCtG/KJK+KhRN7pzqokt0lLK963KAAgiLEin5aI+TrM
	h0+PwzoD8YcUW8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CA011333E;
	Fri, 23 Aug 2024 06:46:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xv6ZBDgwyGZ+awAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 23 Aug 2024 06:46:16 +0000
Date: Fri, 23 Aug 2024 08:46:15 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Martin Wilck <martin.wilck@suse.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH 2/3] blktests: nvme/032: skip on non-PCI devices
Message-ID: <fc4b1c7d-e948-49f7-880e-7e591566c79d@flourine.local>
References: <20240822193814.106111-1-mwilck@suse.com>
 <20240822193814.106111-2-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822193814.106111-2-mwilck@suse.com>
X-Rspamd-Queue-Id: 4D8C2202D4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_234618_032703_7B8E9930 
X-CRM114-Status: UNSURE (   6.70  )
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

On Thu, Aug 22, 2024 at 09:38:13PM GMT, Martin Wilck wrote:
> nvme/032 is a PCI-specific test.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

