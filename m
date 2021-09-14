Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBAEC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 14:25:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E6360EFF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 14:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69E6360EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tx5Q+o/R1dbZu3ptjH7nlx1pZra8R1+cChH17wwjL9s=; b=ZNd/RO9n9rCppn
	PJQ49UzfHwf1njUDPEoRj4ebh1j3YsyrHNY28Mjwca8pvm/fFJyLkGKZj/TNq0G7ePlkfryr7fOV4
	lkSJqTPnCMipWwktB3lLEFxvFbAko6pA/vce2qFiVwvgYfFn3TRujeBluy8flJM8usizI9ES7Slml
	Jy3UeqCvQrsxnYjRwGlHpZW183nFvwRIL6jDmAXpw9gS9dhHU5N4+QTdRbSFYwLSMQApSJBMIX3ou
	r2Nmm2J6epX7HOzYJj2Bj3Z7P/XkdxrIKTTFNDlEBUjnJJhcw7ZmNYNX2N4BEIXNt4h22pgoK7BP+
	gaJt7k8mT6VrIpUWBmQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ9MY-005zJ9-MF; Tue, 14 Sep 2021 14:24:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ9MV-005zIR-Qn
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 14:24:41 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E2FE60FDA;
 Tue, 14 Sep 2021 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631629478;
 bh=ycY17PXL4qHE+rfUE4OdR2jK9LGHVp04hnj1yZIFYU8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZICwzga13WlKFsaVaIcGLLEtGs4s8Y/EMu1DtB3VQhzbWwQ8LgaIt8iNtiWiUrMAN
 a0vyhkPgt2RTHjxI7BwCp2FXaalqR9fwrc7+tIHm79Sh+XujSI3sMA+ZigVw1+c8O+
 t65PJeANqdIdHR7CKlyqDQJEVp0kLhKj04AKH4Nxf1PPDSAPQK40HmjhVH2DvX/Kk7
 IrBEVfHF1bPT0xB2k2Z5J+DYS1e/7IQikdd6FWeHpeJEhcosaRp+MTWUuf3suQYG63
 vVWkVdYsvhtuHqose6WIn3plytrp/cs+nTQjq/OhcJRPBwcRodcrQzWpW/WPE/XWfl
 UEDyXwTDm7fDA==
Date: Tue, 14 Sep 2021 07:24:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Anton Eidelman <anton.eidelman@gmail.com>,
 linux-nvme@lists.infradead.org, axboe@fb.com,
 Anton Eidelman <anton@lightbitslabs.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 3/3] nvme/multipath: fix stale ana state for
 namespaces just added by scan work
Message-ID: <20210914142436.GA3614138@dhcp-10-100-145-180.wdc.com>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-4-anton@lightbitslabs.com>
 <20210913160310.GC6442@lst.de>
 <20210913160831.GC3283786@dhcp-10-100-145-180.wdc.com>
 <520b56e9-cac4-3cd7-9d2e-16633c6e7df5@grimberg.me>
 <20210914063052.GA27942@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210914063052.GA27942@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_072439_933396_4A56D9B4 
X-CRM114-Status: GOOD (  18.43  )
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

On Tue, Sep 14, 2021 at 08:30:52AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 14, 2021 at 09:24:30AM +0300, Sagi Grimberg wrote:
> > I agree it should not happen with xarray as inserts preserve sorting,
> > but that patch has the non-trivial removal of the namespaces_rwsem which
> > synchronizes in a lot in a lot of error recovery flows. It's very
> > possible that xarray will introduce regressions.
> 
> I've actually started looking over the series earlier today, and staring
> it I'm pretty sure the namespaces_rwsem is completely broken.  There
> is nothing preventing the namespaces from going away in these loops.
> 
> But I can't see why we don't just always do a sorted insertation into
> the ->namespaces list.  Just trying to figure out the history of the
> delayed sort ATM.

There doesn't appear to be any reason for the delayed list sort. It
looks correct to do a ordered list insert from the beginning.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
