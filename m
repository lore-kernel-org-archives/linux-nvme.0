Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5416AC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 15:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6mPbq8Nin+hCrDYZQyK8NYroPhFts3KarKSwfAyzCbo=; b=Qzmkry6FZ3Fcdu4RHGqyENL8jA
	fzaqIpnJTjjeuErh9+foPf+j8BHPmRwhOP/jhvxQSsVgQARk7q72kFnlqTGKkzV3DVdZkLa7x2ibD
	QTUCEdl0Wsiw9teiazDRzOdbN7ZI0ksCR+sRe9bqREToStZKp/BC75gGecdrXEPsFKC+cCc7zHMJz
	NsPm2AbJyAzZs16F2fk2vpibkATWh8qLPKSGTSYxwVWxhwTk215j2RQ/KhKIYYJfUyQb/EPHTgDTQ
	5+a77ht82gx33IkcaDHcMYIdbJz+2zdZoKIv0TfLYyujGjZmMHwB4KFPGhmKSz/5W0D3S0DTmKU8d
	tFZWMjlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUVZC-00DXyr-SH; Wed, 16 Mar 2022 15:28:03 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUVNl-00DTKj-Dw
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 15:16:15 +0000
Received: by mail-wr1-f53.google.com with SMTP id j26so3469631wrb.1
 for <linux-nvme@lists.infradead.org>; Wed, 16 Mar 2022 08:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=6mPbq8Nin+hCrDYZQyK8NYroPhFts3KarKSwfAyzCbo=;
 b=L30vLGVg4+B2i0lt1OCVt9Mx/cq9+m69RJKU8Ey7rJCNfqA0rf8GCd5hCIcp44L9wC
 pcfms+au2AnDz8nC37+SgMfZZZAv1VT4QkoB+bM4suhgDsxyihiFGEedshgq0eKjb63g
 XGT8PIj9vlZK8rgTb2iWsiUbEK7tF0/bbLEIpmpZyT7I81GchY5VuKDrZXMZM5wRxflb
 qXy1YkM2YaHos4smaaWdDLxr0aZJ3QY3Rr1ys+T7WlEX77VOKD1xW/dUJD8OsvKvxPy2
 WWFD2UgFaCd4GhhiVuP3vXxhWH8seywxSat4nScaQgs70+OGsvhUui+76d8VYgdAIXmi
 zRig==
X-Gm-Message-State: AOAM530QJR3XcSQD7XuGVj7uY/8s4tjisWdV/SAfsR5BK538bxfucd6o
 oNDAtsUPRSbsFQ35lpTKSBY=
X-Google-Smtp-Source: ABdhPJzrbmh3oAxcez9ERJTBYQ4x3husP7HNLIoMmO5otBPZvg7WqhINAEjqe2PGdpRicVYuj87bHA==
X-Received: by 2002:a05:6000:381:b0:203:84bf:3faa with SMTP id
 u1-20020a056000038100b0020384bf3faamr367161wrf.324.1647443771358; 
 Wed, 16 Mar 2022 08:16:11 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 s2-20020a1cf202000000b0038977146b28sm1901897wmc.18.2022.03.16.08.16.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Mar 2022 08:16:10 -0700 (PDT)
Message-ID: <6d8f4525-f663-18cc-8644-bfddd7d86bd0@grimberg.me>
Date: Wed, 16 Mar 2022 17:16:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Max Gurtovoy <maxg@mellanox.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 RDMA mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
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
 <CAHj4cs_ir917u7Up5PBfwWpZtnVLey69pXXNjFNAjbqQ5vwU0w@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs_ir917u7Up5PBfwWpZtnVLey69pXXNjFNAjbqQ5vwU0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_081613_538923_517363F6 
X-CRM114-Status: GOOD (  10.55  )
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


>> Hi Yi Zhang,
>>
>> thanks for testing the patches.
>>
>> Can you provide more info on the time it took with both kernels ?
> 
> Hi Max
> Sorry for the late response, here are the test results/dmesg on
> debug/non-debug kernel with your patch:
> debug kernel: timeout
> # time nvme connect -t rdma -a 172.31.0.202 -s 4420 -n testnqn
> real    0m16.956s
> user    0m0.000s
> sys     0m0.237s
> # time nvme reset /dev/nvme0
> real    1m33.623s
> user    0m0.000s
> sys     0m0.024s
> # time nvme disconnect-all
> real    1m26.640s
> user    0m0.000s
> sys     0m9.969s
> 
> host dmesg:
> https://pastebin.com/8T3Lqtkn
> target dmesg:
> https://pastebin.com/KpFP7xG2
> 
> non-debug kernel: no timeout issue, but still 12s for reset, and 8s
> for disconnect
> host:
> # time nvme connect -t rdma -a 172.31.0.202 -s 4420 -n testnqn
> 
> real    0m4.579s
> user    0m0.000s
> sys     0m0.004s
> # time nvme reset /dev/nvme0
> 
> real    0m12.778s
> user    0m0.000s
> sys     0m0.006s
> # time nvme reset /dev/nvme0
> 
> real    0m12.793s
> user    0m0.000s
> sys     0m0.006s
> # time nvme reset /dev/nvme0
> 
> real    0m12.808s
> user    0m0.000s
> sys     0m0.006s
> # time nvme disconnect-all
> 
> real    0m8.348s
> user    0m0.000s
> sys     0m0.189s

These are very long times for a non-debug kernel...
Max, do you see the root cause for this?

Yi, does this happen with rxe/siw as well?

