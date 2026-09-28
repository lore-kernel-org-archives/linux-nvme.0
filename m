Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA586CA5FA2
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2026 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7JzwIQlJou2cKoXFRlxragLvVGFjjNACZv+ODl0Exo0=; b=JPa14lonXajcPPJIz22jZ3G97j
	dmZVQiRD8uU5KyGOmD7YveXOFuNCTAWmH06js/sPlNymwqXKf9q2mY/nrtsQxF88k2rq6J7M55Q/i
	The5dBGiYKDP4PmgItBumwzlHGfB2pJOscxiYTmx4MDy5oITRfwZm7uhRtllV9B0jeOTIG0GooDnz
	lg7JnYmSvy9lz6WGXXXIJ3rVRiN3vyWv63/cSPh4rFPGCMyW4KQbr+qTiJxny3RUjSSiHpcYbb+hq
	LFZehsXlbHVmDzY8y/2g6sQMJVkC3hBYyAefIOgK8WLwPQx7B1aCMWubnk5HmI+coS72253OHyzlQ
	EwbM3KKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBCym-00000000rIM-0Djg;
	Mon, 28 Sep 2026 15:09:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBCyj-00000000rH9-1qHs
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 15:09:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790608154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JzwIQlJou2cKoXFRlxragLvVGFjjNACZv+ODl0Exo0=;
	b=cKbbKIZHpZwAH8xn+7V79o5tlYaqZ98mPmJJg4E56uwebLgsJhwpXnxhFacbIUdDWODvQ9
	h74iQY2/XDIddfpAUQbn4xSRWqyMVjsJFimn/6wtyzC/W2MG6G0AoCT3rIcAbUdWivMZO6
	vxhzHdlT/jpInlbpYnqAW+7IKtEGQ+Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-N9YFeVMvMFW7Jady0kk55A-1; Mon, 28 Sep 2026 11:09:13 -0400
X-MC-Unique: N9YFeVMvMFW7Jady0kk55A-1
X-Mimecast-MFC-AGG-ID: N9YFeVMvMFW7Jady0kk55A_1790608152
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4870af30a85so2481848f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 28 Sep 2026 08:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790608152; x=1791212952;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7JzwIQlJou2cKoXFRlxragLvVGFjjNACZv+ODl0Exo0=;
        b=Ld4h1kponB58dii4eeacBSkaKN63MQDJ7rlUVzN2EfSFUeSKsZw9EnfzNxR4UDUhgz
         1BhftCOg7D99f1ksE9Y4YXcfWD3So5cDKiooxDRU7OlpoBo9+X7p1xOBg87cKtE0bqEz
         2BdXD7hUZSXR5ut74PDpUQnGtXQDfv91h83EL3eKpHRza0UJgltmDkkOzISioLAJjxyN
         CmKwzghHOPVSwpM59QbZs6aTW5Tw6wC7f5FYlj1uJxLCY77SFGwQ3ukyrreMvt9PMshl
         UKOQufg7qqHTtMHHvex7vMW77L1c592SeV7dW+J+D527W/lNB+fp0WyJJLYBSvVkQxYB
         WxzQ==
X-Gm-Message-State: AFq9FYIR7C/mFuwSc1+iJs9NPbRHUsfLvLXJ4g3cF846MyW7ZeXfsjcW
	DH9IXLLK9ipSeFqeWNYrsf3qiXZamdDRT8SLAxkEd4j0J2NP3Vsip/a2i5igd4rqmxLyEOLFtfy
	aZnpYucZvO3bniJoFncMzy3mu6u8fUSeNeqiCMaC+Rwvu+D1neTF84DT6NI0yQD5j+zyl0vb2Qg
	ydm7vW+YlYraPK35l8M/spszC9ZPcjkyQ9Hiri5mZ2hsItm5cxB8M=
X-Gm-Gg: AYBFou0J/e3j6EN8taWMmWBMqCO/RwkQ0fJ4BP+3UIQsuZJHpg9HSu96jZZJY7GO+FG
	YDPcYPFbW4NKeOraLhgpEpNFM+Tv8P4bEoSFd1/YwYiw+GAI2OTjaw4bq+EGeo8OeQC91IsvwiX
	CbYPW4k3MRVRLRA6rpC5ouOi2SVBwiEKaLhH88M/sJmSvHiYRUk/OLjI8Qnmks6rDGIIIHJJGLU
	MwT7LDJDkCUhISeqQ==
X-Received: by 2002:a05:6000:2083:b0:487:342:eb28 with SMTP id ffacd0b85a97d-488716f2354mr27611165f8f.24.1790608151743;
        Mon, 28 Sep 2026 08:09:11 -0700 (PDT)
X-Received: by 2002:a05:6000:2083:b0:487:342:eb28 with SMTP id
 ffacd0b85a97d-488716f2354mr27611104f8f.24.1790608151341; Mon, 28 Sep 2026
 08:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260902200547.184734-1-jtaubepe@redhat.com> <20260902200547.184734-8-jtaubepe@redhat.com>
 <ab97f32b-31dd-4975-a8b2-b445110ae3a9@suse.de> <CADRr4bePoiDnWX_XrMWtQe=1g4Yrw1_dK86EV2k9XZR0HnL+UQ@mail.gmail.com>
 <d4879e78-2735-4f86-beab-8aa319e9162c@suse.de> <CADRr4bcSvLwzfSiV0LTxnhZR7oo3F1b2XEo+wwqi668Gr2BBQA@mail.gmail.com>
 <a7a60b61-24b4-429b-8ccb-ee5b6f06a5ed@suse.de>
In-Reply-To: <a7a60b61-24b4-429b-8ccb-ee5b6f06a5ed@suse.de>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Mon, 28 Sep 2026 11:08:59 -0400
X-Gm-Features: AclHuK8rEa0dRLnGnsUacjiVX3fDsEVHWVQeb9zJZDMDBAnfAXNWF2dGmvnsVw0
Message-ID: <CADRr4bfJtQOKYFjDoR+khaPvQW6-UzN70pZ-nfGJnQ22nUkskw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] nvme: fcloop: Add set_marginal_rport to sysfs
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Nilesh Javali <njavali@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, John Meneghini <jmeneghi@redhat.com>, 
	Bryan Gurney <bgurney@redhat.com>, Chris Leech <cleech@redhat.com>, 
	"Ewan D . Milne" <emilne@redhat.com>, shinichiro.kawasaki@wdc.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HARGopqTrlHYnI5CKG2Si6groSG54O0xJ3AxsfLkEyU_1790608152
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_080917_554099_9D5E104D 
X-CRM114-Status: GOOD (  22.55  )
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

On Fri, Sep 25, 2026 at 1:10=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 9/23/26 6:16 PM, Jesse Taube wrote:
> > On Wed, Sep 23, 2026 at 11:34=E2=80=AFAM Hannes Reinecke <hare@suse.de>=
 wrote:
> >>
> >> On 9/23/26 4:56 PM, Jesse Taube wrote:
> >>> On Mon, Sep 21, 2026 at 10:03=E2=80=AFAM Hannes Reinecke <hare@suse.d=
e> wrote:
> >>>>
> [ .. ]
> >>>>> @@ -1671,6 +1719,7 @@ static DEVICE_ATTR(del_remote_port, 0200, NUL=
L, fcloop_delete_remote_port);
> >>>>>     static DEVICE_ATTR(add_target_port, 0200, NULL, fcloop_create_t=
arget_port);
> >>>>>     static DEVICE_ATTR(del_target_port, 0200, NULL, fcloop_delete_t=
arget_port);
> >>>>>     static DEVICE_ATTR(set_cmd_drop, 0200, NULL, fcloop_set_cmd_dro=
p);
> >>>>> +static DEVICE_ATTR(set_marginal_rport, 0200, NULL, fcloop_set_marg=
inal_rport);
> >>>>>
> >>>>>     static struct attribute *fcloop_dev_attrs[] =3D {
> >>>>>         &dev_attr_add_local_port.attr,
> >>>>> @@ -1680,6 +1729,7 @@ static struct attribute *fcloop_dev_attrs[] =
=3D {
> >>>>>         &dev_attr_add_target_port.attr,
> >>>>>         &dev_attr_del_target_port.attr,
> >>>>>         &dev_attr_set_cmd_drop.attr,
> >>>>> +     &dev_attr_set_marginal_rport.attr,
> >>>>>         NULL
> >>>>>     };
> >>>>>
> >>>> Please don't make it a fabrics option.
> >>>
> >>> What do you mean by fabrics option? How should I fix this?
> >>>
> >> Your patch does two things; one is to modify the parser in
> >> fcloop_parse_options, and the other is to implement a new
> >> sysfs rport attribute 'set_marginal_rport()'.
> >> My suggestion is to drop the first part;
> >
> > You want to drop the parser?
> >
> Yes. 'set_marginal_rport()' sets a boolean value.
> You don't really need a parser for that.

Yes, but we need the parser to get the WWPN and WWNN.

Thanks,
Jesse Taube
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich
>


