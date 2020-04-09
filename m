Return-Path: <SRS0=0ID+=5Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5660C2BA19
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 17:22:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB1D20768
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 17:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c0fqqfOx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKhkNs6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB1D20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tQp+riCyIp9P45eTR0+Ux0b6vVlERgcw3C5CWZv2vtI=; b=c0fqqfOxRwbFqf
	+LcJG9obfBIkBnqeK8R6ySKnbbT/FCFgUiZUp0gGtkZZ0Xg1cBKsb5UMZfyqmMFWqQFYKMGXL+Ntk
	inOBxPb+QrHUA7iNZh0daPOMTE1LIk2MrHjGo8SeHCnIZV8mrpc72phmLP/2MCHJ5GZ5KrQ5q7pRr
	wxRCVOv4psCKHS6/sxCqjroNADSZp09P4o55m0KEdqKJeQYPhb4HFw2bDryH1qwXs0JhLxIztmtvO
	4AWHRq8CVBhORFmc0pA8taXPPofPa4p0bmk0x9YVR+7aO9mrOhAI/D0hDQgZpLw4E6UFBUhG0JdBi
	1WBozEjfCPYUe5Ir2imw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMatC-0004p2-NA; Thu, 09 Apr 2020 17:22:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMatA-0004oi-ST
 for linux-nvme@lists.infradead.org; Thu, 09 Apr 2020 17:22:54 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1D77D20768;
 Thu,  9 Apr 2020 17:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586452972;
 bh=KQnxe8lhvYaudueTGgDkU4reyAeWvYuC+oZFL3AxVUM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MKhkNs6tMAn7VMegFkfMZUhkV1JdJ9w+eput8d9iDrkMjEynvoDNapcvh6a1I41ZI
 V3U1fh7kr9Cw+8Eg6zdGX4YVgVjBQtaDCCw2lWBO7WLWRgFallBxfchgbjCQnCU0mA
 5+vicoSFBy1Y+U87hHeSNzVEW88TifDbueaj210Y=
Date: Thu, 9 Apr 2020 10:22:50 -0700
From: Keith Busch <kbusch@kernel.org>
To: Weiping Zhang <zhangweiping@didiglobal.com>
Subject: Re: [PATCH 1/2] nvme: make sure write/poll_queues less or equal then
 cpu count
Message-ID: <20200409172250.GA1889561@dhcp-10-100-145-180.wdl.wdc.com>
References: <cover.1586447291.git.zhangweiping@didiglobal.com>
 <134d9a5fbcf54c1efb8ffa33a5439cd48094925c.1586447291.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <134d9a5fbcf54c1efb8ffa33a5439cd48094925c.1586447291.git.zhangweiping@didiglobal.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200409_102252_939913_19E9E51B 
X-CRM114-Status: UNSURE (   8.34  )
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
Cc: hch@infradead.org, axboe@kernel.dk, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 09, 2020 at 11:57:35PM +0800, Weiping Zhang wrote:
> Check module parameter write/poll_queues before use, if user
> change them to larger than system cpu count, it will trigger a
> warning.
> 
> Reproduce:
> 
> echo $((`nproc`+1)) > /sys/module/nvme/parameters/write_queues
> echo 1 > /sys/block/nvme0n1/device/reset_controller

I don't think it is safe to allow these parameters to be runtime writeable
with the current code: the driver allocates space for queues during probe,
so you may end up with out of bounds access if you increase the number
of queues the driver creates after that.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
