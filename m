Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73195C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 19:14:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B26D2075A
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 19:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lhH/0Og3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQnBAZ0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B26D2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vvNTO4h6yKUaLNabzmVJ5PpjtcRnXTNsFGzH4TEKsZs=; b=lhH/0Og3qmrbO9
	h9AAi+2bWlL87w4GP/l3mtTC+HJbnLVdCNy1R2Qp5mI4HEMhN2fFjmyfZ4iJTK5g8LoyqI72w4Rzc
	Vx3y8WA5iorptw39IuzixNWzI+ffR6RUlYUDQL9BprHN9Y2AAaUE2zQ8Dx/J/Fdjfxhk32xsDNT/l
	o8ltMKRHxYKbi/Jl/d4VhbHg6Y8xgmHUHamwkZPGKTnDm5EI3OU1DRlQ85zRy5xiS5nZz7HsND0+Y
	qgyjcT4Sh/uY8/BJamAO2mWecfi1G9yUqWJGakxqOz02GYB6hmdEZSCZ1NPQTVuLDbehSUyCz7MHh
	hueFT4hD7uIfq/em3nyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeNzM-0000xl-Ol; Thu, 28 May 2020 19:14:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jeNzJ-0000x7-UG
 for linux-nvme@lists.infradead.org; Thu, 28 May 2020 19:14:47 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1EF502075A;
 Thu, 28 May 2020 19:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590693285;
 bh=4TNZ1gE0J4wNNJPj2ShQ7dR9eAGvXi/dNokp1xdJ1OI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vQnBAZ0NqV80gCe2QUr33PmR+PVVlLb7Cmd5VglOG/xZ3VvIeNz3vaTQKO0hjRltS
 tRKZEFj3Y1ph49XjLmsb1+K1I2jon+NgTlsZK7wv+sQ5UVce66g5SUfFt6D4eMDeAP
 GhtUP2otbjB1HgZSEJILaxkmySCiHN65JhiWS40s=
Date: Thu, 28 May 2020 12:14:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCHv3 2/2] nvme: cancel requests for real
Message-ID: <20200528191443.GA3504350@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200528153441.3501777-1-kbusch@kernel.org>
 <20200528153441.3501777-2-kbusch@kernel.org>
 <68629453-d776-59e5-cdc9-8681eb2bab37@oracle.com>
 <20200528191118.GB3504306@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200528191118.GB3504306@dhcp-10-100-145-180.wdl.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200528_121445_992873_7F60DABF 
X-CRM114-Status: UNSURE (   6.44  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 28, 2020 at 12:11:18PM -0700, Keith Busch wrote:
> You can expect your fake timeout with 100% probablility to take 150
> seconds minimum to return a retryable request.

Sorry, I should have said 300 seconds. We restart the timer for aborts,
so 5 requeues * 30 seconds * 2 timer starts = 300 seconds.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
