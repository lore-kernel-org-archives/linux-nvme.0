Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E341C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 05:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=naTeRpj6WSL0NhintkTlv4f0GmmGFsvwZ/yTUXTgj/g=; b=T8XsYLVe9oEMMCzHsX8TkXnR2f
	lNOCqDU0gVAH+t/SDmAasXoVdt+dh4I9+HuFEfQ0egGLhtsk7+YN+0jFbXFOZn0YvJDXTvxGFZ8Gm
	fnJYPLzutpERhe+dUjtwSfd8hj/l1OCvV3GqWhEV+KIk7p7voxTaoKmb1b+D9/NB4pmENNvkgJiBB
	ERSa1HUKoqrMmTdn18QoXo6WkgOhEG7/EIxExR4JWB1wIrLa0nnA36M3a3VrLMfbZgnlYdwnsKsNH
	K/+9kBNGJeOQFKzDcABTljTvmAFpGgrtDf5BGbSdV2/aKOTxH1Yy8YvwJuO3IvfuwE4pwKlUhTCnQ
	ZFZuKTgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rS90H-00F6pz-2Y;
	Tue, 23 Jan 2024 05:07:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rS90E-00F6oT-1R
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 05:07:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A33EB61A3F;
	Tue, 23 Jan 2024 05:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850CCC43390;
	Tue, 23 Jan 2024 05:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705986433;
	bh=pP73/t4EQeLWbOVO+IMYjVn0jX0lOCnSILJMj+j+sUI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=azAf600cCndJ1ldkIpfi9L/CwKa1f/qYxVkMLOb2GTvmHseQ0pND7OdDBad/D17Ne
	 qPfjZA+eyHu6uLA3lHNGVMVmJ1DEE4AGQvGj5+ej3G68QTvfNdqblKilyJjaPZX7XQ
	 gRnRsKho/UL0N/lt8+Y8p3q6rj49uZji08uBx92kzNLcecR6ikeuLg0K4nTBv+zn/f
	 0G0Zfh3gCiwv7Gne0GXDJuY/QWIpkFcK4IprajCsIGd0Dkyqg+14wg1PKF+XFSQbkA
	 WAB3LaBwKjCHDOcCG+OapsB1Qo5psfL1DZwsNhSKuXOTivosKNCpNx42veJyTVcbbt
	 nMOoq8hBfqpfQ==
Message-ID: <d3e5c919-0040-4284-96a3-df39f1aed819@kernel.org>
Date: Tue, 23 Jan 2024 14:07:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] block: use queue_limits_commit_update in
 queue_max_sectors_store
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
 <20240122173645.1686078-5-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_210714_527403_4EBEB0F5 
X-CRM114-Status: GOOD (  10.54  )
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
> Convert queue_max_sectors_store to use queue_limits_commit_update to
> check and updated the max_sectors limit and freeze the queue before

s/updated/update

> doing so to ensure we don't have request in flight while changing

s/request/requests

> the limits.
> 
> Note that this removes the previously held queue_lock that doesn't
> protect against any other read or writer.

s/read/reader

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Other than these typos, looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


