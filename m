Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC54C7EE29
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jun 2023 09:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nfHFD1czxWDo3IknBcYnlZ2RKGFFHnaXgjk0J13dzyA=; b=jIxcgNyKec2sLp6LX09mWh8E9S
	LXOYP44AS6HmsZLnyiVvBVEubBap6R2DwEqpRzs6y0Nk5fDQnvrOPdjZakRk7/gm6w6GsZxL5jPTQ
	uKffP6uQ/vA7uybP9OdItxaeosAMNfVa+zNO90HHiRKKigZkMGYMRw2PI2XimzvZcONseatZRBwRM
	xjuhvR6z7C2tPiBtEghBXR/0iGMm7YHH8u+gN/mW24btMt1JHiT3J3sDO75grIgy6uWHFGtRyHMpz
	F2RrJmxexpvq+VRQGC/4ok8X4ZD7AHE+NPQNN4j+72VCfH60q5y/AiW2kWtzx3BIGbSJBa8vSjPbz
	BCxTLoGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4eBv-002f4A-35;
	Thu, 01 Jun 2023 09:01:55 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4eBt-002f3c-0b
	for linux-nvme@lists.infradead.org;
	Thu, 01 Jun 2023 09:01:54 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B912E211E1;
	Thu,  1 Jun 2023 09:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1685610111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nfHFD1czxWDo3IknBcYnlZ2RKGFFHnaXgjk0J13dzyA=;
	b=ydMq/2EHcpu1aiu3QY5P2mv0IDlbFWGQ9FZV3c/uAY0yKMC7kaOQFwvkm+9AMUh3keexj7
	YR8aMO2V5LwKJIqC1Bz9A8s5HQrh6vT4+F5DimdRXbalo9rdapOMRGhqcYO2V8/KVu8WtA
	81FZkuPnMrmQQzXdYWgetVDQ6u19Opg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1685610111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nfHFD1czxWDo3IknBcYnlZ2RKGFFHnaXgjk0J13dzyA=;
	b=q9J2uc9lj7ESETEzqmDvVmIApzLUqodnRp9iwoWHIgfx0MCzugX+Tjv498XGxNJQzetKN0
	eLiYXsVfKooyhuCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A90EB13441;
	Thu,  1 Jun 2023 09:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 6RE3KX9eeGQ5GAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 01 Jun 2023 09:01:51 +0000
Date: Thu, 1 Jun 2023 11:01:51 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 0/2] nvme_trtype=fc fixes
Message-ID: <ydocewz6ls4bjow726voiqlk3hi3nziss7ppmao6a7c5v4yv6s@t24bkmsjcm6a>
References: <20230503083816.18792-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503083816.18792-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_020153_370072_6D5C7BEC 
X-CRM114-Status: UNSURE (   8.26  )
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

These patches are necessary to get to get the FC transport off the ground. At
least with those applied, blktests should be in shape and only the kernel part
needs to be addressed from then one.

