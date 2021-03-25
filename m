Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7ABC433C1
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 22:20:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0326E61A32
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 22:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0326E61A32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OcnOe4w7tI+KP+Bwlque8b1Y+VnU4l3bOVQ39nd0CGw=; b=ITtfV/DMj0svFYggxqnYuc78b
	VI1pJtg3T4ma4c/qEAx9dZ0JV6LxS7fT1/EI+av3NV8TicxF9+yVAZGg7ESD4lTrO7yvbl5dcc7gd
	OKtXct1N05L6MExrKfsRUQ8xOK39ex/lCKhDCqk6IL3v1OCkKhHGxtyNoJDyPNfENwi6XNACN64Jx
	W4v0JVcyt8vqVGfcQMURi6CAKzqAzmNiOICvZNpiBGQMoneiQL5eXJmJifX1IHrkEufyZ+NhEjRT6
	o2rlgV9tvuLuxEG68NHyMMGeN0uXIAR/1Ag9jHaKjqsavteLkdOTNfWNQlE+qOcsOUzKeLz8UY5eB
	F/hAa95Zw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPYL1-002HJp-S0; Thu, 25 Mar 2021 22:20:24 +0000
Received: from mail-pg1-f174.google.com ([209.85.215.174])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPYKu-002HIi-0c
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 22:20:19 +0000
Received: by mail-pg1-f174.google.com with SMTP id l1so3234645pgb.5
 for <linux-nvme@lists.infradead.org>; Thu, 25 Mar 2021 15:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Eo4GbMCVmk4mS2hNaPEGNS88yhMqkgUCtrkjU1Rie8o=;
 b=FxWfNtHMXvl6iW/twa29pdAtlhCGW9CB2/7RmgKFdoIIoWg309D14ryCWJUJwNgWhD
 q8kaT44oFP8eC5+eFXGTk+ZSz1JQ36xzEO8mpnU/WKrnGimHVTNmfWa0fs6uk3Jd2+O/
 FQFCtAxF1pI2HDAZ8Y5CWrLsl5kM3spg05G+/UJwgjWoxerrhbHz1SDkMgKeSEzjetD2
 uRN8rMYxjoNQeLhgcu1x3AQ6x8RJ0N1Peswtody2qEq8IJxjsTE5entEGpxsxTtlbRYQ
 Jc1a9WnlWOE8KjEy2TUxPj2WHLQ2JZcAI+jeJe+PcVm7EIOd7t+ZrZKXJ8Y/+HQy0Wvn
 HVpg==
X-Gm-Message-State: AOAM531vNycGnciUdevf4I2edzfu2yqsNZbDWmv+keSz3bQbg2+edfT3
 QMyE0DUo7hBrJA7lCrHtuY4=
X-Google-Smtp-Source: ABdhPJztK2kJCnVLV+Uxb1gmbKublIlBPRHzWiljl9GOS6dVKGecddyvKbmQQ0cd+/WX2dmANb1QXg==
X-Received: by 2002:a63:2152:: with SMTP id s18mr9223802pgm.190.1616710812904; 
 Thu, 25 Mar 2021 15:20:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:afd1:1d6c:5e0d:635f?
 ([2601:647:4802:9070:afd1:1d6c:5e0d:635f])
 by smtp.gmail.com with ESMTPSA id y23sm6829523pfo.50.2021.03.25.15.20.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Mar 2021 15:20:12 -0700 (PDT)
Subject: Re: [PATCH] nvme: retrigger ANA log update if group descriptor isn't
 found
To: Keith Busch <kbusch@kernel.org>, "George, Martin"
 <Martin.George@netapp.com>
Cc: "hch@lst.de" <hch@lst.de>, hare <hare@suse.de>,
 "Meneghini, John" <John.Meneghini@netapp.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Knight, Frederick" <Frederick.Knight@netapp.com>
References: <20201205152901.56665-1-hare@suse.de>
 <cbfc78e1-87be-cc09-9b8d-44bf0659eb26@grimberg.me>
 <92763a7271a1eb07e28901e3e91345568202eda3.camel@netapp.com>
 <20210325215427.GB32286@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2744ecea-938a-6ed1-1872-29800628ea17@grimberg.me>
Date: Thu, 25 Mar 2021 15:20:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210325215427.GB32286@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_222016_225633_8A06ABE7 
X-CRM114-Status: GOOD (  11.76  )
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


>> So could we now have this patch pulled in please?
> 
> Yeah, I was fine with the patch initiailly since it is harmless and
> provides higher tolerance to unclear behavior. The ECN essentially
> requires this patch now, so again:
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
