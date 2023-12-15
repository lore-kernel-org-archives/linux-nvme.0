Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A427C35274
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Dec 2023 14:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jHxa4ZIo/rqWhw6b89grB3fYuI4oTxVPaTSpXrpXH+E=; b=fpjOKdQ1bUqej9nhjxFDSYm+l3
	1XcLa7OGUPaJEroXDP2dWnQm18nb5MQzyXFR7f9vDbTSyoN3ZlxFQZLsqnBYkrvcCu6lhhCE1h3r9
	d+InXE+t6xWNJWFos7RrPf5tqclF/aTAKQwdu6vqUfa0NyAOPIBGKLI5vbzcwGvRTmG5Fn5A5CHxq
	Wv3UZvUJw6bShFlUP74WyW+RfLcxTX5G0A+ctwJXc/u4o+eEAK4tZHrHFmvFNsnhBQqwCofl5vjos
	5SslrzhKnNmZObfr/j9s6vm4wQFqu6K/hvb8N33xz+u0E3WQOAPDgYEkgFfhkbRlXIDjWM/RQOEXV
	XS9E6AsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rE9WH-003cmO-10;
	Fri, 15 Dec 2023 14:50:29 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rE9WE-003cm0-1C
	for linux-nvme@lists.infradead.org;
	Fri, 15 Dec 2023 14:50:27 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4CB721A79;
	Fri, 15 Dec 2023 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702651822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=jHxa4ZIo/rqWhw6b89grB3fYuI4oTxVPaTSpXrpXH+E=;
	b=UFsK3H6qW7NJWm9NaYaNtdCA3vQ2jm9+1RU059MQuONU9KYcLi987r7i0Ys9CyiJt3sCWc
	jplejWbJ1fC3J/EZdHSOApd69b8WycoFqmOEilf0DNTFwX555FI33HmW/dYHDhkqgAs8Lq
	nSVBNkha+KcPoQkp0XZtyQIvwbZVpaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702651822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=jHxa4ZIo/rqWhw6b89grB3fYuI4oTxVPaTSpXrpXH+E=;
	b=bnwI5tLRuxYlQp9vejNO6eGrI5M7TVitTS4MLZzdfrVEdDI8dgX9ZiKNgRlpoEQQd/59us
	GIcZrV2+QthF5oAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702651822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=jHxa4ZIo/rqWhw6b89grB3fYuI4oTxVPaTSpXrpXH+E=;
	b=UFsK3H6qW7NJWm9NaYaNtdCA3vQ2jm9+1RU059MQuONU9KYcLi987r7i0Ys9CyiJt3sCWc
	jplejWbJ1fC3J/EZdHSOApd69b8WycoFqmOEilf0DNTFwX555FI33HmW/dYHDhkqgAs8Lq
	nSVBNkha+KcPoQkp0XZtyQIvwbZVpaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702651822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=jHxa4ZIo/rqWhw6b89grB3fYuI4oTxVPaTSpXrpXH+E=;
	b=bnwI5tLRuxYlQp9vejNO6eGrI5M7TVitTS4MLZzdfrVEdDI8dgX9ZiKNgRlpoEQQd/59us
	GIcZrV2+QthF5oAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B648413912;
	Fri, 15 Dec 2023 14:50:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id awywK65nfGVlcwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 15 Dec 2023 14:50:22 +0000
Date: Fri, 15 Dec 2023 15:48:04 +0100
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>
Subject: ioccsz and iorcsz check failing
Message-ID: <6ib6nyftuap3ubf7uryt6sndmomfif47nkforsitadbda2pdkb@ie35lozrsiqf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.63 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.83)[93.99%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_065026_585464_2426A057 
X-CRM114-Status: UNSURE (   9.78  )
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

Hi,

Since commit 2fcd3ab39826 ("nvme-fabrics: check ioccsz and iorcsz") my
testing fails with these checks when trying to connect a remote target
(Linux nvmet) via nvme-tcp. Looking at the TCP frame I see these values
are 0 on the wire.

When running blktests with nvme-tcp via the loop back device all is
good.

When running blktest with nvme-fc via the loop back device the first
check fails because ioccsz is 0. I've added a bunch of debug prints:

  nvme nvme0: I/O queue command capsule supported size 0 < 4

  nvmet: nvmet_execute_identify:687 cns 1
  nvmet: nvmet_execute_identify_ctrl:469 ioccsz 4 iorcsz 1
  nvmet: nvmet_copy_to_sgl:98 buf ffff8881348a6000 len 4096

So this part looks good to my eyes. Not sure where the problem could be.
In case someone spots the problem as I can't really make sense of it at
the moment.

Thanks,
Daniel

