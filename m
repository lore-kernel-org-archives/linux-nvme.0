Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBBCC021A9
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 08:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:Cc:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CjdDB9uvZBBF3c03e9VylpCG5WkQPsjk1qSKlO3MQtE=; b=YDaDvQaHxHAyZgv9Apq+YoJam3
	KBC+DzGDDSk7IC/mwMzgBqt2W+pZX5BkVBVQ712B0NBURd0yrbJcqaKs0sTzdme7Zxd7K0gjMr1T/
	i+/Ua2BdHG5EK/Zwvs8iH5lYh8bNd6MNHEiobqZSO1uhBRePQpgH9swXGHQ3585NgSMOeIkkTB7rx
	FoNkqZDD0JqscLHrbWm5XA+2PJzXZ8qZ/Y32rWCXB+HYBKQ8XJE5PK9hviXoHTSlhgv4gH0O3xlRL
	QQtJKXPiXLXjU40FNqzhZbpdupKX9kKwiDLEEtc0tSv1nSM+ZPvPgdTWW0Y5jdUp0hc1aFRjIakT/
	kwiXEFHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkJFi-00000007Lct-2Q3o;
	Tue, 18 Feb 2025 08:46:50 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tidHU-0000000C44e-16M3;
	Thu, 13 Feb 2025 17:45:46 +0000
Received: from [100.65.1.94] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id D7186203D61D;
	Thu, 13 Feb 2025 09:45:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7186203D61D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739468742;
	bh=CjdDB9uvZBBF3c03e9VylpCG5WkQPsjk1qSKlO3MQtE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=MqwOKrlM0wNKTlUgCtpn9gJKIpfGiwVh9dHGNNF4ycPmXa/idcQ30iiksOd4FJJaH
	 jrqNCD9r00CbzdjGOPFOZ+MnFU6woy29/+YEkOfP14iTKCcgK64o8pGQaLxlVNUpHe
	 bIb4sXQD9rr6g8CsvFcC34/zgx+kxX5/LItW+SLg=
Message-ID: <8f80b65e-724c-439c-a094-4bfbb1e296f1@linux.microsoft.com>
Date: Thu, 13 Feb 2025 09:45:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Yaron Avizrat <yaron.avizrat@intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, James Smart
 <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>,
 Xiubo Li <xiubli@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>,
 Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
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
 linux-rdma@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 00/16] Converge on using secs_to_jiffies() part two
To: Andrew Morton <akpm@linux-foundation.org>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128161643.289d9fe705ef2fdba0b82a52@linux-foundation.org>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250128161643.289d9fe705ef2fdba0b82a52@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250213_094544_357915_2D85254A 
X-CRM114-Status: GOOD (  12.60  )
X-Mailman-Approved-At: Tue, 18 Feb 2025 00:43:11 -0800
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

On 1/28/2025 4:16 PM, Andrew Morton wrote:
> On Tue, 28 Jan 2025 18:21:45 +0000 Easwar Hariharan <eahariha@linux.microsoft.com> wrote:
> 
>> This is the second series (part 1*) that converts users of msecs_to_jiffies() that
>> either use the multiply pattern of either of:
>> - msecs_to_jiffies(N*1000) or
>> - msecs_to_jiffies(N*MSEC_PER_SEC)
>>
>> where N is a constant or an expression, to avoid the multiplication.
>>
>> The conversion is made with Coccinelle with the secs_to_jiffies() script
>> in scripts/coccinelle/misc. Attention is paid to what the best change
>> can be rather than restricting to what the tool provides.
>>
>> Andrew has kindly agreed to take the series through mm.git modulo the
>> patches maintainers want to pick through their own trees.
> 
> I added patches 2-16 to mm.git.  If any of these later get merged into
> a subsystem tree, Stephen will tell us and I'll drop the mm.git copy.

Hi Andrew, I don't see these in mm-nonmm-unstable. Did these get dropped in the confusion around
casting secs_to_jiffies() to unsigned long[1]? That has since been merged in 6.14-rc2 via tglx' tree,
and I have a v2 for just the ceph patches that needed some fixups at [2].

[1] https://lore.kernel.org/all/20250130192701.99626-1-eahariha@linux.microsoft.com/
[2] https://lore.kernel.org/all/20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com/

Thanks,
Easwar (he/him)

