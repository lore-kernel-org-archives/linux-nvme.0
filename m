Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C98EC433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:39:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA39207DD
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VxOfoCf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA39207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=d5y1usnLk60fIlOZhtXdRvxPxJ8f7EzQKARKqeFQa8E=; b=VxOfoCf0IaJ9kqihdAxMu3NX/
	h4jmdfJYgxJND8A3zRTP90ydUnyUrmfKXz310+yTyXPwdFrpSbRw1wSn0iuuiMRv0bK70SGjH86Au
	hRrgJbXLKQ0ZlY/FAdUguYWjsFKbt88ZDrf+WKIzYMdpIlRuVmCrxC3zQ4V1YGlLLcNJkj9Q1DmJ3
	dncicf5K1zWNbagM68bHutpJNr90M+NR4Hag5+Tc9ujS0EeSRVCX1xWjMFtwn0VXXjk53Mn73PKy/
	KTIheDqVqMkvvnQBSDFmAycSdFlS5d/claXBH2WQ9wCI8IFjF039K/jffRrV8zxvJpozEgZXX0pPa
	mlQL4vueg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnz43-0001Uj-QP; Wed, 24 Jun 2020 06:39:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnz3q-0001S8-4u
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 06:39:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9434768AEF; Wed, 24 Jun 2020 08:39:03 +0200 (CEST)
Date: Wed, 24 Jun 2020 08:39:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 for-5.8-rc 4/6] nvme-multipath: fix deadlock due to
 head->lock
Message-ID: <20200624063903.GD17594@lst.de>
References: <20200624001853.5408-1-sagi@grimberg.me>
 <20200624001853.5408-5-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200624001853.5408-5-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 05:18:51PM -0700, Sagi Grimberg wrote:
> -	mutex_lock(&head->lock);
> -	if (!(head->disk->flags & GENHD_FL_UP))
> +	if (!test_and_set_bit(NVME_NS_HEAD_HAS_DISK, &head->flags))
>  		device_add_disk(&head->subsys->dev, head->disk,
>  				nvme_ns_id_attr_groups);

The HAS_DISK name is a little strange.  The disk obviously is set
before, otherwise this call would dereference a NULL pointer :)

Maybe NVME_NSHEAD_LIVE?  or NVME_NSHEAD_DISK_LIVE?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
