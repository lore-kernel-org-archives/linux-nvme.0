Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341D1C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 04:11:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B859164F96
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 04:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B859164F96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uhlNfnJ9qX4wz5EkMyQz5d1+YUw9hlp5pcXNQ4YisV8=; b=OjAmr4Tkk6YDKjIGkHTvYmfVY
	Fp8ZLvOR4Xr6+KSxypuASnGy9CaZO8THzV+GaeaOsmFXQnlan2Dt1qgCqcfMtAZTZ3hufBavWYDYn
	pKs9slpoGzWNCK7DXNGd1sABwueweWKNQTwXIUyAFIY+F09S7vu1Pn80SP7JvAARhgzjgHUwAd34o
	55O2WSzs6zYLKbbBIu0QqeAK+4cnlajnyNMU4jC9xzqYtWAzVLKSLZCFbocU+itqwSR//hXqr5G3S
	OVPWQqEy+3bUs/6kO2RikL2vjoN4U22AJvMZngK0DjgEtqTjoedy2YPQdvx8/65rvA8P7dKCULl+R
	0PnohCxVw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMNX3-002QzV-Vo; Wed, 17 Mar 2021 04:11:42 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMNWv-002QyG-V2
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 04:11:38 +0000
Received: by mail-pl1-x636.google.com with SMTP id o10so131418plg.11
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 21:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=RhMjCYe6RDtJIawAITx3Tquydw5vnWOLOen0FSvT2rw=;
 b=t4oO2Ke5pUJuZxGD0UXcNlxPC1IOmkG1Vj83f7ZYKax5lmoechPUPZ5QEXqwj1FCfx
 Lrk/V6mYk/qCN0oNRYZlxZ6veyjSmiFLISID8Ih0Xt/H5dvEx41j/xBSA/71uglaNcQA
 TTLOOZ32hjLN8ckRCP0pTRCjPmAV2uzpintGXCsMiDFpD7KdIPLqNvkeziAgKHpDrxW9
 CekFyUCDhuLboEnv1xT29YvUHO6R/MFfiwGzNwXtVxn9p4Drhhg0LIvhiQV06DPDf2Bq
 8qFu99DnZjosF131tlmWZXi8lh00LUuhnUF//xPyue1pU0Sg/NLfO9qOU/O5cNCxKQy6
 +W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=RhMjCYe6RDtJIawAITx3Tquydw5vnWOLOen0FSvT2rw=;
 b=lxu2f38GRX/vP7eIItzF0bxNPgwFcWYp2PqLPiFHpV/fq/HePEvhCphJZefvqMRzik
 dzv6JNENtNDIYI1fdYaCVrcSetCNrdY3a3I2l1EaGjwx1J/l6VGr3CfAsc/bwgNRbEkb
 CWCYCFB5y7PCwVyIVU64Z6z2oQNfwI3O5aOh6QJvwtMmdrxw3uuLz745hxDQC3vTdgxZ
 BO5yzCNqWt0f9zpiiee1Z8DVoP4Zv4Etq85OUL29Z3KSTeStpBCWtXmJQNFygSfj84GJ
 ITu0fjStWIw2jEQWqSy0m5w3BTNBxZkm8b4vXNgJKnGYpyA8kZfgAMQnCA/cT4O0+iiT
 4zdA==
X-Gm-Message-State: AOAM531ft7ZJ95HHEF/qMg6/T8aK4Mup53Hcr44hRPYnUY+0x3OGRW7J
 wDai0/jMrmR6vDTdHI+2XIFg1CCeObNybr3H
X-Google-Smtp-Source: ABdhPJxjcy/5udvxI7Ch3fbAMs/d0P3Ohg1WKjW6poMPHZAeST5iEh6txvZou82PL4/aslhxWTHHNg==
X-Received: by 2002:a17:902:c1c4:b029:e6:7bc9:71fd with SMTP id
 c4-20020a170902c1c4b02900e67bc971fdmr2455161plc.5.1615954291952; 
 Tue, 16 Mar 2021 21:11:31 -0700 (PDT)
Received: from houpudeMacBook-Pro.local ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id a15sm812956pju.34.2021.03.16.21.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Mar 2021 21:11:31 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error
To: "Grupi, Elad" <Elad.Grupi@dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
References: <DM6PR19MB4011D61F1BF2A4F66228E9EEEFA50@DM6PR19MB4011.namprd19.prod.outlook.com>
 <20210316093539.16125-1-houpu.main@gmail.com>
 <DM6PR19MB40116B3A8A9751C4BA926521EF6B9@DM6PR19MB4011.namprd19.prod.outlook.com>
From: Hou Pu <houpu.main@gmail.com>
Message-ID: <e7286d8a-a364-fdf9-c839-7c5976b4fc70@gmail.com>
Date: Wed, 17 Mar 2021 12:11:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB40116B3A8A9751C4BA926521EF6B9@DM6PR19MB4011.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_041134_291338_DC922861 
X-CRM114-Status: GOOD (  14.29  )
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


On 2021/3/16 11:52, Grupi, Elad wrote:
> Hi Hou,
>
> You are correct, this is the same issue.
>
> I have reviewed your patch and I have two concerns:
> 1. As Sagi mentioned, you might not have all the inline data in the socket at this point.
> 2. You might get hit on the last round of the budget of the receive loop, so you will still have a chance of hitting the response flow before reading all the data from the socket.

Yes, I realize my patch has these problems.

Thanks,

Hou


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
