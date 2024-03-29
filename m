Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89773C6FD1F
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Mar 2024 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g7Av2jin4sX0Cfb78/pBPBNfyidDPOykp9LCP0eWApg=; b=hTYVcv6EXdd4GfmEkbNc9nKgS8
	oyzrMTmfHm2o5VkJoCyUk99ehk24bfV5u41yZSiXqCPd1FuXGV3NnZNWErkpZOLjOmoTN5OWKoJz+
	WK6/nlNsPEIIdcox2l06HB76qIoXQo8aAyu6rcBIdH+CUuy6tnrcs5R6APRnJhC8fzp+SDhd3PltJ
	tuTcNgtWEFowRO3RJvfh/MUc/D3OWZYjMcoZ6sZeg4ytO3HIPcJcFHO/qW7yXpBV1d86y3SoVMK9g
	X0rOowok3iSxt4TwcR1LKQohGm6WZ0dTdzIfWWuEbCgdi7sza5XjWSN0zti7HX96Rbg5ANn/wejr6
	vLwRDAow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqHSh-00000001gyQ-2KRR;
	Fri, 29 Mar 2024 19:00:23 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqHSf-00000001gxM-0zPW
	for linux-nvme@lists.infradead.org;
	Fri, 29 Mar 2024 19:00:22 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V5qVD51PVzlgTGW;
	Fri, 29 Mar 2024 19:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711738818; x=1714330819; bh=g7Av2jin4sX0Cfb78/pBPBNf
	yidDPOykp9LCP0eWApg=; b=399cq4XgVFCAZleHjaMjkk4Dxz80eXehdQuOh3Il
	N/xxtb52kFk+EnmbeXSc55NK98tQrHiBX5qGwHPsGM7Wyfh+dJGkxU/kHwtgkqSu
	Jcp7xrkbNiHI/P+bEJxyL2BzvdY3t55N25/V2sOb/kHtsmF9t5FMmyJ6GpoCGQYl
	Bdr6EVgtt0lVBy7GowlZy+Sa0Sp8+6AdaYLngZNCbLh5tguBeX8M35tGr6pjgU4K
	ijBqqQekpzB1E1aYObWhiCfFMPzXmkUCGwfIootc1ALsLE3jf6m/Me+1TcA6QuWQ
	dRJ2z3PZdx9Asl0tjJROWVx0p2xYfseLBSlHN5NFx33drQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PaHJm4o6KFQU; Fri, 29 Mar 2024 19:00:18 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V5qV76jybzlgTHp;
	Fri, 29 Mar 2024 19:00:15 +0000 (UTC)
Message-ID: <17a9b0ce-1423-408a-8c70-767218572d64@acm.org>
Date: Fri, 29 Mar 2024 12:00:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/30] block: Move zone related debugfs attribute to
 blk-zoned.c
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-27-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328004409.594888-27-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_120021_349614_430B08FA 
X-CRM114-Status: UNSURE (   8.31  )
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

On 3/27/24 5:44 PM, Damien Le Moal wrote:
> block/blk-mq-debugfs-zone.c contains a single debugfs attribute
> function. Defining this outside of block/blk-zoned.c does not really
> help in any way, so move this zone related debugfs attribute to
> block/blk-zoned.c and delete block/blk-mq-debugfs-zone.c.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


