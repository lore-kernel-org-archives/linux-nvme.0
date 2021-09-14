Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61817C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:10:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275F761163
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 275F761163
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=VT3YVDVHr1p488ygxCmAzmH13M
	PuWl1d240Vois2iKB0Bu+848nT3NyJF/pzXtbe1kJHjHZ/EvCMtegiLS1mN4Uf4tNnj2kB/o5wUry
	67QKXjoRwx7hoEs+O74fEkJZiBsrljUOXpM7saDSgLYBIAYGA0NYoRX9W770XuNC/ulywp+l38Pgb
	swOJttwCawriqpAkykQVnz0EtA8yPpwUcz1xiaq/EkhzadRr/LGR4tmLZEiCBjoUYoOUflD7XVd7N
	OopFUUj5Keuh/MKQgdVOPH1jI9V+WRlLs7Ai5FkipRSAKyG9EE+/9k8GaGVeP2r4nuq17WtMCKGp6
	17JO5JSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ2aG-004OTk-EH; Tue, 14 Sep 2021 07:10:24 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ2aD-004OSO-Bh
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 07:10:22 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 b21-20020a1c8015000000b003049690d882so1176184wmd.5
 for <linux-nvme@lists.infradead.org>; Tue, 14 Sep 2021 00:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=fnRqjodgk9khcsdbhdBc5ZIvA3iLt4O7DMNG3qucR8f3nvWa8XTNt8AWde2KFIi+I4
 v8GOHnUboG39Lq52H9RO14rR5e5mAff0at/Hpa7Y50AwpkwgY+XaSypsuJduUH53goqC
 2FTCE+hzkoPfzuGBe7qycIqld2yEUl+uu8VF8zx3cCJppERYIFdCB2c4+VjNGaGFGGGO
 7zwpLE8T7CjqhrEYkMRPPknYiKp8UpiVrEgRVrSc+AxM86b1pd7sby7hYGscozLyz8kD
 vwqefDBD4ulYP2gsQjelreGsTLLBJrjQrUMIfvNJN1tksP//05fj8b+pOlvw/pZYui0E
 XuHw==
X-Gm-Message-State: AOAM530+UtORIGH3CFtAtNgbE/D9O5xhY6idhjDGS3mi3X91pKFf4zn6
 Sd3L5RffhvFT40ag51PNiZ5kmZoL2eo=
X-Google-Smtp-Source: ABdhPJx7sgMPw0ZveAhlsfNR05BybpsNgXDeSWAWCXYwgqr7q8we2bjrntKcjsDyOtsJWIFczNrzsw==
X-Received: by 2002:a7b:c447:: with SMTP id l7mr462543wmi.15.1631603419971;
 Tue, 14 Sep 2021 00:10:19 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id z7sm11919641wre.72.2021.09.14.00.10.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Sep 2021 00:10:19 -0700 (PDT)
Subject: Re: [PATCH 1/3] block: check if a profile is actually registered in
 blk_integrity_unregister
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, martin.petersen@oracle.com
Cc: Lihong Kou <koulihong@huawei.com>, kbusch@kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210914070657.87677-1-hch@lst.de>
 <20210914070657.87677-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f9ed98d5-daee-7206-59c6-88bbbc49ed25@grimberg.me>
Date: Tue, 14 Sep 2021 10:10:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914070657.87677-2-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_001021_456233_892E56B4 
X-CRM114-Status: UNSURE (   9.97  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
