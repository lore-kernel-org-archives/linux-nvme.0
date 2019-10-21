Return-Path: <SRS0=hg6U=YO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10751CA9EAE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2019 02:15:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47B321897
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2019 02:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ne02j/C5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47B321897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=CNb1VBHoKOLHzCqgyQTpRreS4CreWo5a3V1E3UWQHPs=; b=Ne02j/C5qSCiEk1hpnIJEjCwjs
	/1C8vu/GjRGIcufBIzceuwLzDTlGxfDI/6sVrXpB8VOTxs96RYAE8AqKXz/qBVwS49tCYOGcwtPWG
	k9xDecAYLn+fLPN+SewCNZfkDCPIo2I2P8i5Gc3ncI9K8lVYuIr/Up2K/KmfRcyG8vhxQGzN0lL2L
	RIWyiTQdue91Bf/r5JM+QuV4wKYvJtNqCrwkH9UZOpQz+mCfupIoJ3UBbSRVw4fYdexqg1qtmB/E9
	/j4jY+Yl9PKADolT1aTHZe940zDvQ8N9uX41idd5ATCwgYWEmrbY25pKGH/hoyyI7UhItYfjn9vHu
	WYHBuD5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iMNDr-0000uG-HO; Mon, 21 Oct 2019 02:15:03 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iMNDp-0000dj-AF
 for linux-nvme@lists.infradead.org; Mon, 21 Oct 2019 02:15:02 +0000
Received: by mail-pf1-f195.google.com with SMTP id q12so7391080pff.9
 for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2019 19:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rQGR8mfXhmatZdrMVXi7RNTYwvN9Zv0kQDfyar7Sl2w=;
 b=XjemGNLRtOFHE0ElFpe8hQSnk4NQ6NhDBxRuM3lpxzaBuW3a2yhEIJw73CwpFnk236
 xEX+u/Ulexw5vf4C+Kk3mvGEQRlUOPcyNbe1DXRFrotG0UWDE2VQkt85nyQfoAgeBYuM
 oHTMLXWPGZvVhpO9rsjqSokYlSTMCiHSG9qfJGwOb6gqqgCY4iIWdj7ufKWmc9CKNaiW
 NLPsuIzZljJHoDtCMkbNNguKGRqWlSF/1RrUl4HaGNbWKzN6VosyS/fxHxwl4eaGNw4r
 ev2Gaxpfe/uX24sArn6bmbPkTg2aWwmXx7flgYZf8Yv5Llq5TeU8/bhbcpFvnBqobLKF
 qerQ==
X-Gm-Message-State: APjAAAUeIO1G2TLOQHbZpZHTs6ONMG20Ncmq3L7UtZewyFFaT7u4n96n
 jSxbuHO6h0b5Rdvjd0NZBmk=
X-Google-Smtp-Source: APXvYqwcmXT1SlqO8OhYtxtCbtWgrEba/we7E84gnBpH/qcbPwcsKJ+gVmFs+wp3uhFSSshweicH5A==
X-Received: by 2002:a17:90a:19c1:: with SMTP id
 1mr25528780pjj.52.1571624100347; 
 Sun, 20 Oct 2019 19:15:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:ce:256c:d417:b24b:327f])
 by smtp.gmail.com with ESMTPSA id
 g12sm13861608pfb.97.2019.10.20.19.14.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2019 19:14:59 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme: Introduce nvme_block_sect()
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>
References: <20191020234220.14888-1-damien.lemoal@wdc.com>
 <20191020234220.14888-3-damien.lemoal@wdc.com>
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
Message-ID: <092dd421-c439-f020-f2de-a7d17e56bd09@acm.org>
Date: Sun, 20 Oct 2019 19:14:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191020234220.14888-3-damien.lemoal@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191020_191501_374380_AFB5C1CD 
X-CRM114-Status: GOOD (  11.57  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2019-10-20 16:42, Damien Le Moal wrote:
> +/*
> + * Convert a logical block number to a 512B sector number.
> + */
> +static inline sector_t nvme_block_sect(struct nvme_ns *ns, u64 lba)
> +{
> +	return lba << (ns->lba_shift - SECTOR_SHIFT);
> +}

How about renaming this function into nvme_lba_to_sect()?

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
