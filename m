Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B41CA5FC5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 16:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HbvtTgQfS2w7xkwQMd4dxfTuimVr1wZpXFUl3NwHi4E=; b=pBDuvg913Tm8I43ekW3qGYBuxw
	v12qAqO5XhnseGbOBnMyCv+EwDuiHGnkR3vFyunUgq+AItbQcagxJXyb5oAKLeGTh74xTw7QpW4PU
	HcMjbnfx4ekorG4BkbVWIwSyhbRI6HiGtonDRpkGt6GK6b40J8ctXrBPYLMhT/r8lOvQIVJ1/OEIt
	f/uVSk3Igdgvg8zA+eCjZkl1+vLXUTSgs2dS7sWrMyZDQCzo5pbgsuC8EAhtRWV3Jf7+5Ao8fzbG1
	fhKqYEkapNkR//CkR/b6XlaEaER1s7VuSJRj+SLec7bnwD8u+koufzsr6f4XGjwilbUr6xIRWJpfp
	1SL4hXww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBwjC-00000006cCt-3C6r;
	Wed, 30 Sep 2026 16:00:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBwj8-00000006cBn-2WlQ
	for linux-nvme@lists.infradead.org;
	Wed, 30 Sep 2026 16:00:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790784011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbvtTgQfS2w7xkwQMd4dxfTuimVr1wZpXFUl3NwHi4E=;
	b=JOq6FAZ5hdC2nVMKpe4vcZ4+uR/wo3ifjtQFnlDEiWqF/uBj5jMBOMuh1/TUSH5kGzibv0
	xRTk30bfwoDwn0eDIslc9+Qv04oufrHLkLi18F/tw5N98kh07auwkNb0askWpe4y8OqmE+
	15nfOrzjwWXGmqZ+AZutYms5tUnhp3Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-egxcpujDNNydrmP-XyWI3Q-1; Wed, 30 Sep 2026 12:00:10 -0400
X-MC-Unique: egxcpujDNNydrmP-XyWI3Q-1
X-Mimecast-MFC-AGG-ID: egxcpujDNNydrmP-XyWI3Q_1790784009
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-532c6028621so65338131cf.1
        for <linux-nvme@lists.infradead.org>; Wed, 30 Sep 2026 09:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790784009; x=1791388809;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rswwO4jduymRlqfwk2hkvrsb0tcbIMml5VZ3Fn+B1L0=;
        b=UlYA0LchqSGB8eiuwIuiBppbzDUYiDvAe0bggP1DkbTmLf+n1PIdRCrQYE8pOkr6WW
         4nwGkTLEOtexPoleJ+dOD8yJ4O6C6XiNjj+Ls0fQ56W1ryUZKipUfx3kYPhb4XtpYBDe
         T9udK54MHa65w7FJcorVQsgPkvgfFx1htuhmBy+/1dL8Ue9tkYe1/L+K6epK3ZXLMulr
         q1WGKo1SCFrgIlAbLacBn0zM7XLi1lDsll95qDyU2sLJgTk7cX9ESipHfF5cveyi4mS2
         KvpEqFPgLAhq2euiJWoKtSSSQYc57DACUGe7sTHRR5Vp/WuoZvMwz4MPEebGkXZGIR1U
         p4sg==
X-Forwarded-Encrypted: i=1; AKwUvBxv0EsaiFeXcDce0jxoJLZbc0he0zS+whCVW9B8YxgRpTOookyJTOMCgNvx9AmPQADecX+IDDA6Wqv0@lists.infradead.org
X-Gm-Message-State: AFuF++knSCFSuAKmg8rCCxqBtVnWbnirxXZncmqo1QI4KqbMWB6XXamX
	sGCIETcWsuRmnHbufqTfYTJoF05Ne0Wpoo8Oi5ogQ/6NjBRMUQbZfQBx6+4alpqc27s9ke6TRn9
	p5b5fSstxS36UOxN3aPsjSfGpsek6jF94d8tYiJjq5CiatRcSGvlWc+2yvOadXHgykZx4
X-Gm-Gg: AYBFou2dVH0qTjgXD7fmyq7G9EVBthaI8sOxgNGW4NgVjpske7JZ776bxwUn9B10Pcz
	YoOyUZM9olcEv0LUzrne9hfsFai1IhUxYjx2GtM1RZN3kCmKbuZ8N/xxkhk/ByTJBaocH/R7DP1
	vTQ4v2E7EJWXX3DAPRmwjhH+z86NLRNM7TqN0c6uajXQUw5isZOAHkahHhMj2LD7K4BTCTTVoeT
	WxNvWj9dQjmqM6rZsKkXHcEhOlM71TuFARQMiC0w6R0nxpKmYv6ZlF21TAX0ulT90iK1U4WfE+r
	r7HC+CCEpTfqtT1K6cgX7SVrMu6Ibp0Ylmq6FmNS9TZwgdqfROpeNP9fGFjbOUiNb+R0K8xGGbu
	OwutgZC6Q151wPwgibdGuCSIi9MgbSvz3hIpm
X-Received: by 2002:a05:6214:5b85:b0:914:43b1:d4e8 with SMTP id 6a1803df08f44-917a0b26709mr28871246d6.10.1790784008936;
        Wed, 30 Sep 2026 09:00:08 -0700 (PDT)
X-Received: by 2002:a05:6214:5b85:b0:914:43b1:d4e8 with SMTP id 6a1803df08f44-917a0b26709mr28870146d6.10.1790784008156;
        Wed, 30 Sep 2026 09:00:08 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a8a22f96sm2778796d6.32.2026.09.30.09.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:00:07 -0700 (PDT)
Message-ID: <ada8481da01e3e4c7800fafdb75bf219fdc07672.camel@redhat.com>
Subject: Re: [PATCH] nvme-multipath: report "none" iopolicy for discovery
 subsystems
From: Laurence Oberman <loberman@redhat.com>
To: Martin George <martinus.gpy@gmail.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, Martin George
	 <marting@netapp.com>
Date: Wed, 30 Sep 2026 12:00:06 -0400
In-Reply-To: <20260930153658.4002-1-marting@netapp.com>
References: <20260930153658.4002-1-marting@netapp.com>
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WDuct4MU8aWyFkHeWS5wp5qJfwC5ucqKmVMOvdwUbuk_1790784009
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_090015_050204_CDF07CAF 
X-CRM114-Status: GOOD (  23.35  )
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

On Wed, 2026-09-30 at 21:06 +0530, Martin George wrote:
> A discovery subsystem never exposes namespaces, so it has no
> multipath
> head and no I/O paths to select between. Nevertheless the per-
> subsystem
> iopolicy attribute is registered unconditionally and reads back the
> driver-wide default which is 'numa' for the discovery subsystems too.
> This can be misleading as it suggests a path selection policy is in
> effect when nothing is ever selected, and writing the attribute
> silently
> mutates state that can never be used.
>=20
> Report "none" instead for a discovery subsystem, and reject writes
> with -EOPNOTSUPP. Report "none" from iopolicies as well, so that the
> value read from iopolicy always remains a member of the set
> advertised
> by iopolicies; otherwise userspace validating the current policy
> against the available ones would reject its own subsystem.
>=20
> And while at it, document iopolicies too, which was not covered when
> it
> was added previously.
>=20
> Signed-off-by: Martin George <marting@netapp.com>
> ---
> =C2=A0Documentation/ABI/stable/sysfs-nvme | 15 +++++++++++++++
> =C2=A0drivers/nvme/host/multipath.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 12 ++++++++++++
> =C2=A02 files changed, 27 insertions(+)
>=20
> diff --git a/Documentation/ABI/stable/sysfs-nvme
> b/Documentation/ABI/stable/sysfs-nvme
> index a0bb88ca1694..67795a2dd905 100644
> --- a/Documentation/ABI/stable/sysfs-nvme
> +++ b/Documentation/ABI/stable/sysfs-nvme
> @@ -465,6 +465,21 @@ Description:
> =C2=A0=09=09selections. Only available when
> CONFIG_NVME_MULTIPATH is
> =C2=A0=09=09enabled.
> =C2=A0
> +=09=09A discovery subsystem has no namespaces and hence no
> I/O
> +=09=09paths to select from: reading returns "none" and
> writing
> +=09=09fails with EOPNOTSUPP.
> +
> +What:=09=09/sys/class/nvme-subsystem/nvme-subsysX/iopolicies
> +Date:=09=09September 2026
> +KernelVersion:=097.4
> +Contact:=09Laurence Oberman <loberman@redhat.com>
> +Description:
> +=09=09Shows the I/O path selection policies that may be
> written
> +=09=09to the iopolicy attribute of this subsystem,
> separated by
> +=09=09spaces: "numa round-robin queue-depth". A discovery
> +=09=09subsystem accepts no policy at all and reports
> "none".
> +=09=09Only available when CONFIG_NVME_MULTIPATH is
> enabled.
> +
> =C2=A0What:=09=09/sys/class/nvme-subsystem/nvme-subsysX/subsystype
> =C2=A0Date:=09=09September 2021
> =C2=A0KernelVersion:=095.16
> diff --git a/drivers/nvme/host/multipath.c
> b/drivers/nvme/host/multipath.c
> index 11871f5f18c2..56ee25b448ad 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -1054,6 +1054,10 @@ static ssize_t
> nvme_subsys_iopolicy_show(struct device *dev,
> =C2=A0=09struct nvme_subsystem *subsys =3D
> =C2=A0=09=09container_of(dev, struct nvme_subsystem, dev);
> =C2=A0
> +=09/* A discovery subsystem has no namespaces and hence no I/O
> paths */
> +=09if (subsys->subtype =3D=3D NVME_NQN_DISC)
> +=09=09return sysfs_emit(buf, "none\n");
> +
> =C2=A0=09return sysfs_emit(buf, "%s\n",
> =C2=A0=09=09=09=C2=A0 nvme_iopolicy_names[READ_ONCE(subsys-
> >iopolicy)]);
> =C2=A0}
> @@ -1088,6 +1092,9 @@ static ssize_t
> nvme_subsys_iopolicy_store(struct device *dev,
> =C2=A0=09=09container_of(dev, struct nvme_subsystem, dev);
> =C2=A0=09int policy;
> =C2=A0
> +=09if (subsys->subtype =3D=3D NVME_NQN_DISC)
> +=09=09return -EOPNOTSUPP;
> +
> =C2=A0=09policy =3D nvme_iopolicy_parse(buf);
> =C2=A0=09if (policy < 0)
> =C2=A0=09=09return policy;
> @@ -1101,8 +1108,13 @@ SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
> =C2=A0static ssize_t iopolicies_show(struct device *dev,
> =C2=A0=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribu=
te *attr, char
> *buf)
> =C2=A0{
> +=09struct nvme_subsystem *subsys =3D
> +=09=09container_of(dev, struct nvme_subsystem, dev);
> =C2=A0=09int i, len =3D 0;
> =C2=A0
> +=09if (subsys->subtype =3D=3D NVME_NQN_DISC)
> +=09=09return sysfs_emit(buf, "none\n");
> +
> =C2=A0=09for (i =3D 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++)
> =C2=A0=09=09len +=3D sysfs_emit_at(buf, len, "%s%s", i ? " " : "",
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 nvme_iopolicy_names[i]);

Hi Martin, thank you, yes, an oversight on my part not to update the
documentation.=C2=A0
Thanks for adding that patch.

In addition, your discovery patch change looks good to me.

Reviewed-by: Laurence Oberman <loberman@redhat.com>


