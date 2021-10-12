Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9740C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 13:04:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6981B60EB6
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 13:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6981B60EB6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fJ6VqF/PANQKPctLZPVEMI+xU2oLtkQDGHiytKVfBLA=; b=ijhZrVMkauHAP0
	RpFeuLsiLm+lnqokiUi4APMcZP+NV4FaXdnwBJxptSORpnIDHgT3uDaVMlJUCReml7S4pcEeio+hI
	DD2yyme2H5N9+IdEUblygIcAXqq7tp2a4BT6jRkb/LfUK+y5Mxe3WRLCfbJVQPrySRILhvI9i68+0
	GWorroYtPDgpHjG9UIkEY5urNk0KvtfD1StVsFQ5RUTjXK2gxTv8DfX0H0+8k8tf8rg+DqJDlgN1t
	L7kHIWHzITHo7dlzeY01pJo/4w5MW5lvqz9Qc64VE1u6tYLM+OPRCfS+J8Pi0yYLpJ5pfkDKe5rPT
	dsW15pGbBw+AKB9pRnMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maHSB-00Cpsv-Cd; Tue, 12 Oct 2021 13:04:23 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maHS8-00Cprc-Ko
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 13:04:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 19BD267373; Tue, 12 Oct 2021 15:04:18 +0200 (CEST)
Date: Tue, 12 Oct 2021 15:04:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, chaitanyak@nvidia.com, israelr@nvidia.com,
 mruijter@primelogic.nl, oren@nvidia.com, nitzanc@nvidia.com, jgg@nvidia.com
Subject: Re: [PATCH v2 0/3] update RDMA controllers queue depth
Message-ID: <20211012130417.GA11205@lst.de>
References: <20210922215537.6499-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210922215537.6499-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_060420_864144_37F86FB7 
X-CRM114-Status: UNSURE (   8.02  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.16.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
