Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB3AC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:59:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E1C664DFD
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1C664DFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9WDe5fZ+0y9UpVVoQXBL2tWXk9q6vHw6ctlBIgJKlDg=; b=G4sUOTqiAdosYI0TDQ+sCUwEG
	e+6fEyK+2wJF2tfvq8E1rO47lCNPQH4WVR+fWKFu0vKCKHm+xsJ5i6si+r1i0SkM3EhrQ9hRgjNrQ
	0PUPdcqvqB8cRVCfINFCV70YUyo0ZraHLSSXerem+yR2g0YB1Zi4tyHbFo0HwcnT3sjUU3v0YE+SP
	+ck4kcU/W94igm/Ra//tFvX0rMY3sNy6NSMizgSSPArzr0Wjxa7oKexinUAOCxLdWnoHS7odqYwHk
	p0QO3yZ4mWRVkAHmia8Ud8N/AdspdkvkLPE4nfMyHLII6GdCiEpm2MTtYToJ90eaRvCCLsuiZGSML
	Zh1Lv3ltw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5J4E-0003Mj-0i; Fri, 29 Jan 2021 01:59:22 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5J4A-0003Lu-G8
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 01:59:19 +0000
Received: by mail-wm1-f46.google.com with SMTP id e15so6002626wme.0
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 17:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EPcjrBHYIqIoDWAiKwk293Y/CuqUzbJrZNJlUVgaAO8=;
 b=eTn4vuOdFL7cXiA0Edh7D8tMMNPk5PTmQ5X59/QOKluMn71dmurTskBoQPw2pDQ0bn
 nPNDqqjDs/lmGTwNv9z/lMF1I9ubK3BOduFXY4tdlCYz9sNP4jA8XhIlkHEcFkTDitg0
 E9xbZGF08qA3ZZuGPimduOlID3JsPGb0wIeHMXi3tncJ3MCd+razUUDTmI5cmNgRiOEy
 hnfFqiA1EqYxZozVMyMYhrrqV4fMmzM5fYit1x+vVGXX1AbQCebqECrZ++UI7yPt2pJj
 I+PFlK6XByT0HoJAb8M3ewFyu4fm5XWHbEvlmecMZf34gi7QVshBzDsDIcR9Tv8es340
 ksAw==
X-Gm-Message-State: AOAM531JM8t9w4tfHSTaEljkEkQly9SoaMiKL/38nUrSo5gbA3Cc5r1I
 gk63CwBo4OECqu2tWdYlumg=
X-Google-Smtp-Source: ABdhPJxT7lGfP96UXkzv8kaRd4LsIPra4q27GsQrxBdAuH8WVKIMQcOyrjPfg5AO8BfdnQunY9m+HQ==
X-Received: by 2002:a05:600c:201:: with SMTP id
 1mr1631314wmi.104.1611885557336; 
 Thu, 28 Jan 2021 17:59:17 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578?
 ([2601:647:4802:9070:3d48:4849:d506:e578])
 by smtp.gmail.com with ESMTPSA id u3sm10018714wre.54.2021.01.28.17.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 17:59:16 -0800 (PST)
Subject: Re: [PATCH 22/35] conn-db: add simple connection registry
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-23-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <322b27a0-ff3e-265b-4c69-fae54466631e@grimberg.me>
Date: Thu, 28 Jan 2021 17:59:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-23-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_205918_556219_5A59B4DB 
X-CRM114-Status: GOOD (  13.08  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> From: Martin Wilck <mwilck@suse.com>
> 
> The monitor works best if it maintains a discovery controller connection
> to every transport address that provides a discovery subsystem.
> 
> While controllers are easily tracked in sysfs, addresses ("connections"),
> i.e. (transport, traddr, trsvid, host_traddr) tuples, are not. Create
> a simple registry that tracks the state of "connections" and their
> associated discovery controllers.
> 
> A detailed description of the API is provided in the header file conn-db.h.

If this is more flexible, perhaps also the main fabrics 
discover/connect/connect-all can be converted to use it as well.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
