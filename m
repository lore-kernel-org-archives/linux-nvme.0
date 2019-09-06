Return-Path: <SRS0=wEPw=XB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D18C00307
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 23:34:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8153B20842
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 23:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eig5FbwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8153B20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=Eig5FbwQNZ5YM0fe97cXuIf3T
	wq8k80KYnPNFO+NYU15/nlbaFIvKajJnnYqJ52cAKNI8q00xN4xjPhSEwFFrNurkgi8/c34H0094N
	ZCzhanUJA4+bhF360tiRyyv3DRdGYQ9t9kw29hx26pCk9phJqSQ5t8eJ+6OQKjNSSTsoddBH7SudB
	5gXvmomM5AINMY7zbfAAscfcGY6PBhahLSm7f+jiBGEUhpfl1KrivxucC1O/0oBsyaN87u3JNSdsU
	Ogwzek/T8Co4DewcYBWk7zq9JKpnymPqBv1w8k4EaTJhyWhwME4h0R7a04IEUz8B2O/1uHvbqsOV5
	wQsLtjnvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i6Nk8-0003ac-Nb; Fri, 06 Sep 2019 23:34:16 +0000
Received: from mail-ot1-f42.google.com ([209.85.210.42])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6Nk5-0003ZM-DW
 for linux-nvme@lists.infradead.org; Fri, 06 Sep 2019 23:34:14 +0000
Received: by mail-ot1-f42.google.com with SMTP id c7so7366018otp.1
 for <linux-nvme@lists.infradead.org>; Fri, 06 Sep 2019 16:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=FkwBPf8lxK2J+QtKMKHj7NP9QXxS8o+TKy1eKagG2iGOTpy+FGIe40J8Zt4gkmnAmX
 WVbAXRUN4Zl/MCbC0TPoBVUuskbBlgbvhxhhhJjOMBazV70S2YtOIvkbdEOgNQip8MGi
 xnOAmJvfHkQJR736Xc/lR7v9WgKNS9tPZgiGAz+m5JoqX7uPZKYVzO8zKXb/mCxCjUZ5
 jxkqs56F2HZF3iKSYlV2s2Zrv7XFsyad8ZGw8ABJLIXAotZBssEYq3fDBYRH77jhFuew
 ASo4l6u9pT/l5w0ZVTJMs+gTG3X5ZC+yE4rLOYKKFmTSb9R6kUi6TN54xBuonOoS9YNZ
 HDpg==
X-Gm-Message-State: APjAAAUnPyefUHKUxDyEnKgzBooc/pdOJRrHoM0cszBKv8BpvuYCHFw3
 wwuf6+0UXWDWYpnNUgFxo6Q=
X-Google-Smtp-Source: APXvYqwRA/sTRBH8LKky6oTfHAe/irKHfMvLqzpzDm+MS/dCPKGb5WaN6a5eWl9hHJ4yxsV/ZxcQyQ==
X-Received: by 2002:a9d:4699:: with SMTP id z25mr9739940ote.134.1567812852711; 
 Fri, 06 Sep 2019 16:34:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id y6sm2570389oiy.45.2019.09.06.16.34.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Sep 2019 16:34:12 -0700 (PDT)
Subject: Re: [PATCH v8 03/13] nvmet: add return value to
 nvmet_add_async_event()
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-4-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c9e321d6-8cb8-523e-f951-20a951bb6eed@grimberg.me>
Date: Fri, 6 Sep 2019 16:34:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-4-logang@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190906_163413_452143_65040F2B 
X-CRM114-Status: UNSURE (   9.59  )
X-CRM114-Notice: Please train this message.
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
