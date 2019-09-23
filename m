Return-Path: <SRS0=8MmT=XS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50724C4CEC4
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Sep 2019 17:05:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208C920820
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Sep 2019 17:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ii77mZsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208C920820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AAuUR35TShE9z90CuyTRGl/WB43ORRnT3Mz95qnQXSE=; b=ii77mZsgwgjU+3IV7cfONaz9n
	H2odettFWajoZXzAa4qg8HjcIdkzX8SCIl9CYzBtlHhux0eFlBJtO/ADMvtn2QIFlcHtZ0pFw7uNF
	9liBVXyn5au0I3tP1WTLTXmmyyHS/nKgqMXCcj/Li6d43Y2IMWgc+rmcTA35E/Ug8Y/7tRfP5pllX
	5s0wTz6JbCTVueUpfs0nWcuTgAvKEQVK7JeGmuYggMwR50ckMmm8l0OuwEm5tgNiKF7sHFKmzdkT6
	1fCO8UKSMR0RrdtMsCtxgT0xdLGRpUbvzozJonEO3/9a9fnWfwcdZ+I1PReOXzR920cqr5UUKoLDN
	9ruQqKB6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iCRmB-0008Ee-Hb; Mon, 23 Sep 2019 17:05:27 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCRm9-00088y-3b
 for linux-nvme@lists.infradead.org; Mon, 23 Sep 2019 17:05:26 +0000
Received: by mail-wm1-f68.google.com with SMTP id 7so10861850wme.1
 for <linux-nvme@lists.infradead.org>; Mon, 23 Sep 2019 10:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+NSghiXdymFRz8hFIM04tw1PQqs9DJbDZYrafKOpMzI=;
 b=QY9NcmNG2CdEmfKm2Sxyf1Jgp5eIsf/EOR0gZ8obYMTce2anvBj1Mwjms9a4LV01wI
 Pg0DBcDseepn8TuGpIU3vaVeFQg4BovHR6oPxnwuaRAelz9E72cHb50QOJYaLvPSa7XA
 8iNKO9613qy8KcfaU+uUdvlk79aU7Mqcfmolz68TGyirra93uL9h4mrw40HdCctoMTEu
 GFpGF081FtP+0ZWzwRniFZzpNchk2dOqg+Sx047zDRAgIBUsxesWWC4lHz2zKikYMY5m
 lJKZN/Uo5PVPmDYRYzvB7E1agA74skR8dzkTuxCcHyjm51ZmP3Bmmi2+nmTEyb575UaN
 B7gw==
X-Gm-Message-State: APjAAAWdQStaAXbjPWvWteKN9KapOzUojUxOGWb1E+4VAKRtzfHDEi6D
 UjoA1O3dmaYFPzXN18Ht5tksPWO7
X-Google-Smtp-Source: APXvYqygZ6f24N5vj07ZzRq01NtuF4vqeWbORZAHUzpHG6vAeC/H7THDvVx+32djqeQOQiuUELT1DA==
X-Received: by 2002:a7b:c757:: with SMTP id w23mr475488wmk.31.1569258323576;
 Mon, 23 Sep 2019 10:05:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id h125sm15185593wmf.31.2019.09.23.10.05.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Sep 2019 10:05:23 -0700 (PDT)
Subject: Re: [PATCH 1/2] scatterlist: make sgl_free null pointer safe
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20190920181818.14424-1-sagi@grimberg.me>
 <BYAPR04MB5749A22666141F6BD6E07573868A0@BYAPR04MB5749.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f7c42702-35b7-24d3-ed45-72441e75bf4e@grimberg.me>
Date: Mon, 23 Sep 2019 10:05:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5749A22666141F6BD6E07573868A0@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190923_100525_151925_1484702D 
X-CRM114-Status: GOOD (  12.51  )
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
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Unless I totally missed what you are trying to fix here,
> I think this case is already handled implicitly to avoid
> the code repetition inside for_each_sg() which makes :-

You're right, the condition in the loop makes it null safe already.

So we can safely disregard the first patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
