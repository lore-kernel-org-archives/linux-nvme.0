Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22C6C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 08:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hSdLIgrPxKmt0A39EhZ616AX8EdlL9NK7+SNBTe7jMk=; b=UVsJIZbUxE7n76OiXDDHaYf7/8
	4E2vN4fCEee4N2P3oEvcCa3D7OMZAeAZW4t0tzPkf1lhvyJliOPFr/SqRLWFdLa1mIUaqzvcxnJkI
	+gKgPY8BnJYoijqUUuXD1WF7FCaiTP0wOxbNqABDFvzJ/+ET5A9KBBUvW3G+3uFvinBM4uLVrVJPi
	OmR7uhzEUM0pHPJQo8HgTXGNV174rZOdS6olEaGbpsYo1Uv4g72JSa/QCNVEcET3Si59aXHNpFnAX
	FGRhKW1JwAiRKVBafnYKqt7XkyZTzJAyd9nzcef8F+RG12XuNifCwj0PzXXI4G9gRnD+vw4QWPagt
	zF2KH/HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngMJs-00Fumq-N7; Mon, 18 Apr 2022 08:01:12 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngMJq-00FukJ-Fl
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 08:01:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1650268871; x=1681804871;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=3/KeY74fCa89/HKmeQeN7bAvF9g3Fcpr0R9Z+15MzFA=;
 b=mkwX0+VC9dkFG1j7QbVmJKatS/KtA00sbtSIORmv9vDSYZXXtyaOl2LK
 YZFSsw/4legVY+zKlsZFVX7KyvigM3BPJt0IBeV1XvdvAdLjfzXMcpCgF
 vF/xL+cFFG7B3/o88GtdgrRiS7pacUZ3e0l19npz8+LCMwyzFwb9Zj3/v
 MZ7IeSTmhCUsbt7jk6J24RWcFOI/PpMthk2fRv8+b6dBRnUzHX6tKhSg/
 KHxn9V4DygHwPZBTXHRRkvN/75l+fxvj7rLcE9JFQdyGaLOFRgO65yAxi
 Fsfer6T+lwd1AcPITunNaSJVm9R/tG8XB6t6k6FsLRXzg8GLf6Q2yWpSj Q==;
X-IronPort-AV: E=Sophos;i="5.90,269,1643644800"; d="scan'208";a="199047587"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 16:01:07 +0800
IronPort-SDR: 9oBEkXUbuZ8UoNcdjNBdnNIbnnNQIaAvOJo+rS1b2mHZ0HgZ49w15euyDJXdpDtuL16RIUJdXp
 oEnQdv7DBNKHOzB/d+k+sujeFbWNOhpJUczGukMVk6KMVAa0ePMl461mCKwmopbGQ3n++zJR3M
 aVj0TN7mzQtAi1p7E8lzVuBVn3w2liXrxT1OpzaEF4TKkxsmVtZC7V5ynVmkvuX4a2C2SEmZ4r
 0N3OnFqkSpmEeE6wgUrmcZRcicXTC9YmeCoa6xT7DaJ9boaEKa76mAO0aLwdhgBT5qmv6Ihbjx
 s1GM6hcRtlpQFrfKzGmqw+5p
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Apr 2022 00:32:13 -0700
IronPort-SDR: 9A88UktfInxtTLmlJ6ysqjmiZJhEr1AxfsrwjeYW4KBiVUpbt221CXAxi6IDV7CZLXBuGGQVB5
 KZzYxSuOAp/B0G4D9AQnxt678GgfseD7ZXAXrgarvPotmAsnU9Af668JXY3Rh+9V7Zz4GDIgoe
 UBctctyKrdBbXW8KQmYs0b/Dk3iP4+QIoF0VEjOZXJU87/GZziskfG36K3M/7FWfe8MlAdHWXL
 vFayo6lMIU0ZoPchaP9/ALf479yV+iPFh+x3rj8ReIG68nTDZoAcN4+zAnlCK0RJiRdfr/d8Zk
 KwI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Apr 2022 01:01:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhfWj5Pjgz1SVpC
 for <linux-nvme@lists.infradead.org>; Mon, 18 Apr 2022 01:01:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1650268864; x=1652860865; bh=3/KeY74fCa89/HKmeQeN7bAvF9g3Fcpr0R9
 Z+15MzFA=; b=RIA+H92HNPzO4gWSeMVoqSWT3m10rBKmlLQcVEyCT9Rid+o1KlV
 iqV2xUypq2hDG/V8+vod3GcZtiyWFYkzYA2YHoTyC2BIJE5k41aqBGin/fd1TZ/M
 b3+meMBaDqT3CBOEkN4Dr3xrqtXr8bCAOS1SaCim+QrPo47IHpeoOFz8wKR5cl/D
 fK8/F9+hBEendDrUaP6UYa6QADixsBuszVbfs+uTK8Xu2BiLh3viWdBB/rO1zH6b
 GQbc1dCPmhvl/dHQXgJxs/XwFf43p3Vpekh27O0opPRrekskDKSmIKghQQKDVaXj
 krlHvgQVnrfyY2BhYOMFK2yeTZa3G6VdKyA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id c08ExGoBw47r for <linux-nvme@lists.infradead.org>;
 Mon, 18 Apr 2022 01:01:04 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhfWd1wHlz1Rvlx;
 Mon, 18 Apr 2022 01:01:01 -0700 (PDT)
Message-ID: <fb5baf81-fa19-bb48-865c-e13277a0952a@opensource.wdc.com>
Date: Mon, 18 Apr 2022 17:01:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [dm-devel] [PATCH 03/11] null_blk: don't set the
 discard_alignment queue limit
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 Song Liu <song@kernel.org>, dm-devel@redhat.com,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 linux-s390@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 xen-devel@lists.xenproject.org, linux-um@lists.infradead.org,
 Mike Snitzer <snitzer@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 nbd@other.debian.org, linux-block@vger.kernel.org,
 Stefan Haberland <sth@linux.ibm.com>, linux-raid@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-4-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220418045314.360785-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_010110_616626_B584843C 
X-CRM114-Status: GOOD (  23.07  )
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

On 4/18/22 13:53, Christoph Hellwig wrote:
> The discard_alignment queue limit is named a bit misleading means the
> offset into the block device at which the discard granularity starts.
> Setting it to the discard granularity as done by null_blk is mostly
> harmless but also useless.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/null_blk/main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 5cb4c92cdffea..a521e914a9843 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1765,7 +1765,6 @@ static void null_config_discard(struct nullb *nullb)
>  	}
>  
>  	nullb->q->limits.discard_granularity = nullb->dev->blocksize;
> -	nullb->q->limits.discard_alignment = nullb->dev->blocksize;
>  	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
>  }
>  

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

