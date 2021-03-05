Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFDEC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 21:01:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F3C6186A
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 21:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F3C6186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zq/Cu74f9uH4610DMWaSYygmVEfVcrA55bWS0hN9iUo=; b=Q25cweHGliAJ4ZxcIgq6hcNA0
	er57GpcDxZ9Y+XEkfOmX1J30/ZJTPf1Byv4u0mORdqgKl7agusQnKo4KQHcZvFln+tlx1tU6m9PwG
	n47SE/kQBl401CDf5TD3FJqfzewoVUV+TSLUrxTiXMid6vNCGnQnuy8qgJV/JzrZd/sJbpW9KCMXY
	/jUwfFQL9I4Q+PN3je90n7Mv1jqGwj9dk9QHStm+GTDCnqN7r8ZPWCYpS+DZQdMBueJYT8AQ9EypY
	GayiN+mxQGU2KBHAF5pFsHXPJ7/yoMdyjyyg+Ph1icc7i5lcmLJ1YQgEkmQPkGcuVg9xOG3YfNghZ
	HLRU0bozw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIHZP-00GU6l-C5; Fri, 05 Mar 2021 21:01:11 +0000
Received: from mail-ot1-f43.google.com ([209.85.210.43])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIHZF-00GU41-QJ
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 21:01:04 +0000
Received: by mail-ot1-f43.google.com with SMTP id h10so3160466otm.1
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 13:01:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fzbwvy0QQ6KRA4Mt/35yAdvxH1XUcDstVEdEhKVB8dE=;
 b=EAoJD11Nu17F9zfJuGVjZzxJYk7gzGlIGPuIArOk3KsQfvAEMOo4vkqy7YsrOAjttP
 3CgmaxqENDwR7rvGBBud5fJ/0jRR1GVG2v0zzsVUfwz90OpRCHzHeQIg/3uFoWz0yCnO
 hNItxq5N8e8Y0EpNAxe+fQkan6ubSdq6F143FXOqm37L0H3HvyXBUBc7OPG/wf6ogNJW
 7GyzTx3zluydO0wFaTdZSYNRd6xl8jQ1QVTaMv/JYKNrqQ3PNJfyfL0rlM/EkEvjnI55
 YiRclk9XDs9yMf24/rgxcsE/+vR0NewKV+nntlqImvLoQ8mtkqfTW+yF2tkdLReL+2Pz
 VcPg==
X-Gm-Message-State: AOAM532shSyo93RpzTE324SKMw9Mkqmz/4twb2L/AGmWQG8JT9rsYiXy
 KNYfvDEaMWYh2stVE1PFIRytQn5bem4=
X-Google-Smtp-Source: ABdhPJw2oIGDBEXOn3cTGCilBS1scIn2XAZjbiIwOqX52sQd1Mv/8Dste1+W23ntz0sryU7E2E6lAA==
X-Received: by 2002:a9d:3f75:: with SMTP id m108mr9739333otc.42.1614978060289; 
 Fri, 05 Mar 2021 13:01:00 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id d26sm790992oos.32.2021.03.05.13.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 13:00:59 -0800 (PST)
Subject: Re: [PATCHv2] nvme: send uevent once a multipath namespace is
 operational again
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210303121227.65688-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cf86b4b2-47a4-857f-eafa-4e673f1f5c9d@grimberg.me>
Date: Fri, 5 Mar 2021 13:00:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303121227.65688-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_210102_464970_A2CFFDD5 
X-CRM114-Status: GOOD (  12.29  )
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


> In an all paths down scenario I/O will be requeued or aborted, and no
> further I/O will be ongoing on this namespace.
> This leaves the upper layers unable to determine if the namespace
> becomes operational again eg. after a successful controller reset.

Who is upper-layers here?

> With this patch a 'change' uevent will be sent per multipathed namespace
> once the underlying controller moved to LIVE and started I/O processing
> by calling nvme_kick_requeue_lists().
> 

Other than that looks reasonable to me..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
