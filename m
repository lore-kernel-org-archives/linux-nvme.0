Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C843C48291
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Feb 2024 09:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p9LIYBr/SBBvGlqKN3eoDiC5chZptPGHdLPb7HiYj8w=; b=weX4G7rLi5Zb7kbWKY87r6Mxy2
	AovWlikYdLBa5SG140W9gL54kfEc4Q5++UJGWqin1g2oe5gG520r3lX+JvEBHpKuFOFgp/t5y9O6L
	NXWPIQ1jRsNXo11WJofM+gff1Z91S64WD+nSaS5OKgg4wtvSyYORPCiETLFZbN6Mf7W6TkS9M3KB7
	HYkO0Ywdtl0CyhbiExCeskgy9sOjX+Ikgw5QsVUId3rwq6jp630Y5NuDyvXafrYy/i8UMrxPuJ1AW
	yhokC1JMXRzAVRCiYonTE0P7+OE8M5gqlH3VCaSV+rDvMa5HC4XBMc2SXQmKX+Qx8pkuue3itxEyD
	IHvkpd/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWvA8-00000002b4C-3lOd;
	Mon, 05 Feb 2024 09:21:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWvA6-00000002b27-1bFH
	for linux-nvme@lists.infradead.org;
	Mon, 05 Feb 2024 09:21:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707124867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9LIYBr/SBBvGlqKN3eoDiC5chZptPGHdLPb7HiYj8w=;
	b=JSsEf3hXw6rJfnlLC763TeOlIr1f/U15jKqz9ERGBMnRvQep1feYwHTuWBzuU7NXE8/RRZ
	TWsz1rzJ2h92/f67PA+tawTkys68EOmLPcWOF6HDwVIMcL6qgPDv7CVrJn6Ec7ypmIKHq4
	EGmcH2MZv5kbPOx1qlrGqiqcheW9xhQ=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-D0gpa2I4PSe_aX7zBlaEqQ-1; Mon, 05 Feb 2024 04:21:06 -0500
X-MC-Unique: D0gpa2I4PSe_aX7zBlaEqQ-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-46d31058c80so79496137.1
        for <linux-nvme@lists.infradead.org>; Mon, 05 Feb 2024 01:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707124865; x=1707729665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9LIYBr/SBBvGlqKN3eoDiC5chZptPGHdLPb7HiYj8w=;
        b=j36ahqaU2tHrmPAZK8x//jZclD45ZG31ZPlYASS1eqbsa21JdK2GBP78Mrc7O8UGqX
         frQK1jgJ/MGeMLxAXj9XW1VoIBfFZ9Hu1wyrVVCAZelqN3npb3PkfwLQxN9Jycpxcb/0
         XoE1S6tHzPXYj6wqTj+fx2cTV7ttKtUqYMD6gubQdT2kPLxpLWAhPH1FC5pWYv441kiN
         41FjhGLMgp7zVQsKi1mtKbEVsQwkxVE4xC0FsE8uu6blN8u+fpfmFJkGmAkixiqvj3tw
         jihyBPNSuwLnVo4lDNIutjfT/Cz5cUIEVIQqyWst3NjhQYcwhp0VJMJgh/ChSUmPqZVE
         cAPA==
X-Gm-Message-State: AOJu0YwDba5xAnV0MD+SviKldapYMtmcxrTXFJDlYE/gQIs97SJnTxFx
	GhS9PX21o4oqcxGyBNo4EVKGDG0Vb7ZHbyRgaHrXHNJATvoxthfoGKI3vwJ7Q00LcpUw3iq7PWX
	k1ELyT2kZXGawXUz7M8/1g681lOJedPOdxOWsfk66qf12Flf2bdKYbSPin3DNiycPmhSEnUojMg
	hWpLnLQr1IZLXxy1ydTILoiNsbkmlOLUMWdbbdt8c=
X-Received: by 2002:a05:6102:ccd:b0:46d:372b:dfc4 with SMTP id g13-20020a0561020ccd00b0046d372bdfc4mr368966vst.15.1707124865742;
        Mon, 05 Feb 2024 01:21:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBTOsbyxZEJDQZOip5MJXT/RW4u3aef098QluKKnXQ6jbMHykO/HdLHPU5KOj1aTuZ6/oDEgx9rcnPjG/+aRY=
X-Received: by 2002:a05:6102:ccd:b0:46d:372b:dfc4 with SMTP id
 g13-20020a0561020ccd00b0046d372bdfc4mr368954vst.15.1707124865521; Mon, 05 Feb
 2024 01:21:05 -0800 (PST)
MIME-Version: 1.0
References: <i4bmvgd3u7shgizqgtdtssdz5v3wc76l6bcce6fcbvoft32gzk@rztzeut4azvj>
 <e0e89568-d3af-4d4e-9652-59d04f2c1977@suse.de> <5pquzxdvemeeahharuoyh72njlx4unrshwxbtkpg63tk3aw2lt@ugv4guf7hkpz>
 <CAFL455kN3Y-ia5twzNRyuT1a+hDWwqS93C2XJDa1+_8nEom0gQ@mail.gmail.com>
In-Reply-To: <CAFL455kN3Y-ia5twzNRyuT1a+hDWwqS93C2XJDa1+_8nEom0gQ@mail.gmail.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Mon, 5 Feb 2024 10:20:54 +0100
Message-ID: <CAFL455mLZ5j9Jkvo+AqKaAmyjDeTpZgKN2X53uytDD1uQTutHg@mail.gmail.com>
Subject: Re: Re: race between nvme device creation and discovery?
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_012110_514473_D228DE07 
X-CRM114-Status: UNSURE (   9.36  )
X-CRM114-Notice: Please train this message.
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

po 5. 2. 2024 v 10:20 odes=C3=ADlatel Maurizio Lombardi <mlombard@redhat.co=
m> napsal:
>
> I think I had a similar problem with nvme-stas some time ago, it tried
> to delete a controller right after it appeared in sysfs, causing race con=
ditions
> with the init code path.

This is the problem I was talking about
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D2eb94dd56a4a4e3fe286def3e2ba207804a37345


