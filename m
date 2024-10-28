Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80050D13570
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 11:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b7MNEALBjD7TFR6OpglGXkIxV+TEMrq2CJi1qRFeTWw=; b=hMfbHiFysTJqvT6NgVhZRF7Gb5
	gilWkhFjjlnpCwdNj1MyVcX5VBFwU4AvfrG8MLOXImfiGHYfBngDM7sHk8w1z3SNyKuPBdJ0JXmIf
	Mt+13QaQXEdh8dGqJOezXCgkehI59Mw1wZVuIDlX5EPOF5EZOJhMCv4mSHLQD/Uj9nYe9CCw3P9V6
	sc23QUoZXa5uZrnwpXL8kp9ueI0l/SyvbBSKuAHqCLf1E5htQrvi91LwEanDa6K/6dtBOTv1ilNJr
	yjmypik7zNe7E3uWLe4V1y3180C9PSUOFm3DwCdaKd4GeK0OAKdOYrxmxvy5uo/r1QYQ3+eouZnZb
	h3H32KbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5OFW-0000000Acbg-15BG;
	Mon, 28 Oct 2024 11:49:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5OFT-0000000AcZZ-02Qi
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 11:49:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 09616227A88; Mon, 28 Oct 2024 12:49:16 +0100 (CET)
Date: Mon, 28 Oct 2024 12:49:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv9 0/7] write hints with nvme fdp, scsi streams
Message-ID: <20241028114913.GA8517@lst.de>
References: <20241025213645.3464331-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025213645.3464331-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_044927_209713_F6D4D2DC 
X-CRM114-Status: GOOD (  10.33  )
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

On Fri, Oct 25, 2024 at 02:36:38PM -0700, Keith Busch wrote:
> Upfront, I really didn't get the feedback about setting different flags
> for stream vs. temperature support. Who wants to use it, and where and
> how is that information used?

The SBC permanent streams have a 'relative lifetime' associated with
them.  So if you expose them as plain write streams you violate the
contract with the device.

