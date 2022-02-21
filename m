Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65099C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Feb 2022 13:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XV77O2+22zDtjFuEpVNaAxOO3yTDMtaxVMxo4p+73Ys=; b=MQUFRH3gLpgDce7Q6AOhLrzxL/
	V6Xn/2a0k1LBtesMFoevcIX9dwg81CNjpUheR/dzCI/pqF0Tsh622oTtJN44MV5zLsTjTdVouacDt
	FbLK3Xrq4T4P1MnneTPaR1lcl14dz6nc6+JhmW/5+N5vyEktOCBXAmC99LiTEJj44+DVnVnNvoyp0
	gkuZ7BD3iymBUUelwVNxV4Rykcq0/e5WxaYJm9c78z175wSh/eumJQGhwzFeM5fCyr4n5s63z4f49
	zY4/wdcHNsyX1AHCx/ZyTPlMiC6InQcTEDwpW93wqx2OU+ed0QpRZ4x49R6RwtUxI2ShI0aEqiE4U
	3fRayfMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nM8i6-005u1X-Ms; Mon, 21 Feb 2022 13:26:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nM7wu-005grX-KQ
 for linux-nvme@lists.infradead.org; Mon, 21 Feb 2022 12:37:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645447069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XV77O2+22zDtjFuEpVNaAxOO3yTDMtaxVMxo4p+73Ys=;
 b=e46gEOUNjR+UvvsO6xsMCJj7IdeFpEBFv5AzoAW+SnFWYRcR6niHv5zPYiG3KBN5HcbIic
 uTAZ3ryfwRagmo9Sg8sCzLW/26wRUC9XiPaVunShBs4ny5MT5IMH5eNYvbEzQlxQKmYQuj
 TNnxJcThH7AprWrHqPF7TnQKZR5dDP0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-mfFqo8WgPhmlI-V0X2aNfA-1; Mon, 21 Feb 2022 07:37:48 -0500
X-MC-Unique: mfFqo8WgPhmlI-V0X2aNfA-1
Received: by mail-pj1-f70.google.com with SMTP id
 q40-20020a17090a17ab00b001bafa89b70aso8253634pja.2
 for <linux-nvme@lists.infradead.org>; Mon, 21 Feb 2022 04:37:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XV77O2+22zDtjFuEpVNaAxOO3yTDMtaxVMxo4p+73Ys=;
 b=xIZAmpLNmiiXQ8VwqWiuKaAJnz/mPRarSZ34y05ZQ0bNBwj4PCPjnL3vx0dZD4IcPP
 imzsG+5b+3MD7fD9QQS/xoIT7QT4Y6hkHJ2FopHBETDlVHTMgDvh5bu2mli9mSqu0UJW
 4k//+oXF+sv1DvEI2yo5J9yMj4rDDRAuNCaoqUMmoYNbjXAsGk/4D2+qHZvcJ4/7gsLP
 y+LKsvCD68hd0jgDLoUE5EV8AZ/d0VrBsewGKrXsI8MEVQbEAMYnuPnmebZrTW5QsRGh
 h/Ob37gbaK5aQftctnvv2TI5hsRrAMQHaRVNC/1j2o2ea5sb32F1db2ZS+lWgU9pGMWq
 1TxQ==
X-Gm-Message-State: AOAM531Fmfz1MQcdsGxjoZUA7hlwnHaFqG7mzZSzPnYiCwFSWC/JUAY/
 I3kBD9aqLXg1iZbh9RmJuE/5/mNw0XajlFAg07m4BMFHv7WfauSMTakjDztpqUDUsm2dJK4P/qX
 rLXey4MR05Np2lomV1N0kcMHHDmpIg1ewyDqCATzH+qU=
X-Received: by 2002:a62:e90f:0:b0:4d1:7437:f0c2 with SMTP id
 j15-20020a62e90f000000b004d17437f0c2mr19953767pfh.5.1645447067046; 
 Mon, 21 Feb 2022 04:37:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzixRnA8+DunkkS5x+iGYLT96XMjkOmR40D3b+P+um2eJ4jwjynrDD/f05ZFc6Qi7y65d8ojFEcMoUM+/e+XlA=
X-Received: by 2002:a62:e90f:0:b0:4d1:7437:f0c2 with SMTP id
 j15-20020a62e90f000000b004d17437f0c2mr19953743pfh.5.1645447066738; Mon, 21
 Feb 2022 04:37:46 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
In-Reply-To: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 21 Feb 2022 20:37:35 +0800
Message-ID: <CAHj4cs_LZoohRngyjz8GZCZfK+XOTT5-3ihxnwOVD2jwGEKygw@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with
 nvme-rdma testing
To: RDMA mailing list <linux-rdma@vger.kernel.org>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220221_043752_786168_D730A6C2 
X-CRM114-Status: UNSURE (   9.35  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

add linux-nvme maillist
On Mon, Feb 21, 2022 at 7:37 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hello
>
> Below kmemleak triggered when I do nvme connect/reset/disconnect
> operations on latest 5.17.0-rc5, pls check it.
>
> # cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff8883e398bc00 (size 192):
>   comm "nvme", pid 2632, jiffies 4295317772 (age 2951.476s)
>   hex dump (first 32 bytes):
>     80 50 84 a3 ff ff ff ff 70 d4 12 67 81 88 ff ff  .P......p..g....
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
>     [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
>     [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
>     [<00000000aade682c>] blk_alloc_queue+0x400/0x840
>     [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
>     [<00000000cbff6d39>] nvme_rdma_setup_ctrl+0x4ca/0x15f0 [nvme_rdma]
>     [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
>     [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
>     [<0000000031d8624b>] vfs_write+0x17e/0x9a0
>     [<00000000471d7945>] ksys_write+0xf1/0x1c0
>     [<00000000a963bc79>] do_syscall_64+0x3a/0x80
>     [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> unreferenced object 0xffff8883e398a700 (size 192):
>   comm "nvme", pid 2632, jiffies 4295317782 (age 2951.466s)
>   hex dump (first 32 bytes):
>     80 50 84 a3 ff ff ff ff 60 c8 12 67 81 88 ff ff  .P......`..g....
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
>     [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
>     [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
>     [<00000000aade682c>] blk_alloc_queue+0x400/0x840
>     [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
>     [<000000004f80b965>] nvme_rdma_setup_ctrl+0xf37/0x15f0 [nvme_rdma]
>     [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
>     [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
>     [<0000000031d8624b>] vfs_write+0x17e/0x9a0
>     [<00000000471d7945>] ksys_write+0xf1/0x1c0
>     [<00000000a963bc79>] do_syscall_64+0x3a/0x80
>     [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> unreferenced object 0xffff8894253d9d00 (size 192):
>   comm "nvme", pid 2632, jiffies 4295331915 (age 2937.333s)
>   hex dump (first 32 bytes):
>     80 50 84 a3 ff ff ff ff 80 e0 12 67 81 88 ff ff  .P.........g....
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
>     [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
>     [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
>     [<00000000aade682c>] blk_alloc_queue+0x400/0x840
>     [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
>     [<000000009f9abba5>] nvme_rdma_setup_ctrl.cold.70+0x5ee/0xb01 [nvme_rdma]
>     [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
>     [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
>     [<0000000031d8624b>] vfs_write+0x17e/0x9a0
>     [<00000000471d7945>] ksys_write+0xf1/0x1c0
>     [<00000000a963bc79>] do_syscall_64+0x3a/0x80
>     [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
>
>
> --
> Best Regards,
>   Yi Zhang



-- 
Best Regards,
  Yi Zhang


