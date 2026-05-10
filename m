Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAF7CD37B2
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 22:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7TT88Obqx1AJAzXu0jcEZD6MoC4AHPr3xtkjAGFDve0=; b=xqjS1yW/NWWwFEDXiFtY9p0xx3
	R4IxZPuDc3e0pkfI97v+wloTFQOdpeOKaWccjhj2cFr6W9NPfTsmxhJ8xtV0lqA2//bX7Emdxsd7Q
	qCxXBdlmT2H+yeXqaENDf5mI9JimFZSUCuY7nG5k5ZLgLaXkFLVMCLML0y+60llIDbyDEr8uDhslG
	s76mcwdhWUjvr7Btwc1i2dy9dNyRr1FYpNydnGoZ6p918ZxMbNt4cgKlsgdvoNM7hv1dinQuMZ3eg
	hEU930dGOZVhA7KBnC4viMCGfixuc9ycsBYBniWmT+v3MeBIrFe9tTtEdgXh5peMRjaapetUFiMCr
	ZoMBsokQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCF5-0000000BiVv-20VF;
	Sun, 10 May 2026 22:03:19 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCF2-0000000BiV5-1nRP
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 22:03:17 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891f625344so35201875e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 15:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778450594; x=1779055394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TT88Obqx1AJAzXu0jcEZD6MoC4AHPr3xtkjAGFDve0=;
        b=a+3vv+OGpF0zm6zuQbEFYXlPcmBL1UP29YsS3PRrx40TOS9oJtM3kRQqN7HcYpYme/
         aBuM198nLuumzi0sjUe0UCIbhZfql3aJZ2wagnzOgx12NSsNakp6UoOQ7sjrYHzQKLtm
         1AOwP8mHncgmprsnYp8d5BCuwtjAPb8pZZ3Q4pti1Zu0CAq989lPFeUYu1oVQ8oidcrz
         XelUbL45kAas7MqXQyo2fguGgwjLtz2cFhxyki0R1nF5uVCGX2B9S7bEI1SKHGPTyHLf
         Jt8JjwioY3E7vWQa73XudWWhPExd3nyK5JMPUGpHpeUmGwRidpLd6zZNEynD6IQJwLW9
         hErg==
X-Forwarded-Encrypted: i=1; AFNElJ+ebXDkQlgcrv1RE9jVA4R8OY9RRDnsIyebWiwanlY6nbNX+sj4y/N1s3YQe8FxDeCiHBeubxjBtSBL@lists.infradead.org
X-Gm-Message-State: AOJu0YwJIyzMCR/gQR9JYxyhuLqZwK54jzcbwVy8M0YQvFdSvfd4ScJZ
	4s0af16tWHjqi7G0UtLDAytHE8TFx2EAf7ISfaWWtBEHlHSYiljj9uAP
X-Gm-Gg: Acq92OGQw7CG/GnuujOEMk+YDt9OgQjqefdJRlpiR5FIgCXnXcFyVRpcTFSyRGLhWpF
	O7zE7hVmgkIcdPiTqN6rS3lH6mwcfxkrrKd8LPXrdat00KaJ+EQUH5KDE5nIkYPazEMlmdM53Fn
	0eLPWizv+3lL3HtXeL66ztIgdFXkgfBuMtWk5d72pbFq6uSn//m4AEUebNtjGJffZ0fD9F01YuZ
	aMFYqfnBfu8dPPo4o6t6C+iLtTzl5dqXSjoPbc/IFAxZbYXX/ilP2ssnOVS48JLjOzSTjhr8w5U
	iQbWhGd7+wpTgX8gFyjtvUxe+AllPiCkik5O8ZmwVD3TepYn4RPiH/01WnwqdBcVaQusXvazOWG
	ltd/lDj+YQi42euB+Yf1eDu4Kpxe4VZr+2HYck/oHsG2uLd5ius/t2sUvmKXcEbjZP1Bsn5B/wV
	qq/mXmG7WyTP8zetNz6Bo=
X-Received: by 2002:a05:600c:570d:b0:48a:5236:7f38 with SMTP id 5b1f17b1804b1-48e5dfffademr189351075e9.14.1778450594444;
        Sun, 10 May 2026 15:03:14 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491304505sm21071533f8f.22.2026.05.10.15.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 15:03:13 -0700 (PDT)
Message-ID: <ad0a1191-4928-4700-8c55-4c844a7058e3@grimberg.me>
Date: Mon, 11 May 2026 01:03:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] libmultipath: a generic multipath lib for block
 drivers
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, martin.petersen@oracle.com,
 james.bottomley@hansenpartnership.com, hare@suse.com, bmarzins@redhat.com,
 nilay@linux.ibm.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, michael.christie@oracle.com, snitzer@kernel.org,
 dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260428111105.1778008-1-john.g.garry@oracle.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260428111105.1778008-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_150316_477669_EB653827 
X-CRM114-Status: GOOD (  15.16  )
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



On 28/04/2026 14:10, John Garry wrote:
> libmultipath: a generic multipath lib for block drivers

This is very nice John.

>
> This series introduces libmultipath. It is essentially a refactoring of
> NVME multipath support, so we can have a common library to also support
> native SCSI multipath.
>
> Much of the code is taken directly from the NVMe multipath code. However,
> NVMe specifics are removed. A template structure is provided so the driver
> may provide callbacks for driver specifics, like ANA support for NVMe.
>
> Important new structures introduced include:
>
> - mpath_head
> These contain much of the multipath-specific functionality from
> nvme_ns_head, including a pointer to the gendisk structure and
> a path SRCU-based array.

I think it should be placed first in its parent struct as it holds the 
hot-path
head->srcu and head->list.

>
> - mpath_device
> This is the per-path structure, and contains much the same
> multipath-specific functionality in nvme_ns
>
> libmultipath provides functionality for path management, path selection,
> data path, and failover handling.
>
> Since the NVMe driver has some code in the sysfs and ioctl handling
> which iterate all multipath NSes, functions like mpath_call_for_device()
> are added to do the same per-path iteration.

very nice, overall seems fairly straight forward.

