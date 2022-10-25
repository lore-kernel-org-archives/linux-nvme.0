Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531B9C04A95
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 16:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hxStXIEzqXSZBeCLG8BXCikWCPRvqjdKaqPLCwGaheM=; b=MkwejKP6Gc4ql4QuiRzoySoeSB
	HIw1PgpTS8xE9myYj9Lu3EOlMhxaaAkz/Sskk7iuMIHVyLOX/pam6IhTnpAJprirzDOS+wtAs5huo
	llsXzWfgonQsF36qHGzuu2eNvZ6tm5Cc4KRX6bwc90EcWwhsFv00g3pKoRFf6rJSYQ1D5LJD/BuBM
	fxw1nEwXTH9HDePyF1cQMslcAn1rshPIfv1pE48HLMBjyS+jvx8xg19t92pR9jPHBYaT9YAMEAM+g
	b8JZGi7fj2N9oNpWJ9+GsxliqcFxsvpzSY8eri4lX7/SHb28g73zcR1GAexnR0wMyHzVkRRuDpIeL
	3D3o9clQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onMZk-006Fot-05; Tue, 25 Oct 2022 16:14:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onMZh-006Fnp-Gm
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 16:14:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C08B168B05; Tue, 25 Oct 2022 18:14:42 +0200 (CEST)
Date: Tue, 25 Oct 2022 18:14:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	tariqt@nvidia.com, leon@kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, smalin@nvidia.com, ogerlitz@nvidia.com,
	yorayz@nvidia.com, borisp@nvidia.com, aurelien.aptel@gmail.com,
	malin1024@gmail.com
Subject: Re: [PATCH v7 04/23] Revert "nvme-tcp: remove the unused
 queue_size member in nvme_tcp_queue"
Message-ID: <20221025161442.GD26372@lst.de>
References: <20221025135958.6242-1-aaptel@nvidia.com> <20221025135958.6242-5-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025135958.6242-5-aaptel@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_091445_733703_80792240 
X-CRM114-Status: GOOD (  11.72  )
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

On Tue, Oct 25, 2022 at 04:59:39PM +0300, Aurelien Aptel wrote:
> This reverts commit fb8745d040ef5b9080003325e56b91fefe1022bb.
> 
> The newly added NVMeTCP offload requires the field
> nvme_tcp_queue->queue_size in the patch
> "nvme-tcp: Add DDP offload control path" in nvme_tcp_offload_socket().
> The queue size is part of struct ulp_ddp_config
> parameters.

Please never do reverts if you just bring something back for an entirely
differenet reason.  And I think we need a really good justification of
why you have a code path that can get the queue struct and not the
controller, which really should not happen.

