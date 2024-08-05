Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6CCC3DA4A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Aug 2024 08:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ayi3M8Q0EYAP0dZBx1MXz7GjQ1ptlMlNtkqG+YbZicU=; b=0WZW7TTg80qoYmmiGdoiLpghrl
	a308ZaqJpnaa1MjEcNEHkpTO2b/16CeXb2fq2cVJkp0/i5d8f5uhSHo+KHALlBDIdOWkquak2jNWw
	5AD2+VDwmZGF3T/7PDB6K7F35ta92b5/neg76xN3sEx8VNYbPZLmuyOVDgyIs9/rV3yxL0sUQpFor
	5ckfEc89uG8/IOGh9coZTihXarVO4W8uGy4KJZzolKMAR77xe4C9kVJV+YYhqC1jge7E2mYQfxBO/
	GkV3ef2Doe8OZOeW1u+/MdkCVmzW75hSnAAOrOzDnnD2pFeyg+HBo8mDhTQmERNeFZSRHkfo2nbwy
	TN/algqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sastb-0000000F5kE-1P4L;
	Mon, 05 Aug 2024 08:16:47 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sastU-0000000F5in-02Ex
	for linux-nvme@lists.infradead.org;
	Mon, 05 Aug 2024 08:16:43 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0C26211B5
	for <linux-nvme@lists.infradead.org>; Mon,  5 Aug 2024 08:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722845796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ayi3M8Q0EYAP0dZBx1MXz7GjQ1ptlMlNtkqG+YbZicU=;
	b=e6tOHa9586/B5CGzb3JTAmi5Nuwq1OCtbwBgVgZEpOeJ6CRXrupuGu23OHCGX9x/w1lPN7
	R5Jz86nznR07ZyAcHtM3JlvO942lIRtOmFR3Uhc9cQ4RuwUNaPM7kSUfg5F1CRW8gAPwFY
	pK3bzCkTdOGczBtNqeKhiwpQ6NkaC0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722845796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ayi3M8Q0EYAP0dZBx1MXz7GjQ1ptlMlNtkqG+YbZicU=;
	b=n44aEAY0WE8U39LbYTRzZOWjQdRBiCl05sxxSYWEKKJYUnV0ZvSAhHwL3MPQRi5DE56vVT
	TiBt6TCcSo+IG5Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e6tOHa95;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n44aEAY0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722845796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ayi3M8Q0EYAP0dZBx1MXz7GjQ1ptlMlNtkqG+YbZicU=;
	b=e6tOHa9586/B5CGzb3JTAmi5Nuwq1OCtbwBgVgZEpOeJ6CRXrupuGu23OHCGX9x/w1lPN7
	R5Jz86nznR07ZyAcHtM3JlvO942lIRtOmFR3Uhc9cQ4RuwUNaPM7kSUfg5F1CRW8gAPwFY
	pK3bzCkTdOGczBtNqeKhiwpQ6NkaC0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722845796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ayi3M8Q0EYAP0dZBx1MXz7GjQ1ptlMlNtkqG+YbZicU=;
	b=n44aEAY0WE8U39LbYTRzZOWjQdRBiCl05sxxSYWEKKJYUnV0ZvSAhHwL3MPQRi5DE56vVT
	TiBt6TCcSo+IG5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8466D13254
	for <linux-nvme@lists.infradead.org>; Mon,  5 Aug 2024 08:16:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gVvfHmSKsGbSWAAAD6G6ig
	(envelope-from <dwagner@suse.de>)
	for <linux-nvme@lists.infradead.org>; Mon, 05 Aug 2024 08:16:36 +0000
Date: Mon, 5 Aug 2024 10:16:35 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [ANNOUNCE] nvme-cli v2.10 and libnvme v1.10 release
Message-ID: <gsbq2nv7br5hkl5m2mczp4opws3xzy4rxlfjdxnzihpplfukua@fgbouvqmcijo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-nvme@lists.infradead.org];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A0C26211B5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240805_011640_220410_52FDB6C3 
X-CRM114-Status: UNSURE (   5.75  )
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

nvme-cli v2.10 and libnvme v1.10 are as new release available.

