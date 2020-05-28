Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A692C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 18:18:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3601D2078C
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 18:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oj0Hh+bD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vdJgTUdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3601D2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HP43kz6LPIeYpdpO0JFY3ZXZEH2dTwGxcCYYKa22yKM=; b=Oj0Hh+bDyFL2Dz
	72oxvUtVhjWVzPEvnTJsF/wpG0/xyAHkZHPrBN2bnOCoQbkxy9GNqNZMOYhl/GyMikclb6vQv49Yb
	OD+0qnFJic5WPbSrPkXD0T5PsqoHBplmg7vQUNJG9Sw/llKhfLLSjh/fZ15I+EURwxF9kj+U/DLWC
	3qipkrKxuPt+z6aGaewfVbdDkKPfrS0vF87yiIsZiNqv3PkiNjU2YYL26yiVr78L5jNje9A2kw+Vi
	6/x7HX7VDQqu2MXi82T0evAh2rQRTjm2aPNelxAvt6mcsTXlyuH3TaT/TWnxJ/fDrDmx3NMKjHF4+
	qQPDk6fWOgi4dJO1Ea/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeN6b-0001Y6-6u; Thu, 28 May 2020 18:18:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jeN6Y-0001Xf-KS
 for linux-nvme@lists.infradead.org; Thu, 28 May 2020 18:18:11 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 830372073B;
 Thu, 28 May 2020 18:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590689890;
 bh=AI6mftzqfL5PqUmgUmNnymIfEoSbNgy5qQglt19o9yk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vdJgTUdMWvo0k/8NfoBN38tUzqyyhsugmhAR4HGCIcVmcuqc4A5Difa48syV37mh8
 dv63NaSZ0H51K05wj0Zd8jRXL6rGQO0gTRkCHK9tCZVglOS5wiNC3VipyzgnBpB4kN
 rf7/2AuEtGfXiD4p/Wi1qZ/AkE3WnhXu8dJtagpE=
Date: Thu, 28 May 2020 11:18:07 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 1/2] blk-mq: export __blk_mq_complete_request
Message-ID: <20200528181807.GA3504306@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200528151931.3501506-1-kbusch@kernel.org>
 <20200528164256.GA25651@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200528164256.GA25651@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200528_111810_689468_DCF1E4D4 
X-CRM114-Status: UNSURE (   7.87  )
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
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 28, 2020 at 06:42:56PM +0200, Christoph Hellwig wrote:
> I think this needs a better name.

blk_mq_do_complete_req()?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
