Return-Path: <SRS0=Rbl5=MJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C3DC636CA
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 06:16:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA5136115A
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 06:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5136115A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5bwic09XSgLMNoweU1KVGK+jie0S81cE14ZKPbgzfrU=; b=sAZNXNbWQYeIP38gHJzGwsPgo5
	lu1wQZF8Tcs3j+fzNdZSpDnd5R76FVFdckvhlpdTgLRdCxGx4mMheOn6HNj7pcQsWOL9BIy0UlvI7
	PvTYX+p4dKLf1PtSqVRakDBXE+cvWswYgb8obUM4JyMEJ/upKW6JhM+tr8gK/KizRNc1cr74yibik
	MLLtZezumMNRLZ+D3K0NPIrsSAdHYJwdtk9IfyOsUyWoEItwD38EIhhtlJKnK/IJFpxJap/eHXl1v
	hME7zbl/CcYvvbTF0a6fAuTf3RGAEUiJ4/P/BntkXjZVZ1TsUwleb5qv76Z7lbqCETARFbowIbR2E
	8R6gbUvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4dcw-0063C8-M8; Sat, 17 Jul 2021 06:16:42 +0000
Received: from mail-pf1-f179.google.com ([209.85.210.179])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4dcu-0063Bc-BY
 for linux-nvme@lists.infradead.org; Sat, 17 Jul 2021 06:16:41 +0000
Received: by mail-pf1-f179.google.com with SMTP id q10so10694883pfj.12
 for <linux-nvme@lists.infradead.org>; Fri, 16 Jul 2021 23:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cLOwrRZ8XdTMGJ02GNn5GwoySVd4zqzZ4mVDU+aI7bo=;
 b=IJd73Z4yXTYi495GHpL2W483KJusuyBGq93JK/sfB95yJh7ieBDoZ9S/dtrluAAMX+
 tnHpj56jBvzYHaAdf86N5TkhUC/MCjjq2YdHubxPIGTTl0oFon0IPHt/xUoHkPBO6bGG
 Y+o+HsadWDQz+yBdJcW7h3WUemitZPAeperPkAmdZ3adm2z59jc0RbWRFmyQbqb5P3+m
 cmgM12YPubAK6+nCsZ/wX7CWls1JGqosYGo/K98nO8ufrhX2r7JxcEDBYBSFdGX+61Hf
 qt+0EVJU1+XrjToyzDYiG88ZQ1RmbOXI+6WjMzTkcxPQEPGHHtFInwLXlDbv0V8RzUUN
 sF2g==
X-Gm-Message-State: AOAM5322bzTu4Tdo4HwE5zkTd7CSOn5oklmEiOiIHtwUgshe/2MjnpLu
 8uFxV5SWhNvBjUuALijbxzM=
X-Google-Smtp-Source: ABdhPJxaaJ0iaFKX76PA2pZ0+oq7YpgNagS7e+Rvp9/z8CXjlQsr+GsT5mWo0Wt2PcEf2iKZRJlGpA==
X-Received: by 2002:a62:cd47:0:b029:329:714e:cce2 with SMTP id
 o68-20020a62cd470000b0290329714ecce2mr14151344pfg.22.1626502599424; 
 Fri, 16 Jul 2021 23:16:39 -0700 (PDT)
Received: from [10.0.0.146] ([162.211.128.122])
 by smtp.gmail.com with ESMTPSA id e16sm13978579pgl.54.2021.07.16.23.16.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jul 2021 23:16:38 -0700 (PDT)
Subject: Re: [PATCH 04/11] lib/base64: RFC4648-compliant base64 encoding
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-5-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a6708951-76f6-21bb-f7fe-e4bb32cd0448@grimberg.me>
Date: Fri, 16 Jul 2021 23:16:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716110428.9727-5-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_231640_447909_BFD42BEA 
X-CRM114-Status: UNSURE (   8.56  )
X-CRM114-Notice: Please train this message.
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


> Add RFC4648-compliant base64 encoding and decoding routines.

Looks good to me (although didn't look in the logic itself).
Can you maybe mention where was this taken from?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
