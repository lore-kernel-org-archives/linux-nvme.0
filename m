Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA43C636D3
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Feb 2023 03:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FYKVvt42aJbjGZBd0oGZzd0c3ijaT6HL5OB7YcHa/BE=; b=dTSs2KwcwWF/fWd5MmonFqXDao
	at/KoufOefFtbmvAK198RI29hvcKzG0uQUx5p9xopjEePMm1I0X8HMgyrSFjc51T0kFlcHpnFpjob
	82R/DfmPd9yec4gcVzV1ZY7yqZR61oN0CuSiehsIDWDz47SCquRnrKGIFw4EdaxRXdGz5/T/5z9Ju
	0eNrCj59IbJ7FdVkBY3VjFzb63r7PIGfVcKULE7GiFi++JsOi8ptRSfjQgW4UfDdpVVcBf8+gG41k
	xt60ey7he1ziyiRiUGXDGp3DGdJlosdy626SuXQ4EA5cnFiQowOg2gYaCwdPwZRNv4MlK9lgMkWgM
	FMhvNuPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pO9ST-004MwO-KD; Sat, 04 Feb 2023 03:43:21 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pO9SE-004MuM-7R
	for linux-nvme@lists.infradead.org; Sat, 04 Feb 2023 03:43:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 3E007B829C2;
	Sat,  4 Feb 2023 03:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A16C433D2;
	Sat,  4 Feb 2023 03:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675482181;
	bh=Fql2NQ0xiyvHDXp3y8aTtoOW1LSw01YvzAS0sT1Y9eY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AaJu2yhcFru428vR4nYrjT1NoC+w6iRA1BuKANnUMs+JGEVdmc6c2taBWy+C42HAB
	 t6VvLRZIzUbPv8HC0TUqC55eM+RwtkVpbqalvI24v2SywaJ0DkzuTNEkpZd6eMn7c3
	 BO3PlA2BGafSTAnla82FnhusiDY8XSplDtwIbDU3XZrvhuraGNZj3RrqtmnIBzBubh
	 qIB00OdKa91YEoT/vsa/RzDLexZMBOm0mlpBXUXPK6lA++Ghbe7ZUkKlnhPXbN4wdG
	 6MkO7g6lNmVdkA+Wbwrjs1o0Jes+ISSGqAATIftZthWrDjIPcRE2un+7GrJYdJJf+s
	 CkoEMZOLMGSeQ==
Date: Fri, 3 Feb 2023 19:42:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com
Subject: Re: [PATCH v11 02/25] net/ethtool: add new stringset
 ETH_SS_ULP_DDP_{CAPS,STATS}
Message-ID: <20230203194259.67c08c7a@kernel.org>
In-Reply-To: <20230203132705.627232-3-aaptel@nvidia.com>
References: <20230203132705.627232-1-aaptel@nvidia.com>
	<20230203132705.627232-3-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_194306_550163_BF585812 
X-CRM114-Status: GOOD (  10.26  )
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

On Fri,  3 Feb 2023 15:26:42 +0200 Aurelien Aptel wrote:
> This commit exposes ULP DDP capability and statistics names to
> userspace via netlink.
> 
> In order to support future ULP DDP capabilities and statistics without
> having to change the netlink protocol (and userspace ethtool) we add
> new string sets to let userspace dynamically fetch what the kernel
> supports.
> 
> * ETH_SS_ULP_DDP_CAPS stores names of ULP DDP capabilities
> * ETH_SS_ULP_DDP_STATS stores names of ULP DDP statistics.
> 
> These stringsets will be used in later commits when implementing the
> new ULP DDP GET/SET netlink messages.
> 
> We keep the convention of strset.c of having the static_assert()
> right after the array declaration, despite the checkpatch warning.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

