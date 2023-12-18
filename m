Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284F0C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L5R99au8NJbb079tj5U7lHEWAwHW7p8PGZmVQ7WmYCk=; b=0qQjAapapsqMwuWFE5370h68LB
	9pttjeQF073c1FfZg8/Hj29WwKwSjX9atw6pl1FcLdg0RX7bBtb0MFJmfNPgbKnZy30PqR6JF0H/9
	0uAlXM6dDqMndgjo9XGabq11i+lktrIpT805+YA+PYg3o0VIlKUqkfwuIo3dfOyBml7MbHlwauk3N
	v40fGEGJBFSkGk8za0Bj7CQ2a/uqKk1n3ul6VTP/0wmvfcwjsCugE6Ez2klKA+Xytr55EDEQwFvtF
	t/iA2Ua7a/7KArP/i65cTtMzutDRGVVrbGMPBDMNONbLE2WYulkzjKf8jDQdPyUyH56PytgW+2Tvs
	JGU9E29w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFGCP-00BNlR-0m;
	Mon, 18 Dec 2023 16:10:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFGCL-00BNk9-0N
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 16:10:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702915827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5R99au8NJbb079tj5U7lHEWAwHW7p8PGZmVQ7WmYCk=;
	b=GrWMaS/q3tp/q6X7aNE7kYvBIgN67seZjMPaWSw1xlpJ5w67BUDRQL/P91H3bRklnGgk+G
	8aYKQTRx6tTPZxrn1481OBbUisU7VAD68AE2LtlcldrwK2btgRldim1RPjvUemAi0QE/Pu
	dBsw9dfdsTH6zzwsILcBFRtRQRvVecA=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-jfmB1DokOXGN5P70h89XsA-1; Mon, 18 Dec 2023 11:10:26 -0500
X-MC-Unique: jfmB1DokOXGN5P70h89XsA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-203d1052e4dso914776fac.3
        for <linux-nvme@lists.infradead.org>; Mon, 18 Dec 2023 08:10:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915825; x=1703520625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5R99au8NJbb079tj5U7lHEWAwHW7p8PGZmVQ7WmYCk=;
        b=jNpf+IE5rTsJsUBImcVHNX33dKkJLI8w9Zb/7M1gT70Cn6IenV/YZCzirlL4tHL7AK
         90GSBThoZigV/x9z4venaXiXmBiIJNIwR+NEBoBOFXaVMJDl3kpggHzX75Dbjg8iZ4zV
         67F5s9M2F8kR24Fkt9jhJHoXCQT3RZNniW5B3wgDnUN2ejqbYnnSjkGCG0y3Pkl4TYgW
         iSemGyyeHRuhuyD8a030xYMt2n6Nt5ThJikCtd776t0Wt2V6Rh6ExBQwL+AsPSStB9rN
         IACt6pYhVxGUAQge5UzBRYtdOKXgZfX8CUBWBSGJizG01lJKben3r6sDtym7KZLvK17U
         xx1A==
X-Gm-Message-State: AOJu0Yzimv6xF7swD3d/ePYUT4WTiZ+aO97+ZzeaIN4oggro/H2huGjJ
	l35NTUaReqmfGecEMrj+wknpkgOcmJ324oEKYhfbVIBeZ3UOvUnFi4ARNtQIeIa311Tz/OlH09E
	aKm154KGo35odV0EO1JOAvEsib4u+aJmqSE7R3Vhjfts=
X-Received: by 2002:a05:6870:3d8e:b0:203:d297:a711 with SMTP id lm14-20020a0568703d8e00b00203d297a711mr1363182oab.66.1702915825205;
        Mon, 18 Dec 2023 08:10:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoAVPoEADCU6TjYtAWpqQGANggJfJXkSkO1I0bREZXjGczCKhZxkL4FRuwG2AyDJYAXsvzFVBo7hHGGAwxPRI=
X-Received: by 2002:a05:6870:3d8e:b0:203:d297:a711 with SMTP id
 lm14-20020a0568703d8e00b00203d297a711mr1363172oab.66.1702915824969; Mon, 18
 Dec 2023 08:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20231218153105.12717-1-dwagner@suse.de>
In-Reply-To: <20231218153105.12717-1-dwagner@suse.de>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Mon, 18 Dec 2023 17:10:13 +0100
Message-ID: <CAFL455mFwEfRF9VCCGHhHZVMt2tzr8f2qfFMAPGvufaU8zO4Gw@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] enable nvmet-fc for blktests
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_081029_227403_F5EEF04F 
X-CRM114-Status: GOOD (  10.58  )
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

po 18. 12. 2023 v 16:34 odes=C3=ADlatel Daniel Wagner <dwagner@suse.de> nap=
sal:
>
> Apropos KASAN, it still reports the problem from [1], so anyone who want =
to run
> this series needs to revert ee6fdc5055e9 ("nvme-fc: fix race between erro=
r
> recovery and creating association").

We hit this regression in RHEL too and we were forced to revert that
commit, it's obviously buggy
because it calls blocking functions with interrupts disabled.
Please revert it.

Note: I have tried to fix it and close the race condition but it all
became a bit too complex, also,
I didn't have the opportunity to test it yet.
http://bsdbackstore.eu/misc/0001-nvme-fc-fix-races-and-scheduling-while-ato=
mic-bugs.patch

Maurizio


