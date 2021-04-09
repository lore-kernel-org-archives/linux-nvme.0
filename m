Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B468C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 14:30:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBEC61185
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 14:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBEC61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=d78n7nEdGjhkJGgPI8plpkeTvoKoGHVNfgBGQGLPJ8Y=; b=YCPXeTjL1sdrQ6N5kRAWpnEXz
	g/Wmn0zR3139luHzyf2pjUB0tlwtwoWpilqvrFmTWJADKtPh5GFiyAMU1UQ+1U6E+LEc1hV+viPwN
	9rI3OEUW7NpoPKYLAvpYM3Z8Z6++Jr0kBHS5EuPiDWKtYJEh4xY0JFI0YIZSCIIs3C3DDlNzDu6xC
	ZJRJgq4yA9Q/i46PvL2nNSyv/SnN65lQsz1aqiOb/0BFVN4Qx3/UqzzvN9yYm6dNRGAjOUi+DQPlR
	auuoWxrY8D1uzhs54KxaurCjMX95r7RY9tS7dKWQn4GdxSCzJCwK8iMaWwkq4h4abrlIOdOcU/tKO
	zSKxmRXIg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUs8c-000ukE-N6; Fri, 09 Apr 2021 14:29:34 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUs8b-000uk7-0H
 for linux-nvme@desiato.infradead.org; Fri, 09 Apr 2021 14:29:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=IonkUwubdgFBdt309v0MxCwbUb3w1euEp2dczckCE58=; b=yhD/s9zOkyyLoYj4QHe4812cFD
 /Qxj1AJ0NjLqGGD96+eo5n8boTRlQuyAH8O+naNt12Rz+C0X4QRhwHx0h390kxyu5m6n756JQyHGM
 OTPMivIR24bL0j9lU+PfD3ubqKZpa+Qu4hn3g9tSn+st710xjCIikpmUVMmKO69x+t2KS8jLRyotS
 UE930hOUgP7afumduuQrZfW3CpJ9JAcEfiN2U1VWLODjRrHsFvuwyY8UEJgEmttGF0GgXK0SnJGKf
 mXgUrgsiC1dBWYzMFs4moa/XwFcMDynWHkrFFa5kwgo/DjJUPWmlKQeObpAGHiwgqnzxGj6aNAmv7
 uAOQQF1g==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUs8Y-004aV9-JU
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 14:29:31 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1135461042;
 Fri,  9 Apr 2021 14:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617978569;
 bh=2cNpZXoz0W17yRczvzPd2t6uoBT17gUN32HR56THWOQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Hs4odVSuCGhnpHPygCJedToDJzPsCo5lGFaNIRfoTTOaaHiZ4KeziUh1RZSo7C+lr
 BrkSj90r2ukq/G3D+gveF89nmYy2WT8LwFsZtt2Ngp7NN1HbhkkdUp+dSHYqypNZRU
 rfJQJb6ttIalsKQA6c8Ja3mIIFzEx/Vw+PpaiKqyEZkXrtWvCYqexM40HbAVH/ix0a
 qd6WF4KvNAgIs+xAMwTRF1Q7GE9JBArdq4TRPLgbvfomegMkOKe3ERyREXj7iXNOOD
 EXbUWApfSrhOx+EF54RscLOtxzTsxuMP+R8AETak+UYA5/6pnTwwLsQBtmZo7oc5zK
 Vh/y+zPY0RggQ==
Date: Fri, 9 Apr 2021 08:29:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 13/13] nvme: introduce generic per-namespace chardev
Message-ID: <20210409142927.GA6929@C02WT3WMHTD6>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-14-hch@lst.de>
 <20210408165613.GA3774@redsun51.ssa.fujisawa.hgst.com>
 <20210409061432.GA3702@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210409061432.GA3702@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_072930_676637_9A50EF75 
X-CRM114-Status: GOOD (  13.75  )
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

On Fri, Apr 09, 2021 at 08:14:32AM +0200, Christoph Hellwig wrote:
> On Fri, Apr 09, 2021 at 01:56:13AM +0900, Keith Busch wrote:
> > On Thu, Apr 08, 2021 at 02:08:42PM +0200, Christoph Hellwig wrote:
> > > +int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
> > > +		const struct file_operations *fops, struct module *owner)
> > > +{
> > > +	int minor, ret;
> > > +
> > > +	minor = ida_simple_get(&nvme_ns_chr_minor_ida, 0, 0, GFP_KERNEL);
> > 
> > Do we really need to allocate a minor specific for this char dev? It
> > looks like the ns->head->instance can provide the unique value.
> 
> Looking at this:  no, head->instance doesn't help as it is an
> instance relative to subsystem, but doesn't help with a global
> allocation over all subsystems.

Right, my mistake.

In that case, there needs to be a ida_simple_remove() after the
cdev_device_del() so we don't leak the ida.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
