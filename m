Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC73C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Dec 2021 20:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eIIczbBbUirs7yOL8Qh9w6DKnn5LzU/OJ8RuhKfSRBs=; b=1DPmmoQ128X/Fp4BvsMIgfGW50
	NfUzp3mQ35QL0D2LuaZpAALIubcND/+g5xJa6Bh+ZAEub4O6jsmTiqmK5ay+qiRwffb5DD9Gr6V/n
	dZBVsJWDSakmCaTKauwEEsSWCCFXkzuta7pdR9Z025VMuBLXY9aHg9D0QdmFNX7LhwOFlCCc/mtdX
	sy2824v6upqBYs1RNXhXnkgZnNwJxGVynvlRuNhO0fsOUZqqTx0YkKYg/aSQb7WaUIdo8onv8YfUy
	G3WGdfWmFk4SUCxEUARUpjH8vmjsm24mdQzX/COt2h4NmrwxoPjL4g8KOFja4x993EPuXvosb7QwB
	3Amratzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n2g13-003QIH-C6; Wed, 29 Dec 2021 20:57:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n2g10-003QHn-PD
 for linux-nvme@lists.infradead.org; Wed, 29 Dec 2021 20:57:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7D86D614D9;
 Wed, 29 Dec 2021 20:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F3FC36AE9;
 Wed, 29 Dec 2021 20:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640811460;
 bh=4Gv+LCK+fMVJjuW25xEsAB9tl9EA1s4k1jK9ak/wXpU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BG3cQEzjAct0X4iM5BS0oy9Vw/omFNHcfKGV7JlvA9uVOU7baTgOBrQGvMDt9+/5W
 6Ui/XGAlhci7PggZ9hg4n02odT91aeCX4BKrbHdEPYrTyf0E1FmHo0d8CPlGm0twC6
 5b4dM0eM9a2vTRSTvDnxKB8k2GSeUbQDilp4SqAwVCwWyFHsuQN5ZdNRRf9qP2uTGn
 9NWfsnmLDI6UNmCCBLJVQiDqk9MVh/ynOTncz8R0ed2AzDHB8PZGcHdiMBhbs/L0mG
 kXFdZxFOsNLrTNVvOHCndbKkzuXaAyDmZPnLOVCN4Gzf4AKy2S9Jqoji+r9kkgz1NV
 fBE4KGenjkAZA==
Date: Wed, 29 Dec 2021 12:57:38 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk, sagi@grimberg.me
Subject: Re: [PATCHv2 1/3] block: introduce rq_list_for_each_safe macro
Message-ID: <20211229205738.GA2493133@dhcp-10-100-145-180.wdc.com>
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211229173902.GA28058@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229173902.GA28058@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211229_125742_904465_AAB800BA 
X-CRM114-Status: GOOD (  11.70  )
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

On Wed, Dec 29, 2021 at 06:39:02PM +0100, Christoph Hellwig wrote:
> (except for the fact that it, just like the other rq_list helpers
> really should go into blk-mq.h, where all request related bits moved
> early in this cycle)

Agreed, I just put it here because it's where the other macros live. But
'struct request' doesn't exist in this header, so it does seem out of
place.  For v3, I'll add a preceding patch to move them all to blk-mq.h.

