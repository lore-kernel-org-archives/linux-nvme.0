Return-Path: <SRS0=oc1E=F3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5D9C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 21:23:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9D9224B1
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 21:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9D9224B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ya259bhSngf4pD0N7hicIW/pWuw/wp5xaUTljUi+BR0=; b=OpUnGb5SyPxvs/hR7EBGnujUl
	6eK1BwSrz4HbNE9GAWSa3xMmok5xRE9c8mfW7ULbgxUH5RTuhte+qMAY7ChpN2pcd0m+1IDFY8VNz
	9xK7XdlBppdNJgQXjVOJV98xvo2kwXUGFB2W6YwFTwOhQfG1L+X+DqmN3PlO9ObZ57X8tD7HL7DQ1
	JxZeMWv1JkYZwb3jRUcYEqvU4FJU3aN3pdQ77uMG2UDtSZBgY2J7xtNkG9WH4uaEK8PfxK0fDKu2k
	kLwqqfoX/Bns7rlMCrHIWcUpa7Qs8wuea8hdONnBSd14y3MZ7dTQTqJMnbgUpfgNAGlKX7a5b0N+n
	EWkJDTukg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ksBbO-0003jV-MZ; Wed, 23 Dec 2020 21:23:22 +0000
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ksBbM-0003ic-Ez
 for Linux-nvme@lists.infradead.org; Wed, 23 Dec 2020 21:23:21 +0000
Received: by mail-pl1-f171.google.com with SMTP id x12so295349plr.10
 for <Linux-nvme@lists.infradead.org>; Wed, 23 Dec 2020 13:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QSrQzKYWUSWEVKj5b6E6X53rjWS1zqoMkgdWtFg3Lcg=;
 b=cSqUG8OFnemkvrpTizM59xtOKpdw+n9QuUj/dUmcYxCqrEvdSCgMBp9JsQizU/mqrj
 eGC9+Jlr0iOoDkZbNIML/fgp7whyQO0q70KzMAamtjf6m0FRuCsevEqbVUrAoo7rjwac
 3GkiKIOsf4Ay8wMA9eoGkCwL2q4E4OBBwDwux/dJd9KycBaiKcK1tWq8ruwwD3kloaX6
 fHcKX//1ASgbYfV6A3iQ3zZbewnelREkOm4qX2C6VtTKR0j+zK8uUzTiY826U8dkY00/
 yeFUtSYN2gF8RosVdU0Cu6ohu6Bb2YmjwR/Q8RaC8lxSZ9ZrQSHgr2I2AAr4uFYy5rJZ
 wkWw==
X-Gm-Message-State: AOAM531diYdJA3pVJQMx74AxULetnqWFLRHeEzef/IXWlsy7Z9YCTVnr
 sZw/0T4wPJgT2VRDGN+3r+21tGUxSF0=
X-Google-Smtp-Source: ABdhPJxzdDkqy5O11zoODW3NYeq8l8x4bmQpPtur9JJy53rvh3aKtsF2baKkFXP12Cb8l7B9Cpzgxg==
X-Received: by 2002:a17:902:7895:b029:dc:4bf0:2b74 with SMTP id
 q21-20020a1709027895b02900dc4bf02b74mr2685808pll.32.1608758597911; 
 Wed, 23 Dec 2020 13:23:17 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:8c81:7d09:c1ab:94c8?
 ([2601:647:4802:9070:8c81:7d09:c1ab:94c8])
 by smtp.gmail.com with ESMTPSA id ay21sm515293pjb.1.2020.12.23.13.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Dec 2020 13:23:17 -0800 (PST)
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Christoph Hellwig <hch@infradead.org>
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
 <2c0ff5ec-4ae2-ad29-67fb-4744514dab47@grimberg.me>
 <CAJS6Edh8aVAHhKRGqU+7v5C3KY7YxczVg_7Q8QrPGtyvVw7K3w@mail.gmail.com>
 <fd4541e4-78c5-ec3b-b272-467fd11f7472@grimberg.me>
 <20201223084332.GA30502@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ad826e9c-021b-7750-314a-f44ef58944f9@grimberg.me>
Date: Wed, 23 Dec 2020 13:23:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201223084332.GA30502@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201223_162320_565273_0A4FF732 
X-CRM114-Status: GOOD (  10.21  )
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
Cc: Hao Wang <pkuwangh@gmail.com>, Linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Wouldn't testing with a not completely outdated kernel a better first
> step?

Right, didn't notice that. Hao, would it be possible to test this
happens with the latest upstream kernel (or something close to that)?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
