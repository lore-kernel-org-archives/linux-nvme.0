Return-Path: <SRS0=D+H5=A2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1264BC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 01:36:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED5C20729
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 01:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zXLwY5vH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5gXKq7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED5C20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JxUk4fGDDMIKn0k4a/9KiVC6FrWmThr967y7W2T1jQg=; b=zXLwY5vHShCbo37PvPJVkTU3J
	LW9u6IvFdew4cR9x8Y9A02ouSE8ToBjOAFctcMQGYZvqj8IQvGYG/gMrTNtFfuOt2gYWdg0kuBLU1
	ref7ZJYVVvtGcEuK7eaBhdz9WbO0ZvzAaPA275xMw96/VLaneV/jhkg1qiAWSO2/dNMdBxNjR1GHR
	5aZBiJjRtDwkOxmwX7sDoXlDMznvqXbUVQ8lbCzuQuohtoRBAUkS4D6HKVJQ+UbZJV2tDi7qsc9/O
	oAk4f8LaZb7ewwgbyh3pwiLSkYCWWNv9Hpkkrck7wdn4CVjKVL7kYgEv4mrcEcQXntHXITFqRocGb
	HXl+hSFpw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvWLE-0004qw-Kg; Wed, 15 Jul 2020 01:36:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvWLB-0004qE-S7
 for linux-nvme@lists.infradead.org; Wed, 15 Jul 2020 01:36:10 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DFECA20729;
 Wed, 15 Jul 2020 01:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594776969;
 bh=SGaRuM9Fn1nU+s2Ltgie1/O7jjaFKS8i8geHaGAcyr4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S5gXKq7c7OnGyUcdiwrg0OLMwBHkI1A/hlqUtQ0obM8BeL8QZ49NY2JohEU+koY1P
 asE2rpGmQWeNlbrtjtLVpV+TanL9Rran0vncA/hbGP7cyZ+FghALUOAvo31G1fYWqt
 Hpp/21Lb4pu4ojYHVeQ0ZOvnADAox6d9jh+HWoo0=
Date: Tue, 14 Jul 2020 18:36:07 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V3 03/10] nvme: centralize queue action nvme_kill_queues()
Message-ID: <20200715013607.GC2772284@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
 <20200714233057.10915-4-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200714233057.10915-4-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_213610_016970_0E17BF4C 
X-CRM114-Status: GOOD (  10.79  )
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
Cc: linux-nvme@lists.infradead.org, hch@lst.de, willy@infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 14, 2020 at 04:30:50PM -0700, Chaitanya Kulkarni wrote:
> There is no point in having 7 different functions which are differing
> with just one line.
> =

> The helper functions for ctrl queue management can be centralized=A0with
> the help of the descriptive enums for action. This avoids code
> duplication which spans across the 7 functions as compare to one
> function and exporting 7 symbols as compare to one symbol.
> =

> This patch merges nvme_kill_queue() into newly introduced
> nvme_queue_act() which handles the queue management.

This should be separate from the xarray conversion part of this series.

And if we're going to collapse these, I would prefer to create a generic
API to iterate namespaces, something like "nvme_ns_iter()" that takes a
callback function parameter.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
