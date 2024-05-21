Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAD5C25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 20:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=XvTwMan0TKAdL9P1TlBPBVB7+J
	AohJhmkb9GbC4pQ6ZtsCw9LO+XffRdm3vUN7VUQmr1lT9kWJbFA0MvOrpjif3R5ki3AjM2/WFRK/8
	YkCi/f/9/uPyDasyvbVzi/Nl2Hmybt0zA+2B1lEzkLKzdCRGC0jcvIwfXegeDoyI/xMzZhUxazRZ2
	5vBMvzLAwtg4x+Lk+6xy5wDBirvh//q8F/QLWj4jHaYcuX1cqg1X2Ydx57PRR5UdPWpPIlIJZtXd0
	u4KvLWH4ClHqWUH51Io7O3YPad7jaUw4h4hrjJoTsIR6jfFcxoQ6/UdXMwDDlbd867krld+0KxhUd
	ia48n5Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Vp2-00000000yc6-0jVi;
	Tue, 21 May 2024 20:10:56 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Voz-00000000ybi-3MS0
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 20:10:55 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-420139ea1c4so133165e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 21 May 2024 13:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716322252; x=1716927052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=X75T+717CIheO6kj3yQJ3SUXJhtFaQmxxin5um2MALRyBruLcfu77CwFwBO9AjZ1CA
         5APkhKe33MDCt6DJMseJcSAkB6M/jnfdiBcgpioqABu9nD5bsCW+YD57ckZwPKdz0Drs
         M7dZwYzPBC6kxdZulgZNTFldLFHC6x0Vb05TF35q4UdoVqlWiLaGOQABtB2cBxK5rToz
         hA3Sct/c6kw689ScW/N628+O8hKSmxOMBkwz+CrabADbAtAKFx3gRYJB4UfcPEM5Bb7h
         InlnOCHku6XSQ+TgKM7GYxTaEMvsAGRWrD+1t2L/grkjFHvZzz/eu0ve2DmwSalRcwaf
         F6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUOpD7zQ+j3d++nJQLKjTxmA6yV914PptHO8vr33m6DcYGHQ574w4YQTnEhMzhjksKGrDZEkVc+OJwwQnhAlGISXhMZWLcaaYOEIdB7eyQ=
X-Gm-Message-State: AOJu0YxK9rTh466E+CEeydlSvDTvsEC6NnSNmWgELu/0LFnsNFCvxSW1
	T9LjD9wzCmAHANUQnobwj2A0A5FdA/e7T7bzzpH1YHFTdferfslq
X-Google-Smtp-Source: AGHT+IFxjNnQG+s4INhvrzbLd5XScWQp4HR5URVOEZ/Dehk+4ccQaDf7NjYRnwAzsPOiaWBZyykcuQ==
X-Received: by 2002:a05:600c:3582:b0:41a:bb50:92bb with SMTP id 5b1f17b1804b1-41fea539aafmr244442795e9.0.1716322251600;
        Tue, 21 May 2024 13:10:51 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420149b1c24sm366299185e9.41.2024.05.21.13.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 13:10:51 -0700 (PDT)
Message-ID: <20d89de5-3791-4a3a-8af2-d1b3ed1f013d@grimberg.me>
Date: Tue, 21 May 2024 23:10:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix io accounting on failover
To: Keith Busch <kbusch@meta.com>, hch@lst.de, linux-nvme@lists.infradead.org
Cc: jmeneghi@redhat.com, nilay@linux.ibm.com, Keith Busch <kbusch@kernel.org>
References: <20240521180712.2423165-1-kbusch@meta.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240521180712.2423165-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_131053_879003_85B939CD 
X-CRM114-Status: UNSURE (   5.06  )
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

