Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AE8C3B187
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 18:20:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E63208C3
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 18:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EsgtX0Uo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0GPZfSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E63208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Y4KzsFS0XZkriD6KSVtcWLfeH53ivxox6cEUgK05EmU=; b=EsgtX0UoX1eJIsT5NBa/iRl7d
	vHZu4UO0PoczUcImFotpSI80zvhKcah8yXOr71iHQUrhOCvUSyJtJjwfI9taB+C87hNd7gbqRV2uF
	AwejgM6MFvMftS4gQlY26yJ4imqR0XCz8K5wtzDgFSsSGgJ+krOdMPsOzh50VIETanQVT77+Tf+Ok
	OUV5/oQHa/BMCyctgl3rV11H5fDyI7mKSMpDbi8ncjq5zz6+6G1SvUpDRs4e1IN9KAj9x63vyBJnK
	SYC1RsCMaaRioRQ/9/CCTeuwAzgg+DXHql1sIH7/EQ0remN2XHbJorrVQOnEPfj5CYhOkFTccdVP7
	6Dp88BkcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1a8e-0006yX-RP; Tue, 11 Feb 2020 18:20:00 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1ZlZ-0006ZD-LW
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 17:56:11 +0000
Received: by mail-pf1-x441.google.com with SMTP id s1so5835235pfh.10
 for <linux-nvme@lists.infradead.org>; Tue, 11 Feb 2020 09:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nxyR688pDq8caOzKNAVkWBmaTWa4mFR0rWSoTMGHAm4=;
 b=K0GPZfSU5RlWw8qhc1h3BDjvFEmi6pwXcsy8IuxR3yE9NS8F36a+M8SS8hffW1M1WY
 DhYD/VVFFk53oj5wqhnfVqU5NBTs7iuei4EWG9SsTBotdhaW+Kclw7GrNI3qKa36wN2y
 VW6KzWLX3XbyxUJ0xZHoMyO33nT+hWVot/+mSjBpBd6N+Nfe/EpaLa93aCXMNuUUBmf+
 Sc9xYmMSi3R3NcvQa0z3GykyoFLUyi9YP6B4doMRpTXG2EzYPB+NH8ADke2dbovsD2hP
 /ZRcEYei291SCKT/N36zB+25I+3pHjoVSem5Rq/XPyL1dFA0ijUPr+1vnZ0frGvPHjHu
 IYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nxyR688pDq8caOzKNAVkWBmaTWa4mFR0rWSoTMGHAm4=;
 b=GhCiBx2O8tN4Jy5cRPKPTZjzNJ83MKqrTyb4H9MJcdix+t56UHiHOEJemv6Rn6aZB5
 dEoSZdiqBSiuys2Cz6ldWYWc8Rlsl4SLbllHIYvRvPoWKuzsNrCwb/EEtXcAqK9TKx57
 /SleJXvbyC9KAjoC4DIh4y4abepE524LzA9BHmA8IOwXun25kqFduS2CY+gmc7u5Q1Py
 h/LLISx3GYDDRHy36cvWcZGxJh6xnBWneMn4VX3LiMyKdVQ5eIuk+7PSzXLPyFORV4lT
 P9wStJHRK1jBtTM8j/qkuhMh392td8zww4dn33XGEoSM3jrFVlUfj5GSBC5IF83HqCWo
 77vQ==
X-Gm-Message-State: APjAAAUfND5e9rPsM3iQ7ofFmNKqpdHE8gNuYPyF7afSWazOlOpwoLes
 62ml8ye29KaKkOPTum/cAO4=
X-Google-Smtp-Source: APXvYqzSEcqKd9c5RY+3BQhCFvIyDQkMKb1FZ6r2wPbfK8Ni/Lygs5/tyufQYycaPx8sC5+7gVSQuQ==
X-Received: by 2002:a63:6704:: with SMTP id b4mr4423447pgc.424.1581443768740; 
 Tue, 11 Feb 2020 09:56:08 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id x11sm4974422pfn.53.2020.02.11.09.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 09:56:08 -0800 (PST)
Subject: Re: [PATCH 2/2] nvme-rdma/nvme-tcp: Move err_work to nvme_reset_wq
To: Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
References: <20200206191342.10190-1-jsmart2021@gmail.com>
 <20200206191342.10190-3-jsmart2021@gmail.com> <20200210170442.GB19584@lst.de>
 <ec482da7-1794-eea1-555c-31c76e792e4d@mellanox.com>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <35b81d7a-3783-c81b-a45b-f22260671444@gmail.com>
Date: Tue, 11 Feb 2020 09:56:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <ec482da7-1794-eea1-555c-31c76e792e4d@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_095609_749524_31B13897 
X-CRM114-Status: GOOD (  14.64  )
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
Cc: Nigel Kirkland <nigel.kirkland@broadcom.com>, mark.wunderlich@intel.com,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/11/2020 2:12 AM, Max Gurtovoy wrote:
> 
> On 2/10/2020 7:04 PM, Christoph Hellwig wrote:
>> On Thu, Feb 06, 2020 at 11:13:42AM -0800, James Smart wrote:
>>> With keep alive processing being moved to nvme_wq, it potentially 
>>> creates
>>> a conflicting position with err_work also processing on nvme_wq and 
>>> needing
>>> to flush/stop keep alives.
>>>
>>> To avoid issues, schedule err_work on nvme_reset_wq. It looks like 
>>> this is
>>> not only a good thing for keep alives, but also brings the transports in
>>> line with the RESETTING state and processing work relative to RESETTING
>>> on nvme_reset_wq.
>>>
>>> This change is made to both nvme-rdma and nvme-tcp which have like code.
>> Shouldn't we move both in one patch to create a regression in one
>> cycle while fixing the other one?
> 
> Yup, seems like these should be squashed.

note: see the v2 posted yesterday.

> 
> James,
> 
> did you run some testing for RDMA/tcp that will trigger this code ?

The testing of the keepalive movement was all in FC. FC already has it's 
calls from either nvme_reset_wq or nvme_delete_wq.

For RDMA/TCP - it was not tested. It was by code inspection and looking 
at who calls the keepalive cancellation calls.

-- james


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
