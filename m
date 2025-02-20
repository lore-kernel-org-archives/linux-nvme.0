Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D128C021B1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 10:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=tmyLu0PNCo6lEDCSaT8eZrQGiL
	h4DI/w+38Ak/STJHXgIR19JZkh1shzifX9/yqfxweDyP8nSJhDVR1QqVCrq7N5++QO5wAS+q0xjIg
	Jvxr6a3s6oL5vpzig8v7g54l26PNq7XT4WcqkN2losRoV/0WhJ5ULa7eWIMPLWegBCi+Mfs6NwWir
	Jsr7MBZxOZ+18QjpyUVFLEueomqi2bTFsxFRXaOAkQikepuCbAPKqEklfqI9Ii/nzv7k6/XdSpJ8B
	WtE53GTBsNm4SZiZ9IGDqfiTSYv+uvYh5Z/9zLnoAoZvixJf6fGahIsyITTzobkZKpS/NWeleQBdp
	7iS2vY/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl3uT-00000000Jsi-1Ebb;
	Thu, 20 Feb 2025 10:36:01 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl3tD-00000000JaR-2DkS
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 10:34:44 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439946a49e1so4568775e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 20 Feb 2025 02:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740047681; x=1740652481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=JZhBictiUJ4CvK+Mhb7WYH1Qm6B8N+K7FcELFC9+0+ME5eo3M54Sz96l+YK2GJRX4f
         TIdiwCLgCSqOk5KyAISdacXasiXEKtOKUiR7QZfeC3OjWVUE0NxSa8H7xndJhYr5ue8O
         tl6590HIlEFvPJUxPQyFvhhyHYfrHGRJGh58ruTWF2QETLAmEJ1XnhM2sGw/iL1+X8sA
         YXGjKUwdJ2RwBNQoREdOs8cJqhZJH+tOLvzoP3WBb6mJGWUyjkgxfKew8XelE1sqDZdM
         QtuyhnQh7+Gh3b+PbY8KXw0FEBm+Hj+Hxh5e49SYMsHEJgZ18PMADXxjMJbIkoK6xBq9
         74FA==
X-Gm-Message-State: AOJu0Yzr7KLZ3PCmAIfFwzC+gkklZdX/xkauVFmY/eZpbklorQ14PKHf
	L4NURLydM7NOlQcGugkdE931Cc4R+qLRm3zo4JmWHGMxYcsWbNXv
X-Gm-Gg: ASbGncuMn2cuYSDijrZFOOfopyKcnlGpzoKtnafcPfhiomGTEirxFjNIGkA/uWacN88
	PW3Sf1ArDYiWMCYLtdFyiHhtGbUPGEKuM5kMpVGwANbSTJdM72hotFFkK7RWtIK7WTBsXJ16xAE
	QAaSKijhs+S66cqkaC85ztA06uupyVNT8TRUy9BLNzBTIALerLAWijBqP7x+eFh9pr2jVJZwSuz
	nqpOq6yCy+Ak5W/HRKSnt252gbOcEniLO4QWLJMhxNLguJgVca9qNmPHNrMdN7OHYEgBYQaGJZa
	otuyq6VK7gPPnYZFVwCfFM8yPmT+I34bp7FVqGDNF4Oo5tARWqI=
X-Google-Smtp-Source: AGHT+IG1XAERjlZeolfku4uzfm5PyTJpsYEZeMXgZnFNEAIQaTE8DD6o7lsFxTSvy9r9GAQad0NT5w==
X-Received: by 2002:a05:600c:474a:b0:439:8a8c:d3ca with SMTP id 5b1f17b1804b1-43999ddb1c0mr71908265e9.29.1740047680846;
        Thu, 20 Feb 2025 02:34:40 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43991c84fa4sm83526555e9.39.2025.02.20.02.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 02:34:40 -0800 (PST)
Message-ID: <d10b5bdc-147f-4d72-a47d-b7a5f5cdda40@grimberg.me>
Date: Thu, 20 Feb 2025 12:34:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_023443_662420_13217026 
X-CRM114-Status: UNSURE (   6.90  )
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

