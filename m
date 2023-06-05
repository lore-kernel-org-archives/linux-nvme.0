Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25838C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 23:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CCrWbhU4kEcfY652bfVS5L1eCaIUS1TtdSbSuvq6gTo=; b=Nogld/oxfIU2fZ4DnJ6ldJrk/K
	Upupozwle/7KaUQ2NmuctZL1U6gP0MXR/vYCXAzkdu43vVOr/SttWyRzaqlNXYDsr0uJS3DC2obmh
	KnyjbrJ6FrLPukCZ6fH//6Z5lvujZ5oRdLm3RZNuvwISRc70hy3oBB/3qRkjS94gGi3SJ/SB6mmHn
	Ka0j40gJK0US0ml0uCTcNbo5FhjZod8sB1tlVMnSuy3fOoG8vJF452EC7gCvntimBDoZI4yOkopwL
	/l43+PCYdajQJVsLXKAQVOQriu1kpnbCsI9fLuUZXerNzpyGz/l0FzQfXmZkxJTA2efl6YBh5a9VI
	915pG+RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6JG3-00H5uU-2p;
	Mon, 05 Jun 2023 23:05:03 +0000
Received: from mail-lf1-f49.google.com ([209.85.167.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6JG1-00H5sv-38
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 23:05:03 +0000
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f14e14dc00so827606e87.1
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 16:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686006299; x=1688598299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCrWbhU4kEcfY652bfVS5L1eCaIUS1TtdSbSuvq6gTo=;
        b=JQ1xyDHVBngjZUWxO0rlpBq9wF88xFLERHq84S7QuXnwcBJJ5ZUlqChDMSoVcqz3To
         k0FqEyMKJvLd2b18oSk47rfqHU98csqFjINzLYwMJvJHqfJBBNDNRE2Bi4ABFe5+WGZR
         gS+2hKglg6Kh1qULifHTlG9d+5Cz2v2m+pNN3iF7EM0pgcmkXxtEKipo3a/tNzhaHqhU
         DyrTRrHzc5CtmFQ3thfTx/XI6uAcFJpykJaR/n1HZ9uEhK1PmHbtFVHTMmXNLzgL5JlB
         Quv5FkyFrWDoIw0VlIevcTvsmI+DD53ULzcFYN7sS3u6GHqHK2enogOi+y8jEgPRxY8d
         6Izg==
X-Gm-Message-State: AC+VfDyIW+lxjwtEGIDhl+CX8IVRlKzN+KWrKM7xD3kpbjuRJF/2PbIH
	tHGHnGx3wJKtFXWheluFdVo=
X-Google-Smtp-Source: ACHHUZ6asdsWa+E7QgS0377yLsLLAEZv6NA67XW+1AAwmRpliqB/AZG5eZ1cJ51D0mDHSlvWxPDHxQ==
X-Received: by 2002:a05:6512:407:b0:4f6:a2f:beb with SMTP id u7-20020a056512040700b004f60a2f0bebmr148655lfk.5.1686006298631;
        Mon, 05 Jun 2023 16:04:58 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id c27-20020ac2531b000000b004f61a57797fsm985305lfh.60.2023.06.05.16.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 16:04:58 -0700 (PDT)
Message-ID: <fe8be97e-ac6e-50fa-edde-59ac647f01a2@grimberg.me>
Date: Tue, 6 Jun 2023 02:04:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] nvme: improved uring polling
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
 axboe@kernel.dk
Cc: joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20230530172343.3250958-1-kbusch@meta.com>
 <20230530172343.3250958-2-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230530172343.3250958-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_160502_014502_16702690 
X-CRM114-Status: UNSURE (   6.02  )
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

Looks nice,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

I'll look again after the rebase.

