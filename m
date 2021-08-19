Return-Path: <SRS0=ZTQI=NK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BF9C4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Aug 2021 14:38:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C599A6113D
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Aug 2021 14:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C599A6113D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f6mx5zhWMnhMeN0Xa1c96d1avQX1BU5VKDalq63U7Us=; b=rAM/vh79eUBav4
	x/HBJuFzlQzV6jzpE59lYkuLB4Y0voe1LzshflBwkoZwjqHdhNvPAKBqDEpoixozv1zqVPgE9/lqk
	YShrUwjDhN3Wm9UWZh0Q3YVvdQr+w4aLL4j8gJOPFOyGJW0MAXNVtML7j9/zOexysVSrPmm9ZUJZc
	O6ELA4mPuZ3RUcENZmt4Zzr7YJtbtKKPnWMkHwaxfobHj76WWt8Lr6Dg3so7ctZ7bAdJOEk1400R8
	NnPWI+O3MjZRcHOHBezN2HmvK2mOuybxpkC4adwzhDD4bAgVbYa9i8gw98Ghx6ia9g9uOs0Bt8hy3
	dKhODhjMP9/sAoHtwNnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGjAx-008fhE-RK; Thu, 19 Aug 2021 14:37:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGjAv-008fgt-Vp
 for linux-nvme@bombadil.infradead.org; Thu, 19 Aug 2021 14:37:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=O8f6t6sgVAabEzm1Z38nLiwdOTtbukfx8qrQ0y7zVwM=; b=eJ4WaQUd8IRgH7GBZ4jjnZIqDc
 loeOgBheyIGtgQDfXrpIvueIKAZhRPec1Pf9KwsD4ppQdINHAQV28/+tUxcJ0m9OOBTe2pwAgO5Ox
 39k70th+pIDHJDjNST98aqKH6OxB0wTrjbwRywkzVyxKNjT35KfE+CxtynZxz4FybsShnacMDUGnv
 75tM/jDtMLV5eoHf0pClTraXMVhgaJaqAkf1hj1u6h9dtisqiA1+QQONtFxG0lgfZWZ3kwOljCvQz
 8U9e9X8u8PMeeBFtGyyqmEpiNPCMcWOwPJCegMx3RLp67ksurymqK9WZcO9H5gokDzvlqullSALb/
 ZDCNOGYQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mGjAU-005Cnu-Jf; Thu, 19 Aug 2021 14:37:26 +0000
Date: Thu, 19 Aug 2021 15:37:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Luengen <LUENGEN@de.ibm.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: hostname cannot be used for traddr?
Message-ID: <YR5sns2ib4BBI4Tb@infradead.org>
References: <OF6B2D5E85.F00AD733-ONC1258736.004F4A7C-C1258736.004F6E51@ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OF6B2D5E85.F00AD733-ONC1258736.004F4A7C-C1258736.004F6E51@ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Thu, Aug 19, 2021 at 04:27:35PM +0200, Andreas Luengen wrote:
> Hi nvmetcli developers.
> 
> Following the NVMe specs I understand that it should be possible to use 
> host name or fully qualified domain name instead of an IP address in the 
> traddr field.
> Setting the host name works, but when I try to attach a device this fails. 
> Just changing the host name to a valid IP address and then attaching a 
> device works (see below).
> 
> May I  miss something or is this a bug?

Not a bug and you're not missing anything.  The kernel doesn't do
DNS lookups, so it need an ip address.  The only enhancement we could
do is to do the DNS lookup in the nvmetcli code, and then store the
resolved IP address in configfs for the kernel.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
