Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021FEC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 13:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AivZCskSOYsGt1NOGJ1DcoR6o1h1b6rR2pJbteQkzQg=; b=FZlRyBhCn1ZVl45v6R6TDAaAFy
	znh0UI1joNJA2AUfLV+smREK5YzqHWNkULxA83xK7MYcW3ic/rcSSRamGE+gKahoBrGWt9Ot+enNy
	Bk96jqunejHNd/5ekFohWhX5YEVwdb9wAkmP9KCJJAY5EXlvYlwQJXV6fZB64eF4M0MnHVp/OnfIS
	sbh6wjG0F4AFFnbm02awiM8r+efNqgmHoHm4OrID74DrVZffRXRttxAn12BnliYjWcE5qDyaea1Qy
	XLtceyJPWxJhs3ikU4Bb/bfZYJXfXeB/cGYx7yd/9cxYBRA30A92+IY3OkWjjpY9xu9jW5KcMvLia
	3PQYCtsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olVgH-00FW3R-Nn; Thu, 20 Oct 2022 13:33:53 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olVPT-00FLPP-FI
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 13:16:32 +0000
Received: by mail-wm1-f54.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so2339990wms.0
        for <linux-nvme@lists.infradead.org>; Thu, 20 Oct 2022 06:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AivZCskSOYsGt1NOGJ1DcoR6o1h1b6rR2pJbteQkzQg=;
        b=71aENuH+if+dSE926HY0e3CkmFSr7SYcnJVNzPs7WnBF3Ah+fx7bwBJEkqj6eVQegz
         SkWiC+Rp3fhr4fVNd6yV0T9sGjzNsX7suLagJ3gatBE84IpnPKKvdt+byH1pmVDW5J/j
         YXkxFy+yBliYyyqbbv1no9J7znqtBNAsDfz8SR1EnABa0yO75ydM+NxDScJaYe9Ay2wP
         IuOUV/aNHDFmnuvbv1ktYBfBKCpBbBUkdWQlxcD1pHesOz20GK3fYbEYxlENGgB9v6r9
         U+N61jgztwjDutUASE+NPe/63qg5RStbPBTIXKJIIatynq7iOx+Jd40t6STXvBS8i+Ol
         MUFg==
X-Gm-Message-State: ACrzQf3AUzO8U2827cbT81wixruwlDzjAwm1ktm3580a3iUSF5QSEcWH
	XnunsIpyJYoXXWiqK9iU87E0MDwuF3w=
X-Google-Smtp-Source: AMsMyM4z/2NuduNUmj7tIVaRf8fesahqvdC0oIsxf/e/U2kmrpCbzKikgL+JSQfooAtPwRKlT4hrEg==
X-Received: by 2002:a05:600c:54f2:b0:3c6:bd60:5390 with SMTP id jb18-20020a05600c54f200b003c6bd605390mr29908717wmb.206.1666271788615;
        Thu, 20 Oct 2022 06:16:28 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id ay41-20020a05600c1e2900b003a6a3595edasm2977898wmb.27.2022.10.20.06.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:16:27 -0700 (PDT)
Message-ID: <c540811d-1664-458a-0e97-d77a2a0b3f4b@grimberg.me>
Date: Thu, 20 Oct 2022 16:16:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: per-tagset SRCU struct and quiesce
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020105608.1581940-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_061631_579314_B5C27A55 
X-CRM114-Status: GOOD (  10.79  )
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
> this series moves the SRCU struct used for quiescing to the tag_set
> as the SRCU critical sections for dispatch take about the same time
> on all queues anyway, and then adopts the series from Chao that provides
> tagset-wide quiesce to use that infrastructure.

Looks nice, should be easy enough to modify scsi_host_block() to
use this as well.

