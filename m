Return-Path: <SRS0=Iz8v=EI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ED5C2D0A3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 18:34:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A9D22245
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 18:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wYgvLj6p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJYgRC9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A9D22245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QCZGiBBRVV4iKRCpqGU7I231PzY5TVV1r5g7WE3YbxQ=; b=wYgvLj6pzGOmRonR5qmKyCiK+
	oy9Ne0M6vPB7oCAPJLNYv+Ypq6QnYCZmfEXKKeZF3d7QyErxkC7IUTurLdAxA/ZoeQ69gtKDHk/Cy
	Dl+MR+mVtUHT38marVYDXMX2MLB0qUaJi03We1kESynYAds93r3/qrzmVusJutOz42rNd6ldkw+Pk
	/SlJ+CpeiO1lLvI8TrTnHN/qzwTOQbsLJi407eamSS8Zqo6TtqpCv6iKpynlFIP75FDGAxLhk2gko
	wFei6s0shetbQNLOl7dDsfjkukSTpF3ETBEfM7AQBSRx8n4r23Zmxilo3BvD7GVSusgob7hK7taKv
	7tgZRyq3g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZeeX-0002N7-Rd; Mon, 02 Nov 2020 18:34:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZeeV-0002MK-Bn
 for linux-nvme@lists.infradead.org; Mon, 02 Nov 2020 18:34:00 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8C42722245;
 Mon,  2 Nov 2020 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604342038;
 bh=8Xk9SHcN724jkmqolETaQdwcKCNm99W5ejOMIzeeWWk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NJYgRC9RyEjCoXvd6B3nVza41sccjCZ4wJnXfKQnN9jRYOVPqg9GmO3rwyH/wTNrD
 0ne2trMrwInSpSQp2N9HR4ZE3eRcXQDzJ6eYQuTuFttNt7mRSa9PNXUJhs6BP0Xgi8
 HXUSmx0v5y6SDF2Gea/bmYVc/yh5Py30v05PyShA=
Date: Mon, 2 Nov 2020 10:33:55 -0800
From: Keith Busch <kbusch@kernel.org>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102180836.GC20182@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201102180836.GC20182@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201102_133359_507741_2F0EF461 
X-CRM114-Status: GOOD (  19.04  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>,
 "javier@javigon.com" <javier@javigon.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "Klaus B. Jensen" <k.jensen@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 02, 2020 at 07:08:37PM +0100, hch@lst.de wrote:
> On Mon, Nov 02, 2020 at 04:15:01PM +0000, Javier Gonzalez wrote:
> > That said, I don't mind the concept, though I recall Christoph had
> > concerns about the existing 0-capacity namespace used for invalid
> > formats, so I'd like to hear more on that if he has some spare time to
> > comment.
> 
> Yes, I really don't think 0 sized block devices are the right interface
> for namespaces we can't access.  I think the proper fix is to ensure that
> we have a character device that allows submitting I/O commands for each
> namespaces including those where we don't understand the I/O command set
> or parts of it.  That should also really help to have a proper access
> model for the KV command set.  Initially we only need NVME_IOCTL_IO64_CMD,
> but eventually we'll need some support for async submissions, be
> that through io_uring or other ways.

I can see this going one of two ways:

 a) Set up the existing controller character device with a generic
    disk-less request_queue to the IO queues accepting IO commands to
    arbitrary NSIDs.

 b) Each namespace that can't be supported gets their own character
    device.

I'm leaning toward option "a". While it doesn't create handles to unique
namespaces, it has more resilience to potentially future changes. And I
recall the target side had a potential use for that, too.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
