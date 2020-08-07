Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F17C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 14:04:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F8422DD6
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 14:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="x4JldnE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F8422DD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7cJ+rwO+dIazuRdWhImTmX7mr3Zl1arU+wdYvY7DxrY=; b=x4JldnE26VQv+DUsR3c/X7nac
	3xW3i6yizX2bg2jYwAJ4Nj4IDx8rqQaHYVYn6Y9nKi0LguymRxA70t0U1AatC4XeOiKIHUm1x/8Fn
	ew+nbjhH+P/bXO1fBYe6DBJrwrIcMVibX9/MZZo6oOVsDUbMYiryPx7+vFZQshveWcnXzbpABKfAR
	z6KilFEPgQ2uNPDrJnEq5TKUTrTwbd6HZ5miX41fEaa7+sSzbrEEHJ8B7YuHZb2WsA18u29DBaTDc
	PLaJeNW3yVKok3/NQjQ4ET+oHqzZ1tHDdzLeSPfWIyzcO3J6iwuECDKEIA0xMBcMjWLCmKsYh16AB
	CX031R5Gg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k42yX-0005Du-Uc; Fri, 07 Aug 2020 14:04:01 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k42yV-0005Ct-D9
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 14:04:00 +0000
Received: by mail-pf1-f196.google.com with SMTP id r11so1036848pfl.11
 for <linux-nvme@lists.infradead.org>; Fri, 07 Aug 2020 07:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=EEK7qwrINpS0AR/Vn7KHw4tDcx330ztZP1xMqKuRyrs=;
 b=miYGdprPKvdNJVq+5EMztf1gjr2D+Vkm+H7A/4HSJrPhEQfKZTm+S/sLbeSUpQZchK
 V7ftg5WRpxJayyIVRTq88S9poXn3RJJJxeuc61izBtNcGD+7wpTLry1eZjeMzS4icbds
 vLNKSZgAcDj4ucOvVnY+QXHZRLyoUoVEbt4o+sVNE0duHPWLaJgRVHD68uxdJSFgOpgl
 wlYmIftF72SdCOFeOdU06E3j5H1ZdCt94kmw1WTaOWjk1pN022OfYU7SCB8d7mcWH9e+
 7yDSZ0SrvsCTcKiOsHD7g9PG/Iv37JA26pR41TPpGvAZcxAhVPT2wV+uMhoauiu7FfWX
 LfCw==
X-Gm-Message-State: AOAM532UrcZM1hXqLeT4tBQu3S42osVZ0ORB7cdak1TM8Wm1r0v3eAbc
 yeiCuje9s169zxZdUQ6z0uc=
X-Google-Smtp-Source: ABdhPJykpmFKNmixCd1ZJN51TBX4Tamosjc7RGHoywvvFCyOkdv0lE9ATyjd3zc3eXFFu1Ml7HSSgg==
X-Received: by 2002:a63:541e:: with SMTP id i30mr12053466pgb.47.1596809035679; 
 Fri, 07 Aug 2020 07:03:55 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id s29sm11398410pgo.68.2020.08.07.07.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 07:03:54 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] common/multipath-over-rdma: don't retry module
 unload
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-7-sagi@grimberg.me>
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
Message-ID: <925e1ac6-38fa-6fe9-c0b7-7e665559a989@acm.org>
Date: Fri, 7 Aug 2020 07:03:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806191518.593880-7-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_100359_484283_1B84F447 
X-CRM114-Status: GOOD (  14.71  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020-08-06 12:15, Sagi Grimberg wrote:
> There is no need to retry module unload for rdma_rxe
> and siw. This also creates a dependency on
> tests/nvmeof/rc which prevents it from using in
> other test subsystems.

If it wouldn't be necessary to retry module unload I wouldn't have
introduced a loop.

How about moving the unload_module() function definitions from tests/srp/rc
and tests/nvmeof-mp/rc into common/rc instead?

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
