Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E60CC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 04:47:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34DF20575
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 04:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="npQfIWvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34DF20575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rLdKTXpnm6IUIawyFwxw2VHJaLkxPT5/bRqjImpqvfI=; b=npQfIWvfRawfx7AvBSyZkkDTHw
	hWEOxlgBq2948MaxYAudMg2zQPtyQqbiFy9jqFMXVivVWU8NBoTMXRlLbsQzr5emR1fNg0XerK+03
	oQG24OHQohXTQL8biY3Oj7wQcWABtIDZj8SuRDEiayjdfietlciXjXyoi+XrydGxH45vjG6Yjr3iP
	EEPrl0CEh+egbJPvWcXMWumOw22YKg72cZ0lr/pCmE87Fj5r/tNEIaM9a2QTUAynhui2nX+xM1KQE
	DIgpEfQEcR1aelvk28ujXVLm3n/YzYoCOsoPz6QIRrNnHyknqO2Jr4qyvWhuPomi8dTqZc5/SNFFL
	JD5M7/XQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ5mH-0008GI-GB; Thu, 14 May 2020 04:47:25 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ5mF-0008Fc-9Q
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 04:47:24 +0000
Received: by mail-pl1-f195.google.com with SMTP id g11so715061plp.1
 for <linux-nvme@lists.infradead.org>; Wed, 13 May 2020 21:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5BZ1Q/KhNxerT2YC/bFsNN0ZMGGuYHN558e0FGkJOC8=;
 b=pg5vpM5Y+CuFO0hPBdyvaUFqueQnaqgogmtLNlG3TbAwnDDYqKgyJpsM1bgwdzrsBX
 +oXNlVGxt7hAijSSogEk/c5CMmjOuitbFoxIon8JpC+OHFi51tIHKVVYWprWV/f+rVTh
 2oiRKcxw2tvTfqSMpxOFG7dEVvN0M1fLLW4AcTCJOYJ6ZrzHgtEJRv59v3cFTX4eCU7l
 F5XEHAP4FCFjMeDiJ0qURMpfmMfj1Zuh656HiRS/n7kFJUF7JTO1X9ZtrTTR4qTbnnKr
 mfq6v08fLe2iZ8H814sUNu9a3MdHTqSNgMjE9d80hyv9/MjzwiTF8xPje4yCwUxvKnM/
 LJjw==
X-Gm-Message-State: AGi0PuZLhWdBjOwRry8U1FcsYGxMpPz3mXKlOg08gXIBImmoVJpOyy72
 X5EuBh86Wn3jFneDHL2v5oE=
X-Google-Smtp-Source: APiQypJKF93ksHvPzFbEGQnY0/hVrr9X7gKYHN77OIFajn1gbqa4od0+EorYJiM/crjOE3Hq55Fekw==
X-Received: by 2002:a17:90a:d78e:: with SMTP id
 z14mr38691419pju.125.1589431639471; 
 Wed, 13 May 2020 21:47:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:89b0:7138:eb9:79bf?
 ([2601:647:4000:d7:89b0:7138:eb9:79bf])
 by smtp.gmail.com with ESMTPSA id f76sm1013718pfa.167.2020.05.13.21.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 21:47:18 -0700 (PDT)
Subject: Re: [PATCH] nvme: Fix io_opt limit setting
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>
References: <20200514015452.1055278-1-damien.lemoal@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <fed0df8c-3005-fbdd-c413-06fd7d174dee@acm.org>
Date: Wed, 13 May 2020 21:47:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514015452.1055278-1-damien.lemoal@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_214723_328629_A394B249 
X-CRM114-Status: GOOD (  12.88  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020-05-13 18:54, Damien Le Moal wrote:
> @@ -1848,7 +1847,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	 */
>  	blk_queue_physical_block_size(disk->queue, min(phys_bs, atomic_bs));
>  	blk_queue_io_min(disk->queue, phys_bs);
> -	blk_queue_io_opt(disk->queue, io_opt);
> +	if (io_opt)
> +		blk_queue_io_opt(disk->queue, io_opt);

The above change looks confusing to me. We want the NVMe driver to set
io_opt, so why only call blk_queue_io_opt() if io_opt != 0? That means
that the io_opt value will be left to any value set by the block layer
core if io_opt == 0 instead of properly being set to zero.

Thanks,

Bart.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
