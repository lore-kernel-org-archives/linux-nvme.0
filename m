Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7F8C433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 15:40:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1333C61284
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 15:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1333C61284
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=16HH9zPdU3jNonSq9M+6CX7HoxKzXTavRskAou6bpoE=; b=aW2kq0YdqzlkMlSvIabDOIupt
	R38GOQJduqX2f5qODZUN/JxYPIkQeK0iZz0asZuMMcMNvZ7FWjp0DX7DnlZfPiuHCZJoFSk3Q9im6
	1LwrsZdmmkdw/IC7AoDb6R7k4RmQamzFOVpSgI28a3LaKbsbIV7ZAOI1uM8cyRmkucN5lUmbd1CFF
	58Lp3r1ZW4v2JNRmtDhZcbhUG1khL41DmJv+vBmrDCBd+RnNt1tWO0mMlKZrAQWQKPvh65nnxaNI2
	5HWROD8t0t9+vkBY7s2lYHTZNwp926pYpBzURT8BHM/5GEgaHaVmJ1+lnvVGsNGahami8/XhkgaK1
	m3X6rFYJw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUAHo-005ImP-Vo; Wed, 07 Apr 2021 15:40:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUAHk-005Iki-CV
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 15:40:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8AD9F68B05; Wed,  7 Apr 2021 17:40:00 +0200 (CEST)
Date: Wed, 7 Apr 2021 17:40:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi <joshiiitr@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 1/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210407154000.GA26718@lst.de>
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <20210406064841.103393-2-minwoo.im.dev@gmail.com>
 <20210407131527.GA15142@lst.de> <20210407141128.GB2805@localhost>
 <20210407142152.GA20466@lst.de> <20210407153536.GA8667@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407153536.GA8667@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_164004_591477_76A97E25 
X-CRM114-Status: GOOD (  20.67  )
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

On Thu, Apr 08, 2021 at 12:35:36AM +0900, Minwoo Im wrote:
> 1. During the `nvme list` command, controller ioctl for the ns_head has
>    been not coming out from the mutex_lock_killable(&nvme_subsystems_lock)
>    because it just gets the controller reference and return it without
>    unlocking it.  So the first change point of this patch is to unlock the
>    mutex right before the return.  But, Is this a real issue? because
>    this changes are not from this series though.....

Yeal issue, stupid rebase error when I stated to split and move a few
more pieces for better reuse from the chardev..

> 2. Can we have the check whether the ns_head has disk allocated or not
>    by getting `disk` pointer out of the #ifdef CONFIG_NVME_MULTIPATH?
>    If it's not allocated due to some reasons (e.g., !multipath, or CMIC
>    does not support multiple controllers, or some failures during the
>    allocations), disk will never be allocated.  So, I tried to pull the
>    `disk` pointer out of the #ifdef from the nvme_ns_head, but maybe
>    this is not what you have intended....  It would be great if you can
>    give some feedback on this.

This looks pretty sensible.  If you give me a signoff I'll commit this
as a separate prep patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
