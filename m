Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DB8C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 23:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dcdG1XdA8XnrnFa9/zZB6Q7Yu71aAFsf31yr3Vd3+3k=; b=JzwHLCwO8x9a7vwDS2srSifEt4
	/a3/XIeChhoXDnMTq4rfzxzRGMuFIMb3clVWPe+Jaiv00TJIPeApVfTFW4/g/2vH0YFTMIiR24QuR
	B1+6ZocAEaHovjrxbSgbn+EPxiuxFmprlzhYEoRKuJTR8wL/uezBe96XzFf+JjgJ1w2whvGLlIaQt
	jBzKFHIbq2Kzf73J4yOV2OT3CcW+8faM0ji2RHm2awy6g8KnucUXyHArTR1A3BkZDqbEQHGl6t+/3
	t3KsbEL7FcB4IAf+kBUFJLBvmIQcSaq9Mh0SyxQneGuq+f7tSkKGYbMpFKDn96jYXKfCDAR/HXc9w
	Nx2D0mJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6JCP-00H5GH-0T;
	Mon, 05 Jun 2023 23:01:17 +0000
Received: from mail-lf1-f47.google.com ([209.85.167.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6JCL-00H5FA-0E
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 23:01:14 +0000
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f61307827cso654848e87.1
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 16:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686006067; x=1688598067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcdG1XdA8XnrnFa9/zZB6Q7Yu71aAFsf31yr3Vd3+3k=;
        b=Vw7eZ5GjDqi+K0honoo4lcfDatjcQe/EkGfHPKC7ppfdxP5kS4TwOTCdnHd7zOvXYV
         /WCBBQjh8oGqLWXiZzVq5IxGTTzeWBU1pUGu7ylbzT1y7G1M4rD6oIrL+LP7fkvtdt8h
         QHnc/WyUNMhiWIR84pu5k1mHVvorYjZscJnVruZPrklbtsNkiNb2DF+pFwHWhagcYMld
         JNdHriCJ+sykuzq2vSUR2HrBTWWzR/PMLkFzye1AS9GmRLTKZgd1eo2/d6sYtLiyqZkd
         BFF3W7N6fAaKIi94gznrq69qm+b6G7MwDadG98gH2n00Xn5w09gORhodeDK8V2QyJ+6x
         tBew==
X-Gm-Message-State: AC+VfDwO+JBHb8xkrql8PZVG3nCxi/mAaXu5P6z1W14/xbnrVbDwMz0N
	XRgVZWd5RObq1Ajp/tyI2cc=
X-Google-Smtp-Source: ACHHUZ72eyIUbhKoNDoPk0vcakKw9lHDP1Lf/ZUIDhkt85YTOy+WpgALmUD8nldfFIZbrs5eupivEA==
X-Received: by 2002:a2e:aa1c:0:b0:2b1:a69e:6a8e with SMTP id bf28-20020a2eaa1c000000b002b1a69e6a8emr301259ljb.3.1686006066563;
        Mon, 05 Jun 2023 16:01:06 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id z19-20020a2e8853000000b002af15f2a735sm1623369ljj.111.2023.06.05.16.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 16:01:06 -0700 (PDT)
Message-ID: <09504ea7-186d-9ede-e01f-87849673b9b2@grimberg.me>
Date: Tue, 6 Jun 2023 02:01:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Revert "IB/core: Fix use workqueue without
 WQ_MEM_RECLAIM"
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Maurizio Lombardi <mlombard@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-nvme@lists.infradead.org, parav@mellanox.com
References: <20230523155408.48594-1-mlombard@redhat.com>
 <20230523182815.GA2384059@unreal>
 <CAFL455m3T4qrk0Uf5qK7-57Oh6L6AKionfs0mF-imUMYpbqBOg@mail.gmail.com>
 <ZHebeWlpn68Xa1Hd@ziepe.ca>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZHebeWlpn68Xa1Hd@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_160113_132512_82276CF7 
X-CRM114-Status: GOOD (  12.03  )
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


>>>> workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_rdma_reconnect_ctrl_work
>>>> [nvme_rdma] is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_core]
>>>
>>> And why does nvme-wq need WQ_MEM_RECLAIM flag? I wonder if it is really
>>> needed.
>>
>> Adding Sagi Grimberg to cc, he probably knows and can explain it better than me.
> 
> We already allocate so much memory on these paths it is pretty
> nonsense to claim they are a reclaim context. One allocation on the WQ
> is not going to be the problem.
> 
> Probably this nvme stuff should not be re-using a reclaim marke dWQ
> for memory allocating work like this, it is kind of nonsensical.

A controller reset runs on this workqueue, which should succeed to allow
for pages to be flushed to the nvme disk. So I'd say its kind of
essential that this sequence has a rescuer thread.

