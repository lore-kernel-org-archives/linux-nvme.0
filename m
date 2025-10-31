Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA8ACCFA02
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 17:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H2gJ+R3dxcg9oaIm0n3G+xeqBE2dv2VwFRsTo9tGfA0=; b=0UiEw6tQ2KK0ucK63AebZWpqBb
	bVZ0l96QR8tbEPe/Q2aQvDQBedRAbdcP9QkA/7Yz094LL8wC9GPWMbv7AaL7G41ZBHySUFJ68r1TT
	940QaQYjNFUQP3aM3r6cJsoS9q0Vu7EwsQjoPIVH5P5k8EQkZi0pL2KBZDQ3jg80HMcHKORGA05rw
	kS8K9+0yB2xK4NtahxYKIAuOn+EwR9MdrFs1SiVI/3MXJ+vrI6XJmq9qvEJLUwrIPmIL2E/JRlSd7
	qeUvgte+tVHYA71IMYOQmM8Do6rTOgkv66Yqq+Mdmd+IWcQDcFtJQSqepw+59cmQSbUJArvdeY2YQ
	azEhhz6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEtMC-00000006aRW-0iGJ;
	Fri, 31 Oct 2025 17:56:12 +0000
Received: from 004.mia.mailroute.net ([199.89.3.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEtM9-00000006aQi-3WgC
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 17:56:11 +0000
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cypYz73RCzm0pK5;
	Fri, 31 Oct 2025 17:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761933365; x=1764525366; bh=H2gJ+R3dxcg9oaIm0n3G+xeq
	BE2dv2VwFRsTo9tGfA0=; b=rT28JTWZ99TOZeuVLHnbuiww9kMqasyX8PYMeefR
	E7vPo6R6ZeeCK8Hh09MEp3ihMVqImaZndPHWHNjBXjNngQGj9NtRCNCqsnkpFMV1
	44b/RaTaB+4ASNlTp4uk3aMu2Bg+1DaAtkJ0aRIircAlyJg3JN/+AY0x2Fe9k05w
	PFTir7Cf5L0v2ZMEtVG951wdbJAtWuxhxVSiGYNROtEnb8pkNpjs2xTYi8gaT0ed
	HCvdoynO8W0ZnaacVvmv1FRJTH/Pqdr2j1QdPvwDP7DalxFIabiX0ZAaUaqlxNxs
	Tndh5RtstAX7aOxdVPNIZXmE8ZSXCQcwGWic2k/4IU11Gg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PfNpY8yMIsmy; Fri, 31 Oct 2025 17:56:05 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cypYj0bQZzm0ytR;
	Fri, 31 Oct 2025 17:55:51 +0000 (UTC)
Message-ID: <a25bfd8a-42d0-4f5e-8478-892d8c9c0127@acm.org>
Date: Fri, 31 Oct 2025 10:55:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] block: cleanup blkdev_report_zones()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-3-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_105609_957577_53F3E971 
X-CRM114-Status: UNSURE (   7.08  )
X-CRM114-Notice: Please train this message.
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

On 10/30/25 11:12 PM, Damien Le Moal wrote:
> The variable capacity is used only in one place and so can be removed
> and get_capacity(disk) used directly instead.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

