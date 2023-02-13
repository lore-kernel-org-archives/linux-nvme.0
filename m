Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06701C636CC
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+g1fnTaz39tma9VeGMhx8CBso1U4t3Zw5x48hvl40Dg=; b=x2ps6k3YbQzPhFMr5dQj5RZJaB
	38vPbDlXyytkAcbOghKwdTmArLa9zkMRRCoR5P1tvdq68eTUNfrIUz1dWuHZyv5RmKWuMNPdw5DFy
	H8oBZrNqnyg/31MDOpQu5gtEwDZaxXdmuhxsBIGh++4t5+yd+3z23I6ScU6X5oYi8QwDioHXF7Rr8
	DvUrLJyB9EVDeoFb1OH+D4/wosIgM2D8AX0/CQReCn7s4hWc9DAmhJsNx6aoJZ79BNAlcZJbJ/+jB
	X4F6vxeBRLTvgNjtxEm3+H68oVnyUxI/sD6o6ei0HbWb6SpQsBSWahnqFe0Pg0dyhczQgMy8a0i6x
	5sxgyVYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRarw-00FEWP-7n; Mon, 13 Feb 2023 15:35:52 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRarr-00FEVP-V1
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 15:35:49 +0000
Received: by mail-io1-xd2a.google.com with SMTP id o1so4573343ioo.10
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 07:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+g1fnTaz39tma9VeGMhx8CBso1U4t3Zw5x48hvl40Dg=;
        b=1vZ0IX4uJQD+lGU7FV+iAb0up57WV1rNkznnl1wvbgdtoCNOpW1NBweBVyFkV2Jtna
         MsDHSLBDIzhNdvs3O8gqiMGCSWSfaQdG/DG4rcrsjNvv1sh4rmlMIcq3U80XnI0qpvSU
         uFIRGk8WWRxlL2WBoM5L6mTtCFPdfymzpjhqfklzDT/lO5MzjkrBK6QcAVa8PgUBcOBY
         axyRSWR/iBTMYy9ymIxCGK7ObIhvkrYQqEoCiHefpS9jWm8xHog0pi32XdmkVBoXikDH
         AiTEWm6tpItAh+Z8UELfFbRzGiKp448vPAzyP+n7gAQTGynTCbtmzlSc3tLp5gFglZ6V
         2aDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+g1fnTaz39tma9VeGMhx8CBso1U4t3Zw5x48hvl40Dg=;
        b=d1rBNfNL2uDlLcktXSRW14bCGUD/de+1NwQOn4wMD59RBKd+MB8lIp1JwcwxDKDYxo
         Z6LSBYvK7PXqm2JsW1pU0tD7Qdsa94/fPXGSn79OIErKEPbni6SJpMOFXNAqscxY5q2z
         +GlT26NWBBvea0oRQBg/+wP0koELlycdGXNyHflUQDvzaaOzeJrodGE2NlFOdwgTQsbL
         gpRV1kqREsxOuZouBCaycieuSdIAgQR6MjqvvtUUaNiX+XmUsGU6yNDBGTRrloA+qnDh
         lXTW88oWsueR0MJYVgT8zg5vlkC71dm4qxMrMTn+L6uev3vovf+fWe3qbKuXWUcMwL3J
         8yLg==
X-Gm-Message-State: AO0yUKU39m5c4t8c6NW/iDaFKRwkZmTxjiEJ9A5OuQKKBFHcnIzXvobI
	wWTQi3WLn4+5B9bxZDeuE7BKiYsB0pREaLdN
X-Google-Smtp-Source: AK7set9bFZZGZQZjXu4gP745z6z0ZMJHorhLrZscw2dWjs39E8oOLnVdvjRa1rG1LnKXCu7LWdTqrg==
X-Received: by 2002:a6b:ed05:0:b0:716:8f6a:f480 with SMTP id n5-20020a6bed05000000b007168f6af480mr18296844iog.0.1676302545887;
        Mon, 13 Feb 2023 07:35:45 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h16-20020a02cd30000000b003adb75f4aa6sm4086004jaq.108.2023.02.13.07.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 07:35:45 -0800 (PST)
Message-ID: <38396b5b-c12f-cb69-dc80-5ed42d5bcd19@kernel.dk>
Date: Mon, 13 Feb 2023 08:35:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] nvme-pci: set the DMA mask earlier
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, kbusch@kernel.org
Cc: mikelley@microsoft.com, linux-nvme@lists.infradead.org
References: <20230213072035.288225-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230213072035.288225-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_073548_231226_7DD4E15E 
X-CRM114-Status: UNSURE (   9.26  )
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

On 2/13/23 12:20 AM, Christoph Hellwig wrote:
> Set the DMA mask before calling dma_addressing_limited, which depends on it.
> 
> Note that this stop checking the return value of dma_set_mask_and_coherent
> as this function can only fail for masks < 32-bit.

Looks good:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



