Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CFDC54E5D
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 21:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=3jUU/8yKvD+Nosuxk+6Oir+VQy
	gpmpj83PcjzP/vbchAbtpBvL6rUKB7JURVeQirZUbPjeJhQvGjxWo18Zvu0/wbnmFAJPSKnQYG9F6
	1yvIx21w2nf6f4MpUOzt3mB2GMnLCShUszVLUvcLvKx+J/vvzfAFdq1zDodoBGxSKAii1QGWQ4F0a
	LgXdlWPnCU0blUq09lEAqFvmSJBYOtcifv+bLOqpkRov4a7B52oGiA+zldcxTmIbs5Qj4ULh9hyR2
	ZJnsQS0MLNjPB9H/l9p9sXZOKrFQyk+zhc94Vy03vNe+G0rScIhjhMkHSERsYeme0UIRFvJ3H7b/w
	OTeAUiSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk9jT-00000007cEK-3wIb;
	Tue, 12 Mar 2024 21:32:23 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk9jQ-00000007cDf-079S
	for linux-nvme@lists.infradead.org;
	Tue, 12 Mar 2024 21:32:22 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e73f04309so1688468f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 12 Mar 2024 14:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279138; x=1710883938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=bJGCRJl8RlBztXxSGW2HXYhJ5QZ5vFWpYwRvFYTlnZeiDFZeW2wxtR+EuGiXSfE7Rk
         jahQVSBTuGRic2QkxmbwY5PyCMxifZ1lEloy76RLWQsBmu5spUFE7t04Rd8GLZBbitkP
         2W+lMX7E3W2Z79nQIeadSwIgZ5EJRF3J+nl7JuuFtexuCcd4Pk5CQCdeSG/d8AxO3DzU
         Qjh/2+uGL8UQIlpsFR4zd1KD4QD0fIBItRaF7VZKbE2ZJ7AlA+5LNsCiwRFGtGHYajN8
         exFwTO/IxJdX+yUh6iou4fV33lK7YloKPpwCJV9E+alb5NMJvEh/cPJUG7VTcE74Ai9A
         PtLg==
X-Gm-Message-State: AOJu0YykoTMTxOpRN0/qDKF10pJ5mUtphJxZu/7Eud4GbE+NU43Fnru5
	v70j+gCbTCOeeKUWUUI6GUUJ8y9FgrpcTK00KwBFetJV8Knl51eYgdRBHbJj
X-Google-Smtp-Source: AGHT+IEzhTAmyfm38qGjz0lxriyvK8jNl8lMeXKtXOVGK5wY0bVlgCc1xYdkiGW9mXwd5IyBrKkZtw==
X-Received: by 2002:a05:600c:1d1f:b0:413:388f:e609 with SMTP id l31-20020a05600c1d1f00b00413388fe609mr2052354wms.1.1710279138104;
        Tue, 12 Mar 2024 14:32:18 -0700 (PDT)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id fk11-20020a05600c0ccb00b00413e523b7f9sm132574wmb.43.2024.03.12.14.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 14:32:17 -0700 (PDT)
Message-ID: <968e6098-7dc5-49d2-8405-b644ccf8faba@grimberg.me>
Date: Tue, 12 Mar 2024 23:32:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: parse zns command's zsa and zrasf to string
Content-Language: he-IL, en-US
To: Guixin Liu <kanie@linux.alibaba.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <20240312075243.91742-1-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240312075243.91742-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_143220_232320_86D5ED6A 
X-CRM114-Status: UNSURE (   4.94  )
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

