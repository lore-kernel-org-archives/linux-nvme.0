Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D513C982E1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 11:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/NfxikMW0an5SBYmu5hTO0LNfhoBM9wQ5NRZpY/GkJg=; b=QjcpD0lXsH08eZusb8B6Ia2qZ5
	Hqxk5px4sBOHJ6/8ls1rGNFNHoZoF5fsdOqiUsSLJmRQEwAQkjKUW7AYQIhtwjimrBn/ClzmHbsEa
	t0k9i9MwP+ARZ5JR0MXCa8Y2IsUXnQ9+ouVBV72/4U8y7ogKGRJTmMDEhaYMsiQSC9WB7bp4dUp8X
	CNN8oHfRu9DfH9ZnkqR41ID2QiUdTu09ls3VRLcmpw9Km+zF5Nof9DQgZCRzLwz1kR20hkWfwbWJi
	0zH0v276UCnOVJ30I7Qsf7W7nkmd1I9xGrEbidcVIgQqu84iUIrJCjz4f2QqRDHD0o1zZI4FgbId1
	gcwulxvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8cCX-00000001uoc-0szI;
	Mon, 21 Sep 2026 11:28:49 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8cCV-00000001unk-10bQ
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 11:28:48 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E27AC1FAA3;
	Mon, 21 Sep 2026 11:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789990119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/NfxikMW0an5SBYmu5hTO0LNfhoBM9wQ5NRZpY/GkJg=;
	b=VjN0N5Zl79FtE2/GBE7l7l59/Sb8ANygoLJz9KzcTbaCQoWRprCFMtqbJF2FZqTCMaEQKt
	bH2ckt+mIE+/V8wazxX1AszFkC924RBp6wAXBAVZk99Sxi7ZMPMNDZawID1fewiWKHMpwH
	ewo3MCKC1a1761qHfSMsciF/Ak2owjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789990119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/NfxikMW0an5SBYmu5hTO0LNfhoBM9wQ5NRZpY/GkJg=;
	b=0VVPFEi/huCWgBwTVrA4LBpyCP3bMfUaCzpLE90Q1hgu/gO4iiAvGluVzozNsqbo6JPZ/B
	pQpzzhY7PUaMBzAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789990114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/NfxikMW0an5SBYmu5hTO0LNfhoBM9wQ5NRZpY/GkJg=;
	b=Yv4M9aiRuv8s2thiL4B+pzXQ7/kOW8Wjob0pG/vBHjgPXOWSZ8xbJbLnDRlsYhiexiEtPr
	ZeWU5fE8b4NqcH4669aasiH2/G+pga6E4TFYMifC8IwjdofuW8+14KTXGa0xSSizRdbdwO
	NiiLrJV2SUonBuUCSOr7lhtCtYk0yrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789990114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/NfxikMW0an5SBYmu5hTO0LNfhoBM9wQ5NRZpY/GkJg=;
	b=q9sV4Syuc7Wxfkin30dX96s50DF4uOIkMWFpIK4WE9d3ndBN1rjWglS1I3tvXCzPuI7g1O
	7g6j71cO/Ixi6WDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A249A1368D;
	Mon, 21 Sep 2026 11:28:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QCrYHuIUsWp0fAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 21 Sep 2026 11:28:34 +0000
Date: Mon, 21 Sep 2026 13:28:33 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Daniel Wagner <wagi@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzbot+77955102efac681ec73b@syzkaller.appspotmail.com
Subject: Re: [PATCH] nvmet-fcloop: fail LS request synchronously when remote
 port is gone
Message-ID: <2ad8b13c-b548-4574-9c61-5224833e1bad@flourine.local>
References: <20260920163804.67858-1-ngocthang2710.1999@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920163804.67858-1-ngocthang2710.1999@gmail.com>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[77955102efac681ec73b];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,lst.de,grimberg.me,nvidia.com,kernel.org,suse.de,lists.infradead.org,vger.kernel.org,syzkaller.appspotmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_042847_429264_0D4637FF 
X-CRM114-Status: GOOD (  12.96  )
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

On Sun, Sep 20, 2026 at 11:38:04PM +0700, Nguyen Ngoc Thang wrote:
> fcloop_t2h_ls_req() handles a missing remoteport by queueing the request
> on tport->ls_list and completing it with -ECONNREFUSED from a work item.
> 
> nvmet_fc_delete_assoc_work() sends the Disconnect Association LS this
> way. When it runs during nvmet_fc_unregister_targetport(), the work is
> queued after flush_workqueue() has started, so it is not waited for.
> nvmet_fc_free_pending_reqs() then frees the still-pending lsop and the
> late work item calls lsreq->done() on freed memory:
> 
>   BUG: KASAN: slab-use-after-free in fcloop_rport_lsrqst_work+0x242/0x2e0
>   Workqueue: nvmet-wq fcloop_tport_lsrqst_work
>   Allocated by nvmet_fc_xmt_disconnect_assoc
>   Freed by nvmet_fc_free_pending_reqs
>            nvmet_fc_unregister_targetport
>            fcloop_delete_target_port
> 
> Return -ECONNREFUSED directly instead. __nvmet_fc_send_ls_req() unwinds
> and nvmet_fc_xmt_disconnect_assoc() frees the lsop, so no completion is
> left outstanding.

IIRC this has been added to free memory in a different execution
scenario. So I don't think you can just skip it.

And this is also a change in the behavior between HBA's behaviour in the
loopback behavior.

