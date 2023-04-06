Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16235C76196
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 08:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vsg1dyrlBthwxSnhm3PHglz+LBV9NS/qe4M2IkHmNKM=; b=yyOjnsOmxx9GqM/m+I44K2ktgG
	eHKPm4bODLiKaga0HZSDeAmoX2Lm/vqMq+SBRa3E+9EOYazCueR8bGdQ8WkfNHNSUNKdbNvYacb52
	g55oF37J5aszRqChZgMIEyXymwwbmZHRPPZnGU2HhFP+dl6tCQ9bTK/ftbeXtzihItq256UOzFstr
	ZqJziBYv0JyHyuifiC59JjoiviC8FOgMVCn+1wNNhGOLSeL1pv+G/Zv8IqyswRe4zUcZsV9Ywchfi
	Dftypkori1jUQop8sBGh7IzSv74UlmuFY06ULF+YapwyMSekNrM1GtL0FZCwxpPrNEPXDaBPSoD5w
	EX6SDUIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkL7j-006mFi-12;
	Thu, 06 Apr 2023 08:37:39 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkL7g-006mEn-1g
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 08:37:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 47CAA1FD90;
	Thu,  6 Apr 2023 08:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680770253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vsg1dyrlBthwxSnhm3PHglz+LBV9NS/qe4M2IkHmNKM=;
	b=QvU7FngFkubiq0bRvIVkXPAsFE0KY11jgV5uissOlfIJCcIRVmpGzZx5l24BCwuA1LQRjo
	Kz8Usj/T3Sr+3lvxeQS4uc6uSahzpq/alWDpcv/OAVn4jYQIBOZwlxlL0eF9cCbqtmHd3j
	6I8LgweANumU9bqOOKbeIji9MFebMAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680770253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vsg1dyrlBthwxSnhm3PHglz+LBV9NS/qe4M2IkHmNKM=;
	b=c560stvTNE1FxQ1RVJaQHHTCj+BgcKpf9O0RxjRR3kFX9WGjjl+IcPXMv/czZAT7Eo7GaR
	FBH5zKzv8QOpNqAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3ABE0133E5;
	Thu,  6 Apr 2023 08:37:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id sR1TDs2ELmTMaAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 06 Apr 2023 08:37:33 +0000
Date: Thu, 6 Apr 2023 10:37:32 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	James Smart <jsmart2021@gmail.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v6 2/2] nvme/048: test queue count changes on
 reconnect
Message-ID: <u34skcorm2t3mzwplerudnja6ruvpbooqufjmrsulvwqqirkwo@li3lv5gq5cej>
References: <20230406083050.19246-1-dwagner@suse.de>
 <20230406083050.19246-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406083050.19246-3-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_013736_708850_F74E1DEA 
X-CRM114-Status: UNSURE (   8.18  )
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

On Thu, Apr 06, 2023 at 10:30:50AM +0200, Daniel Wagner wrote:
> +test() {
> +	local subsys_name="blktests-subsystem-1"
> +	local cfs_path="${NVMET_CFS}/subsystems/${subsys_name}"
> +	local file_path="${TMPDIR}/img"
> +	local skipped=false
> +	local hostnqn
> +	local hostid
> +	local port
> +
> +	echo "Running ${TEST_NAME}"

I think I missing a _nvmet_setup call here.

