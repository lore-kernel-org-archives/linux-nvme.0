Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D3EC25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 10:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G6ueuYcgNyPg+H14jas1l6tjqwo8OtVCGswmLs1Z/js=; b=z3JzkEjhzYgc5F8m3AvNBRWsOm
	kW6JYCxWWtDhOYsRVOe+Rv111SqRJ/duDxfnihGbqGEDoWQ2Nc5dDAXC2xZMei3fwQU/QkXIaRigM
	eiPOHL2sztcwcWnOFFD/2Ru/QTLbr+QQW3I6MtALP/TDibhrVwPUVcNzSHIbaFiitTHRwlslKkH6c
	jL4SeJKKXOS6UXOKliJpckxwx2I1a9HvKua//BCTtgXRJCX9nZarg1GQjeZj+MCJlvb7dbtoX5XMx
	2nsx/v493vLLtUD+Tqne2mK2sdn67/nQcZdgnSlka3PN3dMCBFO8STU98Qm4z4UDGIT2TPTHyiejY
	ipVBZrYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGz3l-00000008VTT-1ci3;
	Tue, 11 Jun 2024 10:49:01 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwp8-000000086AT-3AQe;
	Tue, 11 Jun 2024 08:25:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 142C8CE1A1B;
	Tue, 11 Jun 2024 08:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617E6C2BD10;
	Tue, 11 Jun 2024 08:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718094344;
	bh=SsjtIxdZTv9alxTM6s+eXXe/b4WXYQcjMfNg5CfEKdc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZQZg1j5YVztWgVvkxKyPKd72qqKRNzGYuDroL0hLwlP4ltRHp2mvUzylgapCjo/QX
	 /9JUYHtH9lVcV7U8Irn9NtQ6Tf4T6BlUFQm06rRyckQkTNr9Kms7oXAKJzeYMkpiMK
	 Ybljnp8uYPvlerlZvfIK+8/5AdyU/rT7kIsgR7AlzPHmM2fE435z6Gjn2Vvlo55KVu
	 JYmLy8lPunL3Cs67SCKuZOcNFm3ArkP7Bsy0nS3RPixSC4k7DYJ0IbBTowTxu4OiQO
	 q7okcClLynGKcjyF6P0660uu2Ke9bJiS/94AvjFYJ69OKCMBI3EL8IsbNDCkR/OILW
	 7cbHkjEZuN7bA==
Message-ID: <f4497895-93ce-4d96-bcaa-6ad77be83c83@kernel.org>
Date: Tue, 11 Jun 2024 17:25:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/26] block: move the skip_tagset_quiesce flag to
 queue_limits
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
 <20240611051929.513387-26-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240611051929.513387-26-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_012547_069244_D236FDBB 
X-CRM114-Status: UNSURE (   7.71  )
X-CRM114-Notice: Please train this message.
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
> Move the skip_tagset_quiesce flag into the queue_limits feature field so
> that it can be set atomically and all I/O is frozen when changing the
> flag.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


