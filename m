Return-Path: <SRS0=yUYt=43=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20598C10DCE
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 20:54:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92AA222C3
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 20:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jENEbCg9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z5ts/8eC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92AA222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2kBueSyT9lG9u+91NSseY2SZDFgalHAZIgloEKJ0a58=; b=jENEbCg9SJ5b9d
	e4pKFlRwbaly5vS0NXRd9V4f6R96PM/w0jNAy1UX7U1qgx8DcFnDswg9QZ/xZWp266u382GIrksL3
	V8BYDrf2rX4u2W0AlG9PNfUp2Vv2UBFjYm2ScjESx6UsiCrAJfIj/65h14N2/IImPHijA4YbNzsKo
	jjq9wBhJIh/SonrQkUynRW3O4mXxPEO2agGWdwndHQXap81BbhpwV5yHnEsoZtqPoO17NvVLV9Yv7
	W5P2gg4Dg7ovw5ANaFURJ8/SghLJxjPdX7lgFYxFmkiGreVA9EOoGT4c/ite34COjr97OpLwA4X/y
	Q7lv0+lDOdoTKiVqNhpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBlt1-00022A-Hv; Tue, 10 Mar 2020 20:53:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBlsz-00021m-8H
 for linux-nvme@lists.infradead.org; Tue, 10 Mar 2020 20:53:58 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9EF19222C3;
 Tue, 10 Mar 2020 20:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583873636;
 bh=bF6sSIodPU9nAapKOpH16NP9C35Bj2zaGPjUSgdj/Fs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=z5ts/8eCTS+kYPLr399Csg8kP3tlna2QZQKdkCiwjQmXaE4foAMrojjftzpJe8DGW
 QswuGCL4yMRooOHpreMWG6sMsfIP2Q5tBve9RvVg9B3SWg5dW2eOJkemReoLXXZn9Y
 QwCsaPu2kbOTtOAXSEPjWGQqnLHpED5HvJ/jmtZc=
Date: Tue, 10 Mar 2020 13:53:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvme-tcp: move send failure to nvme_tcp_try_send
Message-ID: <20200310205354.GB604509@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200226004324.10694-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200226004324.10694-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200310_135357_314912_439AEF8B 
X-CRM114-Status: UNSURE (   9.23  )
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
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 25, 2020 at 04:43:23PM -0800, Sagi Grimberg wrote:
> Consolidate the request failure handling code to where
> it is being fetched (nvme_tcp_try_send).
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Added to 5.7, thanks.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
