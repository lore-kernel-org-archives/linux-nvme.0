Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB7ACCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 05:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sqieCu+UIOf81tXqB7aUd4zfChJC3njMDpMawemTdrs=; b=PSLOwLJwnpmZIjd6x2MjC4/luU
	pL/QRZhz07ND8gDw161OXFuJA93TRcnyDufVpu25EUASa+0yRQycE4J0OvDPARwKymQsQYOJE4GNh
	wKjH1IWa1IU853DO78NOEoZ04ODcLnPqQk8iCm3j6dNncvi3jqHMGggyTq8RoldX7SqXYZD+4nPfe
	8VF6KqHCV651ENNUYHDAdmmEoA6w+Z54o8yzVe9GSC64SsfTzWS52fiMNE19qAV8ce1wAn0FpLkU1
	XYE5vBNzD+5iQfB/c6ZIvgJneCiXiiprDSK99CMwR65zIjokBELS+rI++4p7OwMwS8EBzynM+jmFl
	nFMr33gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFnXN-00000009Frh-2lvG;
	Mon, 03 Nov 2025 05:55:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFnXM-00000009FrX-0KxB
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 05:55:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B02756013A;
	Mon,  3 Nov 2025 05:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C7CC4CEE7;
	Mon,  3 Nov 2025 05:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762149326;
	bh=6LgEPdkotDiUC26z3hawBssMdC0Ec7mJ0QWs+Mou5lg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=fkju2wnGMNeh+frH605RoGSCvt8OW3kANgUJV2wPQIt310Go8GP5F0WoIv4ukN2mM
	 DLe5vl55xqJ1CljTAM33OYU8Xya0oD4z4KA84VTMp6LNoCDKY0ad++WVn/rLkABk5c
	 I2wWsE7N21GY5cdnePjgj3KJFiO70mQlSZ/nTfbQcD4uVIfAlcelRzecci2TuyiU0u
	 A63n1+5axU1qIIk7VMf0qgRgSAyu/kMRMQSST6EgHgRkzxSrF37rsk9xE1VhyTDYee
	 d2ZrWFXDgc+UbeGLZuOlZMX8/Ls3+cABTyFgsEtr9pGTzN36bFgTO2NBHCtfsd00Yy
	 AjODKC0h8kSnw==
Message-ID: <bd71691f-e230-42ca-8920-d93bf1ea6371@kernel.org>
Date: Mon, 3 Nov 2025 14:55:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] block: freeze queue when updating zone resources
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-2-dlemoal@kernel.org>
 <55887a39-21ee-4e6c-a6f3-19d75af6395a@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <55887a39-21ee-4e6c-a6f3-19d75af6395a@acm.org>
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

On 11/1/25 02:48, Bart Van Assche wrote:
> Hi Damien,
> 
> disk_update_zone_resources() only has a single caller and just below the
> only call of this function the following code is present:
> 
> 	if (ret) {
> 		unsigned int memflags = blk_mq_freeze_queue(q);
> 
> 		disk_free_zone_resources(disk);
> 		blk_mq_unfreeze_queue(q, memflags);
> 	}
> 
> Shouldn't this code be moved into disk_update_zone_resources() such that
> error handling happens without unfreezing and refreezing the request
> queue?

Check the code again. disk_free_zone_resources() if the report zones callbacks
return an error, and in that case disk_update_zone_resources() is not called.
So having this call as it is cover all cases.

-- 
Damien Le Moal
Western Digital Research

