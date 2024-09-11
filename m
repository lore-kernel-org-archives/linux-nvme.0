Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECFBEE4995
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 11:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EVHMJxX7bIJ1gFg2WEvfMYI4EW1ys1yqjwgKzj2K/yw=; b=2d8WsUWLyaPAKnupALat7scX26
	EZu01dZtRL/lYDP9JLDYWthZ7NzpvFjRqULA4sNbT7viJekGpb7f48wS2VnJmxqvRU6nyML+tgCC/
	mZN3cYEczbQ+ZU8qBO8E3q+XWfHdpwMeXkRGLtwXdSyY+sbevXMPhGphukQtzJNF+vYaalr/0UZ7Z
	W3SdsaA2HEMJf+tuWSu8gRIFNbjQ2/Gadu6YQO6P2TEWQxWz5xX+t7MR6c254sQr24tRONcemoSvi
	avlJM/sNhlQ4Ce5TPspF5nzA2oLC8FISzmmtCkAiVEMz3/cuEP731SPcV1O75iGJzc70bG4z70Ijy
	9wu/RYaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soLWS-00000009ICm-3FK1;
	Wed, 11 Sep 2024 11:28:32 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soLSX-00000009HQB-3xn7
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 11:24:31 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374c1120a32so1323855f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 04:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726053868; x=1726658668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVHMJxX7bIJ1gFg2WEvfMYI4EW1ys1yqjwgKzj2K/yw=;
        b=jFoaDmihC4wl8A96CxXatlFDygVNgNQyE4rzxHipBWw5aC5x9nEYvUfgs47ovAnGYq
         breQVixHcrrzr/paFWwqt+3RjMOB8Hk+J0eAOBcd5bcPfVCeZDyIDvxp111UUaFDsMd1
         pfQ8Wp3BLKoyOhCvHuhZKS/fImW8HYOpUBNKoYeIsmg9k5cxXLxZFE2ymgX4FD7/Wsa6
         RGYRuOcViqAhZVkLR6Cxj3J4nEwk3HFkiLhf51a295EjKIzYJ/NzIg/D/bBOTNPDOpqJ
         BipGm5/IRfaxFYCIsoHBFoEAEJrKTIqu0sTM29f16LUavTNRQrea3w32d4k1DsTXSHwd
         LJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNMulU9oByo8MGY23AHQ3oUN+2qRv6MdGXgMbbWfz3Kulo87/nxkp54kTVC5xSG9mewkN753IvA9jk@lists.infradead.org
X-Gm-Message-State: AOJu0YyVoAV9bfj70MOxndSHGMI9cNSaZdz/FwaIWZwcYwnpZxH+APAH
	KuvUmZujBP7FrN6yotGqMeuo8zev9nv9QbRhVvMZ5TD2yq7e4CJd
X-Google-Smtp-Source: AGHT+IHCx4FL+6FX1yvGYqERxy/P74eKSOTP2PVMCzKQQZXcqa3cMiGRVHVQM778uV2Ve5x6am2zGw==
X-Received: by 2002:a5d:4907:0:b0:377:284d:9946 with SMTP id ffacd0b85a97d-378b07c8664mr1855115f8f.30.1726053866692;
        Wed, 11 Sep 2024 04:24:26 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d372dsm11309194f8f.73.2024.09.11.04.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 04:24:26 -0700 (PDT)
Message-ID: <9b8b7d54-8716-4449-8497-149dcc62ae77@grimberg.me>
Date: Wed, 11 Sep 2024 14:24:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-multipath: skip inaccessible paths during
 partition scan
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240911095107.121688-1-hare@kernel.org>
 <20240911095107.121688-4-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240911095107.121688-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_042430_018650_16ECC70B 
X-CRM114-Status: GOOD (  16.15  )
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

Hannes, if this patch fixes a bug, please phrase the title to reflect that.


On 11/09/2024 12:51, Hannes Reinecke wrote:
> When a path is switched to 'inaccessible' during partition scan
> triggered via device_add_disk() and we only have one path the
> system will be stuck as nvme_available_path() will always return
> 'true'. So I/O will never be completed and the system is stuck
> in device_add_disk().
> This patch introduces a flag NVME_NSHEAD_DISABLE_QUEUEING to
> cause nvme_available_path() to always return NULL, and with
> that I/O to be failed if all paths are unavailable.

So what will happen if a new device comes along, and the first
path it connects to is 'inaccessible'? What will scan partitions?

I don't think that this approach is the right one.
Effectively, there is a semantic decision here, is 'inaccessible' a
temporary state or not, if it is we should queue IO knowing that
it may change in the future, and if not, we should fail it.

ANA inaccessible is semantically temporary. Its just that your test
treats it as permanent. For this case you have fast_io_fail_tmo, which is
designed to give up also in cases where there is hope that any path will
become online in the future.

I do agree that if the user disconnects the last path, should it be 
inaccessible
or not, it should succeed, and cause the queued IO to fail immediately.

