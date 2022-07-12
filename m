Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69063C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jul 2022 20:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i44WgiLhEQpL2L8I1eN0xvDidyFTyh3H4rXwJnmjusA=; b=E332Hc1xiygx1ureSKOFKrH84f
	iTvrwmRgg4NsrSq1ufriSv64Pxh+LPFFVy8Wlk8cqK2DiszP7o4nwoitUhBUgXsbiVbAlR8zNzRf0
	1XT5UnHnTPfrgwq7ufuOneZR8A8hR5+S7r6lb5Ou5n5kV1HfKKIjCTxK4FpTfDUZqe8+DxEtySzPY
	cDMn/WA7acIArdS+l6Pv1BWNDobBYdmCMqcCzyNcE14ma9X/dke9f223GBwYvxYcfIMoFk8DkEpOY
	dvBX8HtrlcMyIeMIU12yJIKUJL1WI1gdycekxfQFy+rm27CVDHM2WQNKyIGrsfZjrM5u2x8ApSpyE
	iKcSwouA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBMGm-00ESoE-4b; Tue, 12 Jul 2022 20:14:08 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBMGj-00ESlY-UB
	for linux-nvme@lists.infradead.org; Tue, 12 Jul 2022 20:14:07 +0000
Received: by mail-wr1-f52.google.com with SMTP id o4so12719695wrh.3
        for <linux-nvme@lists.infradead.org>; Tue, 12 Jul 2022 13:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i44WgiLhEQpL2L8I1eN0xvDidyFTyh3H4rXwJnmjusA=;
        b=FCAhVxK2MAixhQi8EvjuL26sb3TJwHLkzU/gWqaNQTqiQ/MC4J/tRKw6hNUyaFXQXl
         wBiqSRJqcXEyX3ZzaT8dAXxqTg4m5gVr1/w4PiJK910xJFUiD9I+H0QfWBKm4LR0qcKF
         WggdXlnl5eXKUIx7tHU+INf4ebAyvCXhBXD9dv+owpX3nShvg2SZ4pezAp9Hhp6nZ3kM
         JxSPJn76B2O2vTspwGWiR6pq2K0648TuUrWquWc5DrmBvz0F1dlgXMJlOUtGh2kobKrX
         ZiZNakcbKqj7AEOxyAQWlZIINgq2J/6FcTvvA3W4s1fQacWYfWPam5WdsWDyttolVpAh
         vwSQ==
X-Gm-Message-State: AJIora9PfNkl1RAZ7fhA0HW1kIfeJHCXkt/PYoR9a9WXbb+axNnn9OJs
	v2wFlpA0mcAjsjDaNgyU1w8=
X-Google-Smtp-Source: AGRyM1s2AXD5tSZHdhk70dkHduOPy8P8nujvoI7SI2uNkAjYundFhC3fqCftHzf55G2bv5Dopht+9w==
X-Received: by 2002:adf:facc:0:b0:21d:8c8f:4b51 with SMTP id a12-20020adffacc000000b0021d8c8f4b51mr23123290wrs.307.1657656839604;
        Tue, 12 Jul 2022 13:13:59 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id q6-20020a1cf306000000b003a033177655sm13617110wmq.29.2022.07.12.13.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 13:13:59 -0700 (PDT)
Message-ID: <436c8875-5a99-4328-80ac-6a5aef7f16f4@grimberg.me>
Date: Tue, 12 Jul 2022 23:13:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 4/4] nvme-multipath: add multipathing for
 uring-passthrough commands
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 asml.silence@gmail.com, joshiiitr@gmail.com, anuj20.g@samsung.com,
 gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110827epcas5p3fd81f142f55ca3048abc38a9ef0d0089@epcas5p3.samsung.com>
 <20220711110155.649153-5-joshi.k@samsung.com> <20220712065250.GA6574@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220712065250.GA6574@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220712_131405_998529_5A77AD87 
X-CRM114-Status: GOOD (  19.83  )
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


> Hmm, I'm a little confused on what this is trying to archive.
> 
> The io_uring passthrough already does support multipathing, it picks
> an available path in nvme_ns_head_chr_uring_cmd and uses that.
> 
> What this does is adding support for requeing on failure or the
> lack of an available path.  Which very strongly is against our
> passthrough philosophy both in SCSI and NVMe where error handling
> is left entirely to the userspace program issuing the I/O.
> 
> So this does radically change behavior in a very unexpected way.
> Why?

I think the difference from scsi-generic and controller nvme passthru is
that this is a mpath device node (or mpath chardev). This is why I think
that users would expect that it would have equivalent multipath
capabilities (i.e. failover).

In general, I think that uring passthru as an alternative I/O interface
and as such needs to be able to failover. If this is not expected from
the interface, then why are we exposing a chardev for the mpath device
node? why not only the bottom namespaces?

I can't really imagine a user that would use uring passthru and
when it gets an error completion, would then try to reconcile if there
is an available path (from sysfs?), and submitting it again in hope that
an available path is selected by the driver (without really being able
to control any of this)...

Maybe I'm wrong, but it looks like an awkward interface to operate on a
multipath device node, but implement failover yourself, based on some
information that is not necessarily in-sync with the driver.

