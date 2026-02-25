Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B6EEFD23D
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 10:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P+nn7GxNNTTR4z83VRm4nDPbYz8l5IDhZ9xoBNCdUfk=; b=eD+MPe5NPa3FwbLSs6ybZ8YI7+
	bIYxtBuI7gLz+KNvsK8gU4eRykXn/X9tYUD8RGaA4CLeTJ+4Fuld+AqfIDCJoJ0Ni1Zc6VfiTyCMo
	8qfRFovclSWEkdjVZR3ORo8BzZtE3y1glj12PQSqXxlhZHjZyWuT1Kvy6ScVnYo5FsI4p6JGJVv0V
	Br0HYhNMVqr7hnULA7Ro8+3HgH69Gy29+uywUeQjLlnEICPIv2ohIVziEcU0Uv+Qr/Wk0nswq9Cao
	SLvO+ooddF5wf6lpm9HmIdjLnx9jb3OrqMox9UeXJq/TFoJPoj/H7dtieTZEhVd4IUvqEsOS3xzB4
	KcHteqZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvBoX-00000003kJZ-2LmD;
	Wed, 25 Feb 2026 10:08:17 +0000
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvBoT-00000003kJ8-3VhC
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 10:08:15 +0000
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-3870cbd6c40so57338921fa.0
        for <linux-nvme@lists.infradead.org>; Wed, 25 Feb 2026 02:08:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772014090; cv=none;
        d=google.com; s=arc-20240605;
        b=H35lla2Fb6GRqgA6J0VtZCDGlRdJNj9cNV0ES1G2/ps1SFPcgWbKQeKRsdyzZBcaAh
         /ctY1bKUI+aTgfxkQod5ZK0HpeZA8rSVIDxRrI8qTPSmCPN51wB+nTK3QxmWIfIm3PiH
         MEFyeSq3G/9ItPi+4KZrVbY8cQP54cGTqf50Vs8FyD6L1kbrbWx8GdKDhp7me6qi9IBd
         qDSNE7lxw5FBK176sj5p5TnJ5XFrCxfY5XJkUO72uUUZtYqT+A1VP1CcmYbBpsIbbuxv
         aVAVgYAE0fsNgok6sD2NeLhUw02iM/GWHFvA3yrG474zHkAZlEnjir0mbs7+o/zkBLkF
         k3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P+nn7GxNNTTR4z83VRm4nDPbYz8l5IDhZ9xoBNCdUfk=;
        fh=NyofgHGMY+IqO7QE9VVPypewzObtp/H+hvSirBIJivs=;
        b=F9/XuAWMg7Z+MD08/qg/VyZGgk6cUDSRfOzBx8MRN6JGcYApHqahl1GH+qPmvOENPa
         9+A+SFblJlqYmExht3cA86mxXsB/XaGmaRgXRU2Gqjs6McnCWq+66P6dbyedhLntr7yu
         a9amLRWxG4bLs/GhLr7/BLAaBvBSesJ0L9SF3Vx6x/ZBkDH2DO4jBeqOYZXzjucGAHWl
         hCMyoPaBg6IMV5I25jUawYEf8S6zRzrjazGD75e+VakDUUgQZZJRwZ9zs8BZpBUjtQ6I
         YDpOlIss3nRpbHrXt77n7oY0KA71tXBvty5WzVrbTE5i7q+eud8zur1cSTcZYa0g+ZEu
         IKCg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1772014090; x=1772618890; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+nn7GxNNTTR4z83VRm4nDPbYz8l5IDhZ9xoBNCdUfk=;
        b=e1GCeVs3k3yiJt9dG+AXM6srYgE16FTS6BAqHw++2x1dV4TRgNAVhx02sBORg4FFZT
         zIUtHR+9WN2CJ2MnzRCW9gHoSuEYcfA3IKKRkV9aKJ3pAtb9bkgwdj5GwMa/gehLSEqM
         Gatt92i2cdDVY3t1arSckztLD6aBlbISJh00EAKudzbhnqpVzsHkrCp2IBDG+WdOdZHz
         Ke7p6GEEpMcTfXOZ/Z+bg3zLKqDAfntqLKvtQfy4Su03UG2CLHoJZ7UAkolOXSZpDrgc
         wR2RLUt7eL8uCuO3QqKWJwsboS8WhTNcgg/YpKGkTIfBCswXBVglyTK6DIbUBGU0iH69
         KzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014090; x=1772618890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P+nn7GxNNTTR4z83VRm4nDPbYz8l5IDhZ9xoBNCdUfk=;
        b=dDv75SMSlvJfhZR0TTPhx6ZPvIs+3lBYtClpxvJvqzmWe9kcgvAcsWJ/kWVHec7n05
         oDa1ppki5VxqH8izlRJcKAolOCaMhzej/IJK8ssh52eDeczpD2XdAzEQof8ma+nfTfoC
         oExcnPKAO8aBzmmm55lC3sizfIzfx6Jwyutukuts70pSrqUVajfZKQza1ih7mfx3fdFI
         r9LTPYqokOJzfFxCiJwg9Ac0JNictBUo/oSMl9XCE1cCtzHUa517mE7P2MyYlN2OPTxi
         MQzrCQ0HWJMyPNWWoiDJHsATdwtAIQIl3s5vebTBZUnot2+zo1ULYaq/vQ0n+O8d7Ybf
         W+Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXjRNeI5tTp0VJ79jlZDzQD+tvhUouZ+5MUOKZC2N/9RMVZuN/JE7SGWGgaffQlUZKAnvD+xV/a896U@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+VnqEn2/P6m1x48GXjR0ogLEPpupufoHq5FUncgy3FAovYfwS
	e13b/Sabux+sot/lbZUbjJH7chL7ezQPJY/VG0jjhWeR/4ltmGmyeK1dVyfrCxbAVVuIo0YXzbr
	Y+CVXkHG+UZXCjWrJ/BnePejO1eTKTqqJl/xbo90g0JzdpEjdrrwc
X-Gm-Gg: ATEYQzwFzzUq5uboDDD25JTFStZcV7ebzA+17BpT8gAimGGhgTYU45+yO+IAUa2TgmV
	nShPMuc1IhHKZ7shgs9AfOxmvfPBV0Cn7Y0Y87fgxXnpLj+zomZqHEEXqWdUT19OOH9rbK4TwAZ
	Nc/WV70uwSsQ2QCY6jZH4K/WP4KB+HxwfkyBZtebVQAdU07jbPg6rNMAThIAj748k6vsSdMDadY
	lbtD4I0FYExxVVitQKlWC9hBTL6BSAvUtRESo741cQluumCdB6mgZoLKln1ngrz/J1fKzZcXzku
	rKeatyIGeCVSPTN3erjstwVKbQxRo+XzfT4+P+5SY6GXA6jJT56cj+7BcVH21PDlwyHu
X-Received: by 2002:a05:651c:324e:b0:387:421c:3cc with SMTP id
 38308e7fff4ca-389e2bb0ca7mr6069021fa.16.1772014089948; Wed, 25 Feb 2026
 02:08:09 -0800 (PST)
MIME-Version: 1.0
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local> <aY77ogf5nATlJUg_@shinmob>
 <CAJpMwyis1iZB2dQMC4VC8stVhRhOg0mfauCWQd_Nv8Ojb+X-Yw@mail.gmail.com> <40edeeec-dbc3-4aef-ac86-691e1ed2ed06@acm.org>
In-Reply-To: <40edeeec-dbc3-4aef-ac86-691e1ed2ed06@acm.org>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 25 Feb 2026 11:07:58 +0100
X-Gm-Features: AaiRm53Zv-ldie7aCzcsDbQaCCWr2F8I9cWxTChkMF5C5q2noC0qJ-esR5e6yic
Message-ID: <CAJpMwygzTcBnKVp=bJWZpW9X5JdcP9Lj4H1BRBu2bNV_kGyDQQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
To: Bart Van Assche <bvanassche@acm.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>, "tytso@mit.edu" <tytso@mit.edu>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Christian Brauner <brauner@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
	"willy@infradead.org" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	"amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz" <vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_020813_969337_96C08C1D 
X-CRM114-Status: GOOD (  13.85  )
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

On Mon, Feb 23, 2026 at 6:08=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 2/15/26 1:18 PM, Haris Iqbal wrote:
> > A possible feature for blktest could be integration with something
> > like virtme-ng.
> > Running on VM can be versatile and fast. The run can be made parallel
> > too, by spawning multiple VMs simultaneously.
> Hmm ... this probably would break tests that measure performance and
> also tests that modify data or reservations of a physical storage
> device.

Performance related tests can be skipped when running in a virtual environm=
ent.
Regarding data modification, if the tests do not involve any crash or
reboot, then the VMs can be started in "snapshot" mode. This gives a
number of advantages.
a) Data modifications will not persist once the VM is shut down. This
means the disk will be clean for the next test cycle.
b) Using just a single set of qcow files, one can bring up any number
of VMs in snapshot mode. The data written while the VM is running can
be safely read/modified, but it disappears after a reboot.

>
> Bart.

