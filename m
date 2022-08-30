Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47730ECAAD5
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 20:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=quPrc0QIsuz1NKdESYuLftRz7jRQA9QoPFRh/8Iokok=; b=4KB0Oh6Rk3iGTsIEBl+IM7/YkK
	BRiz9EYwWLGKiqSaCD3mu4/SKcRF20PwhyfI3y2sBYkBDC51JiR/qlXFkwg1wRjI1r40pqST9W8/e
	f9g1lrSFB8i4mtxFwO4Xa+OTihaihqsGPflm94kTOgti/iJ2yM6+OypFrZ1zu67t7A97tp9ie3+Mw
	kMSj1ACN9IquuyYUaeIT0qn3BL8ANI/+iqwem1Iwibz09SvdygL0xKlfvzoGy+lvakW936VVrsXEu
	cuZLe4ZkO7jokmW+fLAtnckjniX8YCIQtTCTZPm+gycDl/8d5dNCLeUdFFHRHB73CraAxWzsl6gtS
	7FuIpcUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT7Vn-001gk6-If; Tue, 30 Aug 2022 20:07:03 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT7Vk-001ggF-Sq
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 20:07:02 +0000
Received: by mail-wr1-x434.google.com with SMTP id k9so15684360wri.0
        for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 13:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=quPrc0QIsuz1NKdESYuLftRz7jRQA9QoPFRh/8Iokok=;
        b=ItJACpqJn+un8MmB1oaVNotCCyq8RQ4xPF6dBt1VRVv0ETdWFC95NwxR2LcTv7r2S6
         GAoZ0BBJ/vPjFKGZeVrjUpP1BrgZrMpVTG/ne7Uux2JpIM3WqT/Cc4yMBwAEMpkWEKhd
         eyKuPLiN9QzvlGqpSw58vEuFRgOks9L623kAbAOHLpV4Sq8Vkkw8tNCFv1RKmQoA6+B3
         tTdlCipGfI5WXXXKiOWEVyvE5Oxy2AeMRqMtiy49/iSLivwtRGkEAn8v/qcH1uCchz3v
         ra9HsSkGrzYJyzjh7S6Xu6/MRblZymR7SpfnnDOHu5/FViVYH6Ye+Yj6/IAnUprh01DQ
         kFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=quPrc0QIsuz1NKdESYuLftRz7jRQA9QoPFRh/8Iokok=;
        b=PlkcHCfeTUfN5/av9VqNIFpvwSV75nxEeZoMC9zzmlmxJY7IUQDj/hh/Wndb4Q3V7c
         govCrJi06hbn7Pu2Li+3BH/qeK8QwCsP21CqYiBaFfxjEjyGnfzTqQfg4ICl17o3+Z6F
         DZm3+8icICHOluml9//SnqmitGlKU5n6nq9PmYcMCiVfcAnE3mJ5svlsxQ7iY76BMZOd
         wocSekEHlcKnHkouxbyHvnRnSanNoqPhEQR58oGxeIn2QPdPXLWZyn7UZr0xtm1gndpn
         kh9pmYoGuBhD6fOxIAjVk4GUGs/kKb7n4jR+Db2tl7MclxnhXd7SXXBJW4wOKKMWT6NS
         j+rg==
X-Gm-Message-State: ACgBeo1U7VbKbt0LKNSjuVrfIiGKywYyt3TVRnIysAGgOslX7Ntx9jWu
	U2K9TTHU9UbpcCGhMW9RdDI=
X-Google-Smtp-Source: AA6agR5HLvAHkx1e6748LuYIDVeH3GMrvVPWnUmBdS/sV+yDv3vrCIxtQ/50OS4HDxutgYtDsL3NmA==
X-Received: by 2002:a5d:4d12:0:b0:226:d878:e096 with SMTP id z18-20020a5d4d12000000b00226d878e096mr7374164wrt.377.1661890017093;
        Tue, 30 Aug 2022 13:06:57 -0700 (PDT)
Received: from opensuse.localnet (host-87-1-103-238.retail.telecomitalia.it. [87.1.103.238])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d4108000000b0021eed2414c9sm10405186wrp.40.2022.08.30.13.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 13:06:55 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>, James Smart <james.smart@broadcom.com>, Ira Weiny <ira.weiny@intel.com>, "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 1/1] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date: Tue, 30 Aug 2022 22:06:54 +0200
Message-ID: <1924196.usQuhbGJ8B@opensuse>
In-Reply-To: <Ywkf3NJQ7/8SSV+e@ZenIV>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com> <2887364.VdNmn5OnKV@opensuse> <Ywkf3NJQ7/8SSV+e@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_130700_950670_BE7A514F 
X-CRM114-Status: GOOD (  29.89  )
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

On venerd=C3=AC 26 agosto 2022 21:32:44 CEST Al Viro wrote:
> On Fri, Aug 26, 2022 at 08:16:59PM +0200, Fabio M. De Francesco wrote:
> > As you may have already read, I'm so new to kernel development that I=20
still
> > know very little about many subsystems and drivers. I am not currently
> > able to tell the difference between BVEC and KVEC. I could probably try=
 to
> > switch from one to the other (after learning from other code), however I
> > won't be able to explain in the commit message why users should better =
use
> > BVEC in this case.
>=20
> struct kvec: pairs of form <kernel address, length>
> struct bio_vec: triples of form <page, offset, length>
>=20
> Either is a way to refer to a chunk of memory; the former obviously has it
> already mapped (you don't get kernel addresses otherwise), the latter=20
doesn't
> need to.
>=20
> iov_iter instances might be backed by different things, including
> arrays of kvec (iov_iter_kvec() constructs such) and arrays of
> bio_vec (iov_iter_bvec() is the constructor for those).
>=20
> iov_iter primitives (copy_to_iter/copy_from_iter/copy_page_to_iter/etc.)
> work with either variant - they look at the flavour and act accordingly.
>=20
> ITER_BVEC ones tend to do that kmap_local_page() + copy + kunmap_local().
> ITER_KVEC obviously use memcpy() for copying and that's it.
>=20
> If you need e.g. to send some subranges of some pages you could kmap them,
> form kvec array, make msg.msg_iter a KVEC-backed iterator over those and
> feed it to sendmsg().  Or you could take a bio_vec array instead, make
> msg.msg_iter a BVEC-backed iterator over that and feed to sendmsg().
>=20
> The difference is, in the latter case kmap_local() will be done on demand
> *inside* ->sendmsg() instance, when it gets around to copying some data
> from the source and calls something like csum_and_copy_from_iter() or
> whichever primitive it chooses to use.
>=20
> Why bother with mapping the damn thing in the caller and having it pinned
> all along whatever ->sendmsg() you end up calling?  Just give it
> page/offset/length instead of address/length and let lib/iov_iter.c
> do the right thing...

Hi Al,

Thanks so much for the time you spent writing this detailed explanation. I=
=20
really appreciated that you spend time for teaching newcomers with kindness=
=20
and patience.

I apologize for this late response, but for the past few days I've been out=
 of=20
city with no PC to email the lists (therefore, the lists would have rejecte=
d=20
my messages from phone with a Gmail app).

Yesterday I saw that Sagi sent an reworked version of my patch according to=
=20
your suggestions. This evening I will send it again as a patch v4 and with =
the=20
cover letter it had in the previous version.

You will be acknowledged with a "Suggested by" tag. Instead Sagi with a "Co-
developed-by" and, of course, with a "Signed-off-by" immediately after the=
=20
previous tag. There will be more information after the three dashes.=20

Again thanks,

=46abio




