Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F2EC27C65
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 19:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Rlg7tKxPdWRcmGHiyIBO1+ko+FnfEQf9M9NplmU3irI=; b=r2urur2MfaETV1Idn98M3Bdfx0
	F8f+h6uZ5QCbSlF6zF3+verKJLBfiKnBhUxp4MKBuuEdpRjojX8iQD5NPvtn5I/kKLS1Mucu8yM96
	X0v9iKjmMpw8Isv8xlwS2XsfH//AtXLpiWr7tFzojwDAEJds0AicwX0jG4UqCgzZ+OUkST4fX66h6
	7O7VzX8SKRaKjvsbWyLnbRvjs2m1/x9Ky/2+NxYY+asjuJcF3Jn6gfPOIr91HhuyA401azwf+f0FN
	yzGXXkxYSP2IlyZ4lRVqfhDPbWxd+rlNKbJ7xr4xq4aEYBbWJtGHsAdsqERbwo4lbYwxSofTq3BAN
	C56xDWsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH6s7-00000009x7c-3l4W;
	Tue, 11 Jun 2024 19:09:31 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH6s2-00000009x5m-1rvp
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 19:09:30 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A9182226B7;
	Tue, 11 Jun 2024 19:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718132955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Rlg7tKxPdWRcmGHiyIBO1+ko+FnfEQf9M9NplmU3irI=;
	b=OQwB1yqztM2HX8LWyWPvg4OoqJjJn2bBJmFzpUwj5GMvqzlqpAY94A9QamH1XdnizqDZZy
	3DZYkQ5V7rBBQyHcj0+jE26quVnLkBkzLLL1Pgj++zm3y3Kmzz1k4fGKj1uHbprP8gm0NX
	iEj/1PkhYrPeO+4/sCx25BeXwsEiLxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718132955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Rlg7tKxPdWRcmGHiyIBO1+ko+FnfEQf9M9NplmU3irI=;
	b=EYRca8Y+QS/Cua5s2918GzhsJs7oidxqOjMt/k/ugMYb+HWOpbPfWi5JyXUo8xERXEejXz
	NMjI8g4SFUeDUUDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718132955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Rlg7tKxPdWRcmGHiyIBO1+ko+FnfEQf9M9NplmU3irI=;
	b=OQwB1yqztM2HX8LWyWPvg4OoqJjJn2bBJmFzpUwj5GMvqzlqpAY94A9QamH1XdnizqDZZy
	3DZYkQ5V7rBBQyHcj0+jE26quVnLkBkzLLL1Pgj++zm3y3Kmzz1k4fGKj1uHbprP8gm0NX
	iEj/1PkhYrPeO+4/sCx25BeXwsEiLxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718132955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Rlg7tKxPdWRcmGHiyIBO1+ko+FnfEQf9M9NplmU3irI=;
	b=EYRca8Y+QS/Cua5s2918GzhsJs7oidxqOjMt/k/ugMYb+HWOpbPfWi5JyXUo8xERXEejXz
	NMjI8g4SFUeDUUDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99D66137DF;
	Tue, 11 Jun 2024 19:09:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hvOUJNugaGZeHQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 11 Jun 2024 19:09:15 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1 0/2]: nvme-fc: fix race with connectivity loss with nvme_fc_create_association
Date: Tue, 11 Jun 2024 21:06:45 +0200
Message-ID: <20240611190647.11856-1-dwagner@suse.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_120926_658728_5DC8C518 
X-CRM114-Status: UNSURE (   9.62  )
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

We got a bug report that a controller was stuck in the connected state after an
association dropped. It turns out that nvme_fc_create_association can succeed
even though some operation do fail. This is on purpose to handle other corner
cases, thus we can't really make nvme_fc_create_assocication bullet proof.

Given this, I think the second best option is to ensure that we always schedule
a reset whenever a connectivity loss is observed in CONNECTING state. This is
not perfect (possible back to back reset) but at least it is correct, which wins
in my books.

Daniel Wagner (2):
  nvme-fc: go straight to connecting state when initializing
  nvme-fc: fix race with connectivity loss with
    nvme_fc_create_association

 drivers/nvme/host/fc.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

-- 
2.45.2


