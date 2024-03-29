Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C90C6FD1F
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Mar 2024 18:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Luk15JfJt4tSBUDO/lIjil5U4uWJ6kI3NEcDIpjaZ0w=; b=lBsNSm5LOOmuGr6ZPH3uVgcUrM
	2mpOy/bmQqUGiNyQr3ZwnldwfpVbXGsyhPpjjPQRqow36v8pDEs5zJl8uF0rd+v25yyqE0+rpiWPq
	I4EOXaU0jNzMi8MRQWwaG4tdi+1rYbrfVJJEJkwjDAHEXa3bzIret1nVGciVEMKdCzc20Z641jNp/
	Cemf2VZNOxdlfsM+vcO1LfxdoSn6jykvlcFaHLEQhtd5LMaPnaqQT2paczZW83bdBOS2FgFGf6GNr
	+mf+7tjZUrgcnTL3NFWDtKp3EK0YmUcNUrrcC6a6AoeDmE8JJa79hHxtlSwaIiJWWfj0O98L0noYU
	/+Pq6Y/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqHNF-00000001evs-1qTc;
	Fri, 29 Mar 2024 18:54:45 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqHNC-00000001evG-07KD
	for linux-nvme@lists.infradead.org;
	Fri, 29 Mar 2024 18:54:44 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V5qMj4LlXzlgTGW;
	Fri, 29 Mar 2024 18:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711738478; x=1714330479; bh=Luk15JfJt4tSBUDO/lIjil5U
	4uWJ6kI3NEcDIpjaZ0w=; b=RDrJlwFcF7O73W64IAAXHSjL5fxvW/vKPTB/zrNV
	YuITZp3+mJoeMG8rI0AaXSMZJhEKOOSNy21snAK6llKhHsty99CPwA150updXZwJ
	PO6EtV0G6v3ado8mhZPra/HUl/yOu07Nm+8quDsoxJPUMALMCXAz6lAUcraErAF7
	ooxcu1iGbvMiG6is3YXCQVOaVp982aOxpjPI2FexbSvOCtFk6kH3BpQnYIy1Uw9y
	te+UpNl8umwzR9B54OcCdk1ACJHkMc9k7kWxQab0lCRN2ebroTYe9B0Ie2+fFDUL
	vCkkVX0zvxDpZYVsEjzC0/7h9w6bnus4n3ku9SnPsNlfFg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GV5JYmJTWhW4; Fri, 29 Mar 2024 18:54:38 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V5qMc2V1XzlgTsK;
	Fri, 29 Mar 2024 18:54:35 +0000 (UTC)
Message-ID: <bf23c77d-65b4-43a7-b173-7a5c2c6fc652@acm.org>
Date: Fri, 29 Mar 2024 11:54:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/30] block: Replace zone_wlock debugfs entry with
 zone_wplugs entry
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-28-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328004409.594888-28-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_115442_124962_C6F34A49 
X-CRM114-Status: UNSURE (   9.23  )
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
> In preparation to completely remove zone write locking, replace the
> "zone_wlock" mq-debugfs entry that was listing zones that are
> write-locked with the zone_wplugs entry which lists the zones that
> currently have a write plug allocated.
> 
> The write plug information provided is: the zone number, the zone write
> plug flags, the zone write plug write pointer offset and the number of
> BIOs currently waiting for execution in the zone write plug BIO list.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


