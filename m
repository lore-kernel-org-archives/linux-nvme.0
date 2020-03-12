Return-Path: <SRS0=qcAl=45=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0E1C1975A
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 15:21:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F99320674
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 15:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mUZujzj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F99320674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VYp3EsHBRx8pPFXqVx+Y3RGUhtGKZesiSshbkLjmo+c=; b=mUZujzj4WN+MBOuwBv7VGuQ4Ts
	ewF3u7x5Y8BaAr/zVHtWrGV7n4vLpav2kqIfyZlEftXX5ir97kAoEUL//tyNjTmdzBaRgW8jaSSBz
	ED0sDndPQEJe43lRhcXJ2BlRigIDFHcr74wowNDsa5oZelixQoivJi27c2ZWX5QGc1XVx44Gshzrx
	QHwF3lSkhj731kYAmUUHbT1GMUU0L63IEuHGrWvdv4ogObp9ue3aJtoenJ95pcAKbmbTFDo/D+d02
	v/XUO1cuUGr/ozFmF45yP6UEkqXqJaz9Jz7Z2liWfS3flqqctOKYay9yt9gV5CaND0R0Lh++Gy6eA
	UhYRFcXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCPe8-0008Dn-Lc; Thu, 12 Mar 2020 15:21:16 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCPe5-0008D7-Rn
 for linux-nvme@lists.infradead.org; Thu, 12 Mar 2020 15:21:15 +0000
Received: by mail-pj1-f67.google.com with SMTP id m15so2098588pje.3
 for <linux-nvme@lists.infradead.org>; Thu, 12 Mar 2020 08:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KTSXYITnm1/WH2ZYXdKY58PQDpfbcjgvILt8IUd6Gv8=;
 b=QUKnJh/3k53O3F2RLe/jp/MkpwpVq6tSrzqQuRTH6gMtoiFRKBXCHCAFoQt93A4TkA
 06NotWY6Hfd8AIPAQRLTzrW1sOgVLL3ZX0tmThE/S+HsKDXsMN29aDizFtfe3MQm1jWM
 ZBIzzMpcDvEAzBu9ZafQ1weh+EoHL+apYM6m8MmD4AKiHum2vpBJe4zpkgMcio6INJs2
 gPQWzeW3V2sfMxraRHXckJ/aIF1tmhnn+PupwTfjGN4KufR4uApU80pFWWj6HSwKvrjJ
 p05othgbS7lm6WQSlQCQP1EaEEdMHU20iddLDQPxPcst7EXT1xTLRUuiLsippFAq58Zf
 f5YA==
X-Gm-Message-State: ANhLgQ0AsdATJk1tv1ycuueDoBD6RNxSKVZzMhWBGHEBdhzjJltUEzOu
 8PBb+Dfeo2IBnwliLMBwbp0grVppCdM=
X-Google-Smtp-Source: ADFU+vt8U8p/BnVf1oBclHSd/EQvbH2de32xIyr1ct/abNcEZlkhcdyMK106Jk58dEvrKu4oTeyjQQ==
X-Received: by 2002:a17:90a:dac6:: with SMTP id
 g6mr4774863pjx.30.1584026472679; 
 Thu, 12 Mar 2020 08:21:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:7dc2:675a:7f2a:2f89?
 ([2601:647:4000:d7:7dc2:675a:7f2a:2f89])
 by smtp.gmail.com with ESMTPSA id b133sm54297412pga.43.2020.03.12.08.21.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2020 08:21:11 -0700 (PDT)
Subject: Re: [PATCH v1] asm-generic: Provide generic {get, put}_unaligned_{l, 
 b}e24()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
References: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
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
Message-ID: <4c81594e-6b30-d1ff-31f6-0d8cfbf5ba3c@acm.org>
Date: Thu, 12 Mar 2020 08:21:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200312_082113_901632_CA1F2772 
X-CRM114-Status: GOOD (  10.76  )
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

On 2020-03-12 04:39, Andy Shevchenko wrote:
> +static inline u32 get_unaligned_be24(const u8 *buf)
> +{
> +	return (u32)p[0] << 16 | (u32)p[1] << 8 | (u32)p[2];
> +}

The argument is called 'buf' and the function body dereferences a
pointer called 'p'. Does this even compile?

Bart.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
