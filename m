Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6552BC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 16:02:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0064B60FC0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 16:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0064B60FC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=nOsv4PrFAMKrRpLDqTmRhB+ZLSTNO8j/bWwPgkrV4zY=; b=wnfBLIV+daciP9nj2uCuQLw6jt
	g0RaOBV6OW8PC3Jgh6CG3fr0L++8LjrRRuPk1AakVJ/jMvjEz0fwkEQ7P2JziIuBeXS6d8jyzBqzu
	hxGCbx5LZ46WtvZDMfqXp6lXV17dSUC8YEZo9lqccEk9exH51BzjdGMc5efpEebnnXt8V9r4Is7eI
	UhdFP9ZtixOzTwQE6BxZDpJzvKOHinqdWcHL71daCTSPVbsD3jBBeyOMtDeUfMn59U44gNzrpxIrl
	BFXExeINKRroeZjRTcsKYoFpatBefPZwl0jpjKKnXq48E2pK9GB08EXtN6EmhnmvBSr6gLJ7pPcnb
	LTiprDoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUt4g-003IpT-Qc; Mon, 27 Sep 2021 16:01:50 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUt4e-003IoB-NG
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 16:01:49 +0000
Received: by mail-io1-xd31.google.com with SMTP id p80so23374439iod.10
 for <linux-nvme@lists.infradead.org>; Mon, 27 Sep 2021 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zWfRCgwbUCMt3VegiZe9H7fVuP1dOdTHuI0eCNUmEN0=;
 b=QziNJYCuQMNqedzOinM32sdAbqa01glxy7+EzSlsqgBGsBvODyEK11802a0pi5uFiC
 a2LHCgEGfyQPIeS8x7HsHUzkW6fV3WZ+v14ZjUIQTY3H4z5pqOk/GQlzNFygN42VfOCi
 QEX0vRox3xnZ8wGoKeufREp1TTNsRRS+Y3L4WYmJbrCxBQPVIHjUyhwqhYjQhjqWgh3W
 2iFAHheblRcWTomnmyKey9wf8Z1JoBooRmVvQ2g4CAFzrnecsA8KXVK8fg8JuoP5YalY
 msSKiNZtQjrGn2kT9lL6BZhwW3GdH0hP8jZ+f85C7xhWhVL/Ef7vRCxWLG5f+KjqlDWl
 +hsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zWfRCgwbUCMt3VegiZe9H7fVuP1dOdTHuI0eCNUmEN0=;
 b=Z0O2CKhafUGJdqGQbemN+GTV5fiun9P8EyEvQewanPOpyW+bRlMaofXQQhJ8y2WP9p
 PM0c9YwHuqbKak5JgrWUy2Njf7iX5XS+md5xLLeuHGbUVg1sHn03zXQcQuTxSZr8oa0B
 tUgovlCKUWPkjd3YIIOHn5tHwO5nCFykim+bppW0AfCMCxze1ErMY0kQIbynHYcW7Wk8
 tyFZ8sUXpnP7ykOnIlYuoqZRQqWXh8+DKtKhPmRhdcoTIY5TvGG6NUoYOzjmEtP2O1+Q
 Y+UDIRFLBjUKS1E6K8STf7WPtHUruhgauWf6x5sBZQzDbK6KfEfPA9y/nhcBrgctIaLt
 LD5A==
X-Gm-Message-State: AOAM5336R7qBdHU4vsBbOzlmCriVsWN8THABscnc6f1eMLaGqs47slAo
 vKpjFOIgoyu8VfYL+4KpzRswjA==
X-Google-Smtp-Source: ABdhPJwcefBo7p2+Pn59Tw6UOi3NrLcs/OaXxOLZYzH1Zi5emr9WEu/pbmgphL8ZJSpts0+Ytnfntw==
X-Received: by 2002:a5d:9c56:: with SMTP id 22mr376327iof.10.1632758506974;
 Mon, 27 Sep 2021 09:01:46 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id e13sm8898444iod.36.2021.09.27.09.01.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Sep 2021 09:01:46 -0700 (PDT)
Subject: Re: [PATCHv2] nvme: add command id quirk for apple controllers
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me,
 linux-kernel@vger.kernel.org, Sven Peter <sven@svenpeter.dev>,
 Orlando Chamberlain <redecorating@protonmail.com>,
 Aditya Garg <gargaditya08@live.com>
References: <20210927154306.387437-1-kbusch@kernel.org>
 <20210927154812.GA9730@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <31eb3b40-d3e9-d35e-5a3d-1a2199ef2dc5@kernel.dk>
Date: Mon, 27 Sep 2021 10:01:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210927154812.GA9730@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_090148_796830_E2F9E19A 
X-CRM114-Status: GOOD (  12.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/27/21 9:48 AM, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Jens, given that you're on the thread, do you want to pick this up
> directly to reduce the patch queue latency?

Sure, applied.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
