Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1E6C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 13:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jH2spHwV5nu3maNbrDBOWfulEQrrhO2gPLLrHYGmCbA=; b=zN1pxuZ8kgYvJGiMpab4ZI/ZNH
	RVITc+G8VmN8UOYXDyuhQXtlt3uI5wmm8SI3CdIZMDHoGQvAmqQGd9tai/hYJbX3iW4m/Nn3i3IcS
	3eUY5uIKwrzNYNHJoNu2X9p+ugRNqucwve7swGkHKYL8ktuR6sdLNKVqbQgBuLmBorH3NbbAyM0Ea
	F3QsxIKPzkah8LwIlU5f18XuVya4k2WQhdfZ+LY/qP8l+CNoIuwYcMEbXwNsGu1BsM1DPMtB71PWC
	1/3PO3g/EMsiz7wFDfedFYyVvqgwuw15Wh3WrnYjlgBlNTpYDIX7emmK6/7qIoz/aa2CsbKWj3uSk
	JnjLpivA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncSCM-00C8g1-S3; Thu, 07 Apr 2022 13:29:18 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncSCK-00C8ey-17
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 13:29:17 +0000
Received: by mail-wr1-f43.google.com with SMTP id b19so7834500wrh.11
 for <linux-nvme@lists.infradead.org>; Thu, 07 Apr 2022 06:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=jH2spHwV5nu3maNbrDBOWfulEQrrhO2gPLLrHYGmCbA=;
 b=DzzTgZf3aBAksxUESV6XkD2FBjqDGy/KXDilRE7dSnyEDZ2GiNFfjj/zekWCXqF3Q7
 ChQyTb40Wlov8ve9taC4OjbrYPrEtSwfZJZ7zQNJj4Z/5nLr0OBI4FCFu/Dhoee/QaKO
 wFdwn0o04jMUGlAeeSaH8TvDSEJ/4Ec5fSWh4/P7NW5TavSkGa6PyQnt2wMOOTvXRLg7
 4eWhGStkLCJBBJz68XhEkx9X1ML5Eo6rz72E4EKvuZpSgc8x3c0waYMQoDHYu8+MgZ4q
 XFb7ALUrC9CYX/u4DMHumihy8MFKg4OzMuIYrb6KFm+7Gq/3NNA6ka3m5uW873I9pVN+
 Bvqw==
X-Gm-Message-State: AOAM533Y41hpVpTBTIIqD3xV/hxC7rUZo0KTEa/MumOztYuKh8VmzeBe
 j2mwlkxif2mJAdXgeekRRvu+b5SyN4Q=
X-Google-Smtp-Source: ABdhPJw2Zwjcd/SPAtltqhgQMfzn72OSO6eyBb/U2xt1ECiRPfl3J6CjF6RxFubFJZ8rCm0jZ1zVFA==
X-Received: by 2002:a5d:4e08:0:b0:205:89b6:1d4d with SMTP id
 p8-20020a5d4e08000000b0020589b61d4dmr10631136wrt.124.1649338153717; 
 Thu, 07 Apr 2022 06:29:13 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d5912000000b00205a7d0c6a3sm16662544wrd.69.2022.04.07.06.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Apr 2022 06:29:13 -0700 (PDT)
Message-ID: <81dd2585-3c71-370f-70da-302072f3e9af@grimberg.me>
Date: Thu, 7 Apr 2022 16:29:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in the discovery
 log page
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220407104808.29007-1-hare@suse.de>
 <20220407104808.29007-4-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220407104808.29007-4-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_062916_112476_FA5602BD 
X-CRM114-Status: UNSURE (   8.54  )
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


> When a per-port discovery subsystem is used we should include
> all configured ports in the discovery log page, not just that one
> through which the controller was connected.

Why?

