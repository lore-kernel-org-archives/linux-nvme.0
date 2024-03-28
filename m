Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34692CD11DD
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 21:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ksg/DMS1bxH4ci9zDHJu3QBPaiyJrb+/OpfKms9PbmU=; b=LBCodGA53oAwMDVXVsrWoEVRY2
	Ys5KXlWq1IBNvNnsQi0LDyHox32PN+FBRblSySbdxS/ePCfTEmmvd4jedAgPJf158P7T7yQKr2tPl
	F6SnXBGr+JT/so9IfBfqVLk/zyc5DUQjxiqBwCbwyJ8LY1W4U7ongDrbL7W3mOd2F1bGpbjImDMSg
	6cZSh9A11COOOKNiYezpQ02myzOx8e3ukE7sd4sgNQ6jvlHPdHAsc3RjfWsVmitK04NsUWoKU7BLH
	vqLmugCabDc805ZpemBxey3HU6wipiikx0Y5lTcepHK/F8JXR/bmq+XHp9db0ZQ9ZjV7FfZ4OjDoL
	YAEieYgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpxLy-0000000Fmdg-2bkj;
	Thu, 28 Mar 2024 21:32:06 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpxLv-0000000Fmd8-0FSH
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 21:32:04 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V5Gvk4twjzlgTGW;
	Thu, 28 Mar 2024 21:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711661520; x=1714253521; bh=ksg/DMS1bxH4ci9zDHJu3QBP
	aiyJrb+/OpfKms9PbmU=; b=kj7rSatTaqYNmgtdm7OdbCpNUs3WbpN0DUznjiMI
	s25jK7EI3aiZgMT+w+TGuNIa6d4iy4PVrNtfU/ytvsKG40pZZkfioMFIhGfSRAR0
	kvSydIlwugESGpuRfd7OTvDZ0hvKV4EfXJfh22UsbOCzoZ+NcYXgPGYlbCCmNeq6
	wzC3HYFs8MLCbBhO5XAsRJUuJToomSn0TVHCc/BPEHLLsKPn8DuRvGX5jNngYB5i
	zXN5ZQCj1asx2muF1wdXtM8PNEtd7Rh2gANKYufe083lv2AW19/0+t1jGQ9z7OyC
	5Q1oKxt/Cb2O3HptwWDJGSYOhm1UeYQsQRtHcAyNf1ONzA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id d8a6biSl8T5g; Thu, 28 Mar 2024 21:32:00 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V5Gvf5VxCzlgTHp;
	Thu, 28 Mar 2024 21:31:58 +0000 (UTC)
Message-ID: <44eedc5c-a5be-4e60-94cc-c22e7a187ce2@acm.org>
Date: Thu, 28 Mar 2024 14:31:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/30] block: Introduce blk_zone_update_request_bio()
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-5-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328004409.594888-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_143203_144553_5B442E0B 
X-CRM114-Status: UNSURE (   8.81  )
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
> On completion of a zone append request, the request sector indicates the
> location of the written data. This value must be returned to the user
> through the BIO iter sector. This is done in 2 places: in
> blk_complete_request() and in blk_update_request(). Introduce the inline
> helper function blk_zone_update_request_bio() to avoid duplicating
> this BIO update for zone append requests, and to compile out this
> helper call when CONFIG_BLK_DEV_ZONED is not enabled.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


