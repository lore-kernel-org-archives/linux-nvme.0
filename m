Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E690EC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 17:39:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA30920674
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 17:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lqu8Kjog";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2GWk3PW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA30920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0FMD2NRAuqEwzzNIcr63ixgbk32TQzp64rka7xgGV2U=; b=Lqu8KjoglkktW+WaRBGnYdovv
	5sup1RPtBq50f9jcn0Dj9W4fDj4Ppy0K8Le/g9KwSu/aVvgZLEykutYqHzreQxIqnOiXJkINnc4OF
	0FhWndDoVSNOfPtnBmd//Hpe8wUQR8thACt9ewI1Q6N797CG6E+V1OPrWqgVX9eXaGmZDMR69gAaH
	V7FOTMDN0UgyDlHkRePO9I7gbbLoExVv9+ntBxBQ+SJ6ZZGbhjZ+8HK0K48k2deA4E68Ggzppy4vh
	hh0d5T9Sta49+Ye2a+qfB14jBVZeLRxX3CJ8QkFRASif1r7z9f1moE+e+2N336NtfXaA9rwYB8wNA
	Ftp4YQugQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k85aI-0001d8-Mr; Tue, 18 Aug 2020 17:39:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k85aF-0001cI-Gp
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 17:39:40 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0F8D420738;
 Tue, 18 Aug 2020 17:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597772378;
 bh=X2MHH+ajAt8ye/9QwPzB+aG8Y9hDwLgxvzGBUmiUFUM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A2GWk3PWMd1NreljfZxP+OqUTzod2fm7mIpCQ2qDQ3qvyktQFZsiI1Hu65eBGngzS
 /pdohnETh4V1X31tm8Fvq5I+D2HMEhhxkB8xsfbl6HRDH09D5WWdq8xSfdSRmMlL5n
 W52qnLFBeZuAX4Ov7JTOB9KCrbr3c4fgaVtkzFxY=
Date: Tue, 18 Aug 2020 10:39:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Javier Gonzalez <javier@javigon.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818173936.GA3097355@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <20200818165811.GA2979311@dhcp-10-100-145-180.wdl.wdc.com>
 <20200818172912.e54klrofz3tfhxhj@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818172912.e54klrofz3tfhxhj@MacBook-Pro.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_133939_647921_B4870A15 
X-CRM114-Status: GOOD (  13.58  )
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
Cc: axboe@kernel.dk, Damien.LeMoal@wdc.com,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, johannes.thumshirn@wdc.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 18, 2020 at 07:29:12PM +0200, Javier Gonzalez wrote:
> On 18.08.2020 09:58, Keith Busch wrote:
> > On Tue, Aug 18, 2020 at 11:50:33AM +0200, Javier Gonzalez wrote:
> > > a number of customers are requiring the use of normal writes, which we
> > > want to support.
> > 
> > A device that supports append is completely usable for those customers,
> > too. There's no need to create divergence in this driver.
> 
> Not really. You know as well as I do that some features are disabled for
> a particular SSD model on customer requirements. Generic models
> implementing append can submit both I/Os, but those that remove append
> are left out.

You are only supporting my point: if your device supports append, you
get to work in every ZNS use case, otherwise you only get to work in a
subset.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
