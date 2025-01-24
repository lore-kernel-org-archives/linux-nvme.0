Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E977C02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 15:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a8GBddDeS47GHL23Z9x7nHRb5sWTUDcuA1sL4e3J23U=; b=zdxqFQYW/IceFn08IZrilnswdO
	Al2IlC4Im/mfn/PgbTqmSyoaOZU9qsqT6zcUK/2FULkuDctNtXgQ4mKVU/W5ssQB/74npX8kVZ88s
	QZG0R9Z5XtygclLBH9MVfUDHFvfBYeHCo7uAH3rogGwHrkEZBwKCDPOdYzUtKAjgZB05i3SZhQavu
	Q+8ZWYH/pHCg1Y03G/+LPGBvl5RaqWB4a6SdgK9q0s/jL/iHneVwawnldRe90/qTq+c+2wPsZc9Af
	5tYC+oNt9vsb8lRl4w7pabpKJ254oAkVxld/wJ0i89cydTKBUXohmdJOCt2RxGmMGAO4ccanVWcH6
	tgdxmHLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbM5m-0000000F32o-42vA;
	Fri, 24 Jan 2025 15:59:34 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbM3S-0000000F2k3-2nm5
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 15:57:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 97907A41996;
	Fri, 24 Jan 2025 15:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE540C4CEE3;
	Fri, 24 Jan 2025 15:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737734229;
	bh=sTmfti2T99ft1G7Uhq4p9fuv3ViggOpKUYVGx5gGkOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcvaoofm+FR0Y6iLKQcGYi3liSoActyEgDCAtAiMaSb9jadO1yiUOcLCCN/1fs9e/
	 xw6uZ4bQVd/q4p0EYZyUhYXbXh6/B59JJAH/XQJFePRPw5Ik0WjIjRQ4t7aUTtmDWf
	 rt8l5UfMhxxQFJJyDSsngzqiJGchWKk+rwF1WEbVFSPr3HWlIV+oV6mmkJ2oE5wlab
	 Sr0zUzdJMkldP/C1MobgdxsT+6W/SwHlD5RaXKnEYT+985nWjFI3pCSLUdq5GI/MZE
	 jhEgUaCGjydOB68lHQ7rqw/MOM4LbNBOpDbI3HaZlNJgAol9X3hqgxx0xfmRdAye2d
	 RToPHPUL5nz/A==
Date: Fri, 24 Jan 2025 08:57:06 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
	dwagner@suse.de, hare@suse.de, chaitanyak@nvidia.com, axboe@fb.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCHv7 RFC 0/3] Add visibility for native NVMe multipath using
 sysfs
Message-ID: <Z5O4Um96pu2cN6Cm@kbusch-mbp>
References: <20250112124154.60690-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112124154.60690-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_075710_773156_9467DF7E 
X-CRM114-Status: UNSURE (   8.17  )
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

On Sun, Jan 12, 2025 at 06:11:43PM +0530, Nilay Shroff wrote:
> This RFC propose adding new sysfs attributes for adding visibility of
> nvme native multipath I/O.
 
> The changes are divided into three patches.
> The first patch adds visibility for round-robin io-policy.
> The second patch adds visibility for numa io-policy.
> The third patch adds the visibility for queue-depth io-policy.

Thanks, applied to nvme-6.14.

