Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2DBE7AD77
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Oct 2023 16:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/OTDR5NyHbb5QfDMSXNmt2Tc0LOejPzxDMttSZkL2/8=; b=FmPLej442QLNLjrJLGoK2PA9q5
	B+seW84ShxOIhPCOaJE8A9bYP0EnXKPeqw+cTjK/F+inbbykiAWpE3TIO/I7tkUdJ/4kz6V0KGd7+
	PB5jkonok4ik6I9gr8CcBJ/MxXRzp/Szx3FY64a81t8qMquXuxFbLqANjFOD02oGezc1/WvOH0H18
	wd3nAH4NQOO0Yq1bgP7xjcBmRmg5jfF+Inlfeu4Ot82J7BlSPCMPDzvOKOHB79Ppj82Uz3J/pioqg
	UCeiHdns475dYtiZCFV9Mw1MyDL1fChCjsLJIcUcIRP4WYwOhKZm+z9bcewOc5cBERtn4Wnx2ROkH
	mWALMwAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnigW-00F0Xm-0k;
	Tue, 03 Oct 2023 16:55:48 +0000
Received: from mail-pl1-f177.google.com ([209.85.214.177])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnigT-00F0XP-2p
	for linux-nvme@lists.infradead.org;
	Tue, 03 Oct 2023 16:55:47 +0000
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1c6219307b2so8351715ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 03 Oct 2023 09:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696352143; x=1696956943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OTDR5NyHbb5QfDMSXNmt2Tc0LOejPzxDMttSZkL2/8=;
        b=U/DustjVh/47cBXIJBZzxFHnRL/edwKAu1VwYFsyGClyuXhLJHYInsuIrO+lliAoOp
         57ZkhseKRgL6jdYGUwHOFKhTIV/Mo7RUxg2/3fJIOwO+wxA0Ar6wq1RSXejGxUqey2rv
         xjygLhH0g/Ywtc76b0iFY4KaHoVnT8s2VMdGG730VVmmIY6ty6yAGuS1guGdXutzP93R
         dGtlZXj8TyUaYDhejNmGzrf3Cf2ri4mnvPvYoVGlMytZl7/X0x3yqjJOUNHJ/Ddvtion
         1mF4pY8dAIJK4qYer2AdV6QpsuaoZy9TQw2s0XUsueXe98ilh1hlWZh/H0hr86nkjI6c
         fAtQ==
X-Gm-Message-State: AOJu0Yz1lCpfzzH/2T+ZtSmQ6BcrNjjPkWha9l0Sds86K9B3n/wmbcjB
	6e0zgx6wCidXs18piXGV/Vw=
X-Google-Smtp-Source: AGHT+IHkImNltSCEcrQL09yiA54GtSP4oWfRcumNXnmrqYOlKYAw0cgN14lN/1BxGiHV1bJDHfZauw==
X-Received: by 2002:a17:902:a415:b0:1c7:443d:7412 with SMTP id p21-20020a170902a41500b001c7443d7412mr174904plq.26.1696352143218;
        Tue, 03 Oct 2023 09:55:43 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:fc96:5ba7:a6f5:b187? ([2620:15c:211:201:fc96:5ba7:a6f5:b187])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c3c400b001c5de42c185sm1801070plj.253.2023.10.03.09.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 09:55:42 -0700 (PDT)
Message-ID: <db6a950b-1308-4ca1-9f75-6275118bdcf5@acm.org>
Date: Tue, 3 Oct 2023 09:55:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Content-Language: en-US
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, djwong@kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, chandan.babu@oracle.com,
 dchinner@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu,
 jbongio@google.com, linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <yq1lecktuoo.fsf@ca-mkp.ca.oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq1lecktuoo.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231003_095545_913422_2A332E71 
X-CRM114-Status: GOOD (  16.85  )
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

On 10/2/23 17:48, Martin K. Petersen wrote:
> 
> Bart,
> 
>> Are there any SCSI devices that we care about that report an ATOMIC
>> TRANSFER LENGTH GRANULARITY that is larger than a single logical
>> block?
> 
> Yes.
> 
> Note that code path used inside a storage device to guarantee atomicity
> of an entire I/O may be substantially different from the code path which
> only offers an incremental guarantee at a single logical or physical
> block level (to the extent that those guarantees are offered at all but
> that's a different kettle of fish).
> 
>> I'm wondering whether we really have to support such devices.
> 
> Yes.

Hi Martin,

I'm still wondering whether we really should support storage devices
that report an ATOMIC TRANSFER LENGTH GRANULARITY that is larger than
the logical block size. Is my understanding correct that the NVMe
specification makes it mandatory to support single logical block atomic
writes since the smallest value that can be reported as the AWUN 
parameter is one logical block because this parameter is a 0's based
value? Is my understanding correct that SCSI devices that report an 
ATOMIC TRANSFER LENGTH GRANULARITY that is larger than the logical block
size are not able to support the NVMe protocol?

 From the NVMe specification section about the identify controller 
response: "Atomic Write Unit Normal (AWUN): This field indicates the 
size of the write operation guaranteed to be written atomically to the 
NVM across all namespaces with any supported namespace format during 
normal operation. This field is specified in logical blocks and is a 0’s 
based value."

Thanks,

Bart.



