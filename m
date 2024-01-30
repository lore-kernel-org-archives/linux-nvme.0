Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C736EC46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 11:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+HQwhmS5jJKxe/sJjKPG7dInrz3FcsVYSYuj4M+CGSk=; b=s4SpOoHswAdHuXh4YwOVSoSM0b
	otV+DKfVNDv6VClASvl2xW4fshNziDMoo19IqbtoA8eCLzP7id79U7d84AQq6Ssfr5CTfL8LHv+KO
	JLPW7e1NNlJnrpwefYKqs7mANaUGxmquWt2dqkFvrICbXYWZTkEfS97ux9oWUgmnFxrljIFmYScam
	swe0aQLJHwvaElD+lqfSJ9qjQZ8CQUdT3GagDG+HfflMNuNrNd/qAtTCQK0Ev7Hh+aLM2FQAd85u2
	NNe0suGfvPHtzQDc1MDzSyjvzAEiLdEHorp1ZK3HeWr24R+/CAYxpBlP6x8INE201QEZ561zbQs6o
	sYIOB+Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmJ9-0000000GRVA-2pGU;
	Tue, 30 Jan 2024 11:29:39 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmJ7-0000000GRU9-2edU
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 11:29:38 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40f02c1b832so296545e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 30 Jan 2024 03:29:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706614175; x=1707218975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HQwhmS5jJKxe/sJjKPG7dInrz3FcsVYSYuj4M+CGSk=;
        b=IaNh0wIIbPXxYrcArMcHUyzBtLtPm1tYiODrBJn4B2forUPc752ztOuJ+mvOQEi7fR
         14CSSVIQcUcgL55gzGpbHtR3j/FVVxl8saPUJ/9/VXF6i/2p9feAOPuKzgUIhHuusFDS
         xcainqvn2jxByivqGJD8jX4LjtVcf3KfE6Vx4j86dC7WgpoF/8SMB5aTg6RTTVkPfPIP
         bwt2QTnPlNXtShSS+hk/sAUmCdu2XvwVRAHmPol/6skvFYMXfUKlBTSOcqYl3jShXFhR
         F+d8ueO6wFq4U0umKStzdPasSdhyMd/yGaRaO27d/dvRn2ojqOrsm6CV93KI7Ux7qCdq
         ewrg==
X-Forwarded-Encrypted: i=0; AJvYcCX65kEUgy/aZbG2ij7KmJEoKugigychGYyYX288ZmLKZM7ICxNO6DmAz8Y2zf2KNJlT7G4edbA+sBuqfoLcvTsdoSz3V4H102CHS9GLXY4=
X-Gm-Message-State: AOJu0Yw0ZzrGbdUhhdAWKBc6rnopgDmyhEGUjJSqG9/Gi6jYd+F7voiF
	GcBQgaRhTy0id03Ph3yZu2zR9qlgMtYZ+w037V+s7IJ6Q8I4Grl/
X-Google-Smtp-Source: AGHT+IGZpCmliOwYFhbXI8Q/UbKW8JkXrQU5FrNC5KOuz6EsqQwEOeWTOXmyKaX+52ZNWzgmN8mPpQ==
X-Received: by 2002:a05:600c:1da3:b0:40f:afd5:2b7f with SMTP id p35-20020a05600c1da300b0040fafd52b7fmr162218wms.1.1706614174515;
        Tue, 30 Jan 2024 03:29:34 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c4ec700b0040e5945307esm12887322wmq.40.2024.01.30.03.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 03:29:34 -0800 (PST)
Message-ID: <b3821176-b6f6-4617-92c9-ce8ad9f1118e@grimberg.me>
Date: Tue, 30 Jan 2024 13:29:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
Content-Language: en-US
To: Jirong Feng <jirong.feng@easystack.cn>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org,
 peng.xiao@easystack.cn
References: <9b1589fb-6f47-40bb-8aa6-22ae61145de4@easystack.cn>
 <ZW6pJAm9wgqj1HEW@kbusch-mbp> <20231205044035.GA28685@lst.de>
 <08f2c221-cca7-4d34-ab78-157d4eae4f68@grimberg.me>
 <945fa17c-f1d0-4928-972b-da29ca5c95ec@easystack.cn>
 <a99971dc-9157-4a0f-8fb7-5fa495434b99@grimberg.me>
 <b8cd8de7-9167-4b8f-b255-c022376a7c9d@easystack.cn>
 <dda859d1-41f5-423c-a9e2-900a1573c3a9@easystack.cn>
 <ae40ced9-9f30-4e93-813c-5b94d0667d66@grimberg.me>
 <e27ef3fd-d43c-4dc2-8969-4a0f86d9c64c@easystack.cn>
 <a688834a-99b1-4dd2-b698-c9e54070f78f@grimberg.me>
 <89b542d3-dedb-4d5c-ad7a-279467d28e51@easystack.cn>
 <53b68337-8370-4deb-9a90-bf5dbb7d6d33@grimberg.me>
 <6b345b99-3dd3-4c96-8644-e9b40d387b58@easystack.cn>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <6b345b99-3dd3-4c96-8644-e9b40d387b58@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_032937_712775_96AF6921 
X-CRM114-Status: GOOD (  17.05  )
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


> Now I suspect that my testcase is inappropriate for nvme native multipath.
> according to the base spec, chapter 2.4.1, nvme native multipath aims at
> accessing a certain namespace through multiple paths, not how to group
> different namespaces into one device. Therefore, in fabrics' case, a
> namespace must belong to one subsystem on a single target server.

Nothing restricts a subsystem to a single server.

You can expose the same subsystem from two different servers afair (as
well as the same nsid uuid, ana groups etc).

> Looking at
> the latest code of nvme driver host, the host does refuse those namespaces
> reporting the same uuid on two different subsystems(in function
> nvme_global_check_duplicate_ids), which is exactly what I'm doing. The
> testcase seems to be a misuse of nvme native multipath.

multipathing scope is within a subsystem as far as linux is concerned.

> However, the testcase is pretty reasonable for dm-mpath. In a cloud 
> scenario,
> we usually need a volume to be synced and exposed on multiple target 
> servers
> for high availability reason. dm-mpath can do that, only if we choose 
> group by
> serial. Namespaces from different subsystems reporting different uuid, but
> with same serial, can be recognized as one device by dm-mpath.
> 
> The only problem seems just to be the returning code for dm-mpath to
> failover. native mpath should not encounter this case.
> 
> please correct me if I'm wrong :)

As mentioned, afair (Hannes can correct me if I'm wrong) you can
make an nvmet subsystem span more than 1 server assuming that the
backend device is consistent (i.e. using drbd). The only thing that
you need to pay attention is that the cntlid range is not overlapping
in each of the servers that expose the nvmet subsystem (cntlid_min/max
configfs attributes).

