Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3F5C10DC3
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Dec 2023 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=bfz2u3ymnz2F918MYeQaTCLoVB
	tBp0uH+pJGxcPFXLEvUXjQ4YM2C2+RllYxsLJrxwA1z4uZ3TeUu0N1ZcNjuk6BOdmcpJZfXkrO7lD
	iqlwRmH5Ns/ONSWaFGXvPfFkv6CHZQ5UpDU2FQpH5XLL5xpB1VgUKo5/AHaxQPwn0KsSRBHg4FvCv
	xqKIgOZLlBdPntec96JWPFbCx1JtCtRmZD3uWFp1VJf7+WZVC0AI9s6kbcieaQt9PQfgFqeM8o/IH
	dz72ctHjgLAOE2vyZY/yxUXP3jm+fafyryMxfwqKQzHf474pdj12d/VLJP1p4ATfAJxTMY+yiwji/
	WHmUHY0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCh01-0057aM-0s;
	Mon, 11 Dec 2023 14:11:09 +0000
Received: from mail-ej1-f48.google.com ([209.85.218.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCgzs-0057VI-0P
	for linux-nvme@lists.infradead.org;
	Mon, 11 Dec 2023 14:11:07 +0000
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a1f8313c781so70392966b.0
        for <linux-nvme@lists.infradead.org>; Mon, 11 Dec 2023 06:10:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702303858; x=1702908658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=oMcVhebHzPtbv/trSI8n973BfVGMLsYerK9nFthA0ir6QWKTd/yIwK5YVO/2fZ5+33
         BnQZAq9zzK80qpTRo9YwAIeGQJrHmoaAjxZDFH7IxEnllV9zfFvznrjASIz4bfQ+CSMm
         MYxBi9wNzh5ShHfn73TgEGa3G/nq9yB4W3KixLCK3zq/9i8zQFIrrN0c5V3wPTdGpIOV
         y6dMDOAdzdcyObdaw0W4eLCbznqL3XHZC7LQ3TDj49QpCJG4dZaozVivrKI6gG1qMZK0
         Hz/FOSbXtN+ZjTUsJ2dAK+agFnn5Ywhio5yljQ44K0R0e9yMmDJ9n0ADYZQ+1tmTdz38
         bPLA==
X-Gm-Message-State: AOJu0YzX047ERv7q7VcOzNusoxDnTOnlZSBgF4s+c20ytfaYHJvq6v+K
	onNjj/VqHbE/ploeOZfHf4g=
X-Google-Smtp-Source: AGHT+IHVqNvEl5nemxeja2GAZginjIfzvHQEC1QMHqmZ4M4FEH5Zc6C8z9Gwn7boEv27GmqhgYLolw==
X-Received: by 2002:a17:907:a70f:b0:a1d:1c71:8158 with SMTP id vw15-20020a170907a70f00b00a1d1c718158mr4523094ejc.4.1702303857521;
        Mon, 11 Dec 2023 06:10:57 -0800 (PST)
Received: from [10.100.102.14] (46-117-87-214.bb.netvision.net.il. [46.117.87.214])
        by smtp.gmail.com with ESMTPSA id ss27-20020a170907c01b00b00a1d9afe42f0sm4865920ejc.35.2023.12.11.06.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 06:10:57 -0800 (PST)
Message-ID: <cc00e4c6-16bb-4f52-979a-490d9dab86d4@grimberg.me>
Date: Mon, 11 Dec 2023 16:10:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet-rdma: avoid circular locking dependency on
 install_queue()
Content-Language: en-US
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20231208125321.165819-1-hare@kernel.org>
 <20231208125321.165819-3-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231208125321.165819-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_061100_211209_3B148827 
X-CRM114-Status: UNSURE (   5.36  )
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

