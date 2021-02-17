Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B736C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 17:01:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085AD64DF0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 17:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085AD64DF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T2pfCN/rdQOkRglrdDqbjxiHsg6xt+7ae9bcs8/79lI=; b=lz4TAxFNrPkpZIQ6VkYTwz6NL
	nTRI+NsJ3vviZ+C1RN7j6Og/ZXZg697ySw+ldRooiXIYsI3ua6UIfEDNP/hUKpeP8ALY8mlPF6abY
	MFNm6uQvvp5LSRxYztQV0lS95QE6NNR/WEosUWwk52G+rFQZQlmpx09QBpw5HdMXc+43rkkdTXK65
	TDpmrXgqX8hW5GI2rU2G+TqFE9/R5EiF6LMtCF/CxzHgQf6zGPbTfmf2q6+HseYT6aRREdUnA5EQB
	nV9OzVld7BfuOWIiAikIZIh2f/xKG/W2EEr508COqF+9OkOCE5vMBBkhjn9w4cDVBxEyK0DgeWVfk
	TFoRjdDZA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCQCM-0001VY-Ks; Wed, 17 Feb 2021 17:01:10 +0000
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCQCK-0001US-MC
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 17:01:09 +0000
Received: by mail-oi1-x22b.google.com with SMTP id v193so15646384oie.8
 for <linux-nvme@lists.infradead.org>; Wed, 17 Feb 2021 09:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=acLjNYJ2FLHuaTuKCTyp2dOS5vNX6ll7e+m+WEgy3a0=;
 b=tQ/LM6+54H2yMGAbKn9YVIKLAzvYFvsg+p8Ex/fRDi2tFOfu5iD9bq2t2W8WaiqIRU
 TqYxyDYZWTkKhidiSrqiDwqmEqVlpTmbSJY9dfWTqFBJNdW0hTWWuXkdTR0firtIw9Be
 aAHj7agt1nW/4529bnOp11nZIXvzgCM1vW445Uk8/jWOWnKXux/2IQrSRLnN+xcL7ix/
 WKuXthvXIXlIepi5k//ejGxsTuzmOcjpbbCRBxl3Wqfgvc8LGriazkWoy88Aw9pvXrvD
 MCpAl3+pmB35JLKrc8hMyp1ewAOH9xdTvnN4EAubSWOcBOoGRmlwWJld/WUC9i/jazAS
 2GNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=acLjNYJ2FLHuaTuKCTyp2dOS5vNX6ll7e+m+WEgy3a0=;
 b=szTf2oug2L0zcEkwbnhyvaHueal+8Ynu11WSDFIpbamtTanVfYdhIRw3gxpRiEEqsX
 ekfB8zXUwyeCQaausONZ78uYX4ZzB66reV/2puoQqMKVmHiryZAMQocubMAsPg6MJ9Gz
 MQNGZGUuKpllWqE/+3jgtywbuDBixP47tgVEhMcWWytWYfpfROeSSJpL2V4q9rH9rH4x
 MOgF6iu+26KLEVj/CPsaSgJiMfxXjvzmZYMUyVCqpdmIKLAWf05G7YSYt6hBLPMPd4/i
 n0A9+/txi9cz0a8efMHE/kF/azEqt9wPwW+EnRc2Y8f/+q4QwCiLY99Q7Um5keU5yOA4
 R0gA==
X-Gm-Message-State: AOAM5303j/g/p4nE6oYCt8lTsr6VXpTIIvTMVO5PapFTAw3NHIluf3SM
 dg+x2/r0IQTgpeyJxePwCgQ=
X-Google-Smtp-Source: ABdhPJzMM5xD+9OBeIho3+CxKSgzPpLJcl3fXccdo0704VrzBuH8joFNjufISxz4EWSwFXVzByLvAw==
X-Received: by 2002:a54:438f:: with SMTP id u15mr2243540oiv.60.1613581262531; 
 Wed, 17 Feb 2021 09:01:02 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.48.134.33])
 by smtp.googlemail.com with ESMTPSA id b9sm501287otl.14.2021.02.17.09.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Feb 2021 09:01:01 -0800 (PST)
Subject: Re: [PATCH v4 net-next 07/21] nvme-tcp: Add DDP data-path
To: Or Gerlitz <gerlitz.or@gmail.com>
References: <20210211211044.32701-1-borisp@mellanox.com>
 <20210211211044.32701-8-borisp@mellanox.com>
 <cfd61c5a-c5fd-e0d9-fb60-be93f1c98735@gmail.com>
 <CAJ3xEMgZg9dFyc8cnbuPPAFT3jd2k27TdLOz-vtVmxy9k9zHcg@mail.gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <f9c45756-b823-7cab-213c-761866230c96@gmail.com>
Date: Wed, 17 Feb 2021 10:00:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJ3xEMgZg9dFyc8cnbuPPAFT3jd2k27TdLOz-vtVmxy9k9zHcg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210217_120108_769425_5D0EE72E 
X-CRM114-Status: GOOD (  15.04  )
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
Cc: smalin@marvell.com, Sagi Grimberg <sagi@grimberg.me>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>, linux-nvme@lists.infradead.org,
 David Miller <davem@davemloft.net>, axboe@fb.com,
 Eric Dumazet <edumazet@google.com>, Or Gerlitz <ogerlitz@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux Netdev List <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
 benishay@nvidia.com, Saeed Mahameed <saeedm@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Boris Pismenny <borisp@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/17/21 7:01 AM, Or Gerlitz wrote:
>>> @@ -1136,6 +1265,10 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>>>       else
>>>               flags |= MSG_EOR;
>>>
>>> +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) &&
>>> +         blk_rq_nr_phys_segments(rq) && rq_data_dir(rq) == READ)
>>> +             nvme_tcp_setup_ddp(queue, pdu->cmd.common.command_id, rq);
>>> +
>>
>> For consistency, shouldn't this be wrapped in the CONFIG_TCP_DDP check too?
> 
> We tried to avoid the wrapping in some places where it was
> possible to do without adding confusion, this one is a good
> example IMOH.
> 
> 

The above (and other locations like it) can easily be put into a helper
that has logic when the CONFIG is enabled and compiles out when not.
Consistency makes for simpler, cleaner code for optional features.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
