Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F69E7716E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 21:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5gDQjPlS1AG51euFwytbFdQZXGvmJG/Xvn5DXHovM5Y=; b=Ses+4s8tgXbWSV5488c6aFuBud
	mAoNURiBqKO8GxIk2Su9BcC9BZyUCwL0Y3R3pY0YcLV0kqnsCXtneNU+ZcLM3T/pR3JNpdyRF2tqp
	l0OfhDV8n3N+tcWdl7GCuLavF8NCLgHiEO24bW0tDkyo5SbRfjwoK4My+AOsyklE/3grjb2rJKLry
	4kXbkM5YNRiUupRbrHvO8age3m5jo7U+35n1OITbv75gQ4RXqB+FfQLttPVKDDZEuL1yljUNQLkHW
	ibs2kAtldobecRNecyNMNbPe8+Dt4wJLSnaDRjeK5daKkef1Otq2u19QFy6g4LmWTO+2RH5WBL7sz
	PzG/mkzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJJn7-0000000HR6u-1wru;
	Thu, 05 Dec 2024 21:53:45 +0000
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJJn4-0000000HR6V-2zJG
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 21:53:43 +0000
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-515ea144009so368891e0c.2
        for <linux-nvme@lists.infradead.org>; Thu, 05 Dec 2024 13:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733435620; x=1734040420; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gDQjPlS1AG51euFwytbFdQZXGvmJG/Xvn5DXHovM5Y=;
        b=iDQ7B+1s7rWHRIBCYlgz9ofVWc5sr4ThNPJY8e6noK9HkauZtj3p91TbypdjX6kE58
         +L92idZ+vDNhFXhB3z6fLtfXIf4+3iQ+pxSQil2nfb3EjxarYkCuiuIGX5xpgCVOoGxx
         6mU3ktputZnumv8KD/F9yOa3ww7C78QEPO+NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733435620; x=1734040420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gDQjPlS1AG51euFwytbFdQZXGvmJG/Xvn5DXHovM5Y=;
        b=EZc7SRK6mRcC5hgFcMcWlNHuL6sorD7OJZCKgogOR/1+q/h9/ALkJix0YzMqmasABu
         X3I5w6cXdunN7uK5rn4QInBDwmFN1TPcXt4YJi9+lgL6vHQ0rBENzqIOh9Lx+xtfcVh4
         1yAKwG5u5LoyPZfQ1jZK2fCIX/vPyrfQXQaudFqxkaQJxT3VLhlXj3LwejZ+kMMpvBw2
         HmsV+GYRFUHI2J05JydZ5ZX4ise2m1eVRFq7NM7dO0UhdGELyMDKeovHXzQW2L6fFqkT
         9NaF24t5DNZMMBvV4n1UENvg/dsw2jYAMCf64gnHyu4Ix7rlGZjLsBhWBbU+sN1TxisO
         xxDA==
X-Forwarded-Encrypted: i=1; AJvYcCVCLd/0sdDA7Df1hQBd8QpXkJEMxk6a9D93dUVyg9tU0ggrIc6dqrOZ6hozsptWtpiVszo/Dsevodtq@lists.infradead.org
X-Gm-Message-State: AOJu0Yxt2SNYni9pH5hLpLNvWQN2ZgD0q7V2zWt0/EYx0JN/LeowDDo+
	RTQVqMcgufd8zskgZFwQXhGgZofqZ1dXl4EPMHCc1YcVFuKdrWV+8cheKDnf9WWrpgjBZSPfIPw
	YvMPINYph8BSvtgFPfVQfWFpgyDwoHM5gYJb8
X-Gm-Gg: ASbGncsIocwpWPwWhEp9hYeMwKbWLc9AOszHAbOD3ihRNrCb9XELq+ARgpDIz152Nq8
	0QcqVk3FhxfNCVJ7w+2sp7R7Nq2j7b+LSHh/13IYbU3P5Lemyz/9TEUm1NjCy/EtI
X-Google-Smtp-Source: AGHT+IEmvn/lxMBSMBB+tVk5gZMlBqGiKWv8YmxOzM55UzTq1Wc4l5ml/qgygEWL2gTiL1+Ri/LEoggjMxoAIwf7NBI=
X-Received: by 2002:a05:6122:1b01:b0:515:c854:d3c6 with SMTP id
 71dfb90a1353d-515fca0bd92mr1183134e0c.4.1733435620699; Thu, 05 Dec 2024
 13:53:40 -0800 (PST)
MIME-Version: 1.0
References: <191e7126880.114951a532011899.3321332904343010318@collabora.com>
 <20241029024236.2702721-1-gwendal@chromium.org> <20241029074117.GB22316@lst.de>
 <CAPUE2uvUs5dGGmovvHVPdsthKT37tJCK5jDXPMgP18VKhm5qTA@mail.gmail.com> <192d9b75f76.106d874861279652.1491635971113271140@collabora.com>
In-Reply-To: <192d9b75f76.106d874861279652.1491635971113271140@collabora.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Thu, 5 Dec 2024 13:53:29 -0800
Message-ID: <CAPUE2utp0qOiMRNPwtn_gF45f2awa9UyNJ91zmpRbtu6zR5p9w@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Remove O2 Queue Depth quirk
To: Robert Beckett <bob.beckett@collabora.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch <kbusch@kernel.org>, kbusch <kbusch@meta.com>, 
	linux-nvme <linux-nvme@lists.infradead.org>, sagi <sagi@grimberg.me>, 
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_135342_804474_D1650C6F 
X-CRM114-Status: GOOD (  24.67  )
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

On Tue, Oct 29, 2024 at 12:19=E2=80=AFPM Robert Beckett
<bob.beckett@collabora.com> wrote:
>
>
>
>
>
>
>  ---- On Tue, 29 Oct 2024 18:58:40 +0000  Gwendal Grignou  wrote ---
>  > On Tue, Oct 29, 2024 at 12:41=E2=80=AFAM Christoph Hellwig hch@lst.de>=
 wrote:
>  > >
>  > > On Mon, Oct 28, 2024 at 07:42:36PM -0700, Gwendal Grignou wrote:
>  > > > PCI_DEVICE(0x1217, 0x8760) (O2 Micro, Inc. FORESEE E2M2 NVMe SSD)
>  > > > is a NMVe to eMMC bridge, that can be used with different eMMC
>  > > > memory devices.
>  > >
>  > > Holy f**k, what an awful idea..
>  > >
>  > > > The NVMe device name contains the eMMC device name, for instance:
>  > > > `BAYHUB SanDisk-DA4128-91904055-128GB`
>  > > >
>  > > > The bridge is known to work with many eMMC devices, we need to lim=
it
>  > > > the queue depth once we know which eMMC device is behind the bridg=
e.
>  > >
>  > > Please work with Tobert to quirk based on the identify data for "his=
"
>  > > device to keep it quirked instead of regressing it.
>  >
>  > The issue is we would need to base the quirk on the model name
>  > (subsys->model) that is not available in `nvme_id_table`. Beside,
>  > `q_depth` is set in `nvme_pci_enable`, called at probe time before
>  > calling `nvme_init_ctrl_finish` that will indirectly populate
>  > `subsys`.
>  >
>  > Bob, to address the data corruption problem from user space, adding a
>  > udev rule to set `queue/nr_requests` to 1 when `device/model` matches
>  > the device used in the Steam Deck would most likely be too late in the
>  > boot process, wouldn't it?
>
> I've never seen the corruption outside of severe stress testing.
> In the field, people reported it during and after os image updates (more =
stress testing).
> However, as this concerns data integrity, it seems risky to me to rely on=
 a fix
> after bootup.

Since limiting the queue depth to 2 is only needed for a small subset
of eMMC memory modules that can be connected behind the bridge, would
it make sense to apply this patch, but add the kernel module parameter
mentioned earlier for impacted devices?

Gwendal.
>
>  >
>  > Gwendal.
>  >
>

