Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E1DD111A8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 22:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=vKFHsYG5K1isCiaVI+O5iXUyfP
	x+LlD1R8e55GtD2dPmWgdcyPRQz2J5OzGZIA+6LO/ZCw1Z7xm45n9SKEbcCBbFO/xKOIPKEtsHqY+
	jJGL2kjWmhe0pa8SqGsb8u+EkwnVdR9W0gN6dGm9FvdH68dmRX2NliHlUNa18YnTT1sVv8jt0T0ta
	K1p34gacOwN6+SLTBQEfnTj5MTnF2jJHqmMLGHCLj690bziYwoiB4TAlIOuMDngTHFFvMlrY1rkGd
	0eyr7BlMoS1Ee4e/bi4jtLPf/U54JOCJmNeov3QGnu6FMxk/PbpxyyZhbLn6bw+d8zQl3l96F2DRj
	2vOtPSsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpnu-00000002ckz-16yP;
	Sun, 30 Nov 2025 22:22:02 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpnr-00000002ckW-2Wkv
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 22:22:00 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477a1c28778so40371455e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 14:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764541318; x=1765146118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=o/ATvIbiCTC8XNzdW0gEyuTyf7SEOIKEBZZcTXHL81p1zkTVMgaTFTMKhMIUHuZVbN
         r/0m48PZZgAPMOOEMguFeVg5x/tdXyc+xAqkiMdg1FpAbzhWXwZitPM1yhdt76EA3qOh
         jfG0uTcTL8mJGxvfGYRKFb/QZEpPORo81DBJP+kh6f3EcNrqbvWysbL4WWFbEPtp//nj
         dkgdksQjyquGV71P7HQaKG7ttnqb3tpC5dNGJeQHGSywAtjEk+Sm61Zs7I4dylBMezh2
         xSYu8mGCZqIwXkx6TIIdrJfC3SflF0NyCY0YHg7x8dChPqJnnFG7pta6opraJ3BOpnWk
         65BA==
X-Forwarded-Encrypted: i=1; AJvYcCVhHHxw7hDKTGoQ8Tb9wMrPoesNc2KX3npXOhAsQq0/ZWKuG2aXeS3u44Qx9GdXfaUkHuNuc3LElv68@lists.infradead.org
X-Gm-Message-State: AOJu0YzLswVaKvPZC5Nde7DsPfGIkaJS5mdfGFxAeuHaZKCYBhVzbs2I
	VoJGy+2nZplXRfqoALtUM5RjLQCGH4TeSezfFQY4iA4fjZrauJV3Izdo
X-Gm-Gg: ASbGncv/54zL0CzW4qalUx1pC160h/isfoljMiFioL8H+xd4WlFy8fPnXHz/LsXPLwq
	/EG42ZG0vGWTlkqePPZZgAAD1HpXZuDb36c6wvBh1WqNs5JG0xpM1Gex1tGzx0OJr6hS/ACH3O+
	sgAq/p4K5v+Lm8YfCUiXZIeBBEcrkZMhPkSygYuES4owrIiU5X/+Gd3NfOJZ4gSMTABNWsTWMkn
	40uyJHylL7OZ8d3MUlOisv5UCUlr6sZ14Safoq4PzGAOG2jnmzsUlXQ/y18YzzpOuK738fEqPwO
	TlBmqVW0Ft2vuzVHCM5idcVDT69iXKNglmxw3220/SGtRtePFEnqT+rlhQs8TDz4GLEluznYvZg
	JASurmnCfTd6ZvYXi4SDugNm0z0BYijT6lKyyYu0Eb5sCOaYTICugjQOeDzS8DUzG5RcLcCSztd
	AQbItx/CqNtvreoGITjwPb20F0J/b+0sKjR06Fh7VU
X-Google-Smtp-Source: AGHT+IEaDq7D6ajMDVwbhmEysEzsY+1ogXGwoywM0VuEEVuoRMtFYjkQRVWQHiyxGuNw2ezMfnKldQ==
X-Received: by 2002:a05:600c:1c1b:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-47904aebebdmr256111855e9.14.1764541317764;
        Sun, 30 Nov 2025 14:21:57 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790530f0a4sm142367985e9.8.2025.11.30.14.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 14:21:57 -0800 (PST)
Message-ID: <93c631e9-a07e-4293-a59e-81be85270687@grimberg.me>
Date: Mon, 1 Dec 2025 00:21:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] net/handshake: Store the key serial number on
 completion
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, kch@nvidia.com,
 hare@suse.de, Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-2-alistair.francis@wdc.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251112042720.3695972-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_142159_638587_329A3FA0 
X-CRM114-Status: UNSURE (   4.29  )
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

