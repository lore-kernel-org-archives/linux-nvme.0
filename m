Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F5CCCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 19:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EJw2W4R20I0tbP9KTHA+4Okev2/0KvJztiMzbhvTnNI=; b=GuUUOvarrlqhdXhG4d3tWH+1ly
	sOinIPGmXJYaV4mduMG+boYwqZ3bqOlRZ1niLpFBZUYLoITPVV9dLZzF1AbhmfMEEL3vA0tu2cT1t
	4UcdgRFJc4PxFHrWcz21aAEQNjOvVXofNvh+zel90aGMoY/IRKpUCC9Tu/G/Hvozw1rtnYSPQ8sOD
	I5xTWuRrv5J732I7+pMTgubsxc0stfTU1Gli+M7Vcx8Fo94osQK+U8lmJXwCFpYiX3lmeHOmRl2UU
	NyAAfVi/XOfGqJU5BC1o8dGTjlEh/7jou6Okbxn0iBB8ZJ8d0bCqop1gIurK1XL4WMl2gn/NztNxE
	tJod011Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGMHD-0000000CS6H-06We;
	Tue, 04 Nov 2025 19:01:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGMHB-0000000CS5J-43On
	for linux-nvme@bombadil.infradead.org;
	Tue, 04 Nov 2025 19:01:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=EJw2W4R20I0tbP9KTHA+4Okev2/0KvJztiMzbhvTnNI=; b=M1NjKbNVuEQaubWliyrqQQhBW4
	VdpkpwEvBAHIelepH8RK4ljwqigcChsI6Fuu5FjH0Pqs32bmFiKOx8IvzO3K7ekYXoGBdmIejx+ZD
	5GLIYARhOrZ1kHYX+mkBTL27fTRzhwW+bYsckZ1P6ZXQWRA7fwXP2PMW5GQwbV05DMe7T9px18sXN
	e91czu4Y4Q0v522vSEPGcimSY/1Pi0wmaRzDB3uV49Cd11gY2yCBuqe3kg8/hYo0V+mvEMVQ9Vbdh
	xqq01LFvotJ5B2MsdBkNhN9OGIvUMaT0wcdlwnw3ao3LaQrW+7Y8IgyvtLBECGM3LlCwyCSM62Jcp
	kOdTsCJQ==;
Received: from 003.mia.mailroute.net ([199.89.3.6])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGLPR-00000000gO7-1QEb
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 18:05:35 +0000
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d1Hpj6RDkzly6Vc;
	Tue,  4 Nov 2025 19:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762282843; x=1764874844; bh=EJw2W4R20I0tbP9KTHA+4Oke
	v2/0KvJztiMzbhvTnNI=; b=jl2qi6oNwA87r19QHd4bFtJjfr4Oj17sQMNvOQf/
	RhOyR0SYK/HZoqEHVr9wvC/wNUZ3OYoCrVChC4LCEm/umbw4ZKaTl9H/tD5hri+E
	RlAdb2J8XEwP1U0KfDJoEcaVcD/A+sz2aqCeTn9JTtAjcg/8g+4jF8RRypVPznDX
	jl4/eWdb4dezQf8mmXcSrYLMApLTdv3zGENS3zLDzjqhZJ3cKV52htqveEmWNzO9
	v91zGwYfZ8mghDT7lwawv60A62wi4zFveUDXWitoN2PpznE5/ZRkMXWZJMTfjdTm
	dCSfhuXAjpLY1bM8A4OlD3rq+gzjuRimgNpHBF6bsgJ4Qg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ktQnhIQwp04c; Tue,  4 Nov 2025 19:00:43 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d1HpQ08l3zm0XTn;
	Tue,  4 Nov 2025 19:00:28 +0000 (UTC)
Message-ID: <0cb7eefb-4501-47e8-805f-6e8737ca6bb5@acm.org>
Date: Tue, 4 Nov 2025 11:00:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] block: introduce BLKREPORTZONESV2 ioctl
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-12-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251104013147.913802-12-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_180533_558308_D2D358BA 
X-CRM114-Status: GOOD (  10.75  )
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

On 11/3/25 5:31 PM, Damien Le Moal wrote:
> - * @BLKREPORTZONE: Get zone information. Takes a zone report as argument.
> - *                 The zone report will start from the zone containing the
> - *                 sector specified in the report request structure.
> + * @BLKREPORTZONE: Get zone information from a zoned device. Takes a zone report
> + *		   as argument. The zone report will start from the zone
> + *		   containing the sector specified in struct blk_zone_report.
> + *		   The flags field of struct blk_zone_report is used as an
> + *		   output only and ignored as an input.
> + *		   DEPRECATED, use BLKREPORTZONEV2 instead.
> + * @BLKREPORTZONEV2: Same as @BLKREPORTZONE but uses the flags field of
> + *		     struct blk_zone_report as an input, allowing to get a zone
> + *		     report using cached zone information if BLK_ZONE_REP_CACHED
> + *		     is set.

Was it promised to add information in the above comment about the 
differences in accuracy between the two ioctls? See also
https://lore.kernel.org/linux-block/97535dde-5902-4f2f-951c-3470d26158da@kernel.org/

Thanks,

Bart.

