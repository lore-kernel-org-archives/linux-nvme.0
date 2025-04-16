Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51933C369CA
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 21:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=931I5iGMX9xLjFX+7Ib+Wpbv+xz0HfdiL6J2IHCQ2L4=; b=SV1n7FZeOJDZMOb7ACbA6XmLfS
	apnuz6uZgqu59GV3d+0RU1npIjtpOu74SC5Hp7XT/lO3Gb1r+VYvFMxG/OJNYsWPt6h86IGSnlcF9
	W3QGpx4Y3oWq9wX5zh3QUvcyjxMZsSMoi3rGpRWDVouAHLo4cYR5wkOyo9CM5o2iBXHrX1aI1g8Hi
	+P52eNznuD2WERTmhKSGog+752cWxPmTpZdVIrCYS20b1qzsWA41ZdtIAYwEuCPYdMISd+jo1hjzN
	u4om56lAayeNd8KMR+5EepebTzl/rLBc3z7o+RtlSK3iujVqYSPTuCzbbB8JJCcVJmH8sJe4uDBs+
	5MtCKcdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5AHd-0000000Avgq-3l6f;
	Wed, 16 Apr 2025 21:27:01 +0000
Received: from mail-ej1-f54.google.com ([209.85.218.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5AHW-0000000AvgH-1TNJ
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 21:26:55 +0000
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso13791566b.3
        for <linux-nvme@lists.infradead.org>; Wed, 16 Apr 2025 14:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744838812; x=1745443612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=931I5iGMX9xLjFX+7Ib+Wpbv+xz0HfdiL6J2IHCQ2L4=;
        b=Gx2H2A023JuJjWcUaW2vepduGhg5lsWhCqO7M9DYeAnfB7GfPHk/0APWrQKu1GPf1b
         7UMSrFxNyTSJ3hPvg/uxiXqXh7VuMvgen8Y5WUb4UW7an0NrZo4uMGbGTPndFQOA+PCQ
         ndCiE2bkaemIEqgkQ/Q5lZ1LYcPA5Jl9elAOJQ9U7H2+NxVCgvQgx0onjyLUEPYd0rnG
         kHRA/Shb4ujxteK8kF49Tdc9xGtRfZbMeRNBxLiFLUptoTYv6kGUZNDP7Y2GWC9kVSDK
         rqFzA08kgz0vTGDfH6azIc/PU/mptyXww2J0cBDZ6ryIRwXR4yv3rfgoovBBfTe7FdUD
         YYvA==
X-Gm-Message-State: AOJu0YxEIWWgE9MGan50rpgOYBmALBMZ8J/6Fp+otJHvP3F8cZGH49XH
	QPv/ZkFSJW1SS+XHde/7AHmpQuq2lRIFbChtN2mYIKuPKNlyklnr
X-Gm-Gg: ASbGnctdZAa5iRHTyIOmnY0D8Ej7iTPrT1YlBoU7jelCUlSJTTu8KJthx9sXZidpfLu
	yd+uKyPeYrV4NxqNc8f2wVglWZCxiSH7KUtkOE8RJ9AWWSX1hwn9FdF58r5+4S3gVtx4OsE2Gd3
	KaXMsv2cC94r1002kP5KRT8uEmZYz5W67AtvrjhDGnuTywbxGmMoF+zGCNUX64S7nTysbiTiWvZ
	IHgFT7EnIcvaPhbSHzxnJBaSg5Ep5Sb1xroZz+8YZ7N+ARBJvNIRbR4IoCxAzrP6krKMcoLwssI
	a3yee2Znl94xnP+NsiIn2jhFncSrdanW4a+VJMxDWwoDUdYu5ohY4VK0VF5HORPn8xrdXkqW
X-Google-Smtp-Source: AGHT+IHXzOj2EkcsKNvabbD3VKAofrnwQr1zNynx58hFkhYxzB4g3PAB78dWgvTo0ljbZIK0/Lrk+Q==
X-Received: by 2002:a17:907:988:b0:ac3:4139:9346 with SMTP id a640c23a62f3a-acb42892889mr269048566b.9.1744838812385;
        Wed, 16 Apr 2025 14:26:52 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3cdeb037sm191066266b.56.2025.04.16.14.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 14:26:51 -0700 (PDT)
Message-ID: <d1d76c7f-e8c7-4554-adf0-663bb49d2d82@grimberg.me>
Date: Thu, 17 Apr 2025 00:26:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-cli connect regression
To: Daniel Wagner <dwagner@suse.de>,
 Caleb Sander Mateos <csander@purestorage.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 bluca@debian.org, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
References: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
 <6b081163-2b00-4de9-85c1-7bc72909f90c@grimberg.me>
 <066cb0d9-95b1-49ac-92b4-43a212d0a7fa@flourine.local>
 <076c96a5-f399-457f-9ef1-491d81e0d8fb@grimberg.me>
 <CADUfDZo8mRaaT3RhXXGJiXmkkgUmY6+=O8cEPp2rE-U-LMupKg@mail.gmail.com>
 <d7737471-8b06-4a78-af2a-6d8e3fb8ba38@flourine.local>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d7737471-8b06-4a78-af2a-6d8e3fb8ba38@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_142654_387050_28C57201 
X-CRM114-Status: GOOD (  13.16  )
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



On 16/04/2025 15:26, Daniel Wagner wrote:
> On Tue, Apr 15, 2025 at 02:26:40PM -0700, Caleb Sander Mateos wrote:
>> On Tue, Apr 15, 2025 at 2:14 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>>> Its not great that we now get sporadic EINTR errors. I am wandering what
>>> is triggering this?
>>>
>>> Caleb, did you see this?
>> Yes, I did see it. I don't understand where EINTR could come from
>> aside from the userspace process receiving a signal while waiting for
>> the ICResp (or hitting the 10 second timeout waiting to receive the
>> PDU). I don't understand how the switch to MSG_WAITALL would affect
>> this. A tcpdump might be helpful to understand whether the controller
>> is actually sending the full ICResp timely.
> I think I can reproduce it. I have two connections and do a
>
>     while nvme read ....; do yes; done
>
> and block one of the connections, when the error handler kicks in the id
> ns command fails with EINTR.

What happens before Caleb's patch though?

