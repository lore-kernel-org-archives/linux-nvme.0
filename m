Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E928C369AB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KYfVGs5Ml5RUvmfmlnLHLt4BSVc6Sc3qJsp0ZtPVfds=; b=Wn3p03NSrT2bHjXYy8sbUv/1fa
	r+bFnu4iZUtOp4WjiDkR4D+oeQ0jCskmEPgDBW3t+E5/4AoNmjdHl80RigJfgs0zS1SRhl2/iWbdq
	oqw7b3iYZhsjl0+d6tKbFoe/JHxXHiC7S90QEuUMS4PrI/lKzJXfI3CmP5P3DrDGgXlbcrl9IbAw0
	HQq4/XVqhO1/1O0/cGLHNHempCiD0QCKH0nuPSGKKa4vM3zG7tmhv9RTnBxyIUGbvkbXtcmvL9U1W
	8g7OU0P0LeI7BDz3PRo5M+kQaaQd8Uh6gHq3DBpRfopIq1dISp7usif+Oe6DEM+Y8DfoM5tIIhRQs
	Q+s7N90Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5pGb-0000000HAbD-1DBP;
	Fri, 18 Apr 2025 17:12:41 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5p6D-0000000H8CU-2ANW
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 17:01:58 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-af5f28ecbcaso207606a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 18 Apr 2025 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744995716; x=1745600516; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYfVGs5Ml5RUvmfmlnLHLt4BSVc6Sc3qJsp0ZtPVfds=;
        b=YMQomNxAxpgfTA05Jv7g6aqTYEC1K/kEK9Yr5iin1t6niMqbyJ9Pb+2BNcAHMzkP+H
         m4Moy1fFz57M1AsV+/HjRzbz8r9F8BdXsX4UyL99w3YPS+kFoE/dhPu28rAI1KPt+91R
         eJIu3QjMG3pRVke0VsdhWoJIG6rf/zbvz5rU/MWT0xNVw3WcusV4OAb/DDKRcqCoUTkD
         Nw7hH2QJMW658yKWMzSH+lT51lC2tV9/13WEGvw/gVCoczN018CuvjO43G41lnTL4CAD
         c8rOCajzV4ImwPYfjPH3Tl/DBmvSUix40WgPSAvbgGTnUeQ0wKAUjT5+t+Z1aAySVUjE
         RFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744995716; x=1745600516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYfVGs5Ml5RUvmfmlnLHLt4BSVc6Sc3qJsp0ZtPVfds=;
        b=YHxoTR/6AnsKJTuFVaQJ4V8zNFmqbrx5YpsfyrwQofdXda73YRSSJXliCbOeFRJ4aO
         6i8y3vEf4LUh3+YWhgueXJaquBDniqt0H3co6UzXGa+Yjg4y4m4NABbdmuj2qsqetX6T
         /QZnFJQY8IQKSyQ8KkYMevrlctJZx+4PF1CIU7oeALNTfEWqAy3+7cNu3ZQlTN/gD9DI
         WziOi/taQrYdijdRfTXLuaso/tU3GRJaeG9dVhooGM/rc7dTuJTPorF0e2oIYzIpVQ08
         mk7t1ww+ajFF6AYWrEUH5GjVFaJcvH7uxtxXuKRysE61PgHBc5xEgDlr8l82bYpqCNF1
         tqcw==
X-Forwarded-Encrypted: i=1; AJvYcCXji7tM7u30r8hu6vKAOVdC8bjd2LofqFQT6bD0uj6wkZ558ag3isTl7rswbOyKDLj8bprfKd1i2hEh@lists.infradead.org
X-Gm-Message-State: AOJu0YwEEqvHaOSBIoAlNfG4QHhitQZkWx69vv21WB1evWYve5tYg3kk
	rDTm7ApCNrxJHIdXYHC3jxsNwJoyvdP85v5MgQUFsA+2pDu8JZbc9tw2n9UCOmJ9p3nZv6VUqcP
	zcMFQrn4BZaef7tLZAyhSn2R6bY5MIBhrF2RjWCcyt4zQb+VS4B0=
X-Gm-Gg: ASbGncs0jMqU8Isr+Y7KqKu1OJMYpADb4HsuYRjgSfxjZRuzesk3FaTVIeNmy3Q5NvW
	3DWWt1eF8SMLKiKa7pdRHDYeRu/xLCnwj4Wa/eGOg6orxlZLQjCiC/QrUIM0bcVNJYoOG7ppPMM
	D1Zr8z1Db/cPxzHI3JFpzQ
X-Google-Smtp-Source: AGHT+IEygLnAYeWjzW+S7GlO+tNdXPVYglEEMpGoZu7z0weYr0ijWGd/nDLoWQHCNLq1ecV62wSP7JlDjCGoCvDwIJQ=
X-Received: by 2002:a17:90b:3b8d:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-3087bbad9edmr1921074a91.3.1744995716423; Fri, 18 Apr 2025
 10:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <5hdonndzoqa265oq3bj6iarwtfk5dewxxjtbjvn5uqnwclpwt6@a2n6w3taxxex> <0278196f-ecd8-4282-af2c-b63fdceaf831@grimberg.me>
In-Reply-To: <0278196f-ecd8-4282-af2c-b63fdceaf831@grimberg.me>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 18 Apr 2025 10:01:45 -0700
X-Gm-Features: ATxdqUFLrU_XCwdPE4I8PRURxe80HA6-Nv4OIE6wqZIKo0cE22r7FhO60DqBqGk
Message-ID: <CADUfDZqa6dWFgkPX=FHyekKyXBCkm-_3bigcbF2BddUUnste9w@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/062 hang
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.de>, 
	Alistair Francis <Alistair.Francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_100157_595745_A9386322 
X-CRM114-Status: GOOD (  20.20  )
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

On Wed, Apr 16, 2025 at 3:28=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
>
> On 16/04/2025 9:31, Shinichiro Kawasaki wrote:
> > Hello all,
> >
> > Recently the new test case nvme/062 was added, which tests
> > "TLS-encrypted connections". I ran it with the kernel v6.15-rc2, and ob=
served
> > "BUG: kernel NULL pointer dereference" followed by system hang [1].
> >
> >    When I had run the test case with v6.14 kernel, I had not observed t=
he
> >    failure. However, I noticed that when I repeat the test case several=
 times on
> >    the v6.14 kernel, the same failure happens. It looks that the proble=
m has been
> >    existing for a while, and kernel changes between v6.14 and v6.15-rc2=
 increased
> >    the failure ratio.
> >
> > Actions for fix will be appreciated. I can run tests with debug patches=
 or fix
> > candidate patches.
> >
> > [1]
> >
> > [  285.443497][ T1440] run blktests nvme/062 at 2025-04-16 14:41:30
> > [  285.586272][ T1531] nvmet: adding nsid 1 to subsystem blktests-subsy=
stem-1
> > [  285.596633][ T1532] nvmet: Allow non-TLS connections while TLS1.3 is=
 enabled
> > [  285.601564][ T1535] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> > [  285.646164][ T1542] nvme nvme1: failed to connect socket: -512
> > [  285.651941][   T48] nvmet_tcp: failed to allocate queue, error -107
> > [  285.654954][   T65] nvmet: Created nvm controller 1 for subsystem bl=
ktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-48=
56-b0b3-51e60b8de349.
> > [  285.658205][ T1542] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH =
for full support of multi-port devices.
> > [  285.659759][ T1542] nvme nvme1: creating 4 I/O queues.
> > [  285.662596][ T1542] nvme nvme1: mapped 4/0/0 default/read/poll queue=
s.
> > [  285.665446][ T1542] nvme nvme1: new ctrl: NQN "blktests-subsystem-1"=
, addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f=
7f-4856-b0b3-51e60b8de349
> > [  285.763327][ T1560] nvme nvme1: Removing ctrl: NQN "blktests-subsyst=
em-1"
> > [  285.923585][ T1567] nvme nvme1: failed to connect socket: -512
> > [  285.932856][  T120] nvmet_tcp: failed to allocate queue, error -107
> > [  286.035851][   T98] nvmet: Created nvm controller 1 for subsystem bl=
ktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-48=
56-b0b3-51e60b8de349, TLS.
> > [  286.038496][ T1567] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH =
for full support of multi-port devices.
> > [  286.040096][ T1567] nvme nvme1: creating 4 I/O queues.
> > [  286.070856][ T1567] nvme nvme1: mapped 4/0/0 default/read/poll queue=
s.
> > [  286.074999][ T1567] nvme nvme1: new ctrl: NQN "blktests-subsystem-1"=
, addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f=
7f-4856-b0b3-51e60b8de349
> > [  286.200199][ T1604] nvme nvme1: Removing ctrl: NQN "blktests-subsyst=
em-1"
> > [  286.388688][ T1617] nvmet: adding nsid 1 to subsystem blktests-subsy=
stem-1
> > [  286.406950][ T1621] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> > [  286.460711][ T1628] nvme_tcp: queue 0: failed to receive icresp, err=
or -4
>
> Adding Caleb as well I see here also icresp failed with -4
> Should we hadd special handling for -EINTR?

What do you have in mind? As far as I can tell, the only relevant
place in net code that could result in -EINTR is sock_intr_errno(),
which is only returned when the current task has a signal pending. (If
there is evidence to the contrary, I would love to see it! Maybe
tracing signal_generate/signal_deliver would illuminate what's going
on?) Returning immediately from the syscall when there's a pending
signal and letting userspace handle the signal and choose to retry the
syscall seems like standard practice.

Best,
Caleb

