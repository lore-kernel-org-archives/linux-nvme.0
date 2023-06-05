Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF1BC77B73
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 22:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WUwhjyxCO3tovIaq+du0Tw49quCQO0e/7mM2Exe+S5E=; b=gpsl22V6sYtZ6DuPooRPx2wTxz
	R9IYYTN8ZV0VW1U4oJ3d/JxCLFBFqnf5ePksEK7LFGu50EW4B91qCBtIDeC7g8XNi3L4qy4rJx0As
	HQw3cWhF5SGpzzCV5zVrFlh5x0vLJz+A5UklZuuHywgkjMzZWjb7qpduv0aAqk+ZLhy85PR0pMCAh
	IMiZuTcASJwklw4vPWd13zjUMcoKCaxRo2m5/V998qfpvGvDSrMmOboNfn5uCvL7kIvMCDvdmSfdu
	8cqywv4iNr/QX79iAzGTnStIwZp30YhdZqTKZ2iBFKDKVvBU+bioikByNuuW/pf/7y6QN6MuxR9T/
	kbgfsgRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6IHK-00GwqP-2m;
	Mon, 05 Jun 2023 22:02:18 +0000
Received: from mail-lf1-f53.google.com ([209.85.167.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6IHI-00GwpT-15
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 22:02:17 +0000
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4f628cc4a35so302740e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 15:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686002531; x=1688594531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUwhjyxCO3tovIaq+du0Tw49quCQO0e/7mM2Exe+S5E=;
        b=ZGHazI89sBCotvBD1Bg+hXVFHwqrV+5Qwxgl5uvgtuDLNAQatwbWQMOC+gJ/k1hQim
         e+UtRH1QO89lJFyB+i4ORi8b978nFu6BbI1aDfhjxVnasM/fQHWnmWo2Oh7EwakKJ/Fo
         J8WvuuHsPOUId4eIk3TPv02Rn8QzIg7XczSxwoTsLY9nQF5DH5Wa+1xqJM3AtO0jhPY1
         cu9U3PVGXbongR6kJVD6AgTuYP4QKzYU8uh1VVugTtZgNY0Jwd+fhDVQ98iL+AoIVlcP
         a67dvmAmf2ntQ2PqM7UGJKQh5Wm+s3Pf6g92bO2rFH9zm8wTW68gEMPdTuh3pHyyaL0j
         pbMg==
X-Gm-Message-State: AC+VfDxsnJUC8UHFgR/IzGvPNguAPYiXK3T3O8uOqGorYJuqO7UsksQ5
	UQWV2t8VuEwz1ePw+fwr29+5w3la2p0=
X-Google-Smtp-Source: ACHHUZ5uTfN7regQa2lSg7iBN67wNLE5qmC3O1c5vHZpBEFXYdscVpqunillotdrgw1umpBr2HKfGg==
X-Received: by 2002:ac2:4824:0:b0:4f6:2d40:f910 with SMTP id 4-20020ac24824000000b004f62d40f910mr148425lft.0.1686002530711;
        Mon, 05 Jun 2023 15:02:10 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id v18-20020a197412000000b004e95f53adc7sm1241329lfe.27.2023.06.05.15.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 15:02:09 -0700 (PDT)
Message-ID: <a8431996-516d-2da1-2f9e-1931d69e4d4d@grimberg.me>
Date: Tue, 6 Jun 2023 01:02:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3 2/3] nvmet_auth: use common helper for buffer alloc
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, hare@suse.de
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org
References: <20230605091920.34253-1-kch@nvidia.com>
 <20230605091920.34253-3-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230605091920.34253-3-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_150216_372295_68DBEE75 
X-CRM114-Status: GOOD (  12.12  )
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



On 6/5/23 12:19, Chaitanya Kulkarni wrote:
> Add a common helper to factor out buffer allocation in
> nvmet_execute_auth_send() and nvmet_execute_auth_receive() and call it
> from nvmet_auth_common_prep() once we done with the secp/spsp0/spsp1
> check.
> 
> Only functional change in this patch is transfer buffer allocation is
> moved before nvmet_check_transfer_len() and it is freed if when
> nvmet_check_transfer_len() fails. But similar allocation and free is
> used in error unwind path in nvme code and it is not in fast path, so
> it shuold be fine.

This is asking for a future memory leak. It kinda makes sense to
allocate after we run sanity checks on the request...

