Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32ECC2BB1D
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 12:56:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84FAE205ED
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 12:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PwTlWjJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FAE205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sqVTYqwN86kFb6cIil2RhIeHkfe5cCqKYx2gFIpEty4=; b=PwTlWjJUHsbzIn
	AGlqttIjlYKSwY1N9W9OJrtFheKO3h5sMwX7I/nBrULWMveY2tAsbGaz86kbF3VSJQrar9lT/50Yd
	czLjMLjBiGQrZuDCigSbI+E/FgmI9jYdAnI/TtKYa5Pu0HK340ERGOoObrZkWESVHOzizRJw31+Kb
	CXIvhmgqO+EX8/+HLvfB3KykHNaUq/bYJQQWDlD2mfr1Vz0SgRycs165tnQarufStJ8Z7Ub4E1QGq
	pRSlRbBqbjpBi6j7QYjnYij8VjXdPrJIZWu+3JMyqJ8sYxh8gOiosy3SS7lANJPqcfhyjqjtSMgEc
	CurDHkhkkeRNu0zB8Y0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEBlu-0003of-JH; Tue, 17 Mar 2020 12:56:38 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEBls-0003oM-1C
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 12:56:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5BB0F68BFE; Tue, 17 Mar 2020 13:56:33 +0100 (CET)
Date: Tue, 17 Mar 2020 13:56:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Israel Rukshin <israelr@mellanox.com>
Subject: Re: [PATCH 4/4] nvme: Fix controller use after free at create_ctrl
 callback
Message-ID: <20200317125633.GG12316@lst.de>
References: <1583938849-5787-1-git-send-email-israelr@mellanox.com>
 <1583938849-5787-5-git-send-email-israelr@mellanox.com>
 <8d294ef5-ca01-4458-441c-b987a173d39c@grimberg.me>
 <e12ed56f-6bfe-dcee-9967-f6f58f06a9f0@mellanox.com>
 <7710cc5f-850a-f260-fb02-423a46867534@grimberg.me>
 <e010bbdf-a28d-5ea5-2764-d624845bfe63@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e010bbdf-a28d-5ea5-2764-d624845bfe63@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_055636_222329_30E7F260 
X-CRM114-Status: GOOD (  10.81  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, Sagi Grimberg <sagi@grimberg.me>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 17, 2020 at 01:49:43PM +0200, Israel Rukshin wrote:
>>
> Yes, for example you can see that nvme_rdma_create_ctrl() calls =

> nvme_rdma_setup_ctrl() which calls to nvme_start_ctrl().
>
> After calling nvme_rdma_setup_ctrl() we take the ref count on the ctrl by =

> calling nvme_get_ctrl().
>
> In case nvme_sysfs_delete() is called by the user before calling =

> nvme_get_ctrl() the controller ref count
>
> reach to zero and nvme_free_ctrl() is called.

> We can fix this by taking the ref count on earlier stage.

Why don't we do that?

> For example we can take a ref count at nvme_start_ctrl(), but it affects =

> also pci module (I need to check that),
>
> or we can take it before calling nvme_start_ctrl() at rdma/tcp. The ref =

> count should be taken only if=A0 "new" is true.

I think we need the reference as soon as the controller is externally
visible in any way, which AFAICS is done by cdev_device_add in
nvme_init_ctrl.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
