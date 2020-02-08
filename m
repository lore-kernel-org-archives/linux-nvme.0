Return-Path: <SRS0=8Upu=34=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6AFC2BA83
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Feb 2020 01:05:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B14D20715
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Feb 2020 01:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O25cksOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B14D20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vL7/fzfgQT9rLS5UCNqsQrmx2Rxb/1lZyy34wZ5f6Fc=; b=O25cksOQgd3QXsVUyUkvgNTQ8
	cQ84S80rlrxToApcMjQTmVpdbtpw9qFJuBo5wh+Br/BklHrqE8N9mxSNH7Ldw0IGObCSYAwXXtupc
	c7ujq3Yqz0GBPS3b1nfOpNYUTXq+bOYNp4Y1K8Pl+3LOQiOx+IXQdAOplnr05ddS3YqCoHI9UejTr
	J36HO4IBM3yBTk74YIWNcqLvyGWFdDSEN67tJAK+WoJMMlBxG+dOxdNocLagl5Rn7s0mLHcpMN8Q3
	Xvuo+Ny/aQqmE28+TILzj/2dbT07oz0AEJ/3JZf2nOne7uuU3BLAeDat5iosOo+89RwQjaoLao5p+
	wfOCQf84g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j0EYe-00024x-Kl; Sat, 08 Feb 2020 01:05:16 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j0EYb-00024c-Uf
 for linux-nvme@lists.infradead.org; Sat, 08 Feb 2020 01:05:15 +0000
Received: by mail-oi1-f196.google.com with SMTP id v19so3829856oic.12
 for <linux-nvme@lists.infradead.org>; Fri, 07 Feb 2020 17:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h4WLgv/KFL48xGRti2JF/TtCs/37Y8Ax7P6gxmVykI0=;
 b=RwwadEItClcvU/kvcXTLXu5h8rIs/Q/vLNuYg4jOEFOVTK7nYLPAGgszZCMtJDkM5W
 EH3u/8wbzmNshYWMd+ii+Ui4DE4ghCPEo7eLitzwLblJo8WPrBOCAaDvBoxW87PjZTED
 zx16FywxoQA4c+rRNpS3XcDo56lb1BwGVpLdT4ZUNmrP6+rz49uldh4jfINqngPEWefQ
 c4yNukKZQWPG/Mg/Jv3M9nAqZ5vd8+O1IAr/ip7HV9newlxumnBB5atJHP0rE4YIj5cV
 hY+JIX+w599vEri/JZ8PFjdmjWpwHrtpXXNJJjy2iMl6bvu93lZrQcYGeMI7DPrqoFvj
 9DkA==
X-Gm-Message-State: APjAAAWZ3sNRaZDNW/ZHrhImdGsApsTsI3HJiKLc2iNxEnUlhnLt85ea
 RDnspXbzGGIclIvuYLjZUgTtqGDP
X-Google-Smtp-Source: APXvYqzhpp72e5ItV4u02eVcVZy6GUcm6LNEvCk+Kw8Vl+iao4loNCk7muMw9F3f/yyekyZj3ummUQ==
X-Received: by 2002:aca:5106:: with SMTP id f6mr3780336oib.112.1581123911328; 
 Fri, 07 Feb 2020 17:05:11 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id t9sm1707415otm.76.2020.02.07.17.05.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Feb 2020 17:05:10 -0800 (PST)
Subject: Re: [PATCH 1/2] nvme: expose hostnqn via sysfs for fabrics controllers
To: Keith Busch <kbusch@kernel.org>
References: <20200208002111.10220-1-sagi@grimberg.me>
 <20200208004457.GA15482@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0ffaa081-8e61-9e86-6d7c-7baa32d58d25@grimberg.me>
Date: Fri, 7 Feb 2020 17:05:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200208004457.GA15482@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200207_170513_988200_A499E0F8 
X-CRM114-Status: GOOD (  11.17  )
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
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> 
> The code looks fine, but could you say more in the change log why this
> is needed now?

Well, its useful information to have, but I can add a few words on why
that is.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
