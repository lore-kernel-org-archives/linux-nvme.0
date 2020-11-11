Return-Path: <SRS0=YOZe=ER=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD47C4742C
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 08:15:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C7B206C0
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 08:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DBYIyjLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C7B206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5vV/qbqcGD5DHToCX9XFlCWkic7VvNIzJl6cg3hYg28=; b=DBYIyjLzyofUfD/fGMVOj/iS7
	SEMm48rZT/zEtgRQBL6ZUdOGqG377ZsxDhpPbAtItTtCAKLey0CdDF0i9uGRCk+JRu4MPd1H4+S5a
	cRQSpKhce5fKyBiDEoLEqI8azcXqRJF7VxraRaBiJXUyJs0tMoUjOmWvQDfZZRNqlDLqdqUpjUPid
	jHsKZqJBgvcjg122KVIXMUX1MN8f09y2c7m8ugKyFHKb2ICDwkitXcpkmtJIyWTQXLvvccUyQbwVt
	P5fYVSnpltwkIEJ3NIIWmztyGpztm8++ycDNXElp1+hnVDTz19Y3mtQ1k+G2hQY2PwQAadI1sxyea
	d4ys5DlHg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kclHz-0002R5-Tj; Wed, 11 Nov 2020 08:15:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kclHx-0002Qe-OU
 for linux-nvme@lists.infradead.org; Wed, 11 Nov 2020 08:15:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B736B6736F; Wed, 11 Nov 2020 09:15:30 +0100 (CET)
Date: Wed, 11 Nov 2020 09:15:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V3] nvme: enable ro namespace for ZNS without append
Message-ID: <20201111081530.GB23062@lst.de>
References: <20201110210708.5912-1-javier@samsung.com>
 <20201110220941.GA2225168@dhcp-10-100-145-180.wdc.com>
 <87931ded-b17b-90b2-c5b2-a1a465d109cc@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87931ded-b17b-90b2-c5b2-a1a465d109cc@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201111_031533_941634_4AF4840D 
X-CRM114-Status: GOOD (  10.73  )
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
Cc: axboe@kernel.dk, Niklas.Cassel@wdc.com, javier@javigon.com,
 joshi.k@samsung.com, k.jensen@samsung.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 10, 2020 at 05:41:15PM -0800, Sagi Grimberg wrote:
>
>>> -	if (id->nsattr & NVME_NS_ATTR_RO)
>>> +	if (id->nsattr & NVME_NS_ATTR_RO || test_bit(NVME_NS_FORCE_RO, &ns->flags))
>>>   		set_disk_ro(disk, true);
>>
>> If the FORCE_RO flag is set, the disk is set to read-only. If that flag
>> is later cleared, nothing clears the disk's read-only setting.
>
> Yea, that is true also for the non-force case, but before it broke
> BLKROSET so I reverted that. We can use this FORCE_RO for BLKROSET as
> well I think...

Let me prioritize the hard r/o setting.  mkp actually has an older patch
that did just that which I'll resurrect.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
