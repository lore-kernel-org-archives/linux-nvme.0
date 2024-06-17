Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909BEC27C7B
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jun 2024 07:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D6Vvb8LBU5umTE53B1uu2WJSC19NXQ7RJZ59m5y/5A4=; b=mWrFXSYqwT+4tNJ4jiOjTJ8BOT
	XhECWSulKrRXciX2oHUiz/3y7ek1gd2sjFFG1yIicbAuSufnduIuzP3+hFuOGoUoBXtIsypstmxRv
	8Q5W4F6FqFCLdkipnLiJHWGJJ3d9dvOZTI1eBChsejUJGmGX2soXoUVDlPBLn0eqwwDhcPxswRWDg
	128+el6J+j45cdxuKSXSJDHuUvt6nJSnzo/iiWlDsn706waK5ZPUlu941U6vfqhMbE4SX2HH/1YSV
	vcEXXoEGPoEsdDKFzJFxWVmyAFedAYfcTnVpHfClBwx9qJI/yfrR41wP0ttKme3+oH9WIv9GAj2/S
	vkB99yjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ6eP-00000009bqk-0UaQ;
	Mon, 17 Jun 2024 07:19:37 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ5cZ-00000009Nrh-2toz;
	Mon, 17 Jun 2024 06:13:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 79463CE0FD1;
	Mon, 17 Jun 2024 06:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26F1C2BD10;
	Mon, 17 Jun 2024 06:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718604815;
	bh=i+c+RpVRjeaE7WIb31u0YOButoWpoMUXbmMH2ED9KM8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NGDwf0zXEmzo9+7Yx4d9cGXV793JqUi91piwr9DLQr9gvYLzjssulS3nd0FDXod4o
	 1NiEaNf9DKv91oATngwE6MlpuTxufePFFAUPAiGTMSZ8Iyqb43pbMY/AWpT0yfgG9x
	 h7tK/rGWoSYR5lk30x+/zxQfjGaL8mJv2SH7mMjlqBwSC3JpHWjWgqv3xYEnVpUZ3T
	 GLm2uelJLLxYyxbZLJP4lmiyxvgd2hfNI8V/LV1wIStwKjwJDXjuh7JmDm0LI0dTdZ
	 pEsb3rbnrZU0AByYnkj2ZCWuHVBzn8LtTQfnCUTAC98K23Vza+t2P0C82aHVfqiJXZ
	 7lE9UMorz5Ztg==
Message-ID: <72e2cebc-a748-4e39-8783-440a82cd40c1@kernel.org>
Date: Mon, 17 Jun 2024 15:13:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/26] loop: regularize upgrading the block size for
 direct I/O
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
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Bart Van Assche <bvanassche@acm.org>
References: <20240617060532.127975-1-hch@lst.de>
 <20240617060532.127975-7-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240617060532.127975-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240616_231340_117834_4E9AE051 
X-CRM114-Status: UNSURE (   8.36  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Mon, 17 Jun 2024 00:19:34 -0700
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

On 6/17/24 15:04, Christoph Hellwig wrote:
> The LOOP_CONFIGURE path automatically upgrades the block size to that
> of the underlying file for O_DIRECT file descriptors, but the
> LOOP_SET_BLOCK_SIZE path does not.  Fix this by lifting the code to
> pick the block size into common code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


