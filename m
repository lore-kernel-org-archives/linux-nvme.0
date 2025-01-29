Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E88C0218F
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 17:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:Cc:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tZu7Aqdcq4BHW7QoklKujtbGCaxot/XApiLegvlW9Cg=; b=vNgxEvrZa1I2T2WzmFSovFyjNY
	2pdslOEslmfYGzIZ9+jaTjd5ZWSUt/iDgDyl1M0TeH4OMKncXswqy+w/3QQSxRrFBny5+fwN1/J12
	yIw/XPN0eaJ8VtCtYC1DcoDyE1SRnjcY0ymj5G0akVGQjzQq9cg9Jwc/LwJCmbZPyWcJF2908qtvE
	3Kc1d4ZBbj+v0Yge5v6YdtdNsyPVaGanXtMlMgbiiNkuJQ9GS8pBwtGK89ieYLeA3oXi7GKeoyeFk
	+GMg/Qo01yHxDMdBC7BI357cvlcCIBzlnVJbgXaAWXRLomrqUvnOfdqTMquAFiieioSX7Joi/gslD
	BGLde82Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tduTA-0000000B4i8-0mqH;
	Fri, 31 Jan 2025 17:06:16 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdCaG-00000007a63-2jYp;
	Wed, 29 Jan 2025 18:14:45 +0000
Received: from [100.65.98.224] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 28F3F2066C1F;
	Wed, 29 Jan 2025 10:14:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 28F3F2066C1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738174479;
	bh=tZu7Aqdcq4BHW7QoklKujtbGCaxot/XApiLegvlW9Cg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=aAf9IIr/I90cgqgEBczLilZ7bdtCYRLZiEJHEhBdKJpSoOCumeMDEGeLf0xioaxnU
	 Cxs0rQCB+cTOuTBJEpsGVDSTUnsyW+Sqnpdni5YRWUzescyOcAANxe89dy6cL7UnK5
	 9o+lRZL0v3hO8jHtI+YxGsr5kQTHif7tO+OZbuMk=
Message-ID: <670dbe5b-cf5b-4994-9a47-53b0b52a4b20@linux.microsoft.com>
Date: Wed, 29 Jan 2025 10:14:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Andrew Morton <akpm@linux-foundation.org>,
 Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>,
 Xiubo Li <xiubli@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
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
 cocci@inria.fr, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH 09/16] xfs: convert timeouts to secs_to_jiffies()
To: Christoph Hellwig <hch@lst.de>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-9-9a6ecf0b2308@linux.microsoft.com>
 <20250129052108.GB28513@lst.de>
 <3e4a8a44-483b-457a-b193-4119e4adfa85@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <3e4a8a44-483b-457a-b193-4119e4adfa85@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_101440_750104_C3F6541E 
X-CRM114-Status: GOOD (  12.86  )
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

On 1/29/2025 9:12 AM, Easwar Hariharan wrote:
> On 1/28/2025 9:21 PM, Christoph Hellwig wrote:
>> On Tue, Jan 28, 2025 at 06:21:54PM +0000, Easwar Hariharan wrote:
>>>  		else
>>> -			cfg->retry_timeout = msecs_to_jiffies(
>>> -					init[i].retry_timeout * MSEC_PER_SEC);
>>> +			cfg->retry_timeout = secs_to_jiffies(init[i].retry_timeout);
>>
>> This messes up the formatting by introducing an overly long line.
>>
>> Otherwise the change looks fine.
> 
> I'll fix this in v2. Thanks for the review!
> 
> - Easwar (he/him)

Andrew seems to have fixed it up in his copy, so I'll skip this change
in v2. Thanks Andrew!

- Easwar

