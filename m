Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E219EC433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Apr 2022 09:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zZk7l16/MP3GN7S6f0ZA7h1Oi7wmDAYutKc0u18uUic=; b=o2CDRllJWHJ6u236NwlLNK4Ijx
	rWH66wWI4UVwkhwGGXrG6k+7qqQI1e1v+f5Y3Sfu2A54KU2xIm4pzvdODrh3QCOvtq6CT44umyOi/
	ocZZ2oB6x0/tE+BZj9f7NkZ/F1Y4vq4G7/c5fN8hVMDH5IKZS4ro9G2mK2Dwq5nimv5u8CsoI6tc9
	EbGFpHi4HAX8DnclKnvN6CI4F4JcWSk0t16gtcYYhsXUJehVVtxutMIztyRm7HzvO7OcTsMmsHMt2
	ZozBCtRR0EFLlxl797YreO19sYTiQxxodV/jfDjZBhWU0eQeNYcQ68wkh+CY6iIuuyjTWxVdkDNbP
	AGT0Sqvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nd78Q-002eGG-GN; Sat, 09 Apr 2022 09:11:58 +0000
Received: from mail-m118204.qiye.163.com ([115.236.118.204])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nd78N-002eFb-Gy
 for linux-nvme@lists.infradead.org; Sat, 09 Apr 2022 09:11:56 +0000
Received: from [192.168.1.164] (unknown [222.20.98.78])
 by mail-m118204.qiye.163.com (HMail) with ESMTPA id 12941A205A1;
 Sat,  9 Apr 2022 17:11:46 +0800 (CST)
Message-ID: <33f34253-4418-e16a-89fb-92257749cf3f@kingtous.cn>
Date: Sat, 9 Apr 2022 17:11:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even if
 nvme_ms_ids_equal return false
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 axboe@fb.com, sagi@grimberg.me, kingtous <kingtous@qq.com>
References: <20220408051915.GA31955@lst.de>
 <ABwAxgCYBwe5Iq2fM1-8qqrc.3.1649398333597.Hmail.me@kingtous.cn>
 <20220408062210.GA410@lst.de>
 <7b59552e-196e-d06a-f057-aaa3e9432841@kingtous.cn>
 <20220408080721.GA2888@lst.de>
 <YlBSO/vH7DjE6kC9@kbusch-mbp.dhcp.thefacebook.com>
 <20220408160424.GB27746@lst.de>
 <21ac620f-d234-13a1-0de7-e3ec1b3272db@kingtous.cn>
 <20220409044351.GA17212@lst.de>
From: Tao Jin <me@kingtous.cn>
In-Reply-To: <20220409044351.GA17212@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQU83V1ktWUFJV1kPCRoVCBIfWUFZQ0JCGlYdT0hNTExNSx4YQk
 JVAhYTFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OEk6HBw*PjlREk4oTR4dTj8B
 LyIaCjdVSlVKTU9CT0JOTktNTE9KVTMWGhIXVRYeOxASFRwPFA4IVRgVRVlXWRILWUFZSUlJVUlL
 VUJDVUxDWVdZCAFZQUlMTUw3Bg++
X-HM-Tid: 0a800d97fdfe2d26kusn12941a205a1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220409_021155_760734_39745054 
X-CRM114-Status: UNSURE (   9.33  )
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

Thanks.

在 2022/4/9 12:43, Christoph Hellwig 写道:
> On Sat, Apr 09, 2022 at 08:58:27AM +0800, Tao Jin wrote:
>> Note that I'm using the kernel which customed by myself, which comments out
>> "goto out_free_id". It means "nvme_update_ns_info" will be called even if
>> invalidate ids failed. Because I can't do suspend operation if using
>> official kernel, which will cause my SSD directly invisible in Linux and
>> trigger ext4 error, freezing the laptop.
> 
> Thanks for the update.  This proves two things:
> 
>   a) the device is completely broken in reporting IDs
>   b) the reason why the eui64 changes after each suspend is because the
>      kernel is inconsistent in how it queries for the eui64
> 
> I'll prepare patches to fix both issues over the weekend.
> 

