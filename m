Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8FAC4321E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 08:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AkKaxW1KlJzUB9pGl7s3Soy7R6l0ag21MOUW+xjaOeU=; b=1KPdPK1v6AjBJhnE6jlDkZNrtW
	uExTHxeApfRII2GO/QJPJKLdFYaceT+YupCgSUHFwZA6Rysrst3AuZak1NQelomYSP1jYxc3OQLip
	Nl8TBgpP+LgNlla6bBelRQd28h8nH3QtcecUln7eLRZ0aWc3KXYnvXi3yNmrWTOxaSGNeKQQcZtGP
	xYl4xPDAvRVWT0dRMCh5aORHIrUcAGv1+IqLYQl5aipe37LmST2vikpYVzblBg55q66AYTFsJgLJa
	PdxEFdPxzsRyhRUYrblUs7PsnQizPHKmvP0p2usz/oPk/Z3k2YpoBY+why/QyyW8qMRKKT1dn7Url
	cEHdJPGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0IeF-00Edh8-3Y; Wed, 30 Nov 2022 08:40:55 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0Ie6-00Edcc-1R
	for linux-nvme@lists.infradead.org; Wed, 30 Nov 2022 08:40:47 +0000
Received: by mail-wr1-f47.google.com with SMTP id g12so25873247wrs.10
        for <linux-nvme@lists.infradead.org>; Wed, 30 Nov 2022 00:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkKaxW1KlJzUB9pGl7s3Soy7R6l0ag21MOUW+xjaOeU=;
        b=3Fo0x5MDlLPpvCemu8r0xPEG4PLzN8PTR3IOnkojPuq0auQRsNS3i7sdzUKfm317+T
         Jl23giMGsKkviY2oPbmKK7J6v0eiVvdcgfAg9zlHAmtnIfHyNyoNg+kCIOhVEqwM8HB9
         axObz7oYqR+h1qaNYsNL+1TMzNRIzJFbqOJs9jP4sB10CRIPIOrV0XFRdN0gEUeWDVqg
         FKedjnTfLltfj/Ti3DdGiD5GvrfsGxdj8sfmhcG+45m7Hc249SyjGpgtVUlh/bbam52l
         Hgc+mrkoxiUQn8La2xfHdl/61T88/vdnEvXXaeSdt8uO4pvsrs/52onNNBQLboUvi1uL
         8WaA==
X-Gm-Message-State: ANoB5pkCch+gKcYl4HSszbmJY0qCzS40XPelZxT98HyHPxMNaDYSzVEg
	VVmVIgprd/XzmZSLNpM5KAcZ2mKEjiE=
X-Google-Smtp-Source: AA0mqf5VnJQVhuORFsnN+a3lowz2JwgApuNkoPwNPRBwiidS+lLinr3FzpepdPVpIhTGuOPNrhzFTg==
X-Received: by 2002:a5d:540b:0:b0:241:e5b3:76b3 with SMTP id g11-20020a5d540b000000b00241e5b376b3mr23072602wrv.444.1669797643185;
        Wed, 30 Nov 2022 00:40:43 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p15-20020a5d638f000000b0024207478de3sm805917wru.93.2022.11.30.00.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 00:40:42 -0800 (PST)
Message-ID: <3ac2968f-c640-815c-a7cb-fd6a8fe0cffb@grimberg.me>
Date: Wed, 30 Nov 2022 10:40:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme: fix (S)RCU protection of nvme_ns_head list
 (alternate)
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Caleb Sander <csander@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org,
 Uday Shankar <ushankar@purestorage.com>
References: <20221118232756.1457075-1-csander@purestorage.com>
 <20221124002432.3715594-1-csander@purestorage.com>
 <20221129083905.GA25314@lst.de>
 <c3f8ebd7-8da5-a29f-bbc6-f4f893f7ef60@grimberg.me>
 <20221130083514.GA15442@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221130083514.GA15442@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_004046_428689_1464154A 
X-CRM114-Status: GOOD (  14.34  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> I understand what you mean in general, but in this particular case
>> I don't understand what is not working.
> 
> How does this work?

Particularly, the sleeping contexts are guaranteed not to dereference
this NS after the two previous srcu synchronization steps so at this
point, the only protection of nvme_ns_remove is against this
non-sleepable traversal, which should be enough to protect with rcu.

>> But, if this is too confusing we can make everything srcu protected
>> and be done with it.
> 
> To me the original patch looks like correct and reasonable, so I'd
> prefer to go with that.  We can then look into optimizing the
> SRCU usage later if needed.

That is fine with me.

