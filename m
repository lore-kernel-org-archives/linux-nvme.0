Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83627C54E58
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 22:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uZI/v8KeU4NHgmW3skA6LyGPgjaJysTxzyyVkQZDsAs=; b=vYIAMfW8d97/4Kvy7rJUbNtaAm
	wJrnHBdTwVIoobYJQ1J7C27Jv7mO58rUwF0BB1nihFqL/TBtyd+Lcl0RvOMJiB9cL0d/q2nrIKQh/
	5j+tNAJ4Qyh77W+lnFAupy+HeiKXIWSdOYSRKKR3/fkIz+gnyeT6OSDNV7aJ3k3S8j5deIZJG9GgT
	SIavewT3NyCMCkVsFW6cncScR9+hP7yQAVHfpCCqG8X8z0uNGFaSdWaa5Rv3Uzt5SL8e4tyn/0Zg4
	Sx20s62D7rE1PEwgPTJoTWjBZXziiPthwioztBCJFMENgCohAvlLkyQZmlN8AGJTRm6s1Y+JaOSSG
	3r++kuxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn4m7-00000001AYS-20rr;
	Wed, 20 Mar 2024 22:51:11 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn4lz-00000001AXW-1CNs
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 22:51:08 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41401ee5828so689295e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 20 Mar 2024 15:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710975061; x=1711579861;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZI/v8KeU4NHgmW3skA6LyGPgjaJysTxzyyVkQZDsAs=;
        b=wmNCQWEhjV5XGSuY1hoD/yxMOICRw4PrG28VoCjyE0rQczYouRP8Hhq5wodbH6lU3d
         ji+sZ29sE341sxMDsU+KiIKI9Bq4ibn7DikqeqDMW7POSzkr26vSbl8/vwmO5oO1F+0D
         QfgwrAn8BthqNufvplmOAyTutNKNiCrEOWd0ZnjBuZS2wMC4qukqXpiTvy+fZOjhAxBI
         doJCTzAqK+a9SjDSKe6Y6loEAlyO10MrEiA7m019nWTf1mZVKWrbMAG//bP1XcmCfk8G
         fQHknCxshE0I3jPZOQqeYSY1yqQHnm8SndDlcu3fMfxnZkA9WfCcTWoEA9u98XPuTGZ9
         6a7w==
X-Forwarded-Encrypted: i=1; AJvYcCVeNwl+yBG7MN6rpq0aKppnJAGnObrJMOr06aQcd1Rby30v3i1HTr9ibezNM763FDCW4xKTMrMzMHO+vH92iOl2bnsGDOlPRSI4/MZ5YWA=
X-Gm-Message-State: AOJu0YxYpdI1GKyyIKeqRhfIuY8KDxjydnsHL2f8gznaN7YXw+La6BVu
	lLw1P5sZTQdYQapGUzMXyT9UNkl6aHzGemDSKaRAvUooWY/v8AdgLLXl1lX1
X-Google-Smtp-Source: AGHT+IGmj7YBrMgLy6pSh7ZUByRcmxdC+6BNXAKjbuH7cGZSgn/LdkT6D5u1qIKrrLxWeOzs8UoFbw==
X-Received: by 2002:a05:600c:4450:b0:414:66d1:aae9 with SMTP id v16-20020a05600c445000b0041466d1aae9mr4346952wmn.4.1710975060861;
        Wed, 20 Mar 2024 15:51:00 -0700 (PDT)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0041463334822sm3591513wmb.26.2024.03.20.15.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 15:51:00 -0700 (PDT)
Message-ID: <97e82c57-7ccd-4697-aa83-dd8929364894@grimberg.me>
Date: Thu, 21 Mar 2024 00:50:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Connection reset in nvme-cli?
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <bf1201db-a2fb-4ced-ac62-36315bbdf4a6@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bf1201db-a2fb-4ced-ac62-36315bbdf4a6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_155103_548888_339038C1 
X-CRM114-Status: GOOD (  20.33  )
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



On 18/03/2024 15:40, Hannes Reinecke wrote:
> Hey Sagi,
>
> the secure-concatenation stuff is nearing completion, but there is just
> one snag: After DH-CHAP negotiation the connection has to be reset to
> start over with a TLS-encrypted connection.
>
> IE currently I have to do:
>
> nvme connect ...
> echo 1 > /sys/class/nvme/nvmeX/reset_controller
>
> which is clearly unsatisfactory.
>
> So now I have two options:
> 1) reset the controller after the call to ->create_ctrl()
>    in drivers/nvme/host/fabrics.c
> 2) reset the controller from nvme-cli after the connection
>    was established.
> The really awkward thing is that resetting the connection works
> when run from the error recovery; it's just the initial connect
> for which I need to do something 'special'.
>
> Personally, I'm not a big fan of option 2), as it means that we
> have to do a 'blind' reset, ie we have to assume that upon reset
> we'll pick up the correct key. If someone slips in a new key
> after the initial connect and the reset call the connection will
> fail as we won't be able to pick up the correct key.
> Option 1) doesn't have this problem (as the 'options' structure
> is carried over across resets, and the generated key is stored
> in there). But then the intention seems to be to move error handling
> / retries from the initial connect over to userspace.
>
> So, which way do you prefer?

Agree with you that we should handle this in the kernel. We shouldn't 
bother userspace with
the details of the initialization. However I'd like to treat the reset 
as part of the initial connect,
i.e. either it succeeds or fails, as a oneshot.

