Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2956C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 07:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IbnwARqjdU+mb/Bbl38P10RjElasU3BImT8bz2Wc+og=; b=A025wlxPakRAF739Gl/EJxPyTd
	I8D9gymg9mmT4jDp9GdFmRfwzanFpv19xZmpsMuTmbwovGP5Rw65b3xnBhP9L9cyDEuse0rGk4WLz
	lVoLjYVq8BJDk5y6oh2IuGbmrR3nlSSesQe/QLZ07JLEx4WFhGB+v/ojI1z/evoVJtZN9XL7qx8Hw
	X2/9bROAIYv40HwfOYMeukx5HhpY8l1DakZBkvoEPeeclRX3DFAbCdbRUTdX5fSpsR25Qgjp68yxy
	baDusSKsz/1xU6ECympefcQo345inZvH5z3fUmT/Rd0XW5A3sik2swTKdbYlGRBokYQElZeDqJxrX
	iW74jEBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wge1y-0000000Bkvy-0fFJ;
	Mon, 06 Jul 2026 07:46:18 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wge1v-0000000BkvQ-1uXM
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 07:46:16 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 00E6F739C1;
	Mon,  6 Jul 2026 07:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783323972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IbnwARqjdU+mb/Bbl38P10RjElasU3BImT8bz2Wc+og=;
	b=u31QSO/1KXM5tiAlP0AGx42fWIRdVtoPiGByUe9meODxkHYDdsuIdQgFv2nzQIjf8/0FW1
	BJgRO+U+1+YgfhnSyNYto/u5JQ0aezpbbPlv/d+Kw2F80yH1hI77B1g0CmVMU+XE/iUdtF
	IEVVLuETQrxhllp+12JsTG6dV30w0EI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783323972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IbnwARqjdU+mb/Bbl38P10RjElasU3BImT8bz2Wc+og=;
	b=uSyHEp9G/fh3NvYKtltCqyjpPBSRMw0+vIA3cqbYJmufx1KxUM1nLzcBRmZCIYUvpAcSE+
	I9DS0bHhtlmNiDAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OpLNMP7m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bSeW5YFm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783323971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IbnwARqjdU+mb/Bbl38P10RjElasU3BImT8bz2Wc+og=;
	b=OpLNMP7mIwXsY4VH2aaZldrM7eRhrlQ3Ib5m7oe4nfVoX0pasdmoWsOPio0c8uv2Mj8CT+
	9d/ZKinIc/3tjGO92Yuzn838zGufrdOOScAwLUVtqI82oEugu+0XMLZG5mlyW58pMNjcgp
	PhmnsbgffCivUT7LJgM9d+xHlG+WsLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783323971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IbnwARqjdU+mb/Bbl38P10RjElasU3BImT8bz2Wc+og=;
	b=bSeW5YFmk2VdvqJ9JFPre8srywqHhKX/6+mziDUGJo47bPMBZd2v034vSapTgSS9fKShX+
	Kyh6sC6FiNseVrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E055D779AA;
	Mon,  6 Jul 2026 07:46:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D3EYNUJdS2o/BAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 06 Jul 2026 07:46:10 +0000
Date: Mon, 6 Jul 2026 09:46:10 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	John Garry <john.g.garry@oracle.com>, Nilay Shroff <nilay@linux.ibm.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com, 
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v3 1/3] nvme: add ABI documentation for host sysfs
 interfaces
Message-ID: <bf51b33c-cde7-448c-a329-aaa1a56e0a26@flourine.local>
References: <20260706023439.3054578-1-kanie@linux.alibaba.com>
 <20260706023439.3054578-2-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706023439.3054578-2-kanie@linux.alibaba.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 00E6F739C1
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,alibaba.com:email,suse.de:email,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_004615_649555_AED29786 
X-CRM114-Status: GOOD (  10.18  )
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

On Mon, Jul 06, 2026 at 10:34:37AM +0800, Guixin Liu wrote:
> Add Documentation/ABI/testing/sysfs-nvme documenting all NVMe host
> sysfs attributes, covering controller attributes under
> /sys/class/nvme/nvmeX/, namespace attributes under
> /sys/block/nvmeXnY/, and subsystem attributes under
> /sys/class/nvme-subsystem/nvme-subsysX/.
> 
> Each entry has been traced to its original introducing commit to
> provide accurate Date, KernelVersion, and Contact information.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Reviewed-by: Hannes Reinecke <hare@kernel.org>

As far I can tell, this looks good.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

