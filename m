Return-Path: <SRS0=Uv50=XV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DA5C4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2019 20:04:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC98621A4A
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2019 20:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sqs9cuVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC98621A4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tNwVbN+1M30OUzfmvYH6JVi7nuPlyDY437stjCe4Cxw=; b=Sqs9cuVbIyJxSaF8r73I1PACl
	hapuThgscJ92vYqo0ixQnP8VyvF59GZqB+jLsDf1JTg9z6p/ZJRcY8ZJPQksVaNHvNwpExhtTrZPE
	CH/tFZrorLWfRnp5WUG6g9mIk0hehuteSw0zxzQQ4CIQqLYtAqydnkDBesDwMD/gjorKlF+GDXmBH
	C8BBAV+iUCozKh43EXsb8SX8Oiyf007w5rwZ+uZY2guZcMoXkyGLMc1xUmWfdCqMMQulnQcR2ekFi
	BAULaUrPPpFqroH+BAmyqgHmhrfXyWxO1cCGyEqYL9PXhAnCIjOxpUD8+/BvFMkM3aTnvZi82VG/m
	Neg7ezmQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDZzc-0005zz-KD; Thu, 26 Sep 2019 20:04:00 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDZzZ-0005zf-VG
 for linux-nvme@lists.infradead.org; Thu, 26 Sep 2019 20:03:59 +0000
Received: by mail-ot1-f68.google.com with SMTP id y39so246938ota.7
 for <linux-nvme@lists.infradead.org>; Thu, 26 Sep 2019 13:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sOaP61NzCbjteLEjIgUHiaIabeRxs6SAIyG2Wbqa820=;
 b=uaRRXPFiLN84geyWrr6ODmiTM+MfvxYSM1HeFfjmAsngqa33z5G2k9H0553A01u673
 VbCnE9fF9W11KjzSYWi2VPOVX0x7UqErFJUPL4bXwhBmcNLc5brL4TaTLOOQC7P5IgHO
 KnqwAo2oxwG9P/rhzgX0PxnIfiiEDxEKYHXuqE4q35CK6xvVpnElGYBWO1PivBvsJWhL
 i0IlCcPIOm9IVPpY3FggWsPq9Jt5UAv/Pfu1gf/727M/HTCxR/y4B04ctVof000ZeAIy
 qTsnuI/DO+UoQ89MHlkcn6Ak6XU0oiHaCLaqhLMJR+EBOz6vMg0fK/w/SncbPlSMslVO
 VFtg==
X-Gm-Message-State: APjAAAXFFcTTL6vP6B/j24v9+yayoJoGKXfbaj5UFxlMsU0Jec3wl3Dc
 kNThwBiSvpJSX2vdAvHepzcZZi5S
X-Google-Smtp-Source: APXvYqwZa2jbjTt5msTlQwymnYNUsfqPZt4NTg1AcW/mpJPrGxm2SDZfK3qRDnrXBYRtotsEPzwwDQ==
X-Received: by 2002:a9d:5a06:: with SMTP id v6mr365418oth.250.1569528236556;
 Thu, 26 Sep 2019 13:03:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id g18sm105450otl.76.2019.09.26.13.03.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 26 Sep 2019 13:03:55 -0700 (PDT)
Subject: Re: [PATCH rfc 2/2] nvmet-tcp: set SO_PRIORITY for network sockets
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <B33B37937B7F3D4CB878107E305D4916D36846@ORSMSX104.amr.corp.intel.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <63782282-026f-b12f-7a97-3e5d9643e262@grimberg.me>
Date: Thu, 26 Sep 2019 13:03:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <B33B37937B7F3D4CB878107E305D4916D36846@ORSMSX104.amr.corp.intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190926_130358_061730_49C3FBFF 
X-CRM114-Status: GOOD (  12.62  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> +/* Define the socket priority to use for connections were it is desirable
> + * that the NIC consider performing optimized packet processing or filtering.
> + * A non-zero value being sufficient to indicate general consideration of any
> + * possible optimization.  Making it a module param allows for alternative
> + * values that may be unique for some NIC implementations.
> + */
> +static int nvmet_tcp_so_priority;
> +module_param(nvmet_tcp_so_priority, int, 0644);
> +MODULE_PARM_DESC(nvmet_tcp_so_priority, "nvmet tcp socket optimize priority");
> +

No need for nvmet_tcp prefix I assume.

Should it be a bool if a non-zero value is sufficient?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
