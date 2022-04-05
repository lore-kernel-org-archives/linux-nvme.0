Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB87FC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 10:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=auPPRfo2tdetUHqTRvpHx+79UdyGBr5FBYn9FSxmUKM=; b=YasUnGgw6+LtaPTXMoyBvuflll
	XXSjxLAuXZsgoCrhUhib9ZL0qlKuvNSyGeA8LETYbhdFie3F/jZnorNncl1vrx2Ppe56lH7dg2bE1
	WcNyxR6tLmXZy/k+4eZ10oBdqMR7+ppkEFdP2STceukcWPAsCNxRjydZ5c8aqWn/56RAZjpBWe9Cp
	4uK8C+SfUKId+uhr0qQEflbRsMPkkO3mF3Z0kEGNlYiYZAauHHOp3/mvPKUF2by6F1JdhPrNBSvAQ
	mJdx1zUaEwj9ac/5/QJJHBFuyDjmQkkU2V5QHG0n0CgY1Bb7XJtr9iilL00A58FigWa0BkX/jEsQ+
	D5TOIaog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbgUI-000f9l-LX; Tue, 05 Apr 2022 10:32:38 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbgUF-000f9E-SI
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 10:32:37 +0000
Received: by mail-wm1-f41.google.com with SMTP id r7so7670593wmq.2
 for <linux-nvme@lists.infradead.org>; Tue, 05 Apr 2022 03:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=auPPRfo2tdetUHqTRvpHx+79UdyGBr5FBYn9FSxmUKM=;
 b=UaHK/9cESWGfC46GRoWy85TB7Yvjjop8V8zSAgyeKMvC+bPe0LLmyr2e0ldIQeG1/A
 xnOev2Ai63x88BIpdGN1y7w/8RjHHes+3tfTk5JR0QFvfutt4JvlLLb3SiZoT3L9kuSi
 7uWSqHUKNT3TjxEPEvXd4zt4dnPFfYE9XvpFH9E53Ve/b5rwxUX4mssc6/FpXq200HFt
 hR5geNfKjXg5CST8Qu6XC+EAS7al7OZMx6QgIAZMeZ2kwpo+fNFdSXDshDcV3OvAatI7
 oNNB/4jZvamreexT7FBhXyUr4WjG2m9F2X060Tre6Fzc1XP69nT4QS8JkfeNxjTSwFaw
 HYoA==
X-Gm-Message-State: AOAM532pIVsYiaH8jP634oHog3yrev7ZnAyQSOWOv94glq678ceWfdya
 +iWfvZ0CzQsy0tvWE8hP8PkQwd3vptc=
X-Google-Smtp-Source: ABdhPJzYlmQx6iY2qgQYOhysdo1JYP3KkA+ZhxMIf9BuPEipiO/y3VTMgj4r6O/L/TEpK6IuOQczbQ==
X-Received: by 2002:a05:600c:3ba5:b0:38c:b19e:253c with SMTP id
 n37-20020a05600c3ba500b0038cb19e253cmr2473835wms.35.1649154753007; 
 Tue, 05 Apr 2022 03:32:33 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 p125-20020a1c2983000000b0038e6c62f527sm2644776wmp.14.2022.04.05.03.32.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Apr 2022 03:32:32 -0700 (PDT)
Message-ID: <9ebf0f5f-db48-f326-8455-1fcb9211b752@grimberg.me>
Date: Tue, 5 Apr 2022 13:32:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in discovery log
 page for unique discover controller
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-4-hare@suse.de> <20220405054601.GC23466@lst.de>
 <a129df40-6195-8b59-aa76-e3053e0960fd@suse.de>
 <20220405061941.GA24290@lst.de>
 <366e9acd-23c8-f8bf-2671-9187f3c0ce96@suse.de>
 <20220405073121.GA25524@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220405073121.GA25524@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_033235_958372_41FB7369 
X-CRM114-Status: GOOD (  20.39  )
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


> So maybe we'll take a step and think about what we actually want
> to support.  Here is my understanding, which might as well be incorrect
> and/or incomplete.
> 
>   1) support a uniqueue discovery controller for bidirectional
>      authentication to work properly
> 
> The only thing we really need is to have the existing discovery log for
> the well known discovery subsystems to be able to also show up as a
> unique discovery subsystem.  Either by just renaming it like your earlier
> patch did, or by supporting an alternative name in addition to that.

I think that making the discovery subsystem show up in configfs makes
sense, it can be attached to port(s) just like any other subsystem.

> 
>   2) (optionally) make the well known discovery controller go away
> 
> Just renaming the subsystem will make the well known one go away,
> but while that can be useful for some use cases, I think making it
> always go away has the potential for breakage.  So maybe we need
> to not rename but be able to create an alias and have a way to
> disable the well known discovery controller if not used.

agreed.

> 
>   3) Actually have a different content.
> 
> Can you explain the use cases here a bit more?
> 
> And maybe add anything else we'd like to consider.  (Everyone else
> on the list please also chime in)

I don't think we should support multiple discovery subsystems on
the same target. Don't know why would anyone need it. I also think
that reporting subsystems that are attached to all ports is just a
a routing failure waiting to happen. But if anyone really really
wants it, we can keep a flag on the discovery subsystem to report
on all ports if explicitly set.

