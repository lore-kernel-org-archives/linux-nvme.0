Return-Path: <SRS0=nRQ2=4H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C84CC34047
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 15:20:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6634324656
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 15:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nBjkctwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6634324656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+jh3GYVhKHwotC9dBQYxyk7up5jg+D19FLsJW7N/LpM=; b=nBjkctwQcptJxM
	bBa12o6zdJhGfFuVFvdrNa1OJ5ZzU0uKYLWdimTnftvlX0rdum9FPP/bIMsMW18l+N4DaYYtbLSzN
	HZbjW1DcXd/M7w9J88B1s4HRTWqtAHkTE9KBOJyfJBtsNwMmqROkG9tzi83VEbTcmBOiNcWO3TGAS
	PCzambFYOQd2LQIO6shhU8ONdm/tF9Gg/Wr8FYC1jcTakpHhS7z8VOXIHUjoRgr7Iu6hEa8w7TW9w
	Rm3zcLs2zxQGctSHT9A3AMASfWIoQfwb3W9eePcVvVKtUWyhzaUhfcUcRgdxMCWmv0q7qhOJFxcS0
	7BSwuLZHWLHRqUiU3mgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4R9k-0004v4-6w; Wed, 19 Feb 2020 15:20:56 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4R9h-0004ut-SV; Wed, 19 Feb 2020 15:20:53 +0000
Date: Wed, 19 Feb 2020 07:20:53 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Talker Alex <alextalker@yandex.ru>
Subject: Re: NVMe/IB support
Message-ID: <20200219152053.GA13942@infradead.org>
References: <12132471581079402@vla4-9d01d86ae0b7.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <12132471581079402@vla4-9d01d86ae0b7.qloud-c.yandex.net>
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 07, 2020 at 03:43:22PM +0300, Talker Alex wrote:
> Hi,
> 
> is there really exist NVMe/IB solutions?

All the original NVMeoF development was done on IB, just using the
RDMA/CM IP based addressing.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
