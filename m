Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A606FC4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 12:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gkgcaQ0YFyTksYfTa/+pmIIo5echmxDVgyJAWq5qzZQ=; b=oigkDu2NJ+L9SgyYnsHLHMCjlG
	T9s7y/oSsj5Ato48bGU8Rq9O13a7+tAxE61h8N+17pcAeTFdmPQNXkvHusPBc3fzY67wJxLCBr1I0
	XO9OfVBbz7tHQEYiofcp2OM8IX3JlHCXu9f3wrRLdmNlZ+MV/vf3n6wRZooIdeCa0//GJzYMafuIr
	8iqeMmx2a9Y6BXf8KRi+HjR+7lWs01GfXqyZ8EwCxeRZBeqZTPVjKyx5KjHze6BybGT9NJ/Ij1vL4
	vOiyn+A4+KgmLFV3++mqr6oqCTaWvI1PKCdiQC4uvffNl5YW/+yzeHolrZZavpwq7WmtLXnzSUU1k
	N43+LSAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzbie-000000044AV-0CqC;
	Wed, 24 Apr 2024 12:27:24 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzbiW-0000000445C-1m1g
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 12:27:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A9C63487F;
	Wed, 24 Apr 2024 12:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkgcaQ0YFyTksYfTa/+pmIIo5echmxDVgyJAWq5qzZQ=;
	b=LRY1JJAhur+UzdQg1yOGsqr3qz5hQ0R5HgDpAghVbljhQYGPwmghGAojWXU8KlOP01Jea/
	PrH+PaFfnaUYA9OJLpH1n1oyk6fdk5AMGP9TA5BQu/B0ojbeVT+tWnthuJUcKxFhiV956r
	ShaZDHxyXvll3foZkZasS/y19Y1JOMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkgcaQ0YFyTksYfTa/+pmIIo5echmxDVgyJAWq5qzZQ=;
	b=FrEzMpz42eGas1H1fw35XlO0BjTbxUWvY2bOJjfLY3Dd9BiX8hrSD0vm77APfo+YjAozZw
	XgDS5niF7GtLr+CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkgcaQ0YFyTksYfTa/+pmIIo5echmxDVgyJAWq5qzZQ=;
	b=LRY1JJAhur+UzdQg1yOGsqr3qz5hQ0R5HgDpAghVbljhQYGPwmghGAojWXU8KlOP01Jea/
	PrH+PaFfnaUYA9OJLpH1n1oyk6fdk5AMGP9TA5BQu/B0ojbeVT+tWnthuJUcKxFhiV956r
	ShaZDHxyXvll3foZkZasS/y19Y1JOMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkgcaQ0YFyTksYfTa/+pmIIo5echmxDVgyJAWq5qzZQ=;
	b=FrEzMpz42eGas1H1fw35XlO0BjTbxUWvY2bOJjfLY3Dd9BiX8hrSD0vm77APfo+YjAozZw
	XgDS5niF7GtLr+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F9941393C;
	Wed, 24 Apr 2024 12:27:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L0WSA5v6KGZObgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 24 Apr 2024 12:27:07 +0000
Date: Wed, 24 Apr 2024 14:27:06 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v3 05/15] common/rc: introduce
 _check_conflict_and_set_default()
Message-ID: <aamzlwv36dlc4oaz67locs5iblwoaze33dri74mj7ch57rp7tj@4ad3642cuo3p>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-6-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424075955.3604997-6-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-3.59 / 50.00];
	BAYES_HAM(-2.79)[99.10%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_052716_697233_BA97126B 
X-CRM114-Status: GOOD (  13.49  )
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

On Wed, Apr 24, 2024 at 04:59:45PM +0900, Shin'ichiro Kawasaki wrote:
> Following commits are going to rename some config option parameters from
> lowercase letters to uppercase. The old lowercase options will be
> deprecated but still be kept usable to not cause confusions. When these
> changes are made, it will be required to check that both new and old
> parameters are not set at once and ensure they do not have two different
> values.
> 
> To simplify the code to check the two parameters, introduce the helper
> _check_conflict_and_set_default(). If the both two parameters are
> set, it errors out. If the old option is set, it propagates the old
> option value to the new option. Also, when neither of them is set, it
> sets the default value to the new option.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

