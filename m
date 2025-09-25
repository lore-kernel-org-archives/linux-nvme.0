Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230A8CAC5BA
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Sep 2025 18:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ReuDuMaujN0MhhBVHybap8vk7TKVWSfnnUBsXonGP2s=; b=yosIsyxamxNNQj8/Ysz0W408eM
	CEIoQaxrpTL01iD2Qrc42S1kg/WYzD36nklScSaJwty1OTFxUSHL8mn+k5luMoiLWD0cWEVYr3qN1
	R7d9lsLWjOLqs733HidN4CnG9HHlVBrZ6b5XDJswrntbO+HkThJ+BaOBEympE9hvXPA4BanPdL6N7
	fbQEFu/59/hTfRhc7uSNTZD3hVOm0kYlko2LAxgq7HhMFoE43xEnYbpk4ZklTzOwEvD/qQfYOuXDu
	RNgvG2/COpAo5lKLvuasL+qbNtWZT/A5UhXo6tEgiAE8RbopGyeXEhN1bMkay3YbK/MW2PBi462dk
	TllU7kCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1r6j-0000000C5Of-17iN;
	Thu, 25 Sep 2025 18:54:21 +0000
Received: from omta34.uswest2.a.cloudfilter.net ([35.89.44.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1r6g-0000000C5MS-2bYl
	for linux-nvme@lists.infradead.org;
	Thu, 25 Sep 2025 18:54:19 +0000
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id 1nVpv8xXFZx2i1r6fvvycX; Thu, 25 Sep 2025 18:54:17 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1r6cvUSVUMem51r6cvQ8WK; Thu, 25 Sep 2025 18:54:14 +0000
X-Authority-Analysis: v=2.4 cv=bZtrUPPB c=1 sm=1 tr=0 ts=68d58fd6
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=kbmabLdzh3uUJaiPGAIkPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10
 a=DteqQ0MXNSPvLnE5JQEA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ReuDuMaujN0MhhBVHybap8vk7TKVWSfnnUBsXonGP2s=; b=d4EqFZXQyUecheMwwfXlO3iqFj
	Vs0i/dhEVEVNkd45SBZmSDIcxb5lpEq3DawVSdetan4LiFIaLnML1NFEbtzlAreQX/M0d5kvxfQHK
	Y2nQyUyfsKJiVlllhF3Mi0D557I8qRtyAEW2TnEPyxh6uAv3xo2LIyKHlmgNL68zzh9xXBIcT1iL6
	y18QopIvIAgCkVjvKKzrI/iMIveCM4d0XXy/0qoAgGDM3TZqx3iQm8ugVv7zrkLxneUYEy91K2e+G
	I8Jd8NdQFb1InpceN3c5Inx7OYAkLct3our8vZpl3GKGQwuCtmGR2FS9eKmzYTNdlPqOffBmn1kZ+
	lyEdKiEQ==;
Received: from [83.214.221.223] (port=56964 helo=[192.168.1.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1v1r6a-00000000Pwc-3iFY;
	Thu, 25 Sep 2025 13:54:13 -0500
Message-ID: <39cb2084-db12-461d-8c9b-17fd48d5c682@embeddedor.com>
Date: Thu, 25 Sep 2025 20:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] scsi: qla2xxx: zero default_item last in
 qla24xx_free_purex_item
To: Bryan Gurney <bgurney@redhat.com>, jmeneghi@redhat.com
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk, james.smart@broadcom.com,
 njavali@marvell.com, linux-scsi@vger.kernel.org, hare@suse.de,
 linux-hardening@vger.kernel.org, kees@kernel.org, gustavoars@kernel.org,
 emilne@redhat.com
References: <fbbef12e-fc43-464f-b92d-f42f3692a46c@redhat.com>
 <20250925170223.18238-1-bgurney@redhat.com>
 <e58d743b-a999-4e00-8f2e-31707744c5bb@embeddedor.com>
 <CAHhmqcTdC_we4x9e0Q-NT=k-9LM5Q8azFH51_Wbpr4tKgpOzDg@mail.gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CAHhmqcTdC_we4x9e0Q-NT=k-9LM5Q8azFH51_Wbpr4tKgpOzDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 83.214.221.223
X-Source-L: No
X-Exim-ID: 1v1r6a-00000000Pwc-3iFY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.104]) [83.214.221.223]:56964
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKp9QxumOwpH+IKiEu1N8f340WEhtcVsYPh7GGwwxXmPaE6d43B3vaiGtJe7mCGcHH7b0lvFNcSmfoIKtGPnoqhx/DwMbue0x9Yr7zpLT0iZ1oWBCvNM
 4dDvEdJZjQmKkalobxQ3vyy9C0oP2ymg9Beo08pTuDevQRtu4oh//lx0ymJF3U3hIS6hLtI/PfHpFlD+mjFN7SZqMY19TYSjf/A7ywp2gl3SLdRssDr6O4/t
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_115418_685773_A473D352 
X-CRM114-Status: UNSURE (   7.67  )
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


>> I see. I think it's probably better to go ahead with the revert, and then apply
>> the patch I proposed in my previous e-mail (it's more straightforward and introduces
>> fewer changes).
>>
>> If you agree with that, I can submit both the revert and the patch.
>>
>> Thanks
>> -Gustavo
>>
> 
> Hi Gustavo,
> 
> I just built a kernel with your patch, on top of the NVMe FPIN link
> integrity v9 patch set, and a test run on qla2xxx passes without any
> field-spanning write warnings, nor with any null pointer dereference
> errors.


Awesome. Thanks so much for testing it, Bryan. :)

Okay, so I'll go ahead and ACK the revert submitted by John (so as not
to duplicate efforts), and once it's applied, I'll submit the proposed
patch.

Thank you, folks.
-Gustavo


