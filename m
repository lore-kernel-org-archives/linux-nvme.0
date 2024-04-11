Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161E6C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Apr 2024 18:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=obp8ppy5jmNsb0WQYhzgwfoTID/QFmO8yekV59qwSBU=; b=pboM55lpRL5u3MCmoCBEXhgzxI
	KJyWSZgTOjru1TuSLXt2r7V5uiG0pmOeO4hJiOnyfUgDcqddzkhCQSUBWHT4voTO60NVEXwN/7ryl
	jTfqCSflUHPvdJ1t1QCSTgcy/K7r204T+iCPZrb8yhpECFI0xaC2lgIA2UlZ7MoScSfeqyWVpm0ks
	lJKtrUuCFAmN6SDCCCyBtSVsfMkEBEwaD1LeSNCE97OpX/VsEw0GYGiMOvZRW4jCU8KrlHTuC7jxX
	VKWesu//D63bmg27UVZhI/6OiZxaam5IERR7AOf1+FM2rENN5axha+g9om6+MLML1rEciiubQdb7x
	3iLr25vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruzPB-0000000DkkS-2KK5;
	Thu, 11 Apr 2024 18:44:13 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruzP4-0000000Dkgs-2E4j
	for linux-nvme@lists.infradead.org;
	Thu, 11 Apr 2024 18:44:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D35E037812;
	Thu, 11 Apr 2024 18:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712861044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obp8ppy5jmNsb0WQYhzgwfoTID/QFmO8yekV59qwSBU=;
	b=DZTmhi7QWFL7+Cel05fW3P+z1u9OXUlFB9tU/AOsxtAgWSMUnaPo3YPizQZTUMVK6ptSCm
	928mAlWd8ZdNYyAW+JW2o9dr+TOW62+PO9FCMbSoJj+nhJ7fi9u5RxHD1mec/5ORjBF51l
	/f8LupVZJUI3sXdXxFFsDTp0aT2hfhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712861044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obp8ppy5jmNsb0WQYhzgwfoTID/QFmO8yekV59qwSBU=;
	b=RoW1tudImiFmwvmEGnUIHIOak9KgAjIZRLH2qnGHv89vCZrVSHFddOQ6URC9pEruV41Edl
	nW3UoVFrJiTIYVAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wXqrKLLN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n0XDyI6Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712861043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obp8ppy5jmNsb0WQYhzgwfoTID/QFmO8yekV59qwSBU=;
	b=wXqrKLLNx/kR5EDKMfFIbIDl6cPswWRuGmvVz+K+OhkP6+CWvku5xOgZn5ZMp4gbA8DoTf
	ZtUgcv/n8b/+hvzAzagZqBaP3XVnz3zaTDrGnawJjsJo4DsVVJ0iuWie176ODbmqdzpRnc
	ZM1SrCD7wgI18m/8VVwnKPBjDmcTWMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712861043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obp8ppy5jmNsb0WQYhzgwfoTID/QFmO8yekV59qwSBU=;
	b=n0XDyI6Yl+JTuYsRoaEn8W3lPjbZb6GJeOe7F2jGrP3SfadR1MmXipNlprS3w4SkWUcYBF
	0F6CQylz2Eo/YqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC52E13685;
	Thu, 11 Apr 2024 18:44:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ogGnLHMvGGa/GgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 11 Apr 2024 18:44:03 +0000
Date: Thu, 11 Apr 2024 20:44:03 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests 07/11] nvme/rc: introduce NVMET_BLKDEV_TYPES
Message-ID: <xbrhdihng3oazsnanxi5egcidbxd5bwz7i5463volkp4uvgkn3@3nu6yyhx5utb>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
 <20240411111228.2290407-8-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411111228.2290407-8-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D35E037812
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_114406_764217_079C8633 
X-CRM114-Status: GOOD (  18.54  )
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

On Thu, Apr 11, 2024 at 08:12:24PM +0900, Shin'ichiro Kawasaki wrote:
> Some of the test cases in nvme test group do exact same test for two
> blkdev types: deice type and file type. Except for this difference, the
> test cases are pure duplication. It is desired to avoid the duplication.
> When the duplication is avoided, still it is required to control which
> condition to run the test.
> 
> To avoid the duplication and also to allow the blkdev type control,
> introduce a new configuration parameter NVMET_BLKDEV_TYPES. This is an
> array to hold default values (device file). Also add the helper function
> _set_nvme_trtype_and_nvmet_blkdev_type(). It sets up nvmet_blkdev_type
> variable for each test case run from NVMET_BLKDEV_TYPES. It also sets
> nvme_trtype from NVMET_TR_TYPES.
> 
> When NVMET_BLKDEV_TYPES and NVMET_TR_TYPES are set as follows, the test
> case with _set_nvme_trtype_and_nvmet_blkdev_type in set_condition() hook
> is called 2 x 3 = 6 times.
> 
>   NVMET_BLKDEV_TYPES=(device file)
>   NVMET_TR_TYPES=(loop rdma tcp)
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  Documentation/running-tests.md |  3 +++
>  tests/nvme/rc                  | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
> index ede3a81..ca11f58 100644
> --- a/Documentation/running-tests.md
> +++ b/Documentation/running-tests.md
> @@ -108,6 +108,9 @@ The NVMe tests can be additionally parameterized via environment variables.
>  - nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
>    Run the tests with the given transport. This parameter is still usable but
>    replaced with NVMET_TR_TYPES. Use NVMET_TR_TYPES instead.
> +- NVMET_BLOCK_DEV_TYPES (array)

NVMET_BLKDEV_TYPES ?

