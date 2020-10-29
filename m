Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27099C2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 21:02:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81ECF20790
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 21:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jqgvrg7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81ECF20790
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kWPTSB7MiSmnBwRhvemTUdHdzC6m3dFPamcKlc1yEpI=; b=jqgvrg7WIu36RPvzVVy5mrXfI
	15ceDy1IHU5se5nFcUAGQ0sVVzurxVy++knK8nYzWt/n4V+Cw9Cq8DoWvZ5ImkUNZll6NYJHv8HcQ
	zzXh/YvCbkaWksg3zuZuynycoxR8g2vfCPs81+zKnazXAqW7UcAQzKJIOjaWuU3aOjBQyzoE+RPit
	PmLbie2Bidsztcp/ng3wUzwzPXwV/QnamkJybEABXsqbYBrZwqhq+Gm+o0jwxDTyJUtH/3UxcYg7Z
	abFyWzUpqFBru5veIvPfvspAMhVM2mLDO/qwFMcydU7tfwqTIE5OIxjAoI48m8fUuGOqdz+kpxPOu
	zrTlwbSLA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYF3b-00021N-5k; Thu, 29 Oct 2020 21:02:03 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYF3Y-00020I-4v
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 21:02:00 +0000
Received: by mail-wm1-f68.google.com with SMTP id d3so1109744wma.4
 for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2020 14:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c9PkRMCGgoLGqjj3IeDTkd4Yt6oOBLCgpENgoS2p9fc=;
 b=fpj+i8zwWn+UB0TFed6Y7sMLUwybncUkSCJHaYxk12UHLeMMHzE2TFJDsD+K/zdprr
 JKvWEcS7iLAjNMYHcXmqctDuyMEl5z11VoTOPQTazgZOlYAmRdzcoK7OXtznFvr2VsWJ
 VtLCM81m5cKKKtJwsCki/LYdkSF3aITqv/rYbytv+2VoLg6HblBAkb8rRLrFnmnb/bMY
 JDG9K5N/JPDHXvncd02w03Bmj73N3siy9SsxJs574/Gc1rn7nz9JFjW4hJhuQ+ry3HoE
 WhV6cZ9L580p7WczYDUj4kCTFlY1HMW1fVKY5cnjiumEZVDAvw8E9OgX935N0zZGTZid
 uKoQ==
X-Gm-Message-State: AOAM5312PDIRabv2lt+Ub9j7STlesc9h/+BbPrEvD/Cr+Fx6N0e20YNz
 FncWHDO87bwe298yW1L9UPNsfqR8dmg=
X-Google-Smtp-Source: ABdhPJzWi+6w3Bx/T2k+VBbz1lAARCIEXQ9eEJse3oBhAE+SBmYta/lE4bLtgqCBMYWej8W2d1e5lQ==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr1172147wmi.58.1604005318843;
 Thu, 29 Oct 2020 14:01:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d32:e3ef:ad74:6ea9?
 ([2601:647:4802:9070:d32:e3ef:ad74:6ea9])
 by smtp.gmail.com with ESMTPSA id s2sm1995480wmh.9.2020.10.29.14.01.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 14:01:58 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] avoid race for time out
From: Sagi Grimberg <sagi@grimberg.me>
To: Yi Zhang <yi.zhang@redhat.com>, Chao Leng <lengchao@huawei.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20201022021452.10971-1-lengchao@huawei.com>
 <aba13cb9-a3d4-490b-4d1d-1deb60eafff6@redhat.com>
 <e913e433-d8ef-c04b-d9fa-3a6d71657136@grimberg.me>
Message-ID: <22167d2f-2b86-6030-8949-eeeab92fcae9@grimberg.me>
Date: Thu, 29 Oct 2020 14:01:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e913e433-d8ef-c04b-d9fa-3a6d71657136@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_170200_223393_C7BE69F9 
X-CRM114-Status: GOOD (  11.65  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> For debug purposes, can you switch to run blktests with siw for
> comparison?

Disregard this comment, forgot which transport we are talking about
for a second...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
