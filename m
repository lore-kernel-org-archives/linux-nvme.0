Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10369EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 07:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TgDpH4Pmwhb+8zfjClR8p7ZuBuHg8+1VxoH4Zuhey8c=; b=OaD0/MNYNdbEtNSSY8FwxFNj+O
	30faZHacg74unqKImF4myCt2jQBxOutKCUpQfVVXFN4mCsWLC+Z05YR74Mngpf1DywdXnoioo5/kf
	s8GFqm4D+sAWr5Zx8X2fW/QMmz5ri/GFwjefaeLFPoTl3JPbunNg/8iG5De8wM6UOUVeDsvY6XqPY
	5CtuDBdbsAgfOlu7MuZo4xcQNYVz6X+N6gfVAkN/VtwxWH5C1Z8QDc9JS3pgYlTMSV4sDzqZo1R+/
	irqC/AoxP6jgraWHT59wvs+eZmty3urgQ4VoeCK5/7eAKhCRN1DSbZNLUiieWY1jDVbl7t3Wlkgzi
	K6xR9blA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEPXu-00F3ea-2i;
	Wed, 28 Jun 2023 07:24:58 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEPXs-00F3eD-2E
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 07:24:57 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3fa86b08efcso8946555e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 28 Jun 2023 00:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687937094; x=1690529094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TgDpH4Pmwhb+8zfjClR8p7ZuBuHg8+1VxoH4Zuhey8c=;
        b=XQ0GSoIxjaWiBXNdlTTD3zMA0+p1suYC20jx7EiyfRDAKOuXV9ckS7dhg2nvsIP4id
         dhpcPCxs3J+IfNPkwewp04eWX5tVWds4TPAWK/QRj8wWHY82ES9d9t68rT356s7PmFgB
         ssarUPm7zcmVuFvGQ2Vvz/SagukY7d9mX6OGxz4G1+IZVVT/8cE1Pv8iq4HtlKoEOanS
         0aX9Ax/d86jYo5Q2nqVM5TaMMLkl9Qw/eZEmqUziJQeHevocilfd4BD8VtVFi3qbuCgC
         +jZCg51c76Sg+TJtEGoR9h6Vgy3MaBfxhs/3EspIqDhie9xL0bXjuWuQf2u4iJn8Yay+
         xtow==
X-Gm-Message-State: AC+VfDyKCeq8Pg40D5va5+pNfz16F7kESustKzd2rIok2dQolsoqiJ0c
	wnxd90Wop3gF9jZ7auSOejM=
X-Google-Smtp-Source: ACHHUZ6GHUInBdAHlPN+IxSwvJD+GK8guEKBNogTrcD/Je2luO4EeLOd05efMHol+TegiL+EaAvCwQ==
X-Received: by 2002:a1c:ed17:0:b0:3f5:f543:d81f with SMTP id l23-20020a1ced17000000b003f5f543d81fmr35619270wmh.3.1687937093793;
        Wed, 28 Jun 2023 00:24:53 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i6-20020adffc06000000b00313e421c620sm11678649wrr.54.2023.06.28.00.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 00:24:53 -0700 (PDT)
Message-ID: <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
Date: Wed, 28 Jun 2023 10:24:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me>
 <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
 <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
 <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
 <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_002456_751391_9A01957C 
X-CRM114-Status: UNSURE (   9.06  )
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


>> Yi,
>>
>> Do you have hostnqn and hostid files in your /etc/nvme directory?
>>
> 
> No, only one discovery.conf there.
> 
> # ls /etc/nvme/
> discovery.conf

So the hostid is generated every time if it is not passed.
We should probably revert the patch and add it back when
blktests are passing.

