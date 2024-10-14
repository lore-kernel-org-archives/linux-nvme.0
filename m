Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCCFCF2590
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 06:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yu+j7A7oPjGnRKFnmAe1/z1X+OssRjePksYw3dfVi7U=; b=lz5y/GylerZb8RY2gKTWB04pag
	ALxN1Ntc7aE1UFwXmfk+kWBoWPDMg/N1UeCcEjfcIW35TPkJCiFgf/HhwpfSh/JowlZMLGDH8xcg/
	/bkzI0gFTPI2AxaMc7UaaHPBk6SDg2Z83TMOklfYmCqiLGyFrX4txr7hTVWTX6+nUjeqIsVy1lkEi
	nN6Gj11wr1K67GFPGlak2rPQGsWFwYkSPOl898deNQjz12N60/WwQbcmZ1hZ2XJ8w49HmAFAK4gCX
	U7zx+6QLIfiumW7ygssqM9f2UpIonOPLZ4f3YOQ81NaJprZjFm5gSFrmG/n18p2UTT7zb/1JaFXsY
	zm3hqJqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0E8F-00000003orP-2PcU;
	Mon, 14 Oct 2024 06:00:39 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0E8B-00000003oq4-2vUw
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 06:00:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728885633; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yu+j7A7oPjGnRKFnmAe1/z1X+OssRjePksYw3dfVi7U=;
	b=Yo2IspXBgSXicmUTKavZy64xbHESTFfO+f9zRWkZwmxr7H0nigEXtbKrb35zYNBTjseDunD/edlcis7XqHmUwDKDBIuqd/B3SwqqBs32H+kszBC101HkCSY7bKHETgvHRKLGLlg/zZ4L/HpxCBoRFZPSSQqI4dX2Ua6lZMi0Vek=
Received: from 30.178.81.252(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WH0c60G_1728885630 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 14:00:31 +0800
Message-ID: <2b10b220-7069-400a-8b82-a20a69a58478@linux.alibaba.com>
Date: Mon, 14 Oct 2024 14:00:30 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v14 1/2] nvme: add reservation command's defines
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
References: <20241011022612.50303-1-kanie@linux.alibaba.com>
 <20241011022612.50303-2-kanie@linux.alibaba.com>
 <519ebe04-a2b1-4e9a-a67f-7bfb810a7d88@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <519ebe04-a2b1-4e9a-a67f-7bfb810a7d88@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241013_230035_917409_24483D58 
X-CRM114-Status: UNSURE (   7.21  )
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


在 2024/10/14 13:43, Chaitanya Kulkarni 写道:
> On 10/10/24 19:26, Guixin Liu wrote:
>> This is a prepath of reservation implementation patch.
> if it makes sense please consider something like :-
>
> This is a preparation patch for NVMeOF target reservation
> commands implantation.
OK, I will send the v15 to change it.
>> Add the defines of reservation command, such as reservation log
>> and sub operations.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>
> Looks good.
>
> Tested-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>
> -ck
>
>

