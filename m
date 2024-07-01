Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BB5C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2WZf5LOp4Rb9s4tcJNnlmeRvWpKdeFhj+A+kik2xmZY=; b=VWzj89iPUny4MSLjUCaYn7XPpO
	LvNSWax1Ho96xBdoiojREOJkLAzctCOoaouMQt9P3nYm7leiNwACyW8GbYmp5O4UiGNfOew5j9Tf+
	L5GKNjXqrEx6yRYrIl00a1aIkU0eaCGsqCnZ/+KZyEDA9B7DRyhMjkPTKpFXQWsVdKEmlP14mladI
	l4g/n+NG9XRWjDXnbsdzAFLWlOZ7tSaY4Kv++jjGYrFrj7lXLEh3fDLTkGaSxrBXYfl3tkAWwXLbQ
	V8LX4fq7TIEnRPUrom/JJ9/t7oQ7lP9SYdirHwd7jSYJRfdTifyj+AmJdGVirZy9KjzRQmMPlef4N
	t+/2c0IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOHWP-00000003bog-1iaa;
	Mon, 01 Jul 2024 13:56:45 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOHVP-00000003bJE-10q6
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 13:55:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9A4EBCE1409;
	Mon,  1 Jul 2024 13:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C2BC2BD10;
	Mon,  1 Jul 2024 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719842139;
	bh=zKCeN1svAYfKXmpP5QCWCwWbylE06deDSOE1rh6xc9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FVlHdsan4UwN8cZv+xgM09c5euTJvJnZeIfl+XynzX5k2EbHfXVVxWwhYjp+SP66G
	 UvlDflMj5HzhLZHssOZGuDlaB+263YwznQiQBSDKbze4B7n5i13rDALLUQtj4vkwB7
	 qXBgQeKnSVRFjz9XcWd/K/8OLsw6ZL3Yhoa0rXGgaoc65+PW5yEqQPauCtEwS8PYRw
	 mMrp6/LlIBZAUzDP97jQa4ROUNgEExbZs2VXSS4ZYPMf6qJi5PqlniCCPiLZXBURpM
	 OJgT4Qj8Et0vBN8oXJqVO7nujJb/k+DA/jcX5vDTlixqfjSO43kvTl8IRBw6U2ARCZ
	 VC9qjzCk2PD7A==
Date: Mon, 1 Jul 2024 07:55:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme: don't set io_opt if NOWS is zero
Message-ID: <ZoK1WRFbr1dK86FK@kbusch-mbp>
References: <20240701051800.1245240-1-hch@lst.de>
 <20240701051800.1245240-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701051800.1245240-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_065543_495263_913BF663 
X-CRM114-Status: GOOD (  11.66  )
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

On Mon, Jul 01, 2024 at 07:17:52AM +0200, Christoph Hellwig wrote:
> NOWS is one of the annoying "0's based values" in NVMe, where 0 means one
> and we thus can't detect if it isn't set.  

We can detect if it is set based on the namespace features flags,
though.

> Thus a NOWS value of 0 means
> that the Namespace Optimal Write Size is a single LBA, which is clearly
> bogus.  Ignore the value in that case and don't propagate an io_opt
> value to the block layer.

Hm, why is that clearly bogus? Optane SSDs were optimized for
single-sector writes.

