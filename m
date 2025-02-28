Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282C2C282C6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 17:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jmEfv1cxzWF1lXe3SDA6PYp3fJr5POSg3Ma667tGLlI=; b=pHGu+DV2WIodhfMgb+sjwFH8+u
	DwFgreK4MYIkjiHOoXXD/b4teB1flTtcLkIYegAq09wYDSBur/WuFT3sXYTbZtDOUlauU7MXG9/6i
	NRq2N+X5yGqumr6ZISdBauAwVJUcieTmKZ1YILtJMRaOUgUZ8n05c98uySXyYkOe8oXyVSezzaQmq
	geYUmMosQrEdRjNhtUg79QO6N4XEhu8V56rF7v31Z/eL6rwGEhpF4xGuCH6zkV0VowcJNT88oiyW8
	+6cWyvaEW09iZ/ATj4MdzrtjJu2aZWJUzQ1SYo1kiSBEQN/ubA7Tiw2PGtdk5Vn1Lss9Y9jucgRfK
	hu9po9Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1to4e5-0000000C2vU-3FT9;
	Fri, 28 Feb 2025 17:59:33 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1to4e2-0000000C2uy-33lk
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 17:59:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 411E45C65B5;
	Fri, 28 Feb 2025 17:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1CEC4CED6;
	Fri, 28 Feb 2025 17:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740765569;
	bh=cthMVJCzwUynFdktQpl6YHLefPl1KyvUYWfd9SAmsI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rRK7/4dmHZlbU+nbG1JlahEkb3lSZ8k+r4mS5nJo+Pkju++xG70+K4gmTwpQPy9SL
	 TxA/UXlV1KY1pd4PW5PiHUKQYRxeKgoLxMXrsT/tGwRYGOJDEd9vqRSd2naazWLQMq
	 AvcGsGRUvhtxxVWc1tdvmbNJFP3KdkbEzcWC1X1UuuhWlGmAPVtqVnyBp77Qf2SKuz
	 oS9A0NEw0EVloVFXZSIGmdkdzwdPdsK88jaAV+AWNCwauxNBymVqPbiGZRlQkM9nhf
	 6qxrTO2hBGgs6sl/EqoyRDyvsoFP0VnQOc51yTFFKfRH2QjqQmLyEvWdJgCPwZFPFI
	 WJTBnWGPDwYOw==
Date: Fri, 28 Feb 2025 10:59:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hare@kernel.org,
	mlombard@bsdbackstore.eu
Subject: Re: [PATCH] nvme-tcp: Fix a C2HTermReq error message
Message-ID: <Z8H5f71CGG6aJmmO@kbusch-mbp>
References: <20250224144058.693927-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224144058.693927-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_095931_907936_10039983 
X-CRM114-Status: UNSURE (   8.77  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 24, 2025 at 03:40:58PM +0100, Maurizio Lombardi wrote:
> In H2CTermReq, a FES with value 0x05 means "R2T Limit Exceeded"; but
> in C2HTermReq the same value has a different meaning (Data Transfer Limit
> Exceeded).
> 
> Fixes: 84e009042d0f ("nvme-tcp: add basic support for the C2HTermReq PDU")

Thanks, applied to nvme-6.14.

