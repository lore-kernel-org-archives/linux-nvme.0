Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3A1C25B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 12:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ua6JW+plmR5FfiI4xxAVzpYFa9SOk6Czkym6dfSngfo=; b=HdKTiH119jIeE0j10pTmLvXAnC
	/DMSHTctgze6gqgJosk7AcBhBqgH2qblEKHNn9UfCw9jSNcMWC8z1W5FqSQOzfUBo0ZGQSOpojj3m
	GnZT6CCFzRTthNu50axxXF/31hKxX1yVrFq3bqXzyKidp18IsXK17A5csPNiw5s1NeYC12ZEGh9+4
	BXJrfj1hQL6vCbAbTqmZErxTFa7JaKPbJlYzJdu8/sV+//HIWFIpryrf2AYMMkNWDrRiqgsBleIbq
	BpRWXllxrgrZvA5kGCH4/GV3LrfvX6M+pExRdUxs2g/Lx8xyCHcg5TiFLH+PibcyppYbUS0leTLVs
	u3bW/IQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9lU1-00000002yo0-2U8x;
	Wed, 22 May 2024 12:54:17 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9lTv-00000002ymJ-0zAo
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 12:54:16 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 90C7834D11;
	Wed, 22 May 2024 12:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716382447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ua6JW+plmR5FfiI4xxAVzpYFa9SOk6Czkym6dfSngfo=;
	b=mCX+we6tVFUowAq0WNSD00OoXJX10HCMo/AALreOkdAkVDGaMNnpAxjbZ8xBg9uhgeqAXp
	FHZXIWb3EuS7EScX8qjsD4z9ZPaiWhwrdyKBF8iDac/1m1x29C7NHZSlnjrT71eMuaDmWT
	Uiq/bYpHdcE6seWfXRJJHR12BHNtBwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716382447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ua6JW+plmR5FfiI4xxAVzpYFa9SOk6Czkym6dfSngfo=;
	b=LBaUr1QSXkGt9aR2dhoHuiBv7+yELWvgZushKzp/Yh++hk6SQ98j79kFkHrZOcQdFGlwAH
	Ya3W7bmdX4V8WnDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mCX+we6t;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LBaUr1QS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716382447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ua6JW+plmR5FfiI4xxAVzpYFa9SOk6Czkym6dfSngfo=;
	b=mCX+we6tVFUowAq0WNSD00OoXJX10HCMo/AALreOkdAkVDGaMNnpAxjbZ8xBg9uhgeqAXp
	FHZXIWb3EuS7EScX8qjsD4z9ZPaiWhwrdyKBF8iDac/1m1x29C7NHZSlnjrT71eMuaDmWT
	Uiq/bYpHdcE6seWfXRJJHR12BHNtBwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716382447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ua6JW+plmR5FfiI4xxAVzpYFa9SOk6Czkym6dfSngfo=;
	b=LBaUr1QSXkGt9aR2dhoHuiBv7+yELWvgZushKzp/Yh++hk6SQ98j79kFkHrZOcQdFGlwAH
	Ya3W7bmdX4V8WnDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7400B13A6B;
	Wed, 22 May 2024 12:54:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l8DoGu/qTWZ3YwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 22 May 2024 12:54:07 +0000
Date: Wed, 22 May 2024 14:54:06 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2] libnvme: Introduce functions to generate host
 identifier and host NQN
Message-ID: <fxwpekgunkujdtea6qiysdfnik2vupjkvcss7qgplamhqgozkz@2humlfy4irig>
References: <1713450277-20323-1-git-send-email-israelr@nvidia.com>
 <1713450277-20323-2-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713450277-20323-2-git-send-email-israelr@nvidia.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 90C7834D11
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.89 / 50.00];
	BAYES_HAM(-2.88)[99.47%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_055411_455439_D10FA0F6 
X-CRM114-Status: GOOD (  11.61  )
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

On Thu, Apr 18, 2024 at 02:24:37PM GMT, Israel Rukshin wrote:
> The nvmf_hostid_generate() function generates a machine specific
> host identifier. This is useful when the host ID can't be derived
> from an NQN that doesn't contain a UUID.
> Also, add nvmf_hostnqn_generate_from_hostid() to explicitly set UUID
> when hostid is not NULL.
> 
> Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Both patches applied.

Thanks,
Daniel

