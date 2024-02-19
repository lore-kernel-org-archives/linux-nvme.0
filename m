Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77958C48BF8
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 18:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pcTPuo6GV3W0H7qdUsYsZOLgcPNlQ24pV3rYw6LLRVc=; b=LfgnQJoGVb754fTXBWJrdEnmyF
	I00UpthL9yg/4818LkxX2BKVpDLqyFrYKi/ZS1WUW3n+mm46E5NCUV1mJu3+H3HIBCRVO9ZU6B6Mm
	KiymFhHvwNTDj6uKF+o6Va1FvGTV9MOrkc8unKWPDhEv2ZstspkwsD7gDLEX80ceEV+DNGz9En7V4
	UYgE+vyMZXH28/ULn1sYQ6xg7mbSdPET3dIWw0NUPOSSqJMtFwmPn7Qe216ogyKBlMQBBv/VglBAI
	pqcXT9uDTt9ys6YlzpxcRPKyHYHa+DKyqfbVBjVIpncSgcMn/lAERjgcSMX0kbZPFKxR5I/LfzB2x
	7VyQeH6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc8ck-0000000Bl7p-2qjV;
	Mon, 19 Feb 2024 18:44:18 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc8ch-0000000Bl6x-1PHC
	for linux-nvme@lists.infradead.org;
	Mon, 19 Feb 2024 18:44:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 27999CE12DE;
	Mon, 19 Feb 2024 18:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B27C433F1;
	Mon, 19 Feb 2024 18:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708368250;
	bh=A+skSn5EGS8bpzAxHlYWC66tyc9qRmaHyrFHFKuAz6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWRG4KI+8bAKVYukLPfmN2JxynpqPCs19YmhE/Sf4lcIMfU5uL85zLUa9LJy7HBSq
	 mKpB8QmLAX+OtA9xBgXtBhZT61FT59UdF7TF9Ql7t826DSuNMw4MQLw3jk3MB+tg/C
	 DC+0fdDdgstI8BXMAgNk3MvR6kKU4Lt2Av6c8PynIGdQXHI3+akxHAzSb+vlpzUetB
	 3qi3+eDr3v5i+V91rn/Om5OmD8X5xJxoGbe62I0yMi+nqom1Nfmip5RgU5p0ANbkAh
	 fIwH0TwUFX/08Fqq5SJbWPOWUuGhOxTvcQB/k7hIoTXdO0hEjg0gMl57MIzjpzB8pp
	 iI0vl5Cm+Wd9Q==
Date: Mon, 19 Feb 2024 11:44:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/6] nvme-fabrics: introduce connect_sync option
Message-ID: <ZdOheNNssYuhBT9w@kbusch-mbp.mynextlight.net>
References: <20240219131531.15134-1-dwagner@suse.de>
 <20240219131531.15134-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219131531.15134-2-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_104415_569703_0AE41D0B 
X-CRM114-Status: GOOD (  13.87  )
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

On Mon, Feb 19, 2024 at 02:15:26PM +0100, Daniel Wagner wrote:
> The TCP and RDMA transport are doing a synchronous connect, meaning the
> syscal returns with the final result, that is. it either failed or
> succeeded.
> 
> This isn't the case for FC. This transport just setups and triggers
> the connect and returns without waiting on the result. Introduce a flag
> to allow user space to control the behavior, wait or don't wait.

The series looks good to me. My only feedback is this patch doesn't
change anything without patch 6, so I think these two go together.

