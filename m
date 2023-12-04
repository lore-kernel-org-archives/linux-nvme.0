Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DCFC10DC3
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 08:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MElvpz7Uc4iWtinESnprN/ohgQAmWUQXgVtKSo85FuI=; b=QbZyGjOIGM0Of3CTTL0HTCdRIO
	2UgirZZnLQi5QRuyn55++Doozu+V5PGksM/buvAU7kI5Q+lseSohL2XomRftOXdJIRi7YW6nd8lda
	UVNMi7IHxkXs6ZyvhS4XoYo4oIwlJ+I7nQdJxNaydNAdI1X6ZvI2YagFhhBOdFQGtejP+9AU5VAGR
	eYhvZNzXLivwEPDJZnq0uckU1QMaExgYIgOY3bngHoxd+2FUVQq2uiKIVcEPSr6iMrUp8bUs5caiL
	fkSnqSfhW0WI3bGG292lVwvI/bcQ5csWLbiEBBV7Lc1rNj4l6c1VUsEX4RM9JOLcT+kFWVTHbSsmH
	AaNtYO9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA4cE-003KKa-0I;
	Mon, 04 Dec 2023 08:47:46 +0000
Received: from mail-lf1-f51.google.com ([209.85.167.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA4c9-003KJ9-2V
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 08:47:43 +0000
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50bcf41379bso906237e87.1
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 00:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701679658; x=1702284458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MElvpz7Uc4iWtinESnprN/ohgQAmWUQXgVtKSo85FuI=;
        b=cQsON4xQ+7BFGFWfOfBRKjYL6slJ6LdI/WKOgC5RI4Q/ysvoYKI0p/bBn6VYMudyes
         tF7QBYGZUsbv9YSbYnHlGBwFpbPPCYiC+yulLMHRvFj4ecUq5KcC4dZvtLIdNKPuA643
         wIjIVN4nBsFAZEU+QiFqn7j5Mkz7pMq/glrNSUCtf2Wln7QxZ3HxDJ87rqJSTq/TjSBi
         QgP5pKbatFgVkylqdG4O7hZZA8/V+dHCm3sxAJu5034JlYoi4VsF60OPO/e7WXtgQ7g9
         Is3yq1tb/8ox/HbLVZK+0wIfXpf8eEXwM5xnFjtuBwBkUo3wi0+wPucTQdqfcBSowQWd
         d4KA==
X-Gm-Message-State: AOJu0YwMrIl/SNgPkHVc9Q/8imoa/xurzPYUW8+AO8EQUo6Wi5kgYN3s
	2+DxFlw/8VjxssDVa8TgS2s=
X-Google-Smtp-Source: AGHT+IE0j04XP17v22XRj6I7kfIzrR7QKCn6CTu8iem5b57cZSgH81iBFqJiQ1YzXcx+CTsKSM60pQ==
X-Received: by 2002:a05:6512:3193:b0:50b:f157:96b8 with SMTP id i19-20020a056512319300b0050bf15796b8mr1917220lfe.0.1701679658176;
        Mon, 04 Dec 2023 00:47:38 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c471500b0040836519dd9sm14146448wmo.25.2023.12.04.00.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 00:47:37 -0800 (PST)
Message-ID: <b769ab2f-e4dd-47a2-9e20-af9b16c21dff@grimberg.me>
Date: Mon, 4 Dec 2023 10:47:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
Content-Language: en-US
To: Jirong Feng <jirong.feng@easystack.cn>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, peng.xiao@easystack.cn
References: <9b1589fb-6f47-40bb-8aa6-22ae61145de4@easystack.cn>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <9b1589fb-6f47-40bb-8aa6-22ae61145de4@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_004741_957510_238AD114 
X-CRM114-Status: GOOD (  24.12  )
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


> Hi all,
> 
> I have two storage servers, each of which has an NVMe SSD. Recently I'm 
> trying nvmet-tcp with DRBD, steps are:
> 1. Configure DRBD for the two SSDs in two-primary mode, so that each 
> server can accept IO on DRBD device.
> 2. On each server, add the corresponding DRBD device to nvmet subsystem 
> with same device uuid, so that multipath on the host side can group them 
> into one device(My fabric type is tcp).
> 3. On client host, nvme discover & connect the both servers, making sure 
> DM multipath device is generated, and both paths are online.
> 4. Execute fio randread on DM device continuously.
> 5. On the server whose multipath status is active, under nvmet namespace 
> configfs directory, execute "echo 0 > enable" to disable the namespace.
> what I expect is that IO can be automatically retried and switched to 
> the other storage server by multipath, fio goes on. But actually I see 
> an "Operation not supported" error, and fio fails and stops. I've also 
> tried iSCSI target, after I delete mapped lun from acl, fio continues 
> running without any error.
> 
> My kernel version is 4.18.0-147.5.1(rhel 8.1). After checked out the 
> kernel code, I found that:
> 1. On target side, nvmet returns NVME_SC_INVALID_NS to host due to 
> namespace not found.
> 2. On host side, nvme driver translates this error to BLK_STS_NOTSUPP 
> for block layer.
> 3. Multipath calls for function blk_path_error() to decide whether to 
> retry.
> 4. In function blk_path_error(), BLK_STS_NOTSUPP is not considered to be 
> a path error, so it returns false, multipath will not retry.
> I've also checked out the master branch from origin, it's almost the 
> same. In iSCSI target, the process is similar, the only difference is 
> that TCM_NON_EXISTENT_LUN will be translated to BLK_STS_IOERR, which is 
> considered to be a path error in function blk_path_error().
> 
> So my question is as the subject...Is it reasonable to translate 
> NVME_SC_INVALID_NS to BLK_STS_IOERR just like what iSCSI target does? 
> Should multipath failover on this error?

The host issued IO to a non-existing namespace. Semantically it is not
an IO error in the sense that its retryable.

btw, AFAICT TCM_NON_EXISTENT_LUN does return an ILLEGAL_REQUEST however
the host chooses to ignore the particular additional sense specifically.

While I guess similar behavior could be done in nvme, the question is
why is a non-existent namespace failure a retryable error? the namespace
is gone...

Thoughts?

Perhaps what you are seeking is a soft way to disable a namespace based
on your test case?

