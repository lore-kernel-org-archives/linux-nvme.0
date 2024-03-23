Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F6EC54E58
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Mar 2024 20:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uip9BOzYq8GHQqwmzh2hZsRZFW6EkFXo6JPhnU1bx9Q=; b=r70uzhg1VCOWJAaTybcSelXNzJ
	5Pi82nN0UlQF7NP3iKaiN4V6jMrfqfqm0gLTFnhY+1P/hGguv8EiEVLrjW3m1zSdVR9wdHXy6/Dun
	HG3VlSg6ythgKAEhGVZlduNn5D0WMn7VQMdcBftS6JkvpJCm4oGhU+90YtsMAsZNwo6ebPmiH9wzA
	+Nv494/JIuPWlft3+kZyJiOFcu3j+pjkCud+EofL8adAvs9e6q9rqJXpYX33scmxXsDMTb74vowAG
	dkKRsuSw+zpfU2cSonrAnW3qopwPf1eILwHrxfr5+1wsGxLxqp7x1WnxjhyqmocyLb59VhzGS5JrP
	6A6Yr2JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro7vt-0000000B6Qn-0ne9;
	Sat, 23 Mar 2024 20:25:37 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro7vl-0000000B6Pu-12J7
	for linux-nvme@lists.infradead.org;
	Sat, 23 Mar 2024 20:25:32 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-341bba83366so347788f8f.1
        for <linux-nvme@lists.infradead.org>; Sat, 23 Mar 2024 13:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711225523; x=1711830323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uip9BOzYq8GHQqwmzh2hZsRZFW6EkFXo6JPhnU1bx9Q=;
        b=JUYCi9eVH9VzfgDd827/mJUyHitNnlaODLz/ldV036tFXbWFDodHaV5ZCnWLz/9f7/
         B6M+5w8bk/+LNtE3VxshPQPeBFXrEyQxGwacEyoQJ1lwX28FOfc2Au4YBh0xVSQSGWmn
         zABFPy7a51Bonpb7+oNBx2pRhj7Zs/WEM7QyF032RxOZ6A3WFNoaU5lfauCdjkR8Cfug
         6k7iIl4hautCs7xd6qZZIOGbqiWXjCJqLzb5fJzfVf2YCaRKZKNu5Q+0YvqK0Gryt67N
         LIPj+Y1oWOUrGLCAKQu8wPBFeFkmWyOkbd2hOdTHm+pz3S65zn17Khn7dUippXKq1Dd4
         4SDg==
X-Forwarded-Encrypted: i=1; AJvYcCXYaHRGFrLGOszVFrMOQtDPbtqeb02b13zKW6SkUntr3RUuV0o6pAJ4sudx9lR3BLyd4IoVLORYad+EtyOUuOeBO1IEynGHEq83RLnBkQk=
X-Gm-Message-State: AOJu0Yz2VIVjp48ahEK0/RMDIsW6HlAB6ApzkJDNJmL/fpnV7lWbtkcX
	Eak4vGlmCd0SuqSQ58MclSrRwINCwnSy7Z6Ye+DS5OjGXWZKLWE8
X-Google-Smtp-Source: AGHT+IH0bCtVEGqEnIFh3psaJvAYwo4HxMu6DyPNsZu3CW7BES4LcmXLqJRtFqekNaN7U4jrLaCimg==
X-Received: by 2002:a05:600c:4f15:b0:414:81f4:b756 with SMTP id l21-20020a05600c4f1500b0041481f4b756mr1363571wmq.2.1711225523052;
        Sat, 23 Mar 2024 13:25:23 -0700 (PDT)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id q20-20020a05600c46d400b004132ae838absm3353327wmo.43.2024.03.23.13.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 13:25:22 -0700 (PDT)
Message-ID: <0e5f59ee-9ec0-4abe-bd57-ec3fe3d1b27e@grimberg.me>
Date: Sat, 23 Mar 2024 22:25:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] nvmet: add debugfs support
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
References: <20240322070333.3820-1-hare@kernel.org>
 <20240322070333.3820-2-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240322070333.3820-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240323_132529_352295_432B80DE 
X-CRM114-Status: UNSURE (   9.74  )
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

> +int nvmet_debugfs_subsys_setup(struct nvmet_subsys *subsys)
> +{
> +	int ret = 0;
> +
> +	subsys->debugfs_dir = debugfs_create_dir(subsys->subsysnqn,
> +						 nvmet_debugfs);
> +	if (IS_ERR(subsys->debugfs_dir)) {
> +		ret = PTR_ERR(subsys->debugfs_dir);
> +		subsys->debugfs_dir = NULL;
> +	}
> +	return ret;
> +}
> +
> +void nvmet_debugfs_subsys_free(struct nvmet_subsys *subsys)
> +{
> +	debugfs_remove_recursive(subsys->debugfs_dir);
> +}

The subsys setup/free look trivial enough to just open-code
in the call-sites.

The rest looks fine to me.

