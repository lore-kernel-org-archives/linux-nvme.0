Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FA5CD3427
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 22:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bRIkp6GQnKkncwfKRmT7g/9aqFTNjkOojntoK/B6eTA=; b=sMlEg25q3YxCC6CeYer9pMQYuk
	0zNDV3l+azssgskRQxWMNL86oULI3j1Wy9Uzn8krkJHsjr+aCmI+EKB5XvSidAJoUwAuCGord0qp6
	swzGen32pSR4mJ0dS+uUBpwAxSG0ijX2cVgQ1rSjSuOu5EMxma7ogxyVlhF5ZHT9gMQNpgiRlGNG5
	xWu5REqoT6mIWVb8otK6LEXTxAp7yycOqmybCQ6EAoGdYFjH/iRw9LydwZxfLdEC4eCOdxlpJdvLt
	MPzuxms74D0UH/Yvt+JzMx3WQLfPyI9OkwfOn/R2dtwZrC6DGhsye8hYlQDXHuUPvsBx4++Kit6HL
	sl5b/hrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCjW-0000000Blek-1jwO;
	Sun, 10 May 2026 22:34:46 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCjU-0000000BleH-24yy
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 22:34:45 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48d146705b4so45890115e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 15:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778452483; x=1779057283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRIkp6GQnKkncwfKRmT7g/9aqFTNjkOojntoK/B6eTA=;
        b=eSvcTYBXQTbXR6kv0P/dcUj8PfOnN4H47wjy6eW2vwwkcSBLAGIC/sDnp9pNYepNx6
         m/mIoU72gb3UdnBBeYNnO08J2g8mzL57lgqP5Z3Jry4aQ9Vt1XZ4oVPzUhnMaNc6hh9M
         8oqBK9Mzl26+HoqeW1SUxMzEwU9kwobKH3Hc5puG0xmAl6DPePpfD/V/uJolNKCWz8Be
         6vb96bKaFMiw+IIADQMGqn2CZlj+ylRhLvmvLGuPQ0LI31CahhZWTk/qSVCpt8HqBBm2
         OJvi5QBhxUEa5Jhk69O9QV8prtDd55DJI5zGXQY7NYY9nISIgzSiBwH0+md9q7+b0Aav
         nZUw==
X-Forwarded-Encrypted: i=1; AFNElJ867IqoP56PjaOMySJ/3/N99kngaErKJM2mj2aJIopiG69mziyA6wpvlw16HM3bVLkGM0Sjld00zjC2@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3Ha9NdLwLc7AI9aOvm1LRuQiT7NkDJHKH+D4l9+oqtERp9Cmr
	6eS6bu/oNaJbBn2P8P6o6paxoF6GLjRK5RUKx48+e82QW6tDIf7W4z2S
X-Gm-Gg: Acq92OFYEsculfKucY3cAWMNTXtS4bexqguFCZCEIjUA29UFfsf+O/BQNVF7+bNflfh
	9QSaOrfSMs7rPK9O8N6QdwRP7WdKfY8qOj8cDDkM+UNZjnOFeVDtbAlVBUDsWx/S+/wLWhaZk+3
	1hapKGzJvCPOQcXgOn5LKP3Unb5UGiFr2aaJxaasMWvc4x26I/f3IBTEVPALXpcMeSzPWe76zQH
	KNUoD5+J8oNnkEppSotei0w/dM7byscZov0cuQ7LSQDcZ0UQiFQst7u+nlHr5nqkMR0WdECiMaZ
	TcZuAOOJsrizB+glbxxqmXbi1sLZvASxLTBY50znPv+jgrITg/bSN+b1+YDjNd/iXZSYoK9Gn7Z
	Ypi9XT0G4kCyEyPE7pePB8gbk3Ln0S+8hJrcIxyeqm40HZbOQf4pxR08hdabkfyMBsRxR9nY01D
	WsmEmmQECPPWwVxJg/SIE=
X-Received: by 2002:a05:600c:c11c:b0:488:9e54:94c0 with SMTP id 5b1f17b1804b1-48e51f2a79bmr252623065e9.8.1778452482587;
        Sun, 10 May 2026 15:34:42 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491da03a7sm21230098f8f.33.2026.05.10.15.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 15:34:42 -0700 (PDT)
Message-ID: <94f23fce-c968-478c-ae88-c3286d644eb7@grimberg.me>
Date: Mon, 11 May 2026 01:34:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] nvme-cli: add nvme top command for real-time
 monitoring
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
 gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
References: <20260430105234.1172446-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260430105234.1172446-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_153444_566611_1359FD91 
X-CRM114-Status: GOOD (  16.75  )
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



On 30/04/2026 13:52, Nilay Shroff wrote:
> Hi,
>
> Monitoring NVMe devices and paths in production is currently limited to
> static snapshots via nvme-cli. While this is sufficient for basic
> inspection, it is not ideal for NVMe-oF (fabrics) deployments where path
> conditions can change dynamically due to varying network latency,
> congestion, or link failures.
>
> In multipath environments, administrators often need continuous
> visibility into path state, ANA status, queue depth, link speed, and
> error counters. Today, this typically requires repeatedly invoking
> commands or relying on ad-hoc tooling, making it harder to quickly
> identify issues.
>
> This patch series introduces "nvme top", a tool for real-time monitoring
> of NVMe devices and fabrics paths, similar in spirit to tools such as
> top or iotop. The goal is to provide a continuously updating view of
> device and path health, enabling faster detection of link degradation,
> multipath imbalances, and transient failures.
>
> The series first adds the necessary building blocks for supporting a
> top-like dashboard. The initial patches extend the table APIs (including
> support for additional data types such as unsigned, long, float, and
> double) and introduce a generic dashboard framework. The final patch
> adds the nvme top command built on top of this framework.
>
> Future work:
> - Export NVMe statistics to external monitoring systems (e.g. Grafana).
> - Improve topology change detection in multipath configurations. The
>    current implementation relies on kobject uevents for topology change,
>    but namespace path add/delete events are not exported by the kernel
>    since they are associated with hidden gendisk kobjects. This may
>    require explicit uevent generation from the NVMe driver for namespace
>    path changes.
> - Wire nvme top into an MCP pipeline and feed it to an LLM

Nice, However I think that the traddr information is missing. Often the 
network
has some routing issues for specific IP. This tool show this.

