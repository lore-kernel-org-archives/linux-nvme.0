Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8227C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:41:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A11650A8
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A11650A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=NZZ4HdSR7M+daTR4n5D6w9F52
	zAc/UkgusAw1UjzCdDKirT/aGO4yz/vnV7RdJx4NC9A2D121QdfjvSZGlSDBYsIVNz45gudylIK0i
	oviyw7rd4JHd0N7XdzgX3iE03HCP5kCScAF0Dzscmss6owUiLOLNbNb+nsQhBUMgBDpjwDJgqNZUZ
	AIDvBCewk8aoFteqDs7QgsVAojNSO+iAWyFNjmXXE7ARCZ+zf/++G47sEHoBY3oWQYBCH3XEDSN6D
	VLB1fX+dmMFHOV2MBcrUy5ugGjstzzdLLxdbukU2coJ5+v3g+wyp8rdEkDM/UcyLUKB6lwq0FKMvG
	JMB9BpEDA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIJ85-00GtBt-Jy; Fri, 05 Mar 2021 22:41:06 +0000
Received: from mail-ot1-f51.google.com ([209.85.210.51])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIJ7w-00Gt9t-Ry
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 22:41:01 +0000
Received: by mail-ot1-f51.google.com with SMTP id d9so3330274ote.12
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 14:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=CLVtEvcKcdbPrMFgrAGeK7kyZqV1eEy4lMHLweXEdDol9EXY3iKPcLJj8T4qe998A9
 m0af9kt71VAWF0GvZCcqt3tNAKOvEO3gyxavTAs8hM8enL5rD1V+dK24EwUIfdH2Lt2Z
 M9maS1XxZ1/3ur5Ugq+mAbyOpgB//tBsRjE5693FpSe7O1b8JooUPIBbRrbKL8u9uimb
 1/DjcTdVh/pkBvasLa1b2GIKwAkBXClX6TJw+Ap22NnfrFD6H8jaWUTnzSmxNoXrfTNJ
 6nzpfaJlzIUVxH0pcPlhkzuvDMVWhHUn8EiEnKAlYcnmNT+xrkg85kn4UbIbQwrS48LG
 P1+g==
X-Gm-Message-State: AOAM530WQztgHw9zmZtgULMtxlJohsnNtmTK01nlT8OiMhHX66fzVYQd
 JzkWwZ8RQ7MWVXPfwdJrEDXTUTlBaQQ=
X-Google-Smtp-Source: ABdhPJyTxRyNJwxcllrmHU4AI4UwEjY/bouwZvZlmT1izh/n/1keA1vK/zOYMacbUL8qwxW6GVe+Mg==
X-Received: by 2002:a9d:4818:: with SMTP id c24mr9950843otf.66.1614984054714; 
 Fri, 05 Mar 2021 14:40:54 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id z14sm974519otk.30.2021.03.05.14.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 14:40:54 -0800 (PST)
Subject: Re: [PATCH V2 4/6] nvmet: remove unnecessary function parameter
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de
References: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
 <20210225015642.29288-5-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c9a3209a-d745-9fcb-7cbd-8fb52dab0ed8@grimberg.me>
Date: Fri, 5 Mar 2021 14:40:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225015642.29288-5-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_224100_053825_A731E2D7 
X-CRM114-Status: UNSURE (   8.22  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
