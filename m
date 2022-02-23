Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4504C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Feb 2022 10:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d+z/tj64j31nPU7P3+AdyRvXbl+BzXO/CxZqxssuHe4=; b=RiZB8VRMGHRrmgH34aCfnaTfAH
	US8fE4J4rQER8ceaQJMYuB0rhC6KwUBF2qcufCryAQgdbvckBSovF52V6ZdS+ZtgUXFcWqCJhGwWh
	1/BKIjbW+2mOvNmBkJS+/17DnyTipLCrkQsZG7mRfRp/xQYbBHwfQuwOtf0s2OAvDYje36/Xv97at
	abmCX8YYAI/U7f2/c80IpWwRay5FOWhFYzxhQklLUWR4ujVxE2ND3RempU04UHeSRoi7yp1/hfnUb
	bOr7WKVtrCTEae7Rdxo746kLlxa1lPaMoXeUVfgnjMLE3IuLWB17mn3DuCIiUsDuHjIdMubEWJ8DD
	gE2Caphw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMov2-00Dfuq-9A; Wed, 23 Feb 2022 10:30:48 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMouz-00DfuB-Ja
 for linux-nvme@lists.infradead.org; Wed, 23 Feb 2022 10:30:46 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 az26-20020a05600c601a00b0037c078db59cso3981310wmb.4
 for <linux-nvme@lists.infradead.org>; Wed, 23 Feb 2022 02:30:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=d+z/tj64j31nPU7P3+AdyRvXbl+BzXO/CxZqxssuHe4=;
 b=IcoAgdlvF8LW/5TKEtoqUyLusHVWNifMH/oM/NU+/iwweG9lVBedgINjCeyvyShbnp
 gDBBNa52NmyJMzUAwmQuya0vE/6U6pHieRmsnMog1GJqkMVQby2oizExivshDQnjuVv3
 99mtmRkrT6hjx2ioLr4CkfofSPWRB60gslas3yOvmLwJ8t3+lstvtjACGzLx/aM4+2T0
 gxJkgPS0Dn8Fvu7054G2L7j9UnWXAGIADrQCCMdETjTS3aPn8Dqb3J7rIcNWs0yXx+Iz
 ZNziDT7yFZf+XkMw/RX13vWBtdq2OZXoDmpb1Gn8PGKYX8mukk0CHtLBuQyLzpBZC51U
 dYdA==
X-Gm-Message-State: AOAM530Anzv4Ky8BpgfCNKbUbxSkJH/IYDBpek3TfMqJ6/RPu1KxTfWP
 zvyvDlfjo+DWVCDi/AJgDUE=
X-Google-Smtp-Source: ABdhPJwgRPPywPIzZRKBXDJLsLty7vXfYZga5/x2cjtzDLv5Qw2nUqaP1kQfwrbN6siZJpO3t9M+qQ==
X-Received: by 2002:a7b:c04e:0:b0:380:ead9:254a with SMTP id
 u14-20020a7bc04e000000b00380ead9254amr2505870wmc.58.1645612242833; 
 Wed, 23 Feb 2022 02:30:42 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id d14sm50347618wri.93.2022.02.23.02.30.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Feb 2022 02:30:42 -0800 (PST)
Message-ID: <06a6c0ec-3d8b-75b0-7522-bfc10c3813e3@grimberg.me>
Date: Wed, 23 Feb 2022 12:30:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Yi Zhang <yi.zhang@redhat.com>
Cc: Haakon Bugge <haakon.bugge@oracle.com>, Max Gurtovoy <maxg@mellanox.com>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 OFED mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com>
 <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com>
 <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
 <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
 <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
 <a2fabeb3-5f19-11b6-8c00-a479e3759182@grimberg.me>
 <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
 <CAHj4cs_C=pCz41hg1AnQcEZPBRK78WTUq8HE3n_28t56iN1FuA@mail.gmail.com>
 <fe9842f1-e5c7-7569-426e-9029662bb4f3@nvidia.com>
 <CAHj4cs8fNmj2Mn7Srs547ji51x7mQ8ZWKzFOuJaENe=vKpBJ-A@mail.gmail.com>
 <6347079f-ec3b-c2e5-bb3b-43b539d6d3f1@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <6347079f-ec3b-c2e5-bb3b-43b539d6d3f1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220223_023045_673474_66657255 
X-CRM114-Status: UNSURE (   9.44  )
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


> Hi Yi Zhang,
> 
> thanks for testing the patches.
> 
> Can you provide more info on the time it took with both kernels ?
> 
> The patches don't intend to decrease this time but re-start the KA in 
> early stage - as soon as we create the AQ.

Still not sure why this addresses the problem, because every io queue
connect should reset the keep alive timer in the target.

But if at all, just move the keep alive start to nvme_init_ctrl_finish
don't expose it to drivers...

