Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E58CD11DD
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 21:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/FzxR3EQc4bUd0qSMda+6BBxhFru4bnbB4Icj8JXxb4=; b=sPmc9xhSSIc3aPbf5uyQLKpG5q
	ab4L7QEImeXb5NwB0tHnufCYgZrpKlHjcyIqBe8ldg7W6mkxC1H5dKYBtmlhHaePhLTv7CEAi1ed7
	ZXtFuYawo/97QoFZDmQA8fcf9pRlyQFhHt3EqGdfFft0cnIJOAbml/TPvh6YYVPBYOnmC8TC8yTSk
	+ByUXybIrSPmmQ4kjgf4063tOQiGXltkUFghlK3CeTo+QriTlvRpXYLCC9jATiqLQWug+D2pC1z1o
	qKiTzPgmqJTO1gi/kIKMI1+2LXQkz74k97R43WaH/EAw/RJDZ0Z81oiM59lILm9lKiJnuBpj4Z8yb
	EJkg0biQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpxMV-0000000FmjN-2BZZ;
	Thu, 28 Mar 2024 21:32:39 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpxMS-0000000Fmiv-03rV
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 21:32:37 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V5GwM1q6Hz6Cnk8t;
	Thu, 28 Mar 2024 21:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711661552; x=1714253553; bh=/FzxR3EQc4bUd0qSMda+6BBx
	hFru4bnbB4Icj8JXxb4=; b=ZSz9BCw5QdTAh2NXrcz+D2utETF/kvLRO+rYKpyQ
	hoYHSB3q4krTYXDuhkayArIz5h0H2uRsTTKhzSu2JzwDgZjkzQqIgYO1bcNSDnXd
	2WH56+PkiWMoOGHg/HHcTETw0WIELxYRTnOm8ADsnTjvcoiqF647MlvhfKnnyU1R
	DhlEmOKiWJWgoVNEyMMkAiqtIBHXR1Sh7af/nupqLtt2VoTvUA6h/gpACaRICf4x
	2WQ1abfJi4ubKLt71JOWGqG3rYPtuqxKsCS7jXs8bWRjelzDC829b/ihFbaa1AH2
	SBI8kz4q527FEYS8PBotqznnh/k9R41/UbHLDjhpSsNdXQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GxUt2PxOL9LG; Thu, 28 Mar 2024 21:32:32 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V5GwG62Ggz6Cnk8m;
	Thu, 28 Mar 2024 21:32:30 +0000 (UTC)
Message-ID: <0bcd3fee-fc80-4efa-bb2b-eb9e141dbfd6@acm.org>
Date: Thu, 28 Mar 2024 14:32:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/30] block: Introduce bio_straddles_zones() and
 bio_offset_from_zone_start()
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-6-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328004409.594888-6-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_143236_095867_153FBC21 
X-CRM114-Status: UNSURE (   7.80  )
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

On 3/27/24 5:43 PM, Damien Le Moal wrote:
> Implement the inline helper functions bio_straddles_zones() and
> bio_offset_from_zone_start() to respectively test if a BIO crosses a
> zone boundary (the start sector and last sector belong to different
> zones) and to obtain the offset of a BIO from the start sector of its
> target zone.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


