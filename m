Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4C7C64EC4
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Mar 2023 16:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FrWT0Uw+FmkZpoCNK5xclsdtV6ORVe/QF51P6fxoy6I=; b=mmxKOjjvmwi4lGnhSAPad9y/Wi
	eVuXjNd4Q95FaXnlyl2CUPBkEDuqUQKn1zfqdf9DwWG181NYg+NDTEulp0F2ZA0IT3mv9pzKb7xGR
	++WhOu0xxV5ZfPNeq8KWdODfjVyuQXgNjuUSTlqChdC2QCg6+NKA9tVLm+7AsxaddkMiKbXGiC9LO
	or+jWWItYTkkbduAzxNRL+IZbe47iK07y+1oqgf7LZ+CRIIBNw/gbF5xf4Nslrt5c4OwjSmtrLcQP
	E+ZarPc2pFIWXhW8rIdIl/vqKQ/2chl4YI6sK6iJqJ3Lewl31CKYzO2ZLTt655vqhGXYTxaq2a/E4
	3xMhbTDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY8DO-006o7W-Tk; Fri, 03 Mar 2023 16:25:02 +0000
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY8DL-006o6R-OE
	for linux-nvme@lists.infradead.org; Fri, 03 Mar 2023 16:25:01 +0000
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-536bbe5f888so51917937b3.8
        for <linux-nvme@lists.infradead.org>; Fri, 03 Mar 2023 08:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677860694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrWT0Uw+FmkZpoCNK5xclsdtV6ORVe/QF51P6fxoy6I=;
        b=AKX5M2ADiE0XRCcF0QqIDnn7/xUSgfvWFXCSysEpwreGqhYkMScsokJIqensG60TIW
         NPsBDuIpB6g1mJmgdUem0u/dLdniXYn4sEUhOvtcJ8AikZbPMx0lNVgwkIIEw0PmaDIi
         5ZrmRSGEMbUizmMd4v2MFUtdP7NezcjlPymhufL8esz/kXu0GRcBw7mVx+Gn1WmDQeGo
         4rILke1wk3UPjlvAS/Mwobx5/sl2Rf2JX7YKs2EDKFiC0jaEsM8wTft7FFPSbSIKr6T2
         689Gf54yuQeDMJUOKuDwIYF/clFO1tX8b0vuLtN8L2JMsv8nxibouiqiP19p5/8dxk9M
         1tlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677860694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrWT0Uw+FmkZpoCNK5xclsdtV6ORVe/QF51P6fxoy6I=;
        b=ek15xNo5LzsoY0NY7h9BoBhoyhSYkpSflMMSkfD3u10XzSBlz2/cy7yTWRmQARCjU3
         2gnWYNdALX7rHhZDtQfL1xAQhlaHZlCBsMMphaUwSA3hww7uaBwsg2EREDTnY7yI/JRw
         3V1XNg7oUJxGWcHTcOrZ6uDTUE8kmvpXe42WdCddBHMAAziPle+7rf+FVHGHeEtrcNR4
         0Dpm9MDnTCMrbHb0Sistgvn7X+imZodnAu7KhDuAq0KQNQsidZmjpnfv5QB8W1SzDON/
         QZxAQJ3lHXGaWz1FXCHPC4PnwmbTevmfff6Ko/uN4+mjmm5wRM0TR4BI9au/MY75nAnN
         2LgA==
X-Gm-Message-State: AO0yUKWwSSge3Dz+U4ZBsKo0bOB2nGHukroPCULojebyIdEj61/4+R6y
	Jg4O2jhZ+adKy2rsl3w/TQb/zWm47xt+VTBbv7Q=
X-Google-Smtp-Source: AK7set++cGh53sL4B78QHoSD7Y+S1sNtTp+FFwFB55qUIU05r/eLmxDVznFkSmq/IML+/ZUDtRwnq04tuN+SHyvCh88=
X-Received: by 2002:a81:b61a:0:b0:52e:cea7:f6e3 with SMTP id
 u26-20020a81b61a000000b0052ecea7f6e3mr1285093ywh.10.1677860694320; Fri, 03
 Mar 2023 08:24:54 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR21MB1688B4BBFCCCD01C016A62D4D7DF9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <CAPsT6hnbAA_uCiVjST8VaPgb6TyfBq9nO2S7OPqJX3=YhzBD9g@mail.gmail.com>
 <BYAPR21MB16882541DC2DA7AB91E58A03D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y+psCbPTfF9JkW2c@kbusch-mbp> <CAPsT6hkYqg2N6_Xf5aL2ijydTJfPYemUVKPZFGgdAik=DwTygQ@mail.gmail.com>
 <BYAPR21MB16887CE0FC5AFD717C741524D7A19@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16887CE0FC5AFD717C741524D7A19@BYAPR21MB1688.namprd21.prod.outlook.com>
From: Daniel Gomez <dagmcr@gmail.com>
Date: Fri, 3 Mar 2023 17:24:43 +0100
Message-ID: <CAPsT6h=HpDjgE42KRPk8SHHVQ9yPTVBpbGrxd1C9nPN=jWoqUA@mail.gmail.com>
Subject: Re: max_hw_sectors error caused by recent NVMe driver commit
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Gerd Bayer <gbayer@linux.ibm.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230303_082459_830845_CEE30C96 
X-CRM114-Status: GOOD (  31.46  )
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

Hi,

On Fri, Feb 17, 2023 at 5:05=E2=80=AFPM Michael Kelley (LINUX)
<mikelley@microsoft.com> wrote:
>
> From: Daniel Gomez <dagmcr@gmail.com> Sent: Friday, February 17, 2023 5:2=
8 AM
> >
> > >> value to be set.  In your example, I would guess the value of 512 Kb=
ytes came
> > >> from querying the NVMe device for its max transfer size. Ideally, to=
 support
> > >> 512 Kbyte transfers, you would want 129 segments (to allow for start=
ing in
> > >> the middle of a page as describe above).  But the value of max_segme=
nts
> > >> is limited by the NVME driver itself using the value of NVME_MAX_SEG=
S
> > >> defined in drivers/nvme/host/pci.c.  The value of 127 is chosen to m=
ake
> > >> sure that the data structure containing the scatterlist fits in a si=
ngle page.
> >
> > >
> > > Should be 128 possible segements now in -next, but yeah, 129 would be=
 ideal.
> >
> > Quoting Michael,
> >
> > >> the middle of a page as describe above).  But the value of max_segme=
nts
> > >> is limited by the NVME driver itself using the value of NVME_MAX_SEG=
S
> > >> defined in drivers/nvme/host/pci.c.  The value of 127 is chosen to m=
ake
> > >> sure that the data structure containing the scatterlist fits in a si=
ngle page.
> >
> > Yes, I can see that. I guess the 129 needs to be reduced to 127 (or
> > after Keith optimization patch to 128) but not when the device is
> > limited to a lower max_segments value because they fit anyway in a
> > single page?
>
> Yes, that's correct.   But "the device is limited to a lower max_segments
> value" isn't really because max_segments is limited.  The limit is on
> max_hw_sectors_kb derived from the NVMe controller MDTS value,
> as you have shown in your table below.  Then the max_segments value
> is derived from max_hw_sectors_kb.  For example, if max_hw_sectors_kb
> is 128 Kbytes, you can never need more than 33 segments.  Each segment
> can describe 4 Kbytes (a page), so with 128 Kbytes you get 32 segments.
> Then add 1 segment to handle the case where the memory buffer doesn't
> start on a page boundary, and you get 33.

I'm trying to understand and clarify this part. So, I found Keith's
patch [1] where he addresses (and introduces) the same case (quote
from the patch: 'One additional segment is added to account for a
transfer that may start in the middle of a page.'). But I'm not sure
when that case should be considered when we split an I/O. Is that
handled in bio_split_rw + bvec_split_segs functions?

So, for mdts=3D7 and max_segments being now 128, when can we see and
test that a transfer starts in the middle of a page and therefore,
that we need an extra segment for that? In that case, shouldn't the
split max at 128 - 1 (508 KiB)?

In my tests [2], I can see splits are made in chunks of 128 in some
cases. Whether or not these cases are page-aligned I don=E2=80=99t know but
I'd like to verify that.

[1] https://lore.kernel.org/all/1439417874-8925-1-git-send-email-keith.busc=
h@intel.com/

[2] while true; do sleep 1; dd iflag=3Ddirect if=3D/dev/nvme0n1 bs=3D1M
count=3D1 of=3D/dev/null status=3Dprogress; done

On Fri, Feb 17, 2023 at 5:05=E2=80=AFPM Michael Kelley (LINUX)
<mikelley@microsoft.com> wrote:
>
> From: Daniel Gomez <dagmcr@gmail.com> Sent: Friday, February 17, 2023 5:2=
8 AM
> >
> > >> value to be set.  In your example, I would guess the value of 512 Kb=
ytes came
> > >> from querying the NVMe device for its max transfer size. Ideally, to=
 support
> > >> 512 Kbyte transfers, you would want 129 segments (to allow for start=
ing in
> > >> the middle of a page as describe above).  But the value of max_segme=
nts
> > >> is limited by the NVME driver itself using the value of NVME_MAX_SEG=
S
> > >> defined in drivers/nvme/host/pci.c.  The value of 127 is chosen to m=
ake
> > >> sure that the data structure containing the scatterlist fits in a si=
ngle page.
> >
> > >
> > > Should be 128 possible segements now in -next, but yeah, 129 would be=
 ideal.
> >
> > Quoting Michael,
> >
> > >> the middle of a page as describe above).  But the value of max_segme=
nts
> > >> is limited by the NVME driver itself using the value of NVME_MAX_SEG=
S
> > >> defined in drivers/nvme/host/pci.c.  The value of 127 is chosen to m=
ake
> > >> sure that the data structure containing the scatterlist fits in a si=
ngle page.
> >
> > Yes, I can see that. I guess the 129 needs to be reduced to 127 (or
> > after Keith optimization patch to 128) but not when the device is
> > limited to a lower max_segments value because they fit anyway in a
> > single page?
>
> Yes, that's correct.   But "the device is limited to a lower max_segments
> value" isn't really because max_segments is limited.  The limit is on
> max_hw_sectors_kb derived from the NVMe controller MDTS value,
> as you have shown in your table below.  Then the max_segments value
> is derived from max_hw_sectors_kb.  For example, if max_hw_sectors_kb
> is 128 Kbytes, you can never need more than 33 segments.  Each segment
> can describe 4 Kbytes (a page), so with 128 Kbytes you get 32 segments.
> Then add 1 segment to handle the case where the memory buffer doesn't
> start on a page boundary, and you get 33.   I'm making a subtle distincti=
on
> here between "max_segments is limited" and "you can't need more than
> XX segments for a given max_hw_sectors_kb value".
>
> Michael
>
> >
> > Following the kernel code, I can see the max_hw_sectors_kb is
> > calculated using max_hw_sectors =3D 2 ^ (MDTS + page_shift - 9),
> > max_hw_sectors_kb is just max_hw_sectors >> 1, and max_segments is 2 ^
> > (MDTS) + 1 (simplified). Using QEMU (NVMe emulation) to be able to
> > change the MDTS, I get the following:
> >
> >   MDTS   max_hw_sectors   max_hw_sectors_kb   max_segments
> >  ------ ---------------- ------------------- --------------
> >   0      1024             512                 127
> >   1      16               8                   3
> >   2      32               16                  5
> >   3      64               32                  9
> >   4      128              64                  17
> >   5      256              128                 33
> >   6      512              256                 65
> >   7      1024             512                 127
> >
> > >
> > > The limit confuses many because sometimes user space can sometimes ge=
t 512kib
> > > IO to work and other times the same program fails, and all because of=
 physical
> > > memory continuity that user space isn't always aware of. A sure-fire =
way to
> > > never hit that limit is to allocate hugepages.

