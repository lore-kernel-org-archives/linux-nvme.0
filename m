Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5ADC76188
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 22:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9JPpYFUrnozyGu2F1NIER4sOG/1zftO5WsR14W7P3zA=; b=E0V8PBpq+K0wEcoDjgG+JCikXK
	eN5NRhQpUifETr+UgDiEjTJ8AuJ5QLXUG8oXv+/WMUhzh8+QvEsUJLB5fyLcfMaDqezYG+pP0FGLj
	mMzILh4gVv1UxPwzBZwnxAoRW6t7ObyLEIOLb3RMso9447CHHBlR687Kyhgn/WMfGfQcF71Z4IUSk
	kknlQ9nq3UDbuwqMhdJvd69SflpzXBT/8JkLLkXs19JVKmmZ2y+QzM1TyaLsMqD8iVyP/vbVHGl1L
	gQ4uQv73FgErFcfrwJVRLDfKe2YpK1K/NscB4tqQv5nvxETpjceWkPqrnSiORJLXfatcwroIKb6oo
	FSR4lS0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjSEA-00H0Yi-20;
	Mon, 03 Apr 2023 22:00:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjREq-00GmB3-0R
	for linux-nvme@bombadil.infradead.org;
	Mon, 03 Apr 2023 20:57:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=9JPpYFUrnozyGu2F1NIER4sOG/1zftO5WsR14W7P3zA=; b=iGPzjicbMgSeKIDlPvej38H4QE
	MSLRHeAMekG33yEET0pp8Vr17oKcHrweDyZXRVJxNED34Q0MQj5LI3GCZ/Y/BGpmnYqNaDcXxmqHq
	Itovg9GSoB3wUjvUn0/eJH5RYtgLM5fQ5c8dz3HTrIwIVBa+dXz7FyI9PApX894luGr6npf/9fWbc
	Y0l1roNcZQ3FeYU2C+cNMp19iNLQ8OkJ6W9671bualVaIi28jBf6wGRYaqA2r+UNpL4HLJhbCWGej
	sc0pkV8BTM1k3GJrJRjxR3xIHhViCPON0SB5yAuMa//f9NK3+3XWI/Ytugh0yLTWFopxKFVdfVqm5
	G7qBc36g==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjREk-0091Jo-1q
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 20:57:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680555426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9JPpYFUrnozyGu2F1NIER4sOG/1zftO5WsR14W7P3zA=;
	b=FNUtMKhzqQ5ttcgv3c6qQxKz+l3BDaDOz78PzDW3CU4Xb71rQ1ER+9LiwKD3wfzDNHXC/i
	K0adxwNAmBsrQ7d/paOlD4di5XaIIyJ9nQ4Q44NQDv4XQm/9UtAvykPC+crdTqih1etCCk
	upuGd/UAQNbLwo1JfBEvLAT+62qiXuw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680555426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9JPpYFUrnozyGu2F1NIER4sOG/1zftO5WsR14W7P3zA=;
	b=FNUtMKhzqQ5ttcgv3c6qQxKz+l3BDaDOz78PzDW3CU4Xb71rQ1ER+9LiwKD3wfzDNHXC/i
	K0adxwNAmBsrQ7d/paOlD4di5XaIIyJ9nQ4Q44NQDv4XQm/9UtAvykPC+crdTqih1etCCk
	upuGd/UAQNbLwo1JfBEvLAT+62qiXuw=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-13E8nMZRO2maovJwc90jCA-1; Mon, 03 Apr 2023 16:57:05 -0400
X-MC-Unique: 13E8nMZRO2maovJwc90jCA-1
Received: by mail-oo1-f71.google.com with SMTP id h10-20020a4a420a000000b0053685955a14so8056562ooj.19
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 13:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680555424;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JPpYFUrnozyGu2F1NIER4sOG/1zftO5WsR14W7P3zA=;
        b=lN2fwRgePSe/wGlhB6zjy7BsI/uoO9Ycob91rMyWGq6csu1lTYqyIrtNzltfmR7Soq
         agrHjqKXjTfx+um+pPfgS7rercden+v1IRFKwJO54g3kWr7JLQRIh/FsmBrynM3jWEzW
         4beHoBgxc0tHBU1sTPoljtScWhMBHkinEIYh/8eyyJr6wK9VNhWfYDCUdxpCmw69MDW4
         6ojnkbnrtWb+n3Di94P6iznghyAr3ljF0YtjSv0RzuVrb8src99IY00nZ++42avankbk
         qycJ7y7mSJYMRgTjEy359vxXuyGZscJ23Bm7ZdWxuaNOEEEqqOcKRrqnb9RY7hmFKqOa
         aFfQ==
X-Gm-Message-State: AAQBX9cKrQlEsaOBd9zNgEjDx9xYCXld1T9yrwuZZnkVoLwy21/ofPRr
	IuMmTaWcad/1sksB/L9qiY+jDmqGgRac5iAcrJmBjn3MPrUqgpD/sQmu1Mm1/ZITCHcGKB/YrBW
	7UmFODk0SygsZkIvcRQ3ZlpIeKDM=
X-Received: by 2002:aca:f01:0:b0:389:8d22:5ef4 with SMTP id 1-20020aca0f01000000b003898d225ef4mr328235oip.11.1680555424214;
        Mon, 03 Apr 2023 13:57:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350asGqtK1YBd/XC40U+WYkvN3OYoJ8E6d8uaudaYPmTUbrTk98mc+YnVob7yKn8U7qssTedx1g==
X-Received: by 2002:aca:f01:0:b0:389:8d22:5ef4 with SMTP id 1-20020aca0f01000000b003898d225ef4mr328205oip.11.1680555422505;
        Mon, 03 Apr 2023 13:57:02 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:45:ae91:c478:3bf0? ([2600:6c64:4e7f:603b:45:ae91:c478:3bf0])
        by smtp.gmail.com with ESMTPSA id x14-20020a056808144e00b00387160bcd46sm4219223oiv.46.2023.04.03.13.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 13:57:02 -0700 (PDT)
Message-ID: <83798dc24370f7db627b13a09c57c4a139a0fd3a.camel@redhat.com>
Subject: Re: [PATCH] nvme: fix discard support without oncs
From: Laurence Oberman <loberman@redhat.com>
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: sagi@grimberg.me, Keith Busch <kbusch@kernel.org>, Tom Yan
	 <tom.ty89@gmail.com>
Date: Mon, 03 Apr 2023 16:57:00 -0400
In-Reply-To: <20230403200925.1641963-1-kbusch@meta.com>
References: <20230403200925.1641963-1-kbusch@meta.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_215710_919669_B04F4DB3 
X-CRM114-Status: GOOD (  20.02  )
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

On Mon, 2023-04-03 at 13:09 -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>=20
> The device can report discard support without setting the ONCS DSM
> bit.
> When not set, the driver clears max_discard_size expecting it to be
> set
> later. We don't know the size until we have the namespace format,
> though, so setting it is deferred until configuring one, but the
> driver
> was abandoning the discard settings due to that initial clearing.
>=20
> Move the max_discard_size calculation above the check for a '0'
> discard
> size.
>=20
> Fixes: 1a86924e4f46475 ("nvme: fix interpretation of DMRSL")
> Cc: Tom Yan <tom.ty89@gmail.com>
> Reported-by: Laurence Oberman <loberman@redhat.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> =C2=A0drivers/nvme/host/core.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 53ef028596c61..d6a9bac91a4cd 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1674,6 +1674,9 @@ static void nvme_config_discard(struct gendisk
> *disk, struct nvme_ns *ns)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct request_queue *que=
ue =3D disk->queue;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 size =3D queue_logica=
l_block_size(queue);
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ctrl->dmrsl && ctrl->dmrsl=
 <=3D nvme_sect_to_lba(ns,
> UINT_MAX))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0ctrl->max_discard_sectors =3D nvme_lba_to_sect(ns,
> ctrl->dmrsl);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ctrl->max_discard_sec=
tors =3D=3D 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0blk_queue_max_discard_sectors(queue, 0);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return;
> @@ -1688,9 +1691,6 @@ static void nvme_config_discard(struct gendisk
> *disk, struct nvme_ns *ns)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (queue->limits.max_dis=
card_sectors)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ctrl->dmrsl && ctrl->dmrsl=
 <=3D nvme_sect_to_lba(ns,
> UINT_MAX))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0ctrl->max_discard_sectors =3D nvme_lba_to_sect(ns,
> ctrl->dmrsl);
> -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0blk_queue_max_discard_sec=
tors(queue, ctrl-
> >max_discard_sectors);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0blk_queue_max_discard_seg=
ments(queue, ctrl-
> >max_discard_segments);
> =C2=A0

Many Thanks Keith for the quick ressponse

I can confirm this patch fixes the issue and I have discard support
again on the Infinidat device.

[   33.240602] nvme nvme1: creating 8 I/O queues.
[   33.330643] nvme nvme1: mapped 8/0/0 default/read/poll queues.
[   33.348589] nvme nvme1: new ctrl: NQN "nqn.2020-
01.com.infinidat:36000-subsystem-696", addr 192.168.1.2:4420
[   37.590766] XFS (nvme1n1): Mounting V5 Filesystem 6763a33f-18cc-
4a26-894b-8b0f8d79a98a
[   40.762363] XFS (nvme1n1): Ending clean mount

Tested-by: Laurence Oberman <loberman@redhat.com>



