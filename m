Return-Path: <SRS0=CGXy=BV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE69C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 21:30:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91F220756
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 21:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="v148M7xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91F220756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rRo0kS68qDCnx2KlhFz89BaznIONuqhX4Ji/pYfCWto=; b=v148M7xuYduvef9qHYWKZVmPS
	hYkNIWYwfnkwHQ3HFePwEn/eEmMM1QymBVt3hVFyRC8T+yQnzukLthzDAQ0QTj4jaMvhEPSB8yF3H
	pnUc60iDmldW1b3XsjXKjxNxw+K88vNXATS5tvEzcOTgLwPivPo0oQC8KiuUXRQY+1SO6m/gGQgXz
	T8b63+l0rcI7Pc19Ycvd3OVCEviVXE/tcdf90H+ZM56j8HfxfJZ1QGw9rGfrz4ikziw8n0gJHL6I9
	HwMJezfPSR6XYLu5zl+vdSYIb5x0fFhdKAm+5J7Basq6S0HPrQ5qoOGTfkulLLmkD9R04naPQkXWd
	ThHwJeOtA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5br7-0008W6-74; Tue, 11 Aug 2020 21:30:49 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5br3-0008Va-QT
 for linux-nvme@lists.infradead.org; Tue, 11 Aug 2020 21:30:46 +0000
Received: by mail-pj1-f67.google.com with SMTP id ha11so87793pjb.1
 for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2020 14:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=wJpZvTjWYQ4GtquYQV60mD7Mq12yiSTpuZSeaMNpyN0=;
 b=NisIJFby8ULFy4iy9zF/VDjmZ7kbKNoUn5rXAI2ai1MCnW+kdmuCn6WUAEFLEAHesW
 Y2cDnVxHlhdW7aZCCfjyj6pFM+2siIkG+awlzw17zROnNOafxOOJM3V2kbyhvj+lpm7J
 EF5awr8frvHxNMYCDZvTLsL0N37r2a/CZN3kSMuRyVgtIRYCQD9lU4B5iwaPjgFRyHdk
 uVYAtN34tngDKqhg/KZhmaabtGl4uDZDmPhrsAPsUWMfZA9RcXOQesogZPKQVhhdW8j+
 WyPcFhAZVt8jz0tFYoz9FUINwU8jdmGhf4POqFTONSF4XCmySR7+pL/lyIK4ErHZFFW7
 TZ3A==
X-Gm-Message-State: AOAM5300wZdSSjzgfAxRCj27u3HqI8vspCp3R04L6UbMwUDQ+tKnT6vu
 uzyNY/BGaLeoFiZ8sKLrG6Y=
X-Google-Smtp-Source: ABdhPJxXXgNLIiEH62UdjJYBvzI9CtkwsHM4yswHgb2Zlx3BuYcVW4UtxQ8aYTPYZ40+D6uTq2oKcg==
X-Received: by 2002:a17:90a:6d26:: with SMTP id
 z35mr2980525pjj.164.1597181441328; 
 Tue, 11 Aug 2020 14:30:41 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id o4sm3797557pjs.51.2020.08.11.14.30.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 14:30:40 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] common: move module_unload to common
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
References: <20200811210102.194287-1-sagi@grimberg.me>
 <20200811210102.194287-7-sagi@grimberg.me>
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
Message-ID: <47900df7-e3be-c200-67ff-c9e099cb8aee@acm.org>
Date: Tue, 11 Aug 2020 14:30:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811210102.194287-7-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200811_173045_878923_18C6712B 
X-CRM114-Status: GOOD (  22.00  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020-08-11 14:01, Sagi Grimberg wrote:
> It creates a dependency between multipath-over-rdma
> and test/nvmeof/rc which is not a natural home
> for it. Move it to common helpers.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  common/rc          | 13 +++++++++++++
>  tests/nvmeof-mp/rc | 13 -------------
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 7f02103dc786..cdc0150ea5ea 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -291,3 +291,16 @@ _filter_xfs_io_error() {
>  _uptime_s() {
>  	awk '{ print int($1) }' /proc/uptime
>  }
> +
> +# Arguments: module to unload ($1) and retry count ($2).
> +unload_module() {
> +	local i m=$1 rc=${2:-1}
> +
> +	[ ! -e "/sys/module/$m" ] && return 0
> +	for ((i=rc;i>0;i--)); do
> +		modprobe -r "$m"
> +		[ ! -e "/sys/module/$m" ] && return 0
> +		sleep .1
> +	done
> +	return 1
> +}
> diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
> index e446db297ba1..829b26624b7f 100755
> --- a/tests/nvmeof-mp/rc
> +++ b/tests/nvmeof-mp/rc
> @@ -145,19 +145,6 @@ remove_mpath_devs() {
>  	} &>> "$FULL"
>  }
>  
> -# Arguments: module to unload ($1) and retry count ($2).
> -unload_module() {
> -	local i m=$1 rc=${2:-1}
> -
> -	[ ! -e "/sys/module/$m" ] && return 0
> -	for ((i=rc;i>0;i--)); do
> -		modprobe -r "$m"
> -		[ ! -e "/sys/module/$m" ] && return 0
> -		sleep .1
> -	done
> -	return 1
> -}
> -
>  start_nvme_client() {
>  	modprobe nvme-core dyndbg=+pmf &&
>  		modprobe nvme dyndbg=+pmf &&
> 

Hi Sagi,

I think there is another copy of unload_module() in tests/srp/rc. How about
also removing that copy?

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
