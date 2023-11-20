Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B53C197A0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 10:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=M6yiVkN1Av6wsYJ0TWOZPPvFHu
	Za3cM6cLMwt+f6DiOZyPf1Ab0f2EcNOip+18Ex6y9f8G3Xe4YDFAtJ6z4PbfdWnphjq9soYVoTvii
	4qlb8Kil3uMTzAYBCReWCj7rl69vW+RcXgqT7tBy42ZLRaECKe/oSp/4mZm85+6fmzo0DFUNFJIJ1
	w1JXrjzNq78/IPXk3XU0P9Vq6I7yQot7AMHUPwS56h9vadQ6c89LwQGugV4Sc6dE2y5B60ZHlALjG
	AnUbudpDuEGL/dtYRftzYpjUY2Eiry4yfnJsfdgy1xC0Kq8a3g4Q3o+Tx1m00BsJqx6oKlybAsh3y
	rg9S9nCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r51iB-00Bnkt-2f;
	Mon, 20 Nov 2023 10:41:03 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r51i8-00Bnk7-1Q
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 10:41:01 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40a279663a2so10831025e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 02:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700476857; x=1701081657;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=vgOM8OPUlU21ogO3oaSVq3j0eNqe5ZKt9yAn2B9vSb0AvmYFmjuphAh9OBCFnSApgS
         a2kyZzDGMIv2bjxRQ7CYdKpKt6CwkuoHKMX4uF8mWCwM8gYtMmoEncQvmUtvXV/BODJt
         nhtf7PYfPNDUXcn7tgvVrRrJh4Ao52BYl5XzRUagnnhzX4RodTmZwwmhPd5Vikrx0m5F
         589leITjbztOfq5/aBkaDN5ZDqRAXDLkJHNQkYxePXOygzACGSua70aUtbvbVj59pfWP
         afNpeWNjEpCPw4My1sUadK1U9YyTBtiIsREY6T3B3uH+gkvAq+IdFPi7Z6iJFLlG81kV
         UT+g==
X-Gm-Message-State: AOJu0YxbRAxdnHbfGr3KOwuteQ0DWA7KdQ6jX+AH47JnX7h35uBbawwt
	ztb8QAKUSJm5W6mBm50AT+HC2HKt5Wg=
X-Google-Smtp-Source: AGHT+IFY7qLAPr/Jz7Q8vSW4abtcO2wWibEwqQfMcUtAfoqPDCV7Z396k3NLpEMROBvFA/LyDePdGA==
X-Received: by 2002:a05:600c:3d07:b0:405:3cc1:e115 with SMTP id bh7-20020a05600c3d0700b004053cc1e115mr6497856wmb.3.1700476857099;
        Mon, 20 Nov 2023 02:40:57 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c3b9200b00407efbc4361sm17783161wms.9.2023.11.20.02.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 02:40:56 -0800 (PST)
Message-ID: <7f039914-8485-4c6e-96dd-4d1f7f31e889@grimberg.me>
Date: Mon, 20 Nov 2023 12:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] nvmet-tcp: always initialize tls_handshake_tmo_work
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Maurizio Lombardi <mlombard@redhat.com>
References: <20231020050606.9464-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231020050606.9464-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_024100_817323_F0963AB4 
X-CRM114-Status: UNSURE (   4.84  )
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

