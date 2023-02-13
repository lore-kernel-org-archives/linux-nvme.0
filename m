Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91712C64EC4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 10:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=FA4PY8zMTZFxOCbCVkzTuuiASW
	s0E4HMDZZzWBVHELx1oo/kMAuO30gQeUFJYReKa5ry31isF3l/cJO8P7IBdsD+3I6Xkfnq7nkqmtV
	QLoKWaRcu7sHofCNVJQXOpKfcsHnSwvVG3qxGnthTkEfQjGtA0rLLkg3dzKmVTIb4I5XO+OCHCBUs
	QTYK9hnnjh14wAb1s2aPAf2ucJl2ynFEc7PyQ+edgKWMw60J+JCr5QVTU9foTTWZ8BzJAeGECKdyv
	sqeAFBPx9sny/0bQPb/qV+jVc1ZQ27Lrg0PaeR9g5o0CrZYzKFpkTnYIKhAiVnWr+LFFBEqJNPyNP
	fUpjGYWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVsS-00E4Ip-7A; Mon, 13 Feb 2023 10:16:04 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVsP-00E4Gv-BJ
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 10:16:02 +0000
Received: by mail-wm1-f54.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so10878422wma.1
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 02:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=uQLqpzkrAg4/jS7c+A6y7fSyALzezrYcN2mhHmgQ6s+oRTLXsTaVnGCpeOmFdKfNTA
         wJJjPJa5NFjTAxvyskvG5UaSHqMJJ5u8JzXTEKs1vt4Hy2AI2qoejzSSqxwja386I5/1
         1mEeHTISCjGp1uJrPabeXxVvwwhXg3GK+2UQ8Ohp/vBJPCNnpiBiYerFptWFe2zNmS4i
         rtX2Ao1VEibNRVk1s2kRzgGQE5xw9cRqGTcHsf1wUAWpsgjZoaiXyDlrC8VrsNDtsbtu
         esrSuzlTJ9wiad4q7a2pwNjqBoi4vkHuZjbvay2/sUZ6SpRqsC+9nJq5wZC58Z0CRdf0
         8zCg==
X-Gm-Message-State: AO0yUKUqcNHouUElCSBBJ7VOlWjgqYeHUN/2lFtTNowGYoochHn2KnC0
	xGjeDS7Ik1N4A1278B39DSo=
X-Google-Smtp-Source: AK7set+nFSp70rG8TwMbIDKb1Igog4toLEhuY2SS7bYxuHvMEd6Y37TrniMmv27SLYE1UTvgaD+sTA==
X-Received: by 2002:a05:600c:5127:b0:3dc:5b88:e706 with SMTP id o39-20020a05600c512700b003dc5b88e706mr22741945wms.1.1676283358755;
        Mon, 13 Feb 2023 02:15:58 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h2-20020a05600c350200b003dc434b39c7sm22731675wmq.0.2023.02.13.02.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:15:58 -0800 (PST)
Message-ID: <ffdc6552-4a31-236a-52cd-eefcf677ea88@grimberg.me>
Date: Mon, 13 Feb 2023 12:15:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/4] nvme-pci: remove SGL segment descriptors
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20230105202833.3225645-1-kbusch@meta.com>
 <20230105202833.3225645-2-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230105202833.3225645-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_021601_539336_17ED9B0E 
X-CRM114-Status: UNSURE (   5.83  )
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

