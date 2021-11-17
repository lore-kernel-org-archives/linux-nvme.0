Return-Path: <SRS0=tSwM=QE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9D6C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 21:50:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF0F610D2
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 21:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EFF0F610D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GZI7ngT5f/++7QS4WzwWCeDhrtW2tGNWszdYS2/jZJk=; b=KVKQLI5VmhoOgyL3g9ry8jgDcA
	5I4lC0f5o9XtVNxOB7S0y5k8kwBFeBbQfB/NXX+WgvvRvg7RdKcUzW/BpZLmHsLQLw0Og1mOF2+Nx
	PIOJQ5arRzpKq5xv7EtdgwcFMghgOmTfeIAEajnh7nnqoJUOdJo9Otd/TXbo9jCaKxvq9cwx+DBpQ
	1LYk8MxXEpNj7dth3ibPhlS9KKW6DLlcYpSdgVdY2J3UupqvKmoUVJSabOfYsRCf8XprD3h6Nur/b
	6Xflt93wICoTZp6TV2bo+9mDWRvHerUvnAGfZbwIu5ia9aN8wtD5BP73uVIA+5/7xlSmcMaPSiBWu
	4aYsA9TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnSpR-006LCX-Hb; Wed, 17 Nov 2021 21:50:53 +0000
Received: from mail-ed1-f49.google.com ([209.85.208.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnSpO-006LBq-NK
 for linux-nvme@lists.infradead.org; Wed, 17 Nov 2021 21:50:52 +0000
Received: by mail-ed1-f49.google.com with SMTP id g14so17411957edb.8
 for <linux-nvme@lists.infradead.org>; Wed, 17 Nov 2021 13:50:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GZI7ngT5f/++7QS4WzwWCeDhrtW2tGNWszdYS2/jZJk=;
 b=bAd0Eby1Z91ntdBpF66fC+MD2Z6YHRj4JaXyvFE0hdOcGn+HKdX69VMlntMf3XSDyJ
 Tgpqji3IuT3Gsjj2eTf4MjLY5Kw8aIJlHCrqL9E2mHUFcEE3AvKi6wlmGzIR8zMDdTsC
 R7uq6wZ4AWcGqJYas44quv1Ura9YOIwRad9rVSSlLDJmBML/QdezPjsHhE5mLIahy6Y/
 zt5ZzZudEft0js+7CRLCbAPzBUwuzXlqKGLM8oW72PoaCwvWSdgn3gcHZb2zXsc1Aocx
 j5uxJA95X5ljbFxQSxR096/aHPPpOrIHFF6s9aOzbCFpf8Kew9VjsZgimzOod73RpApP
 e/9w==
X-Gm-Message-State: AOAM5301yOZHLUPLi4kJttkrd7uMBMe58BLRt6DGAiTv1JSVAqzqdMi6
 DETlp3WPEUUOdY7RF+n2Qb77N9S2GEw=
X-Google-Smtp-Source: ABdhPJwqC635SGCBhSxwYcnSjDbpJhFpZ7dNCQj0HhikhmN8sdZhFoSzeUpFerQwdRhbPcCSXkTAZw==
X-Received: by 2002:a05:6402:114f:: with SMTP id
 g15mr2943618edw.333.1637185848504; 
 Wed, 17 Nov 2021 13:50:48 -0800 (PST)
Received: from [10.100.102.14] (85-250-228-224.bb.netvision.net.il.
 [85.250.228.224])
 by smtp.gmail.com with ESMTPSA id e26sm548018edr.82.2021.11.17.13.50.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Nov 2021 13:50:47 -0800 (PST)
Subject: Re: [PATCH 5/6] nvmeof-tcp/005: test bi-directional authentication
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211112144510.98523-1-hare@suse.de>
 <20211112144510.98523-6-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c34f1bbc-c54e-9e9e-86ed-421ea602efe8@grimberg.me>
Date: Wed, 17 Nov 2021 23:50:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112144510.98523-6-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_135050_795421_48E7663D 
X-CRM114-Status: GOOD (  17.11  )
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

Hannes,

Should we add negative test cases for each of these tests?
Currently for some reason I'm able to connect even though
I provide the host a different dhchap_ctrl_key.

Controller:
--
# grep -r '' 
/sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:b73ff014-2723-4114-aa8d-2f784ecba4f4
/sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:b73ff014-2723-4114-aa8d-2f784ecba4f4/dhchap_dhgroup:null
/sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:b73ff014-2723-4114-aa8d-2f784ecba4f4/dhchap_hash:hmac(sha512)
/sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:b73ff014-2723-4114-aa8d-2f784ecba4f4/dhchap_ctrl_key:DHHC-1:03:M4ik+B5zPy9vqzH0Ef9sLWXLL7HQ1JEqx0IkhMWwNPc0tq8ZLkTQstMl1A9wkMFzzo52hJwQ0wP9GELWmUwUgFisuGw=:
/sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:b73ff014-2723-4114-aa8d-2f784ecba4f4/dhchap_key:DHHC-1:03:ynOWXFT8AC/OlvuIkpQ1RQlDAuHz2axeP43zmws90yRhPHNP5HyDQSI3m+WCBKcUfl7gRraflcb7nHAHR5mTh9t22Js=:
--

Host (use same key for -S and -C):
--
# ./nvme connect -t tcp -a 192.168.123.1 -n testnqn1 -s 8009 -S 
"DHHC-1:03:ynOWXFT8AC/OlvuIkpQ1RQlDAuHz2axeP43zmws90yRhPHNP5HyDQSI3m+WCBKcUfl7gRraflcb7nHAHR5mTh9t22Js=:" 
-C 
"DHHC-1:03:ynOWXFT8AC/OlvuIkpQ1RQlDAuHz2axeP43zmws90yRhPHNP5HyDQSI3m+WCBKcUfl7gRraflcb7nHAHR5mTh9t22Js=:"
# nvme list
Node                  SN                   Model 
             Namespace Usage                      Format           FW Rev
--------------------- -------------------- 
---------------------------------------- --------- 
-------------------------- ---------------- --------
/dev/nvme0n1          c7ebe13b94f6ad3885c7 Linux 
             1         268.44  GB / 268.44  GB    512   B +  0 B   5.15.0-r
--

Am I doing something wrong?

