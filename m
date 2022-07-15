Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B076C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 23:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OUhFNdoayRnfhDVjmY1UcFA6crmBOplqqO2jHduu9cg=; b=fDRNAivf5rUA++QZQwaYLJsPkt
	1+D8KU9AOyPrxoQoTfrcMetWLnwxupfY+tqLvLQygdbqX2Bcn7o3XfXlWHGiXVqlRUpr2mGbHCJGD
	yC7mLgVsPU/NmUzpAU6yxB4rh1Ezctbn3NZe9IjAbhpJ/eFBtx9HygOtUmfF2VI1r9ogCnjPL/GFo
	0s5nK/NCpimRAG/nNKgYxf0uQcTmP124PoxBEw4q0YKi1tLS8BVjTVoaGdKIL49sLwAWhT6YoH6KR
	gGXIBTX8AtODyK9fvtv7rb1a0wOFLSO2FZqUEEoS/Wo0YsLmtanMdrCmC0nMnN5Qfi+6yLKoS5hng
	/Apnx/MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCUky-00BAWC-Sz; Fri, 15 Jul 2022 23:30:00 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCUZV-00B4B8-0v
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 23:18:10 +0000
Received: by mail-pl1-x62d.google.com with SMTP id v21so4375824plo.0
        for <linux-nvme@lists.infradead.org>; Fri, 15 Jul 2022 16:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OUhFNdoayRnfhDVjmY1UcFA6crmBOplqqO2jHduu9cg=;
        b=gCYaU634v/gTJWGxKwyJyKzUNg3NxPXehyoZvBGvkZOa7XsJTeadx0oVGFxRSKF/Ex
         8jJ2GOkTjoBKU+7Oex5aUq0mdqzB3V1PkjE3qJyiZyfbTXAWNBvmqU3swNPJ4wxYjrFU
         KX5Nccy4mpZ0a8PnJiR7tfVbIzpFJ7JF/qhnyAEr/XPMVHNfiksxjNPr2gh+2+MxU9GB
         mSnjnsjaI4agsw4dbGBsuLy0x8zBiQoO/AdQEWjoz1SAtpq6RPrp39MNSeHK+tjvYdLh
         9+NGChnjvPLfIBDVX2q7kpK7stDFrdURM9jbpaEFdAgH6y58t0BB9kyeOf3LnkrpB7E0
         Giow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OUhFNdoayRnfhDVjmY1UcFA6crmBOplqqO2jHduu9cg=;
        b=nSt4/YWOJsvIkFp+cnzgh0eT8tYtBuOvebjDRVb1GuTrKVilEZgVbZX/o4h1iILRIL
         svxYD6zqzc47AU7KQOfwi27ptE5hpHMNUK8tuXNqq/NWdy/sBGk+Up65leN4f9u3/zTb
         TyaSuZ/ZtZA7WoLqsqotmWIoWSN+ZYcavSNr9dsCO90AoodL57msW21bg6MmZUoZo2Wd
         F1/v1pg2mY/VXEP/lt9nGY5gtnsrL7RyymkhT24BnKaEcSN+DdQgd0EhrYOKKoa07dwP
         dhlYvbDaxcZWR2Jg6OIztTUuaZbkjnI/cXpodHslU+2dS8zcAuOwidZohPaU4uNcJcF8
         bQ3A==
X-Gm-Message-State: AJIora92AxStdmZH4AMLtsyXHsKepC1VpTpyzub9ojtMOHLInSLiJf5J
	pUmrWRJy5PAXuhy6SGPem2EBLQ==
X-Google-Smtp-Source: AGRyM1tdyJFRZuO9w48l1eL9unCDRXPDAMCfbuKDgr7RQxu3LMmhIaSKiJLOcx/ICh2HJ5VjiDGr6g==
X-Received: by 2002:a17:902:778a:b0:16c:a1c9:7b14 with SMTP id o10-20020a170902778a00b0016ca1c97b14mr12582774pll.116.1657927085866;
        Fri, 15 Jul 2022 16:18:05 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b0016c59b38254sm4198801plg.127.2022.07.15.16.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 16:18:05 -0700 (PDT)
Message-ID: <27b03030-3ee7-f795-169a-5c49de2f6dd2@kernel.dk>
Date: Fri, 15 Jul 2022 17:18:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd file
 op
Content-Language: en-US
To: Casey Schaufler <casey@schaufler-ca.com>, Paul Moore
 <paul@paul-moore.com>, Luis Chamberlain <mcgrof@kernel.org>
Cc: joshi.k@samsung.com, linux-security-module@vger.kernel.org,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, a.manzanares@samsung.com, javier@javigon.com
References: <20220714000536.2250531-1-mcgrof@kernel.org>
 <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
 <YtC8Hg1mjL+0mjfl@bombadil.infradead.org>
 <CAHC9VhQMABYKRqZmJQtXai0gtiueU42ENvSUH929=pF6tP9xOg@mail.gmail.com>
 <566af35b-cebb-20a4-99b8-93184f185491@schaufler-ca.com>
 <e9cd6c3a-0658-c770-e403-9329b8e9d841@schaufler-ca.com>
 <4588f798-54d6-311a-fcd2-0d0644829fc2@kernel.dk>
 <d8912809-ffeb-8d88-3b6b-fd30681ad898@schaufler-ca.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d8912809-ffeb-8d88-3b6b-fd30681ad898@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_161809_111847_95A6AB72 
X-CRM114-Status: GOOD (  10.88  )
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


On 7/15/22 5:14 PM, Casey Schaufler wrote:
> On 7/15/2022 4:05 PM, Jens Axboe wrote:
>> On 7/15/22 5:03 PM, Casey Schaufler wrote:
>>
>>> There isn't (as of this writing) a file io_uring/uring_cmd.c in
>>> Linus' tree. What tree does this patch apply to?
>> It's the for-5.20 tree. See my reply to the v2 of the patch, including
>> suggestions on how to stage it.
> 
> A URL for the io_uring tree would be REAL helpful.

https://git.kernel.dk/cgit/linux-block/log/?h=for-5.20/io_uring

That's the pending 5.20 tree. But there's really nothing exciting there
in terms of LSM etc, it's just that things have been broken up and
aren't in one big file anymore.

-- 
Jens Axboe


