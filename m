Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EB9C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 12:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RzcpT/vytrf890n1gAXnicwP1sw7mmYjErBiGRedM+s=; b=sxRWCtg5IF2mQDAqffXC1P6DTk
	cHX/uGpSYAE/o52cIE38CbLWV0ufh5a0dBvvYyqa/aRqevREBVFmFlUzx5OlVJYBkam7qyJrzAGTh
	BEy9LyRPNAkCizXfGxzyJNLQGEnWpeBs2YN0SQsusFnqS3r8xyu0fkzYPT811v/uoYkvON6O+LHaz
	RqZH3YAokNYVqWO5CIMNmjc8bGroLiTLmmZSlnGd5uBuJiG5dMOci7vr8N0EtW0FSLk6/keTReT9g
	NTmNoipR0iLkTpIvrqH/PjgkiYa0E7WrATau+lKAL4xLjxd+mmqPTJWcfqCnPl5OqiiMSc0UFqHPz
	FCSWBOLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzbkn-000000044lB-3CEt;
	Wed, 24 Apr 2024 12:29:37 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzbkg-000000044hB-18GJ
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 12:29:35 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BBB843F290;
	Wed, 24 Apr 2024 12:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzcpT/vytrf890n1gAXnicwP1sw7mmYjErBiGRedM+s=;
	b=oJCaTZyNOdotqXkKeRmbSJHay+nxTBULh9URIyOyn/IB9g0H2zB448DZg8mpkPko1OuWQS
	Hqdm4otskDlRR0/3ynQC4qxzbZsofIFHoxM2hQHNHoa3KCOdline398ehH1vGXyoL+Zwyb
	Yx2RxesFckHBRPT5IdvVMff+JGgk2c0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzcpT/vytrf890n1gAXnicwP1sw7mmYjErBiGRedM+s=;
	b=4DxDEY4w6zinoUMafkLD1z4MhwLvYrujEqYDLF+XidWvbPikO99wl2v65mskkzff9vXe7e
	3AwRmBTk/nCRdtAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzcpT/vytrf890n1gAXnicwP1sw7mmYjErBiGRedM+s=;
	b=oJCaTZyNOdotqXkKeRmbSJHay+nxTBULh9URIyOyn/IB9g0H2zB448DZg8mpkPko1OuWQS
	Hqdm4otskDlRR0/3ynQC4qxzbZsofIFHoxM2hQHNHoa3KCOdline398ehH1vGXyoL+Zwyb
	Yx2RxesFckHBRPT5IdvVMff+JGgk2c0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzcpT/vytrf890n1gAXnicwP1sw7mmYjErBiGRedM+s=;
	b=4DxDEY4w6zinoUMafkLD1z4MhwLvYrujEqYDLF+XidWvbPikO99wl2v65mskkzff9vXe7e
	3AwRmBTk/nCRdtAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF3BF1393C;
	Wed, 24 Apr 2024 12:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3LW9Kij7KGYAbwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 24 Apr 2024 12:29:28 +0000
Date: Wed, 24 Apr 2024 14:29:28 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v3 13/15] nvme/{rc,010,017,031,034,035}: rename
 nvme_img_size to NVME_IMG_SIZE
Message-ID: <rebzjpljyehrqst2ulhb2mler6gr2rjgzqmap6hqd2aeqscgf7@v7a2g2kx7iu4>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-14-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424075955.3604997-14-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_052930_509559_59E9CA41 
X-CRM114-Status: UNSURE (   7.67  )
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

On Wed, Apr 24, 2024 at 04:59:53PM +0900, Shin'ichiro Kawasaki wrote:
> To follow uppercase letter guide of environment variables, rename
> nvme_img_size to NVME_IMG_SIZE.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

