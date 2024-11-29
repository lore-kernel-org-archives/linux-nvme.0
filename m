Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4ABDD729F9
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 18:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XIdUIsiinP9t0oWKVW/09YL/ik9joSWDlaWG5neaO5U=; b=Yoz8zU3z8FbYeFmRO4HtFVc+De
	mXphFjeJatsIvArpQDDgkINGHAEBeA3IpS4MiQOetv6tkQCtoHsuFg7ZEA2zmXEax/X/0pfiMdRAI
	5qqGaaKNPC4OgiJvttTtVhCzlFk1PJupvVgjm/DA42sERPXvWsa2GPt/bMQ8RVPBlfXhSCAyL0uue
	4ocXyShOzuEO/0DcRS/bUGbkdqyl6t/TxP/UCe8GtTTtQzyvVd0eJCMOj5d5JRWEzQi7y3M6r9aFC
	Pc7/zSw0LmgtKShDcoou3mxmaxLubzndGvSUsA+njLkse+96sT4GaWlrCVi8Z82+vEaYb4+Agad6B
	YCssBKkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tH5tp-00000000mug-277F;
	Fri, 29 Nov 2024 18:39:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tH5ti-00000000mu7-2lCR
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 18:39:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732905560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIdUIsiinP9t0oWKVW/09YL/ik9joSWDlaWG5neaO5U=;
	b=IN5wpEAb83uWCSNYJHN/zh64DKwx27opfIgjZHhICwa0HJK2TEuG8xA6+QroqtfyP2GlBt
	nz05gDZ40xWh/5o/fQedX0rqSjKbuOfRxuOo+ka2Plu0VTP21LPOKAiskKstrsfT/dMZCO
	WHygdcijObjGZnr27DCD575J3mIniOg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-Ikq-vEdJNsa67MOwGixPGg-1; Fri, 29 Nov 2024 13:39:18 -0500
X-MC-Unique: Ikq-vEdJNsa67MOwGixPGg-1
X-Mimecast-MFC-AGG-ID: Ikq-vEdJNsa67MOwGixPGg
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8866dc8d3so11351876d6.1
        for <linux-nvme@lists.infradead.org>; Fri, 29 Nov 2024 10:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732905558; x=1733510358;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XIdUIsiinP9t0oWKVW/09YL/ik9joSWDlaWG5neaO5U=;
        b=T0QeIBS5driTBrldN8WCcb5TMebdmgFlRSxJiztKeUU0axyJk7mY7qVw9B7nqSyo2j
         E0qd+AKVJfF8R2RkBUN9rbRNpEmGzwxwI8/8rte7bEiNdEebQkHFpePDd5pZPsenaFYW
         Lf5WYFwNYuuPFkOHcYCWWf4THrtTePO3syrR/gdQ/SA5G5Ei/uE6EkXyXn0TneBxZ0DP
         fdhvQJTaVVwAjn7EXOquZw7HrjIJtr3D6t7g6JBANa/GTohK4jrE/3k4X2Jnr5qlWpP5
         iT6B24ZLmlPMVZ56oc48ei1rRZ+PVlM/etbyfvDCkxO1WaMeUFu2X3YleT44fIRY64cQ
         zYOA==
X-Forwarded-Encrypted: i=1; AJvYcCWd/LorjUcWqHmP20GGenXHfHlGSHxzkEsm0Au6hLW9c0IAOXcuR8OgFic7QDkWoRzx9HXF4rRfXDcP@lists.infradead.org
X-Gm-Message-State: AOJu0YyInN4S0ZYfoySvieBUY16iWjvJ8KB9+qtidUOXWWGgONdFMPTh
	1wyKjjC9Qh6SOTkmBAvoObt+CWnOWOcK2y35HKRLyJ8AOGfWcPfR1X9iyL0A9wI8TLJfzJw4tXO
	b0NjCS8uIsLnk5cRnfAJwo2kkg2VWf+dkxNHYYDAu4Ao0uA1D+oxK+3Lws6Ls4SzE
X-Gm-Gg: ASbGnct/7SATD1DCJFdrBLdbzrolCNcISGWz2DprrLEVtTkuiG94LKBllXXBMoFHS5l
	LYffmKVUcro7R3Nqwne2PgORX2f8OMCly1PSU8AEcRu7dZ8sG3zjS5e/sMIQSDy650lWAstXh95
	E0/xTNc5k+kCcWmo/hiOns74aaMwj5y16PqvZBXElCm3wa6gRN2JeDDPOxD5CM3mEO94hrAertm
	k9lx0cvAkbEnvf08mZ1uN6nvnaLStpYRxW8C/oP8BPvv4q6DPG4ijeDzeATWQbW5fC84ave5ejA
	/+Bu4hsWnCSAJ+8a47U592Ig
X-Received: by 2002:a05:6214:b07:b0:6d8:821d:736e with SMTP id 6a1803df08f44-6d8821db492mr64361176d6.36.1732905558314;
        Fri, 29 Nov 2024 10:39:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaUO95GZP24BPdDRMCZJIPoXj5DP96tdmNOKGL2j50tmSyyK1H/wxIl1R9CMQ9dfGbLmkdow==
X-Received: by 2002:a05:6214:b07:b0:6d8:821d:736e with SMTP id 6a1803df08f44-6d8821db492mr64360826d6.36.1732905558003;
        Fri, 29 Nov 2024 10:39:18 -0800 (PST)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849b7da8sm162994485a.109.2024.11.29.10.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 10:39:16 -0800 (PST)
Message-ID: <7bba577cce61f37b58692b6efd22bb1c61330e20.camel@redhat.com>
Subject: Re: [PATCH] nvme-fabrics: handle zero MAXCMD without closing the
 connection
From: Laurence Oberman <loberman@redhat.com>
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org,  kanie@linux.alibaba.com, kch@nvidia.com,
 emilne@redhat.com, jmeneghi@redhat.com
Date: Fri, 29 Nov 2024 13:39:15 -0500
In-Reply-To: <20241129141706.261171-1-mlombard@redhat.com>
References: <20241129141706.261171-1-mlombard@redhat.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SRszACN2NGcgPC07m7U7GnN3fp8XedIk3BfHdvTdOrs_1732905558
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_103922_766705_C6399425 
X-CRM114-Status: GOOD (  19.27  )
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

On Fri, 2024-11-29 at 15:17 +0100, Maurizio Lombardi wrote:
> The NVMe specification states that MAXCMD is mandatory
> for NVMe-over-Fabrics implementations. However, some NVMe/TCP
> and NVMe/FC arrays from major vendors have buggy firmware
> that reports MAXCMD as zero in the Identify Controller data
> structure.
>=20
> Currently, the implementation closes the connection in such cases,
> completely preventing the host from connecting to the target.
>=20
> Fix the issue by printing a clear error message about the firmware
> bug
> and allowing the connection to proceed. It assumes that the
> target supports a MAXCMD value of SQSIZE + 1. If any issues arise,
> the user can manually adjust SQSIZE to mitigate them.
>=20
> Fixes: 4999568184e5 ("nvme-fabrics: check max outstanding commands")
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
> =C2=A0drivers/nvme/host/core.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1a8d32a4a5c3..91ee2c3aa95e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3257,8 +3257,9 @@ static int nvme_check_ctrl_fabric_info(struct
> nvme_ctrl *ctrl, struct nvme_id_ct
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ctrl->maxcmd) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0dev_err(ctrl->device, "Maximum outstanding commands
> is 0\n");
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return -EINVAL;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0dev_err(ctrl->device,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"Firmware=
 bug: maximum outstanding commands
> is 0\n");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0ctrl->maxcmd =3D ctrl->sqsize + 1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;

A similar fix was tested by a customer seeing this issue and they can
now connect to their array again.
Looks good.

Reviewed-by: Laurence Oberman <loberman@redhat.com>


