Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B190D609D5
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Dec 2025 01:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SbISCg3xyNzRDHIam3BOHvPhSha9SbxaUsBHymv3RJM=; b=bqxDre4oNIJ3zWxF7Y3kUu1QMO
	rPyNpbW6CUWPm2n3A1U7I4OiNFa8GhaWLKIrfQZxOT301KHd2CQBl8m06nP5pMxP0/BS4T3pZAzAK
	SS0RpLHUsNLBn//iJp4s+C25AXv8+VjHXmBc4KIC4g9hqWDsuZLZ6gE8lZA3j6QGFP+DvckbtZNZz
	W6BNdRqdCpw5ytdJjZj9nstN/EqPtYboL0G6iTUfZqmPXEVkWeU9BPLfWqlOYGuzRmnlJTLdM9qMn
	yCMR2BBDUAakgPYkA8sVjDRpuQs1Mz5xIBPc+aRHRTmqmls/S6ZsNjHPKWhbGvweglb1e/e7FYr7+
	znEUZRwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVgYt-000000061on-2Xa9;
	Wed, 17 Dec 2025 01:42:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVgYs-000000061oh-1pYi
	for linux-nvme@lists.infradead.org;
	Wed, 17 Dec 2025 01:42:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 84C6F60097;
	Wed, 17 Dec 2025 01:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F76C4CEF1;
	Wed, 17 Dec 2025 01:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765935761;
	bh=gvr3YyIrJwCgWl2y81TVAseKZmB52eSmwAJYK6Ff058=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aNupqI4pwW/udVhbipYgtsUThoIMv/yfuz5sndC/+RJOlH1ZmwwCylfVk0eJOQy2V
	 cZUp0Fe+mSTLZG+jTRxH/NTtY+ZohIN17L4RYxJOj+3BPcAa1juA12FxvjZmFS2HPS
	 8OIOkVbJckIR6EdSRrnW6jAwI7jbDEP3l7eRrUtYjbHRWaffRu/wJXZlcFVgae6Lot
	 Z7v86wdJZKAkWw+0e1axD3PoTJ6JAs3K+oPl4th8eVFlF+rs2/qYL3IqBvFY5j3u5S
	 diyN+mwePkixWhAvqiobELhBxiB4aZZ/N6va0pzqgsWvbZHJoHRTGgQf9OKxI263tz
	 /p52RGfWgBTCw==
Message-ID: <1afe4a52-2c61-4441-8e6c-5cee343d7419@kernel.org>
Date: Wed, 17 Dec 2025 10:42:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme/host: fixup some typos
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20251216032931.1305349-2-wilfred.opensource@gmail.com>
 <20251216032931.1305349-4-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251216032931.1305349-4-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 12/16/25 12:29, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Looks good, but write something as the commit message.

One nit below.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


> @@ -271,7 +271,7 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
>  {
>  	if (ns && nsid != ns->head->ns_id) {
>  		dev_err(ctrl->device,
> -			"%s: nsid (%u) in cmd does not match nsid (%u)"
> +			"%s: nsid (%u) in cmd does not match nsid (%u) "
>  			"of namespace\n",

I know that Christoph does not like long lines, but it may be better to unwrap
this message to make it easier to grep the code.


-- 
Damien Le Moal
Western Digital Research

