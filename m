Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452ECD73EBA
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 03:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PuOkqOdYTxY1bONa1kAc30uYaDpfI4zaydafwOurEVY=; b=spbVDdHBir6vfPxPHWJxWNJCAG
	zEFiq2W4gAq6jf1uHHnLdR8FxZv0ITDld4EWu+8jddtb5XycH1RFjkXxovfqM08VLIXofdFfIEIr2
	MS++HaCKhBCGboa45bEuEvuOtSAvNj4CSGTahwQ6tLTlaU4oleYRKiqli0D3SwoOXVlNnafl3zINp
	ztnbOySDs17HpZ26JBak+lXis4guD7faa6wI3iDY6sMz8p80qL6zpEGGlFFN4lA+kEYRSmwHaMmLT
	drWYjzjrek97JBYHslb147oIEnCq9ZDEOLrIQ54bP+SbeCuCepTPcaq+Q6+/AH0ZxeUeiz8Bbnb1b
	kWqBeorw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlfLY-00000000xx6-22LX;
	Fri, 30 Jan 2026 03:39:00 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlfLW-00000000xwl-0Pj5
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 03:38:59 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-34c708702dfso886101a91.1
        for <linux-nvme@lists.infradead.org>; Thu, 29 Jan 2026 19:38:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769744336; cv=none;
        d=google.com; s=arc-20240605;
        b=lknfAF4/QKA3NDOitCsvDxMaSg+UENMKj3wU2iJY28OakdPCDKubcsXvXDpFZbn/Ti
         e14mDdkA7qYtHeAtjFu0d+SFt8PyCMnhElP0xWUVYctRKYBWc2TxFXzstty5SoJj7N+s
         +fd8cA+FjaoWFH8MtmbE1NmMKtoVXepWh7/WAtNJv13h5veWVcpdDUoT2ukLSWjZkYXx
         iqX1PHv6CrXyNsL0Wy9spx9AvoRl+OGIdceLGZpIhlnnn9IBdMuEh7wnwmJhICyEtuOO
         5oG+aoS6RPoLuIiVcSFZGWFabmGzwRXfpDO5+9JK70WQG0Yqqv1M0fTnG99QsWt/UcvB
         7+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PuOkqOdYTxY1bONa1kAc30uYaDpfI4zaydafwOurEVY=;
        fh=9SvMVTyLne5kT20uRdau6elZqUmJRtRj+7K1M1VhCxk=;
        b=QUvOQh3wENwXLPZTS1/pXVxt6gDPVRC3UuCpxAhimUpwxmM2oMQvfRwNVcUbA0lL3R
         2681ZsSJZKeM6vuC6R82UK3t22zoZ95Mxx8WMHHB1QmU+aaOZuXg6FB96KKHUqCFrQWW
         0pXttAxZKQWfOLzPCSqGrYXLWVLn2gkxRTY2ni9HgdGWRMlTqD/NDw8yb7+mF+gmlEKR
         jTTLcuYHLgVdjDXhJXGhfAL7M0rfj3YVykhiiafLbbsaG1bCRFOcdz7oClJ41pNpkN3A
         V23rMlphjIR/twCUPJLhtf9RAksa3l0mmg2h2KVTwka/vCOQTyDCJD90xPTl7XAFPlT2
         peJw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769744336; x=1770349136; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuOkqOdYTxY1bONa1kAc30uYaDpfI4zaydafwOurEVY=;
        b=hbF/LrYlJV/Ul1pScGYdQW8U/EKh90gEnt9+uwuU/XQHCEOJpQooPoNzjUrrQ6sBEr
         hbmKVL0yYrq7Nl5AzrKWt5mwslTONm7th2ZLMzqfu8ZxYQb3huHzj5T4+YwIsWGTM1rP
         jkI3iBGhYVhb+7/t16IIaJ6DbRE1CslI8nfeAAHrfDgw1rD4n0OIN2+JAFaQ3k9sC/WW
         NwBbYzuz6QhpQK2yNwdF9rEP3k+CRmTtw/uSf7PJM+FG0Le50V/XMyUe4N1Q94RaUuM5
         WKw06xJAn2iLz4Vmx1aYx58HAQJDTl1VrCy83PMWh6JnuoMAqv/S5xx5/5KJ8z41dLBA
         WYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769744336; x=1770349136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PuOkqOdYTxY1bONa1kAc30uYaDpfI4zaydafwOurEVY=;
        b=J/B4UPfxNuRB3u+6S/2+y7e36je5fE6KeYloJTv0ebJFxryXQLvMxF5bq2oYl6Edib
         H0+dxSVhds1QTmnB4tJ5/cKuUeFmyuYdZZEVmyPTuqYBM00YDN3HWDiyE0zkramgcd1Z
         +Uf4FHn1xQVALm32K5nsXfQUrbRuG1GyDqaPhZ+yDoiN6EIIuadjRZsqdHXYXEuzsHWy
         k3N3QJ/vRIFzJjJiHR/gbaG2DTgL3AnpzuMMZ0c7CU6Qx2n+APC1mraGDsCIL4yEuF9T
         /VzybU5iIHXSrn/disGr7qGEV3aq0ndrehf5eJ9JqKHxIObAg4fcKUsHxo46nB+XUUzT
         eiIw==
X-Forwarded-Encrypted: i=1; AJvYcCUt9GwH9aWz2f3AtBxZ9qCp965yUhiT5ASceqAcYflTWwlnW1nVzK5jkLkPxStS0TCnkEdr6fe2oUlH@lists.infradead.org
X-Gm-Message-State: AOJu0YzJ4/o/iPFjg0y9NuogRA1tmcZS607Ln26SGXVNQj6qchyZAtzs
	fWDMjWGJZ1Fl1x8zgMQl+GBdf7xwANA+pT343iSE0gl5BwjIJpnYl7NwsoYFFOjsjyuo6Kf0CnO
	vd0z9GPdIHRzZzWSNE5a7qae5Pm1Z4xM=
X-Gm-Gg: AZuq6aJZsfMovIVGRPJeiGSnKpCeUaPNofIpTwoxs/ZLTCVgzOlQj5iZzzWKGygNkK+
	SM0Bjmp8UdHo4c0T2IjY3+lKK+RORzw3KyXquAAj/OGXJsJdzDzcaSS0gi9r4ZBSy5+eUp2PvRb
	10srpN9Z0J5EHpR4N8IcKEj+6FiMInM6WeF+JuwGxotRIVClukDS1RsuLPwragsxpVh3Fxfi3A2
	Bkxc/8c+uLeRRafF8wT8VqiGJzj5WIg5QPfATEYpAouy2uFZY3CP4oZGLXbq5pF1CO7fLDCKQ==
X-Received: by 2002:a17:90b:2b8e:b0:32e:4924:6902 with SMTP id
 98e67ed59e1d1-3543b3132f4mr1302858a91.3.1769744336081; Thu, 29 Jan 2026
 19:38:56 -0800 (PST)
MIME-Version: 1.0
References: <1a3d4d2d-db0c-4358-8229-c7d6f5e83bbe@grimberg.me>
 <20260126064248.591202-1-ioerts@kookmin.ac.kr> <DFZFBKPGNCD4.3EKJ4G1H2GBDC@bsdbackstore.eu>
 <DFZG4OIFIHO8.313E3KOTXSDL5@bsdbackstore.eu> <DFZGZT9C3D6B.346BT9Y4IGVFB@bsdbackstore.eu>
 <CAMX6_QHuFJQXd=nSaAk6OxEvwfw8Q1SC3G8Cv4_Sfp8KmcYDNA@mail.gmail.com>
In-Reply-To: <CAMX6_QHuFJQXd=nSaAk6OxEvwfw8Q1SC3G8Cv4_Sfp8KmcYDNA@mail.gmail.com>
From: yunje shin <yjshin0438@gmail.com>
Date: Fri, 30 Jan 2026 12:38:45 +0900
X-Gm-Features: AZwV_Qj0hEJRwlyIpx1n5vD5EFzPb6ZGc2NOZWbaLiJ32PLJKp2vc9JYVGSRbbo
Message-ID: <CAMX6_QG2aKsLLqF8OLtcASN9HY=NZhpLhG9RnBkfDuu2SHdNag@mail.gmail.com>
Subject: Re: [PATCH v3] nvmet-tcp: reject H2CData before ICReq
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, 
	sagi@grimberg.me, gregkh@linuxfoundation.org, security@kernel.org, 
	YunJe Shin <ioerts@kookmin.ac.kr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_193858_165903_596DF3CC 
X-CRM114-Status: GOOD (  15.49  )
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

i agree have been already been fixed by commit
32b63acd78f577b332d976aa06b56e70d054cbba
(nvme-tcp: fix NULL pointer dereferences in nvmet_tcp_build_pdu_iovec)
but i think other thread([PATCH] nvmet-tcp: add bounds checks in
nvmet_tcp_build_pdu_iovec) slab oob is works

On Wed, Jan 28, 2026 at 9:45=E2=80=AFAM yunje shin <yjshin0438@gmail.com> w=
rote:
>
> Thanks for letting me know. I'll check it.
>
> YunJe
>
>
> On Wed, Jan 28, 2026 at 12:17=E2=80=AFAM Maurizio Lombardi
> <mlombard@bsdbackstore.eu> wrote:
> >
> > On Tue Jan 27, 2026 at 3:37 PM CET, Maurizio Lombardi wrote:
> > >
> > > Nevermind, now I get what you mean: you can hit the bug if you send
> > > H2CData after ICReq but before the execution
> > > of the connect command.
> >
> > I was able to reproduce the crash:
> >
> > [25362.399746] BUG: kernel NULL pointer dereference, address: 000000000=
000000c
> > [25362.403368] #PF: supervisor read access in kernel mode
> > [25362.405451] #PF: error_code(0x0000) - not-present page
> >
> > [...]
> >
> > [25362.430592] Call Trace:
> > [25362.430945]  <TASK>
> > [25362.431250]  ? show_trace_log_lvl+0x1b0/0x2f0
> > [25362.431910]  ? show_trace_log_lvl+0x1b0/0x2f0
> > [25362.432507]  ? nvmet_tcp_done_recv_pdu+0x299/0x2f0 [nvmet_tcp]
> > [25362.433285]  ? __die_body.cold+0x8/0x12
> > [25362.433810]  ? page_fault_oops+0x148/0x160
> > [25362.434388]  ? exc_page_fault+0x73/0x160
> > [25362.434953]  ? asm_exc_page_fault+0x26/0x30
> > [25362.435573]  ? nvmet_tcp_build_pdu_iovec+0x4c/0xc0 [nvmet_tcp]
> > [25362.436357]  nvmet_tcp_done_recv_pdu+0x299/0x2f0 [nvmet_tcp]
> > [25362.437113]  nvmet_tcp_try_recv_pdu+0x1ef/0x2d0 [nvmet_tcp]
> > [25362.437856]  ? sched_balance_update_blocked_averages+0xdd/0x1a0
> > [25362.438672]  nvmet_tcp_io_work+0x70/0x8c0 [nvmet_tcp]
> >
> > But it appears to have been already been fixed by commit 32b63acd78f577=
b332d976aa06b56e70d054cbba
> > (nvme-tcp: fix NULL pointer dereferences in nvmet_tcp_build_pdu_iovec)
> >
> > dmesg output target-side:
> >
> > [   54.436869] nvmet_tcp: queue 0: H2CData PDU received for invalid com=
mand state (ttag 43981)
> >
> >
> > Maurizio

