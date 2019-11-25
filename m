Return-Path: <SRS0=N6Q+=ZR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFF4C432C0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 06:59:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5A720748
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 06:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nVCSr2os"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5A720748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q2vRUJeScrfmMpCcbliVGe7T+FMxHQxi4mYWJl/UXgM=; b=nVCSr2oso4HW/O
	Czl59zwMdfx/OZNlkIfdh7Z+wgVMd7S5XjYlafmJKM532eD1gM83hv9buqa81r6VLE9zcqA2YdV1U
	+SF/Ulx3fiP+gxDxh8KBE9CVMttLiaCPPgZIHEkoiyc3NFHYCjSx5UDgEBV5WaUxm/pLPSTkv+xc2
	LFrnIO1p2bBUc5tqISqa8g1Zdd+dryp5w4nKmD+UJZ5Zwd4Yl+7PTHx8jtiUEZbNa/ORfTuic3fm8
	aE/HvL2B53cB9MxhVTQvpbMHF19Hg0EIIYG2JLa65L0xDvVczpwsCyXKx5GqvLGNTHC2wmAbhd7gC
	enkvxGbXsoHCTRxCqL1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZ8L6-0006I5-VF; Mon, 25 Nov 2019 06:59:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZ8L3-0006H9-SD
 for linux-nvme@lists.infradead.org; Mon, 25 Nov 2019 06:59:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5350E68BFE; Mon, 25 Nov 2019 07:59:07 +0100 (CET)
Date: Mon, 25 Nov 2019 07:59:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 7/8] nvme: hwmon: switch to use <linux/temperature.h>
 helpers
Message-ID: <20191125065907.GA29695@lst.de>
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-8-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1574604530-9024-8-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191124_225914_062905_1897A2DD 
X-CRM114-Status: UNSURE (   8.54  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-hwmon@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Amit Kucheria <amit.kucheria@verdurent.com>, Jean Delvare <jdelvare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-pm@vger.kernel.org,
 Sujith Thomas <sujith.thomas@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Eduardo Valentin <edubezval@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, Keith Busch <kbusch@kernel.org>,
 Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>,
 Christoph Hellwig <hch@lst.de>, Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Nov 24, 2019 at 11:08:49PM +0900, Akinobu Mita wrote:
> This switches the nvme driver to use kelvin_to_millicelsius() and
> millicelsius_to_kelvin() in <linux/temperature.h>.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
