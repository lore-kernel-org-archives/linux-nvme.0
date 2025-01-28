Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A47C02196
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 19:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kNKDjhEJ8WEAWrGsmc4Ai3vMOlslzTIFSyWTX24+HcQ=; b=beEg5geYPX8JR5mHSSWSWZzQVD
	L0jcPFhD6ASilIRuhyKOaIANZ73F1+WCoT2mWhpLKtJi/RgYQtgg2KMBq/oH6STDovUS7QNXUhDOD
	NJNwEGUVOfWZAczynCre46yaOUoIglkcmzw8xpKnl7JfpkRDcKj3hQ4r+Ay0efgJBFGo3GtEAoc8E
	EZt3ua2KrShdPgE4q0Od6LgOU6UnmKH6Hl8Uw93tLv0YK5EM9+yXpeA+WQm6zjOsvWbxdrUSo8W1b
	8TdNjkIFKEi9BgIcqzam1oTb9V/2wk3FCJ8cjrNL+lUoNEp1250VbG8bnQrC5LB5JZT6LOAaBl5Ox
	6vJ7p7mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcqpa-00000005ePM-2hlM;
	Tue, 28 Jan 2025 19:01:02 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcqKa-00000005b0S-0erG;
	Tue, 28 Jan 2025 18:29:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B4AC3A40F8F;
	Tue, 28 Jan 2025 18:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831A6C4CEE4;
	Tue, 28 Jan 2025 18:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738088938;
	bh=5vKlyluoIwL5MLSNFaVfQU6gpPWlLBGUfC043Y4ZA48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4RylrDTIX8Uy8PaKXepTKmo9JbD2s1TqRqjVjk79EX6UIO6eP0djQtJJK88za5Fk
	 JwkXSxGvgFzlp0bbaHNaHN00HXwLVEDwoROTo5wDfRfsMG/11EZ/60VjHn4wEmzqLa
	 kcHBrGV05EUJahj0VGnWlSX1miKbeH9kIAO+dxoNow3QgUmwhY5pXRiW1OXApD28B+
	 xQIEadslx9mpHUs2SEA3p3YZ8dPP9LWiKFJVTR9KJ/66eUffexnSqE6XYU8c9mp7pG
	 pv+Gt1KZVlb4zPDYIUoffAngd1LNkOTrkLP3jy3oC+qPbj05QBwYJ5EYU4eU5MsroI
	 zPBbqI0b5RbTw==
Date: Tue, 28 Jan 2025 11:28:52 -0700
From: Keith Busch <kbusch@kernel.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yaron Avizrat <yaron.avizrat@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>,
	Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	cocci@inria.fr, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 11/16] nvme: convert timeouts to secs_to_jiffies()
Message-ID: <Z5kh5BYrYaDArkkU@kbusch-mbp>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-11-9a6ecf0b2308@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-11-9a6ecf0b2308@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_102900_322891_25521AD1 
X-CRM114-Status: GOOD (  18.27  )
X-Mailman-Approved-At: Tue, 28 Jan 2025 11:00:57 -0800
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

On Tue, Jan 28, 2025 at 06:21:56PM +0000, Easwar Hariharan wrote:
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
>  drivers/nvme/host/core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 76b615d4d5b91e163e5a6e7baf451c959a2c3cab..87498215ede4bcaf48660b89c901075dfcfaf041 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4459,11 +4459,9 @@ static void nvme_fw_act_work(struct work_struct *work)
>  	nvme_auth_stop(ctrl);
>  
>  	if (ctrl->mtfa)
> -		fw_act_timeout = jiffies +
> -				msecs_to_jiffies(ctrl->mtfa * 100);
> +		fw_act_timeout = jiffies + msecs_to_jiffies(ctrl->mtfa * 100);
>  	else
> -		fw_act_timeout = jiffies +
> -				msecs_to_jiffies(admin_timeout * 1000);
> +		fw_act_timeout = jiffies + secs_to_jiffies(admin_timeout);
>  
>  	nvme_quiesce_io_queues(ctrl);
>  	while (nvme_ctrl_pp_status(ctrl)) {
> 
> -- 

Acked-by: Keith Busch <kbusch@kernel.org>

