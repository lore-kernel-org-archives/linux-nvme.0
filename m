Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E01CD1284
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 19:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qdf0hOCIsqICXNg/HmfX4nJquVLaNONycWsHwUiLeRI=; b=bn4VRT159MGSotkc07Rmr6tMQN
	DlOsDiVJCosoK8y8VSq5c8rKkOhRdVIvViAiV8sKiE+zWMvg0uUz1AfjP1+JAAqMr7KGmMgVlD8yM
	VQchgq8IrHk3BStUNJX/F0F8x7OD2VLLW6CrCkOZXgj8UW6bIl4uNw8Z2bDzO0IzbYlZzynj+Oihf
	tkPW6OKYMa3w9/Fbw8WRJwjvbdflrp70qtmADuWi2DY4R3MP8BnSdSKCdDdOEfjB+Cn+OqS7eZivT
	fFTIaFu6rd4NYOJwvLnP6/Pu3xhY1KKFg5P6uVm/19zRmrWk9dDSt6eGT56unbZyTB8POJ28ELGd5
	ZixeRvTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsSOY-00000003y2P-1dSH;
	Thu, 04 Apr 2024 19:05:06 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsSOQ-00000003xze-2f2p
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 19:05:00 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V9WJm6q9JzlgTGW;
	Thu,  4 Apr 2024 19:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712257494; x=1714849495; bh=Qdf0hOCIsqICXNg/HmfX4nJq
	uVLaNONycWsHwUiLeRI=; b=I/D4TLxF+fg0FHnVoMGoPznge8gJS08T6awXDBem
	JuikBakcZt7aZ3yepKwvgGq0xRkIRpFjxGKP26AgCJ3jdeAxqeVJJFqmxOp35tFA
	s8tLGEjICxaKlR4reewEkUVwW1Jqfx6o7e+++rzbTxGONHMG6UsGQPC8The9cwV5
	lZRoDbEa8Br07DfqTUSDGTf8sCPywK3mPN5EEU3CP5m/we01E1DjVQFYT6EcrPsH
	eYDh/nVRXlxShkXPCOzuN6xuCkZjiZDB1GAvAn/FdtiMA/foxd3s/ItjzbgDS9cC
	WrmFWn3L9kMRvKevWxR7cokIZQ/yEi2ozxr1qcTUnE6GSA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Bf1mq8KR3xRF; Thu,  4 Apr 2024 19:04:54 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V9WJg489fzlgTHp;
	Thu,  4 Apr 2024 19:04:50 +0000 (UTC)
Message-ID: <acd9961a-ed3c-43f6-94a4-b5b3df6ce9e7@acm.org>
Date: Thu, 4 Apr 2024 12:04:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/28] block: Fake max open zones limit when there is
 no limit
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240403084247.856481-1-dlemoal@kernel.org>
 <20240403084247.856481-9-dlemoal@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240403084247.856481-9-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_120459_441342_26DCAC22 
X-CRM114-Status: GOOD (  10.11  )
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

On 4/3/24 01:42, Damien Le Moal wrote:
> For a zoned block device that has no limit on the number of open zones
> and no limit on the number of active zones, the zone write plug mempool
> is created with a size of 128 zone write plugs. For such case, set the
> device max_open_zones queue limit to this value to indicate to the user
> the potential performance penalty that may happen when writing
> simultaneously to more zones than the mempool size.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

