Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D59FC27C4F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jun 2024 15:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hM8g6+ix7HWGyGWRQTeENmwVBHWd2MM7c4X51NxU8BQ=; b=sCn+nMThq908R5nHB3tNSu7Roq
	YoZpvS/Zs5oa1BBhltGXzuTeF61RauATwthMzkcED9R8aey2cIEqyjAyYDd8EgIFqPbLvF/aNso6z
	eOBK8F8SvA4XPoxY1XEZTe/41IVJ6enKobmRZdyNU2iH1Hr627MEfdVdVGx0aB+ZRjSq9c4Y0DJTV
	TyqA5DzSEh8ANVnsDh+Zt9w81346yUrMF/VnbZFsDpu57D9KcbECVavaKwAtsJvl4lVdGFljkZ0ON
	C5lpDnR6wquGfb2rw47Dk2je7CXGPd2gDlDxyQYv7ekoRH6Tdhe3AlcMA92TarzQP35Z9jVZtAFBN
	G1LljeWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKfsa-00000009fgJ-19t7;
	Fri, 21 Jun 2024 15:08:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKfsV-00000009fen-1rpE
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jun 2024 15:08:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AF2346178D;
	Fri, 21 Jun 2024 15:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0572EC2BBFC;
	Fri, 21 Jun 2024 15:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718982518;
	bh=hM8g6+ix7HWGyGWRQTeENmwVBHWd2MM7c4X51NxU8BQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPFe9lOsr6Pr1sIzfEjkOb0Zd1t6N4LOflXimTwtJ3Dh4R9lM9jZlotKaSG7GzefJ
	 crDQTjR+GcHjLRPjvEB97AP7dTkD3GUB9fbw1uik20gNqzr9IHzmqP6K/l0EqubE2c
	 SJCQJzoluag+IG//EHifAHfBZcGDe9NtB7bwE0tVOW9yotG2LDOT0YiLDG4cneHcAV
	 ASV2e1rBWeFq3n9SshuETvk2e/BrCs7Z8lZnKUWD1E7/1uxnKsqONcbeMMrBvEuFKt
	 7gVCsQ1xXy8ZclKzOCIID5dhtUIEUjyVnHGjEvSD8zesFw4fPvD9UIqYYZQqO6dEyd
	 HJ8Zvu8UmiFdw==
Date: Fri, 21 Jun 2024 09:08:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: dwagner@suse.de, linux-nvme@lists.infradead.org, hch@lst.de,
	sagi@grimberg.me, gjoyce@ibm.com, msmurthy@imap.linux.ibm.com,
	axboe@fb.com
Subject: Re: [PATCH nvme-cli] nvme: warn about attaching a namespace to
 unknown controller
Message-ID: <ZnWXc8wrNR_ijnTH@kbusch-mbp>
References: <20240620125604.3017138-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620125604.3017138-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240621_080839_567626_639194A0 
X-CRM114-Status: GOOD (  10.00  )
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

On Thu, Jun 20, 2024 at 06:25:45PM +0530, Nilay Shroff wrote:
> Sometime it's possible for a multi-controller NVMe disk to have only
> one of its controller discovered by the kernel. And if this happens
> then it's also possible for a user to create and then attach a namespace
> to a controller which has not been discovered by the kernel. In such a
> case the attached namespace can't be used for IO because there's no path
> to reach such namespace from the kernel.

Isn't that a pretty normal thing to do, though? Like for an sriov
situation, a primary controller attaches namespaces to secondaries, but
not to itself.

