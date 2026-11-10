Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4804A606A321
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=K+qxmEAg;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCYyhCOl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Y/Bq6NU1/IpRczkbSWK0oP4bGu0MQGDBx3CDnvVQ39A=; b=K+qxmEAgDbjYLUHKi+PnLMSZrL
	Zn6f62Kk70TbO7/HmvH0PxhCW/DnLAvVGBU+yxIevJHhXrBuW21M63Q22ZGmbg5hqannlKDbhBv+m
	REfLF1r7QDzI72hn32DHELoY0UWqAcs0Tjfah1FWAYl/Ked65JJVbE4gA96MJo3hTVEGI6icJ6Bm3
	Uwzq4C8211rPxsK77wRPnhjBLy6UYqj904SpXKRFL0Q4ZqD/Xg4ApWXI14g6zy5MdoFQeAOdD+3Nk
	2JOFOjAQGOXXN1Dwv+LqVkjasbr9lsbH4Z6K1UrCLVBQ64JcnIpadA4cIT0KilfPQJzp6a8za4NT6
	TuRPZsXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQk5A-00000003e35-2hxa;
	Tue, 10 Nov 2026 11:32:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQk59-00000003e2z-0ANy
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 11:32:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 78C4543613;
	Tue, 10 Nov 2026 11:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3881F0089F;
	Tue, 10 Nov 2026 11:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310326;
	bh=Y/Bq6NU1/IpRczkbSWK0oP4bGu0MQGDBx3CDnvVQ39A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NCYyhCOlRB/iayAIw68czp2Jkp2EU7ecBo8MkOHVhpXEIiYKQzmCRGFefr6GFVt4L
	 Ahbds3F5MUsdqmUn3rOFD2Swy0gcVWsy4oumj5u7VrLtUZ2WMtkjUY58g/do6JelRI
	 k0f+G36VoxiTfKlHRW9Qprt1vKWNYT05DsRDzwC14izpI6lbYxkX3DHDYKPN0aRQ8D
	 evgV5t550NNbHidgu5OdJ12gkiX+/bDpVxYaQemVjyXnTOPJYy99EiTT5IuZZgpnjM
	 GupZKMigRS8pXqFP1iUnTmK6uVgspWprlhWfRhMicCHTcRjyUHHfAkWaFtpCK3XxNQ
	 GfQiAAUEW0dsA==
Message-ID: <sashiko-outbox-206940@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] nvme-hwmon: notify hwmon alarms on the SMART /
 Health Status AEN
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261110110737.3965373-2-kanie@linux.alibaba.com>
References: <20261110110737.3965373-1-kanie@linux.alibaba.com>
 <20261110110737.3965373-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:32:05 +0000
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
- [High] nvme-hwmon: race between smart_work and async_event_work
  re-arms AER early
- [High] nvme: NULL submit_async_event() dereference via
  nvme_enable_aen()
- [Low] nvme-hwmon: unfiltered NVME_AER_SMART subtype in
  nvme_complete_async_event()
--

commit 0ce1f50fb06d20be5bc969ec67713426ed866b3c
Author: Guixin Liu <kanie@linux.alibaba.com>

nvme-hwmon: notify hwmon alarms on the SMART / Health Status AEN

This commit enables the temperature critical warning in the Asynchronous
Event Configuration when hwmon is present and schedules work on SMART /
Health Status AEN completions to re-read the SMART log and notify hwmon
on temp1_alarm.

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f4aa02869b790..9e355fb0e3992 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1792,6 +1792,17 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>  	u32 result, supported_aens =3D ctrl->oaes & NVME_AEN_SUPPORTED;
>  	int status;
> =20
> +	/*
> +	 * Unlike the notice events above, SMART / Health Status events have
> +	 * no OAES capability bit: AEC dw11 bits 7:0 are the SMART / Health
> +	 * Critical Warnings (SHCW) mask, which mirrors the critical_warning
> +	 * byte of the SMART log.  Subscribe to the temperature warning
> +	 * whenever the hwmon support is present, as that is the only
> +	 * consumer.
> +	 */
> +	if (nvme_hwmon_present(ctrl))
> +		supported_aens |=3D NVME_SMART_CRIT_TEMPERATURE;
> +
>  	if (!supported_aens)
>  		return;

[Severity: High]
Can this cause a NULL pointer dereference in nvme_async_event_work() on
controllers whose nvme_ctrl_ops do not implement submit_async_event()?

The apple-nvme driver does not support asynchronous events, reports
ctrl->oaes =3D=3D 0, and leaves submit_async_event NULL in its nvme_ctrl_op=
s,
but still initializes hwmon via nvme_init_ctrl_finish().  Previously,
supported_aens remained 0 so nvme_enable_aen() returned early.  With
NVME_SMART_CRIT_TEMPERATURE set whenever ctrl->hwmon_device is present,
nvme_enable_aen() now queues ctrl->async_event_work, and
nvme_async_event_work() unconditionally calls
ctrl->ops->submit_async_event(ctrl).

> @@ -5006,8 +5017,12 @@ void nvme_complete_async_event(struct nvme_ctrl *c=
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

[Severity: Low]
Should this check aer_subtype (or log->critical_warning in
nvme_hwmon_smart_notify()) before notifying temp1_alarm?

If any non-temperature SMART / Health Status warning is enabled in
NVME_FEAT_ASYNC_EVENT (for example via admin passthrough),
nvme_hwmon_smart_notify() will read the SMART log with RAE cleared and
emit a false temp1_alarm notification and thermal zone update.

> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 406203d8b9adb..172ef63f1180c 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
[ ... ]
> @@ -223,6 +224,39 @@ static const struct hwmon_chip_info nvme_hwmon_chip_=
info =3D {
>  	.info	=3D nvme_hwmon_info,
>  };
> =20
> +static void nvme_hwmon_smart_notify(struct work_struct *work)
> +{
> +	struct nvme_hwmon_data *data =3D
> +		container_of(work, struct nvme_hwmon_data, smart_work);
> +	struct nvme_ctrl *ctrl =3D data->ctrl;
> +	int ret;
> +
> +	/*
> +	 * The event stays latched on the controller until the SMART log
> +	 * is read with RAE cleared, so re-read it here before the
> +	 * completion path re-arms the Asynchronous Event Request.
> +	 */
> +	mutex_lock(&data->read_lock);
> +	ret =3D nvme_hwmon_get_smart_log(data);
> +	mutex_unlock(&data->read_lock);
> +	if (ret)
> +		return;
> +
> +	hwmon_notify_event(ctrl->hwmon_device, hwmon_temp,
> +			   hwmon_temp_alarm, 0);
> +}

[Severity: High]
Does queueing both data->smart_work and ctrl->async_event_work on nvme_wq
actually guarantee that the SMART log is read before the Asynchronous
Event Request is re-armed?

nvme_wq is allocated with WQ_UNBOUND and default max_active, so both work
items run concurrently:

CPU0                                  CPU1
nvme_complete_async_event()
  nvme_hwmon_smart_event(ctrl)
    queue_work(nvme_wq, &smart_work)
  queue_work(nvme_wq, &async_event_work)

nvme_hwmon_smart_notify()             nvme_async_event_work()
  nvme_hwmon_get_smart_log()            ctrl->ops->submit_async_event(ctrl)
    ... (sleeps on admin I/O)             <-- re-arms AER before RAE clear

Because submit_async_event() runs before the synchronous Get Log Page
command completes and clears the latched event, the controller can
immediately complete the new AER for the same latched SMART warning,
causing repeated AER completions and duplicate uevent and hwmon
notifications.  By comparison, NVME_AER_NOTICE_FW_ACT_STARTING sets
requeue =3D false in nvme_handle_aen_notice() and queues
ctrl->async_event_work from nvme_fw_act_work() only after reading the log
page.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110110737.3965=
373-1-kanie@linux.alibaba.com?part=3D1

