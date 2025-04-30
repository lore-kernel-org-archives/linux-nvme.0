Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A36C3ABA9
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 16:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:To:From:Subject:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YzZLP1dF3NySAeux1xXmJ+6NQEHNpV6GfLzZFfCZkHE=; b=NSIeHyVauzLolvReUDUv0aI7b1
	Rcnhi0bNR/s/ZXIE39hpBHMqxVR0PbMyXMmFaQPva+pWCgBlOPjylqzAaIdXWaVFpKM+nFXpiF3db
	SbUxpb2dM+QPeRMfUw6UDiOJvYWAjbJ+AMoP5BiyP99YK9x5xBGOyClynH2Wscdx0n9zxEYmQjb20
	llZZWXDyxitkUzS3DjaYmCZAcDmoN0cQgnITEMHXAtoHeZ7CZxfxqcvwOsgwyml4kSBinQx1Qt9ho
	FI/zcz4sQiGU2LsKUf3tumbWATAh1421x0kP50ujZumMtkuOKqwxTKltEBsxw46ckayCVyO6kT6XT
	LD1zxS/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAA8h-0000000DPTa-02aO;
	Wed, 30 Apr 2025 16:18:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAA6k-0000000DP7q-2Xg1
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 16:16:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746029784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YzZLP1dF3NySAeux1xXmJ+6NQEHNpV6GfLzZFfCZkHE=;
	b=WWxtppeUWXeGWMPVpgJxNZzikgNCOvBSwDd7VIVw6YkUc3kdnu+B/ltR+cHA1u0Y5P/anN
	XuMXpjRuQr4B8m+9Yjlo/IrQjer8AOo+HNRqndYeT6rIw/yiY0/kd39cqVvd7aEij7GVje
	CPR5HQYWSdZ8e0rSvaB5Fb9jANi3Z8U=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-5DOXAfb5N6ukJdBpAhiWFg-1; Wed, 30 Apr 2025 12:14:52 -0400
X-MC-Unique: 5DOXAfb5N6ukJdBpAhiWFg-1
X-Mimecast-MFC-AGG-ID: 5DOXAfb5N6ukJdBpAhiWFg_1746029691
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3f6a5103779so34292b6e.3
        for <linux-nvme@lists.infradead.org>; Wed, 30 Apr 2025 09:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746029690; x=1746634490;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rmrQwzOaD/Q5jFmp2CPseUaZsrrmER6oKUvs5YxaHI=;
        b=NIdSq/uAThU6iwta3gck8DKKWHw/O1ugfv30LWwzD+2V2xkdpxRjOn3ljAiAj9Jkgu
         OcQAPh9vgGBOGaFv/QiuXEzb/HgGIUTjZltfk+hUZ3ko7I8GkUo2+vetTLmGlGqYTw4N
         uqe4a7qIwLy65KsoJsGpCqgbbZgMINsqvLRJAiHUmtHCPm4yfkkZstN+wEJ4qAUyv0/R
         k3aeoNjauuDhlOd7UAH/bJQzUG4OZK6ybr1IEm1tdIxsybhH5CX4RyHFkLVCvo+moScP
         w6xcvk+Nl0co9w2QKgS4mUVoCL9xur5wkwWoWVvvUgg5YFeb95EVwbqdud35G7OMnm8s
         yUdg==
X-Gm-Message-State: AOJu0YyHQ8X1r0vfxZlrzyf3nJlAdK7Xpo2mJwAvJzOSDryhagZIdz5l
	qGkcfjODcR7dGxTQ+qR1AjTCFCqRsKjnfeOKEF5DXOiZ4Eaogs7UGofnfynBPlMxAmfz6qdJcwI
	iVkoy+ilMuKG4qABqV1Sx1JdchUqK2ZbV3QmzOGuZADDGdpaeXWRaoOGuUbGrEU/X8/Oi6vRYdt
	LhS0YfRQj9PH1wo4PEzIcR7qT4stAFF1vPF1ZvMIlDQq9YhrsP
X-Gm-Gg: ASbGncua2umyGU7Y1VZJSvgZMA8c+fienAHOT0uh0EA5EamOvQHOS6efwoPWz+6TkAd
	jWQ9MuKpZ+5vGaf47+t5chXq9yF9wOJTf8K1XR3z20JmJDwrmf7/Yd77LXPGK6Q4p6N///1btij
	E6zb2LRVgb2EMiUeYMPIxwQJnA8ZfCZOrcDfPLwulYIfHKjkvKugja62P592GzUiXPW5RDFxhLi
	tM+G9S3UKP5SDqcQmvdEuf3OpPECTGfCBcmp3hQkQiJHtGT2cBk9uxYDKgmEQYJ0YHrirtRXoug
	75zVY05gstQX3IwL/z3S7bO9tPEk595o7GZOvkrf95gsyJk+S/rSA5rHMrdIVg==
X-Received: by 2002:a05:6808:6b8b:b0:401:bcae:68 with SMTP id 5614622812f47-402c726783fmr2063248b6e.19.1746029690615;
        Wed, 30 Apr 2025 09:14:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3BD+ezLEGryLlUl/19g7QXDNTdp+aJBgx7JLjy8l8VAZiLJcMdhqzcELpAQ8dc1aVaNe3RA==
X-Received: by 2002:a05:6808:6b8b:b0:401:bcae:68 with SMTP id 5614622812f47-402c726783fmr2063219b6e.19.1746029690171;
        Wed, 30 Apr 2025 09:14:50 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60687012bf7sm818122eaf.33.2025.04.30.09.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 09:14:48 -0700 (PDT)
Message-ID: <b368dde2186500caf71464bc966cf22953c5124a.camel@redhat.com>
Subject: Samsung  PM1733 MZXL53T2HBLS-00AH3 and duplicate id's may need a
 quirk
From: Laurence Oberman <loberman@redhat.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, "Lombardi, Maurizio"
	 <mlombard@redhat.com>, bgurney@redhat.com
Date: Wed, 30 Apr 2025 12:14:46 -0400
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9fD_mulcAZBONfGTT5XfpGbdfNFc-yhvCrBRWI-apI4_1746029691
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_091626_719185_C05C06E5 
X-CRM114-Status: UNSURE (   7.43  )
X-CRM114-Notice: Please train this message.
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

Hello

A customer was attempting to create additional namespaces on this
device and it failed with=20

[ 1120.516952] nvme nvme0: rescanning namespaces.
[ 1120.531873] nvme nvme0: duplicate IDs in subsystem for nsid 2
[ 1120.573891] nvme nvme0: duplicate IDs in subsystem for nsid 4
[ 1120.587822] nvme nvme0: duplicate IDs in subsystem for nsid 5
[ 1120.601886] nvme nvme0: duplicate IDs in subsystem for nsid 6

I added some debug and this was flagged here

we trigger on this and we return -ENVAL


 =09=09if (has_eui64 &&
=09=09    memcmp(&ids->eui64, &h->ids.eui64, sizeof(ids-
>eui64)) =3D=3D 0) {
=09=09=09printk("RHDEBUG: ids->eui64: %pUB h-
>ids.eui64: %pUB\n",&ids->uuid,&h->ids.uuid);
 =09=09=09return -EINVAL;
=09=09}

This leads to the code here bailing with the duplicate id message

static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info
*info)
{
        struct nvme_ctrl *ctrl =3D ns->ctrl;
        struct nvme_ns_head *head =3D NULL;
        int ret;

..
..
        mutex_lock(&ctrl->subsys->lock);
        head =3D nvme_find_ns_head(ctrl, info->nsid);
        if (!head) {
                ret =3D nvme_subsys_check_duplicate_ids(ctrl->subsys,
&info->ids);
                if (ret) {
                        dev_err(ctrl->device,
                                "duplicate IDs in subsystem for nsid
%d\n",
                                info->nsid);
                        goto out_unlock;
                }
..
..
out_unlock:
        mutex_unlock(&ctrl->subsys->lock);
        return ret;
}

My question do we need to add yet another NVME_QUIRK_BOGUS_NID, for
this device model.

Has anybody else seen this

Regards
Laurence


