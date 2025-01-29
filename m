Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D424C02196
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 06:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FRie99yEZrhjpO7yvVL8KcKSrVHlVFaikakzBOXXXLw=; b=NIBIboXzdF9DUEkxKc8FDQ8ht5
	a7Obu90dIn7NNo4Uiat155tnQkLDgEclHcVicVKsRMg5Fo+rtRLDc3ddBH9taemZFJwqGiKMrM5jW
	SXRJaalk4qsQIerbjwgDYkXw7YVZ6uInpj6E/phlDgGGym7kh2AaMWpyK+wycw9qSXrxYs3OA2Tmp
	60DqIZrgp94Mv1oivQDehE9EQFMVxWRViISZY6B4jfJsEXxjtenh/29LfzQQm2vQlX946fxPxGonR
	NRRkg2tZrXDWj3gAY17z/+FJ6QudUnVxbcl6i+2a+0mfnxUrzFa2pvcY6in+CPDo274LnhPk1X1wM
	nttGzz9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1td1VF-00000006OzU-2wW1;
	Wed, 29 Jan 2025 06:24:45 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcvlA-000000064VE-1UsS;
	Wed, 29 Jan 2025 00:16:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DBB26A41602;
	Wed, 29 Jan 2025 00:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994C4C4CED3;
	Wed, 29 Jan 2025 00:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1738109806;
	bh=zZU6hynWCHp+6F/RCQmfqyOYkRbiqQZ0uQFQk367ytg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AS2j4JP5RIAisJwaJPGo5rdD+WQkiOVOSd2qjWS7o62PB/KfGo+AtIeEIRlVi8ca4
	 DcFpL5pMszZR4AoEDS94lZdMmpR+YhI7fvUGwBGQGj85DpwI7Ag5fgschNnRNtAEJ5
	 EXSOU+Vpu5p468XbHO3vy3GdYQe6R4CubgmVMLqk=
Date: Tue, 28 Jan 2025 16:16:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay
 <ogabbay@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>, James Smart <james.smart@broadcom.com>, Dick
 Kennedy <dick.kennedy@broadcom.com>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Ilya Dryomov
 <idryomov@gmail.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens
 Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Carlos Maiolino
 <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel
 <sre@kernel.org>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Frank Li
 <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede
 <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Henrique de Moraes Holschuh
 <hmh@hmh.eng.br>, Selvin Xavier <selvin.xavier@broadcom.com>, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, cocci@inria.fr, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 00/16] Converge on using secs_to_jiffies() part two
Message-Id: <20250128161643.289d9fe705ef2fdba0b82a52@linux-foundation.org>
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_161648_522867_417C3775 
X-CRM114-Status: GOOD (  14.36  )
X-Mailman-Approved-At: Tue, 28 Jan 2025 22:24:42 -0800
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

On Tue, 28 Jan 2025 18:21:45 +0000 Easwar Hariharan <eahariha@linux.microsoft.com> wrote:

> This is the second series (part 1*) that converts users of msecs_to_jiffies() that
> either use the multiply pattern of either of:
> - msecs_to_jiffies(N*1000) or
> - msecs_to_jiffies(N*MSEC_PER_SEC)
> 
> where N is a constant or an expression, to avoid the multiplication.
> 
> The conversion is made with Coccinelle with the secs_to_jiffies() script
> in scripts/coccinelle/misc. Attention is paid to what the best change
> can be rather than restricting to what the tool provides.
> 
> Andrew has kindly agreed to take the series through mm.git modulo the
> patches maintainers want to pick through their own trees.

I added patches 2-16 to mm.git.  If any of these later get merged into
a subsystem tree, Stephen will tell us and I'll drop the mm.git copy.


