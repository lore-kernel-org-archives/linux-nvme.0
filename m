Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2046D111A8
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 06:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/GP7XH0mMHlF93hqq8tafQl9hJEBAmK7d9HOHfbwCK4=; b=pASGVoltbEUMG6qxJ+momWbwRP
	1tvA0XdZpJ+SxJhU3kPDBR1KgL07OacutTTkYNRnecOqLATIdyF12AK5RXJ5JGvo5DDxWSf+uBmkt
	hqLfh1cRMgtV8g1JsXjGBgH+zPWIQ0wrchoaA4Xh7DSBzj+lpggRZ5lxgDoNAYlDX3wW+TwGqwO0t
	HVz/ExRA7WJfvi8ZGeKhevMphohWFuyipYHStUamC9IiuzCyd3rJy/anRb3qKHHhtzWZzLtYg/YJ7
	G0rmRXYdLoZJd1XEJ+JzTH1W7UntyhmLSywBuisFm3AbGKdIaFSW/iT22WdGU738C+TjFDoRv3e+z
	oUHqjGjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPxHr-00000002xsI-3uRq;
	Mon, 01 Dec 2025 06:21:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPxHp-00000002xrW-2WsB
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 06:21:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B43566732A; Mon,  1 Dec 2025 07:21:06 +0100 (CET)
Date: Mon, 1 Dec 2025 07:21:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eugene Korenevsky <ekorenevsky@aliyun.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme: nvme_identify_ns_descs: prevent oob
Message-ID: <20251201062106.GA19164@lst.de>
References: <aStReVPqMORJssLT@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aStReVPqMORJssLT@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_222125_785353_F192EC56 
X-CRM114-Status: GOOD (  15.62  )
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

On Sat, Nov 29, 2025 at 11:03:05PM +0300, Eugene Korenevsky wrote:
> -	int status, pos, len;
> +	int status, len, remain;

Pre-existing issue, but all but len here should be unsigned.

> +	remain = NVME_IDENTIFY_DATA_SIZE;
> +	cur = data;
> +	while (remain >= sizeof(*cur)) {
>  		if (cur->nidl == 0)
>  			break;
> +		if (sizeof(*cur) + cur->nidl > remain)
> +			break;
>  
>  		len = nvme_process_ns_desc(ctrl, &info->ids, cur, &csi_seen);
>  		if (len < 0)
>  			break;
>  
>  		len += sizeof(*cur);
> +		remain -= len;
> +		cur += len;
>  	}

I don't think this works, cur is a nvme_ns_id_desc pointer, so it will
be increased by len multiplied by the size of it.

I think this would work muc heasier if you'd do away with remain,
use and just use cur locally, and instead maintain an offet;  Something
like:

	offset = 0;
	do {
		cur = data + offset;

		...

		offset += len;
	} while (offset < NVME_IDENTIFY_DATA_SIZE - sizeof(*cur));


