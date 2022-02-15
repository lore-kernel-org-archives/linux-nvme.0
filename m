Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68508C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 06:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3RJ7FqeJ5y+5UiQ2pCXE7H/0C83iTb1vVR/yQS9RzJo=; b=iW6an6TAoeUipZ5VK9+2NU1Sdg
	McIBeL62uHLC6FA4eXiQyJDrY94wRBhE+/cGnojmA/ZVlxWKCqrZNQM7X1IvtKG6udmSwTpFvjCSf
	Etr/2qAf6kukIaolpgtQgzilbjFSQZ9ASz0Q0Hm0zQaHiB50lqyXWyboZiaQZ2NgWL42yyA6Az+s7
	czi1qr60KiaFPEI/YHcsCY4rNaZiNSvNZ91h3TCopkosspQ1xacPFCe5bVL3D0BGIdtAROJnX7aWm
	NYB278RkcH1u9pLwPhg17uxIHjr240mfuDN9dWzHawwI3GLHW9zs5nns48GDOcKazK4c9qGSoxhWu
	sWDyYCmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJrEP-000bFz-3i; Tue, 15 Feb 2022 06:22:33 +0000
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJrEH-000b8H-6j
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 06:22:31 +0000
Received: from [192.168.1.18] ([90.126.236.122]) by smtp.orange.fr with ESMTPA
 id JrE4noUgHi9Q8JrE5nCLGl; Tue, 15 Feb 2022 07:22:17 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 15 Feb 2022 07:22:17 +0100
X-ME-IP: 90.126.236.122
Message-ID: <183f319e-613d-5318-25b2-2c90ef4fdee5@wanadoo.fr>
Date: Tue, 15 Feb 2022 07:22:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme: Fix missing error code in
 nvme_configure_directives()
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20220215033632.104124-1-jiapeng.chong@linux.alibaba.com>
 <20220215035506.GA1663897@dhcp-10-100-145-180.wdc.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220215035506.GA1663897@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_222225_403735_ABDC346F 
X-CRM114-Status: GOOD (  13.01  )
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

Le 15/02/2022 à 04:55, Keith Busch a écrit :
> On Tue, Feb 15, 2022 at 11:36:32AM +0800, Jiapeng Chong wrote:
>> The error code is missing in this code scenario, add the error code
>> '-EINVAL' to the return value 'ret'.
>>
>> Eliminate the follow smatch warning:
>>
>> drivers/nvme/host/core.c:780 nvme_configure_directives() warn: missing
>> error code 'ret'.
> 
> Nak, the code is correct as-is, just like it was the previous time you
> posted this patch:
> 
>    http://lists.infradead.org/pipermail/linux-nvme/2021-September/027339.html
> 

Hi,

maybe an explicit 'ret = 0;' (and eventually a comment saying why) would 
help here?

The code really looks like an error handling path (and will keep getting 
some patches for it because of bots).

Just my 2c.

CJ

