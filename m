Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73391C5DF8C
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 01:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=i5eEP3j4AhMtM6VBDwYi7G78mp
	mcsdIOyFOF2XGyIbgaPz3xf/R+raOyXc5XcvHuubbFylsSkr8kJyPpgNUtQaYHJIgu/aPE+t+B7j2
	owqUpmejKkck3piMJQs5EyzDxnw+4zIw9un7+s3o3JzoXj0HsaK173hRNTdkhrHt7DpaosUWan0ks
	6sWfvjZUNNil8m89lxSeNTwB28KxWKFLt09UVgr2yScP+1/3rnlbo2Y1J4ImhoZXywyJsStDkViiB
	BNsp8TQya8cEXXxZx6zfWIG7bnoM26jE6Q3yW/ppqi1lh4hYCkiVP+HvEMHfKSv58vOP4O3Zackme
	9uT8zOpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwdI-0000000ExAf-0ffU;
	Sun, 23 Aug 2026 01:04:20 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwdG-0000000ExAM-2AU9
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 01:04:19 +0000
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a386a34603so5443638a12.1
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 18:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787447057; x=1788051857;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=LSfm6wTYXnaeWsuItTJOouvHcRaRE6U/yYWZeoAFbFQ6qNObPsljjKL56E2ehsBYI0
         Pfa84weYylSnd96H51kpmF7An7mq1WdTPZ5xvZv4b51Ju+fmpEvpalwkcV5oDmaOT1Be
         4h+iQKrG1kMObksyv2YDwz90bw3wOrmd9CWlXQhlZhlBkD0kteFXD9jjiMUib3wlCAQD
         NcWagsIwjXSiijQN/rLCG8xJEmcZZENJunZDdlAkzSOastB8/LlAqA9sSn8gYBPTGYEm
         HuZ7wkr7PY8wXsL3WUN1DqU3xdkBsIaJ8chLZw421VZ2yKbZiWAJOe7up76FW9ndLt4j
         UGcA==
X-Forwarded-Encrypted: i=1; AHgh+Rp4HpbC0mmOVPVJklNRwhjOlRAsPHLuiX/zxh8O4yoKaOP0gljWaJqQl13spw1o71Q+PCai88zSX9mF@lists.infradead.org
X-Gm-Message-State: AFuF++kpNQUFkNJnFyqcYBa21imYWofVBho026NP/seytX79FrNJf8Js
	l9Tw9ASHat5OZZUOqx1AecJxnAmu1L1Z0cCS9SRC6UUnOInc8kpLPphw
X-Gm-Gg: AR+sD11YOJuvSPshMsnDh1j+N25UVDNSZlSbcdcYy50Jmi6zi0xnExsPOu3lExgfqXU
	K+PHHhUSxkBQ2bcA7KmTjpJ2he2zaRRay+2phkciR5zK244tT8MgSpb/993kkeWT4hOX/OnidRx
	sPlvf4wExX6BtkwFW+nJNg++xWgg1Ad4/ANAnc4MPyRy75Tbi2KpUgZvEktYHOs25al4b5qzdcv
	W3YWYezZmRA/w/koWmgVzVV01crdRinh1qna6FhoosGRFKRnrSadamTOV2n3c1/B7WuLJX/6JZb
	dDge3r+hwAPxZH87rPvHqitWILs5g8SeMxijLlTpbeqeyEPPeWp906qbTopl8SkyvtApOlC8QZT
	JZrAl5jnwAEjzTDv9BBmOb45516rzlvFZGwtNIFIfa9r72yRs0c2FxiieuqmCLAxYEOdzf54F6Q
	3UJbhCRKx3jbyG0nPwnhs0QI1V1t7tBPGzCEofwrOPYRxfG6+nRmOvSVSXLruCtPTkpX1bjIwVi
	ti1ztI/KZeeQO2iu3fiFSg=
X-Received: by 2002:a05:6402:321b:b0:69f:c929:b88 with SMTP id 4fb4d7f45d1cf-6a430debb60mr16101893a12.5.1787447056614;
        Sat, 22 Aug 2026 18:04:16 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e199767sm547297a12.15.2026.08.22.18.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 18:04:16 -0700 (PDT)
Message-ID: <374a3f68-6ea5-44ce-888f-a5b5635c6283@grimberg.me>
Date: Sun, 23 Aug 2026 04:04:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/16] nvmet: Add support for CQT to nvme target
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, James Smart <jsmart833426@gmail.com>,
 Hannes Reinecke <hare@suse.de>, Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-16-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260712022437.3743117-16-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_180418_557075_986ACC41 
X-CRM114-Status: UNSURE (   5.21  )
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

