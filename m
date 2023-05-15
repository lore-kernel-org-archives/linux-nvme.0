Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54660C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon, 15 May 2023 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7IzVs9eNHBWQypJIF5R5BhxI53mh373cFgKokzrC5tY=; b=Z/FOJv+n/6UAqRQCIQBjT+9IgA
	DAJEJLm5am3A9t+0A4BBBPEZR3pulfYvV/KwAX33IctHlHkvSP5qH/9NbnumC81sjRKBPke07CNWx
	xVjjWdsvxNFCBjqkLOfYYQYc6T1nTi+9bDr+x1XQ5/YrZeOu4jESfNBxm4HwHjqz086x26I8QdZYr
	vHXJd86LsWOFtErPKvCC/lE+060E/MR5cOUR6CUJSyljNUe/6G+N1IPDysobMm0XMfXgh64pex6ON
	TLEgr1s4BV0f5ACEV/6wcW2HBqfXJE4ImL9JpN8DNvJ/AylfNN4w7mBK+aWN5s5112R0rzjUii+T6
	qkvlY7tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pybms-002tdJ-1O;
	Mon, 15 May 2023 17:15:06 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pybmp-002tby-31
	for linux-nvme@lists.infradead.org;
	Mon, 15 May 2023 17:15:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7198F62BBB;
	Mon, 15 May 2023 17:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33158C4339B;
	Mon, 15 May 2023 17:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684170902;
	bh=7IzVs9eNHBWQypJIF5R5BhxI53mh373cFgKokzrC5tY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxC/5x4OyE0A8HeHAhByPuR26yhmnacJNbd1/lgaKd1xopWpyyVy8Y8H6PbNFMY8X
	 oa73uUCAGsBqP3hyqVcP5lSQ1pqD5UxJAGISZ53qyEyr5im3ezDdUDqjoT2by/SAD0
	 VIowgyvCPpPLRCzYsGT1M3xzBIpS6m7WfyNRFLN+muIDFWKAEfybIZgPOC3gh7DEeW
	 fLTIVOPgIxC3HFk3x7rfi7K+qkZRfTuXSgRm3P6cokpnCpCCpFcgGjG4Q+OB+lQesx
	 xxVpilar1tDJ48HWUaE0/aygyQQQxda3XKp01U7y7PiMWC12ubNnOblPfaFxFHbqlD
	 iEIoNGCTHbDeg==
Date: Mon, 15 May 2023 11:15:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	hare@suse.de, axboe@kernel.dk, oren@nvidia.com,
	ngottlieb@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH v3 0/3] nvme-fabrics: fix un-expected behaviour related
 to hostnqn and hostid
Message-ID: <ZGJolOAHt2AMsDEf@kbusch-mbp>
References: <20230512154155.38694-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512154155.38694-1-mgurtovoy@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_101504_020635_FC4BA0D2 
X-CRM114-Status: UNSURE (   7.81  )
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

Thanks, applied to nvme-6.5.

