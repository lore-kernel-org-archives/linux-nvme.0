Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DB3C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 22:12:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05273613FE
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 22:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05273613FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=E+nfrYF1z05Rbf0h8/tDHDyeDAR2zF2A5cjTvOtNd8A=; b=anP5KInCETxz9b6YSZ0f2jqoD
	JJafny0eXVhpUaSHP95CD83qiACpAC0pv+8Pg1ZfnKe1cQRTl+m1HDNrKfyvfsoPH7Hee5zxstBQJ
	+3ig/+ov72cBojb7CaUx5A7ssps59PeiJjsaCkkMI/oIrLAiFRqFOV1gudlALIgvV6WpR41XXzzh3
	nlOCXi1tbq9/+gMSqzz/M88QpXHYdneCJrbQjHgbf2/eoW9x6eqUl2OeX4yfVk0Jb4If9fmGNR0cI
	Ujx2YFcWsrL8cQU7CUtMNPe1rvHwxFGXDjfxWiaLDufvDlTYHg+48Axwr99wM36tKOBfMH3RCIfhb
	vZdRtY4GQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgx5V-0048FH-Qi; Wed, 12 May 2021 22:12:18 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgx5Q-0048Er-MG
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 22:12:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=oi/wT0Nsitlj9r6GRry24ETT67PHuP4w/wuL9jWhkvo=; b=DF3zxYlHFc550bN/K46vRBI1/y
 T8BImeF9KNZsEMxwXQUX4ryfiz1sqgqcE/7o1rUvhQBYyCZtZUrwddu4KdJUgfiQXfkVhDZQwxW5F
 WexJegr3rcPDIIpxINEkEdpgUuwmMkEEewmFXFnZFtY83MWiy4GbjR9OPw7BCv3O4MlazGVkjBCgK
 raydNoH/0EKvPPheDKyzU/KQffaYZmD3nrZd6v5MxH8mccRYPUrK7o8wQdJfe7XzpqX6XrOv9WI0S
 Z67Ga9DQu1hMFLgpRd5ar1NDi1S6fycMgrbzhtulYqvuF2+p3VZJPcf+REq3n2OjcwiAXu3pKXXVg
 1WikAufA==;
Received: from mail-qt1-f179.google.com ([209.85.160.179])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgx5O-00Arcw-5B
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 22:12:11 +0000
Received: by mail-qt1-f179.google.com with SMTP id j19so18432889qtp.7
 for <linux-nvme@lists.infradead.org>; Wed, 12 May 2021 15:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oi/wT0Nsitlj9r6GRry24ETT67PHuP4w/wuL9jWhkvo=;
 b=AFbGSGnMlIL9VVSK8rHqIcWgFMsMAAMYRl55pOhEnO273m1eLyjvXozvm0voHiMXq0
 PAHP/Poc7gm/BPPX6uG+/0Uvu1VUMKCmuQvPASTw7lT73bYFVVtiLYQSDjQ2IUBbx/FW
 c2Spiz1e+l/VhIwUQT25EW/1GPLSv/i9W7m6OtPqjLBSmMnh6eExYKD5WXwpionkQvte
 eVcCI4k7SQnVuUnDx4EfOBOLBjeeJ6xspWBBH7IG7d1s9h1kuUc3R9qrLs37YQamuUCl
 s9rRKuLRmXcHQld8DdjL8+0BCtzMBsKzlnDyLQsMqXbArw5StBA84+7eWArv8K994+/O
 Eedw==
X-Gm-Message-State: AOAM5339rBmTs+6oPTaqg7PxEK7ewxlk6tfUrWNCDWqWTk3i+w21hvwk
 XaTdatcaY9Q5FLuyGAbrs7c=
X-Google-Smtp-Source: ABdhPJxN0/SUjSLxn0JWNV1EXSEzp4jXHhqM/CNosPfj6HlgohXAC4ckjc7ko6VzUYOQY+xIE/+ZGg==
X-Received: by 2002:ac8:5f47:: with SMTP id y7mr34842388qta.284.1620857529106; 
 Wed, 12 May 2021 15:12:09 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848?
 ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
 by smtp.gmail.com with ESMTPSA id f12sm956433qtj.26.2021.05.12.15.12.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 15:12:08 -0700 (PDT)
Subject: Re: [PATCH 1/1] Add 'Transport Interface' (triface) option. This can
 be used to specify the IP interface to use for the connection. The
 driver
 uses that to set SO_BINDTODEVICE on the socket before connecting.
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Hannes Reinecke <hare@suse.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
References: <20210415192848.962891-1-nitram_67@hotmail.com>
 <b47456a5-69ae-1f33-30f0-aa25906668f2@grimberg.me>
 <27a0071d-7c7b-ee5b-41a2-d5eb8de12928@suse.de>
 <SJ0PR19MB45446577ACEA270069ADB738F2599@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <dbb70739-e636-7f4c-7332-1fbc07332444@suse.de>
 <07fa3404-ed37-052a-c2d7-0e21c119f5c5@suse.de>
 <SJ0PR19MB4544F01520BE86D205B41B23F2589@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <b511b6a0-392f-9845-8097-1f2173085ce0@grimberg.me>
 <SJ0PR19MB4544420019D202816F4392DFF2549@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <7b0d0915-961a-0af2-7ea3-77f59cd98ef1@grimberg.me>
 <SJ0PR19MB45449EA9215D3EB116E1325CF2549@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <60aa6be0-ca88-bab8-c893-4c2b1d3f8baf@grimberg.me>
 <SJ0PR19MB45449B142BE6DC506FBABA72F2539@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <9c7d43e1-e13e-43a9-8212-ff48467d3a49@grimberg.me>
 <2d747a9f-d29d-de1c-7bdc-69e11bf5d9da@suse.de>
 <SJ0PR19MB454488E95A2A00E5ABC757DBF2529@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <321dd5c2-9946-6e26-1617-2cb1466ccdf9@grimberg.me>
Date: Wed, 12 May 2021 15:12:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB454488E95A2A00E5ABC757DBF2529@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_151210_225384_DCE6B196 
X-CRM114-Status: GOOD (  12.17  )
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

> Thanks Hannes and Sagi. I will resubmit the 'host_iface' patch after running more IPv6 tests. Sagi made me realize that IPv6 has a few subtle differences and I need to double check that the current host_iface implementation works as well for IPv6 as it does for IPv4.

Cool, thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
