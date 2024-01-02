Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E83C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 12:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jnJY4fKaCjzk1k41TPU4cWkmL5UHk3C7b80RoqFA00Q=; b=t9hwCV2Ztm479v7HQ/p6IOjIh2
	colB1pnY6oL0SMzfPOwh1AhgraOMf0oEzSz4oL5aWK8kY2S0bWWRdVy4Iq149uNabj1726kmfjGL+
	r5D7yTiVOk/UC9owk0FGQFRJCop6BLakkAJJJdlVh5k2vC6/NEooY7Sy0lH+KYgzM4iGUkj1ayHQ8
	e3Eatn1yWDtnrwB/nLxZX/QhQGztzj2JJbpFjfE7hhtcSLz2EbBjnLLJ3GwLQuxU4lmI47OEXfr9y
	+eY9gsH96iwyd1zVI14TQwqKHaxwX1EvE1XJCeN1DL5ikwHTWisfPJUSpUZD7hMv4s/TT1dpxlYKx
	DBUKEenQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKe9w-0081dt-2G;
	Tue, 02 Jan 2024 12:46:16 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKe9t-0081dL-1t
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 12:46:15 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d3da82e29so20073335e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 02 Jan 2024 04:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704199570; x=1704804370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnJY4fKaCjzk1k41TPU4cWkmL5UHk3C7b80RoqFA00Q=;
        b=Pe79+rvlAJSOu7FVBLN4IqXkMBp2ZPHsa67ISJaEcYLxHvtqMw+8Cl5QEJLos1TgSi
         XBJc1naeZRGOa0mH/X8rTb6Xls4EzeSKO+f8CiGP6QU2/9YF2+O5iDzD49CA8RPLGrOf
         0M0dFGJoty2xNllu6YfL/wcVao/lNhdeDAvwAwepybYb1xWQTmfICJTqvfoOTL6SPwDN
         GeIIqskbyZHQkunaEORDompXoe6uQZ4HOT/isn6/zZ5JHV3TvONJFu9aq59MssUynGsg
         ccOnuMJG6I1CYWPf2bt40CQO/0qk4V82y/h5oqMkGINKe9pLmgup2Dwv/HELjAAi8Z77
         RnFQ==
X-Gm-Message-State: AOJu0Yz10Y/bl89FymJswbiJHYY+jj87MoKgCgBZO5cZMmpMv/nEgzeI
	Yesucn6VxGJi8SEF+3iYfMg=
X-Google-Smtp-Source: AGHT+IH2MmAhoNijGbPUoMf1fMjGgmmwYb0lCh+MJ9SpWpzSMPh32IUalvxZ4m2CvbCYA9SxHHROig==
X-Received: by 2002:a05:600c:1ca8:b0:40b:2708:2a52 with SMTP id k40-20020a05600c1ca800b0040b27082a52mr21484296wms.1.1704199570022;
        Tue, 02 Jan 2024 04:46:10 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c138f00b0040d7b340e07sm15052190wmf.45.2024.01.02.04.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 04:46:09 -0800 (PST)
Message-ID: <a688834a-99b1-4dd2-b698-c9e54070f78f@grimberg.me>
Date: Tue, 2 Jan 2024 14:46:07 +0200
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <e27ef3fd-d43c-4dc2-8969-4a0f86d9c64c@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_044613_649106_E4ADC620 
X-CRM114-Status: GOOD (  12.45  )
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

> in function nvmet_subsys_nsid_exists() added in the patch, remove the 
> '\n' from line `if (sprintf(name, "%u\n", nsid) <= 0)`, the patch works 
> exactly as what I expect, fio keeps running and multipath does failover.

OK, can you please check nvme native mpath as well?

What I suspect will happen is that the host will be unable to
failover because it will re-read the ana log page and not find
anything wrong with the actual path, hence will just retry on
the same namespace.

That may be transient because there should be an AEN on the way
to the host to remove the (path'd) namespace altogether.

The status reporting is not consistent with the actual ana state
hence the approach has a semantic problem. perhaps we want another
error that is a path status, but not semantically an ana status.

Can you try returning NVME_SC_CTRL_PATH_ERROR instead of
NVME_SC_ANA_PERSISTENT_LOSS ?

