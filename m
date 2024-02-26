Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8AFC5478C
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Feb 2024 08:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=42Et8NfkpK+j/PdkNpy2yZl8d4fSQf4oSSY9Mj9zbbg=; b=M3EpiSLwdajsY+5MGfQBcM8QiL
	Jx8TaUJBgPhLRmbciOIo+1EPYQjWega4Qrycr3YfcZbEjt5HndXm7xbYPyTim47QaKOPv0by0tR7v
	nB7F2xGh/zzF0LBcSDDvhyEbQLGEuhM9owrgVG55ySxJO5yXNr9PYZM2Q1OsCvEwA1aD+ZsGrYI2K
	hijSKWQeZ5pxaomB5ZCY6RnJjb4aVhEir53e+cYIkHFZpMbypbwdKiUv+A4S3BEEFKQR9gW/9xcbV
	RGQXA94C0Z2jz9dS54YbBgI7MVssFUld0+wxbMMmWkO+zBpYuRwpZfM+S/y1RXkvPtH/gwqCLBesq
	2pazxbpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reWHD-0000000GyJS-3c2K;
	Mon, 26 Feb 2024 08:23:55 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reWHB-0000000GyIK-20Z8
	for linux-nvme@lists.infradead.org;
	Mon, 26 Feb 2024 08:23:54 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91B8622519;
	Mon, 26 Feb 2024 08:23:50 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 792521329E;
	Mon, 26 Feb 2024 08:23:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id coAjHJZK3GWBBgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 26 Feb 2024 08:23:50 +0000
Date: Mon, 26 Feb 2024 09:23:49 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: hare@kernel.org, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: Re: [PATCH] nvme: authentication error are always non-retryable
Message-ID: <ysqcnlgyps3zkothlirrprkmaou2qzwpsznq2mazktmyzgcvzx@hdobn7crqole>
References: <20240223105804.44473-1-hare@kernel.org>
 <c7mv5rb3wfpjlttvgycihgn7fxlngrewpdtuhucqhodde6y3m6@nk7hvf4rwzdj>
 <beef936a-c3aa-4300-b141-ab37ad5d7bf1@suse.de>
 <1870dc3d-6ef2-47ee-b4b3-2aa7638a77fb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1870dc3d-6ef2-47ee-b4b3-2aa7638a77fb@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 91B8622519
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_002353_724468_00ED35C0 
X-CRM114-Status: UNSURE (   8.15  )
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

On Mon, Feb 26, 2024 at 08:49:50AM +0100, Hannes Reinecke wrote:
> I'll send a proper patch.

Yes, this does the trick:

 nvme nvme0: qid 0: no key
 nvme nvme0: qid 0: authentication setup failed
 nvme nvme0: NVME-FC{0}: create_assoc failed, assoc_id 18da4ebfd6fa0000 ret 16785
 nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (16785)
 nvme nvme0: NVME-FC{0}: reconnect failure
 nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
 (NULL device *): {0:0} Association deleted

