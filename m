Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F1BC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Feb 2022 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZeVeQ+lZdn3/5zAA2gF/rBchW6tBhtB5UcuHi6ilZu8=; b=1pW1rawptbCCX5NpKzTjslkeJL
	QAPFKeASEkERIEgvO+YbtF894V+ivtrHjWukcLCcsZFxFrsm6/r6qeV5zuBDaGLGPeCK132MfrhDd
	wYZQKrxkLB9mnQ4rZp5wPzMn+bzosHyY7B1WvSiWpc4C2i+gnlG4ZOaKejsjFaG/4Jv6/jEHlezNk
	w+oUjuzWE0WFO4eW+At2i8cgMHoi4swSqiMzHLia+mEYBzBAPxmNMKO0EbmfPATJHYv5xd5Pzt0LU
	yk+sKvCmPCAwYFQ9cn5gc6fC7JAWGJtJbkvxmuCrPdyzinhDfZkdkLs0qmg13Yk6jz/eKVFTOoQnr
	4cROP8lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nM6Gd-0056e1-Ic; Mon, 21 Feb 2022 10:50:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nM5kF-004pkM-HY
 for linux-nvme@lists.infradead.org; Mon, 21 Feb 2022 10:16:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645438598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZeVeQ+lZdn3/5zAA2gF/rBchW6tBhtB5UcuHi6ilZu8=;
 b=ZT0BU9SmuYruKZp2yGXedxz1m8ESXIAeXDNYXqD9lMXjIywXRpWmskUKWTCK0l6I/PahMb
 UvYjknMTeFjqSTpNp02ZkL+E/eKre5Y37ZeUOb/1JPGBPrZyt1c8oY5bskK8tv8FqwaDcQ
 XVBkqJjyWewn/uAYDx+To313vxiFUOk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-wQOHmX0aOkiimHe6ES0drg-1; Mon, 21 Feb 2022 05:16:36 -0500
X-MC-Unique: wQOHmX0aOkiimHe6ES0drg-1
Received: by mail-pl1-f199.google.com with SMTP id
 c10-20020a170903234a00b0014fbb45ba6eso624948plh.5
 for <linux-nvme@lists.infradead.org>; Mon, 21 Feb 2022 02:16:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZeVeQ+lZdn3/5zAA2gF/rBchW6tBhtB5UcuHi6ilZu8=;
 b=z6mLCiWb83d9q901Rny7dIQOyusTQIdsdH+uu1uChO7JwDK21CSmHMWa2wQR+WHjOy
 UzvudS9o7rBzR8HJwEz5wLMgJvx20ZuEruhR68sMqjQFIf1A8u9HIW6KrHiMDqd5igSW
 7OkkQutKU2A0ReaJdxZxRw0TKyEVPPuaQ6Sf/9mpiRrHfdPRcH/M98worcBv7BBLhjb+
 3RhiP6N73GQENnb0ksuDtN54HumyMT6dp0bvSCuEzLaOwTupTkj82K+cnCXzIccyt/4k
 NUnv4cY81GErYMV3Z16b3TxHjHSjtAbsqjhijTsSXBchDZLEG7CkEmiRyr/I9RFqKwnc
 qF6g==
X-Gm-Message-State: AOAM530mt0Wwu5W0mMTsKwcyGEtGcofnGwifQnbyNMAcBkOz6S4oR60w
 tHGSbH+PN2dr82SI5xjlOS/RK7vUTdF5BNHvcq/+ItAPMfxZYGiuJtQHQdn7h7Zrtma12OsOTM5
 h0fFeFW9c094cUIix9QuYedPFmQJJm63iDPccoEvRCUA=
X-Received: by 2002:a17:90b:3607:b0:1b8:efe5:9008 with SMTP id
 ml7-20020a17090b360700b001b8efe59008mr20737123pjb.163.1645438595249; 
 Mon, 21 Feb 2022 02:16:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFeSWjLYpgHXhaFt/V3JcSL2wyAfwh3tL2hcwfEO9CdDmqL4TeHSTKxFGMw3hxnuM+aHwVlAeRPp7jk0Hb5oU=
X-Received: by 2002:a17:90b:3607:b0:1b8:efe5:9008 with SMTP id
 ml7-20020a17090b360700b001b8efe59008mr20737099pjb.163.1645438594888; Mon, 21
 Feb 2022 02:16:34 -0800 (PST)
MIME-Version: 1.0
References: <20220216022249.2856536-1-cleech@redhat.com>
In-Reply-To: <20220216022249.2856536-1-cleech@redhat.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 21 Feb 2022 18:16:23 +0800
Message-ID: <CAHj4cs_pPtRS_6_y0HXd-2Q-ANKLipC7=pee4_3XCDHCNz_zrw@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme-tcp: lockdep: annotate in-kernel sockets
To: Chris Leech <cleech@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220221_021639_907030_CE2D6F21 
X-CRM114-Status: GOOD (  28.76  )
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

Hi Chris
Thanks for your patch, the WARNING issue was fixed, but the tests
nvme/012 nvme/013 nvme/014 nvme/015 nvme/038 will take more time than
before, you can check the execution log below:


#nvme_trtype=tcp  ./check nvme/
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.403s  ...  10.399s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.539s  ...  1.552s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.740s  ...  1.738s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.266s  ...  0.259s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.312s  ...  0.315s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.602s  ...  1.575s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.623s  ...  1.624s
nvme/010 (run data verification fio job on NVMeOF block device-backed
ns) [passed]
    runtime  112.965s  ...  112.267s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  219.577s  ...  219.101s
nvme/012 (run mkfs and data verification fio job on NVMeOF block
device-backed ns) [passed]
    runtime  88.482s  ...  180.961s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed
ns) [passed]
    runtime  142.780s  ...  257.008s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  9.771s  ...  18.027s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  9.157s  ...  15.595s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.587s  ...  1.784s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.360s  ...  1.571s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.578s  ...  1.752s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.571s  ...  1.756s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.715s  ...  1.947s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.379s  ...  1.553s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.585s  ...  1.758s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.570s  ...  1.762s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.550s  ...  1.740s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.558s  ...  1.723s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.535s  ...  1.720s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.580s  ...  2.058s
nvme/030 (ensure the discovery generation counter is updated
appropriately) [passed]
    runtime  0.408s  ...  0.467s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  2.116s  ...  2.820s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.087s  ...  0.140s
On Wed, Feb 16, 2022 at 10:26 AM Chris Leech <cleech@redhat.com> wrote:
>
> Put NVMe/TCP sockets in their own class to avoid some lockdep warnings.
> Sockets created by nvme-tcp are not exposed to user-space, and will not
> trigger certain code paths that the general socket API exposes.
>
> Lockdep complains about a circular dependency between the socket and
> filesystem locks, because setsockopt can trigger a page fault with a
> socket lock held, but nvme-tcp sends requests on the socket while file
> system locks are held.
>
>   ======================================================
>   WARNING: possible circular locking dependency detected
>   5.15.0-rc3 #1 Not tainted
>   ------------------------------------------------------
>   fio/1496 is trying to acquire lock:
>   (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_sendpage+0x23/0x80
>
>   but task is already holding lock:
>   (&xfs_dir_ilock_class/5){+.+.}-{3:3}, at: xfs_ilock+0xcf/0x290 [xfs]
>
>   which lock already depends on the new lock.
>
>   other info that might help us debug this:
>
>   chain exists of:
>    sk_lock-AF_INET --> sb_internal --> &xfs_dir_ilock_class/5
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(&xfs_dir_ilock_class/5);
>                                 lock(sb_internal);
>                                 lock(&xfs_dir_ilock_class/5);
>    lock(sk_lock-AF_INET);
>
>   *** DEADLOCK ***
>
>   6 locks held by fio/1496:
>    #0: (sb_writers#13){.+.+}-{0:0}, at: path_openat+0x9fc/0xa20
>    #1: (&inode->i_sb->s_type->i_mutex_dir_key){++++}-{3:3}, at: path_openat+0x296/0xa20
>    #2: (sb_internal){.+.+}-{0:0}, at: xfs_trans_alloc_icreate+0x41/0xd0 [xfs]
>    #3: (&xfs_dir_ilock_class/5){+.+.}-{3:3}, at: xfs_ilock+0xcf/0x290 [xfs]
>    #4: (hctx->srcu){....}-{0:0}, at: hctx_lock+0x51/0xd0
>    #5: (&queue->send_mutex){+.+.}-{3:3}, at: nvme_tcp_queue_rq+0x33e/0x380 [nvme_tcp]
>
> This annotation lets lockdep analyze nvme-tcp controlled sockets
> independently of what the user-space sockets API does.
>
> Link: https://lore.kernel.org/linux-nvme/CAHj4cs9MDYLJ+q+2_GXUK9HxFizv2pxUryUR0toX974M040z7g@mail.gmail.com/
>
> Signed-off-by: Chris Leech <cleech@redhat.com>
> ---
>  drivers/nvme/host/tcp.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 891a36d02e7c..f1b27e8b9b70 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -30,6 +30,44 @@ static int so_priority;
>  module_param(so_priority, int, 0644);
>  MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
>
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +/* lockdep can detect a circular dependency of the form
> + *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
> + * because dependencies are tracked for both nvme-tcp and user contexts. Using
> + * a separate class prevents lockdep from conflating nvme-tcp socket use with
> + * user-space socket API use.
> + */
> +static struct lock_class_key nvme_tcp_sk_key[2];
> +static struct lock_class_key nvme_tcp_slock_key[2];
> +
> +static void nvme_tcp_reclassify_socket(struct socket *sock)
> +{
> +       struct sock *sk = sock->sk;
> +
> +       if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
> +               return;
> +
> +       switch (sk->sk_family) {
> +       case AF_INET:
> +               sock_lock_init_class_and_name(sk, "slock-AF_INET-NVME",
> +                                             &nvme_tcp_slock_key[0],
> +                                             "sk_lock-AF_INET-NVME",
> +                                             &nvme_tcp_sk_key[0]);
> +               break;
> +       case AF_INET6:
> +               sock_lock_init_class_and_name(sk, "slock-AF_INET6-NVME",
> +                                             &nvme_tcp_slock_key[1],
> +                                             "sk_lock-AF_INET6-NVME",
> +                                             &nvme_tcp_sk_key[1]);
> +               break;
> +       default:
> +               WARN_ON_ONCE(1);
> +       }
> +}
> +#else
> +static void nvme_tcp_reclassify_socket(struct socket *sock) { }
> +#endif
> +
>  enum nvme_tcp_send_state {
>         NVME_TCP_SEND_CMD_PDU = 0,
>         NVME_TCP_SEND_H2C_PDU,
> @@ -1435,6 +1473,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
>                 goto err_destroy_mutex;
>         }
>
> +       nvme_tcp_reclassify_socket(queue->sock);
> +
>         /* Single syn retry */
>         tcp_sock_set_syncnt(queue->sock->sk, 1);
>
> --
> 2.34.1
>
>


-- 
Best Regards,
  Yi Zhang


