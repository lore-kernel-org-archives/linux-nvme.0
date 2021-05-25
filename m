Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC49C2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 07:25:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E8B61417
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 07:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E8B61417
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=KC0FE5i+suFkGh
	ZBtZtX4r0bhUBEZkaGrYCySRGBZ5hzRKdzGqH5xfmpvgFXB/T1D5l2EJsnneBESUS8m4imsbiO7NR
	CgtEKrpn5Twf2AjkBeftxIUZjAUadyjA5dCrYsiw5EzFBwj1iXL1no4NlNAv23LAfxzQ8VQaw94N6
	K+SKM9i7lk8a52BG7Plhxy2nfLhTDDNjg+Xcuh/0VXfWjIN1xiq8FuMM70Wk4pr0vKYzP/u1p0hGh
	/wJpoZY2tSLy0f96boN3vdprXs0X90YkpQF3qzvk6AmVu87GpXbkd0kUcBKDR7hIVV2P8cvU0xPBN
	+AN4BU6Z0xLcoqg094zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llRR5-003sEe-Bu; Tue, 25 May 2021 07:25:07 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llRQe-003s4I-0G
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 07:24:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 12CE267357; Tue, 25 May 2021 09:24:38 +0200 (CEST)
Date: Tue, 25 May 2021 09:24:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guoqing Jiang <jgq516@gmail.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 javier.gonz@samsung.com, minwoo.im.dev@gmail.com,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix potential memory leaks in nvme_cdev_add
Message-ID: <20210525072437.GB14135@lst.de>
References: <20210521073239.722341-1-jiangguoqing@kylinos.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210521073239.722341-1-jiangguoqing@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_002440_221568_A1096D5A 
X-CRM114-Status: UNSURE (   8.60  )
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

applied to nvme-5.13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
