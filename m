Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4060C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 15:39:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A543060F0F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 15:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A543060F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=1W6RmNS5FDbkdjy9jzFlHIY3GM
	xZHXIzUwvsAtAALOYoFZrcXUtwcaRONunmhuVA4qTfAf2vbi/evS6WCnP3tFo9s571oekorplXoxS
	o8iqgvoa3cSw8a/AqxsNGvSX8YaGIhNaS8/YSJ0Xx6u+dkdu7y7IuZ72Wqmi8WLZecVKFvxdfuH8y
	AFYcnkKRJ0iAGILYfz8g/JM1b3FsBnA3Dzf2s//fZT+8CwjcIHxnucioKB/IicH2yxWS0YZzpFE8f
	Rggu2Nub8vHz/t9G7HfyNQb1YZNqvebK5KvgBPd0VPwHiP/xBt/1hgE1pJGAes9HdClSAlT1GRkW2
	UPjhMp+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlYdn-00B8MX-EG; Fri, 12 Nov 2021 15:38:59 +0000
Received: from mail-qt1-f176.google.com ([209.85.160.176])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlYdl-00B8Lj-Dd
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 15:38:58 +0000
Received: by mail-qt1-f176.google.com with SMTP id l8so8785230qtk.6
 for <linux-nvme@lists.infradead.org>; Fri, 12 Nov 2021 07:38:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=Q5GuwmGEXhYEIPuvzpmNR9IUG1Nj/bHo3KAsHkVAyBUR8ZG6v0clMoZOauevB6//Zt
 z+gpopwJKBtc0VsDRwwThG/lhQrj2TLpRqSx6g9eCfcTtZMcLiVIV1WcYlWblAmfnMXo
 D2Gy9MUJNetYqT9IJEQeaSaXKO1ZFTiH8e+jOb/QKJ9QgB2lO5dLdCtEpNcMfX0BzOf/
 PZYMEtOdAMG8iOJssl1E44Z1zyARvp95cu11AYH3CjokG2FRg4iH4/ksCRkuFKrew0qG
 4fZQJQIU3HZ6iB4sndHOlwxrtfsLfUpCweHeH1wriWXmqSXoQdHP7WXx3b4Kb/5mQupa
 hoPA==
X-Gm-Message-State: AOAM531lZjYrgCHhx/KRNaVqy6yxNJ/hzZrkQDDDe8UkRgM+KzQCCMmT
 OtAjTWftK/AnhWOnCiocxnM=
X-Google-Smtp-Source: ABdhPJyNHeu9f/ZUxvOfxORx124sMvrbBsqcA7M4TM/h+R2WxA+t8TF0JDonrogyvFS5J2fkxYVjCQ==
X-Received: by 2002:a05:622a:1a93:: with SMTP id
 s19mr6774258qtc.291.1636731535094; 
 Fri, 12 Nov 2021 07:38:55 -0800 (PST)
Received: from [192.168.4.254] ([72.166.42.242])
 by smtp.gmail.com with ESMTPSA id bm35sm1893202qkb.86.2021.11.12.07.38.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Nov 2021 07:38:54 -0800 (PST)
Subject: Re: [PATCH 4/4] nvme: wait until quiesce is done
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>
References: <20211103034305.3691555-1-ming.lei@redhat.com>
 <20211103034305.3691555-5-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0f098e85-0da8-6337-5fba-b6e68a6d2ad2@grimberg.me>
Date: Fri, 12 Nov 2021 10:38:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211103034305.3691555-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_073857_492998_9A75F36A 
X-CRM114-Status: UNSURE (   8.34  )
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

