Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974AC606A320
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=X885HTzT;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W4FWu9SM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=eiT5UW9C6XQOoPBhpeVtefFkNp+vbdCYy9PPIfn8WjI=; b=X885HTzTfVpwsn
	YGcZrZJmcpQXw4xngM/6HJVnGPSNpkFJ2o05OkyBr0VOjg9o8Ama38H4fnnl5jspf8wTX74sNQHk3
	uuYX34Xkgkak0A4vBPntl9WRxqImUc1iaXVcv+osCmP9LK6/Gx2IeBZvR84nkI9kU8hjrvgTnoq8q
	2YjYK2MQE+1qhwfRs42NpK7E7Wy6bVTj6wMR5oI5CnwHKAjpiqLPP380DqC3PFqcAk0o9alHHBW8p
	Il0A8PRjva025iCOOPwV6MRUDFUIsvdHbnUPaqynOEdiWSMUYcfpUs+lxEx+K5r0QHpDlnyl2GTTV
	V1K4evr4BfTMOcIKUxxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKGQV-0000000GXkh-3a0R;
	Fri, 23 Oct 2026 14:39:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKGQS-0000000GXkL-0vgK
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 14:39:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792766359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiT5UW9C6XQOoPBhpeVtefFkNp+vbdCYy9PPIfn8WjI=;
	b=W4FWu9SMTMrMeMKlV0QwBJCB9NVmRlODxO7/Cssd+qJqfxwmAUrvv51nFY0CCq/E7hdBlO
	P1syVz74UCd8GFcZPngh7Bmipu3duokhBCYOO/pmPrPm+uGd03EImfDRizzWkoGRxl4RYE
	QBIHwTA4YgIgd9MH91wRTMDV8wb4mqs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-QgcXWErHMjaKQKacs_rAqQ-1; Fri, 23 Oct 2026 10:39:11 -0400
X-MC-Unique: QgcXWErHMjaKQKacs_rAqQ-1
X-Mimecast-MFC-AGG-ID: QgcXWErHMjaKQKacs_rAqQ_1792766350
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e0461e040so740805f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2026 07:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792766350; x=1793371150;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CFsMCfEnZVGx0A+gR98zw6zkPjD6BOiuVa7LOMuev0w=;
        b=Dd2Tf1eZ/9hUqSItBG3UWkiGODeFiObOoNMx7y/TGQ2q7x8GPQitsoFPMZpbAnoZsr
         TDhzP8Ap4GTdfDTp9H/oi4+sDz9Zb9zIh1wZxVINnEJ0D6/w53yQLaDK1crSs39dm0WO
         WUty9OAD9i4y/QDGlu39svyfqHyqihMDh996N1/bl1TBpo9fT2muCU6g4938vlVI19BO
         0Ioyq0v6aWnXsSrHxwMc57T2PWouaBtPCVS0DCj7JbxKzsIm+Tk09y0Jsa2gSsMCS8eH
         OKfbKi4uWbtePp5VmMYaBiZbieAR5nAzlsK4DAuLsqy7laXy9t9j0hc36CP7+UR5oL/v
         P6UA==
X-Forwarded-Encrypted: i=1; AKwUvBw3Is6S/ZitUo+yCXS08JlUR3zm+LhMID8FMxyKoDdd0DZdOs2zSJEJW1tf4GfRHNg31CeqlZCLgJfA@lists.infradead.org
X-Gm-Message-State: AFq9FYIjyECjqqReS3nIDCukjBxQu3ufshRSPBsIJCuWv4NmcQvsMb4H
	Eow3zMJFMrjEqtGIa0z5fNcpu11w40ZicjeTmBETWgtmimIkBV4CrZMw74zpsRQ4Mja8cRrzrCL
	Fy4bbI28PGvEQtWTYoeqWdDoBIHyrlHgHBatKfSAeM1HnvDje0L+o7/pctz4yM/awXPNVRy3UH4
	2q
X-Gm-Gg: AYBFou3BY3ZWmzAbFzSZw4971OpTTf7eO3j5cNIJq0GTg83o4YjM7GaYAfAEivukj8M
	i0U4z8B3So66AlOAIW2oNxuZdBDzc+yXWaO/H3Zi8obhMgJJtdyO+IHmeYem9eLqQ3MMwD9Ux3T
	T7g22+znkVbOyDFwlgguDXyWanNGIZyaKeHbm8kACviJq8mfdG3egeUAk5dyEAZPwNvS+4dKDzQ
	187AnaGYBX/feo+PZLjw3iVVKNiogAFutgEuNWQMtParjMe+Ei3dVbrqAETxuJ7SPlNYzxzsq0X
	DwW2lguJsgS9HPvedkQZUdAL/c1HHm5jFy3+MbfpM/yvV25PA7ZPfnpxna/EU5wN9Ci6MXaaq4E
	+no7vnHdEZJKe937k/2k9pWQlopNl48T/tTlI
X-Received: by 2002:a05:600c:314f:b0:4a2:b89:b02 with SMTP id 5b1f17b1804b1-4a211c9c5c1mr40864055e9.10.1792766350128;
        Fri, 23 Oct 2026 07:39:10 -0700 (PDT)
X-Received: by 2002:a05:600c:314f:b0:4a2:b89:b02 with SMTP id 5b1f17b1804b1-4a211c9c5c1mr40863655e9.10.1792766349737;
        Fri, 23 Oct 2026 07:39:09 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d3ee6bdsm192802f8f.15.2026.10.23.07.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:39:09 -0700 (PDT)
Message-ID: <cc8cee8648fd4a1614b71a49606c9520f87ae1e4.camel@redhat.com>
Subject: Re: [PATCH] nvme-fc: fix reference leak in
 nvme_fc_nvme_discovery_store()
From: Laurence Oberman <loberman@redhat.com>
To: Martin George <martinus.gpy@gmail.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Date: Fri, 23 Oct 2026 10:39:03 -0400
In-Reply-To: <20261023140057.6045-1-marting@netapp.com>
References: <20261023140057.6045-1-marting@netapp.com>
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KEdM8oCkxvKrpqFPrTCd8MOJte2auR0D8Sbbwvmff6c_1792766350
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_073920_340402_C67258C5 
X-CRM114-Status: GOOD (  17.36  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-10-23 at 19:30 +0530, Martin George wrote:
> nvme_fc_nvme_discovery_store() takes an lport and rport reference
> before
> checking whether the rport is already queued on the local discovery
> list. On the retry path (goto restart), rports that were queued in an
> earlier pass are skipped by the list_empty() check, but the
> references
> taken for them in the current pass are never dropped, leaking one
> lport
> and one rport reference per retry.
>=20
> Check list_empty() first and only take references for rports that are
> actually added to the local discovery list.
>=20
> Signed-off-by: Martin George <marting@netapp.com>
> ---
> =C2=A0drivers/nvme/host/fc.c | 7 ++++---
> =C2=A01 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 48454cb7a0fc..03f6fffc9574 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3778,6 +3778,9 @@ static ssize_t
> nvme_fc_nvme_discovery_store(struct device *dev,
> =C2=A0restart:
> =C2=A0=09list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
> =C2=A0=09=09list_for_each_entry(rport, &lport->endp_list,
> endp_list) {
> +=09=09=09/* skip rports already queued for discovery
> */
> +=09=09=09if (!list_empty(&rport->disc_list))
> +=09=09=09=09continue;
> =C2=A0=09=09=09if (!nvme_fc_lport_get(lport))
> =C2=A0=09=09=09=09continue;
> =C2=A0=09=09=09if (!nvme_fc_rport_get(rport)) {
> @@ -3799,9 +3802,7 @@ static ssize_t
> nvme_fc_nvme_discovery_store(struct device *dev,
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "failures\n");
> =C2=A0=09=09=09=09goto process_local_list;
> =C2=A0=09=09=09}
> -=09=09=09if (list_empty(&rport->disc_list))
> -=09=09=09=09list_add_tail(&rport->disc_list,
> -=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &local_disc_list);
> +=09=09=09list_add_tail(&rport->disc_list,
> &local_disc_list);
> =C2=A0=09=09}
> =C2=A0=09}
>=20
> =C2=A0
This looks good to me.
Reviewed-by: Laurence Oberman <loberman@redhat.com>


