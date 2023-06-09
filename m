Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2288BC7EE2E
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jun 2023 15:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4byYO0KEaTnCaqsZ60GsUTC0+EeDo1VKIpnCm9v1IEg=; b=eVoeB4c+3obZ+Atv2tBjtxqRki
	MnoiJduHPqTLNnJlfeOeygECLPKaSRSgFJuErJ/4/c3zr7TwvmuuIHpiizfxYJqiAJafzRrH5sWrH
	cufBY+SFAfKA0pJZb0b5ZKdarNPobPIv68/xgqQlliaP/pXzmoeWuM64DLZ6ChYxE9wUwe/o0A3Rl
	dRXJNv/kX9HTeQNXzPcIDS9fnzu9kEXmHViZrRbxR9BLt+g6gyV0S731oUom3UnCHlAn9ToD4rQYQ
	bS9LU0li3KDlrrsWCw88G3JnaZH942Xh4VOgsPsShEtDhedxhZPZ0ZdobI3BLlxQngUIaGUeG6Aod
	WzTV/3IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7eJp-00DV0v-1O;
	Fri, 09 Jun 2023 15:46:29 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7eJm-00DV0P-0L
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jun 2023 15:46:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A1F1665954;
	Fri,  9 Jun 2023 15:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE1EC433EF;
	Fri,  9 Jun 2023 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686325585;
	bh=4byYO0KEaTnCaqsZ60GsUTC0+EeDo1VKIpnCm9v1IEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcgtaM1KmdL55aIH8UGDIDLFwu63jxrwlf8l35qYnZ3JJsLMFb+t2ETkTb5XlFgVr
	 fCNBm8oAUlk6aLX1rxZEp2a8iMIfjZpx2L92P9ZCw2bsl6eBod+rvil6xzArq8bctl
	 ZSkYLyDxxPNb+4E+dppROlO5JTnwHYoGUyrwzzARAq4v7ahzRzb8DRmtHfU9bHBOk4
	 DMr4Yd9T1GPMsA24rB3oGrLGjbHWekKgHUUqQGGuX5HTKtaj++jUsDA3HX4epogw45
	 IJ9njMg0SG/1F6y9kJ8d//TwK4Z64DQrEZGQSfujxuI6qa7wSNe4Jk6KN0brRff3mR
	 B382hBZ0k9J8Q==
Date: Fri, 9 Jun 2023 09:46:22 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme-fabrics: open code __nvmf_host_find()
Message-ID: <ZINJTg8sHZwAWEE2@kbusch-mbp>
References: <20230602064742.56298-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602064742.56298-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_084626_184878_6FAE3F3D 
X-CRM114-Status: UNSURE (   6.42  )
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

Thanks, appliked for nvme-6.5.

