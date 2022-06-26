Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8C6C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jun 2022 10:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fUJmM57i4IDeiRiP+06MUIUCzp4wYZVLwoPkyaTvDmM=; b=CCjGV8pa7c73XqYbjF5Ad/PeVm
	W+q80iQRzTkCOnty/iyTeHJ5h1fgwyIknDfxcFfLNItQEgWynyoHmAAA2FyMW8pjTGxN0BosVnBxw
	DmPrGlWkCeVSbEH/LGvipZYZSFvIg6xE0amvsDnGUj796+DUNCu8etpk3Q5vrtr1lE+A3w1BD9wHt
	kzdFvN9LcxQ8E+SKLJhnYDZHlR2/mpzqvqY7wa61PLfu8sbEr15J+qH5JSzZBwzpCM54FloJCqkr9
	n1Rw5MeraFT/bU5uq5BZ4DhbF+W9QjyRx5MLUGAyNyDRuxLA7jSOHp0aOJv3pgKxj7LL1Y8PDAfGg
	OP25+Y/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5PKb-00B7Sv-Gz; Sun, 26 Jun 2022 10:17:29 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5PKY-00B7Ra-Th
	for linux-nvme@lists.infradead.org; Sun, 26 Jun 2022 10:17:28 +0000
Received: by mail-wr1-f49.google.com with SMTP id i25so3532193wrc.13
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jun 2022 03:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fUJmM57i4IDeiRiP+06MUIUCzp4wYZVLwoPkyaTvDmM=;
        b=HUX+ptTTIOG+R8flpw4PdVu3nbDD9vLz4JjNXiNxfl1fyb2kikke0iVUNve824Arqo
         T0rC4HOoYCa2DXa7pRY8Xjmt9I9BjBKGSy/bN0+/8XCbjESxmpObkjHTnWVq6P4hStFb
         yD3tRIOKus5QtVcEvu/I512rAbW30UJIoIffxaKTq7qWtyM7jAcX8z8bHqLvJUb2W3ym
         9Jw5hRl/7BuXDqmFpr1KRrH661idKdQMgK+ELYbYsfsrfKXaC86TMiwI7iXQm2qun6m9
         pejQwHrRDHN6HYGi/d8BQ930M32gP/CYwX3YmAPNghCiyOYb8XejpM2qjPLkXd72T7lN
         Kr9Q==
X-Gm-Message-State: AJIora/DZU+RlGs/fDIwPGUwrSZbbGu+t8DgHFGnrQJgOXE7VOr1e07b
	iRNydI6207SAHWnhqhaHJLLFCQrvwhQ=
X-Google-Smtp-Source: AGRyM1sSv3p6KCFzyAPuocg03zW2gFm5iT+m613OZwfhSRS6vval1v2UEtys8DHULM8bly4MtuA4ZQ==
X-Received: by 2002:adf:f184:0:b0:21b:6c76:5b6e with SMTP id h4-20020adff184000000b0021b6c765b6emr6920101wro.126.1656238644342;
        Sun, 26 Jun 2022 03:17:24 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id ay14-20020a5d6f0e000000b0021b91ec8f6esm7299068wrb.67.2022.06.26.03.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 03:17:24 -0700 (PDT)
Message-ID: <19c905e8-963e-5720-b18a-d050217d40de@grimberg.me>
Date: Sun, 26 Jun 2022 13:17:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv17 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220623061730.51490-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220623061730.51490-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220626_031727_012095_E75BD06A 
X-CRM114-Status: GOOD (  20.67  )
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


> Hi all,
> 
> recent updates to the NVMe spec have added definitions for in-band
> authentication, and seeing that it provides some real benefit
> especially for NVMe-TCP here's an attempt to implement it.
> 
> Thanks to Nicolai Stange the crypto DH framework has been upgraded
> to provide us with a FFDHE implementation; I've updated the patchset
> to use the ephemeral key generation provided there.
> 
> Note that this is just for in-band authentication. Secure
> concatenation (ie starting TLS with the negotiated parameters)
> requires a TLS handshake, which the in-kernel TLS implementation
> does not provide. This is being worked on with a different patchset
> which is still WIP.
> 
> The nvme-cli support has already been merged; please use the latest
> nvme-cli git repository to build the most recent version.
> 
> A copy of this patchset can be found at
> git://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel
> branch auth.v17
> 
> The patchset is being cut against nvme-5.20.
> 
> As usual, comments and reviews are welcome.


This looks better Hannes.

Few questions:
1. When we set dhgroups, should we try loading dh-generic (host and
target)? I forgot to load these and took me time to figure out why
things are not working?

2. Sometimes when I setup a misconfigured authentication, I don't
fail immediately, but block until an admin timeout expires.
For example, when I didn't load dh-generic on the host:
--
[ 1618.030365] nvme nvme0: new ctrl: NQN 
"nqn.2014-08.org.nvmexpress.discovery", addr 192.168.123.1:8009
[ 1618.121852] nvme nvme1: qid 0: error -2 initializing DH group ffdhe4096
[ 1618.123944] nvme nvme1: qid 0: authenticated
[ 1680.738012] nvme nvme1: queue 0: timeout request 0x1 type 4
[ 1680.738155] nvme nvme1: Property Get error: 881, offset 0x0
[ 1680.738165] nvme nvme1: Reading CAP failed (881)
--

3. Not sure if this is related, but now I see a new memory leak:
--
unreferenced object 0xffff8fa0c91d2080 (size 128):
   comm "kworker/u8:4", pid 262, jiffies 4294949965 (age 1855.437s)
   hex dump (first 32 bytes):
     e0 a2 c9 96 ff ff ff ff 90 0f dd f4 a0 8f ff ff  ................
     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000009524c6a1>] blk_iolatency_init+0x25/0x160
     [<0000000074c7283e>] blkcg_init_queue+0xb4/0x120
     [<00000000747d5b28>] __alloc_disk_node+0xeb/0x1d0
     [<0000000082cf1eb2>] __blk_alloc_disk+0x31/0x60
     [<000000008e36f1d8>] nvme_mpath_alloc_disk+0xcc/0x1c0 [nvme_core]
     [<00000000f81c9db1>] nvme_alloc_ns_head+0x12b/0x250 [nvme_core]
     [<00000000eba12e37>] nvme_init_ns_head+0x255/0x2d0 [nvme_core]
     [<000000006f769fbb>] nvme_alloc_ns+0x114/0x4b0 [nvme_core]
     [<00000000cf38f67b>] nvme_validate_or_alloc_ns+0x9e/0x1c0 [nvme_core]
     [<00000000db73ed81>] nvme_scan_ns_list+0xf7/0x2c0 [nvme_core]
     [<0000000011b21727>] nvme_scan_work+0xde/0x270 [nvme_core]
     [<000000000f7941ae>] process_one_work+0x1e5/0x3b0
     [<000000008eb36ec1>] worker_thread+0x50/0x3a0
     [<00000000e58a93ca>] kthread+0xe8/0x110
     [<00000000e82e51e5>] ret_from_fork+0x22/0x30
--

