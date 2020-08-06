Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69F0C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:18:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB8B2177B
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LUcttFYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB8B2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=id1WpzOd+8QZjhddRr3vWvEwnN01lTFOa3XhR3V1Okc=; b=LUcttFYL6w/tQblvSjYCVF/iF
	jZjAiG93Aj6/CbYy+bmRWElUffOg1kWQCBlmyE18eSdvkfgYO37aYEuH7bZXNvO8H5dNi+pOZgG9r
	GnhOX8/9Mtj8OzljiuoEGM3fCRrR8rDh9FdSqXyu/HAVvF3MsHz3K182ZoVKH1iD3qMydMvvOYmJ8
	Aj1nDCXn0L4R47gbvryFnJ1f2snom2l/WLsRejzA0UFC92DNSVij9p6niEKPWOL1cn0sXQjNjmkCd
	WrYbD8PhsdoA8CwMMPqh8tzwUZXU1k7CO/4hazrEgUEKOXvGD1i+chjH1ucYahLxexNGaNft736Gp
	uM8M3acbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lPA-00026m-U6; Thu, 06 Aug 2020 19:18:20 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lP7-00024z-49
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:18:19 +0000
Received: by mail-pg1-f194.google.com with SMTP id 128so3902740pgd.5
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 12:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3GUcWBqx3auoQSaf9C6kv/2Ib6AhsVp/v8N0QVa1ypc=;
 b=Wy7VVQAK4eiKJMZbrjfptbw1k4E7DRtEsN4eSohp4wGeE+XUXw/HoJwLGiHcsg1P1p
 6J9o1GX5xlky4p6+/h1V3+Sr4dCLrV4Wvh6I5l8dAMgSFXBetSAoLwKbuAiaSO+cgHD7
 AtDAMeBMRKu5tjVNRjbz1G422m7Py42OoHJ+wRPTvtXHzAlf21J8VlTiQrPjoDlhTKEI
 5q8pWPqZq0d0Q7yUlDTg+IqEfaO5FuhqWlFw95Kaa379sQ0w8/rwUntxoM1zxOr4WcRN
 9k1jJ7Ttm/aya0r9ZpE/WXEZDjuL7nhSkqk+PCCf3iquF+D2qZ79BnUIOQE/R9a0qIAa
 3tLg==
X-Gm-Message-State: AOAM530FMw6prR4mB3UJyWAcZy5bapb+2Z1JHc3DaquqKmbsTxh+4pVZ
 lKtwDyHiJWgPjQHu0qPmnOg=
X-Google-Smtp-Source: ABdhPJx8vDZkZSAAfBA09XMoivjTH8QUixtCsdaq6+uMaDNGLMLqf17wLXO8AQ8wueqKAFljN0aMsQ==
X-Received: by 2002:aa7:9636:: with SMTP id r22mr6120898pfg.304.1596741496026; 
 Thu, 06 Aug 2020 12:18:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a?
 ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id e9sm9273711pfh.151.2020.08.06.12.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 12:18:15 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
To: Logan Gunthorpe <logang@deltatee.com>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-2-chaitanya.kulkarni@wdc.com>
 <20200806154247.GB3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <1f6a1c73-fd0e-d05d-3254-03d0592ac998@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2b345117-b149-939b-10e4-9493223c8f56@grimberg.me>
Date: Thu, 6 Aug 2020 12:18:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1f6a1c73-fd0e-d05d-3254-03d0592ac998@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_151817_217699_9D627401 
X-CRM114-Status: GOOD (  17.42  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> I don't think this is quite accurate either. It looks to me like it's
> just a bug in the error path logic. If the namespace is invalid, it
> doesn't even try to allocate the request so it should really just order
> the cleanup correctly and skip it, if it's not allocated.
> 
> I think a fix like this would be cleaner:

Can you please send a proper patch for this Logan/Chaitanya?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
