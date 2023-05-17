Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C401BC77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 07:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Kc9S4Hbwn1RpOl9y0+BvWbhJdw
	a578ac8qlXp4hbeFJcTDyRn8Qq84FEGYZcgePtyjwDK7h6MdUDUeTu7AFa4jI5dl6IQa0vGNfUNEc
	M4OySNClYdlhsJFlSXOUOxXaKiGjgLVM7WL8bWVd4qk6NluLWEeFtJfX6HMSKC4jtPkw4Mip+/ZCA
	vOc5gqT54jQ6bJtI/co/C7dwFeJZ8/x+blKsZQ1N3LFjdXk+3ZFg2lpAe6N8Uv3UdO+nKqULYMmnZ
	5t16qemMHnaLtliyHxSpJ2wJcHFS2i+KZmlwOnVQ+2+daxz+V29c2ONgr7yNyt4JwvldwL7osOup+
	YIuIVTDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBHr-008bqY-1g;
	Wed, 17 May 2023 07:09:27 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBHp-008bfD-2t
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 07:09:27 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f42379d553so957145e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 00:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684307365; x=1686899365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=T8BpMiuf2NQU3QmHoj/ikSnKGoWmAirVcZaha+FLOJMeAxnrAykUklGaJRXtsfcce1
         RnQTT6PLhMoVE5zZQeyH2Br94F6J/S2xnDlJWwKhpYpBQ9NyolQ5QsUTuCqyWkvO5Pbq
         C4FDZE7UAHRdlCHqNcks78q80J+4ySIeTFRKbDRd/D8ZlInjZK8PAQJnDTmpKb3XOz1/
         luMhxLcmRFllwe33H+CyIPWueHznuN5HpC35NTCs1KvL0FJCkOeeHEzoW5AuSgd/CYtx
         KqYlf+5MkSZ6tXE9IO4D2UgE8Z9noWH08f3PviQhExYoucPb3V6VVOEPnBCdzofD5I/B
         FTwA==
X-Gm-Message-State: AC+VfDzByXcy+Mvvx+a2KdgB4jPtir30QwmoQfmwr9w6dxJIiI8A2puD
	M5AaPWXziZfzNrUH5mcM/O0=
X-Google-Smtp-Source: ACHHUZ7LcAsOLxX+g/mqm5BIFAZXKqCHSnyKo88SzbzOHGnjC0uG72resS96FxFtvawO37mxNMS8FQ==
X-Received: by 2002:a05:600c:3b23:b0:3f4:27ff:2ed7 with SMTP id m35-20020a05600c3b2300b003f427ff2ed7mr1306062wms.4.1684307365078;
        Wed, 17 May 2023 00:09:25 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n11-20020a7bcbcb000000b003f420667807sm1221156wmi.11.2023.05.17.00.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:09:24 -0700 (PDT)
Message-ID: <a85e3e79-6a42-6159-4f8f-f19fc7e2f61f@grimberg.me>
Date: Wed, 17 May 2023 10:09:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nvme: do not let the user delete a ctrl before a complete
 initialization
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
References: <20230511110741.1883129-1-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230511110741.1883129-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_000925_931358_593DBA55 
X-CRM114-Status: UNSURE (   6.69  )
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

