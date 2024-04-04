Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C30CD1284
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 17:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Li/HYSqUiHHL1gshTVSsuPqGzmPzUmPuzsfkN43c+RM=; b=a1m9nAVxteqADvXA05aZnsg/NR
	23wRYz3X+3lptJTyfWb0krSQVYaPPnrAdzh986wAHDSvDsff4gMULoWP0tU2j8SmsoSi6v70X0/Ie
	f37Z06tjKq/dXbKQlBPYQgyjLops14plLyUQIddyJPqHTDOKerRAkFTcdVGdHCWyE/hFVQubztMFD
	OsQ9iuv25m/5tZbQyYyMx6qPHiTkCkurJAs61psv5auCpmmZzKoAilFYOgFrcJksLPVVmv4KUJNV4
	wgbSG4m+XLhetWhpVg4/DIgyQA+QYQZuY+Okne0VYM+b0wNNL0CGbvQKZJv+bU+Z5ME1HGyQAC7Qv
	NmjIze8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsR02-00000003fRZ-1LPo;
	Thu, 04 Apr 2024 17:35:42 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsQzy-00000003fPO-2N6P
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 17:35:40 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V9TKf5xg5zlgTGW;
	Thu,  4 Apr 2024 17:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712252131; x=1714844132; bh=Li/HYSqUiHHL1gshTVSsuPqG
	zmPzUmPuzsfkN43c+RM=; b=hCjT4nSYv13pVzrQUyrKZ70vuRRDYWP+O38zAytq
	e+qhefhOO5P6g+CZSiDTtAE4xsrsc7KfEaJDYlv4K7WdnVDJMa/2uOvLY+jEKDtn
	V1Z6VZNkI9q3POcFMaEaH8TH0Nv6D/7FdgBGZWLQyMXeQxeb9PWYgzvZm65g+nVy
	0gPvLCysBia2sSByxOoE14cP9l+L6n/MQjeJg5uYQhIfkHNESll0aMeDiLOj8k+8
	hGE9nT0GUrTkyouWdUA+8r8wtxX1AYnv9yV1+n4j/rNtJBt3tIDI4Uloj04LbPsB
	++NZALH2z6wE4oIpE7z62G6eOZquOMTltBC5gKU6825Y2A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id q-IbjMRqNSP9; Thu,  4 Apr 2024 17:35:31 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V9TKZ6n70zlgTHp;
	Thu,  4 Apr 2024 17:35:30 +0000 (UTC)
Message-ID: <d1c6b3bf-6381-438a-8814-6809753ac567@acm.org>
Date: Thu, 4 Apr 2024 10:35:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/28] block: Remember zone capacity when revalidating
 zones
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240403084247.856481-1-dlemoal@kernel.org>
 <20240403084247.856481-7-dlemoal@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240403084247.856481-7-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_103538_659880_0782B814 
X-CRM114-Status: GOOD (  12.99  )
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

On 4/3/24 01:42, Damien Le Moal wrote:
> In preparation for adding zone write plugging, modify
> blk_revalidate_disk_zones() to get the capacity of zones of a zoned
> block device. This capacity value as a number of 512B sectors is stored
> in the gendisk zone_capacity field.
> 
> Given that host-managed SMR disks (including zoned UFS drives) and all
> known NVMe ZNS devices have the same zone capacity for all zones
> blk_revalidate_disk_zones() returns an error if different capacities are
> detected for different zones.
> 
> This also adds check to verify that the values reported by the device
> for zone capacities are correct, that is, that the zone capacity is
> never 0, does not exceed the zone size and is equal to the zone size for
> conventional zones.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


