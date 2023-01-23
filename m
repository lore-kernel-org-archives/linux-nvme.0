Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B767EC05027
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 09:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=XqYUElOYGgbuhnPdsGb8VWMpmo
	LukN69iTBUzmg2xylDh+pZQO5Re7N/e1Xq6dEDPYUEITTiVPaneMX2FI6fBdVFooCjFTRDM8Zyb4h
	oLTyDYznm+2p1AfFOhJU5E/N7YIofQKJ5sRXs3SM5KBTBasn7dLSQxzIobbPAczoXv2SYjm8u+9Fu
	RmGqnJfTDWUoQFIJfYa6yRQXiCwwTBfWxj0M/fIE8ujHBpofHS9X5JzETOdxXHNQjF8BR7j2zaLaq
	XZYB0OqCBfHRdqP8NYa59RFsY7OH/QnoTMwF5/cQvODKDSLaeTtUvMT7rzh7wUGCM04f0sDkxrPe2
	iwC479sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJsjP-00GS0U-VQ; Mon, 23 Jan 2023 09:03:11 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJsjM-00GRzU-1P
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 09:03:09 +0000
Received: by mail-wm1-f49.google.com with SMTP id m15so8408219wms.4
        for <linux-nvme@lists.infradead.org>; Mon, 23 Jan 2023 01:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=wl1CZKxBvgYRYP7DQLAVTPk0nki4Jqp1nf8gBq/zq5sF8yPFRAmwPlGIJhEDHdJOL6
         mXaqXxYzn+RZN7cVJtCPe8O8q6SJW+5QJ/j9yQWAB3d42IVHqCRGzY9hgx6y+HmcZiFo
         bhny4cUWgPCjhYfQUkLutTYlzALj5v9rgeqcQelIXWrrLLhtuBjDw9uV964Xr3/Sq6SE
         OxmWfGRJW5Mwvum1qGjwYVJQJM1DTePfybRQ0u6PS4tXUNPbaKZcoOORlXAEDtjU3g9e
         pP0qBlMi6zUCD1/Ffm9seAJRPve3DZtmdxV9lDjsA2TroNl3CCve2ZyE5l1+rww8GS8G
         bUqQ==
X-Gm-Message-State: AFqh2krtrhyJWN/ozgsvRy5UN1Ddmb0ubgyB7UWRfB+Vlemz0C2N9bVM
	CzvURt7USR6/YRs+HCJsKUY=
X-Google-Smtp-Source: AMrXdXsC2gxrl8nCHZ8YAXIhM6twqbkCXidwTlf7ILw/kpYTXObfXpABV2nH2pjdrHWpm2OBzXQeDw==
X-Received: by 2002:a05:600c:3489:b0:3db:693:3fc9 with SMTP id a9-20020a05600c348900b003db06933fc9mr22113764wmq.27.1674464583988;
        Mon, 23 Jan 2023 01:03:03 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k3-20020a5d6e83000000b00289bdda07b7sm3933843wrz.92.2023.01.23.01.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:03:01 -0800 (PST)
Message-ID: <c5ea61d2-a440-4c86-33ba-c2ae9eacb52f@grimberg.me>
Date: Mon, 23 Jan 2023 11:03:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme: mask CSE effects for security receive
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
References: <20230120171731.652371-1-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230120171731.652371-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_010308_122581_A37288D1 
X-CRM114-Status: UNSURE (   5.54  )
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

