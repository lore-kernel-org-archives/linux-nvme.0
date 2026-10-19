Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D661CCF2E3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 14:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SXd06xmy2j7mpCCKr/bXsUuVAzRO7J0mNBFLbo3SZ3A=; b=as3NaOe/JeSktNK3CjwQHD3Mxi
	cI54O/LHRPAL0zqjcBBmB9+bx+KfM36Ec2Ge6gYQ/GIbSqsXAeDgRf6e7nSL/IPCp0IHtEHQPjceQ
	WQMxASWmjWx0xKhv11DIkfs8CjuM2wFGfY/K7UxM7zgrLjvrogo9ig0lpHzQFSq2zH4bcOADd2rWw
	YDOKjILl/6obZC8/Op0wMhe7LnrGXe2sZni7pnR7tKmRNNpQDRCCkZp+Vul/g2t3jINmCuqDqQWo2
	f1X8EpPwVGqPsqHbYSTR+Ue9FrbsEpFLyIa4QSDbdct001TB6+wASK8Imbvhqc9AtnZzBG4bGuYFA
	ZIK65DTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIo9K-00000007iZ4-46p9;
	Mon, 19 Oct 2026 14:15:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIo9J-00000007iYi-3T4g
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 14:15:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 54FFE41942
	for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2026 14:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DB71F000C5;
	Mon, 19 Oct 2026 14:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419337;
	bh=SXd06xmy2j7mpCCKr/bXsUuVAzRO7J0mNBFLbo3SZ3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g1XKR/xhxtWyn7Zk22eNQfnHItacmChn6GuvGngytzG1Lpm1qtzpLP5gTPwdqf8YO
	 NA6EMnXSkuIygvYTn9fr7AqZa9IDh4ABdceRCbQP6ah5dnem2bXWFc1WUxwJhNadL2
	 HwNlI+BXLXRK3IEKYRh2dFoMEFka3xGIRGuww9iZ2AZgOFHVrge4jlPj55dW6B34Rw
	 SWEsEaOn6gIxW/vDeC4riPVR/LpAU5lxKdfhnhmI18+UXLH+klppCEa76eh+k8FSsZ
	 yuKH8yg9GjT0iSDA2jBAR08hpws8o6K+vP+OLgdvmO/fc/Gk1uwNooBcSQLVRC5kp1
	 G77CdxRLbpFwQ==
Message-ID: <sashiko-outbox-177332@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.15] nvmet: zns: reject full zone report
 when buffer is too small
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261019135441.1420968-69-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-69-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:15:36 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] nvmet: zns: broken PR=3D0 zone reports in nvmet_bdev_zone_zmgmt_re=
cv_work()
--

commit 42bb4c679b1e6318e7ed82bbe79461a255997505
Author: Xixin Liu <liuxixin@kylinos.cn>

nvmet: zns: reject full zone report when buffer is too small

This patch updates nvmet_bdev_zone_zmgmt_recv_work() in
drivers/nvme/target/zns.c to fail Zone Management Receive commands with
NVME_SC_INVALID_FIELD | NVME_STATUS_DNR when the Partial Report (PR) bit is
clear and rz_data.nr_zones exceeds rz_data.out_nr_zones.

> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index 15a579cf528c1..dfa9269b59992 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -299,11 +299,18 @@ static void nvmet_bdev_zone_zmgmt_recv_work(struct =
work_struct *w)
>  	}
> =20
>  	/*
> -	 * When partial bit is set nr_zones must indicate the number of zone
> -	 * descriptors actually transferred.
> +	 * Partial report (PR bit set): the host accepts an incomplete listing,
> +	 * so cap Number of Zones to the descriptors that fit in the buffer.
> +	 * Full report (PR bit clear): Number of Zones is the match count; fail
> +	 * if the buffer cannot hold every matching zone descriptor.
>  	 */
> -	if (req->cmd->zmr.pr)
> +	if (req->cmd->zmr.pr) {
>  		rz_data.nr_zones =3D min(rz_data.nr_zones, rz_data.out_nr_zones);
> +	} else if (rz_data.nr_zones > rz_data.out_nr_zones) {
> +		req->error_loc =3D offsetof(struct nvme_zone_mgmt_recv_cmd, numd);
> +		status =3D NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> +		goto out;
> +	}

[Severity: High]
Won't rejecting req->cmd->zmr.pr =3D=3D 0 commands when rz_data.nr_zones >
rz_data.out_nr_zones break valid non-partial Zone Management Receive
queries?

Per the NVMe Zoned Namespace Command Set specification (section 3.4.2), the
Partial Report (PR) bit controls the value placed in the Number of Zones
field of the 64-byte Report Zones header (struct nvme_zone_report):

- When PR is 0, Number of Zones indicates the total number of zones matching
  the ZRASF criteria from SLBA to the end of the namespace, regardless of t=
he
  size of the data buffer, while only as many zone descriptors as fit in the
  buffer are transferred.

- When PR is 1, Number of Zones indicates the number of zone descriptors
  actually transferred in the buffer.

The only NUMD buffer size condition that aborts the command with Invalid
Field in Command is when the buffer is smaller than the 64-byte Report Zones
header itself, which nvmet_bdev_validate_zone_mgmt_recv() already checks:

drivers/nvme/target/zns.c:nvmet_bdev_validate_zone_mgmt_recv() {
	...
	if (out_bufsize < sizeof(struct nvme_zone_report)) {
		req->error_loc =3D offsetof(struct nvme_zone_mgmt_recv_cmd, numd);
		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
	}
	...
}

The existing helpers in drivers/nvme/target/zns.c are built around this
behavior. In particular, get_nr_zones_from_buf() explicitly allows a 64-byte
header-only buffer (returning out_nr_zones =3D=3D 0) so an initiator can is=
sue a
PR=3D0 command to discover the total number of matching zones before alloca=
ting
a full descriptor buffer:

drivers/nvme/target/zns.c:get_nr_zones_from_buf() {
	if (bufsize <=3D sizeof(struct nvme_zone_report))
		return 0;

	return (bufsize - sizeof(struct nvme_zone_report)) /
		sizeof(struct nvme_zone_descriptor);
}

And nvmet_bdev_report_zone_cb() copies descriptors into the host SGL only
while rz->nr_zones < rz->out_nr_zones, yet continues incrementing
rz->nr_zones across all remaining matching zones specifically to compute the
total match count for PR=3D0:

drivers/nvme/target/zns.c:nvmet_bdev_report_zone_cb() {
	...
	if (rz->nr_zones < rz->out_nr_zones) {
		...
		status =3D nvmet_copy_to_sgl(rz->req, rz->out_buf_offset, &zdesc,
					   sizeof(zdesc));
		if (status)
			return -EINVAL;

		rz->out_buf_offset +=3D sizeof(zdesc);
	}

	rz->nr_zones++;

	return 0;
}

With this new check in nvmet_bdev_zone_zmgmt_recv_work(), any 64-byte
header-only PR=3D0 query (out_nr_zones =3D=3D 0) fails with NVME_SC_INVALID=
_FIELD |
NVME_STATUS_DNR whenever at least one zone matches, and any bounded-buffer
PR=3D0 query fails after nvmet_bdev_report_zone_cb() has already written
out_nr_zones descriptors into the host SGL.

> =20
>  	nr_zones =3D cpu_to_le64(rz_data.nr_zones);
>  	status =3D nvmet_copy_to_sgl(req, 0, &nr_zones, sizeof(nr_zones));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-69-sashal@kernel.org?part=3D1

