Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEAEC2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 03:12:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9212E2067B
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 03:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DVWCCHV/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZmMd5yt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9212E2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jfD4Iiuz+lRyKhE/tIFvG6xw92GfWIwzmm5E2G7kxDE=; b=DVWCCHV/KThzDwBQsnBuOGPPL
	ecaNWRLJQEL/8hLWET2DO78FwaX9NT7j8ats8YcwJS7KUhakU9ICtxixLBQ6o1lX8Ss+QKEOGaad0
	ufBSzyAX2FvX+3OY4us3woMwfZO4lynasPPSqmpNdleMeoae4RiB3rwID1+GTvUHdoHez8y30jspf
	g4h9FUk/wyn1N66E/+rfcTPkv83PspoUY/tDM36mKUGeoHaDUw5Q9Nq/5HlVes3ZJDUFiViMOihbq
	BNpGUTA7kfrVozxd4VynNoioqzlqXjb/2Xpz38iM0/CXLvx3gfVhZ6/BDdJpLkRQRDrYKZEozIHbL
	qrwa83wjA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcK5D-0004CF-Of; Tue, 10 Nov 2020 03:12:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcK5A-0004Bq-Q7
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 03:12:33 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 354AE2067B;
 Tue, 10 Nov 2020 03:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604977950;
 bh=eq0HVHMqexHuFFM3Tj80XG4LdqaBSf8nvUVKlJf8xPg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uZmMd5ytvCLJYNbyyZnxeGHgXH7Xgb22gbr1prdPF+saiEV7cJlMfZ3T0LupIp9B/
 GgDVfCWB6sO8dJpoN3xm2i2vrXRLd+RwkJDB5WILbIrIl4e+2Ufr8q0cEOES876mzh
 0K1XbIcwEJEunRIlEkfHyanXnDK2PgGw3fU6l7rE=
Date: Mon, 9 Nov 2020 19:12:27 -0800
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] nvme: Boot as soon as the boot controller has been probed
Message-ID: <20201110031227.GC2221592@dhcp-10-100-145-180.wdc.com>
References: <20201108040903.8185-1-bvanassche@acm.org>
 <20201108082403.GB40741@kroah.com>
 <20201108223152.GA2219646@dhcp-10-100-145-180.wdc.com>
 <8ee7a7b0-5be4-99a3-7314-77d784e2ebb7@acm.org>
 <20201109023544.GB2219646@dhcp-10-100-145-180.wdc.com>
 <90da3071-0d73-f007-5892-d683de71d964@acm.org>
 <20201109150517.GB2221592@dhcp-10-100-145-180.wdc.com>
 <8c710753-a52f-1ddf-d5b6-dde3847b3749@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8c710753-a52f-1ddf-d5b6-dde3847b3749@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_221232_946229_C803BCDB 
X-CRM114-Status: GOOD (  19.71  )
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
Cc: Greg KH <gregkh@linuxfoundation.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 09, 2020 at 06:51:48PM -0800, Bart Van Assche wrote:
> On 11/9/20 7:05 AM, Keith Busch wrote:
> > Resets can happen at any time, so user space should always have been
> > prepared for this. Is there actually a real case that is not working for
> > you?
> 
> Hi Keith,
> 
> The use case of running nvme-cli from inside a udev rule is not
> important to me personally. But reducing the boot time for systems with
> multiple NVMe controllers matters to me. Do you want to recommend an
> approach or do you perhaps expect me to explore the possible
> alternatives further?

I only mentioned the changelog doesn't require a fixes tag. I generally
don't have a problem with the patch if it really does improve boot
times, but I'd like to personally try it out through a few scenarios
first. I should be able to complete that this week.

The only comments on the code I have are that you can call
nvme_reset_ctrl_sync() instead of duplicating that, and you also need to
flush the scan_work after to ensure the boot namespace is available when
probe returns.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
