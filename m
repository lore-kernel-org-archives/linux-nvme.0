Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38E3C021A4
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 00:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KbXvXoKNhrNk6/0otLdfaLVhcnFs9gIXratyNtv+MAE=; b=dIs89YXgnc2h9P5WoeM+/e69VD
	IRoobpSBHRj943ESuo6u31vqo6h961wqzgCG/SgBzG96v23cxVBnWxtDPd9wwOmLobMPP3TIbqVsL
	9t6E9Vjx9pc8Nc0DmgvjbYkgFQkIOiJ4T0bNTbCNXTm8niiqZa+UgCUko4NVIwvq62IVdxAuF1cW0
	azZ9NDMqFPDMX1JK6fOyV6YRZkNFhFlYbawkX90ylFLZwYeQR79446uh4pEslaGqXzxl6bRDPkIbm
	mrGQFnD9Hx3BKBqRvNYI7vhC9s23SxKKYl504mL7PcYfxu8euJhCYzUeCTtc6m1sX+dxbAnVYEizS
	ojzp6Pxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmiZH-0000000FbA1-20Vm;
	Tue, 25 Feb 2025 00:12:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmiZE-0000000Fb9K-45eb
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 00:12:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7BC0E5C0099;
	Tue, 25 Feb 2025 00:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA223C4CED6;
	Tue, 25 Feb 2025 00:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740442375;
	bh=KbXvXoKNhrNk6/0otLdfaLVhcnFs9gIXratyNtv+MAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awf87H7wGG2gTkN+ORt2qT6iDG6O6baVhrvPHmfd/b2MroB1LAwfkVx+3khJLzyV/
	 hwCRPsfjknEroXSMCxJ2oBLsIQPM54tMIsSfAOwFw7J8+D659mDUqK99InxLimPeGB
	 AxtxU4NmhkFWoKDNcYjf5AdY6OBWOi/gL97i8jVyFBBthVwCVznX5VodX/88DUXIsW
	 qM1LrTm8CQkWEQd+RUJ9H4pM3cBj8KusPbVZutIRDsp/bxbgjPPvhpTb5sBwDtHSqL
	 x5gYm4U2wOxnDc690ahw5lEmmgsr7NV7DSqiEAeorIxJx8W/tD8ZuKHeVAgj886YEZ
	 E8ilIayAWGW6Q==
Date: Mon, 24 Feb 2025 17:12:53 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-tcp: fix possible UAF in nvme_tcp_poll
Message-ID: <Z70LBUOpAbSSKuK9@kbusch-mbp>
References: <20250220111830.3185561-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220111830.3185561-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_161257_085634_A787E1D6 
X-CRM114-Status: UNSURE (   8.66  )
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

On Thu, Feb 20, 2025 at 01:18:30PM +0200, Sagi Grimberg wrote:
> nvme_tcp_poll() may race with the send path error handler because
> it may complete the request while it is actively being polled for
> completion, resulting in a UAF panic [1]:

Thanks, applied to nvme-6.14.

