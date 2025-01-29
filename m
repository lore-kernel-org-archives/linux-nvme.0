Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C27BC0218D
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 17:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SjO4doi6Crwa1+LH/mFjSX+oOZBIPS0GurKbtLeu/UA=; b=NGasmJFERsNfMaJcXFZbIpJci+
	HD22Z/dIHcw7FRi3xtpJyKnoJeW7jYyYLW66153UPiY0Hjd2QIphK2NUuz3Ki0wT4i1iCB5e/HhvJ
	emFVPbuXvpvGrmnJ6K5BPuYFqmSDr96IDVD/izaZ/vQMZj2GGqEJLbKqJymPve19CoVOFlC3E+Fzp
	0riwECSeCEhavR4VL/VwZtHNn1yGLtoH6OQ/kAXI3e31MG1iQvmlXoG7yVjJrRttS/Hu2agkG+Evw
	ApsOi1Secbfm9NegzEziym+mNQFPHzqzvHDMsTq/LAt+1tUBHzoUYN06S8ZdjW7FJbbnlJvvlUaH3
	Om6+hBnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdC14-00000007VXm-2fqn;
	Wed, 29 Jan 2025 17:38:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1td1Y8-00000006Pu2-46sy;
	Wed, 29 Jan 2025 06:27:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D54ED5C55CE;
	Wed, 29 Jan 2025 06:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E108EC4CED3;
	Wed, 29 Jan 2025 06:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738132062;
	bh=BcheDkbF7i4plK077EE5fx0I+7LaoMSZmCvmiRwCLWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tYXlaTpf1UHLxCOLY2b71oBs1Z8jmc+k88hDg4mxgy9BfVh5FaZFJ0sctqiMaUJa3
	 0ERjR88O2sKxLaXENNFiYXgW5V6EWANwLybrlRdZ0uAueHnvFc/luTGhJJHi5qSyHf
	 Qhwk4n5jqTURqvwR6zUdrtKBktKuVAQJmisiNKpSZSSK6LJmo4zYOOzg6tSFgxCsOc
	 Qfzb+Ch4Hp08uSkL1c1h9vCW8n/kbD+KUJVXjOVTrDcLl+peTbMx/iozRX16+XGbqx
	 LmxLOokGigU1zjIvh0goqBVkjBWqvL4YDcg+yxNUApdR5ACop75NXb+fT4J9+7jnPJ
	 KRVcLrP4/YQHg==
Date: Wed, 29 Jan 2025 07:27:24 +0100
From: Carlos Maiolino <cem@kernel.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>, 
	Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Hans de Goede <hdegoede@redhat.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Selvin Xavier <selvin.xavier@broadcom.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, cocci@inria.fr, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 09/16] xfs: convert timeouts to secs_to_jiffies()
Message-ID: <kywszbmxtm27rlgaefr6xus6l4bpdiouqqe72px7ml72hh4ozc@5orjtzsbg75s>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <JZGx8kYNWP54f9cEViEKZlR6sGGADv31K4TOPtwvyeoDEFkRKICiFaQy04EvZtsQtc44Zozh76mkch2s8rz7mQ==@protonmail.internalid>
 <20250128-converge-secs-to-jiffies-part-two-v1-9-9a6ecf0b2308@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-9-9a6ecf0b2308@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_222745_180270_501A2B20 
X-CRM114-Status: GOOD (  18.39  )
X-Mailman-Approved-At: Wed, 29 Jan 2025 09:38:17 -0800
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

On Tue, Jan 28, 2025 at 06:21:54PM +0000, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@
> expression E;
> @@
> 
> -msecs_to_jiffies
> +secs_to_jiffies
> (E
> - * \( 1000 \| MSEC_PER_SEC \)
> )
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  fs/xfs/xfs_icache.c | 2 +-
>  fs/xfs/xfs_sysfs.c  | 7 +++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 7b6c026d01a1fc020a41a678964cdbf7a8113323..7a1feb8dc21f6f71d04f88de866e5a95925e0c54 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -230,7 +230,7 @@ xfs_blockgc_queue(
>  	rcu_read_lock();
>  	if (radix_tree_tagged(&pag->pag_ici_root, XFS_ICI_BLOCKGC_TAG))
>  		queue_delayed_work(mp->m_blockgc_wq, &pag->pag_blockgc_work,
> -				   msecs_to_jiffies(xfs_blockgc_secs * 1000));
> +				   secs_to_jiffies(xfs_blockgc_secs));
>  	rcu_read_unlock();
>  }
> 
> diff --git a/fs/xfs/xfs_sysfs.c b/fs/xfs/xfs_sysfs.c
> index 60cb5318fdae3cc246236fd988b4749df57f8bfc..eed0f28afe97ead762a9539e45f292db7d0d0c4a 100644
> --- a/fs/xfs/xfs_sysfs.c
> +++ b/fs/xfs/xfs_sysfs.c
> @@ -568,8 +568,8 @@ retry_timeout_seconds_store(
>  	if (val == -1)
>  		cfg->retry_timeout = XFS_ERR_RETRY_FOREVER;
>  	else {
> -		cfg->retry_timeout = msecs_to_jiffies(val * MSEC_PER_SEC);
> -		ASSERT(msecs_to_jiffies(val * MSEC_PER_SEC) < LONG_MAX);
> +		cfg->retry_timeout = secs_to_jiffies(val);
> +		ASSERT(secs_to_jiffies(val) < LONG_MAX);
>  	}
>  	return count;
>  }
> @@ -686,8 +686,7 @@ xfs_error_sysfs_init_class(
>  		if (init[i].retry_timeout == XFS_ERR_RETRY_FOREVER)
>  			cfg->retry_timeout = XFS_ERR_RETRY_FOREVER;
>  		else
> -			cfg->retry_timeout = msecs_to_jiffies(
> -					init[i].retry_timeout * MSEC_PER_SEC);
> +			cfg->retry_timeout = secs_to_jiffies(init[i].retry_timeout);
>  	}
>  	return 0;

Looks fine to me.

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

> 
> 
> --
> 2.43.0
> 
> 

