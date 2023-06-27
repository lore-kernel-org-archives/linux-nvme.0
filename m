Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552DBC0015E
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jun 2023 21:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7q5GBtuXaNyU+uOoX34ux3w5E9Nu9wE8cDGL5AcPmEk=; b=O1RUThO2eRVhPp7l6o6tss4akv
	xxdQGOMs01WOnoHCIdZlAeBgvKUF+bpzech3ZrPJukK51E9UyvlTZlBikNr3E03/bFj2uM8qJH35+
	82ebzVTfj/yfnq6b41VnvBdrPB34Rv4GHCrBFDNmkkQBZE7MWhjkhZsHg2IkHWJDrHA1ZJXdBx7M3
	7nX4+e0CwnH6kIL7d86z/6lBSxl/xM3vlHzHiCgzOrHqep79FX6Np9mvP8PNYf8QKkL9qCfWXNivd
	VUgUIZzF5gCOPTruQFTVTF7aHAzX6cts4iP/SpqY3fIyk/ILQXdJHdF4GRAGkIQvb3rViZuF/jijv
	frA7y1rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEG7h-00EC6B-1K;
	Tue, 27 Jun 2023 21:21:17 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEG7d-00EC4s-21
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jun 2023 21:21:14 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fa99b4f71fso6607245e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 27 Jun 2023 14:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687900871; x=1690492871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7q5GBtuXaNyU+uOoX34ux3w5E9Nu9wE8cDGL5AcPmEk=;
        b=FXYCcxDrAJP9Cpcj3A/SuR4pimrn89/lNvgm5Ae2mmUV2JHlmuzBQ9ncn0y54vvgRt
         uktRn148k2/5ujtreJpqqJPZlcrtHIGhpdeJHvozGiop3QN2LvL9y1eKYw4+h/XH9oST
         8NcPplIucYNbC+DZ4fJQqzLDnv8+Akzm13DMkeQGfY0XYxGodobFa3npgRUDdmSuteWu
         HNVYLp/OYd+KyzlElECWjUQ4ke/FRcuB96LVeaJSTbsnbBOrU3Vqjc6RPAtqn1ZBuOuc
         jDI+tVEG5MlmYl6PZ1lMo+vC7BYWUI/13U+rMZ/BQ9mIt14wvDrEfqFlPq7J3La79KrV
         eUXg==
X-Gm-Message-State: AC+VfDw9D1ncTjvy0H9oIunKpX3KMLeMj/i7EBZtF0yIifICvgtEE3Wl
	mG8qmwU/4XOld17p2oYtYuk=
X-Google-Smtp-Source: ACHHUZ5RghmTPJFm2Gbp40AKuHZrK+hsjI2iaUF9s8mBLWhAcUQHvDe6h2lJouwNooN3FPkuCHepow==
X-Received: by 2002:a1c:ed05:0:b0:3f6:8a3:8e59 with SMTP id l5-20020a1ced05000000b003f608a38e59mr29420979wmh.1.1687900870644;
        Tue, 27 Jun 2023 14:21:10 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id v14-20020a1cf70e000000b003f9b2c602c0sm14887146wmh.37.2023.06.27.14.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 14:21:10 -0700 (PDT)
Message-ID: <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me>
Date: Wed, 28 Jun 2023 00:21:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>, linux-block
 <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_142113_665228_FE3729D3 
X-CRM114-Status: GOOD (  12.99  )
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


> Hello
> 
> I found this failure on the latest linux tree, and it cannot be
> reproduced on v6.4,
> it should be one regression recently merged to linux tree after v6.4.
> I check the commit recently merged after v6.4, and found below commit
> touched the related code, not sure if it was introduced by this
> commit.
> 
> commit 959ffef13bac792e4e2e3321d6e2bd2b00c0f5f9
> Author: Chaitanya Kulkarni <kch@nvidia.com>
> Date:   Thu Jun 1 23:47:42 2023 -0700
> 
>      nvme-fabrics: open code __nvmf_host_find()

That just moved code, no functional change,
most likely the below was the offender:
ae8bd606e09b ("nvme-fabrics: prevent overriding of existing host")

