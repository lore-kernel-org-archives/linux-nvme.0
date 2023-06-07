Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE640C77B7A
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7+4xPUwHvVelzfYLHlCNeAJmR4fuqXl559NZ4EWZ/qY=; b=mqiIKC3iAO08bNRC5YOqZGOg+J
	g+T3oAqUEi/eM+e/Jxf+Pi0Pn+M8ysLCyYUmNeSRBvThRMd4i1GKlayRnSDDxdftNGp+YuJ3S9TQx
	QG4Lj1TM8uHrwf7Amr5UFgKtK1327x08xAhTqKn+IYJHL9ZpkizdSq4g5FZAetssdTiTwb1Crn+RC
	7otErAU3K41+14UQC3IXrPJ0LvmVD2z7IyRfsUl9D8NAUCPDrO99g0tiNLpDsZ7U4JcAAbpEIQ0sG
	Kb3v6+P0X2hC0vA6tFzTrXbhcd35JIxiPQtK41DDx0VsLv2YGCSjXuwq1AMXouo5S7tUfPAIrmjhA
	6xvhY3Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6udE-006Kln-0I;
	Wed, 07 Jun 2023 14:59:28 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6udB-006Kjf-1d
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jun 2023 14:59:26 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f7e7a5aaacso4849225e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 07 Jun 2023 07:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686149962; x=1688741962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+4xPUwHvVelzfYLHlCNeAJmR4fuqXl559NZ4EWZ/qY=;
        b=MOd622G3vSHfhTVxlHLGsZAO3+V6Tv7UpNxWHD+5zhbMRoK1ssEA+Ayn5UvowlNWbx
         VcVwGolwW6ZrZQoqY757FygyiPEpFYaIr96oM/h3OsW+m36hwhvxyWgQM1dFjvkRjiSp
         vx+v23VepqA0bK7qDgmeeAMsL/E7pE3zSgr1Rul+OFEjRWxiY0GKkgy/GMqRSxnBsgpY
         fEjNBcKy4Te0C+4ru0LWBMjCV0K4Hr2z4Q+UE6YzAW+Yd5z7GB5nZPr+7lm78iVy8gPv
         v2oMlYXMiuw2RMHQSE9eqgkDuspeitYGmdua8NSPhWbeWJ9fBP5jlf23NRHHrxNUPhqD
         RapA==
X-Gm-Message-State: AC+VfDxgx8GLHNOCI1rze4I+syHfthotQ8j0JMQOOuForKeVQ9jMvIOw
	BlLS+PP3iJph0KNWNEmTsRs=
X-Google-Smtp-Source: ACHHUZ4Vbf2qZbr6TlCePHTLQ1lzWxp7vPcSd2Cj3IyTfa8ywzwxD6V4KUK8Bw0Th0viKNFMZQzjBA==
X-Received: by 2002:a05:600c:34c5:b0:3f7:369c:c640 with SMTP id d5-20020a05600c34c500b003f7369cc640mr2093960wmq.1.1686149962164;
        Wed, 07 Jun 2023 07:59:22 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f7f4b7f286sm755774wml.12.2023.06.07.07.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 07:59:21 -0700 (PDT)
Message-ID: <15fad8d4-1620-e39e-a506-65747f1857a7@grimberg.me>
Date: Wed, 7 Jun 2023 17:59:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Revert "IB/core: Fix use workqueue without
 WQ_MEM_RECLAIM"
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Maurizio Lombardi <mlombard@redhat.com>, Leon Romanovsky
 <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-nvme@lists.infradead.org, parav@mellanox.com
References: <20230523155408.48594-1-mlombard@redhat.com>
 <20230523182815.GA2384059@unreal>
 <CAFL455m3T4qrk0Uf5qK7-57Oh6L6AKionfs0mF-imUMYpbqBOg@mail.gmail.com>
 <ZHebeWlpn68Xa1Hd@ziepe.ca>
 <09504ea7-186d-9ede-e01f-87849673b9b2@grimberg.me>
 <ZH9wv6UNZtxhxrfw@ziepe.ca>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZH9wv6UNZtxhxrfw@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_075925_546420_1AE84A49 
X-CRM114-Status: GOOD (  13.00  )
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


>>>>>> workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_rdma_reconnect_ctrl_work
>>>>>> [nvme_rdma] is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_core]
>>>>>
>>>>> And why does nvme-wq need WQ_MEM_RECLAIM flag? I wonder if it is really
>>>>> needed.
>>>>
>>>> Adding Sagi Grimberg to cc, he probably knows and can explain it better than me.
>>>
>>> We already allocate so much memory on these paths it is pretty
>>> nonsense to claim they are a reclaim context. One allocation on the WQ
>>> is not going to be the problem.
>>>
>>> Probably this nvme stuff should not be re-using a reclaim marke dWQ
>>> for memory allocating work like this, it is kind of nonsensical.
>>
>> A controller reset runs on this workqueue, which should succeed to allow
>> for pages to be flushed to the nvme disk. So I'd say its kind of
>> essential that this sequence has a rescuer thread.
> 
> So don't run the CM stuff on the same WQ, go to another one without
> the reclaim mark?

That is not trivial. teardown works won't need a rescuer, but
they will need to fence async work elements that are a part
of the bringup that do need a rescuer (for example a scan work).

So it requires more thought how it would be possible to untangle
any dependency between work elements that make use of a rescuer
and others that don't, and vice-versa.

