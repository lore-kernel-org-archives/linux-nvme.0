Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBBBC282EC
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Mar 2025 10:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qpmWDMECUVQYLvieifaumykmeitLeskvoQGLmEx1dZU=; b=oIL/ASUd2WOBfT+AFC8nIm/nZd
	xtPVybRt/a9OBax80ISa3sDRFHI/sIjTK+K0TEFaVbMyLBJ6AXqnob5HnoNhqemm30jTpI08mfMJ0
	8sAwVKLjFGKyBbmDPj2q516Xon5NbROZUPA0xkJxA94QijOGH4/uQywVzNtAjuuEq7QVuPhZle8Iz
	KXCWJ7T2CzbM+gvHLBPfc3iptS1oKo2G96MOIDnSDzJr4LPEp6m1YWf9RsYhzRUFbZQA7SB/Nzh7m
	/yU1uOBdbnn4OPaDJnocbg9qRhWaA/IsRfRFjdiisgYeCEcxcX3vxoNcmGwSd+rTTSgjmsyggFVlW
	JeV9lQYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tu7RH-000000024k2-2gZu;
	Mon, 17 Mar 2025 10:11:19 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tu7Oz-0000000241Y-3nR8
	for linux-nvme@lists.infradead.org;
	Mon, 17 Mar 2025 10:08:59 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B56021C04
	for <linux-nvme@lists.infradead.org>; Mon, 17 Mar 2025 10:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742206134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=qpmWDMECUVQYLvieifaumykmeitLeskvoQGLmEx1dZU=;
	b=w9yK4/YrvW6ckUoPc7Y9VuNdYyaT5ME2vz5uGcFDGDxmCry2SkEKVoUtJOHhnC+IijjMdN
	pDW1uQjM+5SJTaatC6o5Uw3X+mjVL/f4jqxlkZ3GUlhBvdnXyj4nIzjMcFB7k/QiQRDVif
	6Oz+8A7Z2AFGeUkfTbbqRqljtSZa8vI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742206134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=qpmWDMECUVQYLvieifaumykmeitLeskvoQGLmEx1dZU=;
	b=qTjWHDrTFN6WlyHuicvv39eh3IZOo2pOOkXXnjaJBtD8MLXJd3CDeR0oWgxfaSsjgEV6Ht
	qKPk+5PH7eCMxiDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="w9yK4/Yr";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qTjWHDrT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742206134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=qpmWDMECUVQYLvieifaumykmeitLeskvoQGLmEx1dZU=;
	b=w9yK4/YrvW6ckUoPc7Y9VuNdYyaT5ME2vz5uGcFDGDxmCry2SkEKVoUtJOHhnC+IijjMdN
	pDW1uQjM+5SJTaatC6o5Uw3X+mjVL/f4jqxlkZ3GUlhBvdnXyj4nIzjMcFB7k/QiQRDVif
	6Oz+8A7Z2AFGeUkfTbbqRqljtSZa8vI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742206134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=qpmWDMECUVQYLvieifaumykmeitLeskvoQGLmEx1dZU=;
	b=qTjWHDrTFN6WlyHuicvv39eh3IZOo2pOOkXXnjaJBtD8MLXJd3CDeR0oWgxfaSsjgEV6Ht
	qKPk+5PH7eCMxiDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C813132CF
	for <linux-nvme@lists.infradead.org>; Mon, 17 Mar 2025 10:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qkDwBrb012eOHAAAD6G6ig
	(envelope-from <dwagner@suse.de>)
	for <linux-nvme@lists.infradead.org>; Mon, 17 Mar 2025 10:08:54 +0000
Date: Mon, 17 Mar 2025 11:08:53 +0100
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [ANNOUNCE] nvme-cli v2.12 and libnvme v1.12 release
Message-ID: <d41173f4-2963-452e-adc4-969f5829938a@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 2B56021C04
X-Spamd-Result: default: False [-4.33 / 50.00];
	BAYES_HAM(-2.82)[99.22%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-nvme@lists.infradead.org];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_030858_101574_81ED87C1 
X-CRM114-Status: UNSURE (   5.92  )
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

I've just released nvme-cli v2.12 and libnvme v1.12.

The majority of the changes are adding the missing command/parser/etc
from the nvme 2.1 spec.

Thanks goes to all have contributed to these releases. Thanks a lot!

Cheers,
Daniel

