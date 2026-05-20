Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F40CD4F54
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 06:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Mime-Version:
	Subject:Date:Content-Transfer-Encoding:References:From:To:Message-Id:
	In-Reply-To:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=swfVN7KOlYipjh4qO10XmCnrllo7SwUJfHFP7JOjUVs=; b=v/hJ0D38YBVM3uPGpr3yiz88Ks
	RcvfmmS5f2jLGPTtHuplTahcZ2QPU/Ab6tvFKLFZuLpkoLDTNy0z8F02npLx9DdT2jEBBI7kq9jDW
	6Ldz/ff0bf9rep3351PaZijvPfQzy/gX8EHFCyLFAv+vqEz15YBktTR967Q5pcTTA0MlMCXN+/+lk
	cX2gt5c2GiO4a8dRhBdI+eDHGIbwOpcqjQTM2F7Tvi2zbQVvjDvqZjfptglc00IB48mM/l3TXAdiR
	N7rbp//0ybpzfBbZeEIXA7gell00qfuUh2RkAfJ+nje2XF5n8yPuPbwnuTwN0Gdc7p65dbap7j09/
	xofUcq8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPaK3-00000003eAx-2wWn;
	Wed, 20 May 2026 06:22:27 +0000
Received: from va-2-115.ptr.blmpb.com ([209.127.231.115])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPaK1-00000003e9w-1Y9G
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 06:22:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779258134; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=swfVN7KOlYipjh4qO10XmCnrllo7SwUJfHFP7JOjUVs=;
 b=cRLHKV5XsbZDk7yuwty+mFqidwzrAia5ljsNhvuWDjl3Y76jbWtVkLyOcCo6CKUhGEGL2k
 khH27oeOk2f7/aIZABxE+nyUuIGub7rORpxXttjLfAQcJ9VwvMZqzVvFbw49wiw4Wphe6J
 03DUI3+IQeI9jjcgAuInb19+Wsj+3zPKP7bw5TH3POtrBTc1agcrk+QGq7RCDC9nHN5WOi
 w/5P8Qmk7XeC+9erpw4mZXO6hH5TWziClU71EEFVlO3eKKO/J6PGUJKMAzTzY3PHE8gTx6
 xY/hGyiODc48YlZhucwtv4tXVMo4jynw1sN9u32trvgIyLVZ2FP4FXeURdjPcw==
In-Reply-To: <7e688c2e-7fa5-45d2-9163-a81e1fd8c9f3@gmail.com>
X-Lms-Return-Path: <lba+16a0d5314+66bcee+lists.infradead.org+guzebing@bytedance.com>
Message-Id: <4b210910448ef2227190f426e97614787d15d32b.ec564600.33b5.4dec.b88e.b13b57f6dffb@bytedance.com>
To: "Tokunori Ikegami" <ikegami.t@gmail.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: =?utf-8?q?=E9=A1=BE=E6=B3=BD=E5=85=B5?= <guzebing@bytedance.com>
References: <20260519134542.1841435-1-guzebing1612@gmail.com>
	<7e688c2e-7fa5-45d2-9163-a81e1fd8c9f3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 14:22:10 +0800
Subject: Re: [PATCH nvme-cli] nvme: check MUD support before firmware commit
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_232225_483299_D1BF3584 
X-CRM114-Status: GOOD (  14.43  )
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


> From: "Tokunori Ikegami"<ikegami.t@gmail.com>
> Date:=C2=A0 Wed, May 20, 2026, 06:50
> Subject:=C2=A0 Re: [PATCH nvme-cli] nvme: check MUD support before firmwa=
re commit
> To: "guzebing"<guzebing1612@gmail.com>, <linux-nvme@lists.infradead.org>
> Cc: "Daniel Wagner"<wagi@kernel.org>, "Guzebing"<guzebing@bytedance.com>
> On 2026/05/19 22:45, guzebing wrote:
> > From: Guzebing <guzebing@bytedance.com>
> >
> > Firmware Commit returns the Multiple Update Detected value in the comma=
nd
> > completion. nvme-cli currently identifies the controller after the
> > command completes to decide whether to print that value.
> >
> > That post-command Identify is fragile for immediate activation. A possi=
ble
> > Linux race looks like:
> >
> > =C2=A0 =C2=A0nvme-cli thread =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0nvme driver AEN work
> > =C2=A0 =C2=A0--------------- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0--------------------
> > =C2=A0 =C2=A0libnvme_exec_admin_passthru()
> > =C2=A0 =C2=A0 =C2=A0-> Firmware Commit succeeds
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nvme_handle_aen_notice()
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -> FW_ACT_STARTING
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -> nvme_change_ctrl_state(=
RESETTING)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -> nvme_fw_act_work()
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-> nvme_quies=
ce_io_queues()
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-> wait for a=
ctivation
> > =C2=A0 =C2=A0fw_commit_print_mud()
> > =C2=A0 =C2=A0 =C2=A0-> fw_commit_support_mud()
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 -> nvme_identify_ctrl()
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-> admin ioctl passthru
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-> nvme_user_cmd*()
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-> blk_mq_alloc_request()
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-> __nvme_check_ready()
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rejects user admin com=
mand while resetting
> >
> > nvme-cli then prints "identify-ctrl: ..." after the successful
> > fw-commit output. The extra error makes it unclear whether Firmware
> > Commit itself failed, even though the command completion was already
> > successful.
> Seems the changes good but to make sure let me confirm below if possible.
> =C2=A0=C2=A0 1. Is this failure really caused?
Yes, we observed this in our production environment last week. For the
SOLIDIGM SB5PH27X076T Gen5 NVMe device, when upgrading the firmware from
G70YG472 to G70YG473, nvme-cli printed the following error after Firmware
Commit:

=C2=A0=C2=A0=C2=A0 identify-ctrl: No such device or address

It reproduced 100% in our environment for this device and this firmware upd=
ate
path. I suspect this is because the firmware activation takes long enough f=
or
the post-command Identify Controller command to hit the controller reset wi=
ndow.

After applying this patch, the extra identify-ctrl error after the successf=
ul
Firmware Commit disappeared.

Environment:
=C2=A0 - kernel: Linux 6.12
=C2=A0 - OS: Debian 13.2
=C2=A0 - nvme-cli: 2.13

> =C2=A0=C2=A0 2. Is there any log or issue report information?
There is no public issue report yet.

The user-visible nvme-cli output was:

=C2=A0=C2=A0=C2=A0 Success committing firmware action:3 slot:1
=C2=A0=C2=A0=C2=A0 identify-ctrl: No such device or address

We did not find any kernel error messages in dmesg around the failure. The =
only
user-visible error was printed by nvme-cli.

> =C2=A0=C2=A0 3. Not necessary to care the case as the old firmware not su=
pported=C2=A0
> MUD but only the new firmware supported MUD? (I think so but let me=C2=A0
> double check.)
>=C2=A0

