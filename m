Return-Path: <SRS0=GC6h=CE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB16C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 05:44:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19EA22076C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 05:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cWmNwqXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19EA22076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xVgZMzVPZrCB9rGjImCubV5N77YIvHTkylCGjBhDmVc=; b=cWmNwqXD544kP8XqvqLisZoF6
	Dgcmn4xJ15805C7yEizzDISxsRizDST97wAXsOMlTegyYCgZg3QfC2C6nF6Er7pq5wW+9B15738AU
	VwKc9aIsaQ4CiKd442f9iyNoKgUErmwMTGM6R7BToi9iaauWCpqJgdpt4QCdYVD2ltKwPLFX4zsMv
	++q2IHNy2G4aDYCwfM6/K8MhF9z0tHaqk3k7j/hP1sHoGeJht5NBpVbmW79mXU1O+nkfikfRWIL80
	C2RMT6XdnFw34RviswCpOeXbZkxocwxZG0zJezVCdGLdG4oIhI23blTY5A1epTsEkYisPRJVyzDNE
	IpCM1bQmw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAoET-0005wC-Pc; Wed, 26 Aug 2020 05:44:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAoEP-0005vO-Kr
 for linux-nvme@lists.infradead.org; Wed, 26 Aug 2020 05:44:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DF7D168BEB; Wed, 26 Aug 2020 07:44:17 +0200 (CEST)
Date: Wed, 26 Aug 2020 07:44:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH] nvme: Use kobj_to_dev() instead of container_of()
Message-ID: <20200826054417.GA15738@lst.de>
References: <1598404848-37313-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1598404848-37313-1-git-send-email-tiantao6@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200826_014421_844899_7DF64357 
X-CRM114-Status: UNSURE (   8.30  )
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
Cc: sagi@grimberg.me, linuxarm@huawei.com, linux-nvme@lists.infradead.org,
 axboe@fb.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 26, 2020 at 09:20:48AM +0800, Tian Tao wrote:
> Use kobj_to_dev() instead of container_of()

Why?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
