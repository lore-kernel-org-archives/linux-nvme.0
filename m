Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477EBC282DE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Mar 2025 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i86RIkyiWH5bYZDFwwHBOPZuO6+8Rd00SI8o8EK9zcA=; b=Dl6hm0SGC6Ytxg0bt3B0YpXx9k
	QNrnb9rw5FOlRYtitCcr2VzgAUoJ4ZW1aTpF01Z/6GMfA3sW7gpt+BkYiMQxqS4xJrR4g20gTnclM
	rkPQKY1lHSBg0I90ARBPaccCWm7xWgNUqGmUQoT1EhiCqbqBSDYsy6Fzo28jKJRvzw7GbsNquyI17
	IWDItvD49rH10o2c29DDN5ZGOraW9zlD+S+sjRavroJJroDyfQeAmpfu5jKG/bJBdHzAdlbDDfJGm
	C9Q8cTnN/iUmYtb5dK7o13w486QdSfHLCj2GZCKwGLbbQOKcNTKxTWxtGBYsbwJkeyjbByg8J0nXF
	yYyvO8lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trger-00000003Sfv-150z;
	Mon, 10 Mar 2025 17:11:17 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trgWN-00000003QyP-1hwL
	for linux-nvme@lists.infradead.org;
	Mon, 10 Mar 2025 17:02:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 85B96A412FB;
	Mon, 10 Mar 2025 16:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7D4C4CEE5;
	Mon, 10 Mar 2025 17:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741626150;
	bh=i86RIkyiWH5bYZDFwwHBOPZuO6+8Rd00SI8o8EK9zcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJNMObsdKKQl8TYue2kiTSp5/ycsA7+ymC1v1lUN8oMKtA+vxgdI8HSe5GlCInVXk
	 1sbLiX5zdLCc2MyGwuCKz1BJF/5+PrPGC1PKrBKL0DTIl+EfJIEIaAOk6etD986h5x
	 eEucE3l5A9h7RP+bQnRmPvcfuy+MDS9og2eXZ+W7Hk9NpP/xDAfFdOXiPCiedfHxiK
	 aZGLTfGQ6hSeUZrZmcURh4XUzsww5AgPanSjHQcmanWaVDbAkvGjfrM+SS0gwoX2GT
	 IxiJE49iabLqMlpwI2zMXKhwZ2OS8Udqy5hINC/M8Q2thmQOAv7DqauKLzB+BtSMF/
	 dytYR48gWYGuQ==
Date: Mon, 10 Mar 2025 11:02:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/3] nvme-tcp: fixup I/O stall on congested sockets
Message-ID: <Z88bJG6eTZ8kHL6C@kbusch-mbp>
References: <20250307132802.111513-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307132802.111513-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_100231_514281_FB04F2A1 
X-CRM114-Status: GOOD (  13.80  )
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

On Fri, Mar 07, 2025 at 02:27:59PM +0100, Hannes Reinecke wrote:
> I have been chasing keep-alive timeouts with TLS enabled in the last few
> days (weeks, even :-( ). On larger setups (eg with 32 queues) the connection
> never got established properly as I've been hitting keep-alive timeouts before
> the last queue got connected.
> Turns out that occasionally we simply do not send the keep-alive request; it's
> been added to the request list but the io_work workqueue function is never
> restarted as it bails out after nvme_tcp_try_recv() returns -EAGAIN.
> During debugging I also found that we're quite lazy with the list
> handling of requests, so I've added two preliminary patches to ensure
> that all list elements are properly terminated.

Thanks, this all looks pretty good to me.

