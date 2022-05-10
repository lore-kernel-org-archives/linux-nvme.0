Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C76C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 06:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pcOFu+saMdl49JF7m8TbR1tWhcuHGYpmXaoh1uBGkuk=; b=borHWw47O0/vrKotdtWsg7W/sP
	P1dlfVtjEwETyBf3tdLgpLPHdMqIo5vihwY5/y8IG2cgv4SNfItXwII2vhogp5RecjPrRWCDZSESv
	kmpvE/L/2ugXNY8m0Cfb5L5FwFMV/AMEBXeGHD9smpHRKH68ddiFY5rRqZYe22zji1UPM9vRHS/eu
	1GTbL3ac2aw6Ay+puOF4EWN9oIrZd1Gng79tAqnmkHNpV62S6ov05UnivwKKmOyIOQTPNIFUaEQpE
	TOrGC70+YQitX8nKGcLWGh50SQV1ZHE8zwtpfsk7i29loM2cDK9kvdW7iAx7Rf3/wDWH4veuYNbGK
	2rMAgUwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noJDX-0007YB-DQ; Tue, 10 May 2022 06:19:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noJDU-0007X7-K5
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 06:19:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1D42568AFE; Tue, 10 May 2022 08:19:25 +0200 (CEST)
Date: Tue, 10 May 2022 08:19:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 kbusch@kernel.org, kch@nvidia.com
Subject: Re: [PATCH 1/2] nvme: add missing path related status values
Message-ID: <20220510061924.GB11094@lst.de>
References: <20220428091935.35651-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428091935.35651-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220509_231928_840962_9E1D46E5 
X-CRM114-Status: UNSURE (   8.44  )
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

Thanks, I've applied the two patches and merged them into one.


