Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBBBC27C4F
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jun 2024 08:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=pxR4nPoAJex0+CRpilkfkiVgy7
	4zAT0u1IYZoVaGnco7IBubCZoLA2npJnQr8OUc/aUjBUhukiV+1AvUwmQ3nYruwpUO2aw6QXX7Ywq
	slAM6cmcTaK+dQkWKd816NlxXcu8O4CdW0dCNXTgkAUbTFjsfy04NEepdQVOjMXSH7AZgtycwareS
	KBkQoCLYvutpCCRD7wGYr5R1mwYURwlau/KWFNg8cEMJMzxxrVIlyqEMxlg3lZiqKvtTr+4vzdNiQ
	dTXq65Lj4n8hY1rNgFXEjQavhOv1zMyiUvjRh1t3W3swSwbLCqLtTiebsx3qBfgazgyRUj8DSRONN
	BFBrMwcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNpsK-000000002rs-0tx0;
	Sun, 30 Jun 2024 08:25:32 +0000
Received: from mail-lf1-f52.google.com ([209.85.167.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNpsH-000000002qG-42fM
	for linux-nvme@lists.infradead.org;
	Sun, 30 Jun 2024 08:25:31 +0000
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ca9e52d5dso180808e87.1
        for <linux-nvme@lists.infradead.org>; Sun, 30 Jun 2024 01:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719735928; x=1720340728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=jhMJZ7+dfN8ENiDEZFyPvAn0SFgsKYSbuRfss3ykzwS6qOw+D1YStqzRh6puEeGZH8
         MEqCvWFiF6EJpv9fiBSobiWlO5/Fw/gyRTviiCFFpQX/+kp1lUvUG8m8B0iPXwWS7uGR
         XKDgatrZywdAOSPS11kbq+zeS0M7pqymN70r0mHONwbGyb7zeezL94JdSu3gjG8+iAQU
         KYktAj8xJhLRD06SjWmAPajNbECT+DUieZgDW/0PHaUp1KGSF6stXbJ2nOgS9nW7AMe4
         O4ER9mivjA/3tN9Gt9l24lTEyGFjvuND8T65osmGRrrDiBDW/qsU2B4vzZMEz7tcvv9m
         GO4g==
X-Forwarded-Encrypted: i=1; AJvYcCUzMjrgBuYVsPzeK27Xg0Nz2Lu4Evvw6+6xZy1kNIIIdce0iTQYr9Kk9Zg0H3d7XftsebNxX50pabWQAlEkq0l98KWDS24EgdntJxY3mcQ=
X-Gm-Message-State: AOJu0YyjkMEtuFrbWm8rFHsAWPeyUIDS0tdhw3MGywReg2/PSvJHXCTQ
	qz1xS7W/0ah+zqhjjexbTAepM/VDzEbLAPVFf9Wmt56tnYJfqGad
X-Google-Smtp-Source: AGHT+IESUjeAFOhpin+AORXLQ1ucUyymLVGh3HpTXyH2l5Sz6D0B8lqJqtGoTgJWatL/imKYw89URQ==
X-Received: by 2002:a2e:a267:0:b0:2ec:4f41:501 with SMTP id 38308e7fff4ca-2ee5e337d17mr14893491fa.1.1719735927753;
        Sun, 30 Jun 2024 01:25:27 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675f9dfbdbsm6468852f8f.103.2024.06.30.01.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 01:25:26 -0700 (PDT)
Message-ID: <f790f4eb-231b-46fa-8347-a0ae7bd6f1c0@grimberg.me>
Date: Sun, 30 Jun 2024 11:25:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
To: Daniel Wagner <dwagner@suse.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
Cc: Frederic Weisbecker <fweisbecker@suse.com>, Mel Gorman <mgorman@suse.de>,
 Hannes Reinecke <hare@suse.de>,
 Sridhar Balaraman <sbalaraman@parallelwireless.com>,
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240630_012530_019950_E44039D6 
X-CRM114-Status: UNSURE (   6.03  )
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

