Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13093C36010
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 08:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4AsR62UurU4fs3odz2gZvjye/mdDH0TpcRopUJ6Ua2g=; b=0/UCK3dfywfAsL8B6GJrJ73kLD
	bF67Vk1257jsgLQ5rbWPYmv/r/9MfC4x0Gpx+VUF1JJZD3aFI+bChzH0ysDjKagBYTmqlTCAedb9Q
	dc/xtPfozijUl/ayCroM9lynhUtmVxW7W12sL4h3vkxvZYhpzsi9Y29btaF+u1V7yftStFBY0rk7J
	x2HnRLIQE9GASuBAAPLs6tWpYsK/GV+aLLfQ4NtbrIaECcj/Zy4n+Ql4+aQkeW3f/tEpk3WxDXzbG
	1/GAq7fQtpCl+L8tWbSM92+3t39iIilSWI4B4e2uOUFJY6sNwwirzQOYoPuWz4Y3ZgkeHgN376AHu
	jrCrzGBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1i8g-0000000H4D0-0ZOc;
	Mon, 07 Apr 2025 08:47:30 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1hvm-0000000H1Js-1aKZ
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 08:34:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B735721134;
	Mon,  7 Apr 2025 08:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744014848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4AsR62UurU4fs3odz2gZvjye/mdDH0TpcRopUJ6Ua2g=;
	b=voDbBwMh1i3f7aL030WYcdgtw2hTr73GnrB72dtMo7hxoiiyEIFnxRafFOvBVtpcGh+d+u
	Lib1zh7YUFxjtkqIqg/NJEZAM29jmkYD0OpHiwRcQVtRrUg4qJ6Thgj8wI1jFnjz1HFCiz
	rIamfUGKNX076VjflYLzRiAC5jcVHOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744014848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4AsR62UurU4fs3odz2gZvjye/mdDH0TpcRopUJ6Ua2g=;
	b=AFSuxTGi4KwCEgfEsWc3tj5wbv+UYSV3Bu8UhColcKQWtFHtvqDj/M5S9JZG15noXKE1fS
	scoqkEQwn2wqM9Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=voDbBwMh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AFSuxTGi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744014848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4AsR62UurU4fs3odz2gZvjye/mdDH0TpcRopUJ6Ua2g=;
	b=voDbBwMh1i3f7aL030WYcdgtw2hTr73GnrB72dtMo7hxoiiyEIFnxRafFOvBVtpcGh+d+u
	Lib1zh7YUFxjtkqIqg/NJEZAM29jmkYD0OpHiwRcQVtRrUg4qJ6Thgj8wI1jFnjz1HFCiz
	rIamfUGKNX076VjflYLzRiAC5jcVHOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744014848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4AsR62UurU4fs3odz2gZvjye/mdDH0TpcRopUJ6Ua2g=;
	b=AFSuxTGi4KwCEgfEsWc3tj5wbv+UYSV3Bu8UhColcKQWtFHtvqDj/M5S9JZG15noXKE1fS
	scoqkEQwn2wqM9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A5FB13691;
	Mon,  7 Apr 2025 08:34:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fXksIwCO82fXLwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 07 Apr 2025 08:34:08 +0000
Date: Mon, 7 Apr 2025 10:34:07 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	bluca@debian.org, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	Keith Busch <kbusch@kernel.org>
Subject: Re: nvme-cli connect regression
Message-ID: <e5fb8a06-d427-4332-ada2-8bb121827811@flourine.local>
References: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
 <CADUfDZoa8sVX2D599k=kaWTwc7sWdbqCyOo9ov4QiJ_P_1G+rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZoa8sVX2D599k=kaWTwc7sWdbqCyOo9ov4QiJ_P_1G+rg@mail.gmail.com>
X-Rspamd-Queue-Id: B735721134
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_013410_566004_0118D039 
X-CRM114-Status: GOOD (  20.43  )
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

On Tue, Apr 01, 2025 at 02:40:54PM -0700, Caleb Sander Mateos wrote:
> I am not sure what an error code of EINTR means in the kernel. It
> looks like the kernel_recvmsg() is performed on the thread that writes
> to /dev/nvme-fabrics, so it's possible that there is a signal pending
> for the userspace thread (i.e. nvme-cli)?

nvme-cli has only on place where signals are used (to interrupt a self
test). libnvme doesn't use signals at all. No idea where the signal is
coming from but it looks very unlikely to be from nvme-cli/libnvme.

> The kernel_recvmsg() should block until it receives all 128 bytes of
> the ICResp PDU. It can also time out if the data is not received
> before sk_rcvtimeo = 10 * HZ. But I would expect it to return EAGAIN
> in that case. I was going to say it doesn't look like 10 seconds had
> passed yet in the quoted logs, but they also show time going
> backwards, so I am not sure what to make of the timestamps...

Not sure if I am looking at the right code in networking.
tcp_recvmsg_locked seems to be the place where the operation happens and
this function is able to return EINTR

if (signal_pending)
  sock_intr_errno
    return -EINTR

And if I read sock_intr_errno correctly, this is the case when
sk_rcvtimeo is set.

Back to my original question, what should happen in this case? Usually
for userpace seing a EINTR means to retry. No problem addding this to
libnvme, just wanted to confirm this is the right thing to do.

Thanks,
Daniel

