Return-Path: <SRS0=7/ZJ=QG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3432C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 10:48:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9178661221
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 10:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9178661221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tk68xSaHdAppwyG5+67yI7OUPgx+CCb94LsMtgQhev0=; b=sZkFXZVVhbwT5wlke8oQL2yqh0
	msh6WeT0sKHxkutczB/NsFaJY+RIiw4xHlbBVKP1vgjxTwOIVk4RhGo4cxbvZ3bQxABsZ/6QfceYa
	+yNbb7rsuEmXVfU+/HssjrzwWAKvg7XDQgngmHw1x4LsH+/FIO3LVojeQ6o/pSWl6WpXXJ4eDP8zj
	Hg3joVCGGWQpmEN4s1/qltSjz5P2Lb6VtCDWol53F6pqlY7WwfSAGWgc/cnRrQD76bEk8veJn7V4M
	eD3SQ2ot2R2gWLhCyvH66uNstV9r8uhF4ZNmmObdVAPDzBvc8etAw3Klv5vYr1HoXhXsY5eWczp9D
	RkKgtV8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mo1RP-00AART-Jj; Fri, 19 Nov 2021 10:48:23 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mo1RM-00AAQ6-5L
 for linux-nvme@lists.infradead.org; Fri, 19 Nov 2021 10:48:21 +0000
Received: by mail-wr1-x432.google.com with SMTP id b12so17393543wrh.4
 for <linux-nvme@lists.infradead.org>; Fri, 19 Nov 2021 02:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Tk68xSaHdAppwyG5+67yI7OUPgx+CCb94LsMtgQhev0=;
 b=XDVSvoTT96zb1q7CFaPGEvknaz1XybsElxkVvAWHDwIlm8/9eM7bVQoNGgMuyFTvJ6
 cayUngAYzb0fjzEJ9QBp48OhLSE7gsup8K7+ksxJwubkZf0pct/X/Nw0o9Sxp1U0+j2+
 EHjy32Gum7+k614b6trYMNs6DArCIixYEdOZkok3QZ3jUModL6wzEUyj3CwHuANJbWOt
 JO4jwGIFl6RDjj+XsfqzLq5zJTTIL21b36qH6tnGr2Y3vVd8BEtPzpMY5HzsUSP56VQg
 UVVP+Mk5onza0Xhn9pOJC47F6RG2Z7xLyM8hcX1a1yn+K14RQGC/OdNqA3H1gIFikf/i
 QDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Tk68xSaHdAppwyG5+67yI7OUPgx+CCb94LsMtgQhev0=;
 b=3ewGL5SW/svsMBCLwZ/hr4K4CZW5vMV+z6GbzRc6oMd5JndxtauJdrmWD5yOHPi+sP
 ttBsFexTRbXhRFoCwDlHYaPGekoLBNy5WJaqJdYelfWG01RHFDU2VR5kX+PGy0Kdu2ne
 N3Zlb9OAojXF+RQ2okmR5/C/bPaI2r1XAPjRLHu8B6qjInhk1+O9Vh7H0b89PtxjZGdN
 /0TawY6PRNti2AHeyY+sUin3oY2e/8IXYPg9keAXYHm/e0MJeUB6a7vPJNim0klsD59J
 2Li7ywQXhj1ZalBPhz0IzjgNTIV60fSprG/gDDPT0dmrL59TJCNLsuOusTOPdPhhclPO
 3yXg==
X-Gm-Message-State: AOAM532VggMZJCdlz+uC3COm2Fl0Z/yOjLv+eZNhWFUGn/f5dYi4mH3l
 EMi/xUbeisbYCAB3fgvZa+Acj41LtcuNHuNkPpPHS1pvNiDfzQ==
X-Google-Smtp-Source: ABdhPJyZpbfCDp3ybadK8EsoHtiSMUx4mYJsHOy0WefCsz5FmU+0JuPuNZdF1iPi34jUiQIoV2beE2pjsGiQLxcgQM0=
X-Received: by 2002:adf:dc52:: with SMTP id m18mr6455876wrj.216.1637318897846; 
 Fri, 19 Nov 2021 02:48:17 -0800 (PST)
MIME-Version: 1.0
References: <PH0PR04MB74161CD0BD15882BBD8838AB9B529@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CGME20210928191342eucas1p23448dcd51b23495fa67cdc017e77435c@eucas1p2.samsung.com>
 <20210928191340.dcoj7qrclpudtjbo@mpHalley.domain_not_set.invalid>
 <c2d0dff9-ad6d-c32b-f439-00b7ee955d69@acm.org>
 <20211006100523.7xrr3qpwtby3bw3a@mpHalley.domain_not_set.invalid>
 <fbe69cc0-36ea-c096-d247-f201bad979f4@acm.org>
 <20211008064925.oyjxbmngghr2yovr@mpHalley.local>
 <2a65e231-11dd-d5cc-c330-90314f6a8eae@nvidia.com>
 <20211029081447.ativv64dofpqq22m@ArmHalley.local>
 <20211103192700.clqzvvillfnml2nu@mpHalley-2>
 <20211116134324.hbs3tp5proxootd7@ArmHalley.localdomain>
In-Reply-To: <20211116134324.hbs3tp5proxootd7@ArmHalley.localdomain>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 19 Nov 2021 16:17:51 +0530
Message-ID: <CA+1E3rJRT+89OCyqRtb5BFbez0BfkKvCGijd=nObMEB3_v6MyA@mail.gmail.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
To: =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, 
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
 "dm-devel@redhat.com" <dm-devel@redhat.com>, 
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, 
 "msnitzer@redhat.com" <msnitzer@redhat.com>, 
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>, 
 "roland@purestorage.com" <roland@purestorage.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>, 
 "hare@suse.de" <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>, 
 "rwheeler@redhat.com" <rwheeler@redhat.com>, "hch@lst.de" <hch@lst.de>, 
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, 
 "osandov@fb.com" <osandov@fb.com>, Adam Manzanares <a.manzanares@samsung.com>, 
 SelvaKumar S <selvakuma.s1@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Vincent Fu <vincent.fu@samsung.com>, 
 Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211119_024820_229954_B964AEE0 
X-CRM114-Status: GOOD (  33.85  )
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

Given the multitude of things accumulated on this topic, Martin
suggested to have a table/matrix.
Some of those should go in the initial patchset, and the remaining are
to be staged for subsequent work.
Here is the attempt to split the stuff into two buckets. Please change
if something needs to be changed below.

1. Driver
*********
Initial: NVMe Copy command (single NS)
Subsequent: Multi NS copy, XCopy/Token-based Copy

2. Block layer
**************
Initial:
- Block-generic copy (REQ_OP_COPY), with interface accommodating two block-=
devs
- Emulation, when offload is natively absent
- DM support (at least dm-linear)

3. User-interface
*****************
Initial: new ioctl or io_uring opcode

4. In-kernel user
******************
Initial: at least one user
- dm-kcopyd user (e.g. dm-clone), or FS requiring GC (F2FS/Btrfs)

Subsequent:
- copy_file_range

Thanks,
On Tue, Nov 16, 2021 at 7:15 PM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
>
> Hi all,
>
> Thanks for attending the call on Copy Offload yesterday. Here you have
> the meeting notes and 2 specific actions before we proceed with another
> version of the patchset.
>
> We will work on a version of the use-case matrix internally and reply
> here in the next couple of days.
>
> Please, add to the notes and the matrix as you see fit.
>
> Thanks,
> Javier
>
> ----
>
> ATTENDEES
>
> - Adam
> - Arnav
> - Chaitanya
> - Himashu
> - Johannes
> - Kanchan
> - Keith
> - Martin
> - Mikulas
> - Niklas
> - Nitesh
> - Selva
> - Vincent
> - Bart
>
> NOTES
>
> - MD and DM are hard requirements
>         - We need support for all the main users of the block layer
>         - Same problem with crypto and integrity
> - Martin would be OK with separating Simple Copy in ZNS and Copy Offload
> - Why did Mikulas work not get upstream?
>         - Timing was an issue
>                 - Use-case was about copying data across VMs
>                 - No HW vendor support
>                 - Hard from a protocol perspective
>                         - At that point, SCSI was still adding support in=
 the spec
>                         - MSFT could not implement extended copy command =
in the target (destination) device.
>                                 - This is what triggered the token-based =
implementation
>                                 - This triggered array vendors to impleme=
nt support for copy offload as token-based. This allows mixing with normal =
read / write workloads
>                         - Martin lost the implementation and dropped it
>
> DIRECTION
>
> - Keeping the IOCTL interface is an option. It might make sense to move f=
rom IOCTL to io_uring opcode
> - Martin is happy to do the SCSIpart if the block layer API is upstreamed
> - Token-based implementationis the norm. This allows mixing normal read /=
 write workloads to avoid DoS
>         - This is the direction as opposed to the extended copy command
>         - It addresses problems when integrating with DM and simplifies c=
ommand multiplexing a single bio into many
>         - It simplifies multiple bios
>         - We should explore Mikulas approach with pointers.
> - Use-cases
>         - ZNS GC
>         - dm-kcopyd
>         - file system GC
>         - fabrics offload to the storage node
>         - copy_file_range
> - It is OK to implement support incrementally, but the interface needs to=
 support all customers of the block layer
>         - OK to not support specific DMs (e.g., RAID5)
>         - We should support DM and MD as a framework and the personalitie=
s that are needed. Inspiration in integrity
>                 - dm-linear
>                 - dm-crypt and dm-verify are needed for F2FSuse-case in A=
ndrod
>                         - Here, we need copy emulation to support encrypt=
ion without dealing with HW issues and garbage
> - User-interface can wait and be carried out on the side
> - Maybe it makes sense to start with internal users
>         - copy_file_range
>         - F2FS GC, btrfs GC
> - User-space should be allowed to do anything and kernel-space can chop t=
he command accordingly
> - We need to define the heuristics of the sizes
> - User-space should only work on block devices (no other constructs that =
are protocol-specific) . Export capabilities in sysfs
>         - Need copy domains to be exposed in sysfs
>         - We need to start with bdev to bdev in block layer
>         - Not specific requirement on multi-namespace in NVMe, but it sho=
uld be extendable
>         - Plumbing will support all use-cases
> - Try to start with one in-kernel consumer
> - Emulation is a must
>         - Needed for failed I/Os
>         - Expose capabilities so that users can decide
> - We can get help from btrfs and F2FS folks
> - The use case for GC and for copy are different. We might have to reflec=
t this in the interface, but the internal plumbing should allow both paths =
to be maintained as a single one.
>
> ACTIONS
>
> - [ ] Make a list of use-cases that we want to support in each specificat=
ion and pick 1-2 examples for MD, DM. Make sure that the interfaces support=
 this
> - [ ] Vendors: Ask internally what is the recommended size for copy, if
>    any
>


--=20
Joshi

