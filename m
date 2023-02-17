Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B12C636D6
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Feb 2023 21:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jc7+X1cqzOxQsAFytQZ25BlL34wPn1vkCpcwaRRD9oc=; b=BOtRco0Rjx4PQNIPBOqbsFvypm
	qf566pHN6rXHdCtRHNYAARGBlW8VS2XW0SOXXMzR7a/+T1xsvw+bODHKQbmPI11r/GHWrzB08Z6+R
	S2c9tnuMEZ+0ahpdevTcybuYZ/6SlcABGBn5C7fvr8p+qI2OHPQKl3fQMsGTPLeDebT9vW+6VzOwX
	a4BX8+PWc/CeiC+MWjsiWM47WOScwdVbdyHJaPPgQ9ayEKk4GSPapCjc5D7ycGtWdrpuby1Mxt75p
	O4dkBbvuh+valPp4Eaf69VJen91oQyDSSSec1qICKBOkQfIeVMmeZ78D5mPdwdZDrRhzKMb2LMJqC
	G7g6yPhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT8co-00FmFJ-Ol; Fri, 17 Feb 2023 21:50:38 +0000
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT8cl-00FmCr-AA
	for linux-nvme@lists.infradead.org; Fri, 17 Feb 2023 21:50:37 +0000
Received: by mail-vk1-xa29.google.com with SMTP id i49so162737vkr.9
        for <linux-nvme@lists.infradead.org>; Fri, 17 Feb 2023 13:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jc7+X1cqzOxQsAFytQZ25BlL34wPn1vkCpcwaRRD9oc=;
        b=aG0ph1GtjLSjPnNsZT6Zujg2e+f0b8Rfl6R+FvDstE7ptRAuNh9BTny2PJscjWz/Kq
         e8SYVASadRZ2q/DPe+33qofP2a+oI1iF6upND23LGE8QWBSMR0yXOkgRJPB87ViqMGap
         xOj2TYMNbelNY0h5TrnyyvdlBe0JyCXTeil9fFm7VUZsh5CBcFIryCa+/hH9Njhm6KMl
         y2gwk5OTqShm+f52wWM97o1gXi/luJRo08RIdZZhZFDZ9drAnGFru/F1RPKxY6zDZRNb
         tBjyZ7aTUqAo2tRTenuJl4gUH9CAaOY/6BKxjFcUll7Z7D9RbJaY/Mf7oTS3DwjgXPes
         SdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jc7+X1cqzOxQsAFytQZ25BlL34wPn1vkCpcwaRRD9oc=;
        b=MWxiI2OCX8eoDNKPwjXWWKTt9cL5RsblH1ucv1xDpZKBIIaLZ2/Om8E7lYuIbslTuo
         9hqDEYzy9uNPLmAm2CRQWW0MDQ16t8ZmNP8imSjv3caMsrd4658JYnUn5YARPThkuNTT
         ZrY54xUo5K1ONUaU2VJ8lUUR78ECoyt5Pkf9Nut2r01Na96dVSIkmTKzH1fegnNWFp7l
         iEAnZ8w5Tgp/3ii28QZHkrl6onzdQtuWLKfIvTDCetk4myoADS1SgDxBX8cRVvtLjlIt
         QDUpFf0/wsYmuCoEd9BIeI9+vXfHL23A2no9/4ZULuNjs9IWYVU37GtUPEZTWcCBp5tA
         3cvg==
X-Gm-Message-State: AO0yUKX9EnU73496E5S17/K3wy5iwck3blARNZd7K3MBpqBUmypWN7tY
	G4flxkYMyeQxZY0LBxq7k3teggwazReWiBgB5voy0A==
X-Google-Smtp-Source: AK7set9XHUeLlPkt1gJ12stZFbCMRTkQQ9HrB3LYSIhi3/ZaG+e0VMAG8RtOJDpNATWJTqwo2mfMUsx0Pw5ZKygJeZ8=
X-Received: by 2002:a1f:2693:0:b0:401:6440:787e with SMTP id
 m141-20020a1f2693000000b004016440787emr122162vkm.32.1676670630833; Fri, 17
 Feb 2023 13:50:30 -0800 (PST)
MIME-Version: 1.0
References: <CAJs=3_C+K0iumqYyKhphYLp=Qd7i6-Y6aDUgmYyY_rdnN1NAag@mail.gmail.com>
 <CAPR809uYp6vGvCk4ugWOjbmd13WTm8fRg0f2Mdq3pxj6=d1McQ@mail.gmail.com> <a9cbed84-330f-472e-0cd7-90c6623bb5b5@nvidia.com>
In-Reply-To: <a9cbed84-330f-472e-0cd7-90c6623bb5b5@nvidia.com>
From: Enrico Granata <egranata@google.com>
Date: Fri, 17 Feb 2023 14:50:19 -0700
Message-ID: <CAPR809u0DLwHgV5w5QhWj_a53OcreZP1Qxxcom_Vbwzg0jgsog@mail.gmail.com>
Subject: Re: Virtio-blk extended lifetime feature
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, Jahdiel Alvarez <jahdiel@google.com>, 
	virtualization <virtualization@lists.linux-foundation.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230217_135035_398603_6AA3AB4D 
X-CRM114-Status: GOOD (  29.24  )
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

On Wed, Jan 18, 2023 at 12:46 PM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 1/17/23 14:30, Enrico Granata wrote:
> > Hi,
> > I am going to add +Jahdiel Alvarez who is also looking into a similar
> > issue, and also I would like to hear thoughts of people who may have
> > worked with (embedded or otherwise) storage more recently than I have
> >
> > One thought that Jahdiel and myself were pondering is whether we need
> > "type_a" and "type_b" fields at all, or if there should simply be a
> > "wear estimate" field, which for eMMC, it could be max(typ_a, typ_b)
> > but it could generalize to any number of cell or other algorithm, as
> > long as it produces one unique estimate of wear
> >
> > Thanks,
> > - Enrico
> >
> > Thanks,
> > - Enrico
> >
> >
> > On Sun, Jan 15, 2023 at 12:56 AM Alvaro Karsz
> > <alvaro.karsz@solid-run.com> wrote:
> >>
> >> Hi guys,
> >>
> >> While trying to upstream the implementation of VIRTIO_BLK_F_LIFETIME
> >> feature, many developers suggested that this feature should be
> >> extended to include more cell types, since its current implementation
> >> in virtio spec is relevant for MMC and UFS devices only.
> >>
> >> The VIRTIO_BLK_F_LIFETIME defines the following fields:
> >>
> >> - pre_eol_info:  the percentage of reserved blocks that are consumed.
> >> - device_lifetime_est_typ_a: wear of SLC cells.
> >> - device_lifetime_est_typ_b: wear of MLC cells.
>
> For immediate comments :-
>
> It needs to cover all the flash cell types.
>
> Using names like type_a/type_b in the spec and in the implementation
> adds unnecessary confusion and requires extra documentation in the
> code that needs to be changed.

What do you think about my proposal to have a single "wear estimate"
field and allow each flash type to calculate it as required by its own
internal logic?
The migration for eMMC and existing drivers would be to expose the
maximum of type_A, type_B wear, but other cell types would be able to
provide whatever logic they need as long as it meaningfully exposes
the "wear"

>
> >>
> >> (https://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.html)
> >>
> >> Following Michael's suggestion, I'd like to add to the virtio spec
> >> with a new, extended lifetime command.
> >> Since I'm more familiar with embedded type storage devices, I'd like
> >> to ask you guys what fields you think should be included in the
> >> extended command.
> >>
> >> Thanks,
> >>
> >> Alvaro
>
> -ck

