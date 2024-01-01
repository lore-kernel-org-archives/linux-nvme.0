Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9685BC47074
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O2kqnOwiWzbq6V6XciEVM1q/iXlfHj0RkqFyW07mox8=; b=VBqOHG3KtI+mTlKI2kjJ+NDvbD
	ZdxGhIkv3l1HEpwVishyMlPL8790mXIqCE5nggbb9KPU0qmM4A9/JB2pwYVNVeUNAt3GVBZQ78BOe
	cfHW1GHj4ZL8hSjTiEu2Jm//L4GPbJ8KhQ6WwGjF4cOr30jUfRMmeiCwR0YHvHGOTgAcpbgRiHElN
	UhiPP4aAXxlo7gnj7OdTMrI0qqJ0oNT3qWaL4FRnHFu83d0hHxQ1H+QLVcJxwHtCjncqtU70rawvE
	BZiiHDgqNi2CVgsBL7qXa5D2jMu5/ouCgaxSA7re/OKhAfmynNanBGuCKhOKToBDDTEOiVXwzeEeS
	gtARL8Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKExo-005rHO-26;
	Mon, 01 Jan 2024 09:52:04 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKExj-005rFt-1E
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:52:03 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d87e9151dso1928975e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704102718; x=1704707518;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2kqnOwiWzbq6V6XciEVM1q/iXlfHj0RkqFyW07mox8=;
        b=TXb8PaM+0BlLwIBUd8AJ+tH1BGBcAnr/Vfn1rRE7j+XfMXqNdkxxFQlhgswshPQ8ir
         +3qxpY5FGau7qzxBgflHN3AKoyZ2bD9RzmM0mf3sC4Vg/Ke+c9q/1KjysyFAhzvaDzPj
         huoK6/YK28KyeE4WzJm/wdRf2x2XvHhnxYA7a8rbxdir41YOpBKq+dMrjkvIeGH1jaYq
         GrKoegGavu/6zArGR6LbUnOCP0229eQ6MeOpUIIu1IiVUqNG2fzgFGAEvv1UZuktrB47
         B8LMeEAtgxYhQL7+Edp/+yf+v0SzzoXKnb+hvnAd4KS2yGFtGEZf8Fdb/thXEv4IDkhu
         MQDw==
X-Gm-Message-State: AOJu0Yx5cKy4yaw6jQZ65Y4QhiN6gwuDIT61WOPZalVyqFcJ/PYTDkbh
	c2bzwD+mgbbjcP5hiQupIk0=
X-Google-Smtp-Source: AGHT+IHPl95e+nyIQZBQdEEqbCAPo0A6z+F0qhWORm94Bn3wCgq4woU1BwBtCI+kUe0IBbxhqiRJZw==
X-Received: by 2002:a05:600c:1d06:b0:40d:8954:5834 with SMTP id l6-20020a05600c1d0600b0040d89545834mr878683wms.3.1704102717800;
        Mon, 01 Jan 2024 01:51:57 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b0040d6ffae526sm13976226wmq.39.2024.01.01.01.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:51:57 -0800 (PST)
Message-ID: <ae40ced9-9f30-4e93-813c-5b94d0667d66@grimberg.me>
Date: Mon, 1 Jan 2024 11:51:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
Content-Language: en-US
To: Jirong Feng <jirong.feng@easystack.cn>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org,
 peng.xiao@easystack.cn
References: <9b1589fb-6f47-40bb-8aa6-22ae61145de4@easystack.cn>
 <ZW6pJAm9wgqj1HEW@kbusch-mbp> <20231205044035.GA28685@lst.de>
 <08f2c221-cca7-4d34-ab78-157d4eae4f68@grimberg.me>
 <945fa17c-f1d0-4928-972b-da29ca5c95ec@easystack.cn>
 <a99971dc-9157-4a0f-8fb7-5fa495434b99@grimberg.me>
 <b8cd8de7-9167-4b8f-b255-c022376a7c9d@easystack.cn>
 <dda859d1-41f5-423c-a9e2-900a1573c3a9@easystack.cn>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <dda859d1-41f5-423c-a9e2-900a1573c3a9@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_015159_432376_013B2B00 
X-CRM114-Status: GOOD (  17.88  )
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


> I've tested the patch basing on kernel version 6.6.0. It seems not 
> working...

Can you paste the log output (host and controller)?

> 
> here's my steps & results:
> 
> 1. create a VM and make & install kernel from source applying the patch.
> 
> [root@fjr-nvmet-1 ~]# uname -r
> 6.6.0-mytest+
> 
> 2. clone that VM.
> 
> 3. create a shared volume and attach to the both VMs.
> 
> 4. config nvmet as below:
> 
> VM1:
> 
> o- / 
> ......................................................................................................................... [...]
>    o- hosts 
> ................................................................................................................... [...]
>    o- ports 
> ................................................................................................................... [...]
>    | o- 1 ................................................ [trtype=tcp, 
> traddr=192.168.111.99, trsvcid=4420, inline_data_size=262144]
>    |   o- ana_groups 
> .......................................................................................................... [...]
>    |   | o- 1 
> ..................................................................................................... [state=optimized]
>    |   o- referrals 
> ........................................................................................................... [...]
>    |   o- subsystems 
> .......................................................................................................... [...]
>    |     o- 
> nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06 ......................................... [...]
>    o- subsystems 
> .............................................................................................................. [...]
>      o- 
> nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06 [version=1.3, allow_any=1, serial=308df2776344fdd17cba]
>        o- allowed_hosts 
> ....................................................................................................... [...]
>        o- namespaces 
> .......................................................................................................... [...]
>          o- 1 .......................................... [path=/dev/vdc, 
> uuid=cf4bb93c-949f-4532-a5c1-b8bd267a4e06, grpid=1, enabled]
> 
> VM2:
> 
> o- / 
> ......................................................................................................................... [...]
>    o- hosts 
> ................................................................................................................... [...]
>    o- ports 
> ................................................................................................................... [...]
>    | o- 1 ............................................... [trtype=tcp, 
> traddr=192.168.111.111, trsvcid=4420, inline_data_size=262144]
>    |   o- ana_groups 
> .......................................................................................................... [...]
>    |   | o- 1 
> ..................................................................................................... [state=optimized]
>    |   o- referrals 
> ........................................................................................................... [...]
>    |   o- subsystems 
> .......................................................................................................... [...]
>    |     o- 
> nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06 ......................................... [...]
>    o- subsystems 
> .............................................................................................................. [...]
>      o- 
> nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06 [version=1.3, allow_any=1, serial=0dcf77d36826000cc5a0]
>        o- allowed_hosts 
> ....................................................................................................... [...]
>        o- namespaces 
> .......................................................................................................... [...]
>          o- 1 .......................................... [path=/dev/vdc, 
> uuid=cf4bb93c-949f-4532-a5c1-b8bd267a4e06, grpid=1, enabled]
> 
> 5. create a host vm(CentOS 8.1, kernel version 
> 4.18.0-147.3.1.el8_1.aarch64), config dm multipath
> 
> [root@fjr-vm1 ~]# cat /etc/multipath/conf.d/nvme.conf
> devices {
>      device {
>                  vendor                  "NVME"
>                  product                 "Linux"
>                  path_selector           "round-robin 0"
>                  path_grouping_policy    failover
>                  uid_attribute           ID_SERIAL
>                  prio                    "ANA"
>                  path_checker            "none"
>                  #rr_min_io               100
>                  #rr_min_io_rq            "1"
>                  #fast_io_fail_tmo        15
>                  #dev_loss_tmo            600
>                  #rr_weight               uniform
>                  rr_weight               priorities
>                  failback                immediate
>                  no_path_retry           queue
>      }
> }
> 
> 
> 6. connect nvme on host, finally it looks like:
> 
> [root@fjr-vm1 ~]# nvme list
> Node             SN Model                                    Namespace 
> Usage                      Format           FW Rev
> ---------------- -------------------- 
> ---------------------------------------- --------- 
> -------------------------- ---------------- --------
> /dev/nvme0n1     0dcf77d36826000cc5a0 
> Linux                                    1         107.37  GB / 107.37 
> GB    512   B +  0 B   6.6.0-my
> /dev/nvme1n1     308df2776344fdd17cba 
> Linux                                    1         107.37  GB / 107.37 
> GB    512   B +  0 B   6.6.0-my
> 
> [root@fjr-vm1 ~]# nvme list-subsys
> nvme-subsys0 - 
> NQN=nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06
> \
>   +- nvme0 tcp traddr=192.168.111.111 trsvcid=4420 live
>   +- nvme1 tcp traddr=192.168.111.99 trsvcid=4420 live
> 
> [root@fjr-vm1 ~]# multipath -ll
> mpatha (Linux_0dcf77d36826000cc5a0) dm-0 NVME,Linux
> size=100G features='1 queue_if_no_path' hwhandler='0' wp=rw
> |-+- policy='round-robin 0' prio=50 status=active
> | `- 1:1:1:1 nvme1n1 259:1 active ready running
> `-+- policy='round-robin 0' prio=50 status=enabled
>    `- 0:1:1:1 nvme0n1 259:0 active ready running
> 
> 7. execute fio on host, and disable namespace on the vm corresponding to 
> nvme1, the same error goes again:
> 
> fio: io_u error on file /dev/dm-0: Operation not supported: write 
> offset=14734594048, buflen=4096
> fio: io_u error on file /dev/dm-0: Operation not supported: write 
> offset=106607394816, buflen=4096
> fio: pid=16076, err=95/file:io_u.c:1747, func=io_u error, 
> error=Operation not supported
> 
> 
> 

