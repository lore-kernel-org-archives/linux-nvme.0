Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2911C07E97
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5TE0dtyNOE7lo1q5sTJYPsF2yaEXZ9TW7C2X7ACEkLc=; b=l1EF0fvWxjW2dkuzsY8w6eZ5b5
	1Tt122qJNoCBdcKHw0bVym8GK3vxgyRWTQc4oTqbRlUCQjRln2hNLaE6999j/Vs+6Td5KSX6cEuTa
	3m1QWTTnD6iZQcUuZsnhoRKgfxTz3MJJtgCV9i0BT1tv5DGKpJqznn23XzQdkKWan8sWMPPW220t7
	iqkrxQf5f0h5eWCVKu0gIuVWiwNok+oyhaxArKfVZB0uysdDGegW84J/pb2qDTnxLS6baTEw3NtCY
	Uiy4WMzTvqV2avN0oFPCjlMPaLQUMBNSz/ETR5LYJNJSGdbEPv59P3L1ziAxf8LYfgm9djjmM8NPh
	aDDj/8zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r80fh-005mYm-0i;
	Tue, 28 Nov 2023 16:10:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r80fe-005mXs-1u
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 16:10:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701187843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TE0dtyNOE7lo1q5sTJYPsF2yaEXZ9TW7C2X7ACEkLc=;
	b=VCGoiBLWjAy27rwFbNyyZMrxdjemXldEscqmqzMfrsczu2yZsKHgkapLGWCX7UFweCZyL1
	+GikvkpJXGJ4XevMtj3t6ZoIL2pnzbs345fcTLrnrpcv4rRjmy5wc1I7gv4GyztqiJV3Da
	bhMlhyRgCZ1Sxt9ilK0U/asF994XPjM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-a2EV9i0ENy-ZB3O6Du9v4Q-1; Tue, 28 Nov 2023 11:10:42 -0500
X-MC-Unique: a2EV9i0ENy-ZB3O6Du9v4Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33174d082b7so3855510f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 28 Nov 2023 08:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187841; x=1701792641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TE0dtyNOE7lo1q5sTJYPsF2yaEXZ9TW7C2X7ACEkLc=;
        b=Y8gjuxHTyLp6ezJiDTOG6REVVx4ikvE58kY1d0xYhhSoU5Xiy17MGuJUM3+YUFR2LX
         D06PANsUMkKvVdy1EQEknhzHUvGJCtmnlMkt8rdTy+ehT6VAKOYSV8CzxoYGq/3kYFYS
         O0d08PBo6daOzonVTyw8h+umQBAeBsQuzrqhF3oktomP6jhrGCKijlSyxQkquhBOuEt0
         LhKC07ceRvW1PWAd4ibq6ZaC1VqwQ9nurconi9kJPoYazh6Uk4hGgzh3aRbt9d/dZIxf
         1Mh3vyto8QFhiWU1NQbR39MeOzv2yVcFjM+X0pC+TsHCO+IlZh/umzJ88Qmyc/BTCmFt
         GhIQ==
X-Gm-Message-State: AOJu0YwshZHaoGhdlmKrpm35MpP27DS0Z60jVh11l0wWl2M4G8VPalvo
	4RRPxMmXQDaoVP9Mh0WMo0e8kI1bwbMVjwlk6b4slDUosZ9K0qTyYzcY3E8+O4YHR2aG6wbj5cv
	TXvkbEKH6o3lKgXUaPGUysSi9xpDJ/0Ej/AAYjdBmAu0=
X-Received: by 2002:adf:ec52:0:b0:320:8e6:b0cf with SMTP id w18-20020adfec52000000b0032008e6b0cfmr10112263wrn.42.1701187841151;
        Tue, 28 Nov 2023 08:10:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVgZ535LK//2J1PIRbbmhT1zO3g3zmQOcIrNq4G9Wc0Mk5UUBfcIEreLZOFAhZLdsTkPnOv+BFBRznRXF7haU=
X-Received: by 2002:adf:ec52:0:b0:320:8e6:b0cf with SMTP id
 w18-20020adfec52000000b0032008e6b0cfmr10112252wrn.42.1701187840809; Tue, 28
 Nov 2023 08:10:40 -0800 (PST)
MIME-Version: 1.0
References: <20231127205657.25950-1-emilne@redhat.com> <ZWUSILjL_6fJXPgk@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZWUSILjL_6fJXPgk@kbusch-mbp.dhcp.thefacebook.com>
From: Ewan Milne <emilne@redhat.com>
Date: Tue, 28 Nov 2023 11:10:29 -0500
Message-ID: <CAGtn9r=KZOmxJLGNp1bu_2HRF_nuGUmJanubNVA=Je=v19Uh=Q@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: check for valid data from from
 nvme_identify_ns() before using it
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_081046_703387_C0E74D6E 
X-CRM114-Status: GOOD (  18.54  )
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

On Mon, Nov 27, 2023 at 5:03=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Mon, Nov 27, 2023 at 03:56:57PM -0500, Ewan D. Milne wrote:
> > When scanning namespaces, it is possible to get valid data from the fir=
st
> > call to nvme_identify_ns() in nvme_alloc_ns(), but not from the second
> > call in nvme_update_ns_info_block().  In particular, if the NSID become=
s
> > inactive between the two commands, a storage device may return a buffer
> > filled with zero as per 4.1.5.1.  In this case, we can get a kernel cra=
sh
> > due to a divide-by-zero in blk_stack_limits() because ns->lba_shift wil=
l
> > be set to zero.
> >
> > PID: 326      TASK: ffff95fec3cd8000  CPU: 29   COMMAND: "kworker/u98:1=
0"
> >  #0 [ffffad8f8702f9e0] machine_kexec at ffffffff91c76ec7
> >  #1 [ffffad8f8702fa38] __crash_kexec at ffffffff91dea4fa
> >  #2 [ffffad8f8702faf8] crash_kexec at ffffffff91deb788
> >  #3 [ffffad8f8702fb00] oops_end at ffffffff91c2e4bb
> >  #4 [ffffad8f8702fb20] do_trap at ffffffff91c2a4ce
> >  #5 [ffffad8f8702fb70] do_error_trap at ffffffff91c2a595
> >  #6 [ffffad8f8702fbb0] exc_divide_error at ffffffff928506e6
> >  #7 [ffffad8f8702fbd0] asm_exc_divide_error at ffffffff92a00926
> >     [exception RIP: blk_stack_limits+434]
> >     RIP: ffffffff92191872  RSP: ffffad8f8702fc80  RFLAGS: 00010246
> >     RAX: 0000000000000000  RBX: ffff95efa0c91800  RCX: 0000000000000001
> >     RDX: 0000000000000000  RSI: 0000000000000001  RDI: 0000000000000001
> >     RBP: 00000000ffffffff   R8: ffff95fec7df35a8   R9: 0000000000000000
> >     R10: 0000000000000000  R11: 0000000000000001  R12: 0000000000000000
> >     R13: 0000000000000000  R14: 0000000000000000  R15: ffff95fed33c09a8
> >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> >  #8 [ffffad8f8702fce0] nvme_update_ns_info_block at ffffffffc06d3533 [n=
vme_core]
> >  #9 [ffffad8f8702fd18] nvme_scan_ns at ffffffffc06d6fa7 [nvme_core]
> >
> > This happened when the check for valid data was moved out of nvme_ident=
ify_ns()
> > into one of the callers.  Fix this by checking in both callers.
> >
> > v2: call kfree() on nvme_id_ns struct in error path
> >
> > Fixes: 0dd6fff2aad4 ("nvme: bring back auto-removal of deleted namespac=
es during sequential scan")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ewan D. Milne <emilne@redhat.com>
>
> Thanks, applied for nvme-6.7.
>
> Interestingly enough, I think this is the same as what was recently
> reported here:
>
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D218186
>

Yes, from the stack trace and BZ comments it looks like it.

-Ewan


