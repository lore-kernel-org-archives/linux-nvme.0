Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06846C021AA
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 23:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jTpbqchE4y5la90C+f97efYXplv/ebGhW94eAghKbrA=; b=clBI+QadMORUfWbC4R7ZJjAJ+c
	DJoR1yzjDARh2RpGFBAv3hZgkWpf7yiUYH9upX3Q/k4vCT0GPvPJHvjMpUAsd8bd2tlx26SFll3m6
	BgEHq5kF3j9d748PfCi5+X63EvybMOusNEL27V2Or2PRU/L/lTg3HSyFCM7nvggY3v6evhlvHoECd
	OvMQXVanLp8LdB0O5wvEKECHfKLOwN2m1li1y8gOFvtiuSJJsKNwxT5KTgpFesBj+8cYAgFz4lgh/
	jKDmNoZbhtjjHKDPn1qCSp3Sfwg/iiIJS9dgfk6x6fLgNr/UEiWTmDoQ+SYCoLZ4HYG/IqMVNUGgU
	CzCCtGSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkX31-0000000AGEh-16p7;
	Tue, 18 Feb 2025 23:30:39 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkX2z-0000000AGE5-05Oz
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 23:30:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 28FDB5C4770;
	Tue, 18 Feb 2025 23:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E351C4CEE2;
	Tue, 18 Feb 2025 23:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739921436;
	bh=3jfQmyFQ0KDMA1mSMKOSU9E0eHnBhC6uavEihYVjEu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RKpxckDUZC3iQ94ikHGqNvnO6oX88QULGTf16h3QWyKUkHLWp/RBoVJ3R/k0uUxUN
	 CX31lA4J4rhtlc1OE1i9Uke2mMDJ6aLkKmvYNNGHaLLxAixalPKU46L6GDa7+iIarm
	 MnOAtl0X1akT5TFG70CJGbpcC9PIZs4OC2ASFL/8Ytua/sRCLasmhNH7BEsi0eBKWE
	 EE0YCSnpTx8FkuMPW+wsvAg59D1DHP6EEFAoYCrCr3zkHOWY6OOwAgXQqm6iuoHZhD
	 yuzHapHtBjqYQWfnluLBu0SqaDOxDZpIscXt3OYwsjFd/waLjER20ryK971yDH5wvm
	 n/3sHVT/bFpOA==
Date: Tue, 18 Feb 2025 16:30:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk, Randy Jennings <randyj@purestorage.com>
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z7UYGc25aKFL6oFj@kbusch-mbp>
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
 <9495391f-eb31-4da5-95bf-e5f8eaafee38@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9495391f-eb31-4da5-95bf-e5f8eaafee38@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_153037_113144_AD0601A4 
X-CRM114-Status: GOOD (  13.96  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 18, 2025 at 06:06:05PM -0500, John Meneghini wrote:
> OK, maybe you have a use case in mind. I'll assume you do: some
> applications want to disable native nvme multipathing and to see
> all namespace paths in user space, and they are using this parameter
> to do it. These are ostensibly user space MP applications.

You can have a ublk frontend device with individual namespace paths on
the backend, and let ublkserver do whatever it wants with them.

> So what happens when one of these user space MP applications needs
> a change or a bug bug fix in the kernel?  Are those patches being
> merged into the kernel under a different auspices... is it just
> DMMP that we don't want to enable support for?

I think patches exporting driver private information is a pretty clear
indicator it's for stacking drivers.

