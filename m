Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777BCCF6D28
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4BwGZ0IxufL1UyjZ/sr2I54mfawOv3S37LeV1+QtSlg=; b=vAQMOwJCw2Kgn/WokNHnQ4oUFz
	5bphdTIxCFSgxk/7sVk7WuEnf9U4p2Tv6KZ1TeFk3I1hkVPhvc+JO5NJOzOWvxg2cchu4YLgCumUD
	xrYDQtbrLM66X7IUBu6kUHVU79xBh/u0usrFjLyBOfpYFAkfMZpVCo3/ozMigWBt5UTBZyn7u7hzs
	JMCR5OXnxtmnLsC8jA2mg7BP5a5xrg7SQCBsQ4EoxwV/AxX7vEDbVLz5PPk8C/4uOlm7lu6nY2AO1
	rhLuAagDtNoSHy60f42zQSziSNlGoFCvl/QItMA2Oi8or1qaQ0aZ5Bez3+XcvPXhhwsamkXQy1W5r
	O+lyRLPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw0m6-00000006UBN-3qNW;
	Wed, 02 Oct 2024 14:56:22 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw0m0-00000006U8J-1EWM
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 14:56:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E25C7A43DEA;
	Wed,  2 Oct 2024 14:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F8BC4CECD;
	Wed,  2 Oct 2024 14:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727880974;
	bh=pVnVfcpz/RiPzp4rkTfj+QlwzOpGdatVNLnuREHq27Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PLdUxDo6GA43EbldKvRJu+xC4QoZhOIk+w4XCLbDR4npEsVHOa/jQqbZxD4U7uZ/m
	 mLd+a+wxeSSVw8q1S0vv3uVE7YOb/xc1JnBR/CYUdEIw8A2rgx2MngTzDelaHtJ/ZC
	 sUit4lNTSmwrWS8DOKhqcK92eoN6OG0usaaTo8hvtZMzMMsSnpyk7+DDIW4sJqN7fV
	 F/sTaTEYuhRHGVy8yZCzpoh0gH8QbtxXc4PO1E9F3hXo6T2qpi5v4jqdlqaE7uHT6X
	 th7x9VnEi29gwHBdnsai/mWx6dI+tX/Wf0CNwvMixmXL5zqYoiV9LluDXR87tfVa9z
	 SuY8vatgRSG/Q==
Date: Wed, 2 Oct 2024 08:56:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hare@suse.de,
	sagi@grimberg.me, martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <Zv1fC3qYVDfxn3lQ@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com>
 <20241001092047.GA23730@lst.de>
 <ZvwiD0v3ASF8Hap2@kbusch-mbp.mynextlight.net>
 <20241002074926.GA20819@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002074926.GA20819@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_075616_417793_6BA0CFD1 
X-CRM114-Status: GOOD (  13.89  )
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

On Wed, Oct 02, 2024 at 09:49:26AM +0200, Christoph Hellwig wrote:
> On Tue, Oct 01, 2024 at 10:23:43AM -0600, Keith Busch wrote:
> > I think because he's getting conflicting feedback. The arguments against
> > it being that it's not a good match, however it's the same match created
> > for streams, and no one complained then, and it's an existing user ABI.
> 
> People complained, and the streams code got removed pretty quickly
> because it did not work as expected.  I don't think that counts as
> a big success.

I don't think the kernel API was the problem. Capable devices never
materialized, so the code wasn't doing anything useful.

