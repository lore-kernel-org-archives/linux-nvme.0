Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061B606A31B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LeFEX4IY;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjOwVwTP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EQmexwlL0NaglT07ruapIC+ufieHfae6dJtCkzoFsIc=; b=LeFEX4IYJBAuO5WvS7WmGgXP1I
	6nPPrHtTn5AxSAWmZz7ZQ65eJiWN+IXEHrFUazRXQAB5tctBxwG91DvmQ6SKtkOVoq6V4SeuMFocs
	2s7mLaNfx5tkmYWam9/xlmVMuTfz3B5Wr9i4+DhKWtNwSxlrm8aPT8IqjuXGyn3MJhGntHwxCVShf
	vZJilWsWTAX0m79iqkNDuB4TGpG7ccXM44AVK32eXD/GTWrA/w5No5usUj2q9OMsZlgTsd+tTi2Qi
	SoMzfgeuuh8ifZq+G19isildpH2/CUF5lEVk1B7XbzENmAMDSFQ911ZS10gdQlSo+0GyB6R3801Db
	H1TKHhiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOn5h-00000007Z3C-0ygO;
	Thu, 05 Nov 2026 02:20:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOn5g-00000007Z2k-0mnF
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 02:20:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3F68060C02;
	Thu,  5 Nov 2026 02:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD391F00A18;
	Thu,  5 Nov 2026 02:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793845235;
	bh=EQmexwlL0NaglT07ruapIC+ufieHfae6dJtCkzoFsIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NjOwVwTP2nyvVPDJqnrDbEL1Zr0RkY2lBG7BfJF4WAYLX4L/EnJL/ThmUCYLahYCF
	 4prwuJKq5aXPk1HlE6XyOqM4yW0ezK8nyWHieNqohxeXPl7K3+KwaSzMT1/ZsjkFDy
	 pWsjmuzaVjhHE6+ecyT0jmApWqzdeVkJDf8/IUqRbhNTMd0hQITk9csA6/ZLwjU+pj
	 WgywSMLGlFSDGI7tXJyhABUahcwVM1pDKa+1AJ7hRt4yvWepfsK68N3DR5Hc0ies8+
	 21CfNkYeppHQ2tulmzxhP1PYl2dXVBA5OQ/nUGGThQ4S6icVlsgwo0UZkna8Zrw+tg
	 sikGOhwvaa3zg==
Message-ID: <sashiko-outbox-198452@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] nvme: drop unreachable "off" case in
 reconnect_delay_show()
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261105021051.1667222-6-kanie@linux.alibaba.com>
References: <20261105021051.1667222-1-kanie@linux.alibaba.com>
 <20261105021051.1667222-6-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 02:20:34 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] nvme: Documentation/ABI/stable/sysfs-nvme out of sync for reconnect=
_delay
--

commit 0bdac7a94ae088ab38d8d6006c42a68c7d0447dc
Author: Guixin Liu <kanie@linux.alibaba.com>

nvme: drop unreachable "off" case in reconnect_delay_show()

This commit removes the check for ctrl->opts->reconnect_delay =3D=3D -1 in
nvme_ctrl_reconnect_delay_show() so that reading reconnect_delay no longer
emits "off".

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 10018c6356b62..3724b5ce03a07 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -618,8 +618,6 @@ static ssize_t nvme_ctrl_reconnect_delay_show(struct =
device *dev,
>  {
>  	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> =20
> -	if (ctrl->opts->reconnect_delay =3D=3D -1)
> -		return sysfs_emit(buf, "off\n");
>  	return sysfs_emit(buf, "%d\n", ctrl->opts->reconnect_delay);

[Severity: Low]
With this branch removed from nvme_ctrl_reconnect_delay_show() in
drivers/nvme/host/sysfs.c, reading /sys/class/nvme/nvmeX/reconnect_delay
never outputs "off". However, Documentation/ABI/stable/sysfs-nvme still
states:

		reconnect_delay: Shows or sets the reconnect delay in
		seconds. Reading returns the delay value, or "off" if
		disabled.

Should Documentation/ABI/stable/sysfs-nvme be updated to drop the "off"
description as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105021051.1667=
222-1-kanie@linux.alibaba.com?part=3D5

