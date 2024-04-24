Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48F4C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 12:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pSu2WIroNaqViDCfEfNhyd5e6UMGcjb/EgwDzXHjJqg=; b=BuPvlu8yuzVqbaQZFKbPDL3Sxp
	vrAcCLibXF+ZUZnqBn6xTEgsKyJQR0Xc7yPaeIZkPpaRy8vXs6AHG0tG6BAIIsKbRlVpia3HDcLS1
	s+/7QnM8frEuWGhv1qcQbJPCInqlWuaDJczCuElHfPjEzM31r+eq4wgjCSNa8K+o8cLshyn85redG
	mQsC/91HbBWGlESquMQzT82ShRsgkPQqo661UnyRpikAbO2btedb1VfjiF+nInlf0esDDo8ZBuhH8
	naWmegf0Sjib8wlJ6MrrciR1U8o1eHJKE5GFj4R6lN/IKIi/m86G4AHZ9EQdcKIFzAT+JJKAF/M/B
	elkpfUGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzboP-000000045dR-3DII;
	Wed, 24 Apr 2024 12:33:21 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzboJ-000000045cN-47nS
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 12:33:19 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C62766D87;
	Wed, 24 Apr 2024 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSu2WIroNaqViDCfEfNhyd5e6UMGcjb/EgwDzXHjJqg=;
	b=JM+oj8kA2V3G95bx+S4i/QcQifsngg7DjkuNvDTwJrap+AAiV0C94cL3ox1w44sB+Rtivj
	XYW/v9clKXhAQ2GtLeEczrRm3wqmT/lRuIzmcnWgQ2vYa28LSmVIyqOKQMl4ZscTYjRZTu
	ZyG0wU/0OuS1P7hoTgWvFwKMnjSqKtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSu2WIroNaqViDCfEfNhyd5e6UMGcjb/EgwDzXHjJqg=;
	b=FFTXCVWthE4JWGw8RZSbK7lJzlgm060dxvs/sOPRM3q/LXc5Dy593Nz57yabID4wHsmASl
	7CDlRCH5u6E0z/Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSu2WIroNaqViDCfEfNhyd5e6UMGcjb/EgwDzXHjJqg=;
	b=JM+oj8kA2V3G95bx+S4i/QcQifsngg7DjkuNvDTwJrap+AAiV0C94cL3ox1w44sB+Rtivj
	XYW/v9clKXhAQ2GtLeEczrRm3wqmT/lRuIzmcnWgQ2vYa28LSmVIyqOKQMl4ZscTYjRZTu
	ZyG0wU/0OuS1P7hoTgWvFwKMnjSqKtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSu2WIroNaqViDCfEfNhyd5e6UMGcjb/EgwDzXHjJqg=;
	b=FFTXCVWthE4JWGw8RZSbK7lJzlgm060dxvs/sOPRM3q/LXc5Dy593Nz57yabID4wHsmASl
	7CDlRCH5u6E0z/Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FAB11393C;
	Wed, 24 Apr 2024 12:33:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UOneDgr8KGZkcAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 24 Apr 2024 12:33:14 +0000
Date: Wed, 24 Apr 2024 14:33:09 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v3 15/15]
 nvme/rc,srp/rc,common/multipath-over-rdma: rename use_rxe to USE_RXE
Message-ID: <fmleopq3aey644hrnnlvlrwajqwapsq6wetl2vecrt6wq7kb6t@eclzulglhelh>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-16-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424075955.3604997-16-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_053316_197947_E7D00367 
X-CRM114-Status: UNSURE (   9.00  )
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

On Wed, Apr 24, 2024 at 04:59:55PM +0900, Shin'ichiro Kawasaki wrote:
> To follow uppercase letter guide of environment variables, rename
> use_rxe to USE_RXE.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

>  	{
> -	if [ -z "$use_rxe" ]; then
> +	if [ -z "$USE_RXE" ]; then

Maybe use the opportunity to use switch to "${USE_RXE}" form of the
variable access when you are touching these lines?

