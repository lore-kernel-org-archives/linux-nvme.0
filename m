Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CE2C5DF6D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 12:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X5pIZW1lJTTGeXnIu2W0ab3cX3cmVhHVzaspBtaFF/s=; b=Wb1OA/hOT/tV9+lXOz8luAtzZX
	dXXnzE2v2tgehCF7bFv69sm8/VM7ivEYuldU9mmuITbccbU8WXQ132fegnCYePpzxc2ediJC3YInJ
	/SQXixKQjHcb74lSJoT4ukmv13QtTWdChag83UBtGC6CwMtwbmtnf1G6LiRymc608d17FXqgAVmYw
	QgeLzVYXa1wcA4Tgu50tJHwooQxfTFS4Kwx5n/gz93m5as5uwA3XK04q9nkubr2ONsfsg1RynFNHY
	KOQsT+71GzvM3rFhLrxME1sL2flmw4Li/5HbWO5EiwM5gZc2fb+E6Jn9zBlgUGpDrK5EGwpHHW57Z
	S5eVtyKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwf3E-00000009iq0-2TgB;
	Wed, 19 Aug 2026 12:05:48 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwf3B-00000009ipi-47IU
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 12:05:47 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1473884AEF
	for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2026 12:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787141140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=X5pIZW1lJTTGeXnIu2W0ab3cX3cmVhHVzaspBtaFF/s=;
	b=nepJLdEc8y/okJL9nHCe5JxPqTCvXbjchdZHPZCi9dQ/pxDann0pfjE1J45wplSxWxdnyf
	9r5Ef3ZVCr6X8n5OmPZvpEEs+y3soGQgvMOwX8X9MG4a8Id/GXIXD01A4eG6lrhKk7mksK
	Lqda8HQgo1tU+hjHQ5/eJ6yEA066wXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787141140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=X5pIZW1lJTTGeXnIu2W0ab3cX3cmVhHVzaspBtaFF/s=;
	b=NBmUqPFXd3ZbSFGbO7tvGet2LXYw8YCMA7X02pkXTAuWx+K5vT/cGU2wGASxPhaczacOCl
	UnHw9TuV3ItDrvDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787141136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=X5pIZW1lJTTGeXnIu2W0ab3cX3cmVhHVzaspBtaFF/s=;
	b=K0+/y73ko0ecsnXzxu/Tctz7Y8SQjn+u5F5Q/73XaYhbEFNjEisTQ8INkrKX6vjp7lidr2
	PoDolLZJL20cejxjy5BTkYpYqlQPJAKoRMNKJFkB/DfNhIf4ECAP8fY7LgCJNSi7eGmFoP
	HI77s6UUddk1ePeTtxdQagqgc03PiKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787141136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=X5pIZW1lJTTGeXnIu2W0ab3cX3cmVhHVzaspBtaFF/s=;
	b=lnQaSmgS9O7D+wcflWbAaLe4Tkl0WOZTfvJ5a7POtr6cp33ZsfEPiN7+1QeKZPMZ5PT3TV
	Sv1s1MZrekmubCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECCBE2F81
	for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2026 12:05:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Tts1OA+chWrJdgAAD6G6ig
	(envelope-from <dwagner@suse.de>)
	for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2026 12:05:35 +0000
Date: Wed, 19 Aug 2026 14:05:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [ANNOUNCE] nvme-cli 3.0 release candicate cycles has started
Message-ID: <286dcd0d-d94a-4dd9-aef0-46f46f642b41@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-2.91)[99.62%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-nvme@lists.infradead.org];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_050546_207709_2B21AB63 
X-CRM114-Status: UNSURE (   8.62  )
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

The nvme-cli 3.0 release candidate cycle started last Monday. But there
were still a few larger changes since then. But now I think we reached
the point where things can finally calm down for the upcoming 3.0. I
plan to release end of August.

FWIW, I'm also sending out soon some more patches for blktests, so it
works nicely with nvme-cli 2.x and 3.x. 

If you happen to find a time to test or review it, it would be highly
appreciated.

Daniel

