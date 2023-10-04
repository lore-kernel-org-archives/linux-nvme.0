Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9ABE7C4E8
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Oct 2023 17:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A+/9fMvIMylBk0tUbkGNvHwmLNtY7jK7qI7VPa1SYvo=; b=h5flKi3Is2UhpC8b2xY1nUqpe5
	+/5JP6tItnZwqavW3drTUa/ZBlxWG4cA8brDwyphK0tPDFUro3ade2NBnH7mEOzJz7oY8788ZDl5r
	Cm9WVZfU6b3Mj923ELMP5EDsgUdobCZLMSyXFaofbBa3+NV8iGS1f0n4tw+WZ0cIIRA4SXxYcFG2t
	Avgeier1iP6cZE7gz/Z3ke2a5M4kthx0EhZSXGvNEqZbh3p/B1x0e3i1NvMsrNfxtGFdfOxicBgrt
	tn7eT+FwAUGuYFlrMjKfjAyg9uhUUHVfYD8qGPCRY3C520BCPuRUy3OJqHPiPlah78o6noYSt/xTK
	rDd7i9rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qo5lO-000bvU-0Q;
	Wed, 04 Oct 2023 17:34:22 +0000
Received: from mail-pl1-f179.google.com ([209.85.214.179])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qo5lJ-000bts-1m
	for linux-nvme@lists.infradead.org;
	Wed, 04 Oct 2023 17:34:20 +0000
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c63164a2b6so9710385ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 04 Oct 2023 10:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440856; x=1697045656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+/9fMvIMylBk0tUbkGNvHwmLNtY7jK7qI7VPa1SYvo=;
        b=iXCfzwNjCNM62knQOIme+tLBwF+ntIctxApBOJp3isBOEmcBV7KRKqtpnqIh6cypuy
         nb9Ur4BHrsRQ0hMYm64QxgOv7K5r/eot+wvPSSQzCH6y2DDYKKCWCOirUvcfwLzBGwhe
         rzrrztfP4pNxCbOiZ2h9/6wig13svF8XUis1ZqNLFuB1PXy7AY0kg1blmaiNOFiZxnEV
         XPkLBqr5C9EqSzthlr9uEi1tMg0vyWZ5AGw20c5IJLRRQeKOqRxDccLBokDU+tkH1Ns7
         kSqsAGMxQqTkGUsQeGcynW0idQm8RKzhbnv/W2bgvxhKbVf8C6e0uSbSJVWX7vJnselY
         pIVA==
X-Gm-Message-State: AOJu0YxW0X0rZRTbJvTHfIuXwPv1evMkHb1qnMUUPPFauc3GbBZilW7X
	rPz/hbQ/Txb6TDCZxS6qQcg=
X-Google-Smtp-Source: AGHT+IG8R+DlyiiEVWC+68KptejH+cGLh+ypDyuFaNYiG/lvbHPG9T3lVvSCSBbHEXdRAJ132q1v4Q==
X-Received: by 2002:a17:902:d4c4:b0:1c5:e207:836e with SMTP id o4-20020a170902d4c400b001c5e207836emr444422plg.26.1696440856149;
        Wed, 04 Oct 2023 10:34:16 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:969d:167a:787c:a6c7? ([2620:15c:211:201:969d:167a:787c:a6c7])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090332c100b001bbb25dd3a7sm3978166plr.187.2023.10.04.10.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 10:34:15 -0700 (PDT)
Message-ID: <e6c7b33c-38ba-402b-abdc-b783d4402402@acm.org>
Date: Wed, 4 Oct 2023 10:34:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
 martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
 linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <1adeff8e-e2fe-7dc3-283e-4979f9bd6adc@oracle.com>
 <8e2f4aeb-e00e-453a-9658-b1c4ae352084@acm.org>
 <d981dea1-9851-6511-d101-22ea8d7fd31e@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d981dea1-9851-6511-d101-22ea8d7fd31e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_103417_589764_DDE571AD 
X-CRM114-Status: GOOD (  19.39  )
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

On 10/4/23 02:14, John Garry wrote:
> On 03/10/2023 17:45, Bart Van Assche wrote:
>> On 10/3/23 01:37, John Garry wrote:
>>> I don't think that is_power_of_2(write length) is specific to XFS.
>>
>> I think this is specific to XFS. Can you show me the F2FS code that 
>> restricts the length of an atomic write to a power of two? I haven't 
>> found it. The only power-of-two check that I found in F2FS is the 
>> following (maybe I overlooked something):
>>
>> $ git grep -nH is_power fs/f2fs
>> fs/f2fs/super.c:3914:    if (!is_power_of_2(zone_sectors)) {
> 
> Any usecases which we know of requires a power-of-2 block size.
> 
> Do you know of a requirement for other sizes? Or are you concerned that 
> it is unnecessarily restrictive?
> 
> We have to deal with HW features like atomic write boundary and FS 
> restrictions like extent and stripe alignment transparent, which are 
> almost always powers-of-2, so naturally we would want to work with 
> powers-of-2 for atomic write sizes.
> 
> The power-of-2 stuff could be dropped if that is what people want. 
> However we still want to provide a set of rules to the user to make 
> those HW and FS features mentioned transparent to the user.

Hi John,

My concern is that the power-of-2 requirements are only needed for
traditional filesystems and not for log-structured filesystems (BTRFS,
F2FS, BCACHEFS).

What I'd like to see is that each filesystem declares its atomic write
requirements (in struct address_space_operations?) and that
blkdev_atomic_write_valid() checks the filesystem-specific atomic write
requirements.

Thanks,

Bart.

