Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00185C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 13:55:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDC1205CB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 13:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UxQFHfMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDC1205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mG9uAbAn4wMCK/q7HfzeWu4udM7u5VqnZPnn3Rz6qTw=; b=UxQFHfMluLEAD9
	XkkB2T0tdEzUqQmpQdS+YcEr2ghR0aZz4Katzyplp3wcQxQQ66OBDGrsB+OUKw8S7S9WrCK/R8URQ
	HzHPKKD1sPnW0qJXDM7S5TqPEudVoJAKE5zj4SO9I9n36iRo257jY3KwwJcxSpynyCSGifknJr9Ci
	16ik5l3ZLgh/aRC3yDxD5AsXtgxz5kNyxNAZoLWP/b+4jZSnP+uGp4vdflLuYeEGzJFu7O+fjRqrZ
	2QiC4ue/rOujXwbSNvtUuJdEMyHOWRfDuLZ3Oxz01y7rnM3aYl6yW2AfdixOI8b7ee7z62BG3Vmo0
	kfDsHJdj4qNv4Ak3UWzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZEKH-0002ak-3Y; Thu, 14 May 2020 13:55:05 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZEKD-0001vl-I0
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 13:55:02 +0000
Received: by mail-pl1-f194.google.com with SMTP id b8so1183701plm.11
 for <linux-nvme@lists.infradead.org>; Thu, 14 May 2020 06:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=syNto/APAFXo39Jfkywx9rKgvyWiBrNCHLK7V6gP5Rk=;
 b=GXMIvA7teyFKLgOgHH2svU4AFc7erTqe4N/PfHKHCGdFAQ+/Sen+30dMfbsNdOCJ9k
 l/9MbCF/UXbPbDZzMZVL88LOg+QBnZaWsqwfGpmnPQ4cx4yEKqUAMMZUhfNg1LiywHp+
 sSeNM97QyXWUeRTLi/mQ7aSwK4k1IfBjKJH2Qa2TVOc51u5zbXKgMQHtk5ortH/EyF6V
 Mf49BiIPfSpKcorW/VjHPeTG1QCEV5LJFOHvLqjYVYVpi3dnDo18dpdZpJsqiKbcnuXV
 7JHT/OCcFAKIasIV43gMlgZLVkVt1v70675cMPT6HSXBz7TEct+1OLJW1+0Y9yykOrjk
 KTng==
X-Gm-Message-State: AGi0PuZa0U1Gn+8NhutcdUq8qmPHqzZDXITXpNUkkNW/MmZQu99iTWYE
 MFe6aaWnLXZrmDtIiDvmt7k=
X-Google-Smtp-Source: APiQypJefENidtwNEC3VSBDshB71tPNe/RaPv8G2yXtUu6a8TxGC/v+OtnuYRiWmGDizDJMbe69Azg==
X-Received: by 2002:a17:90a:2365:: with SMTP id
 f92mr42405201pje.117.1589464500400; 
 Thu, 14 May 2020 06:55:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:6c16:7f27:8c37:e02d?
 ([2601:647:4000:d7:6c16:7f27:8c37:e02d])
 by smtp.gmail.com with ESMTPSA id q5sm2208389pgv.67.2020.05.14.06.54.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2020 06:54:59 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: Fix io_opt limit setting
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20200514055626.1111729-1-damien.lemoal@wdc.com>
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
Message-ID: <ac07c7eb-9632-7f3a-6ac3-301854c1ce3c@acm.org>
Date: Thu, 14 May 2020 06:54:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514055626.1111729-1-damien.lemoal@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200514_065501_593814_666286DB 
X-CRM114-Status: GOOD (  12.77  )
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
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020-05-13 22:56, Damien Le Moal wrote:
> Currently, a namespace io_opt queue limit is set by default to the
> physical sector size of the namespace and to the the write optimal
> size (NOWS) when the namespace reports optimal IO sizes. This causes
> problems with block limits stacking in blk_stack_limits() when a
> namespace block device is combined with an HDD which generally do not
> report any optimal transfer size (io_opt limit is 0). The code:

Reviewed-by: Bart van Assche <bvanassche@acm.org>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
