Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F1CCFB446
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 15:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bm7Q5e2TqBLMXqm2ZP9eEQwS8WDHemwrw3echcOLzEc=; b=YXKGlqYJtXNW+qHRgZTd+ALKHT
	/Fe/sCFwalWsfC3VyDHM3NL1R7Nof0cNWnEAqXPbeH3NTQe4Ig3+fQiMkOCiv8qoihyu0elxh9GaJ
	v0TbukrP3m3pqj0PDfyTB40NO1IhlCFvsVzrV6lLW6stRMJXu6N6r2pgDK6u08k2Qo5ZcnFjvJzQZ
	oaktiXitClNmJ1kx0dbDxAlXA99yNJXKhYnO2dSitqghPRproBba8M0t43nKftYwmVz8qkg16qRF7
	uv/a1T29LrwqrKoHX4r9d1xzS6B499KCXmyEdmJBQMGKMWMxaIMQwTwnwrWSA74WhxKp8Ebn7Ywdr
	1wH6Zpcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxq82-000000033oM-3xYq;
	Mon, 07 Oct 2024 15:58:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxq75-000000033di-1oVW
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 15:57:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728316653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bm7Q5e2TqBLMXqm2ZP9eEQwS8WDHemwrw3echcOLzEc=;
	b=A4qaVeJbByYm/pjzHvRRIQLtyEXkWvy7hAPsgaEx1/yAFWOu1crkExoXQNGoKuXSxJQTM/
	22ym8AGz1us/iQbleNzox9NlRmUC0zb+PMt2JgkJRFBGDx8IPOFKCZgQD4aXclSj8Lg2Fj
	nVIkMfQFRSWhCFsqpSLrBOLVacD5Ac0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-NxUOnn4HOhqG7VYyz1M23A-1; Mon, 07 Oct 2024 11:56:11 -0400
X-MC-Unique: NxUOnn4HOhqG7VYyz1M23A-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7ae6f3905ecso542988985a.0
        for <linux-nvme@lists.infradead.org>; Mon, 07 Oct 2024 08:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728316571; x=1728921371;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bm7Q5e2TqBLMXqm2ZP9eEQwS8WDHemwrw3echcOLzEc=;
        b=asW4HfzBv4tkwBYbykj3DGUqGqITeE6LPzKPx+sZyS5WDIC5cMSYYLMxgfmPoAO58z
         mjNPuLiW9nJJdXlmMYHuafWlmT2OQfv7kHzLttySp/KY4PDmeJk+Eks3fi1UtdXIIfug
         zfvI4m/TJrQzIfx4YBlXjTqMLkT9xMqnASVKWa75BXoVao9lC5MFnofUk3oEEm8VTE4V
         Qn0AmSgbJ8QM7uCJKCwAdmfuRJAmvKCGihmtDXCeA6u/iPYtrQkfcWFYaBF+akrDT2qi
         9zQ+5+3itE+SlxETH8zdd+aI7DpIvHDLzlUKRs5DLpqH4wMYun6ZFTbIwDvr2xMBpHol
         h+lw==
X-Forwarded-Encrypted: i=1; AJvYcCVMI0ZwN8wIkRbqq+/KFMnoLn/OFuo3fpbnM8I9jDbcAZozy1V6cciEk6rXyuksn+itUQWkKksuneOC@lists.infradead.org
X-Gm-Message-State: AOJu0YzfURf7sWLHnRsQScwzm44WqtAiD419Rrb8D09GH+l55vR4Oc5q
	A30/9HrCQSKWYmPz0kt+KtsjwjfG3H+5pfcvc9ki7+wphZTESqi6WfnEfLRJePMrjc1yyrCrgC1
	8drfD8KeXaPynvLsOf+cU7UGwaeu19TMpBGTDI1dWs6jDB8mcoQb5mzU3UhrDfC6D
X-Received: by 2002:a05:620a:254f:b0:7ac:b197:4037 with SMTP id af79cd13be357-7ae85f306e6mr14026885a.18.1728316571311;
        Mon, 07 Oct 2024 08:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAzAKYz0ZS7tXQUGeLY0pHD59Y15IF+4k7x4YHdwTXgOesVYvBg/pfvgoybt+oVcFmgFp4xw==
X-Received: by 2002:a05:620a:254f:b0:7ac:b197:4037 with SMTP id af79cd13be357-7ae85f306e6mr14023485a.18.1728316570965;
        Mon, 07 Oct 2024 08:56:10 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75635c9dsm264549385a.58.2024.10.07.08.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:56:10 -0700 (PDT)
Message-ID: <5325b263817024d0ca617b114f0a30aab0e0e2bc.camel@redhat.com>
Subject: Re: nvme: machine check when running nvme subsystem-reset
 /dev/nvme0 against direct attach via PCIE slot
From: Laurence Oberman <loberman@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: "busch, keith" <keith.busch@intel.com>, linux-nvme@lists.infradead.org
Date: Mon, 07 Oct 2024 11:56:09 -0400
In-Reply-To: <Zv8G8l5cyzDRwLJA@kbusch-mbp>
References: <b73005ac327784e740bb6b362870c15d0c7788fa.camel@redhat.com>
	 <Zv8G8l5cyzDRwLJA@kbusch-mbp>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_085735_564562_D411C579 
X-CRM114-Status: GOOD (  24.12  )
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

On Thu, 2024-10-03 at 15:04 -0600, Keith Busch wrote:
> On Thu, Sep 26, 2024 at 05:11:05PM -0400, Laurence Oberman wrote:
> > It was reported to Red Hat,=C2=A0seeing issues with using a
> > "nvme subsystem-reset /dev/nvme0" command to test resets.
>=20
> I really dislike that command. The side effects are overkill for the
> pci
> transport...
> =C2=A0
> > On multiple servers I tested on two types of nvme attached devices
> > These are not the rootfs devices
> >=20
> > 1. The front slot (hotplug) devices in a 2.5in format=20
> > reset and after some time recover (what is expected)
> >=20
> > Example of one working
> >=20
> > Does not trap and land up as a machine-check
>=20
> <snip>
>=20
> > 2. Any kernel upstream latest 6.11, RHEL8 or RHEL9 causes=C2=A0
> > a machine check and panics the box when its against a nvme in a=20
> > PCIE slot
> >=20
> > [=C2=A0 263.862919] mce: [Hardware Error]: CPU 12: Machine Check
> > Exception: 5 Bank 6: ba00000000000e0b
> > [=C2=A0 263.862924] mce: [Hardware Error]: RIP !INEXACT!
> > 10:<ffffffff8571dce4> {intel_idle+0x54/0x90}
>=20
> So this wasn't failing before 6.11? As Nilay mentioned, there are
> some
> changes on how nvme subsystem reset is handled. The main thing being
> this ioctl doesn't automatically trigger an nvme reset. I expected
> delayed recovery might happen, but machine checks are not expected.
> If
> this was working before, I can only guess right now that the previous
> behavior was accessing MMIO and config quicker and triggered a
> different
> error path. If you're successful with the PPC patch reverted, I would
> be
> interested to hear about it.
>=20

Hello

Quick update about this.
I went back all the way to 6.8 and this still happens.
I started to think that these HPE servers were more susceptible to the
machine checks on the PCIE state changes.

So I tested on a Lenovo and still had panics.
I do not think this is worth pursuing given that Keith already
confirmed this is not recommended and way too heavy handed on the PCIE
path.

I have told the reporter of this that they are not to use this type of
fault injection on directly attached nvme devices.

Thanks
Laurence


