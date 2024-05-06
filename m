Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099BCC10F16
	for <linux-nvme@archiver.kernel.org>; Mon,  6 May 2024 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=336FFaNHx/3TCllaOeROXkCMakCFaGBzqPqFJK97brQ=; b=HAFVHKUPOxTY5cqmk9SB1SXVZD
	dIvZgtpihc9Xfil3yPKvLUG12qsgU12MCIkxudGkod9pbpdlEMqZ4X8tPSgz+4bevlP7yMMEQn6Ym
	LVy7QuwqLDknjFoGGVeJb4nhNNagOWpkpES1PJ8+AZPWDItY29BnPeeJQ1S+LX1hous/1zuQXQ9CU
	10vl5cNR+sLGxFjefUDCLbwnp/6QP/pME65fxBdNkyrW3NZSIHhNBYB85zdrwmaRXe9tCP2u2+7Kp
	R3T3H/pnDJxbHKB+ZJ5g73+FrmVGD72w1XDGSCr55u2GK7/MxXNWZ+5Q5e+B6rwWgNx69yIakiSYO
	4ciQUdTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3zfG-00000007kQG-2kFT;
	Mon, 06 May 2024 14:50:02 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3zfC-00000007kNx-2ODS
	for linux-nvme@lists.infradead.org;
	Mon, 06 May 2024 14:50:01 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 63EDD5FEBE;
	Mon,  6 May 2024 14:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715006996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=336FFaNHx/3TCllaOeROXkCMakCFaGBzqPqFJK97brQ=;
	b=SL5+udpjAXfMhNXeLhVnbhlWtJbY41f2Rtyi+B9qPyIOUpXBecpcz44F5lvBq8y9/VOC8Y
	3fMePvzZVKA0p461qHRPFuO8hc/3ChMURl21WzUqMfC+8F0p88wPZ0DraN/6lwpwZMOqik
	TQiJsIcont9+X0USreafxRtqn35NDIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715006996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=336FFaNHx/3TCllaOeROXkCMakCFaGBzqPqFJK97brQ=;
	b=/W7JZHcYxw7uJb9JbJ3m5gpLMCDqvWIAZbey+ge58rukWQlcdn2HpGf8XbKA9+XJGjY5ry
	1fCvAbkohZONJxAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SL5+udpj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/W7JZHcY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715006996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=336FFaNHx/3TCllaOeROXkCMakCFaGBzqPqFJK97brQ=;
	b=SL5+udpjAXfMhNXeLhVnbhlWtJbY41f2Rtyi+B9qPyIOUpXBecpcz44F5lvBq8y9/VOC8Y
	3fMePvzZVKA0p461qHRPFuO8hc/3ChMURl21WzUqMfC+8F0p88wPZ0DraN/6lwpwZMOqik
	TQiJsIcont9+X0USreafxRtqn35NDIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715006996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=336FFaNHx/3TCllaOeROXkCMakCFaGBzqPqFJK97brQ=;
	b=/W7JZHcYxw7uJb9JbJ3m5gpLMCDqvWIAZbey+ge58rukWQlcdn2HpGf8XbKA9+XJGjY5ry
	1fCvAbkohZONJxAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50B971386E;
	Mon,  6 May 2024 14:49:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3ic/EhTuOGY/dwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 06 May 2024 14:49:56 +0000
Date: Mon, 6 May 2024 16:49:55 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v4 06/17] meta/{018,019}: add test cases to
 check _set_combined_conditions
Message-ID: <gfnazciuedsmphy5ccyad2vcmr64o34rc3zl7bqtjuigbmzrk7@epqq75bpw2bi>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
 <20240504081448.1107562-7-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504081448.1107562-7-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 63EDD5FEBE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240506_074958_782677_29A4E5C7 
X-CRM114-Status: UNSURE (   7.99  )
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

On Sat, May 04, 2024 at 05:14:37PM GMT, Shin'ichiro Kawasaki wrote:
> Add test cases to confirm that the helper _set_combined_conditions is
> working. meta/018 combines two hooks, and meta/019 combines three hooks.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

