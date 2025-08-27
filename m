Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E4CCA0EFF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Aug 2025 14:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NxE5rKnj5TjaBsXbpbII/rsOANqwX+dNrTnexSalI0E=; b=iaPQGf9zFp8pPL/kYIBzuoexL7
	Xl+5muHOymDgpYOvt5Ng84RYYa8I/npWCm5kF9HwdPCb9FSu7ZNsPCwyoiZz/0dTCUsHFmw0rqsPl
	egyto8xQOhTb2DhMQcT1GDtOCtLsi9eXEuFpikNrT/IlQv0Wa1m3bW/OYIIUFpR1SuHcszu3opJnH
	wQSniDgwekMZ8sjzF6a3JpIz/XDu9NDb4354mPTMUiCmfg4ZoDSnDRadzRx4/uzweNAVyLBL4g46q
	Wd30zRtV/uixyKGLaxyfYl9Xouk2W+k9Mq+Bfv8DCJGK0VTFMjU9UovriNQINTtOPFTlPV6IhIKAV
	xqkvp/8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urGpD-0000000FgpE-3jc9;
	Wed, 27 Aug 2025 14:08:31 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urDFU-0000000F2Ms-429L
	for linux-nvme@lists.infradead.org;
	Wed, 27 Aug 2025 10:19:26 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1304D22221;
	Wed, 27 Aug 2025 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756289427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NxE5rKnj5TjaBsXbpbII/rsOANqwX+dNrTnexSalI0E=;
	b=Sx5RwQl4mdrvGKXWphXUQ0hvtykvK3pbomkWvnnY3C/J3xN+x2ZHAOSBJLxC4GLt4+IHP6
	fhIb397Tjh7ZItBttJVZrcn5W6MbblkxSPnUuMkh2m4qZnlZylUmCvuzsNJNQDI/fgYDPT
	CxFKOH1aH8JG61b+9eFz6FNE5WZULgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756289427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NxE5rKnj5TjaBsXbpbII/rsOANqwX+dNrTnexSalI0E=;
	b=IydAXml5RA8wO5fCwvDAMvtOzsuRqzJS78ZPyZQjET5bKCdXt3mdY6VsEVH2Z8wcR9Zny6
	ul1gwma8lALLX1Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756289427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NxE5rKnj5TjaBsXbpbII/rsOANqwX+dNrTnexSalI0E=;
	b=Sx5RwQl4mdrvGKXWphXUQ0hvtykvK3pbomkWvnnY3C/J3xN+x2ZHAOSBJLxC4GLt4+IHP6
	fhIb397Tjh7ZItBttJVZrcn5W6MbblkxSPnUuMkh2m4qZnlZylUmCvuzsNJNQDI/fgYDPT
	CxFKOH1aH8JG61b+9eFz6FNE5WZULgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756289427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NxE5rKnj5TjaBsXbpbII/rsOANqwX+dNrTnexSalI0E=;
	b=IydAXml5RA8wO5fCwvDAMvtOzsuRqzJS78ZPyZQjET5bKCdXt3mdY6VsEVH2Z8wcR9Zny6
	ul1gwma8lALLX1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 038D713310;
	Wed, 27 Aug 2025 10:10:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z+iAO5LZrmg1JQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 27 Aug 2025 10:10:26 +0000
Date: Wed, 27 Aug 2025 12:10:26 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.17-rc1 kernel
Message-ID: <ff748a3f-9f07-4933-b4b3-b4f58aacac5b@flourine.local>
References: <suhzith2uj75uiprq4m3cglvr7qwm3d7gi4tmjeohlxl6fcmv3@zu6zym6nmvun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <suhzith2uj75uiprq4m3cglvr7qwm3d7gi4tmjeohlxl6fcmv3@zu6zym6nmvun>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250827_031925_147239_297623F3 
X-CRM114-Status: UNSURE (   9.43  )
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

On Wed, Aug 13, 2025 at 10:50:34AM +0000, Shinichiro Kawasaki wrote:
> #4: nvme/061 (fc transport)
> 
>     The test case nvme/061 sometimes fails for fc transport due to a WARN and
>     refcount message "refcount_t: underflow; use-after-free." Refer to the
>     report for the v6.15 kernel [5].
> 
>     [5]
>     https://lore.kernel.org/linux-block/2xsfqvnntjx5iiir7wghhebmnugmpfluv6ef22mghojgk6gilr@mvjscqxroqqk/

This one might be fixed with

https://lore.kernel.org/linux-nvme/20250821-fix-nvmet-fc-v1-1-3349da4f416e@kernel.org/

