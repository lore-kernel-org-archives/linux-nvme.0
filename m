Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF16C41621
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 16:18:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0B2208E0
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 16:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FfhrmgRY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQETVL7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0B2208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6QR0/RgKozGJM98tMCrNAZghCjCmLpQWZGZsLu7fgzQ=; b=FfhrmgRYXSDiQI
	RR6UN9l7rVxnHvGEIf2BqHmMWGPp0/vpopa1xRRm5/JQbAeCgC2ey4RswW/m3JlbAzK4DCEaHAiZC
	ECZFXZ21302YwmOu4yqaFipCFmhMNxh8rQKdhS/NJumFClK55t3SvBerAZ3nlMQNHLk2irMqyox5Z
	+iR6Q1A10ohRha4Ix3Nu62lhb6bHT0CRvzYjhdNfuuF4RRWEggiV+wEBaj1OPz3/k/5bqzK1QfD7V
	s3ntMo0YgG4VifP83yZEXZq/yEHdho3lt2HHicoCFKQINXiqwewYq+IYHKtzrohHndk5ANCCPghuY
	INR/VscpoH0z1HqHRm9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGmFe-0002vb-La; Tue, 24 Mar 2020 16:18:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGmFb-0002v3-Ml
 for linux-nvme@lists.infradead.org; Tue, 24 Mar 2020 16:18:00 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DD2B82073E;
 Tue, 24 Mar 2020 16:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585066677;
 bh=q2htSSKdYljCh0ysHYdmY1EH1LUMQzCgbnd2qnOExhs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MQETVL7CY+1gjnpLd6M5Eukji2pj3OdL+knb/PIdcRwWsls/rojrrjsCbrsoQkAE9
 ASo3wkL5bFVnP+ucNG7BeUL4OZW0hQ4IBfe6UfjHXv6MYRd134OS2FFs8vFoLX9ouJ
 /JH/6AQNu+ow2qg785lnpBSeC5o7d/nqXOHh0vN0=
Date: Wed, 25 Mar 2020 01:17:52 +0900
From: Keith Busch <kbusch@kernel.org>
To: Israel Rukshin <israelr@mellanox.com>
Subject: Re: [PATCH 0/7 V3] nvme: Fixes for deleting a ctrl before it was
 created
Message-ID: <20200324161752.GA30956@redsun51.ssa.fujisawa.hgst.com>
References: <1585063785-14268-1-git-send-email-israelr@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1585063785-14268-1-git-send-email-israelr@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200324_091759_772953_243213FE 
X-CRM114-Status: UNSURE (   6.12  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, Shlomi Nimrodi <shlomin@mellanox.com>,
 Sagi Grimberg <sagi@grimberg.me>, Linux-nvme <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thank you, applied to nvme-5.7.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
