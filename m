Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285C9EB64D9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jun 2023 15:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1cmxjMcfvrFVecoH9p5LC3mEGtFprhW9cvmWSFdwapk=; b=AfVb34LNon9+pA/OVnJNU7y1qm
	cosb2WdVG31kuh/Th2vX9R3Mj81iSj67tUCHW2zI5S+nMqPaii9HpdTvitD2WZ44GiWCmsO1AqMzr
	EjXTzMlt94c4hnri7O/5KFRdbo8UT/OE68zzJMRs0LXIhtYpO7TIZRfXLyu924QVzJTeffOvnoate
	OxKY6joWQiCo2y4+Lod4BDSrqLYyUMNahpL6VDc0HkxEx5Omc+iObRI4kqJEH46ksO/erBH6BqyLr
	q3sionga3KW+RYjapngxRYWGyF62xp7S8Kz41LVkSBn2YWm+w0gAdXghrFt13b9OqL90mu83a9UBd
	4FZaF08A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEATp-00DUvG-3B;
	Tue, 27 Jun 2023 15:19:45 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEATm-00DUud-2P
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jun 2023 15:19:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A58FD6113C;
	Tue, 27 Jun 2023 15:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8CFC433C8;
	Tue, 27 Jun 2023 15:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687879181;
	bh=1cmxjMcfvrFVecoH9p5LC3mEGtFprhW9cvmWSFdwapk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qt+sR205kSUSCO/lhgmhljsNnEr/+dBlbOAVNLVKHqlgojB3iOgdNHTOEZ0q06dx7
	 MxbsH9jnUUYBpiQJIXRQGpah7wu+LHp2cc5+C5ECRc8IVWbkAB/X66NAx9ROVCd8HE
	 4WwLBK/+is330lgxFG9525kcLTVCiAtkqSSl4pk9mMv07NUnedIEg/4lq9qK1EHbmF
	 Ns71oEgWQ9BFkh9Aoqvq6oL8exB3BiR58zN2dZinzMTdW/nz2keAly1mgYiBczaBox
	 x6PP1h0Dj0D4BgPX3N8AwjeS8/MH00BKgHbsGCwFQp4eK2ht6jVhYXnbQ45RE5p2pF
	 DrkKu2L11ijxA==
Date: Tue, 27 Jun 2023 09:19:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-mpath: fix I/O failure with EAGAIN when failing
 over I/O
Message-ID: <ZJr+ClH67YK8PSnq@kbusch-mbp.dhcp.thefacebook.com>
References: <20230620130736.1090531-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620130736.1090531-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_081942_838225_9C47E563 
X-CRM114-Status: UNSURE (   7.94  )
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

Applied, thanks!

