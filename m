Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E0CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Feb 2022 11:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O+HxDd1vzCZ6FaFkP68KpUsEhj6anxCocqUNp8YRoqQ=; b=IhSpc2IXybMNIIXZyuYYjNwTB7
	7ZOh4Szkrz7udnPcB81Gj57G7TYZtWpmG4Qw9MXwW5U/ylm0tfPmCUrU7jWyAZmzpWIH6PwqYvfKT
	8x4lHxOLWTfryWQyQHEDMGJBE0NhQpvSnnCzCkHAsMvYeC8+Kn44kB3eZ74oeTaZxLuOqJdzJ4khB
	Vz5eBAAkLuOV6VYEEuNM7rR8NF83PNyKWe6OF9z6sGpR0PK2djfrT6hcR2PaINZk6ZN04icTqFyu/
	X8u+mzw++rh9rmRiqTmfns376wUpqSJ5U1c+vs5SwGqpLODJ1ANKxx71mETwWF+l7TtIqb53Xito9
	ggNEdlbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nM70l-005Oog-FV; Mon, 21 Feb 2022 11:37:47 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nM70c-005OkZ-S4
 for linux-nvme@lists.infradead.org; Mon, 21 Feb 2022 11:37:45 +0000
Received: by mail-ed1-f46.google.com with SMTP id m17so28669114edc.13
 for <linux-nvme@lists.infradead.org>; Mon, 21 Feb 2022 03:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=O+HxDd1vzCZ6FaFkP68KpUsEhj6anxCocqUNp8YRoqQ=;
 b=hhS6UrezBZphDHze3sFc9tFkajkr+CAKY3DgBidAwvI8/QcJq53YuTRyrxM7W8BbA0
 ChtDOS4FXkdI2POlcrZZKlqidVX+by2J1SakX8aLH6RQ1WzIu/qbXnJ3a6maiOmaQuKc
 l9A88IcHKwHCIYEdyYmyk/paHiZFzGZVoo/nz5V6/DJixxyax/S5CCvB+fWYaT4UuAZV
 VD9fjBdF3G1gsq89jmbdc9/cApHCIlB3hZo3sXOVf/IMT5YxN1PbCO+Upq6fBDe6j6ks
 geiTJh1ngMl3NtbwLC3iPcWWuM3ug9Eaq0AyInm/9Z3/uMi2AL0iNDfGqD4ZcamGda79
 KIBg==
X-Gm-Message-State: AOAM533wckAsYQgJApKpVWQh7YfuevpZ2QU7SgV1gbndOXDy86UFKSA5
 ehyleRvEKTxkP0rPpjdXU8LFMb4D1SM=
X-Google-Smtp-Source: ABdhPJwR/5RE9E+nGd58wUbsiNNdHlrrusj9ILDw9sjB/4dHRTJroNmCWQqtXELWJed08pJujoTXTg==
X-Received: by 2002:a50:fb19:0:b0:404:eb52:62cb with SMTP id
 d25-20020a50fb19000000b00404eb5262cbmr20568984edq.363.1645443456775; 
 Mon, 21 Feb 2022 03:37:36 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id a13sm5674301edn.25.2022.02.21.03.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Feb 2022 03:37:36 -0800 (PST)
Message-ID: <703dea8c-60ba-58f3-9b20-24d26e43d3e1@grimberg.me>
Date: Mon, 21 Feb 2022 13:37:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] nvme-tcp: lockdep: annotate in-kernel sockets
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>, Chris Leech <cleech@redhat.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <20220216022249.2856536-1-cleech@redhat.com>
 <CAHj4cs_pPtRS_6_y0HXd-2Q-ANKLipC7=pee4_3XCDHCNz_zrw@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs_pPtRS_6_y0HXd-2Q-ANKLipC7=pee4_3XCDHCNz_zrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220221_033738_973527_2A289B66 
X-CRM114-Status: GOOD (  24.37  )
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

> Hi Chris
> Thanks for your patch, the WARNING issue was fixed, but the tests
> nvme/012 nvme/013 nvme/014 nvme/015 nvme/038 will take more time than
> before, you can check the execution log below:

Strange... Chris, can you look into the difference?

> 
> 
> #nvme_trtype=tcp  ./check nvme/
> nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
>      runtime  10.403s  ...  10.399s
> nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
>      runtime  1.539s  ...  1.552s
> nvme/005 (reset local loopback target)                       [passed]
>      runtime  1.740s  ...  1.738s
> nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
>      runtime  0.266s  ...  0.259s
> nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
>      runtime  0.312s  ...  0.315s
> nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
>      runtime  1.602s  ...  1.575s
> nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
>      runtime  1.623s  ...  1.624s
> nvme/010 (run data verification fio job on NVMeOF block device-backed
> ns) [passed]
>      runtime  112.965s  ...  112.267s
> nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
>      runtime  219.577s  ...  219.101s
> nvme/012 (run mkfs and data verification fio job on NVMeOF block
> device-backed ns) [passed]
>      runtime  88.482s  ...  180.961s
> nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed
> ns) [passed]
>      runtime  142.780s  ...  257.008s
> nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
>      runtime  9.771s  ...  18.027s
> nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
>      runtime  9.157s  ...  15.595s
> nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
>      runtime  1.587s  ...  1.784s
> nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
>      runtime  1.360s  ...  1.571s
> nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
>      runtime  1.578s  ...  1.752s
> nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
>      runtime  1.571s  ...  1.756s
> nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
>      runtime  1.715s  ...  1.947s
> nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
>      runtime  1.379s  ...  1.553s
> nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
>      runtime  1.585s  ...  1.758s
> nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
>      runtime  1.570s  ...  1.762s
> nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
>      runtime  1.550s  ...  1.740s
> nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
>      runtime  1.558s  ...  1.723s
> nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
>      runtime  1.535s  ...  1.720s
> nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
>      runtime  1.580s  ...  2.058s
> nvme/030 (ensure the discovery generation counter is updated
> appropriately) [passed]
>      runtime  0.408s  ...  0.467s
> nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
>      runtime  2.116s  ...  2.820s
> nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
>      runtime  0.087s  ...  0.140s
> On Wed, Feb 16, 2022 at 10:26 AM Chris Leech <cleech@redhat.com> wrote:
>>
>> Put NVMe/TCP sockets in their own class to avoid some lockdep warnings.
>> Sockets created by nvme-tcp are not exposed to user-space, and will not
>> trigger certain code paths that the general socket API exposes.
>>
>> Lockdep complains about a circular dependency between the socket and
>> filesystem locks, because setsockopt can trigger a page fault with a
>> socket lock held, but nvme-tcp sends requests on the socket while file
>> system locks are held.
>>
>>    ======================================================
>>    WARNING: possible circular locking dependency detected
>>    5.15.0-rc3 #1 Not tainted
>>    ------------------------------------------------------
>>    fio/1496 is trying to acquire lock:
>>    (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_sendpage+0x23/0x80
>>
>>    but task is already holding lock:
>>    (&xfs_dir_ilock_class/5){+.+.}-{3:3}, at: xfs_ilock+0xcf/0x290 [xfs]
>>
>>    which lock already depends on the new lock.
>>
>>    other info that might help us debug this:
>>
>>    chain exists of:
>>     sk_lock-AF_INET --> sb_internal --> &xfs_dir_ilock_class/5
>>
>>    Possible unsafe locking scenario:
>>
>>          CPU0                    CPU1
>>          ----                    ----
>>     lock(&xfs_dir_ilock_class/5);
>>                                  lock(sb_internal);
>>                                  lock(&xfs_dir_ilock_class/5);
>>     lock(sk_lock-AF_INET);
>>
>>    *** DEADLOCK ***
>>
>>    6 locks held by fio/1496:
>>     #0: (sb_writers#13){.+.+}-{0:0}, at: path_openat+0x9fc/0xa20
>>     #1: (&inode->i_sb->s_type->i_mutex_dir_key){++++}-{3:3}, at: path_openat+0x296/0xa20
>>     #2: (sb_internal){.+.+}-{0:0}, at: xfs_trans_alloc_icreate+0x41/0xd0 [xfs]
>>     #3: (&xfs_dir_ilock_class/5){+.+.}-{3:3}, at: xfs_ilock+0xcf/0x290 [xfs]
>>     #4: (hctx->srcu){....}-{0:0}, at: hctx_lock+0x51/0xd0
>>     #5: (&queue->send_mutex){+.+.}-{3:3}, at: nvme_tcp_queue_rq+0x33e/0x380 [nvme_tcp]
>>
>> This annotation lets lockdep analyze nvme-tcp controlled sockets
>> independently of what the user-space sockets API does.
>>
>> Link: https://lore.kernel.org/linux-nvme/CAHj4cs9MDYLJ+q+2_GXUK9HxFizv2pxUryUR0toX974M040z7g@mail.gmail.com/
>>
>> Signed-off-by: Chris Leech <cleech@redhat.com>
>> ---
>>   drivers/nvme/host/tcp.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 891a36d02e7c..f1b27e8b9b70 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -30,6 +30,44 @@ static int so_priority;
>>   module_param(so_priority, int, 0644);
>>   MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
>>
>> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
>> +/* lockdep can detect a circular dependency of the form
>> + *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
>> + * because dependencies are tracked for both nvme-tcp and user contexts. Using
>> + * a separate class prevents lockdep from conflating nvme-tcp socket use with
>> + * user-space socket API use.
>> + */
>> +static struct lock_class_key nvme_tcp_sk_key[2];
>> +static struct lock_class_key nvme_tcp_slock_key[2];
>> +
>> +static void nvme_tcp_reclassify_socket(struct socket *sock)
>> +{
>> +       struct sock *sk = sock->sk;
>> +
>> +       if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
>> +               return;
>> +
>> +       switch (sk->sk_family) {
>> +       case AF_INET:
>> +               sock_lock_init_class_and_name(sk, "slock-AF_INET-NVME",
>> +                                             &nvme_tcp_slock_key[0],
>> +                                             "sk_lock-AF_INET-NVME",
>> +                                             &nvme_tcp_sk_key[0]);
>> +               break;
>> +       case AF_INET6:
>> +               sock_lock_init_class_and_name(sk, "slock-AF_INET6-NVME",
>> +                                             &nvme_tcp_slock_key[1],
>> +                                             "sk_lock-AF_INET6-NVME",
>> +                                             &nvme_tcp_sk_key[1]);
>> +               break;
>> +       default:
>> +               WARN_ON_ONCE(1);
>> +       }
>> +}
>> +#else
>> +static void nvme_tcp_reclassify_socket(struct socket *sock) { }
>> +#endif
>> +
>>   enum nvme_tcp_send_state {
>>          NVME_TCP_SEND_CMD_PDU = 0,
>>          NVME_TCP_SEND_H2C_PDU,
>> @@ -1435,6 +1473,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
>>                  goto err_destroy_mutex;
>>          }
>>
>> +       nvme_tcp_reclassify_socket(queue->sock);
>> +
>>          /* Single syn retry */
>>          tcp_sock_set_syncnt(queue->sock->sk, 1);
>>
>> --
>> 2.34.1
>>
>>
> 
> 

