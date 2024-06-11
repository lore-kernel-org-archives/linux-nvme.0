Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49D0C25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 06:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mcIAj+YUEAEGlNaiSbkHdz118C/rH7oCL9C+XeYbJy4=; b=uwP7+RwfYbIadsnf/eSt99psdO
	/XAWSb+axIp6RNN0dWBZUYoZRrqp/WA8170zUkvwPgA/khovq+QM94WScnfVYTIbAWO62dppm5VV1
	e0oWt/1vxOR5c8FiMf7i9iQdDtgwS3x4pmUOTcfRKBLFXqn3VKQ1ctUOr3OtMbwdGrlqo2oHwdnid
	AWNVp0/IpP+Id+EYxQIhqWOu4AkhGelQ/tmaakvyOXsmbF9rj2bGSMewIO98NhvOZfO7fwzOV+zEt
	kPKN0cS+PA7DY55M1WTETod2ukDjIh351pZOHRJeNpbDyTbIptqKP0hB3gqlWknuQysbcF5KF22df
	TuC4a8mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuqx-00000007eMV-35J4;
	Tue, 11 Jun 2024 06:19:31 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuSY-00000007aa8-1hly;
	Tue, 11 Jun 2024 05:54:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 91F99CE19A1;
	Tue, 11 Jun 2024 05:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FF9C2BD10;
	Tue, 11 Jun 2024 05:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718085255;
	bh=ImOyYBG3xCcX0n3tLvSbs6xw/kdWptb6Do6trOqK4QA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qHFHpGL8aUbN9wv5klAImzJ5jjK0oiGT8U4BTD8xfsG5jiCOpGSUv7Km3WvNqtPCD
	 6j1nrDjh7PhyALjuNQNHYkKLmYYq6Y1xffYfB0MxJDe2yW8SOyNDdlvw/znXF9eZc8
	 KT4CX+clUIQtduOC06IcHkCGn74lBXgof4aV9GT8PsAx4EZCRJSboZ+IHz3mWN+raN
	 KotqG4Gp62inAvWnPIr4JchEXO3PbNevMpTBNuCyAHk0M6HQGrIQYLuf6JcDaVG6mV
	 fVlgaG9YnpTo4YxUBgRoQVMO/dLvogh2Z6hk8kGRTiZh4LaBEnh8YlC7x62pw9weqZ
	 kWW9/78SoGctQ==
Message-ID: <c5524425-b2bd-40c4-bdc2-5b7e51ce6d67@kernel.org>
Date: Tue, 11 Jun 2024 14:54:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/26] loop: always update discard settings in
 loop_reconfigure_limits
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
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
 <20240611051929.513387-5-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240611051929.513387-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_225418_725662_00CA914B 
X-CRM114-Status: UNSURE (   7.41  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Mon, 10 Jun 2024 23:19:24 -0700
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

On 6/11/24 2:19 PM, Christoph Hellwig wrote:
> Simplify loop_reconfigure_limits by always updating the discard limits.
> This adds a little more work to loop_set_block_size, but doesn't change
> the outcome as the discard flag won't change.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


