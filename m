Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFEFC07E9D
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 08:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eSdnRiC94As3Uk+3Sg0e/E23gM8uyQ5qblkrsfCLVhk=; b=ZqqnL6LkuMnzy4/PDcdJt0E2d1
	un1ZMd+ZqXCczNjEOesn2YsetCETu7vRKaEUS9Mvz3ZABWyt5nvyhj0zQGw5vYmE3nWnVka8tw97m
	F/hoV02qJtYlLeRboe3Sn8ifkGX5VsVypfbdCqN11qOS9VwECydog3aM0eVnJfItcTnCZXAJFHK1m
	69ZWjnWu918Dg2p9tFgIkeRMRTZxRYK+EJKEnhBpqbsUHgwb2Tqf3MONyKQbVbcGimnKdj6YzkhaA
	OGzNnyGU+4YJ/UQjmsIaJhMVY7hZrNx5Ruho2ySMrNp6Z10/9HWV6SOwrTZ30/TLCGmcZVdBtqm5B
	WxY8PX/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odou2-001pg0-KM; Thu, 29 Sep 2022 08:28:18 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odoty-001pal-IU
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 08:28:16 +0000
Received: by mail-wm1-f49.google.com with SMTP id c192-20020a1c35c9000000b003b51339d350so2753229wma.3
        for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 01:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eSdnRiC94As3Uk+3Sg0e/E23gM8uyQ5qblkrsfCLVhk=;
        b=SDt7cS2+Ph/iAJW7SKcjRK5TpfAPMR89JbRbt32ZHdQ12rtWyF5S4yWBk7qruvBpid
         SZFJBfTi9iS5SsO70A10fbL7yukahxHtKnNH/9PzsASy/36Wf4GkS1GVBY8AuTxLF1Ok
         Hgld2uNYfSP2kVw+FsD+Gadk+4bJcpZcOFTS/1QqMz1HiyNEO0u6JFbrC7yIuhWgTfDA
         fOWrSSR5M5Tp44WEHqdUSuOx3nIWFweoz2XyvFwbAN7Q2gKOoJUN4+LpYd9GD/fHfu+A
         yVFQAvjYlOYZsQRUvzFXHGyd7Qxykki43MSHLqW5nUU6zHPPok4+gh6q1WJtwJNK5BRv
         Zhtw==
X-Gm-Message-State: ACrzQf0CnzhKO9xTC0qPjW6D88flrkTfgADYQeH6eAwCm1E1Xr+wxAB7
	JLQ5fYC7D0YWhedVmqiKMyg1DliAx8A=
X-Google-Smtp-Source: AMsMyM4Tfzvx4yc5ZEniMS2Agx9+W8qqwnPN6FNNZUeMzrGqmGr6uv/M4V6wl9tAskclVHAqgHN7ig==
X-Received: by 2002:a05:600c:b42:b0:3b4:7580:a995 with SMTP id k2-20020a05600c0b4200b003b47580a995mr9913455wmr.30.1664440090326;
        Thu, 29 Sep 2022 01:28:10 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c4e8e00b003b47e75b401sm4149508wmq.37.2022.09.29.01.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 01:28:09 -0700 (PDT)
Message-ID: <c547a241-2a81-d521-6fc1-7cdcad17aa2b@grimberg.me>
Date: Thu, 29 Sep 2022 11:28:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] nvme-multipath: fix possible hang in live ns resize
 with ANA access
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Yogev Cohen <yogev@lightbitslabs.com>
References: <20220929073647.171775-1-sagi@grimberg.me>
In-Reply-To: <20220929073647.171775-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_012814_668286_34FAD93C 
X-CRM114-Status: GOOD (  18.34  )
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



On 9/29/22 10:36, Sagi Grimberg wrote:
> When we revalidate paths as part of ns size change (as of commit
> e7d65803e2bb), it is possible that during the path revalidation, the
> only paths that is IO capable (i.e. optimized/non-optimized) are the
> ones that ns resize was not yet informed to the host, which will cause
> inflight requests to be requeued (as we have available paths but none
> are IO capable). These requests on the requeue list are waiting for
> someone to resubmit them at some point.
> 
> The IO capable paths will eventually notify the ns resize change to the
> host, but there is nothing that will kick the requeue list to resubmit
> the queued requests.
> 
> Fix this by always kicking the requeue list, and if no IO capable path
> exists, these requests will be queued again.
> 
> A typical log that indicates that IOs are requeued:
> --
> nvme nvme1: creating 4 I/O queues.
> nvme nvme1: new ctrl: "testnqn1"
> nvme nvme2: creating 4 I/O queues.
> nvme nvme2: mapped 4/0/0 default/read/poll queues.
> nvme nvme2: new ctrl: NQN "testnqn1", addr 127.0.0.1:8009
> nvme nvme1: rescanning namespaces.
> nvme1n1: detected capacity change from 2097152 to 4194304
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> nvme nvme2: rescanning namespaces.
> --
> 
> Reported-by: Yogev Cohen <yogev@lightbitslabs.com>
> Fixes: e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")

Would be good to add:
Cc: <stable@vger.kernel.org> # v5.15+

Just for clarity.

> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

