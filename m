Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EC5C7EE23
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 22:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gFAtZwthMSu2xWanXcRBDrLSz6Z7UnhmBtriC0xC+uQ=; b=JqazOIbxenF3m7QJr2nlHkmNMq
	SJ0KWMomR048OFy1PZ3ckF9Omy5aXM0+ydouWObJJJDhVD+wdgoTSNWukc1ETyb0hKjqq7NPS1pR0
	3tQWiHjW5DOvlPK9yQv4LaeRox0nrz3OjCDMK+Wy5InYRVS8hMoAjd0mbeYLiLf+bjQtujQrxwGN6
	W9hFJh2iTVOpWRYtGXOTJgLy1M6O8NPVzpcwMRof/T4vwpyTqhBBZA92757MLxtNQtPvpTS3/wads
	8EUaawwkr5SqFeQSGVJtyhds1RIYU2EHie6hRZ6ChvYKGC2OKcxPr/UcbUJgEPtC0BMcwpmYdB5WP
	qE1ILvBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Ifl-00H0GJ-2a;
	Mon, 05 Jun 2023 22:27:33 +0000
Received: from mail-lj1-f181.google.com ([209.85.208.181])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Ifi-00H0Fl-27
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 22:27:31 +0000
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b1b5d1bbf1so7023201fa.1
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 15:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686004048; x=1688596048;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFAtZwthMSu2xWanXcRBDrLSz6Z7UnhmBtriC0xC+uQ=;
        b=bRWN6Gc9tIhXB2oKjbsE+ETIO/QSX8iEP/zq8Xm0L1QoWPrn+qDMmZD4e+nVsConXH
         jAbOYWmN6TFC+ep53P1VW78L9SwVVddVKSr2tWlFEPXB8uHQ4CkxnS0M96aimaqm/Kip
         mDxKnc1sjCKL5TORo5eJ7+R+Y99d7zL4iC1HQJEetBD74CMV2Z79w4nEFNVfCR2Lz8vo
         ylTq8EBZPNJYli5SivkFes1taFzb6Q7UC81KqQ8bD/8Q/bfsjOt8i5szxAVoXd1D5q0Z
         05bSkzsfcjD5id7GeHMd+6ly7s0EUKNRS3i1dv1LNRTDiIsZmkta10NuxSdtKy+TmJ+C
         JGKA==
X-Gm-Message-State: AC+VfDyXBnJc4ehEZ1NWf1vIZzmUgOEsHS76J5rst5TC9Ri5sk71+yYy
	kr0gsQIYKA7uLrnaA0YGPOWc+jY/K44=
X-Google-Smtp-Source: ACHHUZ6iRG1RS2AsSi2S19ttz6Xd4mwM8C0Qvo2+fQ9EfSkoHffT6rzLbAkYfMKBciDqiaRK4G1XLA==
X-Received: by 2002:a05:651c:381:b0:2b1:c077:8d9 with SMTP id e1-20020a05651c038100b002b1c07708d9mr208598ljp.4.1686004047634;
        Mon, 05 Jun 2023 15:27:27 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id s13-20020a2e81cd000000b002adf8d948dasm1625734ljg.35.2023.06.05.15.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 15:27:27 -0700 (PDT)
Message-ID: <0e6f1020-c426-6fb0-de38-0c3fdbe8507d@grimberg.me>
Date: Tue, 6 Jun 2023 01:27:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3 3/3] nvmet-auth: use correct type for status variable
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, hare@suse.de
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org
References: <20230605091920.34253-1-kch@nvidia.com>
 <20230605091920.34253-4-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230605091920.34253-4-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_152730_693958_FAE5EA23 
X-CRM114-Status: UNSURE (   7.44  )
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



On 6/5/23 12:19, Chaitanya Kulkarni wrote:
> The dhchap_step member of structure nvmet_sq holds the following values:
> 
>          NVME_AUTH_DHCHAP_FAILURE_FAILED                 = 0x01,
>          NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE             = 0x02,
>          NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH        = 0x03,
>          NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE          = 0x04,
>          NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE       = 0x05,
>          NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD      = 0x06,
>          NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE      = 0x07,

No, these are the failure reason codes. You probably meant
NVME_AUTH_DHCHAP_MESSAGE_xxx ?

