Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F73AC47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 05:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x2PweGbIk1FEVnE78fJBhGsmonmsos+bMOjtLqkucoo=; b=RhAOuGdLLxaInELm+8IlUk7tSz
	FAQl2cRiSXHztDMQhCEqJ/ZJFx9ohqc01F3tC2eQxcqvatp+WBG12BVna4iLNBXAMf4w7BfCiir2D
	vl81IZENUoXHbS1evVvx68AommRGzjbpBgdcFewBWKouGDL3dQSJOPh5VIZUXSRGiAfY04J4JJ2og
	/AxUtZqTKmzvpm4yL+c516iHDfSyeySiP5iuVhD2a/HoqD96KzA18TWPSHkGyzioMPGKezLIPFCdt
	glIoDzc2AMrAEq6djFsrt0l/VpjnoiK0+NnVjpvfEHuz5Prh9cASJigqzPujlHOy/PY7pH9c5QoDx
	CUFCgixg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9O0-00F9ic-1B;
	Tue, 23 Jan 2024 05:31:48 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9Nx-00F9i2-1H
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 05:31:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 29AA5CE2865;
	Tue, 23 Jan 2024 05:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66620C433F1;
	Tue, 23 Jan 2024 05:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705987902;
	bh=wjCgQi0roIhtkMBplPGFNKHRjVkQdZDEwQLchHAoQ00=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WsZnIFwFc2lm76nogoU9tTQWNwQqxr5K5fYrvmaPN4zqSYAPNTKMeB+OZMTWI2KBg
	 Aksbw52ZN3KYfociTiqWM0uTApVmo+JiV7vkVKeeqaruny6RDmDSFrPUXJNrgCE6Fy
	 JvL7p3CjvuZy5NUTxHzrCZ5ZDMtojJr5JJd+TAgxMCoUU6K3zuG+umT3+cMrUljQT9
	 GUj23txdfuirYvkWM9s6qZ1slKUCsfTcMUvK8d+7PlX4ETI6uMSMSPLxqBcHzkipjr
	 TdA2VnWoVL8Y5rK+Iy+qmKA8V/uE4PpoXG9pRp9lveXEAI9q6k6iYyKVMw1NtxdlN6
	 pBLJwgQBiyH2Q==
Message-ID: <ccedfd42-7bcd-409b-af37-e16cd5e4fabb@kernel.org>
Date: Tue, 23 Jan 2024 14:31:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] loop: use the atomic queue limits update API
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
 <20240122173645.1686078-16-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-16-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_213145_608425_AB55E884 
X-CRM114-Status: UNSURE (   8.23  )
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
> Pass the default limits to blk_mq_alloc_disk and then use the
> queue_limits_{start,commit}_update API to change the limits in an
> atomic way on existing loop gendisks.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


