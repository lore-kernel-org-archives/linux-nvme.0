Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1601D3E781
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 01:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oXbbBOYgxRNx4mkmJ6eWKcYg4/dxDNGT9i3CaGbjXmY=; b=c2FaZ7/fZNyxdGxp8/OzzQbmC5
	41Nxl9KQ+wT9VKjnwzL6t7GZ42YwBfpHsr4gbRLS7iLoJs8nn7Jh7+Gjw8gevlF26aEBoJ1wCY+Bv
	LijWe4bV94YaVu6VpnMblsvrlqrMrsfVyp59XX2ejjfo0ykM0ZBUGZwL9z/vqTfy54FxOeA0S6SoZ
	k9i8P428GEOXTH11XZu2wV32n4xo9uBsjMlT0xbQi+0YaHVJZ+Ndd3iwySs0JKYnwlIRnyKA9dMOz
	V9ueq5vXEsCJIwSZVk4FdlFZW2b6SC/UnZFq3jVs3HBQXi4ahLO8ek8L/8Gwz6vz5QJGLDE7uaiz+
	moPWFbCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8V48-00000001LHk-3buI;
	Wed, 06 Nov 2024 01:42:36 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8V45-00000001LGo-1ciV
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 01:42:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730857348; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oXbbBOYgxRNx4mkmJ6eWKcYg4/dxDNGT9i3CaGbjXmY=;
	b=ZftmgsAMu2ruavOQE8aDSqnSdknC3bArHQwqfkqcvC2GKcWXKsMlLosdV1MgPNEcYaq+S4N4w42iHQMZMbwOwWUDo6HcFIgAt2nA4JccIzPLMGAJxlNBlHSvTOBb8MzhoYUQDg2tULVR4w/j7auOmvyMI1O6mH0QZSHiamyPtN0=
Received: from 30.178.82.24(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIoJUkS_1730857345 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 09:42:26 +0800
Message-ID: <e5125a46-4fcc-450c-99a7-5a807989cf98@linux.alibaba.com>
Date: Wed, 6 Nov 2024 09:42:23 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH blktests v3] nvme/{common/nvme, 016, 017, 051, 052}:
 introduce def_nsid
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "dwagner@suse.de" <dwagner@suse.de>,
 "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20241031101455.29273-1-kanie@linux.alibaba.com>
 <uidk3q376j4rahmw5wnpnoycd7pb4nvgzr723okznlx3pkejln@hssxf773zv4q>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <uidk3q376j4rahmw5wnpnoycd7pb4nvgzr723okznlx3pkejln@hssxf773zv4q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_174233_671682_2B44139D 
X-CRM114-Status: GOOD (  11.12  )
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


在 2024/11/5 18:30, Shinichiro Kawasaki 写道:
> On Oct 31, 2024 / 18:14, Guixin Liu wrote:
>> Use def_nsid instead of hard code, the default of def_nsid is 1.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>> ---
>> Changes from v2 to v3:
>> - Fix 016, 017, 052 do nothing when the def_nsid is set to
>> biger than iterations.(Shinichiro Kawasaki)
>> - Fix "make check" error in 052.(Shinichiro Kawasaki)
> Guixin, thank you for this v3. I've applied the patch.
>
> Unfortunately, this patch caused some conflicts with the series "nvme: prepare
> for ANA support", so I took the liberty to modify this change. Please take a
> look in the commit after the modification [1]. If there is any mistakes, please
> let me know.
>
> [1] https://github.com/osandov/blktests/commit/87d4c0cb93f32b7d0798b9faaed6bb2b39d636a2

Looks like I'm missing to add "local nsid", thanks for modifing this.

Best Regards,

Guixin Liu


