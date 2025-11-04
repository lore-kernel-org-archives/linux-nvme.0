Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2E4CCFA04
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 20:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hd5WRC5q73BCc88/cX72o+WZOdt8iG1dF8beT1jc//4=; b=u30SUXIUGVVBr8MxfEGkktEiar
	pI+u1RnVl1/3tm5FwjM7JBfNqaLIe9mVGeo7Z1HtxyWkh+LZ2UjcoR6ri/92cR3AAyUqTqTErQw44
	yN3KvsaktG1F3liiT1ja3XF1K8EF/55RdZbnPz1aaCqSZ7jKEeJ/LEsDVkkPtdx+A3d2DqmWLmLPO
	7uMJ5a+fBSiQ3jpqryhFZp0QFlIUv7lbuVADPV1VZimGKtBXMqEGvWuKXabWkZN36rElByG2YE/aB
	JXP6bP6AmfjuMUsO5Zx5b3Ys+KjssQXE6XgSu7IAZPAD3noGsbNC/q72fizc6JQ1/kQAeq1yMNZ2I
	OZqbluJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGNmB-0000000CYoD-0kKi;
	Tue, 04 Nov 2025 20:37:11 +0000
Received: from 004.mia.mailroute.net ([199.89.3.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGNm8-0000000CYnd-0xRq
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 20:37:09 +0000
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d1Kxr66nZznDrCk;
	Tue,  4 Nov 2025 20:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762288622; x=1764880623; bh=Hd5WRC5q73BCc88/cX72o+WZ
	Odt8iG1dF8beT1jc//4=; b=njyrOopWTof8U96TrrWMp1a4Efg7XVUfLDtQYyzb
	aTMFdUJX01Eu6nU3f0ycgIQ5A43cI+9q+eSogfozr65UTP/B8IKkmDal9zYZTdTC
	xn5n1dVPMj/UYaFV9EZISUSEPAfoTT+J3gsGtepGxTdc4WtilYiIYItT4hOLRxX8
	fnvPSrkzoSDif2AUDTiKSs6bSzBN7uXecCLnD2g8pYeQcj5dI+dAT1gW/c4+0MaE
	DZKyAR+CreJGcVkEpKm3pa/Y2LHj3iVAtAXgTnfyF3hmbFZ/1h4jLlPD2glv3Eye
	oOFphoXnwW8KN42ignT3IE+q+Xa9zzo+tkZ8D3rkbzrpIQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9hBJWyN-oUgM; Tue,  4 Nov 2025 20:37:02 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d1KxY3VgNznDrCX;
	Tue,  4 Nov 2025 20:36:47 +0000 (UTC)
Message-ID: <46fb6d7e-e3c9-48fb-ab2e-f432df9f9c05@acm.org>
Date: Tue, 4 Nov 2025 12:36:46 -0800
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
 <0cb7eefb-4501-47e8-805f-6e8737ca6bb5@acm.org>
 <da7e8c3e-49fe-49bd-9642-3b0ae67a3503@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <da7e8c3e-49fe-49bd-9642-3b0ae67a3503@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_123708_358993_5B95EFBB 
X-CRM114-Status: UNSURE (   8.88  )
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

On 11/4/25 12:13 PM, Damien Le Moal wrote:
> As I said, I did. See the comments with the BLK_ZONE_COND_ACTIVE condition.
> If you think that is not enough, I can cross reference tht in the comment for
> BLKREPORTZONEV2.
The current documentation requires puzzling some pieces of information
together but this is probably sufficient.

Thanks,

Bart.

