Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B1CCA0EC3
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 11:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=4aVr5/3TNQ1E3OOqa+sDh56bh9
	o4VhvLgqwa6Vga82hhdR4yJt40mUkNp8bJnsveoovyryhcZns0A2cCdr/qf5hyeQEUqNZhh0vbfCY
	KFscM/Yy+CQUDcW0Id4JCfsSozOsAfj54ovVnZx5KtdLiww2/M2j0k4M18UMYTyMCoq5se6r7855W
	6puJTO1RkdgkLTOL7JbsHwxFHAoHYj02gKFJcJ5Q36BjF2+wqP/GSC49xaFcfqC/H4Rm/lkp2mwn9
	2bbYigJ0dB5PF7viA5iBiD9Gx0wENm2s5lmPv72wjcpjbcUWUpLdiGIUd8gyTrIsUMI7VSodkRiY1
	5oN2GJwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1kD-003EWZ-17;
	Tue, 12 Sep 2023 11:39:49 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1kA-003EWB-2j
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 11:39:47 +0000
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-52e5216024aso1105859a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 04:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694518785; x=1695123585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=vSZ6qRq2dexK3adgkIv8lbuOiuS4VXtShyxvJs60Dm0MR+rkgXKDATwdPUY32p7KA0
         0aDW022uBIQYNiIx5qN90jsq1vULBiA6Rhdn3CbRRxD5HVYOp/jOpAUF/qrNM5kKIuKb
         ypCCoj31Kpycl7S19vbAl5F3KTy8QnvKZ/wYofhPADLOTn6TcDhM1ARZCMAR/eh46Okf
         vns2WfVgi0DpkzfqIg/t8H5ErDrDGUyd1MIKcNMOlZplPK52mhPahYM1br4e6y/Ae3Jr
         +2KeiwprOyAydgwn7m8oXOhi1TeLm9j/b0EreLB1BLniOtOkAr4MklhxmY5BM/0++JPi
         qMyQ==
X-Gm-Message-State: AOJu0YyNkKBGzYsLpxVOO53VYKiuMCzO/VEIbUteBFlahF3Wpflrd9R5
	cZAuS/jdmqA0kWekF1lbpes=
X-Google-Smtp-Source: AGHT+IEt2gg+b0ELHrfLwF+UqY3w6g8ygIor5V06Lb7l0uqzIgKCfa/gXJ6u+YPzsZSKLSIj52eXrg==
X-Received: by 2002:a05:6402:42c5:b0:51e:34d8:f4c7 with SMTP id i5-20020a05640242c500b0051e34d8f4c7mr10382428edc.2.1694518784813;
        Tue, 12 Sep 2023 04:39:44 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x14-20020aa7dace000000b005257da6be23sm5843018eds.75.2023.09.12.04.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 04:39:44 -0700 (PDT)
Message-ID: <8a47c824-ac32-6fa5-4898-892cb6fe6f3d@grimberg.me>
Date: Tue, 12 Sep 2023 14:39:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] nvme-tcp: auth success1 msg always includes resp
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
 kbusch@kernel.org, hare@suse.de
References: <20230828212033.3244512-1-shiftee@posteo.net>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230828212033.3244512-1-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_043946_880294_23DFCE6A 
X-CRM114-Status: UNSURE (   6.59  )
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

