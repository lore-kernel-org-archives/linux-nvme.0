Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC573C4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 17:31:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87BF56136F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 17:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 87BF56136F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=3FccKKmqTAcDv999x0tLt8COhM
	R2wo6+tvn2ObB5tVq1bU9rnk2Frbd2k6847+tt/spp6HkiAAdDFXOICWzPUPkpvxrP2BHhg1h/YHz
	eL9nf8VKTh1PeeImpnfJCySjPjZNyEZhLaPrqf0cn5y0UV/DH3bPAoW48i5ZwI+R3G043VauDrCCn
	2LKslMBBxsND7HCfh/O7vpYPg6zZrPMropsWYC1bj43f6VdYGd7aKGoFXaOioLidBx+SbMO0tz/ls
	J7MvXGmS1/39AWKy3HIMXe06ILXR6dlOZ1OifQV1moVU2Fc7kORFArFz6fGKYJgnLOpori/B9sb4+
	WU11l26Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIDnD-000BAD-KJ; Mon, 23 Aug 2021 17:31:27 +0000
Received: from mail-ej1-f53.google.com ([209.85.218.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIDnA-000B9F-Hw
 for linux-nvme@lists.infradead.org; Mon, 23 Aug 2021 17:31:25 +0000
Received: by mail-ej1-f53.google.com with SMTP id u3so38643436ejz.1
 for <linux-nvme@lists.infradead.org>; Mon, 23 Aug 2021 10:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=VcWlthOVK9flwa65OcBTFselZSf4Ke18r2jLefV0KRDdlqVHyAayzLhCPbtOOslmPP
 LFpdjshqVBFIZqdOE3hIdRqICTGntZ5WYfIapy8rAFnUKDNd2S0B/2jxhDR8l7HZmpxD
 TcU9C+SttF04HxDS0Cg/Ii9ZC6p+X9gUBayc74AqPu2AB2dj67Z9/HSzZyVAUJ79k810
 +G3dplvqHr8E0kqEslSYX9adYUBlSSl6RSuMOLocrw7RGBXeFsrI69o+K5QQBBd5BIHz
 8j7MAJt6CL0SVWSQH2yYl5UvIjeG/8DUCdaFe0f2L7YRyi7w9pSHi4Ct3smxJtBzjrDo
 iNhQ==
X-Gm-Message-State: AOAM5300yke8YQQXKP6/3yrN5Gq2LmigxE2/NpmwdmFzwASgI6u7VzTu
 GGeyeYwE+IiddGPF9sJv32LDN5JbEFc=
X-Google-Smtp-Source: ABdhPJyWbYu8uKX1tPVF3063u0cvulgHpka3lhfRbr3LPLrFz0BJIHwA2RYqWJOEzf8hILYryaQWoQ==
X-Received: by 2002:a17:906:158f:: with SMTP id
 k15mr36329294ejd.241.1629739882299; 
 Mon, 23 Aug 2021 10:31:22 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id r16sm7730472ejz.41.2021.08.23.10.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Aug 2021 10:31:21 -0700 (PDT)
Subject: Re: [PATCH] nvme: remove the unused NVME_NS_* enum
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20210816124604.606056-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d1520315-406f-a257-f0da-b1653a872c62@grimberg.me>
Date: Mon, 23 Aug 2021 10:31:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816124604.606056-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210823_103124_619885_C98D8702 
X-CRM114-Status: UNSURE (   8.71  )
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
