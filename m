Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A099DD6E2A7
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 09:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hiluTQQR2o92Zl6mrllJbOdtvoBRARmaNFlSmeaix1o=; b=FHiKjQb2kAWgOeRMkLW6rcKoZx
	S7n7Ntht5ztHTywnOtDTapKCqvVLVJXBZFU7lqkbyq5PknKpYox2/hgROyfFaojA1CHOFa/DFMVsK
	bOdgsmlmv/t8sQpz39evaU00yLIxkOCLcOE2HWjYey7NIuDtSF6+Vtdz4Y2Vfdkj/CSO2k1svmem0
	RB5HFL/ZjjDaZhVERtA0XVwPvzCfw/mIinx3XEO4FY9hzfpLXpfOh4PkjmkouJS9SmPMGk8UDoUe+
	A18hdqw5fsA2BPfsLuvRZvFXo6QhtueAIoU2sHmT3+lfDo2p2xigRn556f/WMpMjKmaRcSBfR5pXP
	XOXO8J8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE3v5-0000000HI4K-3quQ;
	Thu, 21 Nov 2024 09:56:15 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE3v3-0000000HI31-34XP
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 09:56:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C2C0B1F7C8;
	Thu, 21 Nov 2024 09:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732182970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hiluTQQR2o92Zl6mrllJbOdtvoBRARmaNFlSmeaix1o=;
	b=M3304OJDEqLUJxEQLUQjPANoqsrSONABftmrX0FKJB6T63aXtWi0MGM5UO4cFT9mVtCsDr
	bJpdicosdOflwLr8IIBiortGAMxrGFY38rDM0gDFirncD7/WPbrY9YgCz5hxyoxwu9GLg/
	cO1ExWEwa8WX2go3kYlfllA7FfL65ZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732182970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hiluTQQR2o92Zl6mrllJbOdtvoBRARmaNFlSmeaix1o=;
	b=6LEWRxnYc5UZr5vpN+zK/M2Ksf9GEd0zCzsDXwsAhf/pBn5ESRRIfitKDbcuvJbDJqeuRT
	MAEFJUBCnpooABDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=b6txS9v2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xkaD7PFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732182969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hiluTQQR2o92Zl6mrllJbOdtvoBRARmaNFlSmeaix1o=;
	b=b6txS9v2U+rst3JV1IRU/cFrcrzlPA0VkB0Ol0O1INJu86TV9fhsmfAS1Nm6U5r29+HCpg
	ozrik/BHeRdguqOfBiGg3o1TONUNFVyszDqISxjfa8BKx8YirmkdiNadYpDYWqyfjK0XQy
	aPowfmddCwD3JzIxbXbCMMkjhXyrByA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732182969;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hiluTQQR2o92Zl6mrllJbOdtvoBRARmaNFlSmeaix1o=;
	b=xkaD7PFFPhGGlIAUx9qbFcq3+3NFmj1+7Oqytu6EKJkIGU4lojgfwXC3PcqlPAjGNTWOc5
	bZhPxX7oGYqVjCAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8D9E13927;
	Thu, 21 Nov 2024 09:56:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g833JrkDP2fyYQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Nov 2024 09:56:09 +0000
Date: Thu, 21 Nov 2024 10:56:09 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests] nvme: delete all namespaces in
 _remove_nvmet_subsystem()
Message-ID: <93c8afaa-3949-4526-8295-9458a727c5be@flourine.local>
References: <20241120102051.247995-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120102051.247995-1-shinichiro.kawasaki@wdc.com>
X-Rspamd-Queue-Id: C2C0B1F7C8
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,flourine.local:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_015613_918190_875C7F48 
X-CRM114-Status: GOOD (  18.97  )
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

On Wed, Nov 20, 2024 at 07:20:51PM +0900, Shin'ichiro Kawasaki wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> A subsystem might have more than one namespace, so delete all of them in
> _remove_nvmet_subsystem().
> 
> This change was to be made before the commit 67e25d71bc58 ("nvme/052: do
> not create namespace when setting up the target"), which assumes that
> _remove_nvmet_subsystem() delets all namespaces. However, commit order
> was modified then the test case nvme/052 now fails without this commit.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [Shin'ichiro: resolved conflicts]
> Fixes: 67e25d71bc58 ("nvme/052: do not create namespace when setting up the target")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> This patch is a part of the ANA support work by Hannes. It was once included in
> the first series of the work, but it was dropped from the series to be included
> in the later series [1]. After the second series of the work was applied, Yi
> Zhang found nvme/052 fails [2]. It turned out that this patch is required for
> the one of the patches in the second series, which is the commit 67e25d71bc58
> ("nvme/052: do not create namespace when setting up the target").
> 
> Of note is that this patch also prepares for one of the new test cases to be
> included in the third series [3].
> 
> [1] https://lore.kernel.org/linux-nvme/20241024010025.2216242-14-shinichiro.kawasaki@wdc.com/
> [2] https://lore.kernel.org/linux-nvme/20241120024925.1397864-1-yi.zhang@redhat.com/
> [3] https://github.com/kawasaki/blktests/commit/31091d116eaea4e7d5ad3cf76e106d1085209c07

I see, I hoped we don't need it, as I do prefer to have explicit stuff.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

