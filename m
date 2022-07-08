Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E6BC43334
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jul 2022 18:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8El55oBhsal1YvHv4IXgTDyrjOJ73nQdWIhXAlq6X58=; b=4mYnoCuZVYl1sDjBO8zKyglZ6c
	24NJmhKi7W4l8vQ2BsdVuTUrrMNnWj3N1XO7P/R77GFt+nLKic5yU9xgt09WyKkrlSUQsWpPucTta
	Z2aHzJ/PC93k+TjO5deR+OcqmZx0axMRdw+Phsw2ceBBCJmOY7abG3SJ2nfN5yEizaqhN9B5Q1Cuh
	wfRFKsv/rgB6rBYzvQqy6RPgcxy4HgQYMn15H2/8SnFni5hbaBgvOoYlT/f8nDRIxagyP/HW5EfCG
	VQTAqzp7eL7YJuqF07pK9fyG288iyPvE1tn8ppqXafJMA7SZL/TY1hRmFw6VuY3py55dR6DMX93tC
	1zu1xS/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9tBz-005V0F-RT; Fri, 08 Jul 2022 18:59:07 +0000
Received: from mail-pj1-f50.google.com ([209.85.216.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9tBu-005Uvr-Fo
	for linux-nvme@lists.infradead.org; Fri, 08 Jul 2022 18:59:05 +0000
Received: by mail-pj1-f50.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so2825675pjl.5
        for <linux-nvme@lists.infradead.org>; Fri, 08 Jul 2022 11:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8El55oBhsal1YvHv4IXgTDyrjOJ73nQdWIhXAlq6X58=;
        b=3Ph/ur8+AzTw0ttPGJOGcn4oBcu2fSc3BhD32W6f6tmHV+qdRTJHCjUxjNrUS9bk5y
         fui4Suwm3HTVzQ//qkLBYknHbgDLdkey7WFB0E7rXPA83gG8g77YZsUjZQW6ZAclX1vv
         kDXW1T6nPcbFg0zuijsmcA634S40JeOHX3yGsbvOvy10zP7tlApK9RFScnwH/AOCs/SO
         ELojmxzTvFbw7DLbUGJrt8HSugnMrycdM0YxZTx3qqxFJzA+Te1P2LKMZXC5BBtrSVcX
         HpjMn7Pl+kKFNofXBRB6Uaqsj+jcnmdi8awhhbCapFvzEOL1mGIN/TAEZHjtPwwglvd4
         3EOQ==
X-Gm-Message-State: AJIora9KSDfdjjYwlcIiJyh6tD0wpZlQ4MbszXJbkb0tBy1ng+mO3mQ2
	dhg52zCHi2fou9UY9wh9f30=
X-Google-Smtp-Source: AGRyM1u31kiAYPbguv9ZthcIeygs6/BqhPnSdUiZJNQb8c9w02A8HFa+TwhukQTeCpGPelUgJA2oUw==
X-Received: by 2002:a17:90b:4a12:b0:1ef:fd9e:a02e with SMTP id kk18-20020a17090b4a1200b001effd9ea02emr1446301pjb.216.1657306738673;
        Fri, 08 Jul 2022 11:58:58 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b0016bdf53b303sm12194911plh.205.2022.07.08.11.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 11:58:57 -0700 (PDT)
Message-ID: <def01493-bd2d-bed4-ab1a-9b4304687692@acm.org>
Date: Fri, 8 Jul 2022 11:58:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [bug report] blktests nvme/005 trigered debugfs: Directory
 'hctx0' with parent '/' already present!
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>, linux-block
 <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs9Jhg4DZRnck_rdGWtpv9nLTAF__CVtPQu9vViVUZ-Odg@mail.gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHj4cs9Jhg4DZRnck_rdGWtpv9nLTAF__CVtPQu9vViVUZ-Odg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220708_115902_572719_D8B8615D 
X-CRM114-Status: UNSURE (   9.13  )
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

On 7/8/22 09:32, Yi Zhang wrote:
> I found below error log when I ran blktests nvme/ tests on aarch64
> with the latest linux-block/for-next,
> Please help check it, and feel free to let me know if you need any
> info/test for it, thanks.

Is this 100% reproducible? I tried to reproduce this yesterday but 
without success. See also 
https://bugzilla.kernel.org/show_bug.cgi?id=216191.

Thanks,

Bart.

