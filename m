Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640DAC3ABB2
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 11:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2gy0qi2tax2Xp6hTkkHGnTT4aK1ueOuc2cK0myicBV8=; b=biTnAAG0h9BDtAUDl7dYDEHX6X
	uWGBxsG7YRkHhPdiSTecMeuFh8TzvT2i7EQFkQ6Dwkz1IOCxQ2vvdPHTotD/i6KbOuPkdMuGzwxPK
	bTR/U3kIGyXChd5kGO9tqPhvIibDcpyz+70ZLHZ7NF95EtUjAxKmU8+7shRUajsg1QCXvNv5+46gA
	cvdCOVThkuZVFLoBbU2G9mBkvZg0vf8AwFy6Nas5OKkvyO6KvUas5by643QXXjw/+nWM3hAqeS4pd
	byFN367wiznC1ygvs6MEaulo2H1XyIOhh5CrhJcbJ9c6G+FoWH/X/z6jYM7dPVcU01T0jPSwXlsBs
	GbIBBS7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKFGR-0000000D0zh-2zYQ;
	Wed, 28 May 2025 11:48:07 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKFFl-0000000D0vq-0q2V
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 11:47:26 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 00D721F79C;
	Wed, 28 May 2025 11:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748432842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2gy0qi2tax2Xp6hTkkHGnTT4aK1ueOuc2cK0myicBV8=;
	b=a3w2n2O4UTKiuBdOy9h2gxpYefOGWLD88mts+GpI9QEzZHbW7lAU/cbxoPcBvBjluXfvIL
	iMwvoE6nwVEXKV/crGMmVSuK7FsGS05EQI1+ieVhaPAdZnDbMbM7S0/kUSDmrtDZZKZ65E
	L28j6tyWgjkZMikAlUfH7xQECix8ybE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748432842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2gy0qi2tax2Xp6hTkkHGnTT4aK1ueOuc2cK0myicBV8=;
	b=a3MKWmSMED4EyOEblcEZ1Q57Mxm4U60asOP+ySC0pLysUpRBGH+0XCTVIJI+yJ7hSogsR9
	zriLBqItinT63RCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748432842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2gy0qi2tax2Xp6hTkkHGnTT4aK1ueOuc2cK0myicBV8=;
	b=a3w2n2O4UTKiuBdOy9h2gxpYefOGWLD88mts+GpI9QEzZHbW7lAU/cbxoPcBvBjluXfvIL
	iMwvoE6nwVEXKV/crGMmVSuK7FsGS05EQI1+ieVhaPAdZnDbMbM7S0/kUSDmrtDZZKZ65E
	L28j6tyWgjkZMikAlUfH7xQECix8ybE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748432842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2gy0qi2tax2Xp6hTkkHGnTT4aK1ueOuc2cK0myicBV8=;
	b=a3MKWmSMED4EyOEblcEZ1Q57Mxm4U60asOP+ySC0pLysUpRBGH+0XCTVIJI+yJ7hSogsR9
	zriLBqItinT63RCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D742E136E3;
	Wed, 28 May 2025 11:47:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pb4ZMsn3NmhtGQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 28 May 2025 11:47:21 +0000
Date: Wed, 28 May 2025 13:47:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <wagi@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report][libnvme/nvme-cli] "nvme smart-log" fails with
 liburing
Message-ID: <32c3e9ef-ab3c-40b5-989a-7aa323f5d611@flourine.local>
References: <a25kumc6oyvzmr42jgowkf4yztmmiypxrvnygetwv6qvc2ol6b@tzhqqggcme3q>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a25kumc6oyvzmr42jgowkf4yztmmiypxrvnygetwv6qvc2ol6b@tzhqqggcme3q>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_044725_385449_9F1296BA 
X-CRM114-Status: GOOD (  14.26  )
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

On Tue, May 27, 2025 at 10:31:18AM +0000, Shinichiro Kawasaki wrote:
> Hi Daniel, I think I found a problem in libnvme as below. Is this a
> known issue?

No, it's new to me.

> - When libnvme is built with liburing, the failure happens. When libnvme
>   is built without liburing, the failure does not happen.
>
> I took a look in the kernel code. The io_uring_setup ioctl for namespace
> devices falls into blkdev_uring_cmd() in block layer. It does not reach to
> nvme driver and just fails. So I guess the kernel does not support nvme
> admin commands for namespace devices through io_uring. Assuming this guess is
> correct, I think libnvme should use regular ioctl instead for io_uring for
> namespace devices. What do you think?

Thanks for the detailed bug report. I'll fix libnvme so it only use the
uring interface for char devices.

Cheers,
Daniel

