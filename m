Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4515C3DA4A
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jul 2024 06:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=2tAhi7YBNGw69OTz1IGVM6QAap
	iqErL8J7Ea2Kqc5Po5zSwbsRFhrEUJ8iI1lEIv/iMwnYFGCAhxO8XmzHflzbbyv9agWhluHkTmYus
	IafkKvOTuiVK97yMhGMp+kpKkaiQkyLhwUS2KpQpKTu9/5YPqGUja33J82XwEXoTnW6owsc4ZKbxo
	r8id8z/TbOn037DlFcamRyJR8tHgTQo+KAc15SS6ofjYCJggdRpwsKaKpPfBfsw/sf8TVBKiLu0yT
	vXdnA1eK73qtFSOkYe49iWsZh8fYV9elxSbp1X0FFaNNQuXPyyQngbcYMBGzfJt3HET6dlT0iYlhz
	202/XKxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYK5A-0000000ACLV-1TEF;
	Mon, 29 Jul 2024 06:42:08 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYK57-0000000ACKq-0cVt
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jul 2024 06:42:06 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280921baa2so1094895e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 28 Jul 2024 23:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722235323; x=1722840123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=b1pjvM5lFF8R6zS39vG80LrnJBbqOYLkoljAMl0Rx03KlsYFmzD0j7+650rZNZEdrB
         rRq42Yv2mJPrGTPFSb7hjMPrs4TiG/hAz4lRINQ/5SxYWdktmd4ftt1fBu5q2UE3tE7P
         3R9fg1vDZPYDrQx/+NcmtaXRv1SYP4v9ScCkP6dPltwnCW0EREw7OK94TQjo+5i7j/9B
         d/wwhZC9d7tBcnXhCf7TaIpdA8xVrR6VbWhONLEP6XxcMUZaW73lDgKDh+oe0PgpH4XP
         PvB91LMtvd5FkSnk8FRbbGk4AIpq08L/kHw9qXgWSyZ+TyjIK998pIanbyJBKpd0uP4p
         eEaA==
X-Gm-Message-State: AOJu0Yw4iJIfphVhVW+XA4SPMZafgrmSDCikvfd5sgI3DYDd0kDUr2qc
	7Tv+mTQhJZKUG2RDeBu5sTvnFnJFK2EUf0XJJloc9jdVsDdH6RX+
X-Google-Smtp-Source: AGHT+IEuWIc0dBVFmlTdRXF12GVMQ45FMeJ4LACtgN885/WJu+V2MTI2KNVvTvomBHaBk7Xi6k5QAQ==
X-Received: by 2002:a05:600c:5113:b0:428:18d9:4654 with SMTP id 5b1f17b1804b1-42818d94831mr18162335e9.6.1722235322971;
        Sun, 28 Jul 2024 23:42:02 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280d37bb88sm109966365e9.38.2024.07.28.23.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 23:42:02 -0700 (PDT)
Message-ID: <9d2bb057-2ce5-455d-a81f-a8209beab539@grimberg.me>
Date: Mon, 29 Jul 2024 09:42:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove unused parameter
To: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <CGME20240729063922epcas5p35577196a5bb929f1fdf60306987d134d@epcas5p3.samsung.com>
 <20240729063133.198682-1-joshi.k@samsung.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240729063133.198682-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240728_234205_216535_144EF3D8 
X-CRM114-Status: UNSURE (   4.19  )
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

