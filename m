Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216C0C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 05:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q2XOQt/WzbX5qhaBcWP1W7PhF4znrFsXYAiRx15P3NA=; b=HwrF6RivTqoNtnRJXnwvBo6pcy
	DIC+wBiBX03lPtB0I4lTS8W/Wn1UDCMnSyCT+tsSL0sziVERvUMNSfH4XV3BklBFhfFYqA0VU/jkb
	FiJafpzl7dDML2N3lMVz3KEg28FNwDVb3X2Y9oojraN/N++l+uwWK7Ayj13wz8USEsIAwaBCuT9x5
	FkbwQXMfD9rqwxSdosafg+V7AXwbxFwWx1jkVpcm5MnT+zSLxhvLI7dYwSXvUF0JPgv984g4n1g6k
	SGF/rMnyHWwnJQXrpgn2l13bTsaHjS4sEWtc1xFZ/yoccBjVUBN0tYM/gYeEge22XsleIO+m0gCvC
	HMhAIrYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9AE-00F7xB-2d;
	Tue, 23 Jan 2024 05:17:34 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9AB-00F7wB-2z
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 05:17:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 689FE61B49;
	Tue, 23 Jan 2024 05:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A21C433C7;
	Tue, 23 Jan 2024 05:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705987051;
	bh=j2np+Yhw+N6TriCvLQQ/BYSPg2nziphCSgbEqkvZeEE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GWuEPDpQ9d4e8/z1awq38zcsbpYA/KM9napcqmIaHC0/FaouTXYcIQPA6ue6sRO6A
	 imhCrtm3512yxIl6GRK2PDepQm/44fiifZqPRuYgwK2ngYv4LZGRpiO63V4jywUbDx
	 WjRONBJ/5qvAjcGTmQqXmPiG4scVkKNMOSU8rcPf8GnOb9T1Zt6he3ymLFOvZl/O53
	 KffwbRsgAK+Jbr3/ksp92zaVt+qBWPFlK9/kvOKnUGsL/dYCZ7kIpbGnqKX2bdYlFA
	 1lnfw8vhyKLXcQj3f5EQXkz1Df3QRYn1LKqu5gIimlyfYd3ws1k4dM6WqN926/PaXe
	 SZ+i6BHcdqegw==
Message-ID: <5336b36d-fc5d-4ed0-be2c-8f3e42de4b93@kernel.org>
Date: Tue, 23 Jan 2024 14:17:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] block: pass a queue_limits argument to
 blk_alloc_queue
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
 <20240122173645.1686078-9-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_211732_003381_9224C3AC 
X-CRM114-Status: UNSURE (   8.04  )
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
> Pass a queue_limits to blk_alloc_queue and apply it if non-NULL.  This
> will allow allocating queues with valid queue limits instead of setting
> the values one at a time later.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


