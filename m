Return-Path: <SRS0=9Kud=5W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC121C2BA17
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 16:36:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB15E24964
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 16:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nv/GlI+5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V15qO9KA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB15E24964
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a35/OB5KT3/GBn95b3PCviCA9CZMtCMJePIQowtGSuQ=; b=Nv/GlI+5oBtuYY
	V1YTRnrPpotYwpVxMqaqXXbQssSwNJTuFLXmBFTemnmTyB1IkS5t4QIjcD/vYlkyvSmDWB4cw1eZP
	ffUiO2zICkULoeWJFv4IeSlal78R/0z6WS8PBswtyoWsxXVX3EbBYIG1+QxDNTwD6PrO7dgsV6rNc
	DaL39qpVV9LquJyvhOKl7irM5Wqqsq/DLvvvGLiFG7bhO6leq9l6EkH5ysPzS0VHg0Wn6eFdo0lrK
	saOPy84tMCngukrtMn7R1/pjmqrhAuJeUqg5tCFltWdNE837xh9KoypmyDN0cLk9AA5JoteRCx9NZ
	L8irrMplpVSg88/OCgpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jLUjx-0000WC-Pr; Mon, 06 Apr 2020 16:36:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLUju-0000Vp-G7
 for linux-nvme@lists.infradead.org; Mon, 06 Apr 2020 16:36:47 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C5AD24964;
 Mon,  6 Apr 2020 16:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586191006;
 bh=DsC3eeaxA5lbSQq8MAjr0mMo4dej95vWUGj2DZK/6+A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V15qO9KAs/fpEMa9TSn7BjxF4bmISCjHIp9HfpFrlF7Sxm51akHAyuUndhA8nUC5x
 dm0wiWN8LolEP+UZNCKKlNVFjdXTpshhLWq86GJMGcmOVvgYgmEbFOetAqO3UD0Zqr
 leWNRUFnz80YJPqAmaVe/H345AZBh+cSIqJ/HZ/0=
Date: Tue, 7 Apr 2020 01:36:43 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: a few more namespace scanning cleanups
Message-ID: <20200406163643.GB26845@redsun51.ssa.fujisawa.hgst.com>
References: <20200406121352.1151026-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200406121352.1151026-1-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200406_093646_560442_FD841016 
X-CRM114-Status: UNSURE (   6.46  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good to me. For the reset of the series:

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
