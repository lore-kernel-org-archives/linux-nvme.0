Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7205C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 06:00:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C26D61152
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 06:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9C26D61152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=uPl49DYkbN6JmaeStnIZLYyJABjPftcbNHuXuvhST18=; b=OYx
	5upYrgZ9bH05socQOdHEMm3cAnoNg4839CTsaI6SoGrOwuvyH8h4JjJ+ywIlX3yOifmpouMIkvJPS
	YOEjjCCcAAO2n4xq8uFa6XmlgzRf6ofayIDqLzRI+CNKUGMDH/1uX78PgFKm5Cqt3w9pifDAI3nz3
	vF+2f0n93xxF6Sg9KJZUVHThwwzqrXrRRXglsLYloazW2m92hFUEM2++fPUsqIi0yQyQwM+zkifri
	k4O/kxETbswPF/koVfITZDCNUXrqaORvASojj3jcJ4F7jPu/oATAv/1pKaFIqN+b4pr1N5bHr7hdb
	rJUE23THBP/8ShPibh+3HQOMdu+vbPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVp6k-00D3YK-Cy; Thu, 30 Sep 2021 05:59:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVp6h-00D3Xm-Je
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 05:59:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632981584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=UQPkCfBjTcavKJzMjFKUO8fWDmhtb5puJ5hHDRTUd/w=;
 b=C2RpoL7n6jBJ9vuTl3uxaRxwwa1KYptnf+q+ByQCcfXaAdwEpcmTAzF2c9r+dBjNZ4BoHm
 9yWk8tkJ+vGewRcwujI3mKRFU3GK2M8J1DkFM+6S71nq9zI/R2UlkmX6koUkpgMk0FPdxm
 qYf05ruilMWRaxFEZcIxoDHQuF0fxuo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-Cs41qt9BMGeh3Mqq9eQMNg-1; Thu, 30 Sep 2021 01:59:43 -0400
X-MC-Unique: Cs41qt9BMGeh3Mqq9eQMNg-1
Received: by mail-yb1-f199.google.com with SMTP id
 f8-20020a2585480000b02905937897e3daso6941035ybn.2
 for <linux-nvme@lists.infradead.org>; Wed, 29 Sep 2021 22:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=UQPkCfBjTcavKJzMjFKUO8fWDmhtb5puJ5hHDRTUd/w=;
 b=jf0hJP94WygWpePhZskeArx3z/3lqYv63WAEinWQBGn0xpzbdgoVvYg0J/KOzX7xMn
 +CHmRUyBW0lsUxwAsorq0ZzWmKU/OLyClctr/JlpKhzHxABcBVUHJYLz+VDR/T6UXwk6
 VF1SKz5ICQy0hNh/NnT6ZhZ52f0VISayPS7OATcA4etO/cld0sUVFDPHE1efYprmeAfy
 gVyNqYaEMhRsuKXEBbGcB1pMtlzhEuwMhOr7vOJnD8yV3zQpakEF230W3M3fjBVxhur2
 dzsu30IqGSBnguu7Ok1RxLPXW9fA8W9uRRT7Z1Hf7jhPnMgA7hJbPKIgz863apLfUqCC
 /DiA==
X-Gm-Message-State: AOAM530JM1clAlmj33OG+SxNvHW1bgpO2ecRr+9oHgUkvkkT2wfQGP0x
 3aE43zHpV8BD91xYhV6NySL0ECLf1go5/LS3vfXocfXYBa74Oy50lODQ5escu9PJmOWXw57aS1+
 WLL3I54r/zTBzoj7jBMZpTlHjupKb6WKqdbp+fimK/XI=
X-Received: by 2002:a25:2208:: with SMTP id i8mr4681753ybi.86.1632981582956;
 Wed, 29 Sep 2021 22:59:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWcMZhn4wDN4t/e/N+LoIPRGXWdrhjl2kZvR0MsbByRyzfw3J7GjfYHHPoR3xb6p3qCUZ7Q7ZzfPV4xho8DAQ=
X-Received: by 2002:a25:2208:: with SMTP id i8mr4681738ybi.86.1632981582732;
 Wed, 29 Sep 2021 22:59:42 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 30 Sep 2021 13:59:31 +0800
Message-ID: <CAHj4cs8pcLTjHMhh_0vebWUgwTY+UtYoKAhQntCsFvKM4zcKfA@mail.gmail.com>
Subject: [bug report] kmemleak observed with blktests nvme-tcp tests
To: linux-nvme@lists.infradead.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_225947_763719_F7465AA2 
X-CRM114-Status: UNSURE (   4.04  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello

Below kmemleak was triggered with blktests nvme-tcp on latest
5.15.0-rc3, pls check it.

unreferenced object 0xffff8882bc8d6668 (size 8):
  comm "kworker/u26:2", pid 82, jiffies 4295107562 (age 2911.554s)
  hex dump (first 8 bytes):
    6e 67 31 6e 31 00 7b 7c                          ng1n1.{|
  backtrace:
    [<0000000046e1c456>] __kmalloc_track_caller+0x129/0x260
    [<00000000a8f7a3a1>] kvasprintf+0xa7/0x120
    [<0000000076a54cc5>] kobject_set_name_vargs+0x41/0x110
    [<00000000a569a16a>] dev_set_name+0x9b/0xd0
    [<00000000f793cc3d>] nvme_mpath_set_live+0x322/0x430 [nvme_core]
    [<000000001f948cbb>] nvme_mpath_add_disk+0x3ef/0x6a0 [nvme_core]
    [<00000000d405af45>] nvme_alloc_ns+0xeb1/0x1ae0 [nvme_core]
    [<000000002fd9b34d>] nvme_validate_or_alloc_ns+0x170/0x350 [nvme_core]
    [<000000009762df74>] nvme_scan_work+0x2dc/0x4b0 [nvme_core]
    [<000000007be5c512>] process_one_work+0x9a8/0x16b0
    [<000000002ae51314>] worker_thread+0x87/0xbf0
    [<0000000034c41079>] kthread+0x371/0x440
    [<0000000020c3a70f>] ret_from_fork+0x22/0x30
unreferenced object 0xffff8882d1509800 (size 512):
  comm "kworker/u26:2", pid 82, jiffies 4295107562 (age 2911.554s)
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff c0 b6 b7 97 ff ff ff ff  ................
  backtrace:
    [<00000000d6c8d6f1>] kmem_cache_alloc_trace+0x10b/0x220
    [<00000000e6493d28>] device_add+0xe08/0x1d10
    [<00000000aa40e6ce>] cdev_device_add+0xf1/0x150
    [<00000000142436f1>] nvme_cdev_add+0xf8/0x160 [nvme_core]
    [<00000000d948ccab>] nvme_mpath_set_live+0x347/0x430 [nvme_core]
    [<000000001f948cbb>] nvme_mpath_add_disk+0x3ef/0x6a0 [nvme_core]
    [<00000000d405af45>] nvme_alloc_ns+0xeb1/0x1ae0 [nvme_core]
    [<000000002fd9b34d>] nvme_validate_or_alloc_ns+0x170/0x350 [nvme_core]
    [<000000009762df74>] nvme_scan_work+0x2dc/0x4b0 [nvme_core]
    [<000000007be5c512>] process_one_work+0x9a8/0x16b0
    [<000000002ae51314>] worker_thread+0x87/0xbf0
    [<0000000034c41079>] kthread+0x371/0x440
    [<0000000020c3a70f>] ret_from_fork+0x22/0x30


-- 
Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
