Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9494AC43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 13:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TjbctjuFPAx/Y9GSv1BiZ+QvAxO7Yt2SctPLOwm5iiU=; b=XO5FmgvzE9Op3uFdd+RkjhD6NP
	8fttHO2ZROBB994d6k/pnrn/2Hb+buefFFm7okvs4fbTIpkEj9iyPk/fNDej593SNxPPUa1NtekUG
	Vdg3MCdkLNyDHumk6gUhFPcwgCpgIcfKdgKWblAlfdfjQp01W6WAtI4zAm75SOfZeeBU7tjC+Q3Gq
	+usAVqEJWalYLXNRVQb0bJadovgoiJ15sSOEYcl6r4rym9xcDEaYJhcfmuDGkfzUWtrnNI3OevQvd
	61xPlD+PlFfeor0Cgy6fh5xTfoYq8pMO9codmHNwdYMPDmCH4Gk5YaE+OLboJln1Vlr2B5HNp/tsp
	5QwklLpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whoYj-00000002VzQ-2bNo;
	Thu, 09 Jul 2026 13:12:57 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whoYg-00000002Vxr-14RD
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 13:12:56 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D3A1761FA;
	Thu,  9 Jul 2026 13:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783602761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TjbctjuFPAx/Y9GSv1BiZ+QvAxO7Yt2SctPLOwm5iiU=;
	b=0s2216JNI11AOSxFBZLii6A53WRB5t9i27odIKC6wy/QznMGeNWdzhQJmlCkzL1TW73aH6
	g86lSdANNU8XRMLGJ2b8i1ydmJgVBdlFx711jNxbn2ViHpwnBeLTKsnXyIK2PbREd5Pd8z
	9vr0PvcvguEa3+sLgKWYHv4rD22IxCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783602761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TjbctjuFPAx/Y9GSv1BiZ+QvAxO7Yt2SctPLOwm5iiU=;
	b=vE+qcssU4rukXPjPRdKSQdM3vZdXlkBmSs9YuoH9wJgbHZHPARnvJj1hqV5O/wMGg+kTFJ
	RmfYVY49d7qE4VCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0s2216JN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vE+qcssU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783602761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TjbctjuFPAx/Y9GSv1BiZ+QvAxO7Yt2SctPLOwm5iiU=;
	b=0s2216JNI11AOSxFBZLii6A53WRB5t9i27odIKC6wy/QznMGeNWdzhQJmlCkzL1TW73aH6
	g86lSdANNU8XRMLGJ2b8i1ydmJgVBdlFx711jNxbn2ViHpwnBeLTKsnXyIK2PbREd5Pd8z
	9vr0PvcvguEa3+sLgKWYHv4rD22IxCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783602761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TjbctjuFPAx/Y9GSv1BiZ+QvAxO7Yt2SctPLOwm5iiU=;
	b=vE+qcssU4rukXPjPRdKSQdM3vZdXlkBmSs9YuoH9wJgbHZHPARnvJj1hqV5O/wMGg+kTFJ
	RmfYVY49d7qE4VCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 780A5779AA;
	Thu,  9 Jul 2026 13:12:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9U+OG0meT2plIQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 09 Jul 2026 13:12:41 +0000
Date: Thu, 9 Jul 2026 15:12:40 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, John Garry <john.g.garry@oracle.com>, 
	Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com, 
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v4 0/3] nvme: add ABI documentation for sysfs and
 configfs interfaces
Message-ID: <492e87dc-b176-4b1a-abc6-67043ad54e93@flourine.local>
References: <20260707121227.2274769-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707121227.2274769-1-kanie@linux.alibaba.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8D3A1761FA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_061255_229113_DA0B492B 
X-CRM114-Status: UNSURE (   9.33  )
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

On Tue, Jul 07, 2026 at 08:12:24PM +0800, Guixin Liu wrote:
> The NVMe host sysfs interfaces and target configfs interfaces lack
> ABI documentation under Documentation/ABI/. This series adds the
> missing documentation and updates MAINTAINERS accordingly.
> 
> Each attribute entry has been traced back to its original introducing
> commit via git archaeology to provide accurate Date, KernelVersion,
> and Contact information.

Looks good to me. Thanks a lot!

Reviewed-by: Daniel Wagner <dwagner@suse.de>

