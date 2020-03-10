Return-Path: <SRS0=yUYt=43=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F728C10DCE
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 20:55:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B54222C3
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 20:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tDRY907C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQEJ+lnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B54222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ksJUWVZW/4FJMPokJNP/+CEKpjHskt8/b8lPh7S4r1w=; b=tDRY907CCEXwGh
	vHRKpp7wyqqRy/SjxEls77rwtKTTccsnGHCgI/bSUqyO2TW+Hw5WiRzCLktgNH90GJsbLxaD6TFBK
	gck9FXy3HwK9KIv7V79s3Yrs1j8KdDPqvIfmXRyrdY5pXvKFWh+Wx0wK5efEIFmJG2Dtqs3529wew
	4R8J4nlzk0KYoBtjazKZ73fBFQV+x8wpxtB1iki6GYJrPXg10Z8t/9Kn6uub3O5JNWu4U1DbSEKNc
	QEatckf9P4h6p1pxNqGpYxDUETq9+NPDXAymNvyvyspOGLVVAt0oKMCHr4wIl9n4PUQVd/qCUt6NU
	mfXG8xTcyejHyX1lzr8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBlun-0003i2-3s; Tue, 10 Mar 2020 20:55:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBluh-0003gp-Gk
 for linux-nvme@lists.infradead.org; Tue, 10 Mar 2020 20:55:47 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C25E3222C3;
 Tue, 10 Mar 2020 20:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583873743;
 bh=TmhV7Ibab64mvMhiUpC+1S0OkEm6Qbyu7H1UK+dE8OQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JQEJ+lnCGnu3zabQiSv4QApcFb+Tle6fwgj9acPaI88u1n7fyULSeC53uMOMiBTbM
 jOQRyt8b3WYIEvQ+0jmJuGptO0lcroxOqrZqX63pRSgoSmPG9UoAKTsI2AU002OMvd
 UJgonvA3Y9BJTZsdYlkekF+c9wyCNQwbkLGHxmcU=
Date: Tue, 10 Mar 2020 13:55:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Israel Rukshin <israelr@mellanox.com>
Subject: Re: [PATCH] nvme: Use nvme_state_terminal helper
Message-ID: <20200310205541.GD604509@dhcp-10-100-145-180.wdl.wdc.com>
References: <1583851150-10261-1-git-send-email-israelr@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1583851150-10261-1-git-send-email-israelr@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200310_135543_579737_3E6E5B15 
X-CRM114-Status: UNSURE (   7.02  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, Sagi Grimberg <sagi@grimberg.me>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 10, 2020 at 04:39:10PM +0200, Israel Rukshin wrote:
> Improve code readability.
> 
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>

Thanks, applied for 5.7

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
