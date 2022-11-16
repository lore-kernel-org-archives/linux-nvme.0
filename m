Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209F7C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 06:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MRs58kTbFQKJ7M942KzlvjA903OOUZPjh8SBDOgmOhY=; b=fmC0MvieRAYrduDl0Bp8DpuXRQ
	aRY+Pej60PoQuMwsl1W93JBO39+bnfXCVlsl/QVcwhvUdh9UiQTohD5PNJG4/IdlamcmTXNqOTwuo
	DMK7ejBoij5t3y/HacLVDtrY4Mujt4wXWE41g8RYuE5NR5v7WoFtRevoqa22+UDFLPOb9tyJucTdZ
	/jkJP6LtQ4FRBmw2lbTUvWlgxZbU5H9qOUptA002v5n3EYLwq55AXPnw4yoaeSh++OGIVmsbqXN0Y
	fRsG7JITWP1O8XqrlTwD5zh/Lr2nfmopDhuZ/3hbDhCv+c3cfIINMLrZgXwB4CofdIUbeh0rus7NJ
	7j+B3Lhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovC6K-000K8T-5h; Wed, 16 Nov 2022 06:40:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovC6H-000K7K-PA
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 06:40:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1CDCE68AA6; Wed, 16 Nov 2022 07:40:43 +0100 (CET)
Date: Wed, 16 Nov 2022 07:40:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2 4/4] nvme: Convert NVMe errors to PR errors
Message-ID: <20221116064042.GC19581@lst.de>
References: <20221115212825.7945-1-michael.christie@oracle.com> <20221115212825.7945-5-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115212825.7945-5-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_224045_978719_A3F4238E 
X-CRM114-Status: GOOD (  10.92  )
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

On Tue, Nov 15, 2022 at 03:28:25PM -0600, Mike Christie wrote:
> This converts the NVMe errors we commonly see during PR handling to PR_STS
> errors or -Exyz errors. pr_ops callers can then handle scsi and nvme errors
> without knowing the device types.

Looks fine, although the improvement suggested by Chaitanya would be
nice:

Reviewed-by: Christoph Hellwig <hch@lst.de>

