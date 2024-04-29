Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D377DC4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Apr 2024 08:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VJeETHwSFIFueydb1Dv19pAkhLq5f+iioaQWJm/e1aA=; b=jgbo0LxiflNc5t6cwUL0/EWSmJ
	dEp5lNqBDY2EZqyiV/VrEON/B1vbeAE0vCidO3ZEfhUWQpZNNB+56/MXYTPiA5xp47azSCN5Z37o6
	uS29G1kCvX6N6egEQ2zWRDQ7/zHqnr7Z8mgCU9CNqyiL7lmA6jIwbmoaM/2JS1ysLQLefqCsJHlK8
	Ce8GRK3afRXcL2E1Q41K8HgKi7tWQAyTmdQmM0rVqWxoCBik2c82o4daN/qMwuECZIvz9QYdLnQMz
	cSKYgfDWudqLasoo6MuWj+7r/JkOgbe3DgB719W8SpB7W/t+HhIyX2JXdVV2ZG4Xi+A6WrHxzL80x
	0H2mAyWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Mjn-000000020io-3MAO;
	Mon, 29 Apr 2024 08:51:51 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1MjR-000000020hr-0Hpv
	for linux-nvme@lists.infradead.org;
	Mon, 29 Apr 2024 08:51:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 50C45CE0A27;
	Mon, 29 Apr 2024 08:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45282C113CD;
	Mon, 29 Apr 2024 08:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714380684;
	bh=dKTWaOfpFEP8r+Cy5OMxEWscFFqxcAVNE6UjBaJdvl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qP1xjk7itN00fw4ri0lq4tHSKkcAsSkliAyP2DSdOriO3H6hmeSOWuH3HQCGPi0kN
	 iJ3bXpoXGr6MX3jZAXDyet1vAHJbCXbgsb5c8IT+e4mqmP2owr0UG5v9oVaDA8hC86
	 l/fRpcZ0VugA+aViVgER19CELaRNTRQFfp19OfXw9wOvaz2zG0i9kTvz4KAKv3dgAc
	 mWs2kksf5ZeyFbFafLPy1vKYWR3F67WQQza8wa2grsrn5HkLP91Veq42wlhUh1xSKe
	 SAXQXDLDoOOUucN58OKWx0r9zeSnc4yRUyxHvvm/kM2LtBfdywrBq9wNwCk+VxS7FE
	 MtccOWRIGYgqw==
Date: Mon, 29 Apr 2024 09:51:20 +0100
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvmet-tcp: fix possible memory leak when tearing down a
 controller
Message-ID: <Zi9fiPIBzI4BIZJX@kbusch-mbp.mynextlight.net>
References: <20240428084949.61931-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428084949.61931-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_015129_412406_1A9286B4 
X-CRM114-Status: GOOD (  13.23  )
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

On Sun, Apr 28, 2024 at 11:49:49AM +0300, Sagi Grimberg wrote:
> When we teardown the controller, we wait for pending I/Os to complete
> (sq->ref on all queues to drop to zero) and then we go over the commands,
> and free their command buffers in case they are still fetching data from
> the host (e.g. processing nvme writes) and have yet to take a reference
> on the sq.
> 
> However, we may miss the case where commands have failed before executing
> and are queued for sending a response, but will never occur because the
> queue socket is already down. In this case we may miss deallocating command
> buffers.
> 
> Solve this by freeing all commands buffers as nvmet_tcp_free_cmd_buffers is
> idempotent anyways.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Thanks, applied to nvme-6.9.

