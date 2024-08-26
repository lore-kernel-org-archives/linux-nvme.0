Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDC0C5321E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 14:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v2GCfs3HDui4PYQVERIu5xcB7QCmzD3+qDauNlp+3Bk=; b=rz616/zuy6SUXqD9/Y2V2Vn+wm
	4GlzxNhomWT51J8+xmWzBwZ9k+JvQd6Mv+D4/sSGiR8Ic+YjqVXWoaWanRPZhfal+66snx/5xxmIJ
	MC9GVdhW2EPr15BOvI3/WVGJdRuG9cg6iKJg6umY56m7YvU8FbyMTCyHFlNLDCGim7pLpcycrkl5z
	ZmQPIQAscnJeEkb+bSvYVZHT0HD+ynxUxopYzvf0dSQ5aJgFFpNcdhCezFxXWwb/4Vlmk3qU6SvhB
	pHWmXHU+F8fIoSKZJxbe2zEIPpzIBJbLUsPqh7xw/1C0csdAdqwhj0ov/cB/T6j8PafgdlORHX3iB
	dATSpYxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sialP-00000007fNx-0eY5;
	Mon, 26 Aug 2024 14:32:11 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siakt-00000007fFo-0k1m
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 14:32:09 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42ab880b73eso39557965e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 26 Aug 2024 07:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724682697; x=1725287497;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2GCfs3HDui4PYQVERIu5xcB7QCmzD3+qDauNlp+3Bk=;
        b=c7/tlcCbHKVHcZueN7Kh1uyb9fmsNJ7RCUiMCTlNp6bS35GsSNaQfbuFINUGp3HwEt
         hm0kOgTxumWQmsBzCDzxji/zqAjsheRNDElv0yrRc2jmyJNP448zU1+sOyihbryOWaMJ
         UwijbH26EEFJLmN1PMfjLg+VWT9NsPCh3P1iwCRVqat0sYMf3phJUJvKtl+ER85KF73q
         T6koO/y8ujlO0YpHGdwO2jRfVnrQU2AaMt655vmV6P3CJGR8krz3Y1m6vB6OHkkxy1Pc
         t83bvLfdTn2bjv/YRUTopkvqdCH0zVKewf1T6e/r90v37X8xdvPR3+W9Pm3T8zb9pjK3
         ISuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq/WhPRLbiHSR8t3Jkn1TALhnptRk27ye5yWf/9kpTIUhCzYDa8VmOk/z7TF0yniy6cNmnaBPron09@lists.infradead.org
X-Gm-Message-State: AOJu0YxB1bpWQsRm8jWV9E9YJa/AoORLn92f+1hP+vlJoAOw2vmMcVER
	mdRRpziLe9zYRc7rcZ0cTNXX6Cvz8p/MKLAavOYpiqjBTxokFw+w
X-Google-Smtp-Source: AGHT+IGwWJU4siRNX0YeEzOaiJeSa8iugGKAj1G/7bbk5WPmuepUyX10dW34sNAFHxr3msn2mSbsxw==
X-Received: by 2002:a05:600c:4d92:b0:425:7c95:75d0 with SMTP id 5b1f17b1804b1-42b99469226mr9280175e9.18.1724682696676;
        Mon, 26 Aug 2024 07:31:36 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5180123sm156257565e9.44.2024.08.26.07.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 07:31:36 -0700 (PDT)
Message-ID: <29b744da-fb3c-4cfa-999b-8f8f03402387@grimberg.me>
Date: Mon, 26 Aug 2024 17:31:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: core: shorten duration of multipath namespace
 rescan
From: Sagi Grimberg <sagi@grimberg.me>
To: Martin Wilck <martin.wilck@suse.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Niklas Cassel <cassel@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Daniel Wagner <dwagner@suse.de>, Stuart Hayes <stuart.w.hayes@gmail.com>,
 linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>
References: <20240826142241.53601-1-mwilck@suse.com>
 <3d52c916-a152-4f1e-8b44-6c4c1ca34747@grimberg.me>
Content-Language: en-US
In-Reply-To: <3d52c916-a152-4f1e-8b44-6c4c1ca34747@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_073139_232792_880B2D4D 
X-CRM114-Status: UNSURE (   7.46  )
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


> -- 
> blk_mq_freeze_queue_wait(ns->head->disk->queue); if (ret) goto out; 
> ... ... out: blk_mq_unfreeze_queue(ns->head->disk->queue);
>         return ret;
> -- 

Not sure what happened here....

