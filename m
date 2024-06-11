Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2483C25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p05Oa+soL5UqVPbydlN73TzAKOotfP33ep8J8JHpMPI=; b=eQEjV8lXgv2IHpITbfuj8jOs8F
	mzuB6eP2GL0U/w5a5XynWDVS1N1OZ5292a5OkB8aXUABLtMkqb8p8Chuk68FrQkSIShRq1gyYhgQR
	sQ9YePm3VRhHcU3usQ2Qswpmy8LIFGyFaDGw5iuT7zXbjAvzZxDCjTooPdKAkKHoo5dOq40WpTOdo
	cmBszfwjx1kRwdpXu9wr6cjEYMNbXHpgTEBtxCWst7VIIid6CDo7e7z+DVEWCG56APW5/7L6QseYM
	k5f/anNCF2HYu5JYhxU3Hpxk0T1ycKV6J6Zp31YmiuCgfTBgONqxmDqN+BxMv+asySECmFwmIYOFd
	Lpn40tbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwbw-000000080lc-3qPK;
	Tue, 11 Jun 2024 08:12:08 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwWb-00000007zZn-1Do4;
	Tue, 11 Jun 2024 08:06:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A0AEDCE193F;
	Tue, 11 Jun 2024 08:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A7BC2BD10;
	Tue, 11 Jun 2024 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718093195;
	bh=jCn0oX3HrJ6Qlcw/LuQoAhJRxhLaDvFIki6GqIikVDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d/4pmxeJzHoEeQ+g2h36PLWMNipYFVLUgldUlVqiJ/oHVrEeGGWvSVD8Qj0WOLs1h
	 W+bfZgsci1Mj1j7xr+uUvjowbUTryqU8M7niWdxvm06YM2JVc8jmnbjYFRmHHcrBjc
	 35EtrgT1CO5oyRbn/EfIn5kNPHJPwVOwHupvi057HyipWOQnDb4p6IBWsy9PJTe2z7
	 aguwef6PSD/S3jnHhAFsQmA+8/MCfLVtbrqTe0OoYvK6gaKfrbg4IMTS8YbzdTrpnX
	 ruwuQZ89i04k1WQRZE0wdLm48U3gwb4DUnNOpOrrhv3eKIrI6XQd7uuU3njn1J65js
	 90POvgbQ696Tw==
Message-ID: <0f01ed9c-6f85-427c-9690-1551e67e46a9@kernel.org>
Date: Tue, 11 Jun 2024 17:06:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/26] block: move the add_random flag to queue_limits
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
 <20240611051929.513387-16-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240611051929.513387-16-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_010637_544345_2D865024 
X-CRM114-Status: UNSURE (   9.74  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 11 Jun 2024 01:12:03 -0700
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
> Move the add_random flag into the queue_limits feature field so that it
> can be set atomically and all I/O is frozen when changing the flag.

Same remark as the previous patches for the end of this sentence.c

> 
> Note that this also removes code from dm to clear the flag based on
> the underlying devices, which can't be reached as dm devices will
> always start out without the flag set.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Other than that, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


