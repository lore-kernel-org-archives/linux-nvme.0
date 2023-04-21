Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9671AC7618E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 06:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dhdeIsytLIVjWf6yjF5V1uEm0pNge/YpOD8xlqvmOG8=; b=xmoLz9eBK/q/6qeKLdkcWgOqpl
	xwrkVdsUMobTXAj/NfJ8L6fq0PcGYkSNvvPELcCJb1cCWoZLpJKttGX1jko6ThCCqDM5c9X1vDE/a
	P46/ZKleygOHCDkktCjuAptJ+5qmE4ebzmT7mdU3bLLc5UWgGzErSo//XXMnl9iiYVDEQoJs5NzPK
	XbKuSIhsnALtJ5NIISh08GSV0RcutXH3znlk+L/NnZSP1P1iEFLAdLEeoxDdpGG2gyN2Guylq2Xxq
	D0QMeDxoP3SrxrmC1oPHUy/zxHEwgjLUDKlQPBbf26/0JUFPMmgJOntKjGqg0gpqDFY9lK3ESG1ML
	181xW1TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppjoJ-009jxx-1s;
	Fri, 21 Apr 2023 05:59:55 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppjoG-009jxI-1L
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 05:59:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D0B0219FF;
	Fri, 21 Apr 2023 05:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682056790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dhdeIsytLIVjWf6yjF5V1uEm0pNge/YpOD8xlqvmOG8=;
	b=vVroTMaRT43s6Q48bBkb3eZErXKAjHDMwT8ic9xX0HrKrF2rti7W2NwqNdbICvdnDL1luS
	kIqhsfb8U2yWh+qbpDrkC3/oK96sIXAsARupulM5CjH4h/e3QcULDUKhtia5JcRtxW5jqN
	8nSgNlSZt6joacINvDlQELSSD+KtBTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682056790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dhdeIsytLIVjWf6yjF5V1uEm0pNge/YpOD8xlqvmOG8=;
	b=NFwGXqrlJWSjLhwvVuSoOG6xQNqXb/YVgVs2uYdl2eIdUbTra5bKSoO8xSxbogsMTNXwAZ
	PZUwjya+4q+QFHCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 169701390E;
	Fri, 21 Apr 2023 05:59:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id tgbqBFYmQmTcYwAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 21 Apr 2023 05:59:50 +0000
Date: Fri, 21 Apr 2023 07:59:49 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH blktests v2 0/9] nvme testsuite runtime optimization
Message-ID: <7hwnfsbib4orqekljbll4hejijzjtzfr65trqygiffycbuy5be@6fd6jbkifbpo>
References: <20230420183121.4489-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420183121.4489-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_225952_627889_ED50313D 
X-CRM114-Status: UNSURE (   6.10  )
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

Screwed up with the mailing process. This series contains an early version of
v2. Let me repost the correct version.

