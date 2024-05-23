Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC09CC25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 09:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u5Rm2h6LS45KRM7p05Ma3ccWXWxSCgkeiNkYPPrpRiI=; b=VDxhR4vYxaAIloDlGxlzl8qus0
	Zl8kcgoih5HEAiY6mo1fXX94IK50ThizpCxDHLE5KRI5tSQnIXMh5NW5eToFUg5z2qGAS/eGxhaL/
	LVWsfXpor4bUkyFeFUHMPSA5f8iSUCaHs5beQ/rwgHn1Wg+M2Z4PFhoJ0w1Da8WbrTh7vGSg8ht5f
	Aw30BMJwiBA3dfBmgwxRuZ0zD2nk2HDSDsRkSzoCZsijzpJ9pjHIupNGRkj5UDhfzxBqdk6ZbAi7N
	X0njUOsSyw4BcYlKyOz11Qgh6xc+PlOkplWBpN3beuvc3t3QOZo0CEq3Z+W2TY1LI8ChbFRPD0t8w
	rKqJ41LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA4wE-00000005jK8-46jj;
	Thu, 23 May 2024 09:40:43 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA4w6-00000005jIR-0eIr
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 09:40:38 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5106822454;
	Thu, 23 May 2024 09:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716457231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5Rm2h6LS45KRM7p05Ma3ccWXWxSCgkeiNkYPPrpRiI=;
	b=RP7jwuCdlghbnQNESkhIcwkcjXZVXyAfgdOfjO8p5z/Ptmq+tF9PZTGYE8hlsYNaPrpiMk
	8X7YC+vI1yYlP6Hw9HU+DVGZ9gjUWwGAObOTE8Y+ucpUSX+GQt5ZelZPknHWsT/weKkdKd
	9m7oBMloQ6ALkqWiAnFKZalAQNH8vb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716457231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5Rm2h6LS45KRM7p05Ma3ccWXWxSCgkeiNkYPPrpRiI=;
	b=qiipYidpRPd27mP3to0LqTvERzpKC+NFEEIJ1FBUC+Ilr0zVFEmFIZcl5ynPYF6thaafhQ
	1ZZPXLY2mXs9RvCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716457231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5Rm2h6LS45KRM7p05Ma3ccWXWxSCgkeiNkYPPrpRiI=;
	b=RP7jwuCdlghbnQNESkhIcwkcjXZVXyAfgdOfjO8p5z/Ptmq+tF9PZTGYE8hlsYNaPrpiMk
	8X7YC+vI1yYlP6Hw9HU+DVGZ9gjUWwGAObOTE8Y+ucpUSX+GQt5ZelZPknHWsT/weKkdKd
	9m7oBMloQ6ALkqWiAnFKZalAQNH8vb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716457231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5Rm2h6LS45KRM7p05Ma3ccWXWxSCgkeiNkYPPrpRiI=;
	b=qiipYidpRPd27mP3to0LqTvERzpKC+NFEEIJ1FBUC+Ilr0zVFEmFIZcl5ynPYF6thaafhQ
	1ZZPXLY2mXs9RvCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 400BF13A6C;
	Thu, 23 May 2024 09:40:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zcE3Dw8PT2ZfVAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 23 May 2024 09:40:31 +0000
Message-ID: <c98dea7f-75de-47d7-965c-966dc265338f@suse.de>
Date: Thu, 23 May 2024 11:40:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-auth: unexport negotiate and wait functions
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
References: <20240208062427.31255-1-kch@nvidia.com>
 <20240208062427.31255-4-kch@nvidia.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240208062427.31255-4-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_024034_382295_D1387279 
X-CRM114-Status: UNSURE (   8.98  )
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

On 2/8/24 07:24, Chaitanya Kulkarni wrote:
> Now that post connect functionality is moved from host/fabrics.c to
> host/auth.c we don't need nvme_auth_wait() and nvme_auth_negotiate() to
> be exported from nvme authentication code, unexport them to make it
> private.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/auth.c |  6 ++----
>   drivers/nvme/host/nvme.h | 10 ----------
>   2 files changed, 2 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



