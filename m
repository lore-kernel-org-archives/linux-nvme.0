Return-Path: <SRS0=bzk4=OV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B5BC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Oct 2021 00:28:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED39D619F8
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Oct 2021 00:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED39D619F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1ANwWzDrksBScXhLMOxNOmbrkXjojgsD1TzBkIhIYV0=; b=1TiIzLfdvh7zGF
	M98CgyPDskuZVqt5Uwede15u1OGsH74bCMUd3VxzaFhjT1HJRRquW+VUxr1tP05yCrFaK17BLOm//
	z8Plny+BZRd1jjAyg3KAdTnBfIeoab425YVYUOUvPGR4uY7jwXOZQUh3Yx7nziHnKpZV+ZiWtMoD7
	nolYriS3nGitSTO4rU0VKcooXuR1g1ijDUzxuR3YlrC+bRX3A/nmUOH8nfOJHsO+HBn/b+9pg1w2G
	rUb0h9DaEpYGurNY/By0JG1hhUkjcCVSmg5+Z6KB1iK6wZoggQHrSUqqfl4lh0AwqayyErCZo3U7V
	n+vwYxIxCF0kPtJm9cuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mW6P3-00GLuC-Fs; Fri, 01 Oct 2021 00:27:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mW6OX-00GLt7-Q2
 for linux-nvme@lists.infradead.org; Fri, 01 Oct 2021 00:27:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633048039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tGVTyUbL36S0B3ERganhD58qVs31BZF00/P/1q7b1Pk=;
 b=KswhOPzQYGI0o2KguoZvwQgyTrqB5sgSvv2vm+qex81A5JfX014ytqjX+11ZDLE4aVN47d
 9EEkN/3amjRXrv2e0aADFdaWDaVwN9e5QyHpxrAZ4/7vURQHb3BU5Aq2Kw/be9ayL4ZyLH
 lDSTFBWKcu7luy4Xx89qYtAPnnS1w7o=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-osl_POsDNhGWcsVooDLF5A-1; Thu, 30 Sep 2021 20:27:18 -0400
X-MC-Unique: osl_POsDNhGWcsVooDLF5A-1
Received: by mail-yb1-f200.google.com with SMTP id
 z130-20020a256588000000b005b6b4594129so11107371ybb.15
 for <linux-nvme@lists.infradead.org>; Thu, 30 Sep 2021 17:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tGVTyUbL36S0B3ERganhD58qVs31BZF00/P/1q7b1Pk=;
 b=ryJ6iGSg3FbtRSTve4zYcDmKGNjUzlVzrYUvJ8hY+y1jjwAN5XZHwkzrOOhy5EYGGx
 tYXhCzjSxSexaBUXitTPLujgMoOpltzAa7D6JFSKwQZ9120iMrbcVP9A8FV6DuKqwtvI
 PvHMNAtYRDkuMOZ1XFbyo0RJ6RVBG6WR5Y0BBmqxpwiMUf53OE9GO63hurzgF3zFDPpy
 b/xkAPj40NSpRB/y2E460YtDpHrWgEm30tC6ImJPjdqm9XYyJn/9XxLqEb1dzdHslf//
 PV6Vuj8feJdQwhNV/MDdUYj9I+YMRl7bMYau/hgPwObhCBbgUQ1fI4QBHz44iXW6z8ec
 wQOg==
X-Gm-Message-State: AOAM5323YCZ+FNkfDT5z02tBvEA9rbkf1gsvAAJL1ktRY4ivft1801yz
 3qgFeOAFsEe++xqjZxkGAEu9krGZB6TUe4jUhjiH510aLZjR3Be5ugpe8QX8J8D8EfBZjNcGKZk
 E3NlWYh8dy5dzxsvknybWXRt8W2I6cMn/v44GUrPU9oU=
X-Received: by 2002:a25:bd03:: with SMTP id f3mr2465873ybk.412.1633048037212; 
 Thu, 30 Sep 2021 17:27:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw20SIZX99kuiDl/e14K3mzsGHJXhWF4N4WGRDnjr4Rp6jeBco0/+KUkNf2nRVeHs9lZLfp3JJGpBm2X3bS6dI=
X-Received: by 2002:a25:bd03:: with SMTP id f3mr2465833ybk.412.1633048036947; 
 Thu, 30 Sep 2021 17:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8pcLTjHMhh_0vebWUgwTY+UtYoKAhQntCsFvKM4zcKfA@mail.gmail.com>
 <caa2467e-9763-b9dd-db91-4cb7020bab47@nvidia.com>
 <CAHj4cs_NqB6WYQQOpqjoOFvTbbN_VydJkn1VquzTkyGpFqMM2Q@mail.gmail.com>
 <0a8810e0-4c42-4275-acd6-475fd42485fe@grimberg.me>
 <CAHj4cs_icpHAf7wN3LFt7avcPcrhjOYiSnU8SnCLQN1ObkRV1Q@mail.gmail.com>
 <CAHj4cs9QBFXca-rnP05ZmWBKDJv4aviiDQ=q2_JihMQuESE7OA@mail.gmail.com>
 <1b992460-26a6-cff6-bee4-b81ac28e93f5@grimberg.me>
In-Reply-To: <1b992460-26a6-cff6-bee4-b81ac28e93f5@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 1 Oct 2021 08:27:05 +0800
Message-ID: <CAHj4cs8Vff_C8FnFciHtYdnifoOHBrNtaGN1Fvpg5m2gV8JpZw@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed with blktests nvme-tcp tests
To: Sagi Grimberg <sagi@grimberg.me>
Cc: minwoo.im.dev@gmail.com, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_172722_084389_76387E5F 
X-CRM114-Status: GOOD (  18.93  )
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

On Thu, Sep 30, 2021 at 10:07 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Bisect shows it was introduced from the below commit:
> >
> > commit 2637baed78010eeaae274feb5b99ce90933fadfb
> > Author: Minwoo Im <minwoo.im.dev@gmail.com>
> > Date:   Wed Apr 21 16:45:04 2021 +0900
> >
> >      nvme: introduce generic per-namespace chardev
> >
>
> Makes sense as both leaks relate to the nshead cdev...
>
> I think another put on the cdev_device is missing?
> --
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1d103ae4afdf..328e314af199 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3668,6 +3668,7 @@ void nvme_cdev_del(struct cdev *cdev, struct
> device *cdev_device)
>   {
>          cdev_device_del(cdev, cdev_device);
>          ida_simple_remove(&nvme_ns_chr_minor_ida,
> MINOR(cdev_device->devt));
> +       put_device(cdev_device);
>   }
>
>   int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
> --
>

Hi Sagi

This introduced one new issue, here is the log:

[  250.764659] run blktests nvme/004 at 2021-09-30 20:23:39
[  250.938913] loop0: detected capacity change from 0 to 2097152
[  250.963292] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  250.976418] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  251.003499] nvmet: creating controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
[  251.020277] nvme nvme0: creating 32 I/O queues.
[  251.050637] nvme nvme0: mapped 32/0/0 default/read/poll queues.
[  251.091232] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420
[  252.179608] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[  252.228383] ------------[ cut here ]------------
[  252.234400] Device 'ng0n1' does not have a release() function, it
is broken and must be fixed. See Documentation/core-api/kobject.rst.
[  252.246498] WARNING: CPU: 10 PID: 2086 at drivers/base/core.c:2198
device_release+0x189/0x210
[  252.255029] Modules linked in: nvme_tcp nvme_fabrics nvme_core
nvmet_tcp nvmet loop rfkill sunrpc vfat fat dm_multipath iTCO_wdt
iTCO_vendor_support ipmi_ssif intel_rapl_msr intel_rapl_common
isst_if_common skx_edac x86_pkg_temp_thermal intel_powerclamp coretemp
kvm_intel mgag200 i2c_algo_bit kvm drm_kms_helper dell_smbios
irqbypass crct10dif_pclmul crc32_pclmul syscopyarea sysfillrect
sysimgblt dcdbas fb_sys_fops ghash_clmulni_intel cec rapl intel_cstate
drm intel_uncore mei_me dell_wmi_descriptor wmi_bmof pcspkr i2c_i801
mei acpi_ipmi i2c_smbus lpc_ich ipmi_si ipmi_devintf ipmi_msghandler
dax_pmem_compat nd_pmem device_dax nd_btt dax_pmem_core
acpi_power_meter xfs libcrc32c sd_mod t10_pi sg ahci libahci libata
tg3 megaraid_sas crc32c_intel wmi nfit libnvdimm dm_mirror
dm_region_hash dm_log dm_mod [last unloaded: nvmet]
[  252.327704] CPU: 10 PID: 2086 Comm: nvme Tainted: G S        I
 5.15.0-rc3.v1.fix+ #4
[  252.335974] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
2.11.2 004/21/2021
[  252.343635] RIP: 0010:device_release+0x189/0x210
[  252.348262] Code: 48 8d 7b 50 48 89 fa 48 c1 ea 03 80 3c 02 00 0f
85 88 00 00 00 48 8b 73 50 48 85 f6 74 13 48 c7 c7 60 cb 18 af e8 dc
fb c5 00 <0f> 0b e9 0b ff ff ff 48 b8 00 00 00 00 00 fc ff df 48 89 da
48 c1
[  252.367015] RSP: 0018:ffffc90003d5fb00 EFLAGS: 00010282
[  252.372249] RAX: 0000000000000000 RBX: ffff8882a5474a48 RCX: ffffffffad731d52
[  252.379393] RDX: 0000000000000004 RSI: 0000000000000008 RDI: ffff888e259e3b2c
[  252.386533] RBP: ffff8882e390ec00 R08: ffffed11c4b3d9b9 R09: ffffed11c4b3d9b9
[  252.393675] R10: ffff888e259ecdc7 R11: ffffed11c4b3d9b8 R12: ffff8882e328b500
[  252.400812] R13: ffff88852e9ee500 R14: 0000000000000000 R15: ffffc90003d5fbf8
[  252.407946] FS:  00007f6f3cad2780(0000) GS:ffff888e25800000(0000)
knlGS:0000000000000000
[  252.416040] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  252.421795] CR2: 000055c593c2e6b0 CR3: 00000002a1aec006 CR4: 00000000007706e0
[  252.428937] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  252.436078] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  252.443221] PKRU: 55555554
[  252.445941] Call Trace:
[  252.448403]  kobject_release+0x109/0x3a0
[  252.452338]  nvme_mpath_shutdown_disk+0x92/0xe0 [nvme_core]
[  252.457929]  nvme_ns_remove+0x4a3/0x7f0 [nvme_core]
[  252.462824]  ? up_write+0x14d/0x460
[  252.466324]  nvme_remove_namespaces+0x242/0x3a0 [nvme_core]
[  252.471914]  ? nvme_execute_passthru_rq+0x5a0/0x5a0 [nvme_core]
[  252.477852]  ? del_timer_sync+0xab/0xf0
[  252.481699]  nvme_do_delete_ctrl+0xaa/0x108 [nvme_core]
[  252.486941]  nvme_sysfs_delete.cold.100+0x8/0xd [nvme_core]
[  252.492532]  kernfs_fop_write_iter+0x2d0/0x490
[  252.496984]  ? trace_hardirqs_on+0x1c/0x150
[  252.501180]  new_sync_write+0x3b2/0x620
[  252.505026]  ? rcu_read_lock_held_common+0xe/0xa0
[  252.509742]  ? new_sync_read+0x610/0x610
[  252.513677]  ? rcu_tasks_trace_pregp_step+0xe1/0x170
[  252.518651]  ? rcu_read_lock_held_common+0xe/0xa0
[  252.523368]  ? rcu_read_lock_sched_held+0x5f/0xd0
[  252.528082]  ? rcu_read_unlock+0x40/0x40
[  252.532016]  ? rcu_read_lock_held+0xb0/0xb0
[  252.536212]  vfs_write+0x4b5/0x950
[  252.539626]  ksys_write+0xf1/0x1c0
[  252.543039]  ? __ia32_sys_read+0xb0/0xb0
[  252.546975]  do_syscall_64+0x37/0x80
[  252.550563]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  252.555621] RIP: 0033:0x7f6f3c1bb648
[  252.559209] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00
00 00 f3 0f 1e fa 48 8d 05 55 6f 2d 00 8b 00 85 c0 75 17 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89
d4 55
[  252.577965] RSP: 002b:00007fff4826bb88 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  252.585537] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f6f3c1bb648
[  252.592679] RDX: 0000000000000001 RSI: 000055c593c70da5 RDI: 0000000000000004
[  252.599821] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
[  252.606962] R10: 0000000000000000 R11: 0000000000000246 R12: 000055c5945d7540
[  252.614102] R13: 00007fff4826e0fc R14: 0000000000000008 R15: 0000000000000003
[  252.621246] irq event stamp: 0
[  252.624310] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[  252.630585] hardirqs last disabled at (0): [<ffffffffac9d68f3>]
copy_process+0x2023/0x6b20
[  252.638854] softirqs last  enabled at (0): [<ffffffffac9d6932>]
copy_process+0x2062/0x6b20
[  252.647121] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  252.653396] ---[ end trace 96526c0d562adac3 ]---


-- 
Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
