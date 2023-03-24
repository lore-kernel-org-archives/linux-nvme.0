Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D2DC6FD20
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Mar 2023 19:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mzEyCZHLH4Zfj5DYk4naroNB2YGbHeAPk3MJAB81cn0=; b=Srlubrij9a75dDTfVW0XN7dujj
	kudqpRLiM1ZCKt4UfFa1Ms+NmxJruxJooVrGnREdvPUfyQQYK7x3G7F56Xc0+sabZyVTNCTVIeM7/
	ehZc2IANrOFSqdkd4vq+oNlk8E7x9UR3Rcbikq2MVicEoJ6bqJa+FQFHeTOleBC8FKnH4Xtb8l0Tl
	yswm3IS9kjByOq2EHBxT939lYwh/RU8sr8lnwf8uku8awEI0+JmBS+CohMF22WWorGnoZfAhDvdPZ
	oBBB2NchnUqo3r4PjGiYKltXmvTxRCLCyACY4MLWdAJzNhJQXcnkHeUweolOtkk9pCRzV/0O4Zcdb
	CHDUwo0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfnLg-005SQ1-0G;
	Fri, 24 Mar 2023 19:45:16 +0000
Received: from mail-pj1-f53.google.com ([209.85.216.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfnLd-005SOQ-1U
	for linux-nvme@lists.infradead.org;
	Fri, 24 Mar 2023 19:45:14 +0000
Received: by mail-pj1-f53.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso6079732pjb.3
        for <linux-nvme@lists.infradead.org>; Fri, 24 Mar 2023 12:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679687110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzEyCZHLH4Zfj5DYk4naroNB2YGbHeAPk3MJAB81cn0=;
        b=mBDi1TBJ2Cn3/JlwG2e8dxFMdoQD6dio1jB0xKYD/71+22BB8bPrv6Twh4BpKtSx5l
         RsnftxvZUUaqDztBhwvu5p6O2IPO2PwhuOy8FAteVhdyQDyjPMhMGi+Dyp3c+ETpZjpW
         0GrqJ6C+dcikiycTkKaTnfA3RzOflA25hCGumcRSCwwqpyhsm9naFHBu1lEUrhOlRoQ4
         F2kh6DP1BfDxZO2Mu51nbo+8FVPUQKYL0dBHe8GFQrhz21Vr0gWjfCgkb5n82uShr2pH
         Qw8uutd2tVTuhD9MgzE5qFnqhDrqN4Zleo0WC8w5kmwnHsMvo7CNAT9t3FyJpEf3QICR
         QOXA==
X-Gm-Message-State: AO0yUKVxgIGNmmX8KBSyj4gseIuvCCwl9wplTwbuUNda1wXdBNdFmI0X
	6PLMuWhZ+qnmCKbkilfb4zuykkc+yM8=
X-Google-Smtp-Source: AK7set+WBcQsEOXCQ/txqOh9eErFNTaYEWF2xegD7KrWmJzmFiNv92WvD5FLTUar7NcICYJm6jYnKg==
X-Received: by 2002:a05:6a20:7a98:b0:cc:868f:37b3 with SMTP id u24-20020a056a207a9800b000cc868f37b3mr3618846pzh.58.1679687110519;
        Fri, 24 Mar 2023 12:45:10 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:386d:2249:7df8:ecf? ([2620:15c:211:201:386d:2249:7df8:ecf])
        by smtp.gmail.com with ESMTPSA id a14-20020a62e20e000000b00625d84a0194sm14306035pfi.107.2023.03.24.12.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 12:45:09 -0700 (PDT)
Message-ID: <0dfa3352-cdca-90c1-a6c9-ea4a4c85dfa1@acm.org>
Date: Fri, 24 Mar 2023 12:45:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 01/18] block: Add PR callouts for read keys and
 reservation
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, hch@lst.de,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>
References: <20230324181741.13908-1-michael.christie@oracle.com>
 <20230324181741.13908-2-michael.christie@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230324181741.13908-2-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_124513_497881_F476F1D9 
X-CRM114-Status: GOOD (  14.18  )
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

On 3/24/23 11:17, Mike Christie wrote:
> Add callouts for reading keys and reservations. This allows LIO to support
> the READ_KEYS and READ_RESERVATION commands and will allow dm-multipath
> to optimize it's error handling so it can check if it's getting an error
> because there's an existing reservation or if we need to retry different
> paths.
> 
> Note: This only initially adds the struct definitions in the kernel as I'm
> not sure if we wanted to export the interface to userspace yet. read_keys
> and read_reservation are exactly what dm-multipath and LIO need, but for a
> userspace interface we may want something like SCSI's READ_FULL_STATUS and
> NVMe's report reservation commands. Those are overkill for dm/LIO and
> READ_FULL_STATUS is sometimes broken for SCSI devices.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

