Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF1AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 08:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BNzvuZcgicTBqbhlj2//0UbgliwQppO+j8GwlwqQT5Y=; b=yirxTFvThYXtPq3nYYZxExyJSk
	bADrbIEx5FmZrzdPQN70FiVehRkOIaKNXXRb0e5Oqq7ihcWeYbe994JrCtup+dcInTNCF/ewUT9Nt
	3j1dhH+zDdal3tvkQGO8rINwY9kGhubB7gvUqTvBjM2dC+FqHj0cSMsppTLSoRUBwbnpQhmSLzaK3
	eT0EzobJmQ7aYInodWBwFPtE46kWo4cctCieBf4RBz/i8pVhrogciJbAfJubBdVz18H/w/1dvY8kL
	so3I0/jRVa5MHaPuBXoXWGUx+QhbVNK0KOu1rz3Y4JlI4uaZYHDWV/VTwKKsYyYXQR0PdZvWmLcSw
	bqm6P5JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbedq-000DDD-8T; Tue, 05 Apr 2022 08:34:22 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbedn-000DCR-Dp
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 08:34:20 +0000
Received: by mail-wr1-f54.google.com with SMTP id w21so18164144wra.2
 for <linux-nvme@lists.infradead.org>; Tue, 05 Apr 2022 01:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=BNzvuZcgicTBqbhlj2//0UbgliwQppO+j8GwlwqQT5Y=;
 b=sqr3Qr5jgl4LoKN42YtI4vRRPJACGlHcNU/IModkVKCi6izTpnLoip25JUDvT6yxJT
 IN8B+zZEWYbp10DpVY9+yTvBPkfWWmwWIq5LNlwBKbg5I0klXriotshjeC+GrUj0HicP
 bi3jP4f+O6IomicAIl4OkeiydMFjzEwdmOuRwUd+GhyaXwsX0n9CS5Naav2FHVEJ7STl
 XJ4trKToZ9Y73lRnRnsKEjiWgyp8iGxqFKjX8cVbyo9fovmBjclaaaGohO+GDjlSPUnS
 2IIKWy1jBTcxX7wMJlTWk3B/Nb1GhG0rAjOfFyNaXrKeUPwSm4MWd/tivPt3hjtO5kev
 PT2w==
X-Gm-Message-State: AOAM530VKmWNKK6QEqn/YMlV5QkIXwLhFwzSuD/QcB0W8Ql+AOAl/E2Q
 icHhMM0VbAfWkOwFDmf+DtI=
X-Google-Smtp-Source: ABdhPJy0n5EjzUDkdbgSbTmRW3+zV9fqhwBDWrVpjotQW6bQpZt2BYEZ2wCeO1d075I1lHxqdJs9hg==
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id
 a3-20020a056000188300b00205c0cb33c6mr1802756wri.39.1649147655658; 
 Tue, 05 Apr 2022 01:34:15 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 f18-20020a5d6652000000b001e669ebd528sm11209607wrw.91.2022.04.05.01.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Apr 2022 01:34:14 -0700 (PDT)
Message-ID: <b997ceac-a391-cc5a-a397-0d68f91736eb@grimberg.me>
Date: Tue, 5 Apr 2022 11:34:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme: add namespace paths links
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 util-linux@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
References: <20220401092855.90652-1-hare@suse.de>
 <20220405054205.GA23466@lst.de>
 <289ee526-8f3f-9a2b-eef4-70816eb4f42e@suse.de>
 <20220405054836.GA23647@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220405054836.GA23647@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_013419_509947_794679A9 
X-CRM114-Status: GOOD (  14.35  )
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


>>>> It is really annoying to always have to loop through the entire
>>>> /sys/block directory just to find the namespace path links for
>>>> a single namespace in libnvme/nvme-cli.
>>>> So provide links to the namespace paths for efficient lookup.
>>>
>>> I think having some form of links would be useful.  Quite a while ago
>>> Thadeu looked into adding some form of relationship for lsblk and
>>> friends.  Maybe it would be good to sync up and make sure whatever
>>> links we are adding would be useful for all users?
>>>
>> Care to elaborate?
>> Using the block device name is the most straightforward way here; we don't
>> have a good enumeration to leverage as the paths are essentially just a
>> linked list.
>>
>> We sure can have a subdirectory 'paths', and stick the links in there.
>> If that helps with lsblk ...
> 
> I personally don't care.  But I've added Thadeu and the util-linux list
> to get everyone on board.

Why not stick to slaves/ like the device mapper?

