Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A817DCD80D2
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Oct 2023 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GSJbo3Jf5hZpxJ7r2XgwmKjkjebO2fblXtzOAiGrInA=; b=4/RdtAuc3Klhr4mYeE2LPn1p3C
	pHrJ3rp+ly9wKL4JbV+GElRjBSAqQmMPiYhR9PFUVP41BQf9rbO+078cPsQvh95vwFnDpmtwBtW8z
	WCBdMHQnHUCNFIN4pnOIX++pLG9aSbXDbvy4CIsS2c3JMGdAd3HtLzH1EeqU9zerxY7fOYQJsDW0+
	t+IIsm3R4KVBDM/XCLNrv/u28gBvHXv0uW/9U2fLYXMk5+zeUKMI39zAKyIqbFNPQpXV99W91/Ha/
	Njsp8BQ08Wmgy6QRyltzv+CwLTjsxlBztjIafSYx79ttA+tHnXECL/BGz66Uxe3R0YdPwJM/fTU2a
	3BMWJzWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqCyL-00DTID-0y;
	Tue, 10 Oct 2023 13:40:29 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqCyJ-00DTFA-0c
	for linux-nvme@lists.infradead.org;
	Tue, 10 Oct 2023 13:40:28 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so55318175e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 10 Oct 2023 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696945220; x=1697550020; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSJbo3Jf5hZpxJ7r2XgwmKjkjebO2fblXtzOAiGrInA=;
        b=OhMz51Cl49bLkKYmFn6YUjvQDk+ObzwnY9EL2nbtOoy2i2khgIUmqj3nCeiBO40VY4
         WJKhWqop85/RSYQl3P/WfSfrid/HUX3RTnrW2RcBI3Vy56n2P9WLR2/mE5nw9Fkq4V/W
         Xu6F1enUIPYYu+zL0gxQXYfCZsgSb3VUQApPj1tKjYlw15t/7guc/6g7zWoyUvPsV+56
         o4Kyf7atOtC0JQ8s3x8khRWyfqN5hCX5hmZ90VVuzNcgtfpJL/hVTAoFzKSrA+2QnxWO
         2PF0TKWq/9ij0g4iPFMGomeF5ijtUWw1dAi8k4MI4VM/ju343hcdlph0U8zhlf2RiOOB
         O2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696945220; x=1697550020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSJbo3Jf5hZpxJ7r2XgwmKjkjebO2fblXtzOAiGrInA=;
        b=AQn7IeOZKeDcxVgi0HaN2C4fMzvOLVBTAtz0MA9EBQCzIwMEPjL6tyaIBgrALV02Mv
         kRfbHdXrenzPm/Wbk9YoKMeubbYEDxUJ529TljHJXzQGcAfWc2sxXCtSiq/6B/D1Lxhb
         m5WZnRbxz6gMKsRW1aWQmVjHySxYWhfrSjUp8nWvjR2N2W5OT2OWeyEiwsXwa1G/qeSb
         cpWK7pFayZRh1xWeOqxz0TvXv6ZJN6u8JGe7Iyj95s1oM2Naai6ONYcB3fNDYpP2Q+66
         UCeaoBrXW5sNngqTh7LI7W4N7bNMQ/NMw28lgp4F/lQ1s4LvSTyuGsKwx1SotyTTYmM6
         aafQ==
X-Gm-Message-State: AOJu0YzBkDDkwF7s6lrTio1qbBuZcSJ6exWOU++yK6CYlfPznf/Crorp
	W7ymQHCFOHEGoP3RVhDlJw0KsYYtC05hFhAUiAA=
X-Google-Smtp-Source: AGHT+IGi5n6OERa2jdoJ3ZdK+ZIz/qqkok2mJgSmiCxtpGoqBx+LuSJ952TEZsfla+16VVx7oqEvj+cGQuTqd1ynqVM=
X-Received: by 2002:a05:600c:1c10:b0:407:5adc:4497 with SMTP id
 j16-20020a05600c1c1000b004075adc4497mr711914wms.9.1696945220216; Tue, 10 Oct
 2023 06:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com>
 <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de>
In-Reply-To: <20231010074634.GA6514@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 10 Oct 2023 19:09:54 +0530
Message-ID: <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, axboe@kernel.dk, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org, vincentfu@gmail.com, 
	ankit.kumar@samsung.com, cpgs@samsung.com, stable@vger.kernel.org, 
	Vincent Fu <vincent.fu@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_064027_228974_9DF1C047 
X-CRM114-Status: GOOD (  34.81  )
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

On Tue, Oct 10, 2023 at 1:16=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Fri, Oct 06, 2023 at 07:17:06PM +0530, Kanchan Joshi wrote:
> > Same issue is possible for extended-lba case also. When user specifies =
a
> > short unaligned buffer, the kernel makes a copy and uses that for DMA.
>
> I fail to understand the extent LBA case, and also from looking at the
> code mixing it up with validation of the metadata_len seems very
> confusion.  Can you try to clearly explain it and maybe split it into a
> separate patch?

The case is for the single interleaved buffer with both data and
metadata. When the driver sends this buffer to blk_rq_map_user_iov(),
it may make a copy of it.
This kernel buffer will be used for DMA rather than user buffer. If
the user-buffer is short, the kernel buffer is also short.

Does this explanation help?
I can move the part to a separate patch.

> > Fixes: 456cba386e94 ("nvme: wire-up uring-cmd support for io-passthru o=
n char-device")
>
> Is this really io_uring specific?  I think we also had the same issue
> before and this should go back to adding metadata support to the
> general passthrough ioctl?

Yes, not io_uring specific.
Just that I was not sure on (i) whether to go back that far in
history, and (ii) what patch to tag.

> > +static inline bool nvme_nlb_in_cdw12(u8 opcode)
> > +{
> > +     switch (opcode) {
> > +     case nvme_cmd_read:
> > +     case nvme_cmd_write:
> > +     case nvme_cmd_compare:
> > +     case nvme_cmd_zone_append:
> > +             return true;
> > +     }
> > +     return false;
> > +}
>
> Nitpick: I find it nicer to read to have a switch that catches
> everything with a default statement instead of falling out of it
> for checks like this.  It's not making any different in practice
> but just reads a little nicer.

Sure, I can change it.

> > +     /* Exclude commands that do not have nlb in cdw12 */
> > +     if (!nvme_nlb_in_cdw12(c->common.opcode))
> > +             return true;
>
> So we can still get exactly the same corruption for all commands that
> are not known?  That's not a very safe way to deal with the issue..

Given the way things are in NVMe, I do not find a better way.
Maybe another day for commands that do (or can do) things very
differently for nlb and PI representation.

> > +     control =3D upper_16_bits(le32_to_cpu(c->common.cdw12));
> > +     /* Exclude when meta transfer from/to host is not done */
> > +     if (control & NVME_RW_PRINFO_PRACT && ns->ms =3D=3D ns->pi_size)
> > +             return true;
> > +
> > +     nlb =3D lower_16_bits(le32_to_cpu(c->common.cdw12));
>
> I'd use the rw field of the union and the typed control and length
> fields to clean this up a bit.
>
> >       if (bdev && meta_buffer && meta_len) {
> > +             if (!nvme_validate_passthru_meta(ns, nvme_req(req)->cmd,
> > +                                     meta_len, bufflen)) {
> > +                     ret =3D -EINVAL;
> > +                     goto out_unmap;
> > +             }
> > +
> >               meta =3D nvme_add_user_metadata(req, meta_buffer, meta_le=
n,
>
> I'd move the check into nvme_add_user_metadata to keep it out of the
> hot path.
>
> FYI: here is what I'd do for the external metadata only case:

Since you have improvised comments too, I may just use this for the
next iteration.

