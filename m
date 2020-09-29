Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26F2C4741F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:09:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B34E21734
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BrqbAAa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B34E21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=seK24HXh7xWOJC+2imqzqDxi/SdVsdf2oANcNBQYaI0=; b=BrqbAAa02rEoxvhFKIQGQfTzB
	M6jTwvoX53VHjgcIAiqYBzUJdPoyVRc6mWRp9fSll5uvpuUiWsa838QeYZZrBouKJ/8waQ18KZmKj
	JMk6KRHBPyXbMWgRT55wcFNzTEWzkApDKCDtD4hgjA+L8M6uRdlhnTUnxnoIyb8pF/rYGSEJNioEK
	pSq11OmvRAS2JzspKWGnwAZZrUPrhD+xOCbywl2u1bOvEg386kchNXJugxfHCDe4KMMQHC7Svq/Yi
	j5hBTc2oXjG/MvTS5VMD8BmqPid0KmOJhyrfmnonT077EJ7u1FtO9dfaLUSwOSlATMIaQHh8BD2qY
	tZuA5NkAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNK3Z-0001BL-Ra; Tue, 29 Sep 2020 18:08:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNK3X-0001Ag-Gf
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 18:08:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 559F967373; Tue, 29 Sep 2020 20:08:49 +0200 (CEST)
Date: Tue, 29 Sep 2020 20:08:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [RFC] nvme-mpath: delete disk after last connection
Message-ID: <20200929180849.GB12546@lst.de>
References: <20200925213819.224198-1-kbusch@kernel.org>
 <f8fdd99f-84da-bf68-a07b-7a6200cc02ab@suse.de>
 <20200927060709.GA24024@lst.de>
 <20200928141106.GA227320@dhcp-10-100-145-180.wdl.wdc.com>
 <4af645fe-f513-22b5-2d28-3e8890cc8776@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4af645fe-f513-22b5-2d28-3e8890cc8776@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_140851_732275_442DE6F3 
X-CRM114-Status: GOOD (  13.66  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 29, 2020 at 01:28:51AM -0700, Sagi Grimberg wrote:
> Something here is not clear to me, we are not really talking about "all
> paths down" but rather "all paths lost", which should take the gendisk
> down AFAIK.
>
> Keith, shouldn't we modify the gendisk reference manipulation in
> nvme_mpath_remove_disk instead of moving it to the call sites?
>
> I'm still unsure why we need a timer for this. If a path is removed
> (e.g. disconnected, we shouldn't keep the gendisk up).

True.  And I guess the right place to deal with timers is on how long
we are going to keep retrying (or at least the underlying disks alive).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
