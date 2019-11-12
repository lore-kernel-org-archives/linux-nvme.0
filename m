Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259ECC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 18:44:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E90E020818
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 18:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="infM/dWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90E020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=infM/dWwlxTa1NkqDIq6jh+9q
	c7x5XLn52t4r9BNWqsVBnrFvI85jDo8RBWMV4zqaoeXPXIlq6jrIwX+soqemN69cd6GHKi8nL/aVh
	o1Dk50XqvTqr5Ta+UmGE50Xd9476NLS7+IPpBSXAjU9OwrV9r63k/b3KlDxdN63nksIEF3P/QR4Hj
	HyH1uvmmhSfJYuCXcF9WsDb2woLjTYTgo+KYdR7TnMiA1AOzngtZildXwDsKi83wQUA8GqdFc1Xw1
	E2MejH+mQ8dM19v6twzuK7N47CK9l6pkGN8o0L+zEL+eJQy38ELV1//+sOosJRU+ZRout5R2eebra
	AggrzQw5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUb8x-0005RI-9c; Tue, 12 Nov 2019 18:43:59 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUb8v-0005Qm-1S
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 18:43:58 +0000
Received: by mail-ot1-f66.google.com with SMTP id m15so15213110otq.7
 for <linux-nvme@lists.infradead.org>; Tue, 12 Nov 2019 10:43:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=IJ2JlMZlfxR+KMORALOqyJj+K64LbH6kpQG3A4KMKpjZY/3Eh+RjwF050aPLJvkXcB
 6S4bQy/z5067dAndzAMKfwN9DYQZ6YAfsyvZZ9XQPRkcW+rbJERd+XjdjbiCw/HpHf/L
 tzdd6515/E/kWSklUO4zoRVyoUsz5rMgTLf31VWdc1Rxm0etmm5B2wK/5nY4G2VKfH0F
 HbA53h2BowZYO2z98ce56YkoAYD2qd4bE+FVkJmESuqeSCNNlJH3e1AjFMfpG4j/wsAG
 TW+dy1tlLguJamTS+52RjBUg0bXC40XyZEpzAyErHtf3Fpc3tK5aAzC7g62Ge+lnAtM8
 Ftow==
X-Gm-Message-State: APjAAAVzz5X+GpgAZ+JAOvjFn/zQ9F7v9683nJ1Adp6Fv+sIEUwluew7
 elff8hxrmUCSm35J9yuIpd0=
X-Google-Smtp-Source: APXvYqyGFtxz7J87Z0+cEEvvorfx2GDJFsue1SaOZViMo5xDD6JpLlNBOW/pRs7W/2Eog02kgdN1Pw==
X-Received: by 2002:a9d:854:: with SMTP id 78mr26311738oty.284.1573584236417; 
 Tue, 12 Nov 2019 10:43:56 -0800 (PST)
Received: from [192.168.1.114]
 (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
 by smtp.gmail.com with ESMTPSA id l32sm6495617otl.74.2019.11.12.10.43.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Nov 2019 10:43:55 -0800 (PST)
Subject: Re: [PATCH 10/15] nvmet: Rename nvmet_check_data_len to
 nvmet_check_transfer_len
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-12-maxg@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8c381366-4366-be05-a4e3-72ac91bf6695@grimberg.me>
Date: Tue, 12 Nov 2019 10:43:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105162026.183901-12-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_104357_081504_8790DCDA 
X-CRM114-Status: UNSURE (   8.52  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: israelr@mellanox.com, oren@mellanox.com, idanb@mellanox.com,
 vladimirk@mellanox.com, shlomin@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
