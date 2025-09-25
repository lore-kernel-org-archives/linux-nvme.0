Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49708CAC5AA
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Sep 2025 07:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ohGoJsSHACIwVtLSwLfdaLPfpRuEO5FFryROoTRQSCA=; b=b1mmagHaOGGNXCsHHMivV4c7Xx
	Fv69GOmpmCcxXOt7r7auNg7vK7dVTcmO7NC/Ll0Zf0mc67NPNqFdMKxZL4D02a8IAwjJUHRcLnfpB
	ywqmfCcMNL3CQTBJkDwt/UDQ9i9IJ2HQEuNkttizpTg6oeKp9X5Sj6YMU0VSMcmNGfJeoe2QQwYPX
	P/JI6D2Y07i5nV/J1Lb1Si0yy+54+c2pDlDTkBQuqPbLTo2XL9SrJwbsOjf+6xDSQ/GHfawx8ax13
	C7AEbcdANP2Fi/gCZax6Zl0C3s4xelFn5McxdLE/1uaEuSk1w/R65I0UkcIfeO/9RBWKhMKFvV8RC
	9ogNVTgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1gWR-00000006lkc-07Uv;
	Thu, 25 Sep 2025 07:36:11 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1gWO-00000006ljg-1v9R
	for linux-nvme@lists.infradead.org;
	Thu, 25 Sep 2025 07:36:09 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02A644DAED;
	Thu, 25 Sep 2025 07:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758785764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ohGoJsSHACIwVtLSwLfdaLPfpRuEO5FFryROoTRQSCA=;
	b=BSevNaGjpVp5UzK4tVvAEB+DgHL/z4xILa5YvddVG011aiSRDsVpEIciOaOUe0J6D2djfI
	x+Ru5MHx/mGt/SobQ8SRgcGj30o1R9Gg6WxH3DaM/7JOSTF7ELZArn9bYF9e0TC1u8cJGc
	QR4tsBHevdzlLSP2nlQ0w3/Z/3Yxgwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758785764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ohGoJsSHACIwVtLSwLfdaLPfpRuEO5FFryROoTRQSCA=;
	b=+KVIBElwAgjVnaHo5nwTIJrIN6qVEYrDobdQh/P1U6eKpio8yNoWw3R++qVShcJMlvfEvY
	cO7Zq9EsbOe8smDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758785764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ohGoJsSHACIwVtLSwLfdaLPfpRuEO5FFryROoTRQSCA=;
	b=BSevNaGjpVp5UzK4tVvAEB+DgHL/z4xILa5YvddVG011aiSRDsVpEIciOaOUe0J6D2djfI
	x+Ru5MHx/mGt/SobQ8SRgcGj30o1R9Gg6WxH3DaM/7JOSTF7ELZArn9bYF9e0TC1u8cJGc
	QR4tsBHevdzlLSP2nlQ0w3/Z/3Yxgwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758785764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ohGoJsSHACIwVtLSwLfdaLPfpRuEO5FFryROoTRQSCA=;
	b=+KVIBElwAgjVnaHo5nwTIJrIN6qVEYrDobdQh/P1U6eKpio8yNoWw3R++qVShcJMlvfEvY
	cO7Zq9EsbOe8smDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E837F13869;
	Thu, 25 Sep 2025 07:36:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xu28N+Pw1Gj4MgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 25 Sep 2025 07:36:03 +0000
Date: Thu, 25 Sep 2025 09:36:03 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org, 
	sagi@grimberg.me, kch@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 3/4] nvmet: prevent max_qid changes for discovered
 subsystems
Message-ID: <97291788-f831-469c-b0cd-7fd79678366e@flourine.local>
References: <20250924202604.7201-1-mgurtovoy@nvidia.com>
 <20250924202604.7201-4-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924202604.7201-4-mgurtovoy@nvidia.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_003608_642502_4C572D75 
X-CRM114-Status: GOOD (  12.36  )
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

On Wed, Sep 24, 2025 at 11:26:03PM +0300, Max Gurtovoy wrote:
> Disallow updates to the max_qid attribute via configfs after a
> subsystem has been discovered. This prevents invalid configuration
> and avoids races during controller setup. The maximal queue
> identifier can now only be set on non-discovered subsystems,
> ensuring consistent configuration state.

IIUC, this change will break an existing blktests where it tests if
the max queue changes on reconnect. This took a while to fix in the host
and the very reason the disconnect call is buried in the max queue
update. blktests nvme/048 

The scenario where this happens if you have a multi node target and one
node after the other gets a new firmware. For some reason the number of
max queue changes in the new firmware. When the host fails over to an
updated node the host can't blindly reuse the old queue max:

555f66d0f8a3 ("nvme-fc: update hardware queues before using them")

So if we find a way to keep this tests scenario alive I don't mind. But
as I said I think this will break it.

