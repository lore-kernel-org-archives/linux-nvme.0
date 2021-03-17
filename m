Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA59DC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 22:22:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069D364F18
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 22:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069D364F18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5iZmmATJGS3Vb/0gp3brq1+ngw54j+LY3ArHr9PnAYI=; b=fJd3U4SyM1Xdnen49J5neM7L6
	a51RAAphHG2HRjG6/iN5bq7kKl0Mvz+E5sjdNO0ZGQOW2GfGr6sQe+ThzOnjIinVV1nCkl1vkRkw7
	G8D+A+Kt/ZPZ4Gj6TUOyG+liLvoR8tgohbSuWBOKtD57add2GAuz7zqQaJdjdhKWV0Z5tOFPdocRH
	8jJe3Ua6+MsdbG5W6oSlkK56q/R7VhcgSbtegLZJRHNK6V/RekK4OeruVRolwebETle8NjKm0LCni
	mg4NicgEKyykR5fGZOmY6GJfqxEDe+CYwU1xWKjDM+tu3GWEU1tDHGhOjIALbVtNmzgoe24BaJi99
	CYzI0vPfw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMeXu-0041Uz-Dg; Wed, 17 Mar 2021 22:21:42 +0000
Received: from mail-pj1-f52.google.com ([209.85.216.52])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMeXm-0041T9-OE
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 22:21:38 +0000
Received: by mail-pj1-f52.google.com with SMTP id
 j6-20020a17090adc86b02900cbfe6f2c96so2091670pjv.1
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 15:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X2mC5NWwVZ/kT3RuaQ8RALNMx8YIRbkt7r3+jghl/QU=;
 b=bWSA7aQfDgTAxoG4W+LAUk2HjV/2/QABER4sUZtscDp8YfH7bTkTkMR+wJJJQ/pO8G
 dgetLCl+AIV0fzTnKvqd3h0wWQFBO08UGYzmG7SJI31lh13vha3sSKk+8FMOv3ejmWLD
 wnfOBAiVD+BGuJlO6Qq1nsysFmAncY9/x7N4w9Rx/Vi6Co8Qhovpu+ekSWaLq0eMq7sD
 bqpIVMCmADK9vrRxBvsWsSWF95TNIFceeS6S5RZXbnuNbZ5r/K3OqvlRVT3TvpF0+gDc
 ltt1CtOPQMhw5ZosJAIWsTRhasj//aYq2OL6Z21VilV5VT7DEmnpiQ/gcPa3Eri2BALs
 pQPA==
X-Gm-Message-State: AOAM530OJwyiY1Z6Qe9dTqF+9WZuU9l1jxRhaIXDWW/SMTWVo3qTfI6y
 3Z49iZIY0Vt3tsLUSOvvD3qrX9NRW9E=
X-Google-Smtp-Source: ABdhPJzXQ4yd8FP7gAMgt/9rDuZ0W+F/y6SXF6cO20ZOyG1a+VUE+NYpscrVxn5/r6JuImKJd8QTTg==
X-Received: by 2002:a17:90b:798:: with SMTP id l24mr932741pjz.63.1616019693002; 
 Wed, 17 Mar 2021 15:21:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dd5:ca84:dc28:de72?
 ([2601:647:4802:9070:3dd5:ca84:dc28:de72])
 by smtp.gmail.com with ESMTPSA id 202sm102861pfu.46.2021.03.17.15.21.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Mar 2021 15:21:32 -0700 (PDT)
Subject: Re: [PATCHv2 2/2] nvme: use driver pdu command for passthrough
To: Keith Busch <kbusch@kernel.org>, joshi.k@samsung.com, hch@lst.de,
 linux-nvme@lists.infradead.org
References: <20210317203703.17391-1-kbusch@kernel.org>
 <20210317203703.17391-3-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ee5bf7bf-8635-b092-fa78-ad040ae1af8b@grimberg.me>
Date: Wed, 17 Mar 2021 15:21:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210317203703.17391-3-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_222137_248980_3D19B75F 
X-CRM114-Status: GOOD (  12.65  )
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


> All nvme transport drivers preallocate an nvme command for each request.
> Assume to use that command for nvme_setup_cmd() instead of requiring
> drivers pass a pointer to it. All nvme drivers must initialize the
> generic nvme_request 'cmd' to point to the transport's preallocated
> nvme_command.
> 
> The generic nvme_request cmd pointer had previously been used only as a
> temporary copy for passthrough commands. Since it now points to the
> command that gets dispatched, passthrough commands must directly set it
> up prior to executing the request.

This looks good,

Did you get to run blktests with this?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
