Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2BAECAAD3
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 17:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fhY5BsAO3EccpKtEZgbCGaBFbRC5YDp1VZrOGbRM0Hw=; b=dL06UKxN6lAthrVOQiuTNo4ORO
	8DjEXrCgjD+4gRbPAvLNTSez847VTGcxiiS0QRdnyIrXKeb2SYQDF9coAxBf4dLuSxXB735BlO6Ms
	Xv8CjBHcXwArb6yapEzsH52F/ZNSWm3swYPqcJkkV8oMU8rx3GmYH+ULyznqaaxWmHfIiKkaLiG5g
	4JKNHNrz2RynYuk2Q7QsfdP8QmYfVwpnPA4Rf1lry/zT1/DfK0Jy8p6cPSSAEhA5nASOrtasHLhDz
	HHT+mjvxVWMd9WcymY1KgdRXcuVKV0q9gA6Q5hK6BPO8JQZ5rkLhmipW4K0BUn5F9DAtYEcHFcbni
	PomqfKiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTnZy-00DTOq-WC; Thu, 01 Sep 2022 17:02:11 +0000
Received: from mail-ej1-f41.google.com ([209.85.218.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTnZw-00DTMV-CG
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 17:02:09 +0000
Received: by mail-ej1-f41.google.com with SMTP id lx1so35990354ejb.12
        for <linux-nvme@lists.infradead.org>; Thu, 01 Sep 2022 10:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fhY5BsAO3EccpKtEZgbCGaBFbRC5YDp1VZrOGbRM0Hw=;
        b=F6wbqFVjzfjOtON6zHcPjaavnfzGdO4U0shf7pftVEUwNPhq76Ok7lztrzBr1viDvX
         Zh9AVDfp3L/BsgHo3dLolbmTba0p5OK6k2naUEFF0IB2ME3TzZzNeIlHV6Pqr6JSRsQi
         QM2vYrg/FGObeqyNOoinYuSWV2N8XovNGlD8rN9fPqMoVn1lx3WgXkh++95YvrcZcUt9
         AdfowO1z4LUFiQQTgR2hnWltAHGKP/2WY00bV81VL9OsVwvwUY2+hQBU0l7F+NFGbMDc
         tGzDFHTBnrUaKq+9zhf1EuQDSPUWgFaaGqxgZmThvY6PrAGmyxixlhiMPUl0wBMOXt6x
         YnXQ==
X-Gm-Message-State: ACgBeo323bnvYfWykjGBRQbwXUT75x8evshtL6k6J6Pc0NEFutbKlARU
	JmCOD5tB2DylmM9aCAzUU/R7cv238yc=
X-Google-Smtp-Source: AA6agR7Q44xAK6rxpj7X79sQUAbBuUDwpIyegALfU+20H2CXirtDFuzELnpGauq3+zHAXUlW8pYICg==
X-Received: by 2002:a17:907:eaa:b0:741:6608:f191 with SMTP id ho42-20020a1709070eaa00b007416608f191mr16106691ejc.114.1662051724822;
        Thu, 01 Sep 2022 10:02:04 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id gh21-20020a1709073c1500b0073a644ef803sm8640074ejc.101.2022.09.01.10.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 10:02:04 -0700 (PDT)
Message-ID: <376e2073-439b-7113-48f4-862d3404c328@grimberg.me>
Date: Thu, 1 Sep 2022 20:02:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: nvme-tcp: i/o errors and stalled host from failure to send
 command pdus
Content-Language: en-US
To: Jonathan Nicklin <jnicklin@blockbridge.com>
Cc: linux-nvme@lists.infradead.org
References: <CAHex0cqr8Sn1ydFjRbwkG8LOMqBXEHL2YpYu_vO8658xLzouww@mail.gmail.com>
 <eb6b09b6-c899-e3b8-3217-02f8833818cd@grimberg.me>
 <CAHex0coajr37Xe_XE3sx+kgNosOD_d8N_SQcK=hT4NDAM8suBg@mail.gmail.com>
 <ca7d5545-4630-59eb-3e50-6ca0594ba7c7@grimberg.me>
 <CAHex0coXdbR28S1PPSGuqJRH2JFZ4VpTg8NzfWFpHyBehK2urw@mail.gmail.com>
 <CAHex0cqVOuSXf759Wdr3NS5gGCve+J-TUSNsvvbEpS7ONvFhMw@mail.gmail.com>
 <715a183c-f888-74f2-9217-b9b430f16d1e@grimberg.me>
 <CAHex0crz1FGrQKnWCrWTCWJ_GsMn5iMmNMtq-BN+nDDUajshdg@mail.gmail.com>
 <CAHex0co9JNwFkDpNvPitESYX6-2F8_n8phxzVsZFq2kieYLGJQ@mail.gmail.com>
 <CAHex0cr80EyJXN1gOgEXF9r=_Y8Z5N6=jxw=je_8Px3vab+qtg@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHex0cr80EyJXN1gOgEXF9r=_Y8Z5N6=jxw=je_8Px3vab+qtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_100208_443525_FD5DBB31 
X-CRM114-Status: UNSURE (   9.25  )
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


> Question: queue->more_requests is updated under a lock. However, not
> all readers of queue->more_requests acquire the lock. The smp_id/smp_id2
> values seem to show that the same queue was being processed on
> different CPUs. Is this a race between the kworker and inline
> submission?

The entire send path in io_work is wrapped with the send_mutex. Which
part is not protected with the lock?

