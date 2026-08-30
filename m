Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11922C61DE8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 21:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ChICS5RKwbIr9V67FgxGk4WsNuFQgo5c9DpeaetnTi8=; b=ovy+MfriV9JZymk6VKs6Mka92I
	1If0OHYIC0lwuXJz/xl+hyPcjFossYKAuJn+XYoESUPEnRJv/XV1p2hWrfPb8Nll233z61cJlGRR5
	JnVL3aGGbVUOTlj1SYBpg6cd7hr7k3rzSMb5EaNtYCNpjJ1PB1yIKzfGUbX3OTYkDF6JdrkmB1cML
	ZKJe1uX0uTtGlAEU8sHOWHlFOHTghVk/7ezXXlKNw/Ly1ob/22ZQOnqgjHk9zQbJrpjsvDoNdogn8
	HwahkbKpXcM4jMYadqgzHsW2vLi30vItTpGnat/7ATaFzsJMLaA3JmlwdRZFmxOPnDr/CKFEp0BlD
	6LzmG9rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0nM6-000000088rp-0brZ;
	Sun, 30 Aug 2026 21:46:22 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0nM3-000000088rO-3Xtc
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 21:46:20 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49557167508so29563955e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 14:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788126378; x=1788731178;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ChICS5RKwbIr9V67FgxGk4WsNuFQgo5c9DpeaetnTi8=;
        b=N1ArfvPz2Lx+Bqlh2XKGvg5dC1fJxRx16Br+vizmZK7n3EDrEcgHuSF3PA5iEknfYm
         Nl7/A4jAPbgN0oz+4fofL1kDxedz7gItK7ez/KB9BNHGLylcQPI2vEsN7xcHMwrevSDW
         pR9p7pbRosYY+YghCqoOjREhDn/0qX8P4VeriAO5NMY5ndrgTWxFVuL5BFhjP9O18iBn
         4erIlMDeRANRyG6JUEJE2thy3Dr+hk+mLCxcttYjZMO+0FyvQRBzZVZ4cVPupngcUpFz
         LNTXJwKQYKWkFJXSvBj05m9VwSHb8Qo0d1FxS/7htW1Tj+qfkcw4aLEzkUNegxKdoeWM
         5fuw==
X-Gm-Message-State: AFuF++kUq1paXPH7az2kksvpVyPnWufDBCgnDTFCB+7D0c20jTXNFaej
	nl1n7/DwpsoLp33RO893HfUkf8b9YCNteSaM2Wo4Jde18Rxtc5efLaWE
X-Gm-Gg: AR+sD11f0xxrnJhVrA8Ds8k+wRZr/3v/8zgcegdQnzvtviaro6QhYROe0CchkUzoHrN
	YEQ+dRGjrSZzOAKbHp12hArXE43MrVM8up4Mv1BmBFsCigPESB0N3TAYLY+OSVGens1Z7Ipbrgq
	5TUDKsaPJuamkP/S+2oNb5nUBS/p3sVS947v5iG98bOhRGkUh/ioNy1Q7mX6/wHflmfItOZXUdH
	9iubTTHrntVgGHSLQPaswd1AdJ6jD79QAHmAw7bcXEYt6/ELV9IuE9wgtEZFS49Lv43au2Kn0Rz
	tuiJfr9xHjePCoXseTKkw040n+GRQeSYSuOyebL4zvIaBAYsZkbN6GMGAdPgl1P5EoVaaOVgCfc
	k7XXtvFF1PI0S2qvnx+u8Vy6/+IoYWIcqMzbmrorNDyTGGnmbZPZtcFtGpFn2uFktfBVIdrbO9W
	2NGkmrGOYdZT1kmcHqO8gM2jeaSBeS3IdD/YuF9/NIMGC0iNUlFMvwZQU11/EIRMwT4TRndp+iI
	ZyXv68nvyHIfWFnstPMsw==
X-Received: by 2002:a05:600c:4594:b0:49b:4d64:bbc4 with SMTP id 5b1f17b1804b1-49b91c2f990mr296637785e9.8.1788126377571;
        Sun, 30 Aug 2026 14:46:17 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49c5a903eebsm142563865e9.4.2026.08.30.14.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 14:46:15 -0700 (PDT)
Message-ID: <558c74c2-4e96-4ef5-b0e3-7a23a08df4d5@grimberg.me>
Date: Mon, 31 Aug 2026 00:46:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvme: Add module reference counting for multipath
 devices
To: Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Gjoyce <gjoyce@ibm.com>,
 Nilay Shroff <nilay@linux.ibm.com>, Wenxiong <wenxiong@us.ibm.com>
References: <20260812223206.720363-1-wenxiong@linux.ibm.com>
 <a9d90f41-1493-4efa-abd1-a7071046414a@grimberg.me>
 <d58d0c4f-0789-4c99-94bc-e2e2121e7b7a@grimberg.me>
 <5626e2342490081fc4acb47f370009ba@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <5626e2342490081fc4acb47f370009ba@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_144619_896148_7F2ED36A 
X-CRM114-Status: GOOD (  13.13  )
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



On 25/08/2026 22:11, Wen Xiong wrote:
> On 2026-08-22 19:46, Sagi Grimberg wrote:
>
>> OK, I now read the original report regarding nvme root device. please 
>> disregard.
>
> Hi Keith and Sagi,
>
> For single port nvme device, I found out:
> If NS does not have any filesystems configured and the root filesystem 
> is located on another SCSI disk, the NVMe device's reference count is 0.
> When a filesystem is created on NS, the NVMe device's reference count 
> increases to 1.
>
> With my V2 patch for multipath devices,
> Nvme's reference count always increases if NS doesn't have any 
> filesystem configured.
> If nvme1 has 1 NS without any filesystem, reference count is 2 after 
> system boots up.
>
> Should Nvme's reference count increases if no filesystem configured on 
> a NS?

No I dont think it should

