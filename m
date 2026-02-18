Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4261FE9A04A
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 04:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MbKBSejKyusQlf945oiHYtRQ1Vdoq/8Ld+w4pHyFIPs=; b=QrZnyXw33u4Uxbm+JqD7nfS6c+
	mbPxd7Ciq8mHBomHAtxINkgPAvNl4k7kQCmfPJ3sgQ8SZGJ8TWvdtIG7Z0FaomEF9+/ThiasDKcv8
	3kkwmwdonWNdxzKbgCB9z4w+EZhT1nP9d+PLpwY8rXByPIt72SWKeY9eSlkRQGTyoqWrAqbmdm5at
	LmNF/2AORXU5Fl0FVB8ChvfpoxPsEfi0YBH4RiQAPXg0tuJdPNH3Z0M+oq/I98+yeru2PhWPK0hpQ
	qikRSw8HeVCTBCUxuskrx9/yPMjuae/ZLzWwfl8o6SEj6Tnq8rfsgMp3JIkrOmicJvVBLZJ29znHb
	SyzCUzzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsYoB-00000009Fw1-45xC;
	Wed, 18 Feb 2026 04:05:03 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsYo9-00000009FvK-2KZP
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 04:05:02 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c6e2a8db928so1902614a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Feb 2026 20:05:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771387500; cv=none;
        d=google.com; s=arc-20240605;
        b=JlBrGh55M4K3whm2ngB2//R03GgbHa0YHqmK4VHG0v8gOUlg0waLE3lSW8Bn09Trjj
         ufdTpDfqLCuM64qy4LGRdW4O0NNOvisZMB7SCTgbzQQ8CY8dQUdk2qiYm0tysHazFvH2
         WSF5UvSLW7FhwxYAqYL2eVKlbt36elNvl77c4zM/AWOa5dhqfmDL6gzJgnRm98Q/HHCX
         j/wHsbXm3bosKTEHZlRMvwUCENWM5x1Fo+bsAFC21Jc2iRKV4L6AXPGu7bFkdXhNtqhF
         4dPUTzvW+G/Sw4iIeu/Dbh4/cl8KYPANeie0GiphFxuR4JfmNMhEr84faAzsazcgqaST
         dRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MbKBSejKyusQlf945oiHYtRQ1Vdoq/8Ld+w4pHyFIPs=;
        fh=ZjvzeaUq5rPMLz4ytZus2RrSz7uXIABk1QiWjo5WwMs=;
        b=ivSbyoX3zsBsXlHJdt8bU8G+sC0wBCoEVKDiVQtGzcuFCjvKomW1V8rMx5DQIDIDhN
         rt/c73+Jj6hQkD8JgjBkAqjGdceEBAatsoiwLcjF+nJ3Ili63TQnBHnUyzrwnHlph810
         CfjaAHssLzb57i3EZWCrCI7gJhnPbHBjBgkClWUfq13A57nz5mTwKBCAOsTnGlpkgeH0
         hh1Ly7nVH6484V0PgSqA3NKllrOPE4KVfBVNdneZkwngyQQJdpVvf7FWRwmcBFDt8j+/
         uLue0CyaToFY5FIc+t53GOi7te2JXCiYT/208o0vHXBxeUHM5HmsgUxJd1POhh4aYIWJ
         9q6g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771387500; x=1771992300; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbKBSejKyusQlf945oiHYtRQ1Vdoq/8Ld+w4pHyFIPs=;
        b=Qgev3/0w7C5g6Hs+o1SDx5pRlL3vFI37SK85IVEfN/PeO6+AnYH5jN+E10reKSlqUL
         VmK6PHA+BpsOl3V38U9nuWZglHP6CO6hdhybxuB1ePObLuFGDPh/xT+NUtMgva2wAXDQ
         BNAukjKPt8/mOJVUQ++W1YvjE/FFyj9Zl50yPGsYgD2iJ5Cvc38GVxmddKhGts0QZDmk
         oOx9InDPL8/IO1re1AwJV8jfYFhgWl0XAHLLJtj6LRZX7PXz5ddobCu8SIHBNA0QROIB
         YrZW7aF5PUt+UlI1dl0bwz7mosxvczwIsCDQGbPkj9Yy7F2yrWso+SZBHPvcoSWjk0QX
         kFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771387500; x=1771992300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MbKBSejKyusQlf945oiHYtRQ1Vdoq/8Ld+w4pHyFIPs=;
        b=CxSVZNTBPLTGU4OmayMS/jr6AiW33uAtm+PAjqMyhgcRMmMVFtknn36PXHEPDplAv0
         33zeVSnCbT0yesWf9dXyLVOFk85EUPq3jQGt2lov4m3WnV+qxUKEzD6ba57pheMl2BBX
         +p02D6yg4fmClSl0zCn24CoZ63GQeRy8UM7pNLdCbe0UsDrA4gUBPIGcA3OiHeydkXhz
         xc0O6MgL9VeDnUlRdtVFGKhFEFvcJDzFjBNK/RRgCFU6J9NwgRe5tmeAe59/Lob5hW1v
         +Reu7trT1FwHaSGk3DH6NnKfU7uzyemeitsQqtNR/okaM0UwZiaOLvlkDejKGalEf0Az
         BP9w==
X-Forwarded-Encrypted: i=1; AJvYcCVB3UrEhuly2SSmmxqKP3E6QCOCwIxlvbjgMtawfh71IHPLTBOIIXzpH7lbuZcTm/6ca2/S8Fdd8LcP@lists.infradead.org
X-Gm-Message-State: AOJu0YyOh259YQd3ZesYOmYTum/H5VooaJ7NXIz9r6hBstt0IQavou1p
	A6bXBksRKvVR/mAAXNhOMdS555kGeavz9jeMXbYMiMGuzNgp6YEOj4kCvD4JDtfnSg5sJB0QqH2
	iofr1bL5D7s2qpu6TyBYVQiVdvv+nbmw=
X-Gm-Gg: AZuq6aJqCZCdwtz7claJIsPIEVveLH1J0f/dmsaTX3qkkJJTYQtGfVOMtcMk6a8WcBr
	3GSBsTZp1zmWP6es3lmkif4/PfaS0OAVKVADmSpFI+CByBjn2ijFb5XzljgbWyBW+wGVObS1abR
	MU1OP/1UhW6dcd9OYQrq2uD6A4dNVopubKp0LFRwrac39KmcCrkpDI5TtW76r/Owrx8AakWjK0U
	dh2CFhBD3uzXAUbCtJz1NmV1irsDT8HlrOpzSZEvR7WYdHY5Qj4XlV06/9Ol85mSCARB+zfJAWd
	MKFQMMEag1BDNOw=
X-Received: by 2002:a17:903:22c7:b0:2a9:327f:ac56 with SMTP id
 d9443c01a7336-2ad17597de3mr137011565ad.55.1771387500087; Tue, 17 Feb 2026
 20:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20260211065925.2878336-1-ioerts@kookmin.ac.kr> <CAMX6_QEQ0MZTPv3+ma6cESW6sXrzHSNttoRTY5wNf9p98caa8A@mail.gmail.com>
In-Reply-To: <CAMX6_QEQ0MZTPv3+ma6cESW6sXrzHSNttoRTY5wNf9p98caa8A@mail.gmail.com>
From: yunje shin <yjshin0438@gmail.com>
Date: Wed, 18 Feb 2026 13:04:49 +0900
X-Gm-Features: AaiRm53B6BPJOuhS2U91CIFXmp5z3GYOpWxe9sCTo4PlYQb4LNe9lDODXs-rdr0
Message-ID: <CAMX6_QGn=0riCV+DZewc98b+AAdemj8ani9bQg-T+epFC5kAhw@mail.gmail.com>
Subject: Re: [PATCH] nvmet: auth: validate dhchap id list lengths(KASAN: slab-out-of-bounds)
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, ioerts@kookmin.ac.kr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_200501_607756_DC988F36 
X-CRM114-Status: GOOD (  29.94  )
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

I've confirmed that the issue is still present and the KASAN
slab-out-of-bounds read is still reproducible. Please let me know if
there are any concerns or if a v2 is needed.

Thanks, Yunje Shin

On Thu, Feb 12, 2026 at 10:49=E2=80=AFAM yunje shin <yjshin0438@gmail.com> =
wrote:
>
> The function nvmet_auth_negotiate() parses the idlist array in the
> struct nvmf_auth_dhchap_protocol_descriptor payload. This array is 60
> bytes and is logically divided into two 30-byte halves: the first half
> for HMAC IDs and the second half for DH group IDs. The current code
> uses a hardcoded +30 offset for the DH list, but does not validate
> halen and dhlen against the per-half bounds. As a result, if a
> malicious host sends halen or dhlen larger than 30, the loops can read
> beyond the intended half of idlist, and for sufficiently large values
> read past the 60-byte array into adjacent slab memory, triggering the
> observed KASAN slab-out-of-bounds read.
>
> This patch fixes the issue by:
>     - Computing the half-size from sizeof(idlist) (idlist_half)
> instead of hardcoding 30
>     - Validating both halen and dhlen are within idlist_half
>     - Replacing the hardcoded DH offset with idlist_half
>
> Thanks,
> Yunje Shin
>
> On Wed, Feb 11, 2026 at 3:59=E2=80=AFPM YunJe Shin <yjshin0438@gmail.com>=
 wrote:
> >
> > Validate DH-HMAC-CHAP hash/DH list lengths before indexing the idlist h=
alves to prevent out-of-bounds reads.
> >
> > KASAN report:
> > [   37.160829] Call Trace:
> > [   37.160831]  <TASK>
> > [   37.160832]  dump_stack_lvl+0x5f/0x80
> > [   37.160837]  print_report+0xd1/0x640
> > [   37.160842]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> > [   37.160846]  ? kfree+0x137/0x390
> > [   37.160850]  ? kasan_complete_mode_report_info+0x2a/0x200
> > [   37.160854]  kasan_report+0xe5/0x120
> > [   37.160856]  ? nvmet_execute_auth_send+0x19a9/0x1f00
> > [   37.160860]  ? nvmet_execute_auth_send+0x19a9/0x1f00
> > [   37.160863]  __asan_report_load1_noabort+0x18/0x20
> > [   37.160866]  nvmet_execute_auth_send+0x19a9/0x1f00
> > [   37.160870]  nvmet_tcp_io_work+0x17a8/0x2720
> > [   37.160874]  ? __pfx_nvmet_tcp_io_work+0x10/0x10
> > [   37.160877]  process_one_work+0x5e9/0x1020
> > [   37.160881]  ? __kasan_check_write+0x18/0x20
> > [   37.160885]  worker_thread+0x446/0xc80
> > [   37.160889]  ? __pfx_worker_thread+0x10/0x10
> > [   37.160891]  kthread+0x2d7/0x3c0
> > [   37.160894]  ? __pfx_kthread+0x10/0x10
> > [   37.160897]  ret_from_fork+0x39f/0x5d0
> > [   37.160900]  ? __pfx_ret_from_fork+0x10/0x10
> > [   37.160903]  ? __kasan_check_read+0x15/0x20
> > [   37.160906]  ? __switch_to+0xb45/0xf90
> > [   37.160910]  ? __switch_to_asm+0x39/0x70
> > [   37.160914]  ? __pfx_kthread+0x10/0x10
> > [   37.160916]  ret_from_fork_asm+0x1a/0x30
> > [   37.160920]  </TASK>
> > [   37.160921]
> > [   37.174141] Allocated by task 11:
> > [   37.174377]  kasan_save_stack+0x3d/0x60
> > [   37.174697]  kasan_save_track+0x18/0x40
> > [   37.175043]  kasan_save_alloc_info+0x3b/0x50
> > [   37.175420]  __kasan_kmalloc+0x9c/0xa0
> > [   37.175762]  __kmalloc_noprof+0x197/0x480
> > [   37.176117]  nvmet_execute_auth_send+0x39e/0x1f00
> > [   37.176529]  nvmet_tcp_io_work+0x17a8/0x2720
> > [   37.176912]  process_one_work+0x5e9/0x1020
> > [   37.177275]  worker_thread+0x446/0xc80
> > [   37.177616]  kthread+0x2d7/0x3c0
> > [   37.177906]  ret_from_fork+0x39f/0x5d0
> > [   37.178238]  ret_from_fork_asm+0x1a/0x30
> > [   37.178591]
> > [   37.178735] The buggy address belongs to the object at ffff88800aecc=
800
> > [   37.178735]  which belongs to the cache kmalloc-96 of size 96
> > [   37.179790] The buggy address is located 0 bytes to the right of
> > [   37.179790]  allocated 72-byte region [ffff88800aecc800, ffff88800ae=
cc848)
> > [   37.180931]
> > [   37.181079] The buggy address belongs to the physical page:
> > [   37.181572] page: refcount:0 mapcount:0 mapping:0000000000000000 ind=
ex:0x0 pfn:0xaecc
> > [   37.182393] flags: 0x100000000000000(node=3D0|zone=3D1)
> > [   37.182819] page_type: f5(slab)
> > [   37.183080] raw: 0100000000000000 ffff888006c41280 dead000000000122 =
0000000000000000
> > [   37.183730] raw: 0000000000000000 0000000000200020 00000000f5000000 =
0000000000000000
> > [   37.184333] page dumped because: kasan: bad access detected
> > [   37.184783]
> > [   37.184918] Memory state around the buggy address:
> > [   37.185315]  ffff88800aecc700: fa fb fb fb fb fb fb fb fb fb fb fb f=
c fc fc fc
> > [   37.185835]  ffff88800aecc780: fa fb fb fb fb fb fb fb fb fb fb fb f=
c fc fc fc
> > [   37.186336] >ffff88800aecc800: 00 00 00 00 00 00 00 00 00 fc fc fc f=
c fc fc fc
> > [   37.186839]                                               ^
> > [   37.187255]  ffff88800aecc880: fa fb fb fb fb fb fb fb fb fb fb fb f=
c fc fc fc
> > [   37.187763]  ffff88800aecc900: fa fb fb fb fb fb fb fb fb fb fb fb f=
c fc fc fc
> > [   37.188261] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   37.188938] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication")
> > Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
> > ---
> >  drivers/nvme/target/fabrics-cmd-auth.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/targ=
et/fabrics-cmd-auth.c
> > index 5946681cb0e3..8ad3255aec4a 100644
> > --- a/drivers/nvme/target/fabrics-cmd-auth.c
> > +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> > @@ -36,6 +36,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req,=
 void *d)
> >         struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
> >         struct nvmf_auth_dhchap_negotiate_data *data =3D d;
> >         int i, hash_id =3D 0, fallback_hash_id =3D 0, dhgid, fallback_d=
hgid;
> > +       size_t idlist_half;
> >
> >         pr_debug("%s: ctrl %d qid %d: data sc_d %d napd %d authid %d ha=
len %d dhlen %d\n",
> >                  __func__, ctrl->cntlid, req->sq->qid,
> > @@ -72,6 +73,15 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req=
, void *d)
> >             NVME_AUTH_DHCHAP_AUTH_ID)
> >                 return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> >
> > +       /*
> > +        * idlist[0..idlist_half-1]: hash IDs
> > +        * idlist[idlist_half..]: DH group IDs
> > +        */
> > +       idlist_half =3D sizeof(data->auth_protocol[0].dhchap.idlist) / =
2;
> > +       if (data->auth_protocol[0].dhchap.halen > idlist_half ||
> > +           data->auth_protocol[0].dhchap.dhlen > idlist_half)
> > +               return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> > +
> >         for (i =3D 0; i < data->auth_protocol[0].dhchap.halen; i++) {
> >                 u8 host_hmac_id =3D data->auth_protocol[0].dhchap.idlis=
t[i];
> >
> > @@ -98,7 +108,8 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req=
, void *d)
> >         dhgid =3D -1;
> >         fallback_dhgid =3D -1;
> >         for (i =3D 0; i < data->auth_protocol[0].dhchap.dhlen; i++) {
> > -               int tmp_dhgid =3D data->auth_protocol[0].dhchap.idlist[=
i + 30];
> > +               int tmp_dhgid =3D
> > +                       data->auth_protocol[0].dhchap.idlist[i + idlist=
_half];
> >
> >                 if (tmp_dhgid !=3D ctrl->dh_gid) {
> >                         dhgid =3D tmp_dhgid;
> > --
> > 2.43.0
> >

