Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D1DC54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 14:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EwxiSaQ3mxim1g4ESG20w5W3vrSpmDdurPH4l285wYo=; b=2l5IuSaCEstoqAf7k0dvrYyJvs
	zGsqNNFeH8YpJxE/b7tVymnAXVA5Ou2dF7kFF/MbAbjjTCbg6PzZbnOaUKL2jYArzlZPX2ZQ+XKhj
	GaziXGM5MODMCn9z35n4PnWWphRG+nxd4iCq7CBepSAbwEswDk08ZUnO7EP0/2xA4uR9XhxKXm4eg
	9tBsNrlmy1bdrS+GEzSjmR+0AFtYmTFIx/IRKxDnkF+MioKRAyEXKI+NzKSk3EFcO97tM7y/a8o/V
	Tb9U0nqexggo6hwI9sbd73Uz97GWfgbnZ1q+VDXrLoeNM835WZD6BaaHRG31X+6Ei6mTgeDMf5VPT
	rMCw1k+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ribQQ-00000009cxu-3rEe;
	Fri, 08 Mar 2024 14:42:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ribQN-00000009cvy-1TDW
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 14:42:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6BC4D68BEB; Fri,  8 Mar 2024 15:42:08 +0100 (CET)
Date: Fri, 8 Mar 2024 15:42:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag
 allocation
Message-ID: <20240308144208.GA9194@lst.de>
References: <20240308015435.100968-1-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308015435.100968-1-brookxu.cn@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_064215_568343_BA8778BD 
X-CRM114-Status: UNSURE (   9.50  )
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

The fix looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But given that's we consolidate to a single place each for setting
up the tagsets for admin and I/O queues, what about just killing
the symbolic name and moving the assignments and comments directly
into the only users?


