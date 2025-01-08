Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1506E7719A
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 10:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C7qs9vgdOqh7Nv9DgQQU2j6aajaLmY6QS5cMOvhJHwo=; b=I+ZLB5eEaU+2PIwQmi9rAugS4j
	yGK4FIU58cTLIBvQQY8bRw+2UPwZxQ5bk8sMdo00t/2tjYPieKWc7fBC7Dgb3qWbRjnbu6WV24P1l
	rDttu3JFFyZfxCatsKZJEuKOvUxGC5vq/MToZcAHE4lzbSBMMWqp7AbyLeimsnIwwTfauJ1CvlV4K
	0NBynvfdLBdtIgTWX6ueH4V1aT572qvo3B2p8iiw6GKPgTycQXDRvBERnnAlUmE2y1/v7zx1hoMb3
	0c6rxnmVnNlddQfsF4+EWafZXptFCE/rmkQ8+QZvsRUJHigAuy0D8qwZVlOBqIvgkmcFYPIUbiKQs
	/1s7uEUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTFL-00000007yf8-0qDI;
	Wed, 08 Jan 2025 10:25:07 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTBJ-00000007xc5-0h9B
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 10:20:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id ACAC5A40C8F;
	Wed,  8 Jan 2025 10:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A832BC4CEDF;
	Wed,  8 Jan 2025 10:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736331656;
	bh=Sr5csu1r/k1+4I78TRGpkFCdGBPLBm1HsXHZfEAFYng=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QXAeWW19UR5Uc2GWgAUU8XJQ0Y9EbfHBv+4+D6eboqmkJTOrbUVB3YzxsVTyS/M4R
	 FXfyjMyMCy87j14VA5jWaE7k4GW/7gs/trNhg0nwRWBtji2VISgv3UoFu/kCNZE5o0
	 mARAo5JtXo9rt1oZ8qes7XRflBk1TP3Pl9vx/p8N1sdRZPKXzRnP8ebafU/VVPyNm2
	 J+O/B8n/2GPrGHNWzpPCmSAVTjy1TAL/aFzxlSldH4H6x0dndbPBEWePJg21LvIZYV
	 RzlmI6Hexjygca8+CptGU7zHdguig7d1/mNA9w42RSh1kA1DmGu/06PcAqplO/FUdt
	 Yk4/1Ui9IDxJg==
Message-ID: <866f4dff-c9bf-43d1-996b-bafd830b9e61@kernel.org>
Date: Wed, 8 Jan 2025 19:20:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] loop: refactor queue limits updates
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-10-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250108092520.1325324-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_022057_275950_7E5569CD 
X-CRM114-Status: UNSURE (   7.30  )
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

On 1/8/25 6:25 PM, Christoph Hellwig wrote:
> Replace loop_reconfigure_limits with a slightly less encompassing
> loop_update_limits that expects the aller to acquire and commit the
> queue limits to prepare for sorting out the freeze vs limits lock
> ordering.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

