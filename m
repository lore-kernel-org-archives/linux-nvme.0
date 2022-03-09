Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E78C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 08:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NsvCXShMMOEJSmHvjjQj9ZAk3nnieok0OQ6NOg1ZcE8=; b=pUYoEiQo7BtVgAjSmPScUKY3Gg
	upzAYorm/jafcSV6lzAapqkFp9LmerwhOyH1vFbJNdlAGZrAli+5H9NxhhIOi6L6cKHXrj89qKhCW
	5JiWmsyX29YIXgAbrgx+iFuECRCGdsbu0Wtzh6PUJe4PlmOgCW5NJuzkpMi6No71a1bAV//JvW5y6
	1PfdRbVlJzF29r/wqBiHANbHqyciXTK9gKYTHEcREQfrIRPCsJ5zYvXLlXMzOi7xSf2STCOKnvbhv
	lz+MkaFGo9hvkXBl2Le7PUKXVvQVaM6Xgmw0StWX1vm59uNrsw6axXjDraxoi1AlXtWg/bmtoKVtv
	V7AZ4JHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRrd1-007kOT-10; Wed, 09 Mar 2022 08:25:03 +0000
Received: from mx3.molgen.mpg.de ([141.14.17.11] helo=mx1.molgen.mpg.de)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRrcx-007kL7-Uq
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 08:25:01 +0000
Received: from [192.168.0.3] (ip5f5aef7a.dynamic.kabel-deutschland.de
 [95.90.239.122])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id EBC2361E64846;
 Wed,  9 Mar 2022 09:24:44 +0100 (CET)
Message-ID: <487079ff-356c-a50f-097c-45c4a968d44c@molgen.mpg.de>
Date: Wed, 9 Mar 2022 09:24:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint.
Content-Language: en-US
To: Manjong Lee <mj0123.lee@samsung.com>
Cc: david@fromorbit.com, axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-raid@vger.kernel.org,
 sagi@grimberg.me, song@kernel.org, seunghwan.hyun@samsung.com,
 sookwan7.kim@samsung.com, nanich.lee@samsung.com, woosung2.lee@samsung.com,
 yt0928.kim@samsung.com, junho89.kim@samsung.com, jisoo2146.oh@samsung.com
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220309133119.6915-1-mj0123.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_002500_184125_21677D01 
X-CRM114-Status: UNSURE (   6.83  )
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

Dear Manjong,


Am 09.03.22 um 14:31 schrieb Manjong Lee:

Just a small note, that your message date is from the future. Please 
check your system clock.


Kind regards,

Paul

