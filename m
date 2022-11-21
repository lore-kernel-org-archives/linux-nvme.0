Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CB8C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 07:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/CaZ8eB2pDCYbZ3TU1yYKCPaKtEW4EIfgv1yTFQipVQ=; b=dP6W38gPpqTWCN4GuJRM6NskkR
	xDzTcJRXjiOCYj6TdXJmwMcP/1Qq5j+6LJidtJc3AFHIeDe1MDolFk+XvTV5tZR5Gik4uGKXX4SXB
	z4LKpZTUy7LTPE/VcLAknvN7ryRwXROK2ruvqb4Am7uiY44Ld6BEL9EUQ6k11+rpp5MZR1TG2EU65
	D/v0QEeBjCd85E9Ga3Q1quoVSlF5E9SRsPjJ3ZsTovWpprxHxh5PDOgs4XSvDaOSRZpaGglLg91xY
	UqCnX3AHwcHKGsOwbh5urHU2gme3Qk2dVgmQJ29uhuJM7UC5NtGGoANt9TVwUnTigsHcpbdBNM3Dd
	cwKkUtTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox0rE-00A8ZX-8M; Mon, 21 Nov 2022 07:04:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox0rA-00A8V2-NV
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 07:04:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6A7D168AA6; Mon, 21 Nov 2022 08:04:32 +0100 (CET)
Date: Mon, 21 Nov 2022 08:04:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, lengchao@huawei.com,
	linux-nvme@lists.infradead.org, Gerd Bayer <gbayer@linux.ibm.com>
Subject: Re: [PATCH] nvme: don't call blk_mq_{,un}quiesce_tagset when
 ctrl->tagset is NULL
Message-ID: <20221121070432.GC23563@lst.de>
References: <20221116072711.1903536-1-hch@lst.de> <e5de54b2-4906-9902-c150-732718a77571@grimberg.me> <20221116132225.GA8071@lst.de> <1ee364d8-4aef-acf6-1cf9-38787ddac288@grimberg.me> <20221116132805.GA8496@lst.de> <2b6bae87-b008-6f8d-3c70-2334b5bd48b7@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b6bae87-b008-6f8d-3c70-2334b5bd48b7@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221120_230440_953171_7B5E182A 
X-CRM114-Status: GOOD (  15.49  )
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

On Sun, Nov 20, 2022 at 01:38:28PM +0200, Sagi Grimberg wrote:
>
>>> All the other drivers check that they have IO queues before
>>> quiescing/unquiescing them.
>>
>> The core firmware activation code does not.
>
> Well, ideally it should, but maybe it would be more readable
> if we condition on ctrl->queue_count > 1.

I find this more confusing to be honest, but if we get a consensus for
that I can live with it.

