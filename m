Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC3BC25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 16:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KKWIWPp3QZkNLpU1K5OD7x0qpQyF+HizlUYjfD8qwM8=; b=pOjRJMyTQg5gg95fFUbwcCaJTs
	d4CVjTW6N8cwySBpB3w2tv4jbe8MrNT66Or1uaX2D4ux5HWsk5E1Z6P4vFN1k3j44oBnn8bR4QKBh
	4jor/scyjYnNmAoTfJerMuxVpbyUSRNtg7m2U4t7AAFRrL8s2y8cemjhrMUvhYx0waUu/NhvZSM5v
	aJiT135WDJzz8UnQVSm1ROLwKzdy4R2OMMst0AbK7AX4GByCOBVg6TXcFeakGg20UBi0gfDfV1bW/
	/UWM2tVaJLC1v7dyYmZld8kZE6GNPeCyDJXMhjH6ZTySHfY0TFlsqOgo0fP86ZWEtBvCjqjZATJk0
	vJap9IMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9olz-00000003WbC-3Wqk;
	Wed, 22 May 2024 16:25:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9olw-00000003WaL-0u9E
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 16:25:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 70FD462A98;
	Wed, 22 May 2024 16:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C040DC2BBFC;
	Wed, 22 May 2024 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716395099;
	bh=K8A9IUGtjtlS2IHu9BKt/bo0efSAJIutxbOu1YwWJD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G89WTnZA4Jw0DHibMFbVXo9+tvNd+rO1PBMcCtnFTQm4IP0UhFQEp8yCCtvgn34Fe
	 G8n6aQvfO18MP1+iV3kpfp7du5zyOL4HbilMtJDvMUk8+D0eSD03QYHG1wuhDUYtPn
	 FtE5OR6cPMkW1Kwbp0wS6l4yJrLsnMqHGnYyTq3gNyU4RyIE41r9Wj0ec+yJpWB0k5
	 El7e377payXTYlLwGp5yTNuZnRT9AIh5HPEb7LRCGsKFGdjYeVXt/5yMjW+4yVxlwD
	 xes0yktn/VW8k+NcP8PuvxTA0aiQ3GWvPWvxu936lkhialMCl8NU4lqIvjuqkud+cd
	 Tbqo2/PgX683g==
Date: Wed, 22 May 2024 10:24:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v2] nvmet: fix ns enable/disable possible hang
Message-ID: <Zk4cWHmFnzLxXETd@kbusch-mbp.dhcp.thefacebook.com>
References: <20240521202028.356777-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521202028.356777-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_092500_334521_EE431EC1 
X-CRM114-Status: GOOD (  10.87  )
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

On Tue, May 21, 2024 at 11:20:28PM +0300, Sagi Grimberg wrote:
> When disabling an nvmet namespace, there is a period where the
> subsys->lock is released, as the ns disable waits for backend IO to
> complete, and the ns percpu ref to be properly killed. The original
> intent was to avoid taking the subsystem lock for a prolong period as
> other processes may need to acquire it (for example new incoming
> connections).
> 
> However, it opens up a window where another process may come in and
> enable the ns, (re)intiailizing the ns percpu_ref, causing the disable
> sequence to hang.
> 
> Solve this by taking the global nvmet_config_sem over the entire configfs
> enable/disable sequence.

Thanks, applied to nvme-6.10.

