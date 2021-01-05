Return-Path: <SRS0=mRFX=GI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647A3C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37BD22D5A
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37BD22D5A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Xbj0GRWvb/OOaM/8qFas48XLStbFc9LwjtEVtgTR8LQ=; b=hl/d8ooOOou2evJ9//kd5dOGT
	6gkLzTZIq8ISTqgUWSYTqszzQtmovo4U/4bMXjbHPsleU/MSVKLsCRV89QA1dYhqu7CeWeq2K69yM
	htkQwcuwlRTwQr7nBk0YLd20T12oBZuY61pBVkrG44SiWNoiuOdvBBuLF7U9nxiC1hnfuWTpuZVMD
	5qSrGiimTrsTBt+cXlvUmqmaCU/rTLXtmNgwBncl+3lkVN0I0+SOQWisJPPFMCZP9/WxbWLxCWN4p
	xr/N7IAGldxIZU/gejSbIxhOu9ULtxqpVfuRp3LS51SD01317UhOw4jDKRNbsnhbp+3kuv5LndQWi
	fEgguUZ5g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwsGo-0001SE-2L; Tue, 05 Jan 2021 19:45:30 +0000
Received: from mail-pg1-f180.google.com ([209.85.215.180])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwsGl-0001Rf-5s
 for linux-nvme@lists.infradead.org; Tue, 05 Jan 2021 19:45:28 +0000
Received: by mail-pg1-f180.google.com with SMTP id v19so531287pgj.12
 for <linux-nvme@lists.infradead.org>; Tue, 05 Jan 2021 11:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dOKcdHgwLsKq51svGXxAsgsUpKjGWKFDGU5xECA6lTA=;
 b=S3W4e7k6EX+7xwwakFfQ1mY/Y7phYIREzGxAnXi5iYFK8c3gCSdrBwQxPCVwhZS3G9
 DADLG7RZ5aAhulAesN6uq0lP0xv5enaIpV1LMbIzz02bd4JC6Y6+HZttVViS8AqGwk+/
 fM/75JrjSsS4nkTO/yHmy7XtDpxTG6jILKVXeGAvMd8DNAnuBPJ4sZhDkOI2Lkv7QBVt
 kvjEuNsfJNwe2DepHbFBap46O8RD/Kem5dTAjnF3GQZjobu4bj/6GJse6SAmG4Gs/+5z
 FqycctRj316t7XVP0eI9cttNV/OKs2blF9PXB+m5I/LjTXaN0gS8pSQi+yvqwP7qhrll
 7eaQ==
X-Gm-Message-State: AOAM531rT3B6IX7T1dw82S0DHvMz53F7MzjQqW+tZ9GeQ4fvmaBBQWkW
 l1wB1s/d0DyTHUtDD6Bp8XDGGXp+zfo=
X-Google-Smtp-Source: ABdhPJzoxzIbvGKnIJvVXNMFouhQVMW/qaXqDhYXrul1evK4NNqgUOUNgWd+p2iT3zY7H2/ITqOgAQ==
X-Received: by 2002:a63:5309:: with SMTP id h9mr845063pgb.19.1609875923465;
 Tue, 05 Jan 2021 11:45:23 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:8cad:710d:d1f1:8ff1?
 ([2601:647:4802:9070:8cad:710d:d1f1:8ff1])
 by smtp.gmail.com with ESMTPSA id p187sm185147pfp.60.2021.01.05.11.45.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Jan 2021 11:45:22 -0800 (PST)
Subject: Re: kernel panic in nvmet_tcp when receiving malformed admin command
To: "Engel, Amit" <Amit.Engel@Dell.com>, "Anner, Ran" <Ran.Anner@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BL0PR1901MB2067C827A2D826C0FBFE985591320@BL0PR1901MB2067.namprd19.prod.outlook.com>
 <cee26269-c9c3-7ce7-8486-4ed16a632e44@grimberg.me>
 <BL0PR1901MB20671CF789D8C246AF911B4D91330@BL0PR1901MB2067.namprd19.prod.outlook.com>
 <DS7PR19MB4439372515F931BA5A1578ABEED30@DS7PR19MB4439.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dec5fc1d-62d6-1c1e-e2f8-4aa5aeb084af@grimberg.me>
Date: Tue, 5 Jan 2021 11:45:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DS7PR19MB4439372515F931BA5A1578ABEED30@DS7PR19MB4439.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_144527_248472_8E572C70 
X-CRM114-Status: GOOD (  11.08  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "Zinger, Eldad" <Eldad.Zinger@dell.com>, "Grupi,
 Elad" <Elad.Grupi@dell.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi Sagi, is the patch addressing the below issue is already out there?

No, thanks for reminding me, I'll have a look into this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
