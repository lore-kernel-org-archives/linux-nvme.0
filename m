Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B645CC6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5s2Yumf5Kngh+tkGzYfQ7Mu6CM8tGxQHFGYngiihKl4=; b=aEn/3LzZ5bi1WZCiYomb4Ppkow
	zw2VCfsCJ5CKCSM4vQm3RGY7vUqeACpIdFzqRDdkboPN5BXp8BIRZzAjocDn1n6XyPrMlk9DEe6gL
	QuXrDaImVobsTmy9u3KVFBnJuWW+NGMZlD9HrsL6ddVvL4N8hlsbQzlZBYce02P51NzA2bhkDhzjZ
	Fy1t5LSwFuetYoF2vZsvw4DJnspWvkpxtco6TO5S1ZeUs/g2PCBpSku9bEXagApOpKIlGuKaVDcpj
	xmcC/BOr9DZtFiUzSdCII347I1pznz25wejC3G02/5NAX2EtUOilYkhbill6R+UAJNdBKhEcrSF6i
	8/fUR0pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peXnA-00Bnzp-2h;
	Tue, 21 Mar 2023 08:56:28 +0000
Received: from mail-ed1-f52.google.com ([209.85.208.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peXn7-00BnyV-2d
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 08:56:26 +0000
Received: by mail-ed1-f52.google.com with SMTP id h8so56708079ede.8
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 01:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679388983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5s2Yumf5Kngh+tkGzYfQ7Mu6CM8tGxQHFGYngiihKl4=;
        b=MoBhwhuwZRGgjRPP3ybeE4PkCnq3qJ3fK5L7ujMIomJB6DzQkSep84pPsknLmN3X0w
         C5W973nKa5z/wh2LecyoKWQBaQl3c0wL4XSSYX8MC8SX56BDNEJWnZu03J2I9/l5dTGj
         iEAcXKdWeAPZJW6oRNh/qBqVwnFDPqAsVintK9EA3DcNOKvB8tm71ybhDHc6eJcNhMTa
         Fhvrb3yuV4jNg03BFFZDwKo22dp+o0y2QQa5BmtTh63HL326uCSPwN+UYkYXvhjuyN3j
         tsmYrNKXJWE1Jlh627b9GDCJTSsy/Oo9EiLgSCyKLdGxdcAtUawvTJV845kxeyQw+Tiu
         U0mQ==
X-Gm-Message-State: AO0yUKXFz+C51OqVl13WuD9o9Xo498b3b17B8myG0OQye3vZEGAmcuT/
	dhkBJlrq1/Y/cW2Fq5VoWzgLVZbis0w=
X-Google-Smtp-Source: AK7set9Cl/WN9qXnYwZxINeuMQ7rGyASgbxfsPafXxY2vJ7SFHFClXGM6mCY4B6xfaVKiGfQSPaSfw==
X-Received: by 2002:a17:906:2081:b0:8d2:78c5:1d4e with SMTP id 1-20020a170906208100b008d278c51d4emr1927178ejq.5.1679388982879;
        Tue, 21 Mar 2023 01:56:22 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id r4-20020a1709062cc400b009353047c02dsm1839343ejr.167.2023.03.21.01.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 01:56:22 -0700 (PDT)
Message-ID: <a3d023ca-ca00-8207-2f89-fad23eddd58a@grimberg.me>
Date: Tue, 21 Mar 2023 10:56:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ZBJFnEY664s1Hm/E@kbusch-mbp.dhcp.thefacebook.com>
 <32741f55-f5aa-cd59-351c-df87ee2b2818@grimberg.me>
 <ZBMz1FUB3qJGKXeW@kbusch-mbp.dhcp.thefacebook.com>
 <6232d774-bc94-fae8-bab9-7151fde4f719@grimberg.me>
 <ZBNPs3ukEpbm/NSn@kbusch-mbp.dhcp.thefacebook.com>
 <bd0c1ec4-edd2-4225-c4d7-b091bde26494@grimberg.me>
 <20230321082308.n6ed7ieu5jdb2gj4@carbon>
 <20230321084917.s5xqklrttauxilnx@carbon>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321084917.s5xqklrttauxilnx@carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_015625_854825_0F52B99F 
X-CRM114-Status: UNSURE (   8.64  )
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


>>> Thoughts?
>>
>> It still crashes in the same way with both patches from this
>> disucssion applied.
> 
> annoted the __nvme_submit_sync_cmd:
> 
> 
> [  210.019050] nvme nvme0: rq ffff8881122a0000 bio ffff88810d8cdd00
> [  210.022653] nvme nvme0: rq ffff8881122a0200 bio 0000000000000000

Why is the admin queue created as a polling hctx?
It shouldn't be.

