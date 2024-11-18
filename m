Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7FAD5E393
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 06:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BpIt5JhHYbgaKLWqXvwdOGB7wadLowwupx0bFrvdPBI=; b=YHUPLbWfngJ4WOMfFu32Lne1kV
	vbUamsKtCgVjkWsQvuFCQHW2JzUYoF/wEzHneZ+gvENtfxRl3t8ie1MbuHVQV+h34vQz2zsSkkLbA
	8+DRWvoldReTgTJ8+yQOLOn1J6f9lWPmoTOpek8GeYmZw03fDaiIr4YnNCWgTtDL4c5qQAb8SCfvF
	C695ZswKX89/0Ea54H15yFUmvg2N2TZjkvF7KqpDPxqa2B7B9i9pyUfUx7iPk0lpFrrS80K7DNrhS
	IlxuwDhDzU4UAJGBPWo8DOcneywq7sqNm2pR1xj9GmoPaAw6okDwKkNvOcsK5O2rQyxrfQUgi09iJ
	+fgZA2Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tCvE3-00000008WOB-0aEg;
	Mon, 18 Nov 2024 06:27:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tCvDc-00000008WHg-3xyv
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 06:26:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E20F368D38; Mon, 18 Nov 2024 07:26:27 +0100 (CET)
Date: Mon, 18 Nov 2024 07:26:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: =?utf-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-core: auto add the new ns while UUID changed
Message-ID: <20241118062627.GA32372@lst.de>
References: <20241115083727.30005-1-brookxu.cn@gmail.com> <20241115170411.GA23437@lst.de> <CADtkEec84+ECj_s4Seue5uC+xv3dBu6T4kaqeHMe9PLiLV6tUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADtkEec84+ECj_s4Seue5uC+xv3dBu6T4kaqeHMe9PLiLV6tUw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241117_222641_122217_F442FF01 
X-CRM114-Status: GOOD (  13.11  )
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

On Sat, Nov 16, 2024 at 08:49:12AM +0800, 许春光 wrote:
> Yes, now we have remove the old ns and log the change to dmesg,  but I am
> confused why not auto add the ns with new UUID, we should treat it as a new
> ns? so that we can avoid an active controller with no ns, but actually it have
> one.

Because as far as the specification is concerned it is.  The whole point of
these identifiers is that they are stable over the life time of the
namespace.


