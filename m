Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A7DC4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Apr 2024 08:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=QUc3B1tKbOODUJ/EtvSKC7vnJS
	L0n+kOLrv8FE6zNC3eCTSmKX+0P0XOpkHkMN3tvXHrJCx5jXZo52QmTjvddgKQLFUsVLeU5mwrp/u
	f3b4tdwt7TVcr93k97dnFKzpp22q25S7GMkEx0edKNdokXqAuZb6AciIBUHoRwQT9/ley4qrJFjhg
	KjLgGzhKaiu2aK/Nor06YLL/i3O7RWumtFvhELga2teWPRuf9Lf7qe7OxU64BHXXm/lPHwhrkXKWw
	nrtN2+u7DFD+6D9ZzGMrUithb0o5M5PPHFokLEw13ZyBRgcfras2ytWkn6a6YnfU+Qs8AIItP8m+p
	hTX8ET3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvvKX-000000052Xo-3agC;
	Sun, 14 Apr 2024 08:35:17 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvvKT-000000052UO-40sD
	for linux-nvme@lists.infradead.org;
	Sun, 14 Apr 2024 08:35:15 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343cb97e7f5so584322f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 14 Apr 2024 01:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713083712; x=1713688512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=tcCdcuVEL8bDH4t6NS+2IKzWz7tsyt/TEa8ObNba10+Qa25By8P+pvuYPsxmhAgki0
         vV1h6wksNvKbKdFo6Kic0qcnjexF9gmU7WdEQuCRvKVa7Xb+H920sTZ74kTS5Y6GNIRC
         fzcPGpP6KHzyeOxmcZhrY5suW+J85nRq7db3A5Y7pnjk4BgZSNa5VUsvUIIeCpIkwSrV
         65HfHsvX94rPRDEb1WWPjTZ4kHr3n04TDPbr622ZorlL0Dj4BmX44KzfqRQx3VxXcNtv
         BL6kiZQfPlGChALzmHpD23xQuUB/Lb1rGp6sCBoTrJJ+jzJ7lH1I6oVOH1rMNVhJUeHL
         QWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsP+D4GgzIKbFX31r0RnVLTR7z2EybX3FI2KXQ+ggzOOpzaMa0pTLhaD0/Wp/c9waxIQVK9FEiKNHvkbCc9VwG1uy3kYLUO1guVC/66PA=
X-Gm-Message-State: AOJu0YwMRCwnLS1kT73yFhUJG+daVkWrP/5TyukcVp5J7OYsRYgGmibQ
	ZyRlA9cjqPqtV4/3icljq2qbmczGl+nc9S/KYvwJTzB60trOdVrG
X-Google-Smtp-Source: AGHT+IHdy/YIcfot4r6Fguz2Q4WkJg/6KXgRiK2fx8hzxbIa7SpS/uaRwbm+WojCSnf07Jl5+CpeGA==
X-Received: by 2002:a5d:4e0a:0:b0:33e:c97c:a24 with SMTP id p10-20020a5d4e0a000000b0033ec97c0a24mr4640163wrt.5.1713083711774;
        Sun, 14 Apr 2024 01:35:11 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id q10-20020adffeca000000b0033dd2a7167fsm8570081wrs.29.2024.04.14.01.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 01:35:11 -0700 (PDT)
Message-ID: <f4717e6c-1082-42ab-aeab-e6f2b559dd31@grimberg.me>
Date: Sun, 14 Apr 2024 11:35:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: return the error code to the
 nvmet_auth_ctrl_hash() callers
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: hare@suse.de, dwagner@suse.de, linux-nvme@lists.infradead.org
References: <20240412134154.565298-1-mlombard@redhat.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240412134154.565298-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240414_013514_048496_016081DC 
X-CRM114-Status: UNSURE (   4.61  )
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

