Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8E5C27C7B
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jun 2024 06:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R91Zz7Je/kXVvV4yGhS2jcSZI0CU7Wn5OacMzRhIuSM=; b=5AgaD9gyK5WUxbVEO5sP7vsIBk
	zUEnVoznQGICqyS02rw0U38G+lEjuWDaGQ2hEiqqR2TdCXP0SdH8/7MG1nnhXM5zoZeWJ2GpgIXTB
	Ji7pJvLnJg9J/hPkz+lNrK+Qo+TdQsc1U3tOdtdhdtZ89PMWFouc1/BZywFFDeh7wLbFdItwcyMCu
	AwPB9FjT3MIS9TZfaOTDhSGlH5pQ3rP7AGoU9zSXTU+YqglbyoV5uSIKCdIBF+OKtF49Nl+56t9gn
	fb014VoRmySHpYlOyz+sVW9sniBEDcGISwi9sPxyLtNDv5wP6gATTTYvYbG09e19453qkIc7YrGGy
	5DMbnzgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ5Zu-00000009Lko-0ltX;
	Mon, 17 Jun 2024 06:10:54 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ5Sw-00000009Hp2-0bEq;
	Mon, 17 Jun 2024 06:03:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2D34ACE0E51;
	Mon, 17 Jun 2024 06:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A36C2BD10;
	Mon, 17 Jun 2024 06:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718604219;
	bh=m0CKH+FHwbkUOr+sSrcVkW5ESZFXp5kIa1//vjrk4yE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZHL4hpDIzus9MORWkAbgDJINc4LVHx93lSfKixSkm6WuLxyXO8kkYM44k+wcOnr5y
	 tkFWuqAKw955Q/rvEo4d1MS5n/NwL4TdN4ssl8cV7ZAZLbnGhDKwhC73QRhgwv+NZq
	 4MHo4ahMA2gZVzsFtyj1OAL5yJiTS0PIsFOfjpr6Q4Iz0vizRFUgFcQcYzSr+vYOlU
	 9makxthgJ0C1BEmV0I9GbD23VHSGMav9AQ29gAEuujqqpGZAlwMM1nxM2wawtGe3Za
	 Rfe2pF85RFEJcZaeOU4UkFt4BeHCBkbgQEQvS0KKa82U3uwq4hheAWgp20LXEFXakj
	 o5wuVRw+MEylQ==
Message-ID: <bf52121f-38f2-4789-b545-7c6ed0fe55b2@kernel.org>
Date: Mon, 17 Jun 2024 15:03:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/26] sd: move zone limits setup out of
 sd_read_block_characteristics
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Richard Weinberger <richard@nod.at>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai3@huawei.com>, Vineeth Vijayan <vneethv@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
 drbd-dev@lists.linbit.com, nbd@other.debian.org,
 linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20240611051929.513387-1-hch@lst.de>
 <20240611051929.513387-3-hch@lst.de>
 <40ca8052-6ac1-4c1b-8c39-b0a7948839f8@kernel.org>
 <20240613093918.GA27629@lst.de>
 <5a697233-0611-459d-b889-2e0133bbb541@kernel.org>
 <20240617045356.GA16277@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240617045356.GA16277@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240616_230342_572670_3FC5FA98 
X-CRM114-Status: GOOD (  10.97  )
X-Mailman-Approved-At: Sun, 16 Jun 2024 23:10:52 -0700
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

On 6/17/24 13:53, Christoph Hellwig wrote:
> On Mon, Jun 17, 2024 at 08:01:04AM +0900, Damien Le Moal wrote:
>> On 6/13/24 18:39, Christoph Hellwig wrote:
>>> On Tue, Jun 11, 2024 at 02:51:24PM +0900, Damien Le Moal wrote:
>>>>> +	if (sdkp->device->type == TYPE_ZBC)
>>>>
>>>> Nit: use sd_is_zoned() here ?
>>>
>>> Actually - is there much in even keeping sd_is_zoned now that the
>>> host aware support is removed?  Just open coding the type check isn't
>>> any more code, and probably easier to follow.
>>
>> Removing this helper is fine by me.
> 
> FYI, I've removed it yesterday, but not done much of the cleanups suggest
> here.  We should probably do those in a follow up up, uncluding removing
> the !ZBC check in sd_zbc_check_zoned_characteristics.

OK. I will send that once your series in queued.

-- 
Damien Le Moal
Western Digital Research


