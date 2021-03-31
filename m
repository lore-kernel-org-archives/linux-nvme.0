Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DC0C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 02:18:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5CCB61883
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 02:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CCB61883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=a5n51QDpDHUerU5h/Ueue4XsZpeQjS3DZleVBCe7CRU=; b=ZBfppCY+mmQm24neDZMrC2J2K
	tmVk46Jkh1dkB2sBeejwUoQPLxgmWpq4jLdYo7AGdkd0CopB+CRIZN1UHiFfd6Lue5XGlmHjd3h+G
	9QNIKl3kkOmd9QShM7izP/XQwxTHhw/cH+fnRNXubcVQi2IHRqbDskTy7YBvqWg/61Gppgv6CbNaK
	BAhbqiuiEkEM+YvR7Nd9BoZfu72ASwvlZtw72Ix2UcKBRiRyD1I/wGe1Lme1wgHvFS2mqupyGKtHF
	k5CB3rMCRy/ydy8vqm0ud/JTxIECUfrKFzNGHFUI4OtaIrtljFnmPSBro+GwLKesGO8qSlGdfgdv6
	mftmhPp9g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRQR8-005IJ2-Im; Wed, 31 Mar 2021 02:18:26 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRQQy-005IHD-Cz
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 02:18:19 +0000
Received: by mail-pj1-x1029.google.com with SMTP id
 lr1-20020a17090b4b81b02900ea0a3f38c1so2243095pjb.0
 for <linux-nvme@lists.infradead.org>; Tue, 30 Mar 2021 19:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=BXjQG1h39eO7ectozhKrUMTr3Hzok9ohxYR+HgDC0c8=;
 b=fODuIBvsiYnDp/bC2bgc+aZ+7U3/wiaOOPdLkAtiDG5ALqJb3YsaCFPjBEirc19xMs
 Sg6+lSCC4Mf6z5wRLQgzLbcMIiPqo/KlBHZfMd5TXc4wZouPXaLSiR/jvYMzfrLiMuZh
 wCscEp8mUh2diOTal+QfEBHUusWATEh7cN9cqZJl/jLcCcpvIKGW/eWVgl1fAgwSmF6w
 zifnIBU33qsws4sOekyF1KU0TXsJx3RNDJPX2qyV8PvK83Lr6xmXw8N7jeh6pgdV+vcm
 mJuhhtly8ymb+DKbtZBmYA4h2Hqg9SXUyToKcIYU7N3zkB9bhn5WPFo//TNw477aMo9A
 mw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=BXjQG1h39eO7ectozhKrUMTr3Hzok9ohxYR+HgDC0c8=;
 b=SLP+66j1kv85xMRAjq2UL8appaJUKx8ZomswuGfv+Ewr0Ng0QkUD1UHntLNxXlrHCD
 qOvVvr1JQ5DwTLhkMyc/sVss/A6iLoyzTE725itvetXIEsMeh6la/cILvi7v5vWwFimH
 hhDbCb5isPAU9VFiXPhVXUzNhzs4x4JtdGEpoZjT0WHK9JFWlSUXPR9ktNRvZuD3kzkb
 RsZ9NJ1PwK2lEovnfCfw2+rZ5C2os5vq8SCS20XfXwvKeQxdm9opdtt+wwhiHa7SlBa7
 hunzF7Cf73PU2SdAdbCwhHKOVXCmND4CScVu+rgwAnUkagUg15Yj2QCe6bGO6kJAdnwO
 3xSw==
X-Gm-Message-State: AOAM531RUgTGafVYiIfN2ayMhOKxKabX+JHRw/Y/RV9qyyepVt8dLCjh
 UZzbR0vQLumW9+Yo5JjQtzQ9L9M4agMnhFCb
X-Google-Smtp-Source: ABdhPJxhbOaOAFlA2yXN6BZVr5iP+bD1hrgM7fVWp1q22l9f1IDhCaXsf6PKpOO/j8AFqJgI6lFnww==
X-Received: by 2002:a17:90a:c909:: with SMTP id
 v9mr1228105pjt.218.1617157094841; 
 Tue, 30 Mar 2021 19:18:14 -0700 (PDT)
Received: from houpudeMacBook-Pro.local ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id 6sm291930pfv.179.2021.03.30.19.18.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Mar 2021 19:18:14 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvmet: remove unneeded code from nvmet_alloc_ctrl()
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20210330115907.15432-1-houpu.main@gmail.com>
 <20210330115907.15432-3-houpu.main@gmail.com>
 <BYAPR04MB4965E59C632B8A45D015B4EC867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Hou Pu <houpu.main@gmail.com>
Message-ID: <0eb32563-a2f7-3b20-64b5-bb17c6981529@gmail.com>
Date: Wed, 31 Mar 2021 10:18:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965E59C632B8A45D015B4EC867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_031817_235028_8499888E 
X-CRM114-Status: GOOD (  13.22  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDIwMjEvMy8zMSA3OjMwIOS4iuWNiCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOgo+IE9u
IDMvMzAvMjEgMDQ6NTksIEhvdSBQdSB3cm90ZToKPj4gU2lnbmVkLW9mZi1ieTogSG91IFB1IDxo
b3VwdS5tYWluQGdtYWlsLmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy9udm1lL3RhcmdldC9jb3Jl
LmMgfCAxIC0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQo+IE9uIHdoYXQgYnJh
bmNoIHlvdSBoYXZlIGdlbmVyYXRlZCB0aGlzIHBhdGNoID8KPgo+ClRoZSBwYXRjaCBpcyBiYXNl
ZCBvbiB2NS4xMi1yYzQuCgooaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZHJpdmVycy9udm1lL3RhcmdldC9jb3Jl
LmM/aD12NS4xMi1yYzQjbjEzMjgpCgoKVGhhbmtzLAoKSG91CgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
