Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D83FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 09:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5GjeOUkjo80DozStTtPXhVzQRQej4Y2nGzurYGhi8tM=; b=IWzBtcjqFELnSHBu2X4MIWL9kb
	5Vt9fDvIfrc8nCkmYbRNvBHwl/xABw1wFkzci7M4YBSd/dnUfKRXje6qYm2+TGxN34cfWy8RCA49j
	uOgf4QXyKN4aMl+YCLTGXo3dlvQ2wgFfqI8hI5fb6+sG4lAOKK3F7VBWea9IyWXboPKVSsJGVqhnI
	6xF55WZrqZJijkS1UtAP/dZtn1YFFElATtv9KeH8VIzNibPJCcZ5fGSVIHWBnqPOx0ILDcTIqJB4F
	SAtp1tXR6Oje1bXTu9RwIjPJEZPj2zUvEWddoBaU95tkB8/Ks0zLsgK8YUPR7Xm9xhBQX1mGmLmth
	CBGgCl8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU34g-008Pki-7g; Tue, 15 Mar 2022 09:02:38 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU34d-008PjU-LF
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 09:02:37 +0000
Received: by mail-wm1-f43.google.com with SMTP id r133so137243wma.5
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 02:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=5GjeOUkjo80DozStTtPXhVzQRQej4Y2nGzurYGhi8tM=;
 b=NAIoFkjYFY0/T7nj5VyuxDfsJbrr87WMl1ZKktFn/lLOMr6bJGK1B85VpLoJCGax2F
 t/vqpLc+M/fXysC/uQmLW+wiXD2yuMYo7ydWnl/brxLArG1KOoNRr4h1HEIf/F0vIfmX
 ZSXILgbOmU5SJIhaxiiOYwjg0IcQj2AzTSeZTW6pz7FRhOtrpAAUuZKtXNNf8LFbEjlQ
 zECa17hZ63QkJRfXxiXqq5ZzWWZvc0eegoHpMPi1anTyGq9dD3LC/8EMyMwrIGKZj7IC
 nS/nWiqKvFiJicH+H4ssLuufASJ+B6tX8m9dMWO4n48lnUmm16lmdWr9Xki/Hv+VJ/Zq
 f0dQ==
X-Gm-Message-State: AOAM531TJez41hawM3SGCzQ/tFnIQTlOJN4H4swGFE5MN3sVrqiMoBSe
 40ZQ+hyDJ8SaYtiaqIw523M=
X-Google-Smtp-Source: ABdhPJwWmkBm9T7IWXeFPmodjHRzLLkW+dwv0nCn/xwaXmyQoWXmh9laUOz1x8EayF3ghihBHG7gKA==
X-Received: by 2002:a05:600c:1c02:b0:389:cf43:da63 with SMTP id
 j2-20020a05600c1c0200b00389cf43da63mr2336863wms.205.1647334953730; 
 Tue, 15 Mar 2022 02:02:33 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 bh19-20020a05600c3d1300b0038b481f357dsm1471479wmb.3.2022.03.15.02.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 02:02:33 -0700 (PDT)
Message-ID: <8f45a761-5ecb-5911-1064-9625a285c93d@grimberg.me>
Date: Tue, 15 Mar 2022 11:02:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
Content-Language: en-US
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav
 <pankydev8@gmail.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier@javigon.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com>
 <7a123895-1102-4b36-2d6e-1e00e978d03d@grimberg.me>
 <CA+1E3rK8wnABptQLQrEo8XRdsbua9t_88e3ZP-Ass3CnxHv+oA@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CA+1E3rK8wnABptQLQrEo8XRdsbua9t_88e3ZP-Ass3CnxHv+oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_020235_728468_C4E699F4 
X-CRM114-Status: GOOD (  17.14  )
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


>>> +int nvme_ns_head_chr_async_cmd(struct io_uring_cmd *ioucmd)
>>> +{
>>> +     struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
>>> +     struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
>>> +     int srcu_idx = srcu_read_lock(&head->srcu);
>>> +     struct nvme_ns *ns = nvme_find_path(head);
>>> +     int ret = -EWOULDBLOCK;
>>> +
>>> +     if (ns)
>>> +             ret = nvme_ns_async_ioctl(ns, ioucmd);
>>> +     srcu_read_unlock(&head->srcu, srcu_idx);
>>> +     return ret;
>>> +}
>>
>> No one cares that this has no multipathing capabilities what-so-ever?
>> despite being issued on the mpath device node?
>>
>> I know we are not doing multipathing for userspace today, but this
>> feels like an alternative I/O interface for nvme, seems a bit cripled
>> with zero multipathing capabilities...
> 
> Multipathing is on the radar. Either in the first cut or in
> subsequent. Thanks for bringing this up.

Good to know...

> So the char-node (/dev/ngX) will be exposed to the host if we enable
> controller passthru on the target side. And then the host can send
> commands using uring-passthru in the same way.

Not sure I follow...

> May I know what are the other requirements here.

Again, not sure I follow... The fundamental capability is to
requeue/failover I/O if there is no I/O capable path available...

> Bit of a shame that I missed adding that in the LSF proposal, but it's
> correctible.


