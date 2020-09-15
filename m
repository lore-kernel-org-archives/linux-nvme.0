Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33966C43461
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 23:12:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C23212CC
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 23:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0WsLJX6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C23212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iT/2wegaerPOCr78zCdzFXyg5ew2ABiaUFwgB92X4Ag=; b=0WsLJX6ABxNhsh+oJbHUT6kK1
	/STSqWhhFGhFxDVfzPdWbvKIXkW37kdyDdXo2rpOyK/nwwh7M9DKTyohLd0MN+sJ/1kXaeckpFEFm
	c0yEiaz2ZXEWkyziLomSU/XMpBgwwIuBv2XUAYChqpKbnfmh2XAZyCb9tZ/h/H8XD6ec4j+XdPduO
	Q7nYAy58eoIMOcfnn8FfwK+4j0BeCwEDYIVdClc8jJYLHmImhO+8082UztQiGvJFbGAqtHhXatzsW
	rk+IDgim1Mge7OIlIE8CvncEcjdcpcmhNfEv6FYZiC9DqY/zLJKra7QRS8FppXGov8dBbUmv8G+j4
	+FwtN0nuA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIK7k-0000jK-FH; Tue, 15 Sep 2020 23:12:32 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIK7h-0000ig-GN
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 23:12:30 +0000
Received: by mail-pg1-f196.google.com with SMTP id g29so2828701pgl.2
 for <linux-nvme@lists.infradead.org>; Tue, 15 Sep 2020 16:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vqm/9XGDJJs4kDeXPwxLa1UfDMy7I5MwHHgD2BXqul8=;
 b=fCJaez3E7yuIo1Srr3749oJ3vzucrsxZcBaifUSHXeKIE/3y4Rt9zdeaG7QdoBAhow
 US7154+za6r2xcUCThIzTFleDdB8cXxT61+HclTPMC+RyZopMJe9lHYtpxzdqsvEJIwG
 SK/YvCeTI2c6qAP89mwtJO4g011sCGaMGnvJLuU+X/j64DRS/wryuPnzlCK60tx1tRwl
 +ukPmJNgZux0Exdo1nHlwmzYJ+RwrVoVUD8wrWW9S1TWa3mATr+MmSGO8K1D85RHqnR1
 EwRQBKrd0IxcKw3emBiR2BpXrU/YMdoVz+7bkzE6zcVdPRTUZWhlMExwrn5Fszef2+6G
 ahSQ==
X-Gm-Message-State: AOAM530+PKVbVz+VOX4XUJAx89GoVv0KL7uBPw7d7jtYlMDu6a3fL9oo
 tkxusLFL5xTazwBvdUTkRMcnIW8PiDA=
X-Google-Smtp-Source: ABdhPJyGHL7cjSoW20heSj2ynEDcH/RGmHkJKruW7KAD7GKWmm/fqbzWy9gKbUHge/MAc85DrfRcuQ==
X-Received: by 2002:aa7:9157:0:b029:142:2501:3984 with SMTP id
 23-20020aa791570000b029014225013984mr3978318pfi.73.1600211548494; 
 Tue, 15 Sep 2020 16:12:28 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:40ae:2cbc:743f:8960?
 ([2601:647:4802:9070:40ae:2cbc:743f:8960])
 by smtp.gmail.com with ESMTPSA id k5sm14148896pfu.77.2020.09.15.16.12.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 16:12:27 -0700 (PDT)
Subject: Re: [PATCH] nvme-loop: allow ctrl-loss-tmo for nvme-loop
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200915230456.13159-1-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9aaecc8f-7eda-b792-2e5f-a8cc8f8178f2@grimberg.me>
Date: Tue, 15 Sep 2020 16:12:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915230456.13159-1-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_191229_586378_7A9D2CF0 
X-CRM114-Status: GOOD (  11.87  )
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
Cc: hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> Update nvme-loop transport with NVMF_OPT_CTRL_LOSS_TMO in allowed ops.
> Without this patch following command fails on my setup :-
> 
> nvme_fabrics: invalid parameter 'ctrl_loss_tmo=%d'

But loop doesn't do anything with this param, why should it
accept it?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
