Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EE9C3DA6D
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 12:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6Eh681Cx+1dw3JFmffF+I+oNC1jnHumCg5WM98Iqfjw=; b=FHChudMfKTF813cg15cYKvnCq2
	HjHfqUuVRzzoRmqUkptk79UT0txcSVYsrlnr/WbLl4jMrWMf3pJPUy/T7s9yVIBC/jtXo8vN6WhYK
	bexukTJdmfq6UIlzzPTEQiMmHzi7l+SngM7gfsp14n2tZT++TfLmmGA7VTs4yXmtPO6IgqrembYLZ
	mtbQSv7Gz9D4TEhX59Az7Btoz4eUkaad8LsmZylLoUr7u7hT2wCc7d2olqn8AFZQdiOA+Wt8vHEiN
	FJwKCcaUEaNaX1N3TISKfMFhcYRflj8VY13Iqum2Tjmg6KDGMKWr5m7JvUZYklxO3jy48xpV/IGG4
	nFksR8pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHLqR-0000000CpIz-0dYa;
	Tue, 20 May 2025 12:13:19 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHLqO-0000000CpHv-2KKf
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 12:13:17 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B10C4206BD
	for <linux-nvme@lists.infradead.org>; Tue, 20 May 2025 12:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747743193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=6Eh681Cx+1dw3JFmffF+I+oNC1jnHumCg5WM98Iqfjw=;
	b=EgwnThbEZV9l8024wS0D53lYeLHYwvwc+6OuXkZyPH1csK2BW99oLjNXi/jCq7rb8a99SS
	SlzGl1A2QxlDEUbHYUbonqYuN30XUpCBx2oBn1CkhzVT3T5/z69YqFUP26ySWnXwIUiWzR
	Yl9n3WFNu/SUWrz6QF9sLm9ID6MBs2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747743193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=6Eh681Cx+1dw3JFmffF+I+oNC1jnHumCg5WM98Iqfjw=;
	b=cXwvcKFY02WHQaOunQa29O0tnEtr0uzlT9TdhYaXiT0fJzQai/Ks+F+rRtcccy2zLIZOtp
	TtNpERQTLm6KarBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747743193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=6Eh681Cx+1dw3JFmffF+I+oNC1jnHumCg5WM98Iqfjw=;
	b=EgwnThbEZV9l8024wS0D53lYeLHYwvwc+6OuXkZyPH1csK2BW99oLjNXi/jCq7rb8a99SS
	SlzGl1A2QxlDEUbHYUbonqYuN30XUpCBx2oBn1CkhzVT3T5/z69YqFUP26ySWnXwIUiWzR
	Yl9n3WFNu/SUWrz6QF9sLm9ID6MBs2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747743193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=6Eh681Cx+1dw3JFmffF+I+oNC1jnHumCg5WM98Iqfjw=;
	b=cXwvcKFY02WHQaOunQa29O0tnEtr0uzlT9TdhYaXiT0fJzQai/Ks+F+rRtcccy2zLIZOtp
	TtNpERQTLm6KarBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A48613888
	for <linux-nvme@lists.infradead.org>; Tue, 20 May 2025 12:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EZAmH9lxLGgdBAAAD6G6ig
	(envelope-from <dwagner@suse.de>)
	for <linux-nvme@lists.infradead.org>; Tue, 20 May 2025 12:13:13 +0000
Date: Tue, 20 May 2025 14:12:57 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [ANNOUNCEMENT] nvme-cli v2.14 and libnvme v1.14 release
Message-ID: <ce244b54-4322-4c72-9c8c-696a5b93d447@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.30 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-nvme@lists.infradead.org];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_051316_746225_A6D64B1F 
X-CRM114-Status: UNSURE (   8.37  )
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

New release of nvme-cli (v2.14) and libnvme (v1.14) are available. As
usually fixes and improvements all over the place.

From point of view, the main change is that nvme-cli is handling the
EINTR and EAGAIN return codes from the kernel. The last attempt to
handle it directly in libnvme was not really a great idea.

FWIW, I think both return codes are not new, they are just more likely
to hit with newer kernels. E.g. I was able to trigger the EAGAIN with
blktests nvme/030 for a while but than something changed it was gone
again.

