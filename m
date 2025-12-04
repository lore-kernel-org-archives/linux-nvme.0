Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4540D1CDBA
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 01:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kxBnpw1GjopzxGlN5iT0Q2B7vyelob3j9SFPDIdohXY=; b=MdZmBQd3x/8XF4bDXlf2IXzU4L
	9iZysoQVszvmIhGCBx8VpJgPcgY0upZqqETMqiM/DK3yW91WZ8lEgbfp91kCQ4UXp288jU6342lW0
	ZUCB8Wu/NWcT4++ZA7hwEfT3tSueXKnOg1IBnDGW4KJww44jPnANE6l+zUhS9DxHL+oafYlvmkCu+
	inoHq2hqg3TzfcrPzYDnoOsaKlCmms4QwZGlxx7ckx+jhWxmwVxmvFAKotrW0EI9DGw3UAkhhCBEm
	pB1MtFvkBdWF9UeEK/MedmnLkrUyAqgm8MqKc7gKPofON158Q+48/3mpSOGXkk4j0e+dhOh94c7w6
	GG15LHhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQyPL-00000007LTM-05Hh;
	Thu, 04 Dec 2025 01:45:23 +0000
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQyPC-00000007LT0-43Aw
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 01:45:16 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-880570bdef8so3706966d6.3
        for <linux-nvme@lists.infradead.org>; Wed, 03 Dec 2025 17:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764812713; x=1765417513; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxBnpw1GjopzxGlN5iT0Q2B7vyelob3j9SFPDIdohXY=;
        b=BGSXbE1BMlBc3DPeHe2/xUmLdJg5OxN8nk9MSFeDFkAZHqF0ErR7XgeXfU2xmzhNDx
         4oau+ERR8dxS251XsR1EtKrwCtzSM3OV6TcYI5ok5Dw30Jb6hxa3K3dk+5jNUjBMfqNo
         +1NBFRdL2ZSxBXoHEkJodagSKmWIi+g0NprigsCsX8vFQy2wgqx1JIv9/j4dTQ9bDkj7
         9GW5FTQfdzEY2LdbSR2V1dBeR6Cwe8p/bfYInuMzPuWPLp3EiDFwPXzkrVin0V3Co17E
         Eks/E2mDbr7rXqtnlx+Se/iS06Ye7sSNYbpZtu5yffpWiQJ6jjgxjdx2nDzBnPz7Py2o
         qYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764812713; x=1765417513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kxBnpw1GjopzxGlN5iT0Q2B7vyelob3j9SFPDIdohXY=;
        b=lTohxX9VZmqauXRI4x4Hvsn4Mjx6UkFQ+8M5akdCvOjcw99VjTRCSQ1NvXvueFLI/D
         VbSSYXaNBmtMg2QlmU1wFyi/bir+xeWsGjjEUgiKuACb2F7xxqvfe84PowzGphYcfRYt
         RswJMNRq5dat0+v0UGloxBUHK2GDH3uBVhhqKQGJvmNGz7oWJKdK1KAR9YR/QTSvQA5q
         1p520IK3koSlmgc8MJb7oJ6jLSyDSfEeNirbOx3D/ef+fCGbeN0Dk3HJhhWc269carH5
         7CQ2XB14Iroge08j+F/YgGeDVnO7lgdpZrYiHPR7Snyecw6dXh5kTymkv4Jk8xKfg1xo
         8XwA==
X-Forwarded-Encrypted: i=1; AJvYcCVMlm5UusgrkyAxilAwVSq2PxjYhcedmYhlRKPTCLeXAfvaZ3R3PGOqZ5lidzq1szxToRwtjwICED0i@lists.infradead.org
X-Gm-Message-State: AOJu0YyPQDBMuDinQhI3H+X2Y2ImwtiF16JPwx+wsqkGjNT9fouwodVy
	U2F2EIpe6DS/vgGydeWFOxP03WDcD6Std7HjAvCMZgGfHt/GyueMm8rc5ss/hT/qfuXjKSdVtbi
	EBpBw6nOqglxBdJWI+C7DrKUI6yYAZLI=
X-Gm-Gg: ASbGncu9rYoaFF02Z+VtRIlttVVmOdPKjEEiVCMx2qdM+wN4HZuvZZ5Ji7rtEcGmQOf
	avXuUm2MUf6hk3I7Ktjjy6kmZpaQstcAtrNJgFX5YdX5VTb9YznvgXSKWofwRyTO0dImo8mGKpD
	9jJs9oCXY3bZNKOrACRn0zXKmBbsfDGPAmAeo6rYkedQWRW5Ok2c9513Vt3ggCp1oZyXFIKTMl+
	HK0yUKMH97o5cA+F8+fw0E4TAmDFH0Sqd+oLdzdlxc6Sv4m52TlbGisRQb9S52ukZUHf8Cu
X-Google-Smtp-Source: AGHT+IGANlvWwi/3A2lXaGwVXC/kDNo20hSUtDFXbTqENBbuvmHnAAoZNcFdFg/Aj4/CTx1dKNy74bBdVTcIvo5A1zs=
X-Received: by 2002:ad4:5ca9:0:b0:880:5a06:3a64 with SMTP id
 6a1803df08f44-888248cdae1mr22539626d6.66.1764812713294; Wed, 03 Dec 2025
 17:45:13 -0800 (PST)
MIME-Version: 1.0
References: <21255200-a271-4fa0-b099-97755c8acd4c@work> <CAGtn9rmSq9+6o1-=tQwYGRKRUSOXkSJnCdSosNnpW0BvnxaNLQ@mail.gmail.com>
 <6440e968-a181-419b-b203-a354b924341b@work> <05b455fc-d08c-4fb2-81db-a818771b9c42@gmail.com>
 <fb66da17-65b5-483f-8d49-e3dfa38b27d3@work> <CABPRKS-e9pXDyFejW+o42vRfzhy6EkUnOVxe46iZqqm4OMk4yg@mail.gmail.com>
 <CABPRKS-UZMwfKNCK6Mx17_MxYK-ZieKddx0N7YBM3hf5Ur=4Ug@mail.gmail.com> <CAGtn9rmQW9w42oMVGpXZB4OuifwF3XzgVaxuHyXN1aYpzjRskg@mail.gmail.com>
In-Reply-To: <CAGtn9rmQW9w42oMVGpXZB4OuifwF3XzgVaxuHyXN1aYpzjRskg@mail.gmail.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Wed, 3 Dec 2025 17:44:14 -0800
X-Gm-Features: AWmQ_bmxnq2BCEjBI1dl7Pfra8S879ifdKO-Q5-uJyxRZzs324HKQGZi2xqNwo8
Message-ID: <CABPRKS-j+J1XKKoMOXx-d-8d_yxo2JhF6G6jYYFvFXOdy5x3tw@mail.gmail.com>
Subject: Re: [PATCH] nvme: fc: stop lsrcv workqueue before freeing a rport
To: Ewan Milne <emilne@redhat.com>
Cc: Aristeu Rozanski <aris@redhat.com>, linux-nvme@lists.infradead.org, 
	Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251203_174515_052179_9A43EA36 
X-CRM114-Status: GOOD (  10.44  )
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

> Aristeau's original stack trace was in nvme-fc (Initiator) though, I thin=
k.
Kind of sort of, the Last Breaking-Event-Address is on the target side
(target/fcloop.c):

[12996.173750] Last Breaking-Event-Address:
[12996.173750]  [<0000017ed7b594da>] fcloop_t2h_xmt_ls_rsp+0x10a/0x140
[nvme_fcloop]
[12996.173757] Kernel panic - not syncing: Fatal exception: panic_on_oops

It just so happens the intended lsrsp->done(lsrsp) call is trying to
reach into nvme_fc (initiator) code because done is supposed to be set
to nvme_fc_xmt_ls_rsp_done.

Additionally, consistent reproduction on a x86_64 system yields a call
trace like below:

Oops: general protection fault, probably for non-canonical address
0xd3ea351027e1e8d8: 0000 [#1] SMP NOPTI

Workqueue: events nvme_fc_handle_ls_rqst_work [nvme_fc]
RIP: 0010:fcloop_t2h_xmt_ls_rsp+0xca/0x130 [nvme_fcloop]
Code: 8b 72 18 41 b8 f0 01 00 00 48 c7 c1 40 d0 a8 c0 48 c7 c2 fa d2
a8 c0 48 c7 c7 50 d4 a8 c0 e8 8d 58 7b f3 48 8b 43 18 48 89 df <ff> d0
0f 1f 00 b9 fd 01 00 00 48 c7 c2 40 d0 a8 c0 48 c7 c6 fa d2
RSP: 0018:ff50b14f0a9abd88 EFLAGS: 00010246
RAX: d3ea351027e1e8d8 RBX: ff2ab922d2016ef0 RCX: 0000000000000027
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ff2ab922d2016ef0
RBP: 0000000000000000 R08: 0000000000000000 R09: ff50b14f0a9abc40
R10: ff50b14f0a9abc38 R11: ff2ab9323f9c6328 R12: ff2ab922d79bc000
R13: ff2ab922c59c0800 R14: 0800000002000000 R15: ff2ab922d79bc098
FS:  0000000000000000(0000) GS:ff2ab92a687fc000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055fecf7f6a60 CR3: 00000001116c0005 CR4: 0000000000773ef0
PKRU: 55555554
Call Trace:
 <TASK>
 nvme_fc_xmt_ls_rsp+0x46/0x90 [nvme_fc deaa37bfaf3bed135f3fe0a56933d272bbdc=
0340]
 nvme_fc_handle_ls_rqst_work+0xd0/0x650 [nvme_fc
deaa37bfaf3bed135f3fe0a56933d272bbdc0340]
 process_one_work+0x18e/0x3c0
 worker_thread+0x29d/0x3c0
 kthread+0xfc/0x210
 ret_from_fork+0x197/0x1d0
 ret_from_fork_asm+0x1a/0x30
 </TASK>


What=E2=80=99s happening is that rport->remoteport.port_state is not set to
FC_OBJSTATE_ONLINE so nvme_fc_handle_ls_rqst is not setting the
lsrsp->done function pointer to nvme_fc_xmt_ls_rsp_done.  So, when
target/fcloop.c calls lsrsp->done it=E2=80=99s crashing.

I have a patch in mind to resolve this, and will report back.

