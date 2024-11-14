Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E52D41D46
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 12:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/X8AqsfsFuTR1IrW1lp9ZjH7mwkw8+XuxGW6rxZ9QW4=; b=ZBnS9XAI1B8OwP3ezlrtzsaQk/
	KpPL8GMQGhailG0bnfw3gjCdMQ865I0fabr4UhnjZ1RZsckcpiJevYH6hpI6P1coPM3z1atH7sbur
	nQDDCrGZpO7vpzEsBuObAw2WfVHCgiKAahre2Rtuec76gO5n1D5l3J6WqFFn4bZfX8wuyByM2mcVq
	JIJpZGpN/1i/kXDLZZJqc+V3Gaeqxg9I+aVh8RYIBBbaEyQmWPiiC0pAL1NYwQhTD5bCjK/9mxAml
	IIwMlPVZcYrXoiTDQHnAiwf0vrdjq5GyfbnDIDtWnXQ7qDy1ybSW2B/xmLSPEZdy3xgdMdt+gz16D
	WauVuHxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYnN-00000009sNW-0ICt;
	Thu, 14 Nov 2024 12:17:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYnK-00000009sMV-3Y9X
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 12:17:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5911E68C7B; Thu, 14 Nov 2024 13:17:51 +0100 (CET)
Date: Thu, 14 Nov 2024 13:17:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: =?utf-8?B?UGF3ZcWC?= Anikiel <panikiel@google.com>
Cc: bob.beckett@collabora.com, axboe@kernel.dk, hch@lst.de,
	kbusch@kernel.org, kernel@collabora.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <20241114121751.GA3971@lst.de>
References: <20241112195053.3939762-1-bob.beckett@collabora.com> <20241114113803.3571128-1-panikiel@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114113803.3571128-1-panikiel@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_041755_051111_EA4A62DC 
X-CRM114-Status: GOOD (  10.76  )
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

On Thu, Nov 14, 2024 at 11:38:03AM +0000, Paweł Anikiel wrote:
> When doing a write of 264 sectors with PRP list offset of 0xf00,
> the bridge treats data as a pointer, and writes incorrect data to
> the drive. This might be why Robert is experiencing fs corruption.

Not having the hardware and just speculating, but this seems like
a pretty likely failure mode.

**still cursing nvme for all this PRP brain damange**


