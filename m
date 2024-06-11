Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74A0C27C5E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 10:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pNYwaEj3dNrURegA+RiJOqP/pVUJo6xdE4fsHS2G568=; b=wa27Vbr6Imx4yRZa0sabXISvWv
	K7KsWXX57fsyZUViL6uS7VK5UAN3IqhV4pes8j85rhapmusIA7Z61/lJS2YI2/sUsIssP995PajGR
	StkVp2bi5YiOyndCsBFhWVhAdq9w6dAg46EU7mxC1R7VDWzBD7Mw5+cuiMWOQ7z4fyIZ/zp7BrjUm
	ZjEFBSTNmxTsDfS1EB1z1zuoHvv0mr/7QSqoin7UIvStWR9fr5P31I4GoVsYy/sTXSGBgptPU8qHt
	Gvg0AgSZ1FM1e6uaqal91So2RYWlWTAl+0N5cLCOntiHvFHO9nNusJZjFAefeF+qwLzF46MTqRbud
	xMOuVsWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGz3T-00000008VGB-31k7;
	Tue, 11 Jun 2024 10:48:43 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwkj-000000084IJ-1Cxs;
	Tue, 11 Jun 2024 08:21:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9FE0660C54;
	Tue, 11 Jun 2024 08:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC86FC2BD10;
	Tue, 11 Jun 2024 08:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718094072;
	bh=JnxwCboQk8q7RlLZlW4EySiyxLKgUjk778Traf3fmoA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T4lYpc9oPKzbZgXNScRXj6fCCJuF2imMpVDO2TmKoprDVoEMAifMh8yJGso4Vfp5y
	 OgmplPRZ+vOoc/3W5Z2/vvUR59B9dvvmiJ3TXlfZjt80a4a+B616vcQsbnQtB8TQlx
	 hCCsxl7ULUCU4AFz7+jEuDHX9a+L+WI83HnZLceoWGeScqnvdznMEcmPFZA+cvHULW
	 tsWbQ1wsp08S3pZw6QSDKAzAlfLw76qcbODE/Rb62WAcCaMIMds4nLrdbgO640++hO
	 MSBTvFYh9It5CVDUDafarknsby40aO62VVd0BASXyBUwrOv7fDEDdarOIcY3IX1DTf
	 +T3qkIPPHiYZg==
Message-ID: <d1775d3f-daaa-4193-9f68-06ec47563b35@kernel.org>
Date: Tue, 11 Jun 2024 17:21:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/26] block: move the poll flag to queue_limits
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Richard Weinberger <richard@nod.at>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai3@huawei.com>, Vineeth Vijayan <vneethv@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
 drbd-dev@lists.linbit.com, nbd@other.debian.org,
 linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20240611051929.513387-1-hch@lst.de>
 <20240611051929.513387-22-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240611051929.513387-22-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_012116_873529_CA5EEFBA 
X-CRM114-Status: GOOD (  12.23  )
X-Mailman-Approved-At: Tue, 11 Jun 2024 03:48:17 -0700
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

On 6/11/24 2:19 PM, Christoph Hellwig wrote:
> Move the poll flag into the queue_limits feature field so that it
> can be set atomically and all I/O is frozen when changing the flag.
> 
> Stacking drivers are simplified in that they now can simply set the
> flag, and blk_stack_limits will clear it when the features is not
> supported by any of the underlying devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Kind of the same remark as for io_stat about this not really being a device
feature. But I guess seeing "features" as a queue feature rather than just a
device feature makes it OK to have poll (and io_stat) as a feature rather than
a flag.

So:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


