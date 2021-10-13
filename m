Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A250C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 11:18:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C905361027
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 11:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C905361027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zaWDpHpo5UNP7NPrVx13tTSZVksQrcHwttmhRihYdlg=; b=B8tpWTaY08lvrC
	LyhGxWDaPHXz9thNi0JqloCsb11AvHMTXe8TfF/90zxd98AB+LFcUvByS9/9yNvJNNBZnEi412iZX
	qfjRXLXfH5sl+pl5B0/vQCgJ3nG5lt1CWj8/u9HvtowxwW9I116+BElCZKmyWaFcHGIEb+zVR17n3
	Y14w/x3KcllMbeqxRSmhEFmpajBAAEMwSOFj1wLtVKtAakPVgHryqtQfNgeCrNwKHauZZyXHQ4iaG
	iIqDNXPg+AV4E+QWqjbPbmyHSehP3NxVSGBKpfaP5rRFIJR3zPLW7WT8g4xF889/auuNvJHBawrV3
	ghlP8AVIC/ytwXwAaO+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1macHD-00GGDz-OC; Wed, 13 Oct 2021 11:18:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maaeg-00FmPu-Co
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 09:34:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634117671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gAoPJUI5dBXQXBQUPXZ+jEQfE2wjGpzBmBaeMOakwsg=;
 b=JHuYR13FBNkA3sQqFY8vLwwRj4wQpZ9Va2NKxklkYwcfxguJH1htWBZbtDuN4RTJCGkoqr
 n10nzrHKtpYmnm3cSMisq7AAGn3XV+ZtnC1lBnfrtCN4GlNuBcL/MF4dUG9kqa3jVyDoeH
 5sNDheK4jRgGIekjjs931oK12N2t2EI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-a4pRQ9qhNsCBHHuPMEfAIA-1; Wed, 13 Oct 2021 05:34:28 -0400
X-MC-Unique: a4pRQ9qhNsCBHHuPMEfAIA-1
Received: by mail-yb1-f199.google.com with SMTP id
 s66-20020a252c45000000b005ba35261459so2550997ybs.7
 for <linux-nvme@lists.infradead.org>; Wed, 13 Oct 2021 02:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gAoPJUI5dBXQXBQUPXZ+jEQfE2wjGpzBmBaeMOakwsg=;
 b=PmbNjx3LdxAGC3eGsRjIOEoUsWaIF1Ayc0D+4zyd5EPiBR/eFhWsVxJhm96fL1Tkri
 VX+kXTPG+ZibzjNcGLpcsm2OS7//Md86Eb3RW2Nu65uuGGp9GoAqCk3whcU+tSDBB827
 br4k1/xDFdiF+XmxVt8wOXdiJ3DrYF7F3mTDkrZQ1ONKTlCv59XCkQYqwoc1GmpZbdwj
 FfX3Y9pP6StJ0mZGnZNdEANFP/oltNgNfFeyMDiHWSbOpT1v+xSbY5HlVKkJ7GIV97xM
 NH7F3yhMtqUDEnbIM14RXVf42nvHihRbHu0fvM3v+jMfZQN35uqh6BwNj/a7qGWIqLOt
 36Qw==
X-Gm-Message-State: AOAM531aEgh8XGEpUSzcd3XkR/Et6Nl317a0xb6bNTpmWK3hro6tkmV7
 gfiZYcL1WaJNJikEMmLuXduwYQ4njMGqXBz4tXbpVuQnQRbbApVAPghvaVPGJGwqjlgWBYXpbmq
 yxeeW+dNIYtOLOeFnxnjec2EA9M4Nm0LEWkxUEo7iarg=
X-Received: by 2002:a25:3104:: with SMTP id x4mr33768383ybx.512.1634117667339; 
 Wed, 13 Oct 2021 02:34:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu4Pr4xWhiMFWBjy5LCYDTpyS49GcQ6N7FGFCWNMsoizODnEfLUWR8ZVuIz18pViD9pC4u1h4Yq6qY0utUrZY=
X-Received: by 2002:a25:3104:: with SMTP id x4mr33768362ybx.512.1634117667002; 
 Wed, 13 Oct 2021 02:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8pcLTjHMhh_0vebWUgwTY+UtYoKAhQntCsFvKM4zcKfA@mail.gmail.com>
 <caa2467e-9763-b9dd-db91-4cb7020bab47@nvidia.com>
 <CAHj4cs_NqB6WYQQOpqjoOFvTbbN_VydJkn1VquzTkyGpFqMM2Q@mail.gmail.com>
 <0a8810e0-4c42-4275-acd6-475fd42485fe@grimberg.me>
 <CAHj4cs_icpHAf7wN3LFt7avcPcrhjOYiSnU8SnCLQN1ObkRV1Q@mail.gmail.com>
 <CAHj4cs9QBFXca-rnP05ZmWBKDJv4aviiDQ=q2_JihMQuESE7OA@mail.gmail.com>
 <1b992460-26a6-cff6-bee4-b81ac28e93f5@grimberg.me>
 <CAHj4cs8Vff_C8FnFciHtYdnifoOHBrNtaGN1Fvpg5m2gV8JpZw@mail.gmail.com>
 <CGME20211002230919uscas1p1bc872acda3a68abc1438443d78ac921b@uscas1p1.samsung.com>
 <05d2844e-81fb-0180-03cc-423cedfd7ac7@grimberg.me>
 <20211012183446.GA264712@bgt-140510-bm01>
In-Reply-To: <20211012183446.GA264712@bgt-140510-bm01>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 13 Oct 2021 17:34:14 +0800
Message-ID: <CAHj4cs94Ts7iLBjw+1Dn3FM9sjj7sTx7j=30ytshH9YTA2jdDg@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed with blktests nvme-tcp tests
To: Adam Manzanares <a.manzanares@samsung.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>, 
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_023434_660932_51F80ACA 
X-CRM114-Status: GOOD (  34.46  )
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

On Wed, Oct 13, 2021 at 2:35 AM Adam Manzanares
<a.manzanares@samsung.com> wrote:
>
> On Sun, Oct 03, 2021 at 02:02:20AM +0300, Sagi Grimberg wrote:
> >
> > > > > Bisect shows it was introduced from the below commit:
> > > > >
> > > > > commit 2637baed78010eeaae274feb5b99ce90933fadfb
> > > > > Author: Minwoo Im <minwoo.im.dev@gmail.com>
> > > > > Date:   Wed Apr 21 16:45:04 2021 +0900
> > > > >
> > > > >       nvme: introduce generic per-namespace chardev
> > > > >
> > > >
> > > > Makes sense as both leaks relate to the nshead cdev...
> > > >
> > > > I think another put on the cdev_device is missing?
> > > > --
> > > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > > index 1d103ae4afdf..328e314af199 100644
> > > > --- a/drivers/nvme/host/core.c
> > > > +++ b/drivers/nvme/host/core.c
> > > > @@ -3668,6 +3668,7 @@ void nvme_cdev_del(struct cdev *cdev, struct
> > > > device *cdev_device)
> > > >    {
> > > >           cdev_device_del(cdev, cdev_device);
> > > >           ida_simple_remove(&nvme_ns_chr_minor_ida,
> > > > MINOR(cdev_device->devt));
> > > > +       put_device(cdev_device);
> > > >    }
> > > >
> > > >    int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
> > > > --
> > > >
> > >
> > > Hi Sagi
> > >
> > > This introduced one new issue, here is the log:
> >
> > Hmm, looks like a use-after-free. I thought that
> > there was a missing put on the cdev_device paired to
> > device_initialize() call on it...
> >
> > Minwoo?
>
> Hello all,
>
> Does the following patch fix the issue for you.
>

Yes, the kmemleak was fixed by this patch.


>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e486845d2c7e..587385bc82b6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3548,10 +3548,15 @@ static int __nvme_check_ids(struct nvme_subsystem *subsys,
>         return 0;
>  }
>
> +static void nvme_cdev_rel(struct device *dev)
> +{
> +       ida_simple_remove(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
> +}
> +
>  void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device)
>  {
>         cdev_device_del(cdev, cdev_device);
> -       ida_simple_remove(&nvme_ns_chr_minor_ida, MINOR(cdev_device->devt));
> +       put_device(cdev_device);
>  }
>
>  int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
> @@ -3564,14 +3569,14 @@ int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
>                 return minor;
>         cdev_device->devt = MKDEV(MAJOR(nvme_ns_chr_devt), minor);
>         cdev_device->class = nvme_ns_chr_class;
> +       cdev_device->release = nvme_cdev_rel;
>         device_initialize(cdev_device);
>         cdev_init(cdev, fops);
>         cdev->owner = owner;
>         ret = cdev_device_add(cdev, cdev_device);
> -       if (ret) {
> +       if (ret)
>                 put_device(cdev_device);
> -               ida_simple_remove(&nvme_ns_chr_minor_ida, minor);
> -       }
> +
>         return ret;
>  }
>
> @@ -3603,11 +3608,9 @@ static int nvme_add_ns_cdev(struct nvme_ns *ns)
>                            ns->ctrl->instance, ns->head->instance);
>         if (ret)
>                 return ret;
> -       ret = nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
> -                           ns->ctrl->ops->module);
> -       if (ret)
> -               kfree_const(ns->cdev_device.kobj.name);
> -       return ret;
> +
> +       return nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
> +                            ns->ctrl->ops->module);
>  }
>
>  static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index e8ccdd398f78..fba06618c6c2 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -431,8 +431,6 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
>                 return ret;
>         ret = nvme_cdev_add(&head->cdev, &head->cdev_device,
>                             &nvme_ns_head_chr_fops, THIS_MODULE);
> -       if (ret)
> -               kfree_const(head->cdev_device.kobj.name);
>         return ret;
>  }
>
>
>
> >
> > >
> > > [  250.764659] run blktests nvme/004 at 2021-09-30 20:23:39
> > > [  250.938913] loop0: detected capacity change from 0 to 2097152
> > > [  250.963292] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > > [  250.976418] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> > > [  251.003499] nvmet: creating controller 1 for subsystem
> > > blktests-subsystem-1 for NQN
> > > nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
> > > [  251.020277] nvme nvme0: creating 32 I/O queues.
> > > [  251.050637] nvme nvme0: mapped 32/0/0 default/read/poll queues.
> > > [  251.091232] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> > > 127.0.0.1:4420
> > > [  252.179608] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> > > [  252.228383] ------------[ cut here ]------------
> > > [  252.234400] Device 'ng0n1' does not have a release() function, it
> > > is broken and must be fixed. See Documentation/core-api/kobject.rst.
> > > [  252.246498] WARNING: CPU: 10 PID: 2086 at drivers/base/core.c:2198
> > > device_release+0x189/0x210
> > > [  252.255029] Modules linked in: nvme_tcp nvme_fabrics nvme_core
> > > nvmet_tcp nvmet loop rfkill sunrpc vfat fat dm_multipath iTCO_wdt
> > > iTCO_vendor_support ipmi_ssif intel_rapl_msr intel_rapl_common
> > > isst_if_common skx_edac x86_pkg_temp_thermal intel_powerclamp coretemp
> > > kvm_intel mgag200 i2c_algo_bit kvm drm_kms_helper dell_smbios
> > > irqbypass crct10dif_pclmul crc32_pclmul syscopyarea sysfillrect
> > > sysimgblt dcdbas fb_sys_fops ghash_clmulni_intel cec rapl intel_cstate
> > > drm intel_uncore mei_me dell_wmi_descriptor wmi_bmof pcspkr i2c_i801
> > > mei acpi_ipmi i2c_smbus lpc_ich ipmi_si ipmi_devintf ipmi_msghandler
> > > dax_pmem_compat nd_pmem device_dax nd_btt dax_pmem_core
> > > acpi_power_meter xfs libcrc32c sd_mod t10_pi sg ahci libahci libata
> > > tg3 megaraid_sas crc32c_intel wmi nfit libnvdimm dm_mirror
> > > dm_region_hash dm_log dm_mod [last unloaded: nvmet]
> > > [  252.327704] CPU: 10 PID: 2086 Comm: nvme Tainted: G S        I
> > >   5.15.0-rc3.v1.fix+ #4
> > > [  252.335974] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
> > > 2.11.2 004/21/2021
> > > [  252.343635] RIP: 0010:device_release+0x189/0x210
> > > [  252.348262] Code: 48 8d 7b 50 48 89 fa 48 c1 ea 03 80 3c 02 00 0f
> > > 85 88 00 00 00 48 8b 73 50 48 85 f6 74 13 48 c7 c7 60 cb 18 af e8 dc
> > > fb c5 00 <0f> 0b e9 0b ff ff ff 48 b8 00 00 00 00 00 fc ff df 48 89 da
> > > 48 c1
> > > [  252.367015] RSP: 0018:ffffc90003d5fb00 EFLAGS: 00010282
> > > [  252.372249] RAX: 0000000000000000 RBX: ffff8882a5474a48 RCX: ffffffffad731d52
> > > [  252.379393] RDX: 0000000000000004 RSI: 0000000000000008 RDI: ffff888e259e3b2c
> > > [  252.386533] RBP: ffff8882e390ec00 R08: ffffed11c4b3d9b9 R09: ffffed11c4b3d9b9
> > > [  252.393675] R10: ffff888e259ecdc7 R11: ffffed11c4b3d9b8 R12: ffff8882e328b500
> > > [  252.400812] R13: ffff88852e9ee500 R14: 0000000000000000 R15: ffffc90003d5fbf8
> > > [  252.407946] FS:  00007f6f3cad2780(0000) GS:ffff888e25800000(0000)
> > > knlGS:0000000000000000
> > > [  252.416040] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  252.421795] CR2: 000055c593c2e6b0 CR3: 00000002a1aec006 CR4: 00000000007706e0
> > > [  252.428937] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > [  252.436078] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > [  252.443221] PKRU: 55555554
> > > [  252.445941] Call Trace:
> > > [  252.448403]  kobject_release+0x109/0x3a0
> > > [  252.452338]  nvme_mpath_shutdown_disk+0x92/0xe0 [nvme_core]
> > > [  252.457929]  nvme_ns_remove+0x4a3/0x7f0 [nvme_core]
> > > [  252.462824]  ? up_write+0x14d/0x460
> > > [  252.466324]  nvme_remove_namespaces+0x242/0x3a0 [nvme_core]
> > > [  252.471914]  ? nvme_execute_passthru_rq+0x5a0/0x5a0 [nvme_core]
> > > [  252.477852]  ? del_timer_sync+0xab/0xf0
> > > [  252.481699]  nvme_do_delete_ctrl+0xaa/0x108 [nvme_core]
> > > [  252.486941]  nvme_sysfs_delete.cold.100+0x8/0xd [nvme_core]
> > > [  252.492532]  kernfs_fop_write_iter+0x2d0/0x490
> > > [  252.496984]  ? trace_hardirqs_on+0x1c/0x150
> > > [  252.501180]  new_sync_write+0x3b2/0x620
> > > [  252.505026]  ? rcu_read_lock_held_common+0xe/0xa0
> > > [  252.509742]  ? new_sync_read+0x610/0x610
> > > [  252.513677]  ? rcu_tasks_trace_pregp_step+0xe1/0x170
> > > [  252.518651]  ? rcu_read_lock_held_common+0xe/0xa0
> > > [  252.523368]  ? rcu_read_lock_sched_held+0x5f/0xd0
> > > [  252.528082]  ? rcu_read_unlock+0x40/0x40
> > > [  252.532016]  ? rcu_read_lock_held+0xb0/0xb0
> > > [  252.536212]  vfs_write+0x4b5/0x950
> > > [  252.539626]  ksys_write+0xf1/0x1c0
> > > [  252.543039]  ? __ia32_sys_read+0xb0/0xb0
> > > [  252.546975]  do_syscall_64+0x37/0x80
> > > [  252.550563]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > [  252.555621] RIP: 0033:0x7f6f3c1bb648
> > > [  252.559209] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00
> > > 00 00 f3 0f 1e fa 48 8d 05 55 6f 2d 00 8b 00 85 c0 75 17 b8 01 00 00
> > > 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89
> > > d4 55
> > > [  252.577965] RSP: 002b:00007fff4826bb88 EFLAGS: 00000246 ORIG_RAX:
> > > 0000000000000001
> > > [  252.585537] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f6f3c1bb648
> > > [  252.592679] RDX: 0000000000000001 RSI: 000055c593c70da5 RDI: 0000000000000004
> > > [  252.599821] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> > > [  252.606962] R10: 0000000000000000 R11: 0000000000000246 R12: 000055c5945d7540
> > > [  252.614102] R13: 00007fff4826e0fc R14: 0000000000000008 R15: 0000000000000003
> > > [  252.621246] irq event stamp: 0
> > > [  252.624310] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> > > [  252.630585] hardirqs last disabled at (0): [<ffffffffac9d68f3>]
> > > copy_process+0x2023/0x6b20
> > > [  252.638854] softirqs last  enabled at (0): [<ffffffffac9d6932>]
> > > copy_process+0x2062/0x6b20
> > > [  252.647121] softirqs last disabled at (0): [<0000000000000000>] 0x0
> > > [  252.653396] ---[ end trace 96526c0d562adac3 ]---
> > >
> > >
> >
> > _______________________________________________
> > Linux-nvme mailing list
> > Linux-nvme@lists.infradead.org
> > https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=c4623b75-9bf90238-c463b03a-0cc47aa8f5ba-4705d26d62157aef&q=1&e=e8f1e635-f4b8-4b35-af63-85700ecd6dd3&u=http*3A*2F*2Flists.infradead.org*2Fmailman*2Flistinfo*2Flinux-nvme__;JSUlJSUl!!EwVzqGoTKBqv-0DWAJBm!GNcPQ8XAKsCJJcCcuc6fY9-radUDLzK6DGiO1Js8mf_-Jg1XVAfs30Cd7G7YXqwtPRdh$
>


-- 
Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
