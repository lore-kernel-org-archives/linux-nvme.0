Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3E2C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 15:38:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22F6610A2
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 15:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22F6610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qF8KThleZt21cmh3H5BFOBY3CLPC5DO6+HjWXsN2Xzo=; b=YQAq/FSYow+wukpi0FpfuPOcvI
	hIrJvtXxS0+4lAglU4VWMu2fuOF9HsyE/aynv2PyKQuyCtVahLUwu484qP6PGvZcsqBBNasc1hauX
	pGbEjYIfs/bQteBGADu8Pwkov4OC83bnko1QzJaPkwzxhha9qO34vLkZvPoJA3xkN0y/yzDGSz7dT
	nGRLu+6AyQjSvuhylw3MgCvGyaYc7bqgQoZo3GFQ11hoFRwdJMBn3MtKpXFsXZzeOMyq15iVNT3ec
	QZRsr44BGIbYvO9DSG1AP8LQWImgT9VQPcfey9m/kKPLbTmn3ThEz9/BH9KowOLFcsp9IToSWe4kY
	Jro2YbUA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljkkU-001jWa-6c; Thu, 20 May 2021 15:38:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljkkR-001jVM-UB
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 15:38:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=GqhCxlum7d3a2zHluSMIV6lcdz6f9Fs3QLGp0JgbMq0=; b=D0F3vkwZkbwyivv17grmNAvpRM
 RE7QmfzgjA9X+ndMiByaSyIhfarW1Kt/jIJMmy44tjcAueK0VntWRXHuu6DAKi37XElxw7rJOZC5y
 esux4XcbuDjLfW1HMKESoCV3oOOyCn0xd6+AQiFHMwsEZeydio60tB0TbsxHWt6+CrT82W0itvbFg
 w2dEcrEyXuUJcAUVFgLFFwwUTDU+eENZf5Mlkbug1aj9hQ8hMnm/8ZEzKiIuX4V8sN9DbvVspQwgc
 D4xpAQ+k2l3+n2C+yHqKO1T+590GS1RK3pOiQcnnExh1GtPJa0ULNHzDnmNSPBOICX2IPV47nVpx8
 wtIdM/sA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljkkP-00GTQb-LG
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 15:38:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 537CB610A2;
 Thu, 20 May 2021 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621525084;
 bh=GqhCxlum7d3a2zHluSMIV6lcdz6f9Fs3QLGp0JgbMq0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sqky9cn7vw7/nZGCtjG678tgFu8o4VakTrDYOh0280XWUdw/w7OEanDe8veD5mGi7
 vMb3UeLIO44g7uUALE+I93m48SKi5/wrgyXnRoOjX6l56w3w+EIbxoB0BLd41bgDdv
 gv0i+z6TqZViYXWdq5yBNhbqDENuuuTnCFnnThfleT92DnNeeyYdKGz2KR0uvJomID
 MXkeDSnn5nMOTUFM62SKc0sS5NR63Or3JaJdEun1cKaohlVCr5Ys/RiSeNsTXdV0Kq
 6e7N/32E+jbMCorpFYegxVceSCFqV+9DzobZjWIwQ4PzFmuMi9TIISPSrodhNhUm3e
 K2CRnTpYAhuqQ==
Date: Thu, 20 May 2021 08:38:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Minwoo Im <minwoo.im.dev@gmail.com>,
 linux-nvme@lists.infradead.org
Subject: Re: misc nvme ioctl cleanups
Message-ID: <20210520153802.GA2937281@dhcp-10-100-145-180.wdc.com>
References: <20210520054426.567241-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210520054426.567241-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210520_083805_732732_1E4F609F 
X-CRM114-Status: UNSURE (   5.12  )
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

These all look good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
