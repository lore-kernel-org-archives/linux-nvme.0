Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593EFCD8C8C
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Jun 2026 09:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dQj5Uv7t9KZulzKNARL/h1xIIEJfpiotu+ZxBAIVAjg=; b=cctJKYxTEXgi06f0T8UYj+a7Wy
	fDwLn/wxNZxNE7rGN5jwEM/UAQWXh1hoIeCTLTubPSIsi3rSwmnioUc3o690Z6Y7+wZSlPgbonT4/
	edU944hWRDe3s734Be6/vlMUfifViSJIVtKlGUM8AmpC0XpUcwBtNmMytC8c1yJToQRo6jvGKW1Y7
	4e9qd49aVG++W0SjjqV1Ng/vIsQcSw/9I96YwlR5RtovLni7S4EK/qmUlAmW/DURE3Jug7zdLPhxy
	O/7bm3+7xVUxsoQWvSfI0tGtmBO5GDyA2fFs4HzL6XuvfY8XiStlIp5vDzYGkvcoqg3IngqShmTFX
	Y9ev9t5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWA0B-00000002ArP-0FuV;
	Sun, 07 Jun 2026 09:41:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWA09-00000002ArA-45IL;
	Sun, 07 Jun 2026 09:41:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BDE5660008;
	Sun,  7 Jun 2026 09:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5D21F00893;
	Sun,  7 Jun 2026 09:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780825264;
	bh=dQj5Uv7t9KZulzKNARL/h1xIIEJfpiotu+ZxBAIVAjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jxXJyWkYAheaa+HAD8W5RsBp+eg4te2bRDyYEF6DSdeQ1CshV9RPk7PIAzpuVOQZO
	 7FPxskvJfzH6AI155IUpqWnSrarh9/JsM4RsQO/iQHgxNWt3DX3zDt0Sf9X++xjMUp
	 J/gduDQhC1bGsbB68D05l9hxN7jNWCLYGevAX/rVPZx7O1qAuVnpD9GjgwxHReSmRD
	 72BAfOCWd35ovJVFebpIFVkNx29DSm/8RHi+gpnbX8cZwlgJVAKpZgfT4GvgpDrC/X
	 Av9yP8PB6oetxT6lEGeVHzh69SggTN9AQ6m+x7TElCkLGvSTsYolN2f+UdzTVDeWfr
	 rqpya3isueNIw==
Message-ID: <6d6f0792-2fbb-4985-819c-87fa499da4ce@kernel.org>
Date: Sun, 7 Jun 2026 11:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-apple: Prevent shared tags across queues on Apple
 A11
To: Nick Chan <towinchenmi@gmail.com>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260607-prevent-tag-collision-t8015-v2-1-dc4ef4fb42bc@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260607-prevent-tag-collision-t8015-v2-1-dc4ef4fb42bc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 07.06.26 08:10, Nick Chan wrote:
> On Apple A11, tags of pending commands must be unique across the admin
> and IO queues, else the firmware crashes with
> "duplicate tag error for tag N", with N being the tag.
> 
> Apply the existing workaround for M1 of reserving two tags for the admin
> queue to A11.
> 
> Cc: stable@vger.kernel.org
> Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---

Reviewed-by: Sven Peter <sven@kernel.org>


Best,

Sven


