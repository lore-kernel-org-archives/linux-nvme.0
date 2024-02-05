Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974C1C48291
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Feb 2024 07:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fNHr5x2WS12qH6xmrfwYpbCqs255Yq6zpMFHzzqwrnk=; b=1LooEp6VWZWxeiWDYAEM1Bhl/0
	1gYteO7BkbfVgifYBPcVmM+6aoEiDfZzc63jGXxfY/V/V+xsRn+ZPMsY/LVBM6nT16yaGhceF5VSk
	beSfWO8bJyO43rJfnAMfWlhlIiUYJLno3CbpmKYrRXBUJgqjLUVNHn5DC4UjqTgrP7//T6IQYjKgl
	ZEQRRLGlz+4L9lJmnFPna3kDO3xmQJNjYZUgtjf8DWr87X+5VPckJkzNggwYg0PS4oSO823hsiSd3
	eKlCyyvdVI6/FxAm0xmTQ2REo6cE42TUl9pcdkykmm74b6n8Yuipyy92osHbL+jU6X1zRsWc64mrB
	iTMJpEDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWthV-00000002LSb-0ZSh;
	Mon, 05 Feb 2024 07:47:33 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWthO-00000002LNq-228l
	for linux-nvme@lists.infradead.org;
	Mon, 05 Feb 2024 07:47:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E67E2226D;
	Mon,  5 Feb 2024 07:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707119242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fNHr5x2WS12qH6xmrfwYpbCqs255Yq6zpMFHzzqwrnk=;
	b=0Lbg4FfQV/LtY1lPpc3sDh3hMXkSLjUw0ihLEKIBagHXCWn0O4gBttp11+BxTC7GiP+xDZ
	/arJVbhnrZl9ath2/xpGS4Ro6U1o9aov+mK171UtWr6VFTWNO4IyYfYr1HsxBhf/HtI+iL
	Qaj1Fg9dC/RYaTwjFz0gj2MZlGBFzCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707119242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fNHr5x2WS12qH6xmrfwYpbCqs255Yq6zpMFHzzqwrnk=;
	b=l8p/whlD7XFggHalSYm5nzHzDnCEW9v6btkVe2DInFqZ0S2XpEqijD1BS5rijMPGCc64n+
	DGx7rKGRcheMRyCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707119242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fNHr5x2WS12qH6xmrfwYpbCqs255Yq6zpMFHzzqwrnk=;
	b=0Lbg4FfQV/LtY1lPpc3sDh3hMXkSLjUw0ihLEKIBagHXCWn0O4gBttp11+BxTC7GiP+xDZ
	/arJVbhnrZl9ath2/xpGS4Ro6U1o9aov+mK171UtWr6VFTWNO4IyYfYr1HsxBhf/HtI+iL
	Qaj1Fg9dC/RYaTwjFz0gj2MZlGBFzCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707119242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fNHr5x2WS12qH6xmrfwYpbCqs255Yq6zpMFHzzqwrnk=;
	b=l8p/whlD7XFggHalSYm5nzHzDnCEW9v6btkVe2DInFqZ0S2XpEqijD1BS5rijMPGCc64n+
	DGx7rKGRcheMRyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C41A136F5;
	Mon,  5 Feb 2024 07:47:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x8tLDYqSwGX2AwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 05 Feb 2024 07:47:22 +0000
Date: Mon, 5 Feb 2024 08:47:21 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Re: race between nvme device creation and discovery?
Message-ID: <5pquzxdvemeeahharuoyh72njlx4unrshwxbtkpg63tk3aw2lt@ugv4guf7hkpz>
References: <i4bmvgd3u7shgizqgtdtssdz5v3wc76l6bcce6fcbvoft32gzk@rztzeut4azvj>
 <e0e89568-d3af-4d4e-9652-59d04f2c1977@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0e89568-d3af-4d4e-9652-59d04f2c1977@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.40 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[15.81%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240204_234726_705225_6627C941 
X-CRM114-Status: GOOD (  18.21  )
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

On Mon, Feb 05, 2024 at 02:02:04PM +0900, Hannes Reinecke wrote:
> Hehe. Good old sysfs.
> This is a common issue with sysfs, and we've even had a retry loop in udev
> back in them days to avoid these kind of things.
> 
> Point is, uevent will be sent out with device_add(), causing udev to run,
> running udev rules, and eventually call into libnvme to scan the device. But
> as you rightly pointed out, the sysfs link is only created
> _after_ the event has been sent, so there's a race window during which
> libnvme will fails to read the link, landing us with the scenario above.
> 
> While we could add a retry logic to libnvme, I'm not really convinced
> this is a good idea; in the end, who's to tell how long we should wait?
> A second? Several seconds? A minute? Several minutes?
> Also not that sysfs_create_link() has a return code, so the link might
> not be created at all ...

Yep, retry logics have always a smell too it. What about the idea to
add some sort of ready attribute to the controller sysfs entry?

> A possibly better way here would be to suppress uevents on device_add(),
> and only send out events once the device is fully set up, ie just before
> the 'return 0'.

I don't think this will address the problem. The blktests runs completely
independent to what udev does and it's blktests which observes the
missing link not udev.

