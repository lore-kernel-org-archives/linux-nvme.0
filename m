Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DC8C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 05:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7JkCS9y8NtStDQm2qkN1RX8n5w5yEJNtjo6cKF3Blqg=; b=vwSV9bLZfp3PFgeoLb7IqyVgzp
	K4MByNkfMTEklZmwRTXOG0Qk3EM3IjMxXukKXsvqwhDUcvYw0oo6Rcwx6VI97AFjI64pOfP4NWQwm
	i9hLY5picbZW/nTqcVbXt3k1mBrRtKBwYaNRmmsT7BegX3sbgI3I7qRqaILqz4VnRQ4Q+fyNfv+jA
	3+ZCrbBPhIroClwLRBDajhBlp81o5fGt96MvKuu9lw93qYLuooBnUJEOMhNhbLcDJFV3LVO6kHdoN
	HwOfMssrjAkRlnZY1ZxtB2O4WWo91HD8dA6SDSERYHrlZZPZ3NLTcNP9HnSEoow8bVYhpqoBCb+iT
	EvMnxOcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nchRM-00FBlX-NY; Fri, 08 Apr 2022 05:45:48 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nchRJ-00FBkm-Ou
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 05:45:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 16A0568AFE; Fri,  8 Apr 2022 07:45:43 +0200 (CEST)
Date: Fri, 8 Apr 2022 07:45:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 2/2] nvmet: handle disc default command set identifier
Message-ID: <20220408054542.GB32232@lst.de>
References: <20220408023930.85774-1-kch@nvidia.com>
 <20220408023930.85774-3-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220408023930.85774-3-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_224545_996958_A35479BF 
X-CRM114-Status: GOOD (  10.31  )
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

On Thu, Apr 07, 2022 at 07:39:30PM -0700, Chaitanya Kulkarni wrote:
> Similar to previous patch handle identify command cns value
> NVME_ID_CNS_CS_CTRL when executing nvme_admin_identify for discovery
> controller.
> 
> This is needed to mask out the errors reported by the blktest nvme/002.

Diѕcovery controllers don't support I/O Command Set specific CNS
values.

