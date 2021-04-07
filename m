Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BA2C433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 23:19:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8947B611C9
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 23:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8947B611C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=d2Q+979P+pxzyIHGf96UX2Nb6ubd3DHt8R1E38zRqg8=; b=OPe/ONOsNhRaGmJ+QoxYoX5PT
	5eb4WEBt+NbFkq5TTt1YErxuTXaw/vw6iTrIpPUV0F+n7yUlgtb83GbYTMhzKd+5YDCaxBQHasyZe
	YJndBbXrbljAYguVVuVkwZmIGoe1ekxId7u3CkvToK7YvV3VEFBbok115vOUrA97uKMZYK2HyGlhE
	aFlNcVNYsabnnHjzDN89AomBJv1v5c8ANfaoP5KNRRD/8Aaa1MIydgv5rDns7RzM8yY5j0Klt6o7+
	9R/GQU8no3idIu/USsyDm3D+UQF1eiRtFeimOEXoalmp0CAG+bPN/ZX2Hr/1pnoTvIyISGG4i56+Z
	kC62ZJsKA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUHRX-006GZx-Cc; Wed, 07 Apr 2021 23:18:39 +0000
Received: from mail-qk1-f169.google.com ([209.85.222.169])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUHRS-006GYS-Vv
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 23:18:37 +0000
Received: by mail-qk1-f169.google.com with SMTP id z10so353429qkz.13
 for <linux-nvme@lists.infradead.org>; Wed, 07 Apr 2021 16:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2motuKeuu3J66m9xpFf2UYKnYQjOm5Hi7nool5WRAr4=;
 b=nEukSMYp3NNKxwlOmcU/wGYruRv5tvkelTvKSo2t0kudDuagYkD1+SiIl9SZh+W/6T
 SXdKAyNB2auW6Zmx+LK/baots3rPY3GooDXBUf67zSzerQWxYc8OwpJq8nw6LfMZLlQz
 DrRHODs8c8T7FqA0YwafvwK1gPHer3ip8xaN3cTN357T04Sl7er0pqYmpfAQKd0Z8z86
 nIxMhLqY+cf4ANhvVvKazgK0qwPFhIhL+ZLtJMvF37DlsEG2ptEsip1TRnSWCdCw2jKa
 5oSrDjGVLlOeZ+LOJMhKBwmVNqoMa8YcRq1EUIw9Z6Bp6rKV8PX+6z99CXYTqdJfU0ZH
 vZHw==
X-Gm-Message-State: AOAM533SdESTGQ48DhcwbK9AD9zVkffuhPzNGaL0/isdOQtz0yUXw2kf
 1BH6pjCLfOtjHhhwU87yavP5HaKwRyg=
X-Google-Smtp-Source: ABdhPJwBI7BK0ChIG/wUeYZ0oG2CRgsxTGXOpDn/MkrLgK6Fnmxc96IDhVOc8H4OFy8hIVLfT6UfDA==
X-Received: by 2002:a05:620a:13a5:: with SMTP id
 m5mr5572207qki.498.1617837512617; 
 Wed, 07 Apr 2021 16:18:32 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:28c0:2d5a:bc28:37fa?
 ([2600:1700:65a0:78e0:28c0:2d5a:bc28:37fa])
 by smtp.gmail.com with ESMTPSA id b10sm19481655qkg.50.2021.04.07.16.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Apr 2021 16:18:32 -0700 (PDT)
Subject: Re: [PATCH stable/5.4..5.8] nvme-mpath: replace direct_make_request
 with generic_make_request
To: Christoph Hellwig <hch@lst.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20210402200841.347696-1-sagi@grimberg.me>
 <YGgG2TAA9TNqM9S6@kroah.com>
 <00e36c71-9f2c-5b38-96fd-3d471382f6ac@grimberg.me>
 <20210407052806.GA18573@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a1674400-b265-6506-71cb-fd893d3f52c4@grimberg.me>
Date: Wed, 7 Apr 2021 16:18:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210407052806.GA18573@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_001835_132693_7B9F4451 
X-CRM114-Status: GOOD (  15.05  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> Hence, we need to fix all the kernels that were before submit_bio_noacct was
>>>> introduced.
>>>
>>> Why can we not just add submit_bio_noacct to the 5.4 kernel to correct
>>> this?  What commit id is that?
>>
>> Hey Greg,
>>
>> submit_bio_noacct was applied as part of a rework by Christoph that I
>> didn't feel was suitable as a stable candidate. The commit-id is:
>> ed00aabd5eb9fb44d6aff1173234a2e911b9fead
> 
> submit_bio_noacct really is just a new name for generic_make_request,
> as the old one was horribly misleading.  So this does use
> submit_bio_noacct, just with its old name.

commit ed00aabd5eb9fb44d6aff1173234a2e911b9fead does not apply
cleanly on any of these kernels, so I think it's better to take this
small one-liner instead of trying to fit a commit that changes the
name treewide.

Greg, what is your preference? backporting
ed00aabd5eb9fb44d6aff1173234a2e911b9fead to the various kernels
or to take this isolated one?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
