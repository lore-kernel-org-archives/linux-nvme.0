Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9D9C47DB3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 20:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=cqrodqrtchw5IZMBZZ/A9lNPjk
	NIEeP9vItre4Ar+guNaj21NQOO/yCV6TiGCoxvcAWZ62KQHq63S5Q377ggwzeOh+WVZbodzMn/80p
	LCX6mlpvsiW5HzJQ5auqNycJ8upLlFOfX1/6eRhHR5TwHyVTFUatNuN8p5ZbQZexSVPaVc3D0Hndc
	wXk22u8/TCm1P9UurLHGmrjUmiEDJCMxJbWQL89FBJKjI3cqLL9c5TQKiH1weJ5aFvxlfPD9puhAG
	mhg1FGOpH53+/ShBn1eL8RA2Js9JXg6SgizBFDEvrom+HF1WCzn41OL7TKJ3Mu2fnzdVgwpXkCW7h
	0L5kj1Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXoG-0000000EBR0-2dTr;
	Mon, 29 Jan 2024 20:00:48 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXoC-0000000EBO5-155K
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 20:00:46 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33aedcb0de7so49143f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 12:00:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706558442; x=1707163242;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=e3DFQlQzz+ahdEiSZ7T4C5KAD/cP4bTzs2Ys0j6i2gfGCnoPKfHNMcsWQ6KlCGrymp
         Ojy/SNAn3eDEeOi75teEJDtHYpeSuxJ8mk4gPGrbqE4qouf1Z9ySkF99bLOpID9n5hRY
         l398dF3rU8UnNk1jxRDC2LMQ3uRaBFzb3g3/OZkBeXCIc6n7mGkC2Tg4rlAM7ppsWcxn
         k/VyPNdTAFJMjNrRFoCN92q6tPENOqcocjRf4G+v5Rtleyo6/zOq/liNQwFhLOItMN2A
         ruiTQkC0XTsLxlXm1lALoMvYT3xiAgGPhfgt+3703Fdp0fEX4fEkEc8FNANxRSUUwcJD
         k5Sw==
X-Gm-Message-State: AOJu0Yxp8VJvdlJInGU21NUJJKxhMySQB9KSLMntnirWr3P7pib79zJS
	Jck6Vixa95ALKEZkZTcTRqhNJ1cecWTflO6wtSscOgcdzwiHs4sC
X-Google-Smtp-Source: AGHT+IGB3MD22t+BV5sM6hTDOy7pLV5Tuc9YnVT+odF/Nf6cRwl6XDG/QNkL4s9oQPtGXcNQB3mj7w==
X-Received: by 2002:adf:a4d5:0:b0:33a:e3ec:d484 with SMTP id h21-20020adfa4d5000000b0033ae3ecd484mr5349630wrb.6.1706558442532;
        Mon, 29 Jan 2024 12:00:42 -0800 (PST)
Received: from [10.100.102.67] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id eo6-20020a056000428600b0033af5086c2dsm1401965wrb.58.2024.01.29.12.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 12:00:42 -0800 (PST)
Message-ID: <6a57480f-13d0-4505-ae14-8d9359a2476d@grimberg.me>
Date: Mon, 29 Jan 2024 22:00:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme: change __nvme_submit_sync_cmd() calling
 conventions
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240129063948.3105-1-hare@kernel.org>
 <20240129063948.3105-3-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240129063948.3105-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_120044_314570_6DFAF3DE 
X-CRM114-Status: UNSURE (   4.95  )
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

