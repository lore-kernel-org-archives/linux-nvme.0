Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B796C021B8
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Mar 2025 23:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=5A05epTr7noMtGoADP4kjvFic0
	7Cy2ltUZUMNMBz+Judxhvp6tRtPWiAlh7frZgFHJohBnwoFU3DonupPfLqVtymNTCDH5ImNHYjURt
	5KifrgcjSuWckZaPSeLN2r/+R4jOnHHlSRM8FPZ9+l2MmYfwzns4WIlWNjO+NYV20A2MpGZJq/SeP
	zTW+JCXhEVNp3cXFhWMg7doPg904pYJgmNo4ho96C37I/z8H58iNhIG3YSvb+XeY13USPiEy5ShNk
	u11Qw+6oxP0grCgSD6arnmjZF/ldrINMFy2o0GPRaMUb509Mu8vtpJJUCIP3ZFgrTejXksyv+IufB
	wjQ3oWBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1toW46-0000000F452-10ap;
	Sat, 01 Mar 2025 23:16:14 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1toW42-0000000F42m-0oUt
	for linux-nvme@lists.infradead.org;
	Sat, 01 Mar 2025 23:16:13 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390e88caa4dso1370183f8f.1
        for <linux-nvme@lists.infradead.org>; Sat, 01 Mar 2025 15:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740870968; x=1741475768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=IGn3tU/BxGzay8ZfKye7E3yBdoVbGLK3tCk00GIcjZt7dod2fZH5JZxT+X2TKHmMkb
         UxJNAV+4mKZAkYM5qyOqSOeyKpQNGFks9IJYfUmSKJKQCthAS8KOZfzlVwpv3/6tkynx
         uHgDUJGqkzwueR8feQKeke7TdhxXQuwzvr7oT9ql27/ppbzCZku00nXOsW+S4aq64UfI
         8e+b5H4F5bt5auQyWXqxGN2v6BgKyS+vC61fmiZ+sYQ+ZO7KbRAhL0iIQW3gW+A1A0vw
         z+P+R/cibBbi1zrC+zfv7O5zVLxnTgz1A3BckiMxjFzI5oJLMtGF2QTaKht5+tDutUH4
         9sbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW+81vPCOarf9ILE9I3BwRpFHxlYyFbk7+6p7L/HqBTSk3oqX6oet5Wnv/tBdd63alrf7uz4n2qafx@lists.infradead.org
X-Gm-Message-State: AOJu0YxGG+Sb/jgguIj1H06bs9bPtVUbe1gZIzAdzVmTLv5LfA+aVuCj
	3XzSjSxyKtupMnrGxpKIQE9ncn5tK8MSOHGGgJFrSJN8rgtxq9Cg
X-Gm-Gg: ASbGncsghce0G9u46AUdIpGJosHtobov4a+V1YyODjKzNEbXMdkyztw6bD0cHIMq22V
	O5xjFitfSAw4rn/lJpolRtbrxoGvT991np1hvlG4Z8Jhy5iDymEwqwJCsxSulS67quzh4UBa3VG
	4w0/Fe/ovskXAGUVECA/BBfKXSUJaYfWMCCwUPRPERFVYf83UHfsC/FJq+mZDVZof+4WkllY4w2
	yyghHPMUinWk07XIh/wjUeEuhZigugZTQnP9ox917qWTspfi+ns1gi3ch79lG+YbiI1gLphur0E
	cNmkYCFwyzjMl7OjQ2zrOmA9STuq2IOb5yflO+J16KyrJgv57qFw0qC6OQ9bhHRSFuoAp9xnl41
	z+Q2h
X-Google-Smtp-Source: AGHT+IHPLd9+jiab01w985BywzrEuE99VxuwkdCg02g97bwTjyXFL7H2etMm7iPNU0L9KED/95Jb5g==
X-Received: by 2002:a5d:64a6:0:b0:390:e48a:3869 with SMTP id ffacd0b85a97d-390ec7c8e54mr8198941f8f.11.1740870967855;
        Sat, 01 Mar 2025 15:16:07 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47965e8sm9428853f8f.1.2025.03.01.15.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Mar 2025 15:16:07 -0800 (PST)
Message-ID: <ddc3b589-909e-43ea-a02b-7d0b26d730ec@grimberg.me>
Date: Sun, 2 Mar 2025 01:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: fix signedness bug in
 nvme_tcp_init_connection()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250301_151610_295645_63DD589A 
X-CRM114-Status: UNSURE (   6.14  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

