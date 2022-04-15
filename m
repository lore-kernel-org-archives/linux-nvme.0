Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944DFC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 05:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rwvsmsnne7SnULh2hbKByo2WuoxQie2Xsqxi/Bxqgj8=; b=LTQDqXABMyJEpmtm8Wf3bqOHcl
	MoMNhZO+XOLpKup2rwfoJJ+DaHns4rC0a5HgxwRrnTPDOp5RXdcN76nvk6r+BcmcpxJNM2LmIOmnn
	UTX2Dcy8AnGMntPFtuP2LBnrMlz7BX1cJSAkgvXsKJ1l+tHOeeXz6m+JNvu8RBDP+lrHjYjWKXXbP
	S9NbrxZ6HQ62R8IW7MWkkCcQmwfoBfwMUmO9WR4riqViTd0RtB/k01KQnPc2YJO/HRdHMpt1zmIor
	uARGXGWfLwm/wD/vhInt0HvMHiWz6BS8/iEycjd7SIeaoWI5cxJCsV60mM4J7npp64L/mbfNkX5o6
	Ry+5bqkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfEFY-008c2z-HU; Fri, 15 Apr 2022 05:12:05 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfEDP-008avi-0A
 for linux-nvme@lists.infradead.org; Fri, 15 Apr 2022 05:09:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1649999390; x=1681535390;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=wC6/PVYH+J9es8aT7sK5ZaGwsGnDQHOFu7y4PW6r0NI=;
 b=CMPNWyaXC+5Ao8bpY5stnytChgMrISU4YAvwAwRTkTi0Gzl9YlnYH53W
 FxcbA2n9y4gsMWt4S9E6o5X3beIAFZBiePehU66IAJ8uaBMt1eBhBSPYe
 XbKky4DtUYLfmCzTYobsWdGEsfuSD1obT+mEuGj4MLO3GzCz2PZXFdB23
 p5rCD8TRMlhaKieuzkS9SlWBgh68mK/8RMqXUHb4Dw6q215lkgZuwLJXt
 t4071Wz1WHFmYFMOhPymV8OvF5zRaixs7azd6Kr/Spp3zFbnmf3b8tJQn
 mzVL60olZG8LHtOegtGOJc8j0RUb+H+NZr/xt3427qBqIsvfEPA0fFCyw A==;
X-IronPort-AV: E=Sophos;i="5.90,261,1643644800"; d="scan'208";a="196832576"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2022 13:09:48 +0800
IronPort-SDR: /DB6T7gTsnF6k/qr5YKa4V8b+qrws22FVnUowAAJVp+a+wNjtWYa5ssz3od+WwdKtH6+dhSwG4
 baos+V0DSSOrlGwQgHSPqMK4FM2TdVPklRC7eKT5EDj8cVX5Cbz2HROzlvJYkGTQcxZxfQme9k
 uREWKf3v23D2u2+mjbt9L4AYNLumbNdMs1CVEQsInYL6G/JLrGfuLl7c+okNYkcdCRwd9XahYU
 eQWYMOLD7EVTEPg4F4c4bAvkCsnNLqCKu7igIO4K629q/9WF0I/bSfe075rYYTGMB5kMu6WQoQ
 ux2AYnAG9E0uzKtd+Sn5iZx3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Apr 2022 21:40:13 -0700
IronPort-SDR: 8cI+ncnba4OEsGuDKwZMWb44cTaRoxTReha4hbUy9Vh/89E7kabsWLmAMmyPKC+K22TG6CCn7u
 NmoQKNnYsfNDxycYmTCuM735W908tJXQJaV8KDAiOoytgvoLQaka2LEoRxWj/ic6xQj2Yb9pHQ
 CaORnOdec78MXuF95fN6dl3+QMsv/xYNHdoEzfRF8wjxjU6iQtOGnaWkmrhfrFJgD4VKSC+iwc
 8iye5ZQ3Gkln5iVNtOgO+EUboDuPmXrqRfp/LKf8Ni5gISyYNzTZLuD8ezf1NRg4lI3Q/iSr/X
 E3A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Apr 2022 22:09:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KfksS4Y8xz1SHwl
 for <linux-nvme@lists.infradead.org>; Thu, 14 Apr 2022 22:09:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1649999388; x=1652591389; bh=wC6/PVYH+J9es8aT7sK5ZaGwsGnDQHOFu7y
 4PW6r0NI=; b=D8kdC3rz3pjqnugRL+G3XHXL6Ng78iZSZCza4fEMQpTN/xdgY6D
 ndgbPRv8Ii6RTniwYP01qFwFHzH91r1LoAWx6xGwWEN+Qsp3Ex2YpjoRKlcblFjc
 7yjQF4oBeK9egOucgCIrr2m+tKTIlJA0mcKIvKIgWCVnz5iEJtEs0vxeju2wZT96
 jtBkpdSzig+EY3uiGMCOqAfDYf4ob5UMdfn63Y/7o6floZGBngeQCZ8K+n+vY3d5
 lYsSP/0Lz/G5amM7P4+yygELabSZDZHGZG/YfdQpCLMrO4FBxFoQbF9pdD3HvN17
 o1OWdE4/X82Vq8Fyie48I/oIcM5G/NLyIZA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id AHkRPewCSwWk for <linux-nvme@lists.infradead.org>;
 Thu, 14 Apr 2022 22:09:48 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KfksM3c9Fz1Rvlx;
 Thu, 14 Apr 2022 22:09:43 -0700 (PDT)
Message-ID: <62ebc311-e5ef-cea5-5236-0c83d1a3eb64@opensource.wdc.com>
Date: Fri, 15 Apr 2022 14:09:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 10/27] mm: use bdev_is_zoned in claim_swapfile
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
 linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
 nbd@other.debian.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-11-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220415045258.199825-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220414_220951_199823_C4B86CE5 
X-CRM114-Status: GOOD (  20.46  )
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

On 4/15/22 13:52, Christoph Hellwig wrote:
> Use the bdev based helper instead of poking into the queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/swapfile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 63c61f8b26118..4c7537162af5e 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2761,7 +2761,7 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
>  		 * write only restriction.  Hence zoned block devices are not
>  		 * suitable for swapping.  Disallow them here.
>  		 */
> -		if (blk_queue_is_zoned(p->bdev->bd_disk->queue))
> +		if (bdev_is_zoned(p->bdev))
>  			return -EINVAL;
>  		p->flags |= SWP_BLKDEV;
>  	} else if (S_ISREG(inode->i_mode)) {

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

