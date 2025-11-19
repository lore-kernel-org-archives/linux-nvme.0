Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA61CF2561
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Nov 2025 00:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CDZlStSLRHB3VrSicxQ2qOMHZ8N/BI1QCw7fvMhZCOY=; b=dpvCgtHQEdBr7ih+SXZDYSiI7P
	Vs4NrwD0bb1Ah+rc70LxhNEuEfI+uJXfTZNeAJZSaS3oeBz9BXmhL7rUzhZW22z2g0CUHISNFJWbu
	TZ5wb/gSrM2fk5o2BEneFJca+h/G9/lrHguq+LlUG/S7X8Ip8ADCaIT3C6asHqqbaJUNJ5dw8+6o+
	LXPtmYLc+tH92plBb8HBz6OSjxM1kjgq7G9xUbDjO/Xbo/kbLuaAgiK1NF7Hm/wiKIn8EdZGvfMMs
	LTc/NHbbjHXL63XRyzs5pALH4EsSGLBXPBJowGgmvHoahh2+NFXr4N41zLq4n52o54cp028+2jjnV
	NDf8rQ4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLW0T-00000001Hln-0VmY;
	Wed, 19 Nov 2025 00:25:09 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLW0Q-00000001HlE-0lBR
	for linux-nvme@lists.infradead.org;
	Wed, 19 Nov 2025 00:25:07 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-b71397df721so902000466b.1
        for <linux-nvme@lists.infradead.org>; Tue, 18 Nov 2025 16:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763511904; x=1764116704; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDZlStSLRHB3VrSicxQ2qOMHZ8N/BI1QCw7fvMhZCOY=;
        b=ZkpfHSEGJav51RtHqU3Crn+jNUP1upvkAv+wMDuVtRaMguiAMLNGuWpXwETsIC9NPk
         v0UAah/vAEN3G+8MtkazT5jOl+0XVchXkexnXt1xOIcGakIL69tC0ohZlfqk78otwt3I
         OGgeL58W+FtUG0ZbWHtP8mN2LqtWqPHnbqbBgByMe2b7Bn+AnlpmSKc6OSn8DA8wz0gO
         T3zI4rzL9Rz5NiouYxTlODNrqEEfawMo8tZz02p9NE/Lz3QxON6qusyM1u8eHjrjBZdM
         7RyFtsCf7sT+GckvZjx/ezSTgscIC7SKtkcSXdh2wrHrI08mR7YpC1FQ48QtjP1Lfkrk
         tLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763511904; x=1764116704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CDZlStSLRHB3VrSicxQ2qOMHZ8N/BI1QCw7fvMhZCOY=;
        b=hV8JmJcLVQpd8Kuqqpp/kY7k13eDXCYT56G5OJ7QJLj2u8XOSCzgi6pjtrd5dAWSsK
         99jQN1DQKrWO5flbo8dBGHnRxY9xpDtKx3woRh5gjeYQCjFV9D5C/kVYSKB5kCDU/PWh
         Y4I+6d0Y7ygO2SYepTpiizh9TQxz7ShHzZtYxJUeCG6nGzWBhKci6qqA/A5Tpy9ZT2JV
         Ha54e2hMuGj+tP2ADR3o7nGkM/i8J/BelQ5V00NghH57Rmg84Cjaj7+M7NUPnGeu72FV
         +0CmjYiqQjLuy+klrIxVmDpHPg48EWb4gR1unEOEyfxapuOsKFxx82102aq4LpXBFA5Z
         TkHw==
X-Forwarded-Encrypted: i=1; AJvYcCXuZpDQ5bnJyE5DjW7fsD3LArs2SaF0qNrBfKoGYmLpAEd42mLHa4Vi/+OznQCSXa0MoCt7WNVK6rWf@lists.infradead.org
X-Gm-Message-State: AOJu0YzWbnEefMKc4rwoHf280gPDqvkuYncN0mCnUDvzeJCJOG12AAtj
	EIKrAi3riYIKnMvqMoOIpV8B//McTnmsBKgaUI050HL32KhQaK0L0wt1uDXbpIfnLLv14Vg4fU/
	1mc8Fvdf481EVffnH6Dp7xFQILVFQii4=
X-Gm-Gg: ASbGncuReEvrcxlUVkRDEZ2Ps65uelkcbcZqsRvPQ5gRYHEHdG4HzrnGLtBhuuxGQ/T
	EscFPmZqPEnwHmuIFd7vBvCqTXP3p0+qLhzmBYBqRv80ARdaaMFipGg14L7r0TCs6ph+dJH+ruR
	xchGLdABjTwZZQfnWsri0RGuh1meB2BXJiYt/QALu8FPnbc2SugBr5iXsANkFj7JqEqrQsaOGIk
	jkMXHxsI9JsFeV847Y1Trgf2/skdWLLfkVhmuqgGGSKsIt8otcduCB/m2lTzqnGL8cPVKkVkTqW
	TuVa9FcxBNO6OAsGEIn2vdqBAuk2yvRZAt12MdZj2QYSCCs=
X-Google-Smtp-Source: AGHT+IGJ82kw4JuhyBfJ1zrbQP9vpSnZiRsvQ/OSf0EXheKPfj127CoqmQ4qHj8ia3M8KK+x6sWjaMVR7ECCMvYxLTs=
X-Received: by 2002:a17:907:1c01:b0:b0e:d477:4972 with SMTP id
 a640c23a62f3a-b736780c3b1mr1595969166b.25.1763511903760; Tue, 18 Nov 2025
 16:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20251114045850.1898865-1-alistair.francis@wdc.com>
 <20251114045850.1898865-5-alistair.francis@wdc.com> <e15b39ad-bfdf-4177-86b7-99c84975825e@suse.de>
 <CAKmqyKNViQjZHyftdj7anoF1Wsf9qeRZQiZ9yfM_FsJAcmx7jg@mail.gmail.com> <fd9c30d3-2a9f-4ddc-9d71-436034637acb@suse.de>
In-Reply-To: <fd9c30d3-2a9f-4ddc-9d71-436034637acb@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Nov 2025 10:24:37 +1000
X-Gm-Features: AWmQ_bkzH6_ruoAzNR8in6LwIpewMc1DsvuF-q4owdFRKloisaCfq2zmaCPwaPU
Message-ID: <CAKmqyKMNESv2T=0pqVAqXg-5NfmTJ1qzaHAi3c9e7tCe5uF6Kw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] nvme: Allow reauth from sysfs
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_162506_262590_7E0DE608 
X-CRM114-Status: GOOD (  42.91  )
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

On Tue, Nov 18, 2025 at 9:50=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 11/18/25 01:52, Alistair Francis wrote:
> > On Fri, Nov 14, 2025 at 5:15=E2=80=AFPM Hannes Reinecke <hare@suse.de> =
wrote:
> >>
> >> On 11/14/25 05:58, alistair23@gmail.com wrote:
> >>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>
> >>> Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> >>> This can be done by writing  a zero to the sysfs file.
> >>>
> >>> echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_k=
ey
> >>>
> >>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >>> ---
> >>> v3:
> >>>    - Only trigger if a 0 is written to `tls_configured_key`
> >>>    - Add documentation
> >>> v2:
> >>>    - Trigger on any value written to `tls_configured_key`
> >>>
> >>>    Documentation/ABI/testing/sysfs-nvme | 13 +++++++++++
> >>>    drivers/nvme/host/sysfs.c            | 34 ++++++++++++++++++++++++=
+++-
> >>>    2 files changed, 46 insertions(+), 1 deletion(-)
> >>>    create mode 100644 Documentation/ABI/testing/sysfs-nvme
> >>>
> >>> diff --git a/Documentation/ABI/testing/sysfs-nvme b/Documentation/ABI=
/testing/sysfs-nvme
> >>> new file mode 100644
> >>> index 000000000000..16aaf0dca9e2
> >>> --- /dev/null
> >>> +++ b/Documentation/ABI/testing/sysfs-nvme
> >>> @@ -0,0 +1,13 @@
> >>> +What:                /sys/devices/virtual/nvme-fabrics/ctl/.../tls_c=
onfigured_key
> >>> +Date:                November 2025
> >>> +KernelVersion:       6.19
> >>> +Contact:     Linux NVMe mailing list <linux-nvme@lists.infradead.org=
>
> >>> +Description:
> >>> +             The file is avaliable when using a secure concatanation
> >>> +             connection to a NVMe taget. Reading the file will retur=
n
> >>> +             the serial of the currently negotiated key.
> >>> +
> >>> +             Writing 0 to the file will trigger a PSK reauthenticati=
on
> >>> +             (REPLACETLSPSK) with the target. After a reauthenticati=
on
> >>> +             the value returned by tls_configured_key will be the ne=
w
> >>> +             serial.
> >>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> >>> index 6d10e12136d0..7ff9a5053c3f 100644
> >>> --- a/drivers/nvme/host/sysfs.c
> >>> +++ b/drivers/nvme/host/sysfs.c
> >>> @@ -806,7 +806,39 @@ static ssize_t tls_configured_key_show(struct de=
vice *dev,
> >>>
> >>>        return sysfs_emit(buf, "%08x\n", key_serial(key));
> >>>    }
> >>> -static DEVICE_ATTR_RO(tls_configured_key);
> >>> +
> >>> +static ssize_t tls_configured_key_store(struct device *dev,
> >>> +                                     struct device_attribute *attr,
> >>> +                                     const char *buf, size_t count)
> >>> +{
> >>> +     struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> >>> +     int error, qid;
> >>> +
> >>> +     error =3D kstrtoint(buf, 10, &qid);
> >>> +     if (error)
> >>> +             return error;
> >>> +
> >>> +     /*
> >>> +      * We currently only allow userspace to write a `0` indicating
> >>> +      * generate a new key.
> >>> +      */
> >>> +     if (!qid)
> >>> +             return -EINVAL;
> >>> +
> >>> +     if (!ctrl->opts || !ctrl->opts->concat)
> >>> +             return -EOPNOTSUPP;
> >>> +
> >>> +     error =3D nvme_auth_negotiate(ctrl, 0);
> >>> +     if (error < 0)
> >>> +             return error;
> >>> +
> >>> +     error =3D nvme_auth_wait(ctrl, 0);
> >>> +     if (error < 0)
> >>> +             return error;
> >>> +
> >>> +     return count;
> >>> +}
> >>> +static DEVICE_ATTR_RW(tls_configured_key);
> >>>
> >>>    static ssize_t tls_keyring_show(struct device *dev,
> >>>                struct device_attribute *attr, char *buf)
> >>
> >> Hmm.
> >> Now we are just running (re-) authentication, but that does
> >> not affect the TLS connection (which continues to use the
> >> original key). So you would need to reset the connection
> >> here to re-establish a new TLS connection.
> >
> > Is the connection supposed to be reset? I don't see any mention of
> > that in the spec
> >
> Yeah, that's a bit hard to read (as usual).
> The base spec just claims (Fig. 733, Secure Channel Protocol Identifiers)=
:
>
> 03h: This {PSK, PSK Identity} pair replaces the {PSK, PSK Identity}
>    pair that was used to set up the TLS secure channel over which the
>    authentication transaction is performed.
>
> So from that your implementation is correct, as it just replaces the
> PSK (without actually using them). However, the TCP spec clarifies
> (section 3.6.1.4: PSK Use):
>
> Once the TLS secure channel for the Admin Queue of an association
> has been set up with a generated {PSK, PSK Identity} pair, that
> generated {PSK, PSK Identity} pair should be replaced periodically
> (e.g., every hour) or on demand by performing a reauthentication
> with the SC_C field in the AUTH_Negotiate message set to REPLACETLSPSK
> (refer to the AUTH_Negotiate Message section of the NVM Express
> Base Specification) over the Admin Queue of that association. The most
> recently generated PSK, if any, is the generated PSK associated with
> that Admin Queue.

Yeah, to me "associated with" doesn't necessarily mean that we reset
the connection to use the new PSK.

>
> And the only way to associate a PSK with the admin queue is to use
> it for the TLS encryption, ie re-run the TLS handshake.
>
> Or indeed use the KeyUpdate mechanism.

This is the part that I think is weird.

If we do need to use the new PSK, once a host issues a REPLACETLSPSK
we have to tear down and restart the TLS connection. Which seems
really clunky and the spec doesn't seem to mention that at all.

If the host wants to replace the TLS keys it can just issue a
KeyUpdate, which doesn't involve tearing down the entire connection.
So do we actually need to reset the TLS connection after a
REPLACETLSPSK?

>
> But I'll ask the FMDS group for clarification.

Thanks!

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

