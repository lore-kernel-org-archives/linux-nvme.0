Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F774C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 05:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/d1n2q9cSp+b9gxHQLH+ft2dBjYpHN/suH0Y1e6M16I=; b=4ZoEPCYgKClRpC2FVn5sYDvNHO
	EsvvAqm4vBbnGk2eH8K0RhqL7moqmogf5sFV9JK2EEm9yk36a9B1ZtmbnsKG5Qtg+efuERZ2vSU/L
	8vN1cKAABwwMsJEIT630WZprh7loQuZatWKTjtbnDjTf6mrezLKQuTa6AlurC5vhf7y8GGqtJ2Xb9
	6qMtaFLL2gZ5AozM29Z/n1oLvZ6U3+y031xlhOy2lyxRsE3HCqKsAlD18oWrNtQ5dhfD6pvwNdcZs
	g3oOh7YW/XK/ow2wf25tY/HqappgdBiSBVllQloqhH2Ahsa3hbtoZ6O0tNRAhH8l0AO5yYavGFtSJ
	klyL0AdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9Jv-00F8y2-2U;
	Tue, 23 Jan 2024 05:27:35 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9Js-00F8xg-1J
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 05:27:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BBA9F61370;
	Tue, 23 Jan 2024 05:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F45C433C7;
	Tue, 23 Jan 2024 05:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705987621;
	bh=rZlc/7iOpLCUjkjY0UJb5UkzbDeUBBdx2FDLEIZEjaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m1/1nptHwu2bz0rUt6GQk6T4dHLgUD6tXHKAITk89vrD+SNDqE1KXCKBy97Pr320t
	 a/ygkWf9KP5PcxTxqQywtFdlLq3968658zMZknlLho7M8UwKDuTK5DomcP6ywI0bDc
	 fFm7L1HWbjNoHqhp6JvouV8LxevD3km4/+gLRtr7WVojnoA2cobqAuIbl6LbHcJREW
	 kqawMBi4nrTp4XgtbP1IEODSR+tMKqQ0XW59w4RWvqlKhHgQOLUIqEV5TVdEiE2JPg
	 XLaGhRl3hrw+hQkFWI9dRSDnIA6fGaWBvFlsDMWA6zvck0SU/fyfDBNYoPbiL6BM+m
	 rX7ZKixe0Gadg==
Message-ID: <13cbd5e0-d690-4407-9718-cccc6ff94661@kernel.org>
Date: Tue, 23 Jan 2024 14:26:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] virtio_blk: split virtblk_probe
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-12-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_212732_481902_C81DC644 
X-CRM114-Status: UNSURE (   7.52  )
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

On 1/23/24 02:36, Christoph Hellwig wrote:
> Split out a virtblk_read_limits helper that just reads the various
> queue limits to separate it from the higher level probing logic.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


