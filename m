Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB31C4706F
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=i4asMJxvNjzdwqmjrhk66l1ywH
	nxe6yFOdN3XPqG0EkxmWA5dtRgK3heJspYZiNyBtZ+FfW1DE/DLkBGsUOnpVbTiaie9F8Ke45Nsbd
	E0VeIAZbb8dFmD/Xc80tjZNrbeGd7fNsTHC+QE4opPVNZpoRVt+ls2XRLViMMamGWIuOprcarLqcn
	3zFZyFfKx6iqRXf5kN+yMLxi/nnh//Yssve/+/uIfja6FnvFBRUNm19pA39b+QjnT9/ZYTRaUo17D
	ooT9yjTwlRnzWZLRCpOJ5Dbiq1Ssv2RlLA6LFtta7sNR4ew9Fp5Fd/e3ayxORD76MhecvtEJhlbSn
	zeSOnzwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEWd-005ojV-1T;
	Mon, 01 Jan 2024 09:23:59 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEWa-005oiu-39
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:23:58 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d5a733823so2486615e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:23:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704101035; x=1704705835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=H/S92hla3aUTAU4kftwFZ9r/bt81dGLfqFioX47HpcRSPcmhp2oH683NkPXHj17KC3
         FoXOesq4na82RIrMJ4o4IxIv4R4NGfYMCusWsmuKRgZJcUs3x7aou8sdazsEiTJohMpN
         ysQ9eoBUtM+0ec7t4qEV30xvYjltvl/ub96CEFUtUCMthLTnCc277UyjFg2PpYwU380y
         xa8yprzoPD/BGbQIKrya4bf50iE8omm/5sm0fomxBkXoTvmh9z5ce60MBnSkCLl7c0f6
         DAT/YHv0XlGfhEtbQ0995jDEy39HLQskA9wbHdiLFMxcm3yLdmJLA5mQZ9JNtFkCcw36
         wTGA==
X-Gm-Message-State: AOJu0Yw46YIYV70rikQoFwjH06EwP1UJrPgLZ1dE/nUeDQdI1Sbz49xP
	smYvTxT2KPZ7YMTGxKfhr0c=
X-Google-Smtp-Source: AGHT+IFRCh2+CokcSgsVzTMvP7CPqYWVgqrUTPvOst4+km0IJe4p77O2K8H6Fel3jia4+4PonvJhAA==
X-Received: by 2002:a05:600c:3c83:b0:40d:6b4f:b433 with SMTP id bg3-20020a05600c3c8300b0040d6b4fb433mr7159988wmb.1.1704101035009;
        Mon, 01 Jan 2024 01:23:55 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m17-20020adffe51000000b003364a0e6983sm25316648wrs.62.2024.01.01.01.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:23:54 -0800 (PST)
Message-ID: <651e0b5d-e452-41df-89ea-8352c909cab5@grimberg.me>
Date: Mon, 1 Jan 2024 11:23:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: tcp: remove unnecessary goto statement
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, hare@suse.com
Cc: linux-nvme@lists.infradead.org
References: <20231231065644.23319-1-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231231065644.23319-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_012357_014047_90EA478F 
X-CRM114-Status: UNSURE (   4.73  )
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

