Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB74E77188
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 10:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BvZHaclgLoxcp9vK/QHTIvJtmhmJreaGsDh9XJetxac=; b=wfksPFonMEBHzc8XEjO/gTFWIi
	JjXKvK+Y6ospvjvJKbdTZPxfaVgGC53NJ601vbcM37YO2vPKBdsW6YJeHLGAuwmqpGILP562bp01g
	8HiU+QSiEuxu7xaHYmjup481pGJ+a1vb9wcBUhq+CcDofuAcu4cZWvlIY64ChmKK2aO/6FJBTyBd7
	8PTHY6sKXE4Su53qmCXFekjyBJZpjiIRpQvtkYaAWDLS26Dw7G5m+RRdJqtl/JluI4iuj+BpQ11HU
	VCfokyznzeiuIpQ3AU0bbG/f/gQEeov8mJdiiFgCyj9hNbvq6VHj0gVkBF/4r7044pwTL13/6obhe
	iJ4zEGyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWBpi-0000000ErSP-3Is9;
	Fri, 10 Jan 2025 10:01:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWBpg-0000000ErRM-2QqK
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 10:01:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 481FA68BFE; Fri, 10 Jan 2025 11:01:32 +0100 (CET)
Date: Fri, 10 Jan 2025 11:01:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 05/11] block: add a store_limit operations for sysfs
 entries
Message-ID: <20250110100132.GA11632@lst.de>
References: <20250110054726.1499538-1-hch@lst.de> <20250110054726.1499538-6-hch@lst.de> <79d85a4e-57c3-454e-a65b-d2a3764eaf0c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79d85a4e-57c3-454e-a65b-d2a3764eaf0c@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_020136_758578_8559F6AD 
X-CRM114-Status: GOOD (  12.39  )
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

On Fri, Jan 10, 2025 at 09:56:35AM +0000, John Garry wrote:
>> +		lim->flags &= ~BLK_FLAG_IOSTATS_PASSTHROUGH;
>> +	return 0;
>>   }
>
> BTW, this function seems to duplicate queue_feature_store(), no?

That operates on lim->features using BLK_FEAT_* values, while
the quoted on operates on lim->flags and BLK_FLAG_*.


