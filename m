Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799DAC4453A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 19:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d+TcFgqQukObtCSZvW9VgUWZR2p8E5ySHAMVDnChiis=; b=Cf9hEniPsv4Y3O
	pztjpMpuJI9gW52wh0EyZXt7pyEvSQ3e4hbMwyHzFF/Pf1d4bNgVx5qgFs0foorpWGyhpFSzMIJAk
	hw0bdMb3C9oNrCkkS1BvP0a6ELM6vJ8dwk3xFO9EphBiT82ZMqcqi0eUeLmEf8kWXlARfBPx2+YPT
	TqPx5FY7nb8QnlRo7FXG1VXbe6sen8xm7QBARXKJqUnt700wyn9ID5zIRH89hnyQ8DMO1rdRjQLch
	SNwLcxm7hhc3Ow78vE58QA/HZij2S0weTPGuh2Kly4B7lgupA/MOtqHo+ZnUwsY0vB/3Li0Jucf6V
	sDchNI/99a7/M8bkHgfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmcSu-0000000CdFf-1WOq;
	Wed, 22 Jul 2026 19:18:48 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmcSr-0000000CdEw-4B7Y
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 19:18:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=d+TcFgqQukObtCSZvW9VgUWZR2p8E5ySHAMVDnChiis=; b=mQRIs3wkfvk8mukQPjS6/uHcq4
	5tZrNMWxPfrEuKuF3obOH9P+n5ni+wANeG2QV8ZQxeElcgt1o1fQFeTgHuY5qHD4MehFKNjbDQ1nx
	LMMVNpHW74oJNrb7pa2a65oUPkStLb6kxtmVh3bWDnLnajXYk6L/yJIOgeENrD10BgP1HJGba4Mn3
	AGcbgO59VYN5xvVe03XYgvcJBUdWqjk5YsNMkg3E8sKPWXNCR7tvaz7NZUxuIwJQzxf/0mpd412FP
	GeW1wo8P4dZIXeekoOdsD5PWpQopBz8ckA3c+Dv2Xx4jLPm4mqQNm9HCngQKRGoRpDvxbmqURV4CY
	yuejIiJA==;
Received: from d172-219-145-25.abhsia.telus.net ([172.219.145.25] helo=[192.168.11.155])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wmcSm-0000000CaBm-2qki;
	Wed, 22 Jul 2026 13:18:41 -0600
Message-ID: <38c44536-51c0-43a1-b83c-b94915890aa2@deltatee.com>
Date: Wed, 22 Jul 2026 13:18:27 -0600
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
 <20260722185841.449934-8-mykola@meshstor.io>
Content-Language: en-US
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260722185841.449934-8-mykola@meshstor.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.219.145.25
X-SA-Exim-Rcpt-To: mykola@meshstor.io, axboe@kernel.dk, song@kernel.org, yukuai@fygo.io, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, magiclinan@didiglobal.com, xiao@kernel.org, guoqing.jiang@linux.dev, leon@kernel.org, jgg@ziepe.ca, kmodukuri@nvidia.com, kch@nvidia.com, bhelgaas@google.com, shivajikant@google.com, praan@google.com, henrique.carvalho@suse.com, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 7/9] md/raid1,raid10: skip futile retries on P2PDMA
 mapping failures
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_121846_115129_85B1264B 
X-CRM114-Status: GOOD (  21.44  )
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



On 2026-07-22 12:58, Mykola Marzhan wrote:
> From: Logan Gunthorpe <logang@deltatee.com>
> 
> BLK_STS_P2PDMA reflects the peer/member pairing, not member health:
> retrying the same pages on the same member cannot succeed.  Keep
> WriteErrorSeen so the range stays fenced, but skip WantReplacement and
> FailFast eviction, as commit f7b24c7b41f2 ("md/raid1,raid10: don't fail
> devices for invalid IO errors") did for BLK_STS_INVAL.
> 
> The failure is whole-range and deterministic, so narrow_write_error()'s
> block-by-block submit_bio_wait() retries are pointless.  Record the
> whole range as a bad block in the completion handler instead.
> 
> Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Co-developed-by: Mykola Marzhan <mykola@meshstor.io>
> Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
> ---
>  drivers/md/raid1-10.c |  3 +++
>  drivers/md/raid1.c    | 12 +++++++++---
>  drivers/md/raid10.c   |  8 +++++++-
>  3 files changed, 19 insertions(+), 4 deletions(-)

Maybe drop my authorship from this patch. I only did the first hunk and
don't fully understand the bulk of it.


> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> index cee21452e066..89daf8558251 100644
> --- a/drivers/md/raid1-10.c
> +++ b/drivers/md/raid1-10.c
> @@ -309,6 +309,9 @@ static inline void raid1_write_error(struct mddev *mddev, struct md_rdev *rdev,
>  {
>  	set_bit(WriteErrorSeen, &rdev->flags);
>  
> +	if (bio->bi_status == BLK_STS_P2PDMA)
> +		return;
> +
>  	if (!test_and_set_bit(WantReplacement, &rdev->flags))
>  		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>  
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 19c4dec450de..917d694ef401 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -2624,10 +2624,16 @@ static void handle_write_finished(struct r1conf *conf, struct r1bio *r1_bio)
>  			 * narrow down and record precise write
>  			 * errors.
>  			 */
> +			struct md_rdev *rdev = conf->mirrors[m].rdev;
> +
>  			fail = true;
> -			narrow_write_error(r1_bio, m);
> -			rdev_dec_pending(conf->mirrors[m].rdev,
> -					 conf->mddev);
> +			/* Mapping failures are whole-range and deterministic */

I'm not sure I follow the point of this new comment here.


Thanks,

Logan


