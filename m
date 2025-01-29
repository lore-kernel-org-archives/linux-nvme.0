Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DBAC0218F
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:Cc:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O+JFGGFluQhzEspwlwz6aXkZ7QKW4DjxL6knEN3myoo=; b=IJw14N/UVQ2316RZRDxSjFznSr
	rki+eIbGR/ciQtldrGvKHgWTLLEG2R5w8T6RNl23CwXl/RzYKSwjArMBCFCaBwImU36NBUzgLYuuf
	pH5fn3c4FDMYIAma75MBnf1e3SljJAiiN3x53OEWHyn+yToDArov5uKB5OCslCmGLk+dg0eDBmFAt
	vgx1Zti+ydOkv44G+YGWmNBMUENCtRo1ed7f1uxQbVHoNRpqVCx9YbQF3cSVX+N2jUr/0AvS6e8iJ
	Mxe0gGVce11TugTwqq+ZNHfXWHWtxqQspDAAx1UqJ1bpw7NpEk/s9hM6+PuYZS3mX4VnjgTMl7trt
	JlezVRbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdtTS-0000000AuUf-16B1;
	Fri, 31 Jan 2025 16:02:30 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdFE7-00000007nDD-36Xc;
	Wed, 29 Jan 2025 21:04:00 +0000
Received: from [100.65.161.47] (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4FFDA2109A5E;
	Wed, 29 Jan 2025 13:03:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4FFDA2109A5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738184637;
	bh=O+JFGGFluQhzEspwlwz6aXkZ7QKW4DjxL6knEN3myoo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=mY3mAkZdBwX5JW6v0rHOcPwixnNpeCwrI5i6lioeivoGl5PeSwTfMHOmjED6AV41/
	 5wIYfQa9MecJKhXc6T7//bDDoOB4BG1MPO3Miu2pGAWJwBcdsKKFOS1hzy+NN34ovy
	 jA6uxIox2R9YzB3PKnfuI/uqwUCqDlg2DifBsbMw=
Message-ID: <dd0358b1-7c8a-4c9e-88c5-2e1db69a3a35@linux.microsoft.com>
Date: Wed, 29 Jan 2025 13:03:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay
 <ogabbay@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, James Smart
 <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 eahariha@linux.microsoft.com, cocci@inria.fr, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 06/16] rbd: convert timeouts to secs_to_jiffies()
To: Andrew Morton <akpm@linux-foundation.org>,
 Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-6-9a6ecf0b2308@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-6-9a6ecf0b2308@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_130359_833826_7ADDF240 
X-CRM114-Status: GOOD (  14.82  )
X-Mailman-Approved-At: Fri, 31 Jan 2025 08:02:28 -0800
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

On 1/28/2025 10:21 AM, Easwar Hariharan wrote:
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
>  drivers/block/rbd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

<snip>

> @@ -6283,9 +6283,9 @@ static int rbd_parse_param(struct fs_parameter *param,
>  		break;
>  	case Opt_lock_timeout:
>  		/* 0 is "wait forever" (i.e. infinite timeout) */
> -		if (result.uint_32 > INT_MAX / 1000)
> +		if (result.uint_32 > INT_MAX)
>  			goto out_of_range;
> -		opt->lock_timeout = msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->lock_timeout = secs_to_jiffies(result.uint_32);
>  		break;
>  	case Opt_pool_ns:
>  		kfree(pctx->spec->pool_ns);
> 

Hi Ilya, Dongsheng, Jens, others,

Could you please review this hunk and confirm the correct range check
here? I figure this is here because of the multiplier to
msecs_to_jiffies() and therefore unneeded after the conversion. If so, I
noticed patch 07 has similar range checks that I neglected to fix and
can do in a v2.

Thanks,
Easwar (he/him)

