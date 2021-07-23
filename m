Return-Path: <SRS0=kg3i=MP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BA5C4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 19:43:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA7460E97
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 19:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FA7460E97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jikKwdeaCU7XLYFBVBhz0ALJY0KNnB8lLBVqwtqgiOs=; b=AnkTtdm0BnBGvM+lXIkLTEUMc5
	QhrxASuYCfmX2jCKFZmcqh/qMxxsJqp3D0Lhf72WYTgBHH8/GiOLqR66uhwaooX3zHXRlVAovMmNZ
	EA/34+a8VYwZWXm8PYC4CaqBlAw8ZrM9jqPfwzE06cI7swF58jKrUuo3EJvYknumRhQxVOY5DotFu
	DqN8+6Q7mDIA4K6cJueGMHXaQD35d6ExpHa1W3t9jDbQ9aGks5WuznsQCwyyYB583gPMcyUAS5NVh
	tXZcKjc+RCKqfnhjMfaH2SoJn/UEBXEqzseTzMA0L/CQaP34WMDh/9ViCVScVtQgyyr4Sny08FXuE
	PLuVOqWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m714C-005mD5-RW; Fri, 23 Jul 2021 19:42:40 +0000
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m714A-005mCM-4Q
 for linux-nvme@lists.infradead.org; Fri, 23 Jul 2021 19:42:39 +0000
Received: by mail-pj1-f49.google.com with SMTP id
 k4-20020a17090a5144b02901731c776526so10440687pjm.4
 for <linux-nvme@lists.infradead.org>; Fri, 23 Jul 2021 12:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MJRb9z9w2T1pw15bznzH8U8+ZElzBg4Yr2imhbXucq8=;
 b=LlB1R5MnlvaYui8eLpdVRLAJOoUq9YnnXuDlm60Z9lP2fxBgECY92dx4krg+mIEsGW
 Uzfi76XJAwFBWqec1kSP4utPxq+xbHo3NxDu38WWUgYAw59uqagZnj1fZmEOJlmZQfmt
 J8FHWXJ9JYxWTVn4MWsSRomHb8F+hrt/UZDyjKr1gAnYlwBtZ1K3a+M/qY4aau8nuo+V
 iI39qgiJoeb5gSZI1NUXEJZD+CJ2gHN+Pg5qTMOEbVU0HhkYZzTWGgQIkry9RZyoxbff
 nNecIG1rO3jz+hOL9hznkjlptAjhD6JAJrB1xpCDl75Kxl7JgA0/p8UwXHAXkT2Xgf8D
 avyQ==
X-Gm-Message-State: AOAM533j+frxet7SVb6uR+OUWMP9n5Au7EdrHgKMJ+cDhCQXKha9u01A
 0XDlgAjcmAUQ6QIVr/b+HG0=
X-Google-Smtp-Source: ABdhPJxEkt7iA0KvLte4vk/r3u5xIJ/HU7v0kmbtay+c6QM7YEXVco4I+0jv3Y20BckYFthHMH32ew==
X-Received: by 2002:a62:584:0:b029:32e:3b57:a1c6 with SMTP id
 126-20020a6205840000b029032e3b57a1c6mr5850811pff.13.1627069356595; 
 Fri, 23 Jul 2021 12:42:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a676:ed9f:319b:a155?
 ([2601:647:4802:9070:a676:ed9f:319b:a155])
 by smtp.gmail.com with ESMTPSA id g13sm34910477pfo.112.2021.07.23.12.42.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jul 2021 12:42:36 -0700 (PDT)
Subject: Re: [PATCH v5 net-next 22/36] net: Add ulp_ddp_pdu_info struct
To: Boris Pismenny <borisp@nvidia.com>, dsahern@gmail.com, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com,
 smalin@marvell.com
Cc: boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, benishay@nvidia.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210722110325.371-23-borisp@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <eaa53cb5-f9ee-1402-b653-662a4c220a8d@grimberg.me>
Date: Fri, 23 Jul 2021 12:42:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210722110325.371-23-borisp@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210723_124238_222443_ABDC4D2A 
X-CRM114-Status: GOOD (  12.68  )
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


> +/**
> + * struct ulp_ddp_pdu_info - pdu info for tcp ddp crc Tx offload.
> + *
> + * @end_seq:	tcp seq of the last byte in the pdu.
> + * @start_seq:	tcp seq of the first byte in the pdu.
> + * @data_len:	pdu data size (in bytes).
> + * @hdr_len:	the size (in bytes) of the pdu header.
> + * @hdr:	pdu header.
> + * @req:	the ulp request for the original pdu.
> + */
> +struct ulp_ddp_pdu_info {
> +	struct list_head list;
> +	u32		end_seq;
> +	u32		start_seq;
> +	u32		data_len;
> +	u32		hdr_len;
> +	void		*hdr;
> +	struct request	*req;

Not sure what ddp does with this, but it shouldn't accept struct
request what-so-ever.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
