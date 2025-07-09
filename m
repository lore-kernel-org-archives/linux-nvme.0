Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691DBC83F0A
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jul 2025 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CHXL2jXIQ2aDFZB9oPdXhFSFo0A5kqMkgJR+k8wv/g4=; b=UGVkSbS0X9LYThPxcO7slK1kn5
	/pfD6Vx3oW7ZWVrFz7EBiKB+YmZN2JWyXtV6SlAqhtcXqNGBWzGktCnU51wkpeSB1y5hXoKXLnd89
	yv5Mp6CgWhzfo99A+agjGe02bWtwe7mg6H+LNaUPuK20VbtGCEnoeaDX+v6tpapU8Y64kb2ATU450
	pI8j9s4/qjQZmZX1d7ELs2sqLA1wZmdGqBnWlUKpSa/l0+WUzMTJL/6ZQC58M0BjOcYsihaFH185G
	89IJdLNOL9+p7ImYITZDnf6jnsY1AqpPxvnaEks67NzYxEc0O9ufCWItXsmAkv+pI4NxhR8xzcdzY
	wYaMGZ5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZX0j-00000009Cld-1zud;
	Wed, 09 Jul 2025 15:47:05 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZUmK-00000008m1n-1Jnz
	for linux-nvme@lists.infradead.org;
	Wed, 09 Jul 2025 13:24:05 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB16621187
	for <linux-nvme@lists.infradead.org>; Wed,  9 Jul 2025 13:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752067442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CHXL2jXIQ2aDFZB9oPdXhFSFo0A5kqMkgJR+k8wv/g4=;
	b=JgHkCnT2z+XhbxP4xfUCNKQsRgH3LtkktoRB9WMrnrGZXdKLxwELnmciT/x+Ov1H9Q7eRi
	yp+Hwi98yRWtVr2kv79BeQ3t3EOpZH+RJxAEIlxodxSmp4YLkVihWHLPgbziMIACR+vJtt
	3mW+dQaIbNE5/kGpkykDfOI1a6pLLmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752067442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CHXL2jXIQ2aDFZB9oPdXhFSFo0A5kqMkgJR+k8wv/g4=;
	b=zIprD2AdVotSGYLegzjr8uDhnCDyg/iSnhQcOlj4skt7zLJCBw9mG3qiLPF64gbxw/8WLC
	hrvK1opCCZ88h5Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ykUjgvoH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="9x/TnBsx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752067441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CHXL2jXIQ2aDFZB9oPdXhFSFo0A5kqMkgJR+k8wv/g4=;
	b=ykUjgvoHD757Ql1vsVA5vWVuXDdwlEXU6bpyEFDnn08LRmCI9di/SlNHojFgCndnmeOMZ1
	qioogmR0f9kAHT1TLYCX69fThdsS6VvnD5O1I4iuFXQCpd2Z6XLRkexALaOMYknkXaUsyD
	lpymMgNeDlNjoRnBeevU4+7GI2DuLrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752067441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CHXL2jXIQ2aDFZB9oPdXhFSFo0A5kqMkgJR+k8wv/g4=;
	b=9x/TnBsxmMV3U2TZ/HvcW8b9drl9n3bwJ6LUC+B487u4og5JZ3/Wk7+N0NfdfsXGd5hHs4
	WCaE845hkIVswTBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0E9613757
	for <linux-nvme@lists.infradead.org>; Wed,  9 Jul 2025 13:24:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9rzlJHFtbmgCWQAAD6G6ig
	(envelope-from <dwagner@suse.de>)
	for <linux-nvme@lists.infradead.org>; Wed, 09 Jul 2025 13:24:01 +0000
Date: Wed, 9 Jul 2025 15:24:00 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: libnvme v2
Message-ID: <88fd24ee-790a-44e2-aa89-66e9127346db@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-nvme@lists.infradead.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: BB16621187
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250709_062404_496555_22060B04 
X-CRM114-Status: GOOD (  11.82  )
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

I've started working on v2 of the library. There are several reasons why
I think it's time for a major update.

libnvme added the MI APIs after the initial v1 release. The v1 APIs use
file descriptors as "handles," which do not work for MI (there are no
fds). So, the solution at the time was to duplicate a lot of APIs with a
different kind of "handle." The main issue here is the naming for the
new handle. I went with struct nvme_link, but I'm sure there are better
names. While I'm not keen on renaming (a hell of a lot of hacking), it's
better to have good name [1]. So let's start the bike-shedding.

Another API-breaking change is the introduction of struct nvme_root as
the top-level data structure everywhere. This allows us to store global
data—for example, logging, or the controller list for MI.

Next on the TODO list is changing the error handling. That is, drop the
POSIX-style error handling (return -1 and set errno) and just return the
error code directly.

Anyway, there's a first usable version:

https://github.com/nvme-experiments/libnvme/tree/libnvme2
https://github.com/nvme-experiments/nvme-cli/tree/nvme-cli3

Thanks,
Daniel


[1] https://github.com/linux-nvme/libnvme/issues/448#issuecomment-2915439618

