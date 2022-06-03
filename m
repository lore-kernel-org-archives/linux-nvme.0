Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CA3C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jun 2022 05:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jb0TyXV/oidz5qukxyhvHi03iGINx4MErOAqfXOcPIw=; b=gArs1sWaYCccLzujg4GKKc9M89
	/UGK+V1FGaSJIgWcQzPLKqhmF2+F8XQ7/3jjhiZDLLsQVWbD8nhM5TM42BvCQBooF+bZRUpcVJomb
	+TQOOeF+hA8Gm2sOYh5MMorUdevBhIhbmJFztIlv9masDyp43JkJczxRoYslolULMDsU6zxO1YJL0
	Gk49yWZaxxXumQDopimBdzsww67kNXlzPMNVqG2roM6Ojh067RvpFj06xv7KuoY7oB8960Vg4iK8R
	I4Obnj7qbH19gR90iucCB6OdcrD4bkoGiPP8T/B7t99k7fVH+fioW6Sir6ikThY1Tausc4lcZR/1/
	hrgvPqTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwzcu-005sZN-8z; Fri, 03 Jun 2022 05:13:36 +0000
Received: from mail-pf1-f176.google.com ([209.85.210.176])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwzco-005sYR-7X
	for linux-nvme@lists.infradead.org; Fri, 03 Jun 2022 05:13:31 +0000
Received: by mail-pf1-f176.google.com with SMTP id e11so6406697pfj.5
        for <linux-nvme@lists.infradead.org>; Thu, 02 Jun 2022 22:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Jb0TyXV/oidz5qukxyhvHi03iGINx4MErOAqfXOcPIw=;
        b=fLxqnrqKeilOsiecRWOVMpJQiXmiMwz5/KXuF8wyVAvxL5oD8M9WMUAVqPd3a3hUmO
         yKCCuN/GbBLncikzUr3d+Oh1yeP+5kHthrKxm6egmEjKOyeGzsMpOGTaiy9YML1ewkGZ
         BsJACbr3VNJTcccMpET53XwNQD8DzPYO99/ecTbyS3+XUP9X+lf9E5Lb1UfdVbPiSGTv
         OYfoKxpN3LyLtmUXDgBaFm3RR/gV8HqgFpBP2b0Lr2iRChm+qfHC3KmYI6+7c/swDYqK
         keV/YGxGqvoQuQOwloL9a793RBnub3xSogpYSJplRH6iVg4vPl6X233s26bA6Qx5bCv2
         qnLA==
X-Gm-Message-State: AOAM530i5sAczjZcI6bcX2mV7jp7ddYPPS1v3AbdwJ1cfj0iK+0hJw42
	OZrt6cU7sDrM7ZVTpdzVra4UAkmT95M8iQ==
X-Google-Smtp-Source: ABdhPJzFOd4NjGVQ84m9d7+jzM5PYR54oZz8DWO899//Yo+LWlC/Zcc6Hdi0Lm+A+1axrMB+fF6nrw==
X-Received: by 2002:a05:6a00:c84:b0:518:e0f6:f1af with SMTP id a4-20020a056a000c8400b00518e0f6f1afmr8682097pfv.47.1654233207164;
        Thu, 02 Jun 2022 22:13:27 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id o5-20020a170903300500b0015e8d4eb2e0sm4302862pla.298.2022.06.02.22.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 22:13:26 -0700 (PDT)
Message-ID: <53951a52-dc77-f4c9-a1dc-d6ac015be1a4@acm.org>
Date: Thu, 2 Jun 2022 22:13:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
 RDMA mailing list <linux-rdma@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
 <20220527125229.GC2960187@ziepe.ca>
 <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
 <20220531123544.GH2960187@ziepe.ca>
 <355f1926-9a0d-f65e-d604-6b452fa987e9@acm.org>
 <20220601124556.GI2960187@ziepe.ca>
 <109ac246-5cc0-8d5a-ac0a-2937d86fbe06@acm.org>
 <20220601173005.GJ2960187@ziepe.ca>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220601173005.GJ2960187@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220602_221330_318372_97F327A5 
X-CRM114-Status: UNSURE (   8.44  )
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

On 6/1/22 10:30, Jason Gunthorpe wrote:
> That is just the keys, not the graph arcs. lockdep records an arc
> between every key that establishes a locking relationship and
> minimizing the number of keys also de-duplicates those arcs.

Do you agree that this overhead is acceptable since lockdep is only
used to debug kernel code?

Thanks,

Bart.


