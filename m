Return-Path: <SRS0=XVsr=XL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7354C4CEC7
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 07:59:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A64E20890
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 07:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eEqF4zJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A64E20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SgVXsRM8nyq8ICljSRkYNbIhlxVgL9zei0pShmBmFlY=; b=eEqF4zJL9KghY1
	S7+NrCYUduyVcy4vLS2ttvi0ZdZoV0VNju6E3oPbgAFUN47tHPF1HuCNTx/hio2t4cYDL5jCCNJId
	TbcFRCjdbtc7xycczOwI1nNmowc/6e35giEvA+EPAaUfwtWGxe3gFSFSaV1roasybn341ff4UKLpo
	8nZ5LB1Qp8f4J+RLgw09D1uG5ci7aqV2GkFs3hstXg1nM3OMw9ytJkjiiFGRfi3m0E1+oxK8Iprl6
	f135RMNRCcr+0b/kmSGxLBDx6lI0aGuLB1tobWof/NRlhniBoCqmhXdFQL1OeEXa159Ye+bdBlQYW
	Y3M9kDqaVH20/DH6Q2hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i9lv3-0003CT-BA; Mon, 16 Sep 2019 07:59:33 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9lv0-0003Br-EZ
 for linux-nvme@lists.infradead.org; Mon, 16 Sep 2019 07:59:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3E90D68B05; Mon, 16 Sep 2019 09:59:26 +0200 (CEST)
Date: Mon, 16 Sep 2019 09:59:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 2/2] block: centralize PI remapping logic to the block
 layer
Message-ID: <20190916075925.GB25796@lst.de>
References: <1568493253-18142-1-git-send-email-maxg@mellanox.com>
 <1568493253-18142-2-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1568493253-18142-2-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190916_005930_644041_86FF1D14 
X-CRM114-Status: UNSURE (   5.66  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, keith.busch@intel.com, sagi@grimberg.me,
 martin.petersen@oracle.com, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 shlomin@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
