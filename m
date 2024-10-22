Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EF1D1CDCB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=12UXq3tuutdyAG1yGgcA+F2QChMxM3wraz9EouGIM4o=; b=RJjL0nv6McVJfr2NReBNP0eNYY
	TjOYZKCy7P78d0qUvAAS5qlpgurYT57h6b+wy5znviIbm2hUyDN47YZTgef9yrZIn6qdtPBxoAdjW
	oI+/5TXTN+GEit08YbKPo4uaZxuXmqIqbQ0qMrNv+hRx/BYOSVETth4ZzOYwFV7k1XBNgTbeR8MK9
	QJ4aO6qgt6nNvZvJ/R8JIgW2J8RQ5jP/tGW/mmG7KVzqB9Wa7gi2gHdvmvHcf6D27/Lmb0ZusDIhB
	rffqHpGEjkUYONkVE0bW1AOItzIHDXCxkmKo0jkJERq4SQLQwQNS1LDRIntDbKOs+5nTL3GaBR4y5
	nTApuNcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3BN5-0000000ANpv-1N82;
	Tue, 22 Oct 2024 09:40:11 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3B8f-0000000ALW3-2TQY
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 09:25:19 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so63343485e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 22 Oct 2024 02:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729589115; x=1730193915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12UXq3tuutdyAG1yGgcA+F2QChMxM3wraz9EouGIM4o=;
        b=FYs1lD/UheInKGpHohCOM+ENugr7zY8XR2nxiDj6ZHYNYOglIvAkp4KavXds6938hE
         QBdKzX6PyjpfgvS/JoedXAZHu2+oI7yYdI9cU3WNBbY+QSXM/UM5Ko1HIOsoPgNh8QEo
         v0KEpSpFzJcuKovC/JjrubnEVyJEYPzYMIlj0vs9yguoak84yyiYeXDme2QKJy0+6NYC
         L/KXEcR7PEXEN06uUa9D8QiMfnP+wkZ7CQ0PMM7mISO/KCIT+GqgaRnPfh/su+Jto0Qi
         hmUemlTY6Shpmc1DNgx/R9dUu8Tli4zE82zjeSGNXhu78jNvz2jhReqQbEdsyFs6wbdZ
         Icjg==
X-Forwarded-Encrypted: i=1; AJvYcCW6TOTg7UPOWesjlkhmSbc6tewN84+7Xqya2pgPbEhLXi6/Vm56az1njiA8J4AiBLTsgIbpKAD2jJON@lists.infradead.org
X-Gm-Message-State: AOJu0YxVohFbVnxrr/W2A9McLgjHOx5Le4ZIYo0trmTLya91MIJd9xzF
	2JJCwjH5k/62GRTJl9lOEnDhuhuPvqOaF7/dDXmngrMbQTswkKT/
X-Google-Smtp-Source: AGHT+IESsM6Gz/uqoew+0/iwXeECPIbqFSj/vsTgKebX4y1K1fxZknP8k5ihiUgKBR8wDgCBe78AIw==
X-Received: by 2002:a05:600c:3b1e:b0:42c:a8cb:6a5a with SMTP id 5b1f17b1804b1-43161636cd1mr164435805e9.15.1729589115136;
        Tue, 22 Oct 2024 02:25:15 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc4c7sm81482705e9.48.2024.10.22.02.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 02:25:14 -0700 (PDT)
Message-ID: <a405c7b2-18b4-406e-8c11-22dc76622fdf@grimberg.me>
Date: Tue, 22 Oct 2024 12:25:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-loop: set blocking flag
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20241017172052.2603389-1-kbusch@meta.com>
 <7846e57b-fb03-42ed-af8e-0df88cc566a4@kernel.dk>
 <ZxFRpdU-GI76uetA@kbusch-mbp.dhcp.thefacebook.com>
 <20241018051056.GC19831@lst.de>
 <64f4d599-3261-4544-90c2-4cb3e1ad96fb@grimberg.me>
 <20241022062810.GC10573@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241022062810.GC10573@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_022517_670568_567265A6 
X-CRM114-Status: GOOD (  10.62  )
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




On 22/10/2024 9:28, Christoph Hellwig wrote:
> On Mon, Oct 21, 2024 at 12:35:17AM +0300, Sagi Grimberg wrote:
>>> Let me see what I can do.
>> Note, the search is ONLY in the error case, i.e. when nsid is not found in
>> subsys->namespaces.
> Which kinda makes it worse as we use an unusual context just from
> that rare error path.
>

I'd say that introducing this search in the hot path not only for error 
cases
would be worse :)

Yes, nvme-loop was an oversight.

