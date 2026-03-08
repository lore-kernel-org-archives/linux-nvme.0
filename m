Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA58EA852A
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Mar 2026 15:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tpY2+19vkrzFiMUcfV5bhjW1OIJlpgy7l2z+NYviHjk=; b=a5ULSaj48QeS84a7D1tnqif8gz
	SCVubE3e6P1PRoYTpkBUb10ZRXSEvM+sXLHrf8KMOqobwzkoSN3MkV8ycJeuR418j8VeleSZ25zZl
	O4Sh/aHmb1yQ0mmf6uPU6eh1JMGu/aoS/F741Ddtgtr5tQ6kAXasYNHiEIeFHhUI4mpD6uSdN/pd6
	yOIdXiTrXcqxql+jn4tetv1TO1IQlDdtg/Vd9RhyIi2TCKtJTaQawbRsnYW/im/SyI78+SzBI+g1m
	CYFlsehxY8mpKGeByCWdEQlZlPy7P+rd416tSicp/OHMZBD4GapvQD/zDx7MMBDKSnP9KvkRpwLp+
	kxM65tuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzFkq-000000067C5-3KCZ;
	Sun, 08 Mar 2026 15:09:16 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzFkn-000000067BX-2mSW
	for linux-nvme@lists.infradead.org;
	Sun, 08 Mar 2026 15:09:14 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-8298fad2063so1740152b3a.3
        for <linux-nvme@lists.infradead.org>; Sun, 08 Mar 2026 08:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772982552; cv=none;
        d=google.com; s=arc-20240605;
        b=eDvhdaaaJwZie3Y9eWubSMGtW/2B1+xRsBDeUNg6OBEWqK2iqDzYUWv5OiUK4jzqwC
         JTGSxf4LBziVc9rgmPhRH6mMLCHHt8E0EFQ/rCiKPrVaYTIFhXn/fH/us0lC7AkF0vAW
         rpnbSvCZRtXNM9cF6UB4hqXp56gHZoGGzpeEXvNhGkUEW7BEdTeWiLkzVDkntddHSAZN
         S3H1pDBWacAH/PsfdA4dNywsN4yIpgiW2XmGP1kOZp7UZ5PaguCQ1+9ze7wMXVSOcEZb
         z44iqpimf1299QyO9RKRb1a3J9ygQUrjjG2w5fl9zS1UEnQ1QtU0PkwPg3HaJGs8GnIn
         yWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tpY2+19vkrzFiMUcfV5bhjW1OIJlpgy7l2z+NYviHjk=;
        fh=t4qazzGJkJd1gu0E44ht/WqjmrcmlDKyMvA+KisCZtY=;
        b=JFqDwzJEciujRCn67+/Wjk8982pu2mt7lVdjdoaBDMFfH0U/wE+VOlGDxeb+l0Nghf
         8dECcEfnQSEIhbzAhxKHQ+ulcz3wFHvDNu8JpRrnMu428Tl5G3S3rU5pGggxV2Qd0Oip
         A1m8ctSGC02QgvAYJMkuOIkPSk5sYHy9hRmqn+s5pJtzpetKgd/cu0hj5XFpQYrwS621
         6W5g7bQl4wYizDncVcpbcyp6DaNmP+yFsKS/HxId6IBoMyighweFs03/4yqtDqsuq3SA
         VnWRYO0o9Zx444HvwlkyCmXgYMxgciAbOhhTQz0n4pkg1rm+qQGSXGmNHvX8QXpoI0y7
         O5Jg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772982552; x=1773587352; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpY2+19vkrzFiMUcfV5bhjW1OIJlpgy7l2z+NYviHjk=;
        b=kgLnHZHlh1u0n6qDkX9UMtjM9uBOWXS3awn5LN4eGdhKXaWEGqxAZCRCGVpejP5IsU
         vr6KyDV2J+ukqvEu9EThPnoH649C8JNFEbH976vITU/z3g+i3DTjAkdf/Y4RQIqBdBYe
         ydnMPfn6z/2j1/ViQsQ9KownJ/j0LG1BfAo8SDkoZ5KDwFEUvLNJAPD79027K2XNdIUS
         CpoUmgbLneNnjYaX+lrUMNG/M2hKk3edwrr22NFJzhp9oNy3OmHSO/xo5E70SylRB5Lq
         rNlvu3fwKuyh3MDmYoD8tNzrlxS6QckrucY0F5QFgikiNzfg9VCe7TnXVXq7UaE9vTdp
         n80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772982552; x=1773587352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tpY2+19vkrzFiMUcfV5bhjW1OIJlpgy7l2z+NYviHjk=;
        b=wRjnq0UT3hX1oL9lF/UjbMcVlVkHqd2DGcuE38GyXfCOJaTz+yROgIVPaCRE5tdL+x
         9t5sAqMGED/BIhZ2PSaa1V1UBx36k9e17oV5c3gOZQXK4qm2q1QlmEnfdhw5sD3FCVJz
         PAL3ZG7EL0iU3fnfyNRWk22TnCMv3tuCMeM8inrgARt963jhjVRJ0e5tf5mI0Ma43A4R
         3P5k/hkoftkvZTjfbRuAWPHHkFcxB+2pajCmvzjXLpMIUa8f2fXin0JzKgdPQr4mgg79
         eWG19Cyy91yGvMMXj4Ttrb1y8xj8n6ZiKCOGQV2sjK/juxws0bcW49cHjxpSHpEtrpmt
         5dqw==
X-Forwarded-Encrypted: i=1; AJvYcCVHXInJta/8vvUXACXsfpwcTXbkWCpiNRPS194kIYQHAsay8z7HlSUMKMjN5Z0M1M7hlIWd1qxKlE6m@lists.infradead.org
X-Gm-Message-State: AOJu0YwIVungOOM46k+kur2Akr7ZnkMFQiQZF3AmoqLf0mAaI6un2PCD
	ThaVVYGR4jtGS4dErEsjWDA3ppi6qP8uIdh2Gb8VaXKqkeQyBm7Tnf0G3IN/vmlaCjQFoqq/+l1
	PdGVXDSWal15HcwDpLkXAIQ7IjUq8Mjc=
X-Gm-Gg: ATEYQzzT4FgLwPITS5vrOocPGiNkoNb/DnscT9cDd2owsawqVQgyNR6xbbTNPzQBNI+
	z80+pK9nziTiYrqgMAs+IWoqA+/odifgprjRuhrV2+9qfOC47X2FgRaqeWxY02XeM941ulx7Q8x
	+JQaoCf6/x10dtiplXU5HvRJ+pKc7BlzwE4iaYRvoqLv14qS1Evf3aDKR8Qro+Wh89pi3s98cpC
	XI+q1/yNcp9DbxDsJ3oi5Ohm59dHvpgxgZaQ2GB9oGX/U4uU1TEpcbQPtvSB2ux2/M/NqYwz1B2
	BtRjdgU=
X-Received: by 2002:a05:6a00:3d13:b0:81f:4dc7:d31 with SMTP id
 d2e1a72fcca58-829a2f6d393mr7629264b3a.33.1772982551871; Sun, 08 Mar 2026
 08:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260211065925.2878336-1-ioerts@kookmin.ac.kr>
 <CAMX6_QEQ0MZTPv3+ma6cESW6sXrzHSNttoRTY5wNf9p98caa8A@mail.gmail.com> <CAMX6_QGn=0riCV+DZewc98b+AAdemj8ani9bQg-T+epFC5kAhw@mail.gmail.com>
In-Reply-To: <CAMX6_QGn=0riCV+DZewc98b+AAdemj8ani9bQg-T+epFC5kAhw@mail.gmail.com>
From: yunje shin <yjshin0438@gmail.com>
Date: Mon, 9 Mar 2026 00:09:01 +0900
X-Gm-Features: AaiRm53f-uxzBHLbs_-QmnZ7EtvjHLF4D9CwCAUyxICv2469qq8-15hKFaztjJk
Message-ID: <CAMX6_QH7xiTxLbF4pZHVs9Umw=j70c-dmb3t97c6XBEEEg-kpA@mail.gmail.com>
Subject: Re: [PATCH] nvmet: auth: validate dhchap id list lengths(KASAN: slab-out-of-bounds)
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, 
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ioerts@kookmin.ac.kr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260308_080913_717332_35380C7E 
X-CRM114-Status: GOOD (  32.62  )
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

Just following up on this patch in case it got buried.
The KASAN slab-out-of-bounds read is still reproducible on my side.
I'd appreciate any feedback.

Thanks,
Yunje Shin

On Wed, Feb 18, 2026 at 1:04=E2=80=AFPM yunje shin <yjshin0438@gmail.com> w=
rote:
>
> I've confirmed that the issue is still present and the KASAN
> slab-out-of-bounds read is still reproducible. Please let me know if
> there are any concerns or if a v2 is needed.
>
> Thanks, Yunje Shin
>
> On Thu, Feb 12, 2026 at 10:49=E2=80=AFAM yunje shin <yjshin0438@gmail.com=
> wrote:
> >
> > The function nvmet_auth_negotiate() parses the idlist array in the
> > struct nvmf_auth_dhchap_protocol_descriptor payload. This array is 60
> > bytes and is logically divided into two 30-byte halves: the first half
> > for HMAC IDs and the second half for DH group IDs. The current code
> > uses a hardcoded +30 offset for the DH list, but does not validate
> > halen and dhlen against the per-half bounds. As a result, if a
> > malicious host sends halen or dhlen larger than 30, the loops can read
> > beyond the intended half of idlist, and for sufficiently large values
> > read past the 60-byte array into adjacent slab memory, triggering the
> > observed KASAN slab-out-of-bounds read.
> >
> > This patch fixes the issue by:
> >     - Computing the half-size from sizeof(idlist) (idlist_half)
> > instead of hardcoding 30
> >     - Validating both halen and dhlen are within idlist_half
> >     - Replacing the hardcoded DH offset with idlist_half
> >
> > Thanks,
> > Yunje Shin
> >
> > On Wed, Feb 11, 2026 at 3:59=E2=80=AFPM YunJe Shin <yjshin0438@gmail.co=
m> wrote:
> > >
> > > Validate DH-HMAC-CHAP hash/DH list lengths before indexing the idlist=
 halves to prevent out-of-bounds reads.
> > >
> > > KASAN report:
> > > [   37.160829] Call Trace:
> > > [   37.160831]  <TASK>
> > > [   37.160832]  dump_stack_lvl+0x5f/0x80
> > > [   37.160837]  print_report+0xd1/0x640
> > > [   37.160842]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> > > [   37.160846]  ? kfree+0x137/0x390
> > > [   37.160850]  ? kasan_complete_mode_report_info+0x2a/0x200
> > > [   37.160854]  kasan_report+0xe5/0x120
> > > [   37.160856]  ? nvmet_execute_auth_send+0x19a9/0x1f00
> > > [   37.160860]  ? nvmet_execute_auth_send+0x19a9/0x1f00
> > > [   37.160863]  __asan_report_load1_noabort+0x18/0x20
> > > [   37.160866]  nvmet_execute_auth_send+0x19a9/0x1f00
> > > [   37.160870]  nvmet_tcp_io_work+0x17a8/0x2720
> > > [   37.160874]  ? __pfx_nvmet_tcp_io_work+0x10/0x10
> > > [   37.160877]  process_one_work+0x5e9/0x1020
> > > [   37.160881]  ? __kasan_check_write+0x18/0x20
> > > [   37.160885]  worker_thread+0x446/0xc80
> > > [   37.160889]  ? __pfx_worker_thread+0x10/0x10
> > > [   37.160891]  kthread+0x2d7/0x3c0
> > > [   37.160894]  ? __pfx_kthread+0x10/0x10
> > > [   37.160897]  ret_from_fork+0x39f/0x5d0
> > > [   37.160900]  ? __pfx_ret_from_fork+0x10/0x10
> > > [   37.160903]  ? __kasan_check_read+0x15/0x20
> > > [   37.160906]  ? __switch_to+0xb45/0xf90
> > > [   37.160910]  ? __switch_to_asm+0x39/0x70
> > > [   37.160914]  ? __pfx_kthread+0x10/0x10
> > > [   37.160916]  ret_from_fork_asm+0x1a/0x30
> > > [   37.160920]  </TASK>
> > > [   37.160921]
> > > [   37.174141] Allocated by task 11:
> > > [   37.174377]  kasan_save_stack+0x3d/0x60
> > > [   37.174697]  kasan_save_track+0x18/0x40
> > > [   37.175043]  kasan_save_alloc_info+0x3b/0x50
> > > [   37.175420]  __kasan_kmalloc+0x9c/0xa0
> > > [   37.175762]  __kmalloc_noprof+0x197/0x480
> > > [   37.176117]  nvmet_execute_auth_send+0x39e/0x1f00
> > > [   37.176529]  nvmet_tcp_io_work+0x17a8/0x2720
> > > [   37.176912]  process_one_work+0x5e9/0x1020
> > > [   37.177275]  worker_thread+0x446/0xc80
> > > [   37.177616]  kthread+0x2d7/0x3c0
> > > [   37.177906]  ret_from_fork+0x39f/0x5d0
> > > [   37.178238]  ret_from_fork_asm+0x1a/0x30
> > > [   37.178591]
> > > [   37.178735] The buggy address belongs to the object at ffff88800ae=
cc800
> > > [   37.178735]  which belongs to the cache kmalloc-96 of size 96
> > > [   37.179790] The buggy address is located 0 bytes to the right of
> > > [   37.179790]  allocated 72-byte region [ffff88800aecc800, ffff88800=
aecc848)
> > > [   37.180931]
> > > [   37.181079] The buggy address belongs to the physical page:
> > > [   37.181572] page: refcount:0 mapcount:0 mapping:0000000000000000 i=
ndex:0x0 pfn:0xaecc
> > > [   37.182393] flags: 0x100000000000000(node=3D0|zone=3D1)
> > > [   37.182819] page_type: f5(slab)
> > > [   37.183080] raw: 0100000000000000 ffff888006c41280 dead00000000012=
2 0000000000000000
> > > [   37.183730] raw: 0000000000000000 0000000000200020 00000000f500000=
0 0000000000000000
> > > [   37.184333] page dumped because: kasan: bad access detected
> > > [   37.184783]
> > > [   37.184918] Memory state around the buggy address:
> > > [   37.185315]  ffff88800aecc700: fa fb fb fb fb fb fb fb fb fb fb fb=
 fc fc fc fc
> > > [   37.185835]  ffff88800aecc780: fa fb fb fb fb fb fb fb fb fb fb fb=
 fc fc fc fc
> > > [   37.186336] >ffff88800aecc800: 00 00 00 00 00 00 00 00 00 fc fc fc=
 fc fc fc fc
> > > [   37.186839]                                               ^
> > > [   37.187255]  ffff88800aecc880: fa fb fb fb fb fb fb fb fb fb fb fb=
 fc fc fc fc
> > > [   37.187763]  ffff88800aecc900: fa fb fb fb fb fb fb fb fb fb fb fb=
 fc fc fc fc
> > > [   37.188261] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [   37.188938] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication"=
)
> > > Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
> > > ---
> > >  drivers/nvme/target/fabrics-cmd-auth.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/ta=
rget/fabrics-cmd-auth.c
> > > index 5946681cb0e3..8ad3255aec4a 100644
> > > --- a/drivers/nvme/target/fabrics-cmd-auth.c
> > > +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> > > @@ -36,6 +36,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *re=
q, void *d)
> > >         struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
> > >         struct nvmf_auth_dhchap_negotiate_data *data =3D d;
> > >         int i, hash_id =3D 0, fallback_hash_id =3D 0, dhgid, fallback=
_dhgid;
> > > +       size_t idlist_half;
> > >
> > >         pr_debug("%s: ctrl %d qid %d: data sc_d %d napd %d authid %d =
halen %d dhlen %d\n",
> > >                  __func__, ctrl->cntlid, req->sq->qid,
> > > @@ -72,6 +73,15 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *r=
eq, void *d)
> > >             NVME_AUTH_DHCHAP_AUTH_ID)
> > >                 return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> > >
> > > +       /*
> > > +        * idlist[0..idlist_half-1]: hash IDs
> > > +        * idlist[idlist_half..]: DH group IDs
> > > +        */
> > > +       idlist_half =3D sizeof(data->auth_protocol[0].dhchap.idlist) =
/ 2;
> > > +       if (data->auth_protocol[0].dhchap.halen > idlist_half ||
> > > +           data->auth_protocol[0].dhchap.dhlen > idlist_half)
> > > +               return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> > > +
> > >         for (i =3D 0; i < data->auth_protocol[0].dhchap.halen; i++) {
> > >                 u8 host_hmac_id =3D data->auth_protocol[0].dhchap.idl=
ist[i];
> > >
> > > @@ -98,7 +108,8 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *r=
eq, void *d)
> > >         dhgid =3D -1;
> > >         fallback_dhgid =3D -1;
> > >         for (i =3D 0; i < data->auth_protocol[0].dhchap.dhlen; i++) {
> > > -               int tmp_dhgid =3D data->auth_protocol[0].dhchap.idlis=
t[i + 30];
> > > +               int tmp_dhgid =3D
> > > +                       data->auth_protocol[0].dhchap.idlist[i + idli=
st_half];
> > >
> > >                 if (tmp_dhgid !=3D ctrl->dh_gid) {
> > >                         dhgid =3D tmp_dhgid;
> > > --
> > > 2.43.0
> > >

