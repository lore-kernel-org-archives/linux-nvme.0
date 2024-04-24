Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13CEC4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 12:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3O+eLxdYAF6bkHqp83YpWX0eof1PThwEJfivUOb23Lg=; b=NBH3Bm6/VNT2WMsWd9hLM6dRXM
	oGVgtcXqv/tSak44QZd0kaEdRscO/Xx2SVe4KZFO3v4tdD7d1GzeHKBdDo0qmvH4OZWloKj3SpxYC
	ZCZPSpFQklVCfDfcVqeKya32T7pw1PZfhiRS7BnY9YuH+MLb65lRbWzAr8CBFvzjkJz4u8hK0Wuxy
	ZgpAlevEO2pbDNPdSoS1YMebl1qsDoE21tS51nDxKjvejBKBkLAaGJMMyrrCZazEP+ZEP6cC49Hze
	XqLQ1aq14/BIQUeb+gRDWrvSGnAuZaC1VdnIJsJ1KbE/RgaFotyDu661Vnt/bZYC5xRW3E3Rmkbvy
	CMtudt+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzbji-000000044OM-2YNE;
	Wed, 24 Apr 2024 12:28:30 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzbje-000000044N8-1D7U
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 12:28:29 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9522866D82;
	Wed, 24 Apr 2024 12:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3O+eLxdYAF6bkHqp83YpWX0eof1PThwEJfivUOb23Lg=;
	b=E0fVq+Ygse1z/uWjC6iQ+wc32zujLcN/en/s0JUPOnflqhkPjrSPXMHJNrSBfX2zgVv76l
	4V3MqowQyDrZB4KdBCfPMl5/Ra9OjV2vMoagEbLiHjunesXb3IIg2YIjqD4JNYMMA1aQSw
	TPhnbU4RqA1JrpxqNuNcg+UTuAMhPXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3O+eLxdYAF6bkHqp83YpWX0eof1PThwEJfivUOb23Lg=;
	b=U6gxe5axNlNOLncQv8uWy0F2XEDE3r/1WGKemO8co+HglnyEh2TzkWs71hXsjxRXweEECW
	E00XQSnK33t0J3Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3O+eLxdYAF6bkHqp83YpWX0eof1PThwEJfivUOb23Lg=;
	b=E0fVq+Ygse1z/uWjC6iQ+wc32zujLcN/en/s0JUPOnflqhkPjrSPXMHJNrSBfX2zgVv76l
	4V3MqowQyDrZB4KdBCfPMl5/Ra9OjV2vMoagEbLiHjunesXb3IIg2YIjqD4JNYMMA1aQSw
	TPhnbU4RqA1JrpxqNuNcg+UTuAMhPXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3O+eLxdYAF6bkHqp83YpWX0eof1PThwEJfivUOb23Lg=;
	b=U6gxe5axNlNOLncQv8uWy0F2XEDE3r/1WGKemO8co+HglnyEh2TzkWs71hXsjxRXweEECW
	E00XQSnK33t0J3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A54D1393C;
	Wed, 24 Apr 2024 12:28:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2ke1Ief6KGaibgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 24 Apr 2024 12:28:23 +0000
Date: Wed, 24 Apr 2024 14:28:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v3 06/15] nvme/rc: introduce NVMET_TRTYPES
Message-ID: <436qpoiaezdnkm3xdtlcbzy7n5ee4kobhfqsvst27si67a46gh@msehpblovq5d>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-7-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424075955.3604997-7-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
X-CRM114-CacheID: sfid-20240424_052826_526515_1D0EF42A 
X-CRM114-Status: GOOD (  12.55  )
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

On Wed, Apr 24, 2024 at 04:59:46PM +0900, Shin'ichiro Kawasaki wrote:
> Some of the test cases in nvme test group can be run under various nvme
> target transport types. The configuration parameter nvme_trtype
> specifies the transport to use. But this configuration method has two
> drawbacks. Firstly, the blktests check script needs to be invoked
> multiple times to cover multiple transport types. Secondly, the test
> cases irrelevant to the transport types are executed exactly same
> conditions in the multiple blktests runs.
> 
> To avoid the drawbacks, allow setting multiple transport types. Taking
> this chance, rename the parameter from nvme_trtype to NVMET_TRTYPES to
> follow the uppercase letter naming guide for environment variables.
> NVMET_TRTYPES can take multiple transport types like:
> 
>     NVMET_TRTYPES="loop tcp"
> 
> Introduce _nvmet_set_nvme_trtype() which can be called from the
> set_conditions() hook of the transport type dependent test cases.
> Blktests will repeat the test case as many as the number of elements in
> NVMET_TRTYPES, and set nvme_trtype for each test case run.
> 
> Also introduce _NVMET_TRTYPES_is_valid() to check NVMET_TRTYPES value
> before test run.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

