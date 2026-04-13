Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8991DF34C5C
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2026 15:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xsTCoBdd7OVwZldKRK9MS/iurfz7+i6cVx8XCPKreZE=; b=pPFq4WrAuKg4PS3vzONW7mMkXv
	jXm/QbLfpXG/FL014ED9DbFpNojWWLGqswxoA9Bal4m7SW48v4OEKnlZTcbXHfnljME5LueOl5Aas
	t6Gtxb/NVmTFu+K+wmUmBoXrhrSPtL1Wua3wjAs8wpuufw45bz3jzsMGafCocYvZHBkfEpjwvYJo1
	ybq4cIHQPGdEXSLAwZKdXaJrLc9wyV5/gDvWbc4VBwl+3F2OjkFZxPXllRyZQk9R991Al5kVK0UY9
	m68Dx+KQ6u0NHDeHzBrXLWJLpqE4062vIoeqSjZcUr+5dPM9zNIWzI0VeJ4o5WTc3xNuzDUAZxO6t
	xFzRhiqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCJ9w-0000000FxT3-2RBx;
	Mon, 13 Apr 2026 15:25:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCJ9q-0000000FxSb-1EV4
	for linux-nvme@lists.infradead.org;
	Mon, 13 Apr 2026 15:25:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 56F2544418;
	Mon, 13 Apr 2026 15:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5FDC2BCAF;
	Mon, 13 Apr 2026 15:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776093901;
	bh=xsTCoBdd7OVwZldKRK9MS/iurfz7+i6cVx8XCPKreZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAfCyUNzAYKU3MFYOfY3cfbHsMQAhKkbUiAYVIJDHAneHqkoMU00chtGDCKV+S0yE
	 faaun+I2Sg5Y9JbdbXRggVxOU4G16jyd5do3qqeoKicJXI+BErVYxRY+iFPJpUjXpS
	 6zspYmNiT5Xrc+oa5ZaPav6pvE+KTv6FjenqcAR3/QPA9tlJ9+gYokzv5i0jIlANlw
	 L7oWrN482ovebgADkmVhpRo+sM5L0n/A1PV2S5BPF0znmc6pwelU5sb4fEyBnoypQ/
	 OuzbL5+swqmjwBQIc8V8g/C+pZblP+RYYPj5g++m/xD0QOHkKiGE9D6jqiJUq9uzFC
	 Qzw9cKYmjZaFw==
Date: Mon, 13 Apr 2026 09:24:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "wagi@monom.org" <wagi@monom.org>, "hch@lst.de" <hch@lst.de>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2] nvmet: move async event work off nvmet-wq
Message-ID: <ad0Ky5rrzZt3Xcdu@kbusch-mbp>
References: <20260226043003.160555-1-kch@nvidia.com>
 <010359e2-c219-4e2e-8b5b-5e86eda5653f@nvidia.com>
 <3c93edf3-87fd-486f-bb00-8db2cf925641@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c93edf3-87fd-486f-bb00-8db2cf925641@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260413_082502_382404_AAC790CB 
X-CRM114-Status: UNSURE (   6.91  )
X-CRM114-Notice: Please train this message.
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

On Mon, Apr 13, 2026 at 12:11:03AM +0000, Chaitanya Kulkarni wrote:
> Looks like this patch is not merged can you merge this ?

Look again:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=2922e3507f6d5caa7f1d07f145e186fc6f317a4e

