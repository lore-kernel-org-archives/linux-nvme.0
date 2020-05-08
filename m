Return-Path: <SRS0=GxYq=6W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376ECC38A2A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 20:12:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3AA420CC7
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 20:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cvTpVqOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AA420CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=orb/GNfT1sZ+RbD5J82hGkG0WDXuaFuJpd+UX82xz/M=; b=cvTpVqOGW9cjQWczBKarBz8GF
	Mvb+AklDWspCBYQZ9kugzzCXXtFrjVoo3t5x6CI3JCbvUu3fVTE7rqV6tRxVVg5s5A7id/PmTXh9I
	ZP8oAN9f3bNaTNUe/gNTS2gHOgBTfNEnK8LkrXDUp2JlOZA2R6vc2AY4jxLCOtyEM7I7Ubgg0NTLC
	Wqgl2u6yqAIksz1YdXjY8Vi9ZBrz1F2PwWucLIo7C4FA2EJcSkC7xD1aGiSkbk6WmXsxyqOK0qnTi
	hIOYlKHYqTAelAxvT5qI15ilR9dOqaVXY6VdAiRtNIDndPPuM+m0r3DjU/h2fOyqfBwf47oEJN5Hx
	aWmoXHDYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jX9Me-000582-4B; Fri, 08 May 2020 20:12:56 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jX9Mb-00057X-Qy
 for linux-nvme@lists.infradead.org; Fri, 08 May 2020 20:12:55 +0000
Received: by mail-pl1-f196.google.com with SMTP id t7so1221193plr.0
 for <linux-nvme@lists.infradead.org>; Fri, 08 May 2020 13:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6SRe/yASNzVcHeUTX7RGNicVJss864tWsTBoQgkbFb4=;
 b=hneN1NmE3/sraVp/liNPKJcOYrS5sj5OhzQLDT7+3FL2KnIDpqKuH8O3xMR6gx2tAy
 U+T90TDWLs5v8WWneOz6fI6ehnwMXa6eAMw1+J46zGsXte9/RdIsO9UeF1BERWJ+dHzu
 bbnBMC8LuHt5h20vs+8S7XsBEf9BHodUp3B6nkSmWGRXJHS5ISG+uCzfgNu+Zx9M4uZK
 W9WSLylkoNmsP3YE1M3su5UtlEpFPFbEkq+78x99dsD9kDcvufbUmxmaHFCyewcCgMxc
 PNUuIis/4ZwM8uQOf9AkHgZy/WuA5139mCGvgKUtNxj56jVPVeEOB0UUkF4fLT3PAR4w
 n/dA==
X-Gm-Message-State: AGi0PubCrMjqRcs/f40KKYi1rzPzaTvkPWtxy8nW55Xs/ssRQRPzY0Gc
 7k7AmTPB8vOcGNd8N7dI0Yw=
X-Google-Smtp-Source: APiQypLTZyGm9NNVea7dNnoV/BIqQ5KIbqtvkYSoL2nzEaWnlcLtZI+Vp10rr3ETlY3aHdEYzmDX5Q==
X-Received: by 2002:a17:90a:eac5:: with SMTP id
 ev5mr8223349pjb.173.1588968772522; 
 Fri, 08 May 2020 13:12:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:bc73:49fb:3114:443?
 ([2601:647:4802:9070:bc73:49fb:3114:443])
 by smtp.gmail.com with ESMTPSA id d7sm2052353pfa.63.2020.05.08.13.12.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 13:12:51 -0700 (PDT)
Subject: Re: [PATCH] nvme-pci: dma read memory barrier for completions
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200508200406.2814437-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <34740788-df94-d2e0-fa63-5568e379cdd9@grimberg.me>
Date: Fri, 8 May 2020 13:12:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508200406.2814437-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200508_131253_872245_3E717B56 
X-CRM114-Status: UNSURE (   9.48  )
X-CRM114-Notice: Please train this message.
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
Cc: John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Control dependencies do not guarantee load order across the condition,
> allowing a CPU to predict and speculate memory reads.
> 
> Commit 324b494c2862 inlined verifying a new completion with its

I think we need a "Fixes" tag to get it into stable 5.6.y right?

Otherwise,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
