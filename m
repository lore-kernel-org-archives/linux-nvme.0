Return-Path: <SRS0=yxkO=HX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68FDC433DB
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Feb 2021 11:44:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F73F64F00
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Feb 2021 11:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F73F64F00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yQ3/NoVvSArziV3wX8KKxbEbO1fgBhtDfb4XpwF4rmo=; b=pSKhmOgjK0P+HUq3OcNTHGtGL
	tCTG3rP/3DFr+pzy+xF5rUgref4IZh220D04PH/nfap2dzE96xGkc8thrKHn26qLV96YWJY4TS5fv
	H9o+58q3hI2IiJBiZBYxmEl89ryWIziE2/0wmQDqe/+74MhU+esipF6NHjAhwneUDmZeD4FQX2VXm
	Oqfi68r91sc6tuxE1wrFAHcypMnVqvXN0Wi1F7beUxTHm3MjZITMd7spoEeDvU4vqv/nZGL7AnwJ/
	1LrALJoOCmlRKJGO+RagXF+iRv9QERlqoW3iQ0wH2HbVRPuPcdMPqieLPIGbRu7UR+4WhsrVgOQJ3
	GyU43pmLg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDn9v-0005ew-PO; Sun, 21 Feb 2021 11:44:19 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDn9s-0005ea-FN
 for linux-nvme@lists.infradead.org; Sun, 21 Feb 2021 11:44:17 +0000
Received: by mail-ed1-x52a.google.com with SMTP id v22so18137140edx.13
 for <linux-nvme@lists.infradead.org>; Sun, 21 Feb 2021 03:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Dhrn779+a4z/VQxcMafxNvJ9pBhmzV8lMEegc3MEdvY=;
 b=VYzCmz/IpOHVbebwWJ42tkC0yblsRK/yZg4sUyVdkmrp1NT9zsuGmuM52IUEOcqn5V
 YmTwGP0a2IJeRqIHxM5WCd6d76wFYhj9lTX2DV8GcrAHoAA8mhL1uGVsjncQqi7T1UHr
 8dsWaCJoIziCY7Qmdb3JJh4ZUtLdLQWWH2RgtohKDvbsn+ltezHLXuHTb2t65A9TnqkG
 huYdV+XE6r1bn3kIQofAE27iClLXTnsJm/HckFXMBukryCZibNNfQC9imCTMZRC8Xfvk
 isU/PjSphswSQoTcV7tWRSMyr11ZyRfnUZr6NhqoyBIsclwR2hSjzzQoONutoIq/5Dm1
 tApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Dhrn779+a4z/VQxcMafxNvJ9pBhmzV8lMEegc3MEdvY=;
 b=tXDoLUghG7Ze7h381WVRXrSoS7040YwfTKwena5k9n3nS1fvOHc3eyIYrBCBdEPDP0
 xK0tqYPPd03swnPrdOlyW98Lx2Uxsbl4xAH9y5GTHWD88vK6rrxlREQ0sox1q0pE1TKQ
 Gx7qMvCh2xX4lD2+nEKTeDKIuS136XfQJlZBmZOCDhhJV3xx/WJAa81kGv744b6ssDvb
 IUx1GdMQa39QTYZ5ETaR1S+8d8L+c1ZroD0f2y4g+zr2DpXlwiqGqHGBaCP0Ssg7nlkD
 tQ90zOqKkUjyYQGTkuEvtJS+4+hp+Bo1RT740VavKMZYxdf2h/n0PoAYO0M1TMjIOTFm
 py3A==
X-Gm-Message-State: AOAM532JwsT70yOlmY25kWkTWnZ5PryKTAcJX1vpF1iHliqovW5Kopj+
 imeXqvscrRZXcxCFr/Z+rqs=
X-Google-Smtp-Source: ABdhPJw27UbxK1VZjh26CdqdQonGjkK6TO3asaERjRg0CqE5PFBBLCHMyRHm4iK+LQkAdpdIFbLfxQ==
X-Received: by 2002:aa7:da19:: with SMTP id r25mr18337968eds.367.1613907855131; 
 Sun, 21 Feb 2021 03:44:15 -0800 (PST)
Received: from [132.68.43.202] ([132.68.43.202])
 by smtp.gmail.com with ESMTPSA id bz20sm8514508ejc.28.2021.02.21.03.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Feb 2021 03:44:14 -0800 (PST)
Subject: Re: [PATCH v4 net-next 07/21] nvme-tcp: Add DDP data-path
To: David Ahern <dsahern@gmail.com>, Or Gerlitz <gerlitz.or@gmail.com>
References: <20210211211044.32701-1-borisp@mellanox.com>
 <20210211211044.32701-8-borisp@mellanox.com>
 <cfd61c5a-c5fd-e0d9-fb60-be93f1c98735@gmail.com>
 <CAJ3xEMgZg9dFyc8cnbuPPAFT3jd2k27TdLOz-vtVmxy9k9zHcg@mail.gmail.com>
 <f9c45756-b823-7cab-213c-761866230c96@gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <c0eba1e7-f113-2400-72c1-4361e79363a7@gmail.com>
Date: Sun, 21 Feb 2021 13:44:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <f9c45756-b823-7cab-213c-761866230c96@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210221_064416_593111_75C072B7 
X-CRM114-Status: GOOD (  13.38  )
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

On 17/02/2021 19:00, David Ahern wrote:
> On 2/17/21 7:01 AM, Or Gerlitz wrote:
>>>> @@ -1136,6 +1265,10 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>>>>       else
>>>>               flags |= MSG_EOR;
>>>>
>>>> +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) &&
>>>> +         blk_rq_nr_phys_segments(rq) && rq_data_dir(rq) == READ)
>>>> +             nvme_tcp_setup_ddp(queue, pdu->cmd.common.command_id, rq);
>>>> +
>>>
>>> For consistency, shouldn't this be wrapped in the CONFIG_TCP_DDP check too?
>>
>> We tried to avoid the wrapping in some places where it was
>> possible to do without adding confusion, this one is a good
>> example IMOH.
>>
>>
> 
> The above (and other locations like it) can easily be put into a helper
> that has logic when the CONFIG is enabled and compiles out when not.
> Consistency makes for simpler, cleaner code for optional features.
> 

The above is consistent in the sense that we wrap only places that are
absolutely necessary, so as to avoid ifdefs as much as possible.

Specifically, here and in ddp_teardown, we will add a wrapper to reduce
clutter if offload is not used.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
