Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB1EC77B61
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 05:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8X/aviboQDVoIjoDxxZOD/zg1POYN6HIeCKORtLfRlc=; b=lnAfrSrV7qUF7QtlWiP7ZbJWAr
	HxfYZTwhNSMyOkdMzVvAz49xH6WWbTRImCYsoxhgT1lq9gEsayVfPxbJvD5KvlmUPap7kq9k7A3xZ
	3qZVrVVlNoMqZ+WFSRHcuKb7RZjlrxTgxu58Q/9JzEItCd9oDZ3J/ciEryVOPFskTfkYNzsnZVv2S
	J+gpzwVNC2IuYk/gfEeBlzp+zJ6zNfVm1E/ew80rsjYWe4WJP2yO3ZHLD1I7BXRJ+ZELT7MM5QWqb
	Hbvm8NU8s8/Wdq9vx163QqNO7d8VFCYhwyMnHO0r/lV5S7yXTEAMCvnttv8M6IEVzRSz5C21ZBSIp
	F4tAwCjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqoUQ-00FLVs-22;
	Mon, 24 Apr 2023 05:11:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqoUO-00FLVG-0I
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 05:11:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9B40B67373; Mon, 24 Apr 2023 07:11:44 +0200 (CEST)
Date: Mon, 24 Apr 2023 07:11:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: martin.petersen@oracle.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, oren@nvidia.com, oevron@nvidia.com,
	israelr@nvidia.com
Subject: Re: [PATCH v1 0/2] Fix failover to non integrity NVMe path
Message-ID: <20230424051144.GA9288@lst.de>
References: <20230423141330.40437-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423141330.40437-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230423_221148_272934_52A6A72B 
X-CRM114-Status: GOOD (  11.19  )
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

On Sun, Apr 23, 2023 at 05:13:28PM +0300, Max Gurtovoy wrote:
> Hi Christoph/Sagi/Martin,
> 
> We're encountered a crash while testing failover between NVMeF/RDMA
> paths to a target that expose a namespace with metadata. The scenario is
> the following:
> Configure one initiator/host path on PI offload capable port (e.g ConnectX-5
> device) and configure second initiator/host path on non PI offload capable
> port (e.g ConnectX-3).

Hmm.  I suspect the right thing to do here is to just fail the second
connect.

