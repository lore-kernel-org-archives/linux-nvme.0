Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA9CC5321E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 15:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v7soXlZSnx2B2pZ17AaywsUliFm0SIebtesBFVF5NnM=; b=ZM8rRNqhozZ2+fYyQ8pdOso1rY
	TXCLVGZajfwUZXK7grEZmjul3eW5JKu8oYz/w1D3UbfM4Rw4+RTG6fzVcCytgaO63YJa9Ae1jOfl6
	bZJXx5Piw51M4uhvblbFxjQ6bp+9nrFl1m4su0gDzGUCbcnP2+5lqty89Q312JyZSL80xVy7lZLTM
	SZtnpaBKEB9LYuCbMyxAnYzFWgXREwpnwQgb1cm5H4i93WN9XQDqBkWPY4FcGgVPBBV1wR7qgHsbS
	1e6BbVP7tBh77BWjF2P3k5eXv2uUN3myVLdy8vPZFgWO3yO1jC9SBlAZWYZBj2zXA+q8uRkxmqzdj
	td5F680w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sibv7-00000007sKf-1IUS;
	Mon, 26 Aug 2024 15:46:17 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sibv3-00000007sIN-49ZV
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 15:46:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 625A01F892;
	Mon, 26 Aug 2024 15:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724687171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7soXlZSnx2B2pZ17AaywsUliFm0SIebtesBFVF5NnM=;
	b=dubD5M+bziPIxY/GsL2y4IVQPItq3KwWNAgG4jb0IC46Q9dQhTKy3+bqxHTayusFQKdzCV
	YlwfMVpuBoIwonzzqlnptKbEsnhWOuDghytb4gfGeb4UYCGaoRr0waCWN1yiWmqxsk4cdc
	eIwrZBtQlgvxi9LYE10HeQH92/9rQ0E=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dubD5M+b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724687171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7soXlZSnx2B2pZ17AaywsUliFm0SIebtesBFVF5NnM=;
	b=dubD5M+bziPIxY/GsL2y4IVQPItq3KwWNAgG4jb0IC46Q9dQhTKy3+bqxHTayusFQKdzCV
	YlwfMVpuBoIwonzzqlnptKbEsnhWOuDghytb4gfGeb4UYCGaoRr0waCWN1yiWmqxsk4cdc
	eIwrZBtQlgvxi9LYE10HeQH92/9rQ0E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14D151398D;
	Mon, 26 Aug 2024 15:46:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pgyIA0OjzGYGcQAAD6G6ig
	(envelope-from <mwilck@suse.com>); Mon, 26 Aug 2024 15:46:11 +0000
Message-ID: <a5b9abcf03302d6f5c5b163c97070c4a674e02e8.camel@suse.com>
Subject: Re: [PATCH v2] nvme: core: shorten duration of multipath namespace
 rescan
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Niklas Cassel <cassel@kernel.org>, Hannes Reinecke <hare@suse.de>, 
 Daniel Wagner <dwagner@suse.de>, Stuart Hayes <stuart.w.hayes@gmail.com>,
 linux-nvme@lists.infradead.org
Date: Mon, 26 Aug 2024 17:46:10 +0200
In-Reply-To: <3d52c916-a152-4f1e-8b44-6c4c1ca34747@grimberg.me>
References: <20240826142241.53601-1-mwilck@suse.com>
	 <3d52c916-a152-4f1e-8b44-6c4c1ca34747@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 625A01F892
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.de,gmail.com,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_084614_216653_3901566A 
X-CRM114-Status: UNSURE (   9.58  )
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

On Mon, 2024-08-26 at 17:30 +0300, Sagi Grimberg wrote:
>=20
> I'd even make it nicer with adding an out label and reverse the ret=20
> condition polarity.

Ok, if you prefer that ... I thought you might like the if block
better, as the goto variant comes with lots of whitespace changes.
I'll send a v3.

Thanks
Martin


