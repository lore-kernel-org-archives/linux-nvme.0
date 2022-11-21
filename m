Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8277C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 07:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5YLuTRgUWtcHEGjxg7K+QhRSox8MX6tpsmqbu4vhpD8=; b=TApn4/ZEP4Yp7MzL3aM8KfZHkO
	3eA+IR0DtFoEs38kMHHolIKaGIE83d5iZQZ2oub7yJjVc/D3jktmWYDKaNS8dz53R+r8X4OPk4ed0
	7FZTxEhP6//gTyI6yPUBc4wtMNfFMEYYO171lrzgIBOVZapuCqE6rWOhtAJstOsdjZTIoHH5op+sV
	DMZa6jUv7BlFMd5Z8YtQtpSZEiJRzWgPjiUAMQF8Ux8OpP0BgP1IBqj9/mENZXxDEZ18h7z0rGuaq
	5sQ05uZl8i86VodBrKMY4YOm5dPRLPCMxTf/l5xEuhlyT8yaMFMhU5kGRoUhWeUiRCRna84WflJbV
	5cWYuzKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox1Tw-00AXqs-Hq; Mon, 21 Nov 2022 07:44:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox1TD-00AWml-6b
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 07:44:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D0C7768AA6; Mon, 21 Nov 2022 08:43:55 +0100 (CET)
Date: Mon, 21 Nov 2022 08:43:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: block dangerous passthrough operation
Message-ID: <20221121074355.GB24507@lst.de>
References: <CGME20221116130636epcas5p39a586e15d27045752f18d022f4efd74a@epcas5p3.samsung.com> <20221116130104.2186334-1-hch@lst.de> <20221116132502.GA5094@test-zns> <20221116133839.GA9364@lst.de> <20221116134322.GB5094@test-zns> <20221116154415.GA18491@lst.de> <20221117031336.GA392@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117031336.GA392@test-zns>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221120_234359_433537_9DA2DE8D 
X-CRM114-Status: GOOD (  12.81  )
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

On Thu, Nov 17, 2022 at 08:43:36AM +0530, Kanchan Joshi wrote:
> But if there are people using the upstream driver for testing
> nvme-hardware, restricting may not go well. Stuff like creating SQ/CQ
> in early stages of new SSD/controller development may just be
> the thing they want to test.

How would that actually work?  If you want to play with low-level
details of the controller you better have something like a vfio
driver that is entirely in control.

