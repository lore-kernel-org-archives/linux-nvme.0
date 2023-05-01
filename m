Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5E2C77B7C
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 13:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=TYzfl5fe7IDu268/UyLXD2MC62
	ClMzjOfzAMhXVGb/QFKeM5k3Je3/rjdSeS5z5XlVN3PjOyqiHx3pA4OaxQUufYDYZsQUB7APHsvHM
	UsP7Kpg5uRtmnxMxugOpD+ih+mPpOToj+iluxSAt6e/Ehb0naljmNVlzcIDioYSwrL/tqG4YK2tXN
	1P6ScpDSZz0oes5+3inpBgRsWXs75f4lic6DbID61UAnr3NP8kNs5Enxe22BRmZ8ilUZ9yE1RSnpV
	40dF5qWkvuqdYzR9mBUBCN4grHPoyszyNtBRmzj3kj2Q13B23DXXzVBxWfuDfLEgzcQ8lleeUR8kT
	o1hYhU2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptTMa-00G3lm-0D;
	Mon, 01 May 2023 13:14:44 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptTMY-00G3kP-0k
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 13:14:43 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f3284dff6cso3780155e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 May 2023 06:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682946878; x=1685538878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=YrCvwQeO7ZFPdMOneRvAWelCg8CHv64HMuMghGNd++JIdloZ0crR2k5R1eNWrkPPyx
         q1lkpAOdnIlOaS3BmY+03GZT6a39dfhhxmkdMcdlkUOrAc0K9OvdhzHFwW+npZBqQPuK
         bQ8DcDvzM4u0n64K52RunlkTBYoEeGmW9KhFhsTPP4nL1f0rHSpvI6KBJo9HoS7/30Ds
         +pz8pOoEp0HidKAMH9HDWj3WQxbpU4upq6Mcjt7OUkh9C0fSHyl51mmbuD5Fer6pX+Mu
         IPOXQm0F/kXGRDO6o7SXlmbdIYsIShbaBcBqUs12n6AMeq79Y17rfsoo+73OJIM3WA1n
         NRKQ==
X-Gm-Message-State: AC+VfDygJkf+yo4+ZxZgqhNS9EtqBY3lTKGc3j9H1eQ6KxuXGYMw/mt2
	T8XrwX2g4yUxE/TFwrQ2VdY=
X-Google-Smtp-Source: ACHHUZ6K+pD7kblcrGfegfduqOSP02gvQ5hq4GccI2IHNaOGZIXL+XSc9r881Q7JI/0Vf53mhbKB8g==
X-Received: by 2002:a05:600c:1c81:b0:3f2:56ae:2177 with SMTP id k1-20020a05600c1c8100b003f256ae2177mr8355933wms.3.1682946877538;
        Mon, 01 May 2023 06:14:37 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b003f1738d0d13sm47548688wmq.1.2023.05.01.06.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 06:14:37 -0700 (PDT)
Message-ID: <cb480a70-25fd-55f6-2776-592301735142@grimberg.me>
Date: Mon, 1 May 2023 16:14:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 3/4] nvme-core: add missing fault-injection cleanup
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de
References: <20230428073115.22987-1-kch@nvidia.com>
 <20230428073115.22987-4-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230428073115.22987-4-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_061442_267856_BD948C4E 
X-CRM114-Status: UNSURE (   6.26  )
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

