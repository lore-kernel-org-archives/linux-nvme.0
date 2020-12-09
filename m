Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B80C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 01:11:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E069123B4B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 01:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E069123B4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pXsB9E16VfeUNknfUTomy800P1gCTBHq7dPtU5cJov8=; b=AV/eKAD7T/CSEpmVAxo3Ir4Rl
	5lHZJe+yObUF4LtzGijZOCrQTa51KyU/7NDOHx3FFsMhZWGjC7OLFLMUmuB1S0LMX+Hy42Li60N86
	+CM0WDdjit6PnLV5Co27MnnEV+98jdUlk9u13jxVDumT6tW56EY+17WbFlDQQbaEqSa07Mk74Lykk
	Bdc4oRSnYK1hkqWz0vGulkDjzAH2KKXMEWTcF/C6+mbeMLuAt+py2nAf/StVq3T8pv1UNa7aWkwu9
	HV6poMK2jQ8OF2YQSDe68cwJt9U9EcYhAMSTIOETwumQUUERWY6mviHfJz/bnlVdQSMgPq/7gq/UU
	ZBY+x1wBQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmo11-0002Dh-2m; Wed, 09 Dec 2020 01:11:35 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmo0y-0002DG-Sa
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 01:11:33 +0000
Received: by mail-ot1-x343.google.com with SMTP id b18so688447ots.0
 for <linux-nvme@lists.infradead.org>; Tue, 08 Dec 2020 17:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RJM1hdnxjXSlZDOWiasy+1r+za6X2vmIYFCfgCITCcY=;
 b=KFKDzFb6UL8vzCHrBPpewb+rC3w3yPSNqdyzUkkp/s5yP41YSU491kKvmkq3Pl0JVG
 kWFELD9ui0QYcaGsielM7PsSc/TbnpGP8zxZyebZgjE5RbNvxY3ib8OKkyQn9nD1U1qf
 9zOClrKtPzFOtaH3/JDWELt0pjxeqHC/CHWNIwQjwq/PjsWu21Yt5j0k2Sg4eNp7DAjU
 lyO5g2Y/cqMzAbxzGMhmdfzIUsrvWz/2LSQBiJawpEktetT/yU4ji38TAD9dPhHStRUB
 ItUBP0th5dJZwytQmiaa7HHvPkSI+6+pNmMBnmL2hhmfU49nWt3eHxWRISkl37TZW0q4
 2fFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RJM1hdnxjXSlZDOWiasy+1r+za6X2vmIYFCfgCITCcY=;
 b=mT+lbEYTSwqD6Z5avoUnZ8hnWVU+cy3weN1RX8y+CkjQ6D3Lf7DBJgWHomtmEPykeR
 TIxHqHWHRyAF9zrSUOxzXlytv7HPXQ8vMpUs+MgBOPahbRx2Tf1Llb22CvNfre9m49jz
 Map5Ivp487WQBDSh59/oI30NTOKdfG+DWSf3HozAeR+BJyB3cjdGrJp7zB6Pty02Wjb4
 GfuG9YtALT90IbzkNE+WUPxCX6CMZP3ypOdzMvpmvUIS4JWWeS+WWoETg6V6tBBU/KG6
 4QvJepj1XB6yt23H9f4it+PDF6KoYEle3DPRQSy1Z6IBDZM6N8D03haqhw0ze/2YrIiA
 yxtg==
X-Gm-Message-State: AOAM5308ypBDlBl16MqGCtqTDlneA/cIfyRCf7eRO1PU1MZc/BI4yXsv
 we2FJlh+oEfIwODrjiHwFmA=
X-Google-Smtp-Source: ABdhPJx8+Ccu8F1QT25GeEV+/cGXSTSWiLiDa65Dr23mGkdZFYosmMbyXGLSutWFJM5Uq5QDZWFiwA==
X-Received: by 2002:a05:6830:314b:: with SMTP id
 c11mr674204ots.151.1607476291183; 
 Tue, 08 Dec 2020 17:11:31 -0800 (PST)
Received: from Davids-MacBook-Pro.local
 ([2601:282:800:dc80:64fc:adeb:84f9:fa62])
 by smtp.googlemail.com with ESMTPSA id k20sm5889oig.35.2020.12.08.17.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Dec 2020 17:11:30 -0800 (PST)
Subject: Re: [PATCH v1 net-next 02/15] net: Introduce direct data placement
 tcp offload
From: David Ahern <dsahern@gmail.com>
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-3-borisp@mellanox.com>
 <824e3bea-60d2-5a4d-e8ce-770d70f0ba37@gmail.com>
Message-ID: <474d1275-9506-99d3-4f0d-86b482953eee@gmail.com>
Date: Tue, 8 Dec 2020 18:11:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <824e3bea-60d2-5a4d-e8ce-770d70f0ba37@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_201132_959443_28ACBD6B 
X-CRM114-Status: GOOD (  13.93  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 benishay@nvidia.com, linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/8/20 5:57 PM, David Ahern wrote:
>> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
>> index 7338b3865a2a..a08b85b53aa8 100644
>> --- a/include/net/inet_connection_sock.h
>> +++ b/include/net/inet_connection_sock.h
>> @@ -66,6 +66,8 @@ struct inet_connection_sock_af_ops {
>>   * @icsk_ulp_ops	   Pluggable ULP control hook
>>   * @icsk_ulp_data	   ULP private data
>>   * @icsk_clean_acked	   Clean acked data hook
>> + * @icsk_ulp_ddp_ops	   Pluggable ULP direct data placement control hook
>> + * @icsk_ulp_ddp_data	   ULP direct data placement private data
> 
> Neither of these socket layer intrusions are needed. All references but
> 1 -- the skbuff check -- are in the mlx5 driver. Any skb check that is
> needed can be handled with a different setting.

missed the nvme ops for the driver to callback to the socket owner.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
