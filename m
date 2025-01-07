Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBF9E77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fkAaqo8x1GSVMibKFNYwrNppF8oNybdZNtqRi7O74Ts=; b=BsyrrkpBCZGzN0CO1spmqe6rCU
	yjBQQ+lwKzDGDNQxADSQYle4NjyU6gGOgZKJZ3wuv5nXWD2OVzTOW2koTobmytWJjXuDRJSpo7iUu
	xHG+9llEFWXMSs0jeTRuVWGlcEwC9t1BwW61w+eFx9CJd+At4DyufWxShJps+AsBjR+O0zbGrMIr6
	JqoEmiWBdX1spCMg2/cyR6eeS2qJ+xL53nJeK1TbtKBBGyv/cNZk8ps03oYT+tnlo52T//TeV74AB
	RuBhKULBbLAowf9n/RwWWqEVWy88RvW7EOzJH2ZG4IC7KlRpAjXjVYgLgqw1KpYsvj7bM8KuJ740o
	pl4bZ28A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV6lk-00000004KLQ-2Ti2;
	Tue, 07 Jan 2025 10:25:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV6Ne-00000004FBt-1bld
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 10:00:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C1F205C3F07;
	Tue,  7 Jan 2025 09:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CF0C4CED6;
	Tue,  7 Jan 2025 10:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736244009;
	bh=VKQPgS4SnN96nY/5RA10CNSAWUjHNFtO30HNuewnXRo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XRm4c/7fpeQvzPjN/W88+/YSBAo8AVk768mSxI6ihf8Y2c5EX3L+KSW3FiIt3kbUl
	 HVkj+IVJJRoGt7pfFNmuWmJZWr78sFl+La1SWEZJ/lOTMqJJ+BvWSJ2S3DpNrlxCpa
	 fkZ6RxHEksAJJutrafI+ipaIUBC4fmbV0x6aQ6YdxCQmGwkJkT4Hy9Kdodcpvd44kf
	 291Bp4awwPcnu+wWwQfOHEswWesNfz63OhgrNk+ejEKd0mOlJvKZF9atGU5FCjtYVq
	 kOy6gkM3vJchS4oYjARE5WlMONzSowGm7kgJ7tE96m31/G/+8d4Rfwg8dk+AikxAyc
	 I+O9Iq9/SMyIQ==
Message-ID: <206497e1-883f-4901-b061-b3ddb02965b2@kernel.org>
Date: Tue, 7 Jan 2025 19:00:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] nbd: fix queue freeze vs limits lock order
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
References: <20250107063120.1011593-1-hch@lst.de>
 <20250107063120.1011593-8-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250107063120.1011593-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_020010_469875_0979804A 
X-CRM114-Status: GOOD (  10.01  )
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

On 1/7/25 15:30, Christoph Hellwig wrote:
> Match the locking order used by the core block code by only freezing
> the queue after taking the limits lock using the
> queue_limits_commit_update_frozen helper.
> 
> This also allows removes the need for the separate __nbd_set_size helper,
> so remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

