Return-Path: <SRS0=afDi=DA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C8BC4363D
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 15:18:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2612075B
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 15:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NngUdlpU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzmRTz1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2612075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3YIWOs+VNZW9JBk+T+l1U538cuGDeLIaumyh6baE8NE=; b=NngUdlpUhR7vLD0UbjToOipYs
	qNv3NhSrxIQcQRMTnuoEftLv9K2xrWeenyzcRUpl3UyE/iAeUFMTyPBjZwQwclo/SW/c6U/kQ49ta
	PnmVvzcmBWlvF5JhWe4ae6cZIyepNioDVMAZQy0jsvmIDbtwN9fpXsx4bAi+MPb9su4jBYAO68Z9D
	wZvHHCWpM0MXN1NJSM9KDP28qWESUD1c4kxjqzrBa+4e7U0kvVmJqjXvN8Kt/sBOTy1dm+ZgH9fEc
	TT0kGgbzv+S6CyGaMuyIj8gEtv1E0XxQoiUs8RoedDjgDkhn15rCDQRo6BvEXAlDrcyKlqB+NPkxT
	tlzUKmsEw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kL6XG-0000LG-Tl; Wed, 23 Sep 2020 15:18:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kL6XE-0000Km-Pe
 for linux-nvme@lists.infradead.org; Wed, 23 Sep 2020 15:18:21 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 421882075B;
 Wed, 23 Sep 2020 15:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600874298;
 bh=lfR2bmpn3oNtVFZftREUjOom7kLgHpqlqQ8RTn3sjI0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QzmRTz1gpvuS6zPeBAjigfBU/WczfKQFXc5Wax0rF1HqIVGJo5rBtR3FwOq9bG8YM
 v5+qQGmUFkJWv/gC/Y9C8zSdLv9LO5pN3MJ6g0x7pLgauRzzMlCMu6xANkBSywiIRN
 UD6v2kKT0lGN50Qjd3a9GdV9R/UkoJ/kfJZh5rFo=
Date: Wed, 23 Sep 2020 08:18:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-core: use xarray for cel storing
Message-ID: <20200923151816.GA4036695@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200922210529.4530-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200922210529.4530-1-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200923_111820_890551_995A2A4F 
X-CRM114-Status: GOOD (  18.03  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 22, 2020 at 02:05:29PM -0700, Chaitanya Kulkarni wrote:
> When using linked list we have to open code the locking, search, and
> destroy operations with the loops even if data structure doesn't fall
> into the fast path.
> 
> One of the main advantage of having XArray to store, search, and remove
> items is that it handles all the locking by itself, avoids the loops 
> when using linked lists, provides clear API to replace the linked list's
> search and destroy loops. 
> 
> This patch replaces the ctrl->cel list with XArray and removes :-
> 
> a. Extra code needed for the linked list for ctrl->cel item management
>    such as nvme_find_cel().
> b. Destroy loop in the nvme_free_ctrl().
> c. Explicit insertion locking in the nvme_get_effects_log().
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/core.c | 31 ++++---------------------------
>  drivers/nvme/host/nvme.h |  2 +-
>  2 files changed, 5 insertions(+), 28 deletions(-)

That's some good looking change stats.

And removing the overloaded use for ctrl->lock will help avoid potential
coding errors in future patches.

So, this looks fine to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
