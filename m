Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6D6D3A678
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 17:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gPWsSrE6fId8nXujJMzW7eCSsaEFFN3yolmO5dWwWUY=; b=TMdcXpnqQ4b4UZVAnHhnhDgEQA
	/etRJHsVA0HueLKi4X7X0lfozRYjTB/Kk6Be7htAB3PF/WRMjltkQaXbBbihCJbW46//Zs6W442Ef
	4dZzTanM96CSjtbeKtYkWll4yWq/MNw3DKkrqTwCA2noGAzgXmgQnb0yRmIluJuUVRFe87s7HRwix
	uecKInWIsQWg5QDHAos9HP+v64kgzIX1bDIHeIN/6ZBjwhapiMMgJyzNX726fYN64e/Qm/owygAMU
	Kc2Oy+va3PDNqUodSkJPjfj68UVpV+ySosBOKY4at5mdNFsUfkPEM9MU228ORZ8FCc/pmIkKBCBy7
	wWq68iGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5q9V-0000000FIsd-1fDL;
	Tue, 29 Oct 2024 17:37:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5okn-0000000F46A-2vZT
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 16:07:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730218051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPWsSrE6fId8nXujJMzW7eCSsaEFFN3yolmO5dWwWUY=;
	b=ASPdwKH6EChMODp2DKVrilxqvmKE49dnM5x+rCBvk7AEZBdsupL7Phr763IdxxTXy/ELYG
	PphXev2o2yvhU981M8QHbUAR5g8bu2d3FY9fyC2qSFdbrlrsRCCQTj3gH/MERG8Zzai3cM
	xhru6aniMovaUIjCjaMTGl3Vxfqir7M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-jQB-p4o1M1il2uE9D2JG8g-1; Tue, 29 Oct 2024 12:07:30 -0400
X-MC-Unique: jQB-p4o1M1il2uE9D2JG8g-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b16c9a84efso969476085a.1
        for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 09:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730218049; x=1730822849;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gPWsSrE6fId8nXujJMzW7eCSsaEFFN3yolmO5dWwWUY=;
        b=ESGzVn3JuHSyerR8QlJBchj9zI0aYY9G43G3J2F0tu39WYvLMWdG5WuysBYB8HnBeT
         vo2DwfoP1CYkFBRuctxavzr/xfCTclCmjZAcvc6PepqRL38xTkEd0Vl3OfR5zCPbq/9Z
         8fTb0YiVNoCBw5JKRu77wgLuB8bW5tL439MNLhnsNdbMbdjHzHpDVE/tM8Ykur63EPfB
         1S3xX0GYJX2PRWCghKEnXRqUEl8DHYB1rGX8w91xXH/2l4+fx5DGOYUMxIFvi97sy9zc
         1ol8LIrhuYvK+f6J4ayHYOFUs3AceOkdIPRK7gsBN5h+3H/FR4eO2c9BM/eBkjxOH9bV
         nNmg==
X-Forwarded-Encrypted: i=1; AJvYcCVFpApMrit9JmXwqo8L3WcL+Gq/ChxN+NtDU4XtzpQ+eCUP6wiFz711UqUHCMIMawRWoPqW1iFcJ/LD@lists.infradead.org
X-Gm-Message-State: AOJu0YwXmCAG/kuOjOj7t2O5hP8Tgoh1kf5ypbr8LC9Qv1BEY0kW9cda
	KVDFlAEqNBxN2iy4fPH4ZJItLptaB4W0FWzWwXyMpjYtwAxoeMwXyrb37XFbzFgM9GhiLFtY0nT
	2TEUtIv0sy4Q2vUBMH7RWKfIZa5RCPuqHCCJx4RPbJ7LVna1wG15O2HyFb6LbNRIf/SZ/icxm
X-Received: by 2002:a05:620a:1928:b0:7a9:c333:c559 with SMTP id af79cd13be357-7b193f3eeb3mr1704993585a.48.1730218049310;
        Tue, 29 Oct 2024 09:07:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcDSpQPh/AMUuxHclMTbzl5cRstw853LlDTbgeVfhNs4Yx8ubXHBK1kCxlWOzOKS4mh7YiGw==
X-Received: by 2002:a05:620a:1928:b0:7a9:c333:c559 with SMTP id af79cd13be357-7b193f3eeb3mr1704989385a.48.1730218048810;
        Tue, 29 Oct 2024 09:07:28 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1aee814e2sm2055785a.48.2024.10.29.09.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 09:07:27 -0700 (PDT)
Message-ID: <bdd5b88fbd3325ae16ec9791b0719c373bbefed9.camel@redhat.com>
Subject: Re: nvme: machine check when running nvme subsystem-reset
 /dev/nvme0 against direct attach via PCIE slot
From: Laurence Oberman <loberman@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: "busch, keith" <keith.busch@intel.com>, linux-nvme@lists.infradead.org
Date: Tue, 29 Oct 2024 12:07:26 -0400
In-Reply-To: <5325b263817024d0ca617b114f0a30aab0e0e2bc.camel@redhat.com>
References: <b73005ac327784e740bb6b362870c15d0c7788fa.camel@redhat.com>
	 <Zv8G8l5cyzDRwLJA@kbusch-mbp>
	 <5325b263817024d0ca617b114f0a30aab0e0e2bc.camel@redhat.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_090733_829577_AEEE3DA2 
X-CRM114-Status: GOOD (  33.29  )
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

On Mon, 2024-10-07 at 11:56 -0400, Laurence Oberman wrote:
> On Thu, 2024-10-03 at 15:04 -0600, Keith Busch wrote:
> > On Thu, Sep 26, 2024 at 05:11:05PM -0400, Laurence Oberman wrote:
> > > It was reported to Red Hat,=C2=A0seeing issues with using a
> > > "nvme subsystem-reset /dev/nvme0" command to test resets.
> >=20
> > I really dislike that command. The side effects are overkill for
> > the
> > pci
> > transport...
> > =C2=A0
> > > On multiple servers I tested on two types of nvme attached
> > > devices
> > > These are not the rootfs devices
> > >=20
> > > 1. The front slot (hotplug) devices in a 2.5in format=20
> > > reset and after some time recover (what is expected)
> > >=20
> > > Example of one working
> > >=20
> > > Does not trap and land up as a machine-check
> >=20
> > <snip>
> >=20
> > > 2. Any kernel upstream latest 6.11, RHEL8 or RHEL9 causes=C2=A0
> > > a machine check and panics the box when its against a nvme in a=20
> > > PCIE slot
> > >=20
> > > [=C2=A0 263.862919] mce: [Hardware Error]: CPU 12: Machine Check
> > > Exception: 5 Bank 6: ba00000000000e0b
> > > [=C2=A0 263.862924] mce: [Hardware Error]: RIP !INEXACT!
> > > 10:<ffffffff8571dce4> {intel_idle+0x54/0x90}
> >=20
> > So this wasn't failing before 6.11? As Nilay mentioned, there are
> > some
> > changes on how nvme subsystem reset is handled. The main thing
> > being
> > this ioctl doesn't automatically trigger an nvme reset. I expected
> > delayed recovery might happen, but machine checks are not expected.
> > If
> > this was working before, I can only guess right now that the
> > previous
> > behavior was accessing MMIO and config quicker and triggered a
> > different
> > error path. If you're successful with the PPC patch reverted, I
> > would
> > be
> > interested to hear about it.
> >=20
>=20
> Hello
>=20
> Quick update about this.
> I went back all the way to 6.8 and this still happens.
> I started to think that these HPE servers were more susceptible to
> the
> machine checks on the PCIE state changes.
>=20
> So I tested on a Lenovo and still had panics.
> I do not think this is worth pursuing given that Keith already
> confirmed this is not recommended and way too heavy handed on the
> PCIE
> path.
>=20
> I have told the reporter of this that they are not to use this type
> of
> fault injection on directly attached nvme devices.
>=20
> Thanks
> Laurence
>=20
Hello

Finishing this thread off but have a final question.=C2=A0
Bottom line is certain server hardware sees the nvme reset command
create a machine check for PCIE plugged NVME devices going back quite
far in kernel versions,  and we panic.

As Keith had said, that nvme reset command is too much impact

There is a final simple question for M2 connected NVME devices.=C2=A0
Are these expected to auto-re-connect after an nvme reset is issued.=C2=A0

The complaint is the following

nvme subsystem-reset /dev/nvme0=20
Device is disconnected as expected but requires the following to
reconnect

echo 1 >  /sys/bus/pci/devices/0000:02:00.0/remove
echo 1 > /sys/bus/pci/rescan

Then it is reconnected.

Thanks
Laurence


