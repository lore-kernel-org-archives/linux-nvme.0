Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1D8C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 04:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ifv2AOmVhPG0rDVqVhZysWFyeOz9gQ9/cTCnKV9Qx8=; b=JQb26akFLBatI/y9+wr3Imx5k6
	sdXjk8fNceIfMt6YrX6orbk05tZve6njKwi8Uw086C6AUeYJ/MWVLtZEr8kFTn0px4FQOuUEQ1laE
	w1S5bwKKCFyd8+zX3EnMJx9K6fvRhBWK8MzCEMi+EPWWtgcJD7O+gAsaU+FO/LjgHSqVtat3ZaWOm
	PnMnnHvIMFvjknPP5HtuFcnp62loKuZfM4V1RIY9pQ+6jkVM8ONaxRcvOBPG57QDq31ncLeE7i2E2
	vpXIPYVNFAJecCJeu8uC4DD0tH2LcLCG0gI/IXfspklOxC5Kwc/ibjhZ2wVso0X+8YeUi+SITccvA
	tqTojJjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rS8ZO-00F4ck-2y;
	Tue, 23 Jan 2024 04:39:30 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rS8ZI-00F4bg-0a
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 04:39:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2C2BECE2B0F;
	Tue, 23 Jan 2024 04:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0BDC433C7;
	Tue, 23 Jan 2024 04:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705984757;
	bh=ENhGdnTXi5oZTFrpBO4asSbiZwsBH4Q1o3HBHTCIVUA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TeRUfrxCFyCGOw4oNFTmLA/mdXvJT0bJ1pWXonOksXzRA2uW/dsFBfRH6OgDCZfei
	 /BvQy8TH4p34274weuYtS/xikv2JDQd72kijKqJdGZIrtfkhTykfzUMnpTTq6pQziv
	 ByWqicuoZRqvv8XA4b06y0toIEOyMr+kigyJvxQhdbfeCRZqw/33Zl2K+sFHvPmHZy
	 d7Sj0KC0pXbsRyLaCyNWsqnTiugzD3rwxI1hUmmbayX/CIMoYqTx2m8+oA6LGMAx8C
	 +H35N6q7cmkiqWQ0PWe66HKaa7UU4pIyEuJI2EUjKwPe2wcs55zPakccJ4SAD9FHrw
	 L1D6AntGZPqEg==
Message-ID: <65f1df6b-3a44-4636-898e-0c2f2a637d85@kernel.org>
Date: Tue, 23 Jan 2024 13:39:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] block: move max_{open,active}_zones to struct
 queue_limits
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
 <20240122173645.1686078-2-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_203924_422283_B8547052 
X-CRM114-Status: UNSURE (   9.08  )
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
> The maximum number of open and active zones is a limit on the queue
> and should be places there so that we can including it in the upcoming
> queue limits batch update API.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


