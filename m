Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676D7C4345F
	for <linux-nvme@archiver.kernel.org>; Thu,  2 May 2024 07:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QQxmnNbxMhAnRyIpmItkdp9VGUuJ8kaLMZCL7BsHoXE=; b=sHsBzfsVgmNUlN+SBxsx2ecb3l
	bnxt8/hWh0oCw1sTdHAr6sSOkn3UTZVTTeTn7IdL1Qm64zGHuWX4jFB8iIq2iIOKp2pVmsVPHQdmO
	nnRjDzAgQsDDbjs9HMckpymKj2poP/YAhA+G7g9pzd1AwmfXEXBqY1j/2ZY/XKOs3oJgv9X1xXDQQ
	bw6NF48HYoRdILMs7fuWV4zurBPVplljFYb9or6LYSdlfWUn2vOB37LABm+LiW0Xvbxz3x6jFJQOE
	fnwEpMYGpBbaGS0njSfsPWKDu0tFuRD89XetBMKZ4WfR/1h7PJpsvMXmdwHruhNVyPbjA59vlpLzq
	T0v8pD6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2QdW-0000000BlqG-07A3;
	Thu, 02 May 2024 07:13:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2QdS-0000000BlpA-2EZ3
	for linux-nvme@lists.infradead.org;
	Thu, 02 May 2024 07:13:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1D44C227A8E; Thu,  2 May 2024 09:13:39 +0200 (CEST)
Date: Thu, 2 May 2024 09:13:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: reduce a repeated ZNS check
Message-ID: <20240502071338.GC31379@lst.de>
References: <20240502063438.422046-1-joshi.k@samsung.com> <CGME20240502064151epcas5p3834c50bcaea2c8db2d24fc30b0957ff0@epcas5p3.samsung.com> <20240502063438.422046-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502063438.422046-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_001342_825128_CBF7B56D 
X-CRM114-Status: GOOD (  10.25  )
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

On Thu, May 02, 2024 at 12:04:38PM +0530, Kanchan Joshi wrote:
> Modify nvme_update_ns_info_block() to eliminate the repeated check for
> ZNS.

Not sure there is much of a point do de-duplicate two instances of
compile time condition + trivial const comparison?


