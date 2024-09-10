Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683B3EDE9AB
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 17:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yRK1RxwVW0BlQwtvOw18QnUBnnzg3LO9FR4oTg1R41Q=; b=IseNHlbWN3rx2LSMVHB4GvzMpg
	t+WPEpdrEcQtpOjXxoj+54zXSyFQ/ihy2MGwVMX+rJquxslSNHkq7+3+ZIahnHyS+W2R5re7vo34c
	Tse+LUbXT7n+/klOyTAwG/Vhly+mqyZuLU1b/PI1RuD05T1jeFudRX/LAHWzMJzb9UPuCVi2L20Va
	TevTa85o3Hbq7iKvkAp9GZzMHlOINOcYLxRtkt97TJiA+3PX/pcxUUJiE+Ki276nlQVs3MUr9ujts
	0dYcGC603R+dWFDZY5cDK3126CKArlUf+EX3+a0mxoWAkSmNpOoKSVFGtfvLBMvzZHEK8/PNPqcHk
	83YArEtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so54J-00000006f6c-1nHe;
	Tue, 10 Sep 2024 17:54:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so53P-00000006esw-1vWq
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 17:53:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2589B5C04FC;
	Tue, 10 Sep 2024 17:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E6FC4CEC3;
	Tue, 10 Sep 2024 17:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725990806;
	bh=igoeBjib071T2Fw8o0YqKVgDabZCIMtx9Z1jvelehiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PArc4IcsVFWAXrD/ObIjdYDdBkz6YCQnBoxdpEnV7XdV+b5ab0lLqkpF2rNxbB1xR
	 SWF3Y6424rsKdfxIRSFjvTcOYjNyLK+Hw9bIH/3oPzfNAf55WOFdzQrXsXpw1DBSCq
	 uHqDs9Qi45aeLJMEr4y1Uhza/+oRa/osKfvGPTNUMB1pT6IhUv0UinHFAg2IAqGbzb
	 UFbqFX+aqm5Sa3Dyt4Pz26dD4gMfF1dLsen3ChjRWsnaucQarllYvp3Dkzg4xwyxQ5
	 4a3L0Q5YaA8vVuUo3Fjv5Xx8d2dNjAhcNgluT30uDIsjbgy0SNmcG0Tmy1lpt1MKWT
	 jZFLn0jGrU21Q==
Date: Tue, 10 Sep 2024 11:53:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Robert Beckett <bob.beckett@collabora.com>
Cc: linux-nvme <linux-nvme@lists.infradead.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>
Subject: Re: possible regression fs corruption on 64GB nvme
Message-ID: <ZuCHk6hDxF65v8T2@kbusch-mbp>
References: <191d810a4e3.fcc6066c765804.973611676137075390@collabora.com>
 <Zt9amhUGs9FT5i-O@kbusch-mbp>
 <Zt9bLa4TJT6L75aG@kbusch-mbp>
 <191db450152.e0b28690987786.6989198174827147639@collabora.com>
 <191dcfa4846.bb18f3291189856.1624418308692137124@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <191dcfa4846.bb18f3291189856.1624418308692137124@collabora.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_105327_622253_A4459EE0 
X-CRM114-Status: GOOD (  22.37  )
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

On Tue, Sep 10, 2024 at 06:27:55PM +0100, Robert Beckett wrote:
> nvme.io_queue_depth=2 appears to fix it. Could you explain the implications of this?
> I assume it is limiting to 2 outstanding requests concurrently.

You'd think so, but not quite. NVMe queues need to leave one entry
empty, so a submission queue with depth "2" means you can have at most 1
command outstanding.

> Does it suggest an issue with the specific device's FW?

I think that sounds probable. Especially considering the dmapool code
has had considerable run time in real life, and no other such issue has
been reported.

> I assume this would suggest that it is not actually anything wrong with the dmapool, it was just exposing the issue of the device/fw?

That's what I'm thinking, though, if you have a single queue with depth
2, we're not stressing the dmapool implementation either. It's always
going to return the same dma block for each command.

> Any advice for handling this and/or investigating further?

If you have the resources for it, get protocol analyzer trace and show
it to your nvme vendor.
 
> My initial speculation was that maybe the disk fw is signalling completion of an access before it has actually finished making it's way to ram. I checked the code and saw that the dmapool appears to be used for storing the buffer page addresses, so I imagine that is not updated by the disk at all, which would rule out my assumption.

Right, it's used to make the prp/sgl list. Once we get a completion,
that dma block becomes immediately available for the very next command.
If you have a higher queue depth, it's possible that dma block is reused
immediately while the driver is still notifying the block layer of the
completion.

If we're thinking that the device is completing the command before it's
really done with the list (which could explain your observation), that
would be a problem. Going to single queue-depth might introduce a delay
or work around some firmware issue when dealing with concurrent
commands.

Prior to the "new" dmapool allocation, it was much less likely (though I
think still possible) for your next command to reuse the same dma block
of the command currently being completed.

