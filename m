Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E67FE92718
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Oct 2023 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mau3Ytqwy7TZu9wwYpopAHbH4XlNKRL4d1UxE9xBpfw=; b=i3FxzVCMCBfXPWQ4jLO8pWWtqX
	iksVQaj+EYf4Uhqb3bo8b+Zgwl34UqkJjCnmMOTaA+S5kFq2U+IHzzcfGz9n0b0WEfrA7Kfc6qobf
	a3vnMlqrcOccYSuumRHa2eArCH7Dt0L7JRkiYnaOAe7qXEg6gIxOHyE49mR+yVIITTVnFlJY+ZvMk
	o95r+V9F7rCAvao3jocuDXIP5ekDLUT7UFKkQZrt6D6/lvlyWTEFXqXaDMkaluHQRy+smlUK8KVbo
	x0fDjIotw5lobcqUbgKTuKe/zY3F+zyZLGp/j53btGFbPQ8QMvAjz44z5nnN2yrfFdqMeBQa6qV1t
	VUhusKiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoRsC-004AhY-2H;
	Thu, 05 Oct 2023 17:10:52 +0000
Received: from mail-pf1-f180.google.com ([209.85.210.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qoRsA-004Afx-0h
	for linux-nvme@lists.infradead.org;
	Thu, 05 Oct 2023 17:10:51 +0000
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6910ea9cddbso1048696b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 05 Oct 2023 10:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696525848; x=1697130648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mau3Ytqwy7TZu9wwYpopAHbH4XlNKRL4d1UxE9xBpfw=;
        b=gkdL54encBS27xyFRD9RFxQAhrtwZGY6C/5l8QTK1yGhw/Xh4ucT39SCSyOmwdd+H5
         WGuRxcgBX8bEBXmh7SP+5l9zK8XTpaSqV+/Swdk9QgFAMeN2EUZ6suqUo/craJGd1KSs
         N23wnZS6cWO0MxqfdWFUvvhFr+T2qIOB6biRoX1ECzXXh60VL6TKdnFiWVJA07+jVGqi
         hD2eImKNfinXV5L2asx8QPKn8Tocwrue2QLx5NUmIvwcGrmXGi0QX+7/PU3W5dbXYj/4
         56S5dGSS802bdnxtJ60AvqwksmYr12jQuBrIG1mAnPvZuVhsTeDTxNA+mX0KwIYCpPCu
         LswA==
X-Gm-Message-State: AOJu0YzyfBNg4fdwCUgz2+ai0UGfqdgmxLCfJIR7INdfqNfgRRtq5fam
	aFYW5sGOM5//d0rPGivaMsY=
X-Google-Smtp-Source: AGHT+IGnVdp8oICK4V8pUUfksO9nmUjiTQt7WLAzT5URUjUrgm7Kl0ihNxBLzaBBJ2yggv4nt+XNYg==
X-Received: by 2002:a05:6a00:1410:b0:68b:eb3d:8030 with SMTP id l16-20020a056a00141000b0068beb3d8030mr6024179pfu.1.1696525847811;
        Thu, 05 Oct 2023 10:10:47 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ca3e:70ef:bad:2f? ([2620:15c:211:201:ca3e:70ef:bad:2f])
        by smtp.gmail.com with ESMTPSA id t16-20020a63b250000000b00565eb4fa8d1sm1641495pgo.16.2023.10.05.10.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 10:10:47 -0700 (PDT)
Message-ID: <a2077ddf-9a8f-4101-aeb9-605d6dee3c6e@acm.org>
Date: Thu, 5 Oct 2023 10:10:45 -0700
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
 <db6a950b-1308-4ca1-9f75-6275118bdcf5@acm.org>
 <yq1h6n7rume.fsf@ca-mkp.ca.oracle.com>
 <34c08488-a288-45f9-a28f-a514a408541d@acm.org>
 <yq1ttr6qoqp.fsf@ca-mkp.ca.oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq1ttr6qoqp.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_101050_252809_07E64816 
X-CRM114-Status: GOOD (  10.65  )
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

On 10/4/23 11:17, Martin K. Petersen wrote:
> 
> Hi Bart!
> 
>> In other words, also for the above example it is guaranteed that 
>> writes of a single logical block (512 bytes) are atomic, no matter
>> what value is reported as the ATOMIC TRANSFER LENGTH GRANULARITY.
> 
> There is no formal guarantee that a disk drive sector 
> read-modify-write operation results in a readable sector after a 
> power failure. We have definitely seen blocks being mangled in the 
> field.

Aren't block devices expected to use a capacitor that provides enough
power to handle power failures cleanly?

How about blacklisting block devices that mangle blocks if a power
failure occurs? I think such block devices are not compatible with
journaling filesystems nor with log-structured filesystems.

Thanks,

Bart.


