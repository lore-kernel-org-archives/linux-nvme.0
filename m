Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4458C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Dec 2021 15:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NmEE3C6eU8qadUobusGqiZtAFFcKmQm1fUz0PUlY0Vo=; b=Ff95y+af/iy2pNkRDA+9fgz3A6
	oDxiS3fLpP45nuzY9zN+tEc8XzaVjUOKMJCu+VI/Gy5z9sIcxNfdTe8S8a8l6rnj30dUrzcktBj1A
	nqOmkvgmlW8oTHEGT5lEAEoeZIWidNuOu8Sdc8JCVn3D8urNOhvWyY/DG2WEeIHgzQmprT4J/yJdY
	hfs1tFeQpKkCeJ+xicic32UwXmNwL+EMFjYYknJR104HoK09kwaGaWPjKtbS89L0sHr26YqZHjtKV
	EWBgBqN2X0axnXjIGrBL2whaTzo0O7fU3DttzbXWzwLgpT5UP377Y3UnrFT7brVwGpwJptDu6Dv48
	mGL904zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mtAQq-00GNGV-Am; Fri, 03 Dec 2021 15:25:04 +0000
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mtAQl-00GNEY-2L
 for linux-nvme@lists.infradead.org; Fri, 03 Dec 2021 15:25:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638545094;
 s=strato-dkim-0002; d=fuckner.net;
 h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
 Subject:Sender;
 bh=NmEE3C6eU8qadUobusGqiZtAFFcKmQm1fUz0PUlY0Vo=;
 b=qDfeDVNbmQikGnnVTMnpLPwP0hzfzt7pSr2KuCXcTeFHeJsq/2+VzeoIU+ngxyKDRN
 dhCjCn/892nJknwpIgwq8m0+UIOMoKG+/0JleeS1DnqDtRXdhNrdAzj7IaLXo9Fy/ZO5
 bZup/J+UFSvMfbWTHdRz7JEB8tV9TroDMrE/6j3Zx626rGFk1x0GrosJOvkcjLbxn7pl
 /ihEBMqAwCsug9uBrCZcsk+KM/dsZijfCgCFAwvi1qTYG7AWTqhQqn1v4YoaALn04Gna
 YqhOTkijDOUz0pMVY42r8evj3C71gVQhDqeCW1Dtk8S995JrJZypOZMiiimFVW/BtDn+
 ayrA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":IWUHfUGtd9+6EujMWHx57N4dWae4bmTbIPWLqRDxdxMSR21kQd9enlO2mnkCSHWyJK8ZpINU"
X-RZG-CLASS-ID: mo00
Received: from [194.175.217.179] by smtp.strato.de (RZmta 47.34.10 AUTH)
 with ESMTPSA id 309d27xB3FOsR8B
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate)
 for <linux-nvme@lists.infradead.org>;
 Fri, 3 Dec 2021 16:24:54 +0100 (CET)
Message-ID: <5c38bbd8-7180-6674-c4a9-7660f9c86053@fuckner.net>
Date: Fri, 3 Dec 2021 16:24:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] add Intel 760p/Pro 7600p nvme disk
Content-Language: en-US
To: linux-nvme@lists.infradead.org
References: <20211202030230.17507-1-caojun@uniontech.com>
 <20211202175539.GC3836713@dhcp-10-100-145-180.wdc.com>
 <tencent_5722FB4254C69E931F449D17@qq.com>
 <20211203150747.GB3839336@dhcp-10-100-145-180.wdc.com>
From: Michael Fuckner <michael@fuckner.net>
In-Reply-To: <20211203150747.GB3839336@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211203_072459_365501_2124F75D 
X-CRM114-Status: GOOD (  13.86  )
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

On 03.12.21 16:07, Keith Busch wrote:
> On Fri, Dec 03, 2021 at 09:37:45AM +0800, 曹军 wrote:
>> When I use two Intel 760p/Pro 7600p nvme hard disks under the 4.19 kernel system, there are two problems, sometimes only one hard disk is recognized, sometimes two hard disks are recognized, but the serial of the two hard disks in sysfs is the same
>>
>>
>> &nbsp;I looked at the latest 4.19 kernel and did not fix this problem，so I want to merge this patch into the latest 4.19 kernel
> 
> Please see the rules for posting patches to stable:
> 
>    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 

Hi all,

I believe there were issues with Intel 760/7600, but they were fixed in 
Firmware 005P. Could you tell me which version you are using and update 
to 005P with Intel MAS and tell us if this patch is still required?

Regards,
  Michael!


