Return-Path: <SRS0=uXiZ=6J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E17C55191
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Apr 2020 17:34:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8AF20728
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Apr 2020 17:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uJBH5zNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8AF20728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Rf6XcYWpFm/ekEqBuVIGzr3cflpfwKwc3F1aROsDEw=; b=uJBH5zNhCiieS6
	vbmH/dn7FbyOXcmw4jzxBhU5qZpkoCdCfZC3brHM/ZetoUAeWecTI56FNDldc7/cS6gzmFe7OpQ6P
	hknEj10eRcNkFGJtLv/5IZOxtFzmWBfEhfXo6p3yv3CR0KBd1v6UAdb9NJehH2VONJ6ctYyb9WBLz
	mTGRwCrh3j4hf5dxVCPYWY8Ni9mHLGUKDBYVXdjZs0b51CRaTXQQiyCCwK2gXySrkCvTkKoB1YPff
	o4FR4TNnS6GHeGt9aJDR21hF8Kw7+eFNs6t04Y7EdjBJRThXUvs4YScDsN1BdHABunqjc5a7k7onP
	5IQ5CIaWr7aU6IJi1Z8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jSOhJ-0000nN-KD; Sat, 25 Apr 2020 17:34:37 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jSOhE-0000lg-TQ
 for linux-nvme@lists.infradead.org; Sat, 25 Apr 2020 17:34:34 +0000
Received: by mail-pf1-f193.google.com with SMTP id 18so6430592pfx.6
 for <linux-nvme@lists.infradead.org>; Sat, 25 Apr 2020 10:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=7yCqD+rRRBkYGW0z/wTNjDeYQaMCpKpzTiPX36S7yQ8=;
 b=oXRkDCragtCb/xJZxVieB7cczAVb7XVDIMvqGA7umK9ytlWuIfsTT0vhtzDyDCmp+o
 +pWh953EPSLbPfrKm/KKUaEbY71cvrXP6heingMVzFEwBEdU+iUAeFwbYMBcHrGPvxt1
 wVT5tI8Q1AAm73SSNtzUU0+/Vof6O1AVujnYt0qmDfYM4P7DroAk+T1W2eh3OcyD8zUc
 0wOA7W8WIhx5+kHdnaZe7ZLr+e/r0pj3qSjVP1epmRLbjvUWnH7t9zc5f5+9aN1plbEb
 Ai0WEB8BDLZ81offsZgn1S7uWETaw3oP7RXkr1cPJZYiHXQ5W6CAptbyzJVqvpBGy/hD
 nxxA==
X-Gm-Message-State: AGi0PuZpeH5N2r41ZgifSX1+1vlHtH6tjaeUr0pRIsAkzLLyDQu/5MDJ
 W8fP1/OvcLoN4eBWdfs1oZWK/BW/QaQ=
X-Google-Smtp-Source: APiQypJ7DK/CXkJ34hRCJq1RYAqa9ANrVrlBvvkj75LUqiH28BOt5qdb0RI2UbAlWQuvsFfJGjMZaQ==
X-Received: by 2002:a63:b20f:: with SMTP id x15mr135266pge.298.1587836071105; 
 Sat, 25 Apr 2020 10:34:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:9817:f6ce:d8be:3e60?
 ([2601:647:4000:d7:9817:f6ce:d8be:3e60])
 by smtp.gmail.com with ESMTPSA id 185sm9031790pfv.9.2020.04.25.10.34.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Apr 2020 10:34:30 -0700 (PDT)
Subject: Re: [PATCH nvme-cli] nvme: fix asprintf return value check
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200425055852.2921-1-chaitanya.kulkarni@wdc.com>
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
Message-ID: <3dda409b-bb72-1019-5ce8-e22781d45ba3@acm.org>
Date: Sat, 25 Apr 2020 10:34:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200425055852.2921-1-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200425_103432_952559_A9A52880 
X-CRM114-Status: GOOD (  12.87  )
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
Cc: kbusch@kernel.org, Kev Dorman <kdorman036@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020-04-24 22:58, Chaitanya Kulkarni wrote:
> diff --git a/nvme-topology.c b/nvme-topology.c
> index e938f23..4dbadce 100644
> --- a/nvme-topology.c
> +++ b/nvme-topology.c
> @@ -357,9 +357,9 @@ static int verify_legacy_ns(struct nvme_namespace *n)
>  		char tmp_address[64] = "";
>  		legacy_get_pci_bdf(path, tmp_address);
>  		if (tmp_address[0]) {
> -			if (asprintf(&n->ctrl->transport, "pcie") != 1)
> +			if (asprintf(&n->ctrl->transport, "pcie") == -1)
>  				return -1;
> -			if (asprintf(&n->ctrl->address, "%s", tmp_address) != 1)
> +			if (asprintf(&n->ctrl->address, "%s", tmp_address) == -1)
>  				return -1;
>  		}
>  	}

How about using "< 0" to check for errors? I think that's a more widely
used approach to check for errors than checking for "== -1".

Will a memory leak occur if the first asprintf() call succeeds and the
second asprintf() call fails?

Thanks,

Bart.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
