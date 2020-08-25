Return-Path: <SRS0=/Y//=CD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573DBC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 17:15:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5D520706
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 17:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tq1DJ7bD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHBmaz1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5D520706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ULXf5LiMzcL54pRzoKMOMhMdVav2TxSTtT9viTkpan8=; b=tq1DJ7bD7fY/tVAW7cDtwQ9S+
	HAvg9zTY8+2A+znhrVOKpC0Cof+Cgs4I9EGMyBQbXsBqNcG5xDHZj2PFZm6JUcTDM37LzSbdANYu0
	c+ohubPJrvJzk6k0ON1T5IqRbfQX4XTpOjWhOmmmQ7kmE/q/sTXh/NqwZNnh4Ym6I3whK9RtiRfQ/
	foXhojl2yXndPK6ZsYQSFQlOR08s1Yk+cG2Cq1gmcLR6+fVACoycosINJVnSmrmz+stuM40a+Aq/2
	wwCOkbepObFs9ElGPqLQLZHpX/oEb5nUyTe+thHSqcXb69ChbI4t/TCA6WK8WtQzSQy46zOoqOJRX
	gZuDhsM/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAcXO-00034F-UZ; Tue, 25 Aug 2020 17:15:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAcXN-00033F-69
 for linux-nvme@lists.infradead.org; Tue, 25 Aug 2020 17:15:09 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 39C412076C;
 Tue, 25 Aug 2020 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598375708;
 bh=ACinW5zJMTkxzq9hqgTuDaw8rIaHEC9upe6ZZfVaopU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LHBmaz1jtSsoPAuVP8LLRO/Wk7/ZaTcHgOoGeutzZAtsLV7+Csc2Xco7z7QBsSksm
 ywB2DPOcdt2grwA17Gn34qjtPQRDFgRuCg4x1pMXzX6VlPHcetOVGc3fy6zRBtBxdC
 CdR0xV2+dF2IkdnJLct61ADHfZHSo5b9fMM0LJNY=
Date: Tue, 25 Aug 2020 10:15:06 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: fix error handling in nvme_ns_report_zones
Message-ID: <20200825171506.GA1706363@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200825095824.3542647-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200825095824.3542647-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_131509_360370_836E9EDC 
X-CRM114-Status: GOOD (  13.22  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 25, 2020 at 11:58:24AM +0200, Christoph Hellwig wrote:
> nvme_submit_sync_cmd can return positive NVMe error codes in addition to
> the negative Linux error code, which are currently ignored.  Fix this
> by removing __nvme_ns_report_zones and handling the errors from
> nvme_submit_sync_cmd in the caller instead of multiplexing the return
> value and the zone size into a single return value.

Indeed, looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
