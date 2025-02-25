Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6174C021BE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 00:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:Cc:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jyr1W2i0apHpLVaBAxpMdrionoJIfFMi72X+ip6bMMQ=; b=k7K7Ktv479+14RwVNNXEFziS43
	2BGfzChwhWdHO72wH4rZLMBD+dNX2huFiicl9MqMaTUx89Sb7mIP1qkLm7KQnqs/s3FlGwRqG8LMi
	n7NKTRjtb5PVPfWy+7pP0jjkX9C4Prtagy8MluxxozBfT1wRhWWQ41VXhjU1GSVqr9LBRvcP5RUnC
	+HlWrXLNmevad7NB69CHkRBtcutp858+iwNa4kK090YiedoCNQlKtJT75HL5bTBX++1yWc9NLBW26
	DKVss7Lkb7eKXuHvv1zgIWlFZjQvjVniBcjeBljbe1iBkorzVEJrhkph+qz2S+mml6sypG/3CIykd
	UWzVS1vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn5jc-00000001vRE-0h1q;
	Wed, 26 Feb 2025 00:57:12 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn1UE-00000001M5K-1qX2;
	Tue, 25 Feb 2025 20:25:04 +0000
Received: from [100.65.162.92] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5191F203CDFA;
	Tue, 25 Feb 2025 12:25:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5191F203CDFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740515101;
	bh=Jyr1W2i0apHpLVaBAxpMdrionoJIfFMi72X+ip6bMMQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=V/Rh9+nle434EIbuopM9xYrJYNBYrbLOW3WlEQkOknOqiCToz7hMLQUIFrnG8DXvX
	 yvhD7z2wBqkGseO+sg4I4fJv6ATebbI1vRErjd+f0KCKZCXRNZme7+k0ebhA+Gn/ng
	 4eDWKrdedP1lm6ZmqWkXb2DlKrIKwrjZudbMNMKQ=
Message-ID: <ff51bcfc-10c8-4461-9f82-ea1d5ed784f8@linux.microsoft.com>
Date: Tue, 25 Feb 2025 12:24:59 -0800
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
 David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>,
 Xiubo Li <xiubli@redhat.com>, Niklas Cassel <cassel@kernel.org>,
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
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 08/16] ata: libata-zpodd: convert timeouts to
 secs_to_jiffies()
To: Andrew Morton <akpm@linux-foundation.org>,
 Damien Le Moal <dlemoal@kernel.org>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-8-a43967e36c88@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-8-a43967e36c88@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_122502_528256_586C174B 
X-CRM114-Status: GOOD (  10.14  )
X-Mailman-Approved-At: Tue, 25 Feb 2025 16:56:55 -0800
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

On 2/25/2025 12:17 PM, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication
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

This was meant to carry Damien's ack once the subject line was fixed[1], but I fixed
the subject line and missed adding the ack in. Damien, would you like to ack again?


[1]: https://lore.kernel.org/all/f39cde78-19de-45fc-9c64-d3656e07d4a7@kernel.org/

Thanks, and apologies,
Easwar (he/him)

