Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442C1C4452B
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2026 03:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rC+XBUGFmySIn3VPBg9GBg/XbZWxt1FvpkzqM8RzAE4=; b=uSnod7P76vGEEX
	3tKqj7+ybCOJhZih/2xAYRBG4RuRFZ/o8wjVd7EyG6XryEPrptsafmL7gTzVzlRS/wftHIaVl2828
	cNPlgybbkTU6yP9Z2T8zD8FVc6x6v1BjD6MkYtSpVjdDEPKexEPn48UX8KdcZpFdcA+jTkvM1VNqO
	EPgOW/XVz7zSHCJhENQfkgCqkt4VuJPNHz/ZpETuTM4WL3GWiDOIL0kTfRcsxyCUlLC9WW3S2tSOZ
	tDutUIho5H3JymJ8rrMDHT+B1NU70j+VtC5sSxavYvCbDjNETuwhXoRTlu/CFOKIePu9YzFP2DpcB
	LNuSP9OC6gEbtnpUNCuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmjsJ-0000000DHl3-20S9;
	Thu, 23 Jul 2026 03:13:31 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmjsH-0000000DHkY-1vDP
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jul 2026 03:13:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=rC+XBUGFmySIn3VPBg9GBg/XbZWxt1FvpkzqM8RzAE4=; b=q+v6LAw8gBxwqa3cOIQEXC3cMJ
	5756S4TXTL4zSiuUzMe7/27YHQiwEj2NiG58xC4WGPsEogiXd4aNH0NiQKiMGKQDRYhy28+R9Us8A
	S3/LYRjonw7QSDPJONdDVL84N1x8hi9e8CYS2M2oLa1ArrwIfsPkWM32waaBEuKpm8pVVWgs89+Hi
	shfawWP5ZD2XU8jhY+4r+ACVr6ngu9egpW2Jg/yBYsRjil73XH5Ji4LZqH8H9P7hGIaCPmXuTtidN
	lwRb7AMjkgpBYB/Zxfi92semLE1yV8AXiFNJRWR4A0FLEJs0p/74dPjiBQLJR4dV3+/5NYMjyvInc
	EOVWi+Ow==;
Received: from [104.157.31.28] (helo=[192.168.1.251])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wmjs7-0000000Cf7r-20SR;
	Wed, 22 Jul 2026 21:13:20 -0600
Message-ID: <38fc491b-ce80-4bb0-85b4-7987936afb26@deltatee.com>
Date: Wed, 22 Jul 2026 21:11:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mykola Marzhan <mykola@meshstor.io>, Jens Axboe <axboe@kernel.dk>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>, Xiao Ni <xiao@kernel.org>,
 Guoqing Jiang <guoqing.jiang@linux.dev>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava
 <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260722185841.449934-1-mykola@meshstor.io>
 <20260722185841.449934-9-mykola@meshstor.io>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260722185841.449934-9-mykola@meshstor.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: mykola@meshstor.io, axboe@kernel.dk, song@kernel.org, yukuai@fygo.io, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, magiclinan@didiglobal.com, xiao@kernel.org, guoqing.jiang@linux.dev, leon@kernel.org, jgg@ziepe.ca, kmodukuri@nvidia.com, kch@nvidia.com, bhelgaas@google.com, shivajikant@google.com, praan@google.com, henrique.carvalho@suse.com, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 8/9] md/raid1,raid10: set IO_BLOCKED in case of
 BLK_STS_P2PDMA
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_201329_506263_375EF42C 
X-CRM114-Status: GOOD (  20.63  )
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



On 2026-07-22 12:58 p.m., Mykola Marzhan wrote:
> From: Logan Gunthorpe <logang@deltatee.com>
> 
> A read that fails with BLK_STS_P2PDMA cannot succeed against that
> member, so mark the leg IO_BLOCKED and let the retry redirect elsewhere.
> Skip the read-error machinery: there is nothing on the medium to fix,
> fix_read_error()'s probe reads into host pages and would "succeed", and
> charging the read-error budget would evict a healthy member under a P2P
> read workload.  FailFast eviction is skipped for the same reason -- the
> request never reached the wire.
> 
> Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Co-developed-by: Mykola Marzhan <mykola@meshstor.io>
> Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
> ---
>  drivers/md/raid1.c  | 4 +++-
>  drivers/md/raid10.c | 5 ++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 917d694ef401..76a1426e64f0 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -2658,6 +2658,8 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
>  {
>  	struct md_rdev *rdev = conf->mirrors[r1_bio->read_disk].rdev;
>  	struct bio *bio = r1_bio->bios[r1_bio->read_disk];
> +	/* evaluate before the bio_put() below */
> +	bool p2pdma_error = bio->bi_status == BLK_STS_P2PDMA;


Sorry, I had one late nit-picky thought tonight I thought I'd suggest:

It might be better to store bi_status in a local variable instead of the
much more specific p2pdma_error value. I think this would read a lot
better, make the intent a little more clear and be reusable if other
bi_status conditions need to be handled specially.

Thanks,

Logan

