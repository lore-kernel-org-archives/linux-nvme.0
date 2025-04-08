Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AEEC369A1
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 05:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=26XhyeM8AFQGiP6XkOLlekexwUhU6P7xEPsqEwPV7Ko=; b=ta1Z22Im+BpXmXkNP7WEJ12Y/X
	Ppr9+xw15q5/+6kUg/uloZelEtS+lS76Cb3AVBTP+3cBMSLnMAuGA0sI0Y8Hd5vNQPPfw8SD//La2
	cvvaGs8l+KgMac/7zKu41SCDv1RSmnejvks1+W2R1O866DyVTu/7a6CI723qR4D+jccGZXbllW0kW
	efao5tQtzeOJogx5DuCcB4Qo0HlzKFQPUctQKTWqAiejoOoaobgbqfOxfRqRBnwFbex+NANMmPfQd
	qarEcUgw1vCvcAelvjJcutL1uJK/l3Wx9Ti3WVxhuOkB+IW8JtCE3KD2Bn2kEYP9Dy9YOdU2o5gXv
	kgOoJCqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u219K-00000002kJa-1mqk;
	Tue, 08 Apr 2025 05:05:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u218D-00000002k9x-47aV
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 05:04:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DF6D767373; Tue,  8 Apr 2025 07:04:08 +0200 (CEST)
Date: Tue, 8 Apr 2025 07:04:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: hch@lst.de, axboe@kernel.dk, gechangzhong@cestc.cn, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org, sagi@grimberg.me, shaopeijie@cestc.cn,
	zhang.guanghui@cestc.cn
Subject: Re: [PATCH v2] nvme-tcp: Fix netns UAF introduced by commit
 1be52169c348
Message-ID: <20250408050408.GA32223@lst.de>
References: <20250407143121.GA11876@lst.de> <20250407171925.28802-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407171925.28802-1-kuniyu@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_220418_173399_B640152E 
X-CRM114-Status: GOOD (  10.94  )
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

On Mon, Apr 07, 2025 at 10:18:18AM -0700, Kuniyuki Iwashima wrote:
> The followup patch is wrong, and the correct fix is to take a reference
> to the netns by sk_net_refcnt_upgrade().

Can you send a formal patch for this?


