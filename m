Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C3BC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 02:31:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3ED52070B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 02:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="raSgmUFm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/h51P7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3ED52070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QIl7gY2bSb0KcWLClcHKjhjlCQ9EcXSDr4mFhMGaUn4=; b=raSgmUFmYXVAN6WWIh1rp/Sf0
	hSEXHKTkvXLlNrcjXY6JmHgtOUxaQVOYq4TSyQCdDrTnjq5OAO9zkstHSIExlyZWT0RNlMJXwLn6T
	XiRzUgujYfyezshevOhf1uZKiZMFwNIWJ9AMWdrFE6/agZTtcHTleC6f1eu9W5ImfPExF2o6YQXmj
	iQ6WwUv5Aj+rcoEYPUJQywvu5MUojiN4VYLmSl8ki6Yvd9a7Pt9JBculRoU7OpNDFxwFEIUhbvDlU
	E5loi8rnbneYtXFKummZpdLR765Cthfk0PovaE5D2hQLoK2iFd2D+a+PvSKEwHdn2rx09U9QRrp8X
	lal0bIjPg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0bsD-0005pv-BN; Wed, 29 Jul 2020 02:31:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0bs7-0005pV-HW
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 02:31:12 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 39EC12070B;
 Wed, 29 Jul 2020 02:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595989870;
 bh=sPkNx8ujapoRZ+wiWpl3aNApXzQpeMHkfuiKEL1HoQA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T/h51P7XX78GBfixkYC4QG1aFgz0c4qRH+efwHdBfVho2RO6JcWR7t5kmVqkXXPmZ
 jzAqSzj9iz1nuDnZP6QX1DVecrqolL1+WfJOyONAEOv6ZtM313aleIU653pFUcZJo5
 sBBp2jW4AmCQlrjgZ9f4ZT2kKtZxiuZsJYuuZP5E=
Date: Tue, 28 Jul 2020 19:31:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH] nvme-core: introduce the preferential local retry
 mechanism
Message-ID: <20200729023108.GB2729664@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200727060644.22782-1-lengchao@huawei.com>
 <20200728112050.GB31546@lst.de>
 <eed46cb8-1c6b-b83c-3ef4-bc06c922b214@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eed46cb8-1c6b-b83c-3ef4-bc06c922b214@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_223111_694831_82F6F781 
X-CRM114-Status: GOOD (  13.51  )
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
Cc: axboe@fb.com, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 29, 2020 at 10:06:43AM +0800, Chao Leng wrote:
> 
> 
> On 2020/7/28 19:20, Christoph Hellwig wrote:
> > If the callers asks for failfast, the caller will get failfast,
> > period.
> > 
> If user issue cmd through ioctrl, nvme core will set cmd_flags:
> REQ_FAILFAST_DRIVER, and then in some scenarios which need retry io
> after a defined time, we will return io error, this is not what we
> expected. So we need introduce the preferential local retry mechanism.

Userspace owns error handling with ioctl passthrough commands. The
interface exists for unfiltered access to the device; the driver will
return status exactly as the device provided it. If userspace wants to
retry an error'ed passthrough, it is free to do so.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
