Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDB3C4706F
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fDkTR+M7f8PS8/be8iDMaJh7ylHTLs+4Ib+G3uFDhwA=; b=tafOeoKPzyil8QjhDkGIrL/l9s
	9g5xWai5KnIJowFXh8+cwz33bAOtcDdySiqBHv55tWr/f+lT/UXz/MU10REoM9csybBT3eQ6hLovZ
	oVhc0wGJh9xW367i3HlNeJ8BxCiCS0IUrHWhFcM52KgbMxNWj6BrprNf8TQMvlyIHbS8Q1JXZzSpC
	cpzR33VQipy1gjTpNxvIv3dbUlmvT7f2iLmrGfS6UKcXgyuSdrZ+00WWGI2qmieb4YOPy99fiST8J
	DTHHcSfkg+tPADHpp/OY6IBhYzaqpQb1TNTQnsX3lsdea2VN3KFlaLW7S2jSD23b5dkyy0xJfMri7
	LL56haxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEe5-005pbs-2f;
	Mon, 01 Jan 2024 09:31:41 +0000
Received: from mail-lj1-f175.google.com ([209.85.208.175])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEe3-005pbX-38
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:31:41 +0000
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ccc1a757e5so17254861fa.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704101498; x=1704706298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDkTR+M7f8PS8/be8iDMaJh7ylHTLs+4Ib+G3uFDhwA=;
        b=C+izr6r/iS5Uxf6rhJ48/FBJuPPVrwbUa91PZWFL2xi8f5GniDfTZeGZvUEj6Nlnip
         gA6jY0Y1wG4Dh35/QuqJDD7uTRz2cryAfW0RKSOAwMc4zrbOSbz9XK/8xabFqp15vCXw
         3wj9uELlCJtdmk5qJSnAfyMlvx0kOKLl73kpeD6Wde5QWXOuySkb4lQWleJpbhwzzdpN
         yD3bDt3+Lrj4Mb6qXVjYa5EFmpV19AZclT4pnOZMGm9dQ7XmyBQRCibHuBfOa5lx2u2D
         FFNgcz7x8lp8Mj6adpeXXtgaMi28cbUMyOOsBqb+f+e5mGVCkqtDAJKmOvItylxisF1e
         rq6w==
X-Gm-Message-State: AOJu0YyE+gMKpE21GqiLll2dRs7zoedXMhX0bkqf4WTm80ZHDNHJFbQh
	N8dOjUPFgXkz1XoiTNAzNXc=
X-Google-Smtp-Source: AGHT+IGEJ/KSDAgZxr0jPM5zGHGTvJE7fvxhvnFHJJ10lkN97goymjhOpYemCFdmHOzq2vEnlVOCRw==
X-Received: by 2002:a19:6d1d:0:b0:50e:337b:f316 with SMTP id i29-20020a196d1d000000b0050e337bf316mr11177743lfc.1.1704101497678;
        Mon, 01 Jan 2024 01:31:37 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m12-20020adffe4c000000b0033677aae2e2sm25302409wrs.107.2024.01.01.01.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:31:37 -0800 (PST)
Message-ID: <35b33263-8cc6-4c64-81a5-92be974f5a97@grimberg.me>
Date: Mon, 1 Jan 2024 11:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] nvmet: set maxcmd to be per controller
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-6-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231231005249.18294-6-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_013140_034886_3CE88969 
X-CRM114-Status: UNSURE (   4.49  )
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

OK,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

