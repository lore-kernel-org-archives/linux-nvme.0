Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9C6606A321
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=agpVTL6x;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QdAehrib
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=J7+RTGH03r/o8OGu2rO9FJzLa/RLTQMzaVEG5eKylws=; b=agpVTL6x4n9bjWfZ2+3B3cRqbA
	WChuOw+QYhMEq7DP7yFuO4zZ7z4Rfy+24CLyviAAbMdVJipPYt5b/4q+5bD9s9d0CTzar4PK/YKu4
	WHzRxl2PzbJ6M2OB7ohAFJ/qbi7/JKiqKn4SjWo0h30zvDAnFAqWl26M3CZ1scFN8f2mAA0+vcXEZ
	O0lJtSH/M+d+cAFs7q7Gr9nlE04xI6EOPcY38+M/X900mO0NVOtZbLJfd52nkVm0w8j1J2v0Gb5tY
	y2czy9hool/8XfioIPTK9WJQu4HVYf9/whehQGTvEACVIw0XUeWNPC9jFspRiMIdaN1ij/BXH2ksL
	E4Pnk61g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQOLX-00000000eNG-0UAG;
	Mon, 09 Nov 2026 12:19:35 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQOLV-00000000eN9-37oZ
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 12:19:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1647A41AE4;
	Mon,  9 Nov 2026 12:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08311F0089F;
	Mon,  9 Nov 2026 12:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794226773;
	bh=J7+RTGH03r/o8OGu2rO9FJzLa/RLTQMzaVEG5eKylws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QdAehribDFebjQsnnBs7sk4eDxsb6uXHZLOT3OFSmJ4DCVk/SO1rV50Vp3ATnRfA3
	 Ku+CQbwtGHAnRqqrvz8Xw/uPwFsBTYGHHNAw2FLiFK4GfLPsLI/FK5AqKrvrUWGIEC
	 PQ0ZwHLw1XZr59yjeh7fIMP64JCeqrfPakK4fFdQvKvuBsXMECYUhuTruakKYE/zW8
	 kMr0CTNuilZjyZL/BNYe51LQEdAtbjh/3iQ8HwTOXIWMLwARGMsi5CZEyhzvteGWyk
	 YY7cntU8ysPtNd4BtsLReSPpyAeKhxHsPlhiDBk7DVyiT67KLO83AbmWblROoA8IrC
	 YIoZl3QxyBlNA==
Message-ID: <sashiko-outbox-204924@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] nvme-hwmon: notify hwmon alarms on the SMART /
 Health Status AEN
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261109120207.1352165-3-kanie@linux.alibaba.com>
References: <20261109120207.1352165-1-kanie@linux.alibaba.com>
 <20261109120207.1352165-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 12:19:32 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] nvme: nvme_enable_aen() masks NVME_AEN_CFG_SMART with
  ctrl->oaes
- [High] nvme: nvme_complete_async_event() requeues AER without clearing
  SMART log
- [Medium] nvme-hwmon: nvme_hwmon_smart_notify() bypasses
  hwmon_notify_event()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] nvme: use-after-free in nvme_handle_aen_notice() [1]
--

commit 33552d2b2131791945c267787b8393f1a3c9f467
Author: Guixin Liu <kanie@linux.alibaba.com>

nvme-hwmon: notify hwmon alarms on the SMART / Health Status AEN

This commit subscribes to the NVMe SMART / Health Status asynchronous
event and schedules a work item on completion to notify sysfs pollers on
temp1_alarm.

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a7a4d09644c13..ef488d3ac081f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1784,7 +1784,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, in=
t *count)
>  EXPORT_SYMBOL_GPL(nvme_set_queue_count);
> =20
>  #define NVME_AEN_SUPPORTED \
> -	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
> +	(NVME_AEN_CFG_SMART | NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
>  	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
> =20
>  static void nvme_enable_aen(struct nvme_ctrl *ctrl)

[Severity: High]
Does adding NVME_AEN_CFG_SMART to NVME_AEN_SUPPORTED actually enable SMART
asynchronous events in nvme_enable_aen()?

nvme_enable_aen() masks NVME_AEN_SUPPORTED against ctrl->oaes:

drivers/nvme/host/core.c:nvme_enable_aen() {
	u32 result, supported_aens =3D ctrl->oaes & NVME_AEN_SUPPORTED;
	int status;

	if (!supported_aens)
		return;
    ...
}

ctrl->oaes comes from the Identify Controller OAES field, where bits 7:0
are reserved and zero on compliant controllers (see NVMET_AEN_CFG_OPTIONAL
vs NVMET_AEN_CFG_ALL in drivers/nvme/target/nvmet.h).  In Set Features for
NVME_FEAT_ASYNC_EVENT, bits 7:0 are the mandatory SMART warning bitmask
(NVME_SMART_CRIT_SPARE, NVME_SMART_CRIT_TEMPERATURE, etc.), so masking
with ctrl->oaes clears NVME_AEN_CFG_SMART and never enables the event.

> @@ -4993,8 +4993,12 @@ void nvme_complete_async_event(struct nvme_ctrl *c=
trl, __le16 status,
>  			nvme_handle_aer_persistent_error(ctrl);
>  			return;
>  		}
> -		fallthrough;
> +		ctrl->aen_result =3D result;
> +		break;
>  	case NVME_AER_SMART:
> +		nvme_hwmon_smart_event(ctrl);
> +		ctrl->aen_result =3D result;
> +		break;
>  	case NVME_AER_CSS:
>  	case NVME_AER_VS:
>  		ctrl->aen_result =3D result;

[Severity: High]
Does completing NVME_AER_SMART with requeue =3D true re-arm the Asynchronous
Event Request before the SMART / Health Information log page is read?

Per the NVMe specification, an asynchronous event remains latched on the
controller until host software reads the corresponding log page
(NVME_LOG_SMART) with RAE cleared.  Other AEN handlers such as
nvme_fw_act_work() read their log page before queueing
ctrl->async_event_work, whereas here ctrl->async_event_work resubmits the
AER immediately while nvme_hwmon_smart_notify() only calls sysfs_notify().
Before userspace wakes up and reads temp1_alarm (or if nothing polls
temp1_alarm, or CONFIG_NVME_HWMON is disabled), the new AER completes
immediately with the same uncleared event in a tight loop.

[Severity: Critical]
This problem wasn't introduced by this patch, but can a late
NVME_AER_NOTICE_ANA completion in nvme_complete_async_event() cause a
use-after-free [1] on ctrl during controller teardown?

CPU0                              CPU1
nvme_remove_ctrl()
  ...
  nvme_stop_ctrl()
    nvme_mpath_stop()
      cancel_work_sync(&ctrl->ana_work)
                                  nvme_complete_async_event()
                                    nvme_handle_aen_notice()
                                      queue_work(nvme_wq, &ctrl->ana_work)
  nvme_uninit_ctrl()
  nvme_put_ctrl() -> kfree(ctrl)
                                  nvme_ana_work()
                                    /* dereferences freed ctrl */
                                    <-- use-after-free

nvme_handle_aen_notice() checks ctrl->ana_log_buf but does not verify that
the controller is still live before queueing ctrl->ana_work, allowing the
work item to run after the controller has been freed.

> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 406203d8b9adb..564d5cae8001b 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c

[ ... ]

> @@ -223,6 +225,32 @@ static const struct hwmon_chip_info nvme_hwmon_chip_=
info =3D {
>  	.info	=3D nvme_hwmon_info,
>  };
> =20
> +/*
> + * Called from the admin completion path on a SMART / Health Status AEN.
> + * The completion context can be a hardirq, so only queue the work here;
> + * the notify itself is done in process context.  No log refresh is
> + * needed: userspace re-reads temp1_alarm, which fetches the SMART log
> + * on demand.
> + */
> +void nvme_hwmon_smart_event(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_hwmon_data *data;
> +
> +	if (!ctrl->hwmon_device)
> +		return;
> +
> +	data =3D dev_get_drvdata(ctrl->hwmon_device);
> +	queue_work(nvme_wq, &data->smart_work);
> +}
> +
> +static void nvme_hwmon_smart_notify(struct work_struct *work)
> +{
> +	struct nvme_hwmon_data *data =3D
> +		container_of(work, struct nvme_hwmon_data, smart_work);
> +
> +	sysfs_notify(&data->ctrl->hwmon_device->kobj, NULL, "temp1_alarm");
> +}

[Severity: Medium]
Should nvme_hwmon_smart_notify() call hwmon_notify_event() instead of
calling sysfs_notify() directly?

hwmon_notify_event(data->ctrl->hwmon_device, hwmon_temp, hwmon_temp_alarm,
0) notifies the sysfs attribute, emits the standard hwmon KOBJ_CHANGE
uevent, and calls hwmon_thermal_notify() to update the thermal zone
registered via HWMON_C_REGISTER_TZ.  Also, the commit message notes that
polling temp1_alarm reports spare-block conditions, but nvme_hwmon_read()
only checks NVME_SMART_CRIT_TEMPERATURE for temp1_alarm and never checks
NVME_SMART_CRIT_SPARE.

[1] https://sashiko.dev/#/bug/linux-216101c0-b2a4-4615-97e0-5cfa127dc568

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109120207.1352=
165-1-kanie@linux.alibaba.com?part=3D2

