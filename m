Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A35ECAAD4
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 09:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N/9qEkDSYdKPALITKV+9aUenoGRPjWeWK6o9rNRQ0rc=; b=pj4zzUVA+tuVH7BItyTtlQiTqD
	Nt2fAkOdyYUv7CYkdUzpeL6R7h7gUKj0a0cACEZr1Z+GcIPZ3vmgv7HYayu4Lz6Bg9R0YjhTE6ldS
	bi2Nx2ithNCt7WlHueCyBSk8FJGg/dgng6pgwt7LrNNr7ctA8Jzi/p2LMXcPjKUJuKHYktasklXR4
	oYxYN5dyeFdV+k3o0/ej8ooiewDC/4hJo5ReHzQC/hXhQV1jlwuuV39QH4gj638xOyMPMYhPKmo8Z
	45UyitVWYcZhnK0jKuHaRU8qLKqBDNMyoFX8SQhOpTcErtIsAIJ67Ktiq714JWPKzunb3j8YPUNpA
	fmHKw2cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaed-006ToZ-4R; Mon, 29 Aug 2022 09:01:59 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaea-006Tca-KK
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 09:01:57 +0000
Received: by mail-wr1-f51.google.com with SMTP id b5so9300170wrr.5
        for <linux-nvme@lists.infradead.org>; Mon, 29 Aug 2022 02:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=N/9qEkDSYdKPALITKV+9aUenoGRPjWeWK6o9rNRQ0rc=;
        b=peqEq2sdjY1hfczz8+jMQUBfNn5XQIFgE1zzcPem0kC8znBRQuN+VX8eAoQAXHZWXP
         u9LYolixUc8u27H9m/CauBmGsOAEEvXwsr9VeqNtiV5tIhe21hbgKB7Eda+MzhuuHe4p
         55rzcTdc5O8tqelVNDkiwaTyFX7To5Efi+nJXPbaVmfxj8YNFNfXOGb8Wa1iE2jvwtb5
         0OXu0jqyzaZZA6IMOWSGtskm7Yo8YxJOKuTMKpMs44uOx7kcJDHDk32QNo/bSDZbk4Ks
         MVsC6ZQVTdgWiy3VSGmPb19FyUegvPOtrdaYB5ZcVBeh/6t2SgvG+GcQq+WKl1v2qRS5
         7yZg==
X-Gm-Message-State: ACgBeo3aoqiRu2n+vA73JKHpb8GW9nU0DBj9H/Jgsp7v/5MkL+q+2ypi
	NAYTgjm5TKqS4gNew8T04JBvsOHHV4k=
X-Google-Smtp-Source: AA6agR5oYvgGRzls2fHG9kFb8N0ktP1nB8nZAB7IvEsSQmuHT2qRUfYKnx5/T8sVEfZF0h945rmpIA==
X-Received: by 2002:a5d:48d1:0:b0:225:3ee8:e5b8 with SMTP id p17-20020a5d48d1000000b002253ee8e5b8mr5472189wrs.105.1661763710225;
        Mon, 29 Aug 2022 02:01:50 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c420300b003a5bd9448e5sm7767802wmh.28.2022.08.29.02.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 02:01:49 -0700 (PDT)
Message-ID: <1b62ecd3-c8b8-10c4-ad88-2a575ea7dd00@grimberg.me>
Date: Mon, 29 Aug 2022 12:01:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/3] nvmet: Expose max queues to sysfs
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>
References: <20220829083856.1850-1-dwagner@suse.de>
 <20220829083856.1850-2-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220829083856.1850-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_020156_812454_A141B158 
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

s/sysfs/configfs/

