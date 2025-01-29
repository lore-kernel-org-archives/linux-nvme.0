Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B5EC02194
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 06:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:Cc:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wht2thRDahYYxR+tegBEk8fX7Ubl7UHYL3NLzUC8OjY=; b=1CBYF6IENkq1zfUj0R+kWoybdk
	eGZrNjsAh1phg6cnD5EXoRh0X2576gJSX2GX3jFtbMghIGMdDE172dRpKBYQp1QCY9WJDt96wBA++
	ny0PiGSFDUUg45MUesfqrTh77hCShHI58RkWeXHShvH6xBHSIkwwUO++EpbLV/Gz1d96Uc6Z3K1Op
	dAvrDhZL1VfyVVXP12g77Mfqi12csLfCdheqVwgT9SjO9eVqW3vY+KeQa8toA8XtkNkEi2gQUdfDU
	lKdrVPsjjCMeK+Y1eWOY0IeAf/nAwwMJ4LEMgDufJWn0Tu/PSR3xGcCcpkhSIkQUGkMVs/EAJpe/B
	ksFRFUmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1td1VH-00000006P1D-0hVv;
	Wed, 29 Jan 2025 06:24:47 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1td0H2-00000006Kjx-3ezN;
	Wed, 29 Jan 2025 05:06:02 +0000
Received: from [100.65.200.247] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id BF2B7203719A;
	Tue, 28 Jan 2025 21:05:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF2B7203719A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738127158;
	bh=Wht2thRDahYYxR+tegBEk8fX7Ubl7UHYL3NLzUC8OjY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AFX9oF9pTu72L24VZYqKx9K3J6cjX75OWwM6bx5F//N6XwqpIMkYxe0t1yv/1uANn
	 K7CYPXdux4/ltP2jazP0+UvJCsUaSdS3dhpnc4wskhaa9xzVe+3duJMghpWbik88tx
	 7xoRplm16e8Caydkk6cw2Nsk6naPDQhd3Kt6qY7Y=
Message-ID: <2402812d-b818-4d1b-9653-767c9cd89dda@linux.microsoft.com>
Date: Tue, 28 Jan 2025 21:05:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cocci@inria.fr, eahariha@linux.microsoft.com,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-xfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 imx@lists.linux.dev, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, Carlos Maiolino <cem@kernel.org>,
 Chris Mason <clm@fb.com>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 David Sterba <dsterba@suse.com>, Dick Kennedy <dick.kennedy@broadcom.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 James Smart <james.smart@broadcom.com>, Jaroslav Kysela <perex@perex.cz>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
 Josef Bacik <josef@toxicpanda.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Ilya Dryomov <idryomov@gmail.com>,
 Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nicolas Palix <nicolas.palix@imag.fr>, Niklas Cassel <cassel@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Ricardo Ribalda <ribalda@google.com>,
 Sagi Grimberg <sagi@grimberg.me>, Sascha Hauer <s.hauer@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>,
 Selvin Xavier <selvin.xavier@broadcom.com>, Shawn Guo <shawnguo@kernel.org>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Takashi Iwai <tiwai@suse.com>,
 Victor Gambier <victor.gambier@inria.fr>, Xiubo Li <xiubli@redhat.com>,
 Yaron Avizrat <yaron.avizrat@intel.com>
Subject: Re: [PATCH 01/16] coccinelle: misc: secs_to_jiffies: Patch
 expressions too
To: Markus Elfring <Markus.Elfring@web.de>
References: <20250128-converge-secs-to-jiffies-part-two-v1-1-9a6ecf0b2308@linux.microsoft.com>
 <565fb1db-3618-4636-8820-1ca77dad07a2@web.de>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <565fb1db-3618-4636-8820-1ca77dad07a2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_210600_961556_4657EA6B 
X-CRM114-Status: GOOD (  17.41  )
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

On 1/28/2025 1:02 PM, Markus Elfring wrote:
>> Teach the script to suggest conversions for timeout patterns where the
>> arguments to msecs_to_jiffies() are expressions as well.
> 
> I propose to take another look at implementation details for such a script variant
> according to the semantic patch language.
> 
> 
> …
>> +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
>> @@ -11,12 +11,22 @@
>>
>>  virtual patch
> …
>> -@depends on patch@ constant C; @@
>> +@depends on patch@
>> +expression E;
>> +@@
>>
>> -- msecs_to_jiffies(C * MSEC_PER_SEC)
>> -+ secs_to_jiffies(C)
>> +-msecs_to_jiffies
>> ++secs_to_jiffies
>> + (E
>> +- * \( 1000 \| MSEC_PER_SEC \)
>> + )
> 
> 1. I do not see a need to keep an SmPL rule for the handling of constants
>    (or literals) after the suggested extension for expressions.

Can you explain why? Would the expression rule also address the cases
where it's a constant or literal?

> 2. I find it nice that you indicate an attempt to make the shown SmPL code
>    a bit more succinct.
>    Unfortunately, further constraints should be taken better into account
>    for the current handling of isomorphisms (and corresponding SmPL disjunctions).
>    Thus I would find an SmPL rule (like the following) more appropriate.
> 

Sorry, I couldn't follow your sentence construction or reasoning here. I
don't see how my patch is deficient, or different from your suggestion
below, especially given that it follows your feedback from part 1:
https://lore.kernel.org/all/9088f9a2-c4ab-4098-a255-25120df5c497@web.de/

Can you point out specifically what SmPL isomorphisms or disjunctions
are broken with the patch in its current state?

Thanks,
Easwar

