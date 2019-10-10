Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0C1C4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 13:59:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF05820B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 13:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="STqei2Te";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANbFPRRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF05820B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6IxlcqJDHMAql08I1UIkVN+LJ00pgklT27p3Kov5hpo=; b=STqei2Teuy8x0I
	9BSAkyt+OAGkfdOnISVz7WL6n0xWbtdnVVFQCH78tZ8IqBjcwWpueDhKNS2RNyrmA+vHnJSNFMOn0
	DLZGRvU2YrZwq9addwgzQ5N0bYNYQstrgP6Oa4dYGdbcBB4SG5fSfWMs8zSQBmfQimclFTX8iXNXM
	1rJHGIqqRcqQU2/WwsO0v6AAGoaYqsQo0nZn+A4lKshRUtwdAfMLR4qapYE78OjIwGK0OYDOmTPTZ
	Yv3+iCSzZr+Jm0vLtnZJ0bSJBu0y3ZXeaeJOqBhqgWrtI4L1fUf+rLiWdaUHEhsh5h0aHWHVq8twp
	kN90NQnHcmMv5V3lTYlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIYyN-0003Q2-1s; Thu, 10 Oct 2019 13:59:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIYyK-0003Ph-Sd
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 13:59:18 +0000
Received: from C02WT3WMHTD6.wdl.wdc.com (unknown [199.255.45.63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C8BC9208C3;
 Thu, 10 Oct 2019 13:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570715956;
 bh=7SfNitKWDiLYxf+ydwz0yzlFVLE4laxxL3eKpciZFE0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ANbFPRRbVSbBd/btfkKBbM15HTOc+n3U4zvakzKRcnTwmfg1IfFiR1kQ8d9mAKNln
 ZNYVqWPv752NnOVwLICyi/SnW3XJg/5eC3uVXUB/xa9rbqyIezj4UFWUKZOSaP2M+F
 THXsPaCDrnnlGHcszvcfGHmjDOzdMiX2VBy3i0h0=
Date: Thu, 10 Oct 2019 07:59:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Judy Brock <judy.brock@samsung.com>
Subject: Re: [PATCHv2 5/6] nvme: Prevent resets during paused states
Message-ID: <20191010135914.GB56376@C02WT3WMHTD6.wdl.wdc.com>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <20190919213431.7864-6-kbusch@kernel.org>
 <20190927214121.GK16819@lst.de>
 <20190928002349.GA17232@C02WT3WMHTD6>
 <CGME20191010120317uscas1p1e4483ca19dbb0e550c413c18c5928537@uscas1p1.samsung.com>
 <2f876efff1484f5f95b852584b27efc6@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2f876efff1484f5f95b852584b27efc6@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_065916_948869_9E3F4FDD 
X-CRM114-Status: GOOD (  12.89  )
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
Cc: James Smart <james.smart@broadcom.com>,
 Edmund Nadolski <edmund.nadolski@intel.com>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 10, 2019 at 12:03:16PM +0000, Judy Brock wrote:
> Hi Keith,
> 
> Any chance you can get this patch in to the nvme tree soon? 

I'll try to find some time to respin today to address some of the feedback.

Christoph, are you okay with my explanation for not introducing another ctrl
state? We could add a paused state, but I think it's a bit risky for no real
gain.
 
> We believe it may fix an issue we have seen. We are throwing a ton of stuff
> at two controllers on a dual ported device at the same time including
> multiple nested resets, nested FW Activations, nested Formats, DSMs, FW
> Downloads, etc. We saw this in dmesg in one test run. We think Processing
> Paused bit was probably not valid at the time as we don't have any record of
> any FW Activates that went to either of the controllers and never finished.

That is rather unusual, which means it is a good test to have! Would you
consider porting your case to blktests?

   https://github.com/osandov/blktests

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
