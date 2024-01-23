Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B60C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 05:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AzqtWMeuRalJb8d16tgxRwgR2IvZ6ZisXjwW5dvlBWo=; b=t04/B1spJ5+Ewd87/NKw78T/IC
	JKw60AhvAPaXeP7DakyJIRq0pmleuUPgnC9tWfGLy529J+y+TpQhrb4dlWIv0X1HXcgePJd1urG2I
	4azrXx17ppmA8mCcnk3ysJXf7mOOnCVSUjXHHTN+oyPQvJUHpwvkNT+xe/dgPiCbUt4nzo+gUQW65
	Z3Qs+Ufhfy4+VPwy3Oa6TkG2O1wZbG9b1xUGUpxVTGTkfLRcwFcY+VRv1QvTrHAzLqF8IjLUmCCgz
	N+p4ToPXX03m8uE5o24TawM/I1MyudV4BmxHG9hhbBvFSzZl85GA5DVKjJX/vxkOv8WpmccNBaZEq
	m+oLlEEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9M3-00F9Ok-2n;
	Tue, 23 Jan 2024 05:29:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9M1-00F9O1-1S
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 05:29:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DC04B61118;
	Tue, 23 Jan 2024 05:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6945C433F1;
	Tue, 23 Jan 2024 05:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705987784;
	bh=xil21I47/lurocEp3cUAko/kuJg5ucYLbHCkSbYk6Yk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gb8cmKoertCfontV0aU/nDmqwwjk9ByY1Sa29Q51ruygiYRjIeJg3aqDhhDscDl6z
	 HgGJM7eMrVjLfJ71i8+ICXSCLT02yt/q4RQkenalDfD99+LWU2d4YystKlLDFJGorz
	 Va2L7bLWYmhCrd+/fSCpRvqHiQuaigSfmGo1oTD7PqI3TBAFEU8ZgNt0Yj9c5Ou9F9
	 /x/1ssrCs7l0iD5YD/FsJFPgAwEwuu1XjxVIK/U6O4LGnJRzJSySrsC/mc2iodSDf9
	 jyQEC4Slbpw4q7QTbdVVdxbMO7sjlTHYRe6NOTOvrWenbf8rRniIrUH5WKnn2lPCHY
	 xXQRNC2Y6s9Og==
Message-ID: <6fb840de-401d-4e19-ace0-66fde70610c7@kernel.org>
Date: Tue, 23 Jan 2024 14:29:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] loop: pass queue_limits to blk_mq_alloc_disk
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
 <20240122173645.1686078-15-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-15-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_212945_533101_F7731691 
X-CRM114-Status: UNSURE (   7.33  )
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
> Pass the max_hw_sector limit loop sets at initialization time directly to
> blk_mq_alloc_disk instead of updating it right after the allocation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


