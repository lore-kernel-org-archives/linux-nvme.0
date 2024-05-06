Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC948C25B4F
	for <linux-nvme@archiver.kernel.org>; Mon,  6 May 2024 15:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZdITPD9WEu/FM6E0+iM5Z02yCRFhIBSKBXwOF0KtDCs=; b=3JSsn75zQZW+AfXjs+41xOUmS0
	WmSR7lAHXOS3cxDYpuIC9LH78DIkhDYuVROBc5iQEKNBLOyU7Kogby7KcBYphRR1EFfJftliqDoaL
	doNBrKEPO5CAQkI1cwcXnRHDwEIXaRrElw/V17fgTYBqbpHG1yZF42xzZEdOq+d4ey45zerN7+x5i
	u4U2l7UCuiw4rOWKzrI5wYhUEIswzhQkdJIzKhq8I/LILzrcWKkF3gD6rkysXZQe2N6EDhtnQbE+b
	cKV18Z0VNWpz5mNYlRHQ1zA4sLwAASlG1WK+ldMRlIq7arGYSgtFYgyXe308LdClz5XodUKohl62f
	+EkCVq5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3ztw-00000007njm-2IHF;
	Mon, 06 May 2024 15:05:12 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3ztq-00000007ni0-499L
	for linux-nvme@lists.infradead.org;
	Mon, 06 May 2024 15:05:10 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4CE43851B;
	Mon,  6 May 2024 15:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715007902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdITPD9WEu/FM6E0+iM5Z02yCRFhIBSKBXwOF0KtDCs=;
	b=PxCYoTqBl3nX4MeHMn6VeZXd7El16tgLoy1iCKHPKxqGnYeI5wLlAdTj8EuyRwkVLQrY/g
	a2QNrqKld+Bw0LREsk9OyVCAzDYb+/m5UyYEXCj7iE478yPeVdCEM0tQOWOT2zJFlsK0IJ
	DljLrncB6/TcVvCLwQDx1oG4a/FrANE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715007902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdITPD9WEu/FM6E0+iM5Z02yCRFhIBSKBXwOF0KtDCs=;
	b=n7/Ku2SkeC+WgzJ6/iArKzZ5uQPjovdgidUJxQtnuyLNsAHqYC0QzcHlIcNj58jqj1WKU4
	ZHTRWaROxOU70HCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715007902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdITPD9WEu/FM6E0+iM5Z02yCRFhIBSKBXwOF0KtDCs=;
	b=PxCYoTqBl3nX4MeHMn6VeZXd7El16tgLoy1iCKHPKxqGnYeI5wLlAdTj8EuyRwkVLQrY/g
	a2QNrqKld+Bw0LREsk9OyVCAzDYb+/m5UyYEXCj7iE478yPeVdCEM0tQOWOT2zJFlsK0IJ
	DljLrncB6/TcVvCLwQDx1oG4a/FrANE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715007902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdITPD9WEu/FM6E0+iM5Z02yCRFhIBSKBXwOF0KtDCs=;
	b=n7/Ku2SkeC+WgzJ6/iArKzZ5uQPjovdgidUJxQtnuyLNsAHqYC0QzcHlIcNj58jqj1WKU4
	ZHTRWaROxOU70HCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1EE61386E;
	Mon,  6 May 2024 15:05:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xdERJp7xOGaffAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 06 May 2024 15:05:02 +0000
Date: Mon, 6 May 2024 17:05:02 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Gregory Joyce <gjoyce@ibm.com>, Srimannarayana Murthy Maram <msmurthy@imap.linux.ibm.com>, 
	"axboe@fb.com" <axboe@fb.com>
Subject: Re: nvme-cli : attaching a namespace to an undiscovered nvme
 controller on multi-controller nvme disk
Message-ID: <yhvmfctxhfzrcsq4lx6nr3f5n67kegrixtthh3pals7vn5qr26@k5as5whcdrum>
References: <f1a7c1e2-3203-4b7a-a922-82fa812455bd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1a7c1e2-3203-4b7a-a922-82fa812455bd@linux.ibm.com>
X-Spamd-Result: default: False [-3.77 / 50.00];
	BAYES_HAM(-2.97)[99.89%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240506_080507_281147_24FCF426 
X-CRM114-Status: UNSURE (   9.75  )
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

On Mon, May 06, 2024 at 07:45:20PM GMT, Nilay Shroff wrote:
> There could be multiple ways to address this issue. However my proposal would be to address
> it in nvme-cli. As nvme-cli builds the nvme topology it shall be easy
> for nvme-cli to detect

The topology scan in libnvme is only using the information available in
sysfs. libnvme doesn't issue any commands anymore and I'd like to keep
it this in this way. So if the kernel doesn't exposes this information
to userspace via sysfs, I don't think it's simple to 'fix' this in
nvme-cli/libnvme.

