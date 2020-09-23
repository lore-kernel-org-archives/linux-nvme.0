Return-Path: <SRS0=afDi=DA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BDFC4363D
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 05:07:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0231421941
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 05:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lKEhHRbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0231421941
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jwH1cmFgy3E8i8T3GrPAvYMx3BoyA95K8Ydy8oY2I2I=; b=lKEhHRbz+Z/ES3T2NK2+qqNvg
	u8RKS4XNzGC3CEEmJf3Gb5H6m3zNs4fQEAZolgem+KvX3NB8c8DrfYkpmXqN01n6dB/1bYZNPO09y
	YS7TnBZl2kdJuZFXXajwFfGVyOCFkstYAhfXMhE4Yy2reZpcsMqAMBZaN+a8XqtA0ssEQGCBBz1df
	MSu5V0Ou/mNXaWktr/KARLK+3JJfytGbM/DG/QSzWHVnL8G4W5xEPAgYcJrI6oTUQCCUxCpIr008f
	9+iNGqd+Hvy4FbKOgvuEj+4FqyDpEs0kS3tE0mWDZF8FkLyS+nEJ56Dx/kZOk732tGV7uTP87X7LS
	Z9WWXnshg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKx05-0004JC-Hv; Wed, 23 Sep 2020 05:07:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKx02-0004Is-UN
 for linux-nvme@lists.infradead.org; Wed, 23 Sep 2020 05:07:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 587DA67373; Wed, 23 Sep 2020 07:07:25 +0200 (CEST)
Date: Wed, 23 Sep 2020 07:07:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-core: use xarray for cel storing
Message-ID: <20200923050725.GB14878@lst.de>
References: <20200922210529.4530-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200922210529.4530-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200923_010727_095184_C6F09AFB 
X-CRM114-Status: GOOD (  13.62  )
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
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
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

A nice, I thought of that I while ago but never got to it.  This looks
exactly like what I had in mind.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
