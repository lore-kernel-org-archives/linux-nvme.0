Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7A9EB64DD
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jul 2023 02:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9uaeXtxe4unZzbrIeFOhj1LzJcUKV2mGuq4o1uAw0cw=; b=fixss53E76lv+M6hDbkXqANrRh
	L1FUGBmDw5uXsA0YmailAvFgL76IUR4RaSbH6X/zgayf/XChquQoL4vHwbtdsdPv5z1M/8rQeeqtB
	X5NltDb3g7xfIjfZEtW2eNWv65vXG2x2pC71m9W6Yl/wrZhuKvXnHel/+DAl4AYHVOCOAM/Rj/lVZ
	WGzRNjNAzpUCidhvLg2FkRTwRz30WDMRlzp+xcksfVKdDqbgUPaF4qb/fD0XQut90c9FWcei6Zq10
	ilH+ey99i2yRtnIbtL1+8E5mjph5t42abgtfwoOCh0yNpPTfGNhmizFcO9otlkfs9z5gwcb5Z0hB+
	dQ0CzUIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qN1v8-00Fa74-03;
	Sat, 22 Jul 2023 02:00:34 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qN1v3-00Fa6Z-1z
	for linux-nvme@lists.infradead.org;
	Sat, 22 Jul 2023 02:00:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CF1E661D6A;
	Sat, 22 Jul 2023 02:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC0FC433C8;
	Sat, 22 Jul 2023 02:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689991228;
	bh=9uaeXtxe4unZzbrIeFOhj1LzJcUKV2mGuq4o1uAw0cw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tq57IEXA3V3bPLE7IqAXsNIDw83qnvuWC/7JiN0TVr4/b51rQQXE8zAeitvFDSBG6
	 Cx2l/wkn0p0gSGmT6A7Dth6uEnE5NnZ1QwQO+Jw3hLEn/iQZ2YyyNhV9v5XiyJCYrz
	 hXiHhl/i7HNaP0+Rlg/3MErG76d519LXsm5i9XagsrJQ4MmVtHZKcf4UodsVYpB4y0
	 FN+RndIytcKzG8eLGVujmEF5jJAII6top9L+0Af+tl1aEd8aGbcOZK1NBgbfUR7eF5
	 4viMHwvsq9qdTPYDh4v/Zris+2EEFfotxsYSPWzRwvV4VEWJOvTLM4JTFXFZOc9NNI
	 4UxpciaFuhKIg==
Date: Fri, 21 Jul 2023 19:00:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCHv8 0/6] net/tls: fixes for NVMe-over-TLS
Message-ID: <20230721190026.25d2f0a5@kernel.org>
In-Reply-To: <20230721143523.56906-1-hare@suse.de>
References: <20230721143523.56906-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_190029_714508_B6AA486E 
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

On Fri, 21 Jul 2023 16:35:17 +0200 Hannes Reinecke wrote:
> here are some small fixes to get NVMe-over-TLS up and running.
> The first set are just minor modifications to have MSG_EOR handled
> for TLS, but the second set implements the ->read_sock() callback for tls_sw
> which I guess could do with some reviews.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Sagi, I _think_ a stable branch with this should be doable,
would you like one, or no rush?

