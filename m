Return-Path: <SRS0=mn4A=X3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D2CC35280
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2019 05:47:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1E42086A
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2019 05:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LNnfvnb1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="JlZiYquG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1E42086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	References:To:In-Reply-To:Date:Subject:Mime-Version:Message-Id:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YWTlFz6UXCFEyGiweej8fin+wis97m0ltF03srRhc7g=; b=LNnfvnb1xOW9xnCvICq2QlHGE
	EeHW90RHFvXp5JELN5B51vyhx4KdDnlqufAlHoc0b1AUw7TIK1HBmYUZeEjZS6M1ImoIZ6XALYzkH
	vcDlQPv5LISQHFCKopq1i9HznPRK2N2K5qAUp5t5s7IL4WmgehnQc/gEcr/zMgrNQKJ2VfRr3LKqw
	apOOHLIa1LLth3ujdfC86BWAyGTRu0cf9+M7bhe/HYDbmnqERpH0dpGtINF1drZLx791uwnKvde0w
	q9HcHNpNBKQN7vshznjEV8WWGX4L5OIHcgnQO3EyUamVgDeUU40os1Q0gsZWAjdqoPkygMkPuuTQV
	6LlAmlW+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iFXTp-0006bQ-5Z; Wed, 02 Oct 2019 05:47:17 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFXTl-0006ai-8c
 for linux-nvme@lists.infradead.org; Wed, 02 Oct 2019 05:47:16 +0000
Received: by mail-ed1-x542.google.com with SMTP id t3so14031479edw.13
 for <linux-nvme@lists.infradead.org>; Tue, 01 Oct 2019 22:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
 :references; bh=gtltGfqs5A0iTwdYRSznbl3W2xRnqo68EXWt45OxsUM=;
 b=JlZiYquGooHdlqYLAasl1TljD/3fNXdxtrkO1Pm+VgR3rMGaM28h53CG/1skcnUZCv
 JbgeDxs4vN8uzUikV79/N3prYoGy7VQasrHemgji8joHKFOAX1sWllW2doRya6t3TETb
 IGcn5hTnOy2IjfghHC35jRQv8VpFrV+Yu2IoIfGBANvU7nvZYIFyYIfx3xVaXLi/fKVe
 HMGvRmz0q0ukPScO+EsxNyFJhfDPEXUW5b+ob/h894a6bxZszJLSLDWjqMEMAbV+1bj4
 C/QH/eWnkjdQWLjJm3xq89bOacQ8AYtWU/Hb1ScGf7K8slsvwOBex294RZINGUN+pX82
 eQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=gtltGfqs5A0iTwdYRSznbl3W2xRnqo68EXWt45OxsUM=;
 b=I1gteKF82M2D4ArxsUdQa5V7tcJ7VL4V2IwGcdjdCjC82w51BGA1FKlxwQsvb8VBiV
 npOqfcA54oRlAv53vucGhMpMoM85B1jV4K2cJ4KBPIE/RVqbsf0MEDBtiXZXRAECqvc4
 3mpOUTnsS7m4tGrJctrThpYtjUKeBGQtow2dZAiHb9xO6Xmoemh6ZbainlXDX6o6w0xo
 y9rUTvlbJJpOk/wa6dU1APiHwBf7AYfqweOjzmkcDocMEt0zByu1tLW9dTHpv4+uPaGP
 wjHynpw9KtsgHeYTvuVlkkuU4wHsZQWFy3Y+wo1xkOKBYT54Rp9QFORN94ZbR+lSm+qB
 b0lA==
X-Gm-Message-State: APjAAAX0CFqt6D6tDA8ZmvilzTT2nu/tk22Nb5sosAVTohJ+QNhh+oaE
 LRwKwCGb/vr3PK+4bfjCUiAIlg==
X-Google-Smtp-Source: APXvYqwxOVlAR6ka/jU0Y4b5Rzp43mBUn2grPIuxxzmkWZZdJJAGhKviemhX1i/23WYK4AcyURMwKQ==
X-Received: by 2002:a17:906:b742:: with SMTP id
 fx2mr1495863ejb.205.1569995228502; 
 Tue, 01 Oct 2019 22:47:08 -0700 (PDT)
Received: from macbook-pro.gnusmas ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id r18sm3655617edl.6.2019.10.01.22.47.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 22:47:07 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <58CA8A6F-46B6-4728-9EF4-ED3EAEEEEE2E@javigon.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] nvme: define struct for __nvme_submit_sync_cmd()
Date: Wed, 2 Oct 2019 07:47:06 +0200
In-Reply-To: <20191001231346.18518-1-chaitanya.kulkarni@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20191001231346.18518-1-chaitanya.kulkarni@wdc.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191001_224713_450905_610C1CD2 
X-CRM114-Status: GOOD (  23.31  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============2510175662082558066=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============2510175662082558066==
Content-Type: multipart/signed;
	boundary="Apple-Mail=_1397B6B2-3197-4FDF-BF52-2A9C13CBBABF";
	protocol="application/pgp-signature";
	micalg=pgp-sha256


--Apple-Mail=_1397B6B2-3197-4FDF-BF52-2A9C13CBBABF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 2 Oct 2019, at 01.13, Chaitanya Kulkarni =
<Chaitanya.Kulkarni@wdc.com> wrote:
>=20
> Over the period of time __nvme_submit_sync_cmd() function has grown to
> accept large number of paratements. The function =
__nvme_submit_sync_cmd()
> now takes 10 parameters. This patch consolidates all the parameters =
into
> one defined structure.
>=20
> This makes calls to the same function easy to read and improves =
overall
> code readability.
>=20
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
> Hi,
>=20
> 	I've compile tested this patch. Once we agree on this change
> 	I'll send out a tested version.
>=20
> Regards,
> Chaitanya
> ---
> drivers/nvme/host/core.c    | 78 +++++++++++++++++++++---------
> drivers/nvme/host/fabrics.c | 96 ++++++++++++++++++++++++++++---------
> drivers/nvme/host/nvme.h    | 18 +++++--
> 3 files changed, 142 insertions(+), 50 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e35615940365..9be51df8fb2f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -769,32 +769,30 @@ static void nvme_execute_rq_polled(struct =
request_queue *q,
>  * Returns 0 on success.  If the result is negative, it's a Linux =
error code;
>  * if the result is positive, it's an NVM Express status code
>  */
> -int __nvme_submit_sync_cmd(struct request_queue *q, struct =
nvme_command *cmd,
> -		union nvme_result *result, void *buffer, unsigned =
bufflen,
> -		unsigned timeout, int qid, int at_head,
> -		blk_mq_req_flags_t flags, bool poll)
> +int __nvme_submit_sync_cmd(struct nvme_submit_sync_data *d)
> {
> 	struct request *req;
> 	int ret;
>=20
> -	req =3D nvme_alloc_request(q, cmd, flags, qid);
> +	req =3D nvme_alloc_request(d->q, d->cmd, d->flags, d->qid);
> 	if (IS_ERR(req))
> 		return PTR_ERR(req);
>=20
> -	req->timeout =3D timeout ? timeout : ADMIN_TIMEOUT;
> +	req->timeout =3D d->timeout ? d->timeout : ADMIN_TIMEOUT;
>=20
> -	if (buffer && bufflen) {
> -		ret =3D blk_rq_map_kern(q, req, buffer, bufflen, =
GFP_KERNEL);
> +	if (d->buffer && d->bufflen) {
> +		ret =3D blk_rq_map_kern(d->q, req, d->buffer, =
d->bufflen,
> +				      GFP_KERNEL);
> 		if (ret)
> 			goto out;
> 	}
>=20
> -	if (poll)
> -		nvme_execute_rq_polled(req->q, NULL, req, at_head);
> +	if (d->poll)
> +		nvme_execute_rq_polled(req->q, NULL, req, d->at_head);
> 	else
> -		blk_execute_rq(req->q, NULL, req, at_head);
> -	if (result)
> -		*result =3D nvme_req(req)->result;
> +		blk_execute_rq(req->q, NULL, req, d->at_head);
> +	if (d->result)
> +		*(d->result) =3D nvme_req(req)->result;
> 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> 		ret =3D -EINTR;
> 	else
> @@ -808,8 +806,20 @@ EXPORT_SYMBOL_GPL(__nvme_submit_sync_cmd);
> int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command =
*cmd,
> 		void *buffer, unsigned bufflen)
> {
> -	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen, 0,
> -			NVME_QID_ANY, 0, 0, false);
> +	struct nvme_submit_sync_data d =3D {
> +		.q =3D q,
> +		.cmd =3D cmd,
> +		.result =3D NULL,
> +		.buffer =3D buffer,
> +		.bufflen =3D bufflen,
> +		.timeout=3D 0,
> +		.qid =3D NVME_QID_ANY,
> +		.at_head =3D 0,
> +		.flags =3D 0,
> +		.poll =3D false
> +	};
> +
> +	return __nvme_submit_sync_cmd(&d);
> }
> EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
>=20
> @@ -1114,19 +1124,30 @@ static int nvme_identify_ns(struct nvme_ctrl =
*ctrl,
> }
>=20
> static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int =
fid,
> -		unsigned int dword11, void *buffer, size_t buflen, u32 =
*result)
> +			 unsigned int dword11, void *buffer, size_t =
buflen,
> +			 u32 *result)
> {
> -	struct nvme_command c;
> +	struct nvme_command c =3D {};
> 	union nvme_result res;
> 	int ret;
> +	struct nvme_submit_sync_data d =3D {
> +		.q =3D dev->admin_q,
> +		.cmd =3D &c,
> +		.result =3D &res,
> +		.buffer =3D buffer,
> +		.bufflen =3D buflen,
> +		.timeout =3D 0,
> +		.qid =3D NVME_QID_ANY,
> +		.at_head =3D 0,
> +		.flags =3D 0,
> +		.poll =3D false,
> +	};
>=20
> -	memset(&c, 0, sizeof(c));
> 	c.features.opcode =3D op;
> 	c.features.fid =3D cpu_to_le32(fid);
> 	c.features.dword11 =3D cpu_to_le32(dword11);
>=20
> -	ret =3D __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
> -			buffer, buflen, 0, NVME_QID_ANY, 0, 0, false);
> +	ret =3D __nvme_submit_sync_cmd(&d);
> 	if (ret >=3D 0 && result)
> 		*result =3D le32_to_cpu(res.u32);
> 	return ret;
> @@ -1954,10 +1975,22 @@ static const struct pr_ops nvme_pr_ops =3D {
>=20
> #ifdef CONFIG_BLK_SED_OPAL
> int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, =
size_t len,
> -		bool send)
> +		    bool send)
> {
> 	struct nvme_ctrl *ctrl =3D data;
> 	struct nvme_command cmd;
> +	struct nvme_submit_sync_data d =3D {
> +		.q =3D dev->admin_q,
> +		.cmd =3D &cmd,
> +		.result =3D NULL,
> +		.buffer =3D buffer,
> +		.bufflen =3D len,
> +		.timeout =3D ADMIN_TIMEOUT,
> +		.qid =3D NVME_QID_ANY,
> +		.at_head =3D 1;
> +		.flags =3D 0;
> +		.poll =3D false;
> +	};
>=20
> 	memset(&cmd, 0, sizeof(cmd));
> 	if (send)
> @@ -1968,8 +2001,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 =
secp, void *buffer, size_t len,
> 	cmd.common.cdw10 =3D cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) =
<< 8);
> 	cmd.common.cdw11 =3D cpu_to_le32(len);
>=20
> -	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, =
len,
> -				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0, =
false);
> +	return __nvme_submit_sync_cmd(&d);
> }
> EXPORT_SYMBOL_GPL(nvme_sec_submit);
> #endif /* CONFIG_BLK_SED_OPAL */
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 74b8818ac9a1..c5a8aec5f046 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -144,14 +144,25 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 =
off, u32 *val)
> 	struct nvme_command cmd;
> 	union nvme_result res;
> 	int ret;
> +	struct nvme_submit_sync_data d =3D {
> +		.q =3D ctrl->fabrics_q,
> +		.cmd =3D &cmd,
> +		.result =3D &res,
> +		.buffer =3D NULL,
> +		.bufflen =3D 0,
> +		.timeout =3D 0,
> +		.qid =3D NVME_QID_ANY,
> +		.at_head =3D 0,
> +		.flags =3D 0,
> +		.poll =3D false
> +	};
>=20
> 	memset(&cmd, 0, sizeof(cmd));
> 	cmd.prop_get.opcode =3D nvme_fabrics_command;
> 	cmd.prop_get.fctype =3D nvme_fabrics_type_property_get;
> 	cmd.prop_get.offset =3D cpu_to_le32(off);
>=20
> -	ret =3D __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, =
NULL, 0, 0,
> -			NVME_QID_ANY, 0, 0, false);
> +	ret =3D __nvme_submit_sync_cmd(&d);
>=20
> 	if (ret >=3D 0)
> 		*val =3D le64_to_cpu(res.u64);
> @@ -190,6 +201,18 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 =
off, u64 *val)
> 	struct nvme_command cmd;
> 	union nvme_result res;
> 	int ret;
> +	struct nvme_submit_sync_data d =3D {
> +		.q =3D ctrl->fabrics_q,
> +		.cmd =3D &cmd,
> +		.result =3D &res,
> +		.buffer =3D NULL,
> +		.bufflen =3D 0,
> +		.timeout =3D 0,
> +		.qid =3D NVME_QID_ANY,
> +		.at_head =3D 0,
> +		.flags =3D 0,
> +		.poll =3D false
> +	};
>=20
> 	memset(&cmd, 0, sizeof(cmd));
> 	cmd.prop_get.opcode =3D nvme_fabrics_command;
> @@ -197,9 +220,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 =
off, u64 *val)
> 	cmd.prop_get.attrib =3D 1;
> 	cmd.prop_get.offset =3D cpu_to_le32(off);
>=20
> -	ret =3D __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, =
NULL, 0, 0,
> -			NVME_QID_ANY, 0, 0, false);
> -
> +	ret =3D __nvme_submit_sync_cmd(&d);
> 	if (ret >=3D 0)
> 		*val =3D le64_to_cpu(res.u64);
> 	if (unlikely(ret !=3D 0))
> @@ -235,6 +256,18 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 =
off, u32 val)
> {
> 	struct nvme_command cmd;
> 	int ret;
> +	struct nvme_submit_sync_data d =3D {
> +		.q =3D ctrl->fabrics_q,
> +		.cmd =3D &cmd,
> +		.result =3D NULL,
> +		.buffer =3D NULL,
> +		.bufflen =3D 0,
> +		.timeout =3D 0,
> +		.qid =3D NVME_QID_ANY,
> +		.at_head =3D 0,
> +		.flags =3D 0,
> +		.poll =3D false
> +	};
>=20
> 	memset(&cmd, 0, sizeof(cmd));
> 	cmd.prop_set.opcode =3D nvme_fabrics_command;
> @@ -243,8 +276,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 =
off, u32 val)
> 	cmd.prop_set.offset =3D cpu_to_le32(off);
> 	cmd.prop_set.value =3D cpu_to_le64(val);
>=20
> -	ret =3D __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, =
NULL, 0, 0,
> -			NVME_QID_ANY, 0, 0, false);
> +	ret =3D __nvme_submit_sync_cmd(&d);
> 	if (unlikely(ret))
> 		dev_err(ctrl->device,
> 			"Property Set error: %d, offset %#x\n",
> @@ -366,10 +398,25 @@ static void nvmf_log_connect_error(struct =
nvme_ctrl *ctrl,
>  */
> int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
> {
> +	struct nvmf_connect_data *data =3D kzalloc(sizeof(*data), =
GFP_KERNEL);
> 	struct nvme_command cmd;
> 	union nvme_result res;
> -	struct nvmf_connect_data *data;
> 	int ret;
> +	struct nvme_submit_sync_data d =3D {
> +		.q =3D ctrl->fabrics_q,
> +		.cmd =3D &cmd,
> +		.result =3D &res,
> +		.buffer =3D data,
> +		.bufflen =3D sizeof(data),
> +		.timeout =3D 0,
> +		.qid =3D NVME_QID_ANY,
> +		.at_head =3D 1,
> +		.flags =3D BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT,
> +		.poll =3D false
> +	};
> +
> +	if (!data)
> +		return -ENOMEM;
>=20
> 	memset(&cmd, 0, sizeof(cmd));
> 	cmd.connect.opcode =3D nvme_fabrics_command;
> @@ -387,18 +434,12 @@ int nvmf_connect_admin_queue(struct nvme_ctrl =
*ctrl)
> 	if (ctrl->opts->disable_sqflow)
> 		cmd.connect.cattr |=3D NVME_CONNECT_DISABLE_SQFLOW;
>=20
> -	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> -
> 	uuid_copy(&data->hostid, &ctrl->opts->host->id);
> 	data->cntlid =3D cpu_to_le16(0xffff);
> 	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
> 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
>=20
> -	ret =3D __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
> -			data, sizeof(*data), 0, NVME_QID_ANY, 1,
> -			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
> +	ret =3D __nvme_submit_sync_cmd(&d);
> 	if (ret) {
> 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
> 				       &cmd, data);
> @@ -436,10 +477,25 @@ EXPORT_SYMBOL_GPL(nvmf_connect_admin_queue);
>  */
> int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid, bool poll)
> {
> +	struct nvmf_connect_data *data =3D kzalloc(sizeof(*data), =
GFP_KERNEL);
> 	struct nvme_command cmd;
> -	struct nvmf_connect_data *data;
> 	union nvme_result res;
> 	int ret;
> +	struct nvme_submit_sync_data d =3D {
> +		.q =3D ctrl->connect_q,
> +		.cmd =3D &cmd,
> +		.result =3D &res,
> +		.buffer =3D data,
> +		.bufflen =3D sizeof(*data),
> +		.timeout =3D 0,
> +		.qid =3D qid,
> +		.at_head =3D 1,
> +		.flags =3D BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT,
> +		.poll =3D poll
> +	};
> +
> +	if (!data)
> +		return -ENOMEM;
>=20
> 	memset(&cmd, 0, sizeof(cmd));
> 	cmd.connect.opcode =3D nvme_fabrics_command;
> @@ -450,18 +506,12 @@ int nvmf_connect_io_queue(struct nvme_ctrl =
*ctrl, u16 qid, bool poll)
> 	if (ctrl->opts->disable_sqflow)
> 		cmd.connect.cattr |=3D NVME_CONNECT_DISABLE_SQFLOW;
>=20
> -	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> -
> 	uuid_copy(&data->hostid, &ctrl->opts->host->id);
> 	data->cntlid =3D cpu_to_le16(ctrl->cntlid);
> 	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
> 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
>=20
> -	ret =3D __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
> -			data, sizeof(*data), 0, qid, 1,
> -			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, poll);
> +	ret =3D __nvme_submit_sync_cmd(&d);
> 	if (ret) {
> 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
> 				       &cmd, data);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 38a83ef5bcd3..f172d8e02fc6 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -395,6 +395,19 @@ struct nvme_ctrl_ops {
> 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
> };
>=20
> +struct nvme_submit_sync_data {
> +	struct request_queue *q;
> +	struct nvme_command *cmd;
> +	union nvme_result *result;
> +	void *buffer;
> +	unsigned bufflen;
> +	unsigned timeout;
> +	int qid;
> +	int at_head;
> +	blk_mq_req_flags_t flags;
> +	bool poll;
> +};
> +
> #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
> 			    const char *dev_name);
> @@ -485,10 +498,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, =
struct request *req,
> 		struct nvme_command *cmd);
> int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command =
*cmd,
> 		void *buf, unsigned bufflen);
> -int __nvme_submit_sync_cmd(struct request_queue *q, struct =
nvme_command *cmd,
> -		union nvme_result *result, void *buffer, unsigned =
bufflen,
> -		unsigned timeout, int qid, int at_head,
> -		blk_mq_req_flags_t flags, bool poll);
> +int __nvme_submit_sync_cmd(struct nvme_submit_sync_data *d);
> int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
> 		      unsigned int dword11, void *buffer, size_t buflen,
> 		      u32 *result);
> --
> 2.22.1
>=20
>=20
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Makes sense to me. We have other places with similar arguments (e.g.,
nvme_submit_user_cmd). Would it make sense to unify this too if we move
in this direction?


Javier

--Apple-Mail=_1397B6B2-3197-4FDF-BF52-2A9C13CBBABF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAl2UOdoACgkQPEYBfS0l
eOD3iQ/6ArM8EI7Y/rOqFCPmDY5O7guaYqj99z0PVYxXxVHg0Inb4mGGb3BEwbyY
50dS4gDj5SWbcjIDfN3GTHlfBU3qU5y22o1hfAMd2EMcU6J3MvDoIQ9c9hPvuldL
C+AkEyKB8VEcO2rv41Xm7FaK1Nuyr5J1GZtowTgYnMANZmkFyHKYHxFBy2qq/Ho5
/Ml7wCfsev8MwPRig8PKlabWvJcozZoRD7GtOQpcdL8MVMPWBm2nRQRPmCTHvLe7
d5V+wxMWayI9V/yZ2pO9hd3bYqvfGmgppl1DzWHi+Q/FcnnKJ76ZibJfkLiRZeQv
pn6UxG527JZLUvP/by0R9zbd9GshT6XoT/dvDNfmShVb+1FbV/cE+pMqDld5lB5a
H/XfDxOMOdRKrjK4SoOZlIYgfXhG3RHJMmRqJU0dp7dDPhhB2dMK/+MgjIOLvFY5
qmvDou5DtCxzQDxc2YN+S+c0VHDxv+EwxYPnVbgtRFhkYZSQDjSHedWJbHr4HfVA
1x0z9jpvcqEqywFoRpP9/dHYsDnE3SJ5I3GlAtDYUOT7KKrERdwkarF2v3TLKPW4
DjdiWasFv8Zxjnrkfl+DUyQpbB4YFQOZGjOIQ6BPrk6tRCfIOSNrxxXxKvB5vo0z
QR/B2ZUoGshNtYX0QobRWTpfHUEl/nJ0qP8vewl8t1DV75zE4PI=
=JOxw
-----END PGP SIGNATURE-----

--Apple-Mail=_1397B6B2-3197-4FDF-BF52-2A9C13CBBABF--


--===============2510175662082558066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============2510175662082558066==--

