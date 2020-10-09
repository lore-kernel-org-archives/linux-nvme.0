Return-Path: <SRS0=D38N=DQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2182CC433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2020 15:29:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA0C422261
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2020 15:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3X97jgGe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WisCFbIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0C422261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/T2Sb3v9gGjDUGt4eWDqzKOE6F7LLAvgYwkfEhraQd8=; b=3X97jgGeJPXFnIxZF4ugGiJr+
	eoYN/gwEljYZNpNuJZBZVRq60Lipgu+QeUyiXl/HKtp5S0rAwAml7ioA9hsjcwxHAIMjE8K2wc5li
	KQ3AEVKDRxvNy8O0XSmoJQ1eHvsGhTQOzqB4yoHVHghBZwquK+12r2Yu7qAZbkmD47BMd5PWLNjQV
	Aa80zY3JH9bpPcLB7Q8ADDvbyLY3eeya8S4uAX0lzaDgayqgg4xqt7yaFTHi9C316ifRZf2wt6G3P
	LWAlgAl6r54Jz+5sc9vZywyO2zBR7TunmV+718qzgetnLBTCJ6PZR7yF9K0mgisU4LEr8CQaLeSFd
	tkN3WjgmQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQuKu-0005PL-72; Fri, 09 Oct 2020 15:29:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQuKp-0005Oh-D2
 for linux-nvme@lists.infradead.org; Fri, 09 Oct 2020 15:29:32 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6556F22261;
 Fri,  9 Oct 2020 15:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602257370;
 bh=+a0QD0XOHMqpJMDLxqtDZCq4Dwlwyp9i1c41fzMX1OI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WisCFbIltSHyFXLFhQO4rA5pwBjFv/nI+bjQ8ReG69XF0XaKek5yAsO40Yhn+GiVG
 nqNr4K9oEVOBYyADjiYWFr4LxShsVK5a8sOK5DyUC5K9HrFrNzXl9cxycpDtBRBGl/
 HDWTV3nJTzzP6RpdrhbXyKe207PlVvW7/JXd+s60=
Date: Fri, 9 Oct 2020 08:29:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Subject: Re: [PATCHv4 1/3] block: add zone specific block statuses
Message-ID: <20201009152927.GA1023921@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200924205330.4043232-1-kbusch@kernel.org>
 <20200924205330.4043232-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200924205330.4043232-2-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201009_112931_523329_654C12C2 
X-CRM114-Status: GOOD (  11.36  )
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 linux-api@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 24, 2020 at 01:53:28PM -0700, Keith Busch wrote:
> A zoned device with limited resources to open or activate zones may
> return an error when the host exceeds those limits. The same command may
> be successful if retried later, but the host needs to wait for specific
> zone states before it should expect a retry to succeed. Have the block
> layer provide an appropriate status for these conditions so applications
> can distinuguish this error for special handling.

Hi Jens,

Can be considered for inclusion? The series still applies cleanly to
block for-next.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
