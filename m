Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EDEC61D92
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Nov 2023 07:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9CfBPwRcV1wRU6URO6m8qJZonHz7TrhMtvHYwD07ad0=; b=jTvlKt1EWl407oIBC4tkZWi92I
	KEVeYSVPtXraUVvb05G3sqofGE18C/bjL/XmqByQ+jE/0JAutEsd9iBpwjxVwsvyfZMs9T0EvubWT
	QwoZqkMOO/VuMN87FxGP3a5w3/bE9c10AV+uH3B1etK3VFWaDtaSWYjJjy41IeKAO9M/NvGudvoPr
	TepG2hqaTc8r7r9vaNwJrHsjK5UtSw1Vmmxao4/3iessyH017zQsfz6QKQ+gCWXGvKbFW8K0/RGic
	dM2j+GsWVYOT0jp2cnIicg9X1bplSlp69mD6aRWjHGhrcsB9yQYcTRmiZVFn7Fg3EeRBQY89raBZ2
	nXjMxdjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5hvG-000xHv-0C;
	Wed, 22 Nov 2023 07:45:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5hvD-000xGP-03
	for linux-nvme@lists.infradead.org;
	Wed, 22 Nov 2023 07:45:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700639116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CfBPwRcV1wRU6URO6m8qJZonHz7TrhMtvHYwD07ad0=;
	b=U9+kTZ5TStTGnepYp2ivySubhSEeAEQo48xsNJPbAyTl7QaNyWsrJgbDNW55RflewiMU8Z
	N+7YYUB9bY1tkPW1FJt1tRx4gE3r0Dgcj1spH+ojIkHMR7PYiwHBaUDRdRjpT1sqaqj217
	igKJtospLWYoARhj5vlNLa/vEB3e1gE=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-S3Qwyv6QNta1Cq5O4O_2dQ-1; Wed, 22 Nov 2023 02:45:15 -0500
X-MC-Unique: S3Qwyv6QNta1Cq5O4O_2dQ-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4abebcbc81bso2381618e0c.2
        for <linux-nvme@lists.infradead.org>; Tue, 21 Nov 2023 23:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700639115; x=1701243915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CfBPwRcV1wRU6URO6m8qJZonHz7TrhMtvHYwD07ad0=;
        b=geN6euizoC5lLBEvm+irxskFEA2jJKJ5LnhYc3p1oprjpnOFWgW/8WTTk/FyXzFdX4
         Qjoa0W6E+pYG5aiwRkLSSKVOJWdxx0NYk6CtcExV+Mogl3rpcjcm+V30NLG1C2ihPu3h
         LtwxmG7ErppFmcYb/DEWMGgOWCZ5l10S59q0h1PK06BhVD9kFvh3irxp/9WbzQt2OO5S
         pfynk56qwx7TneUQS5KWJ1t99NhiR1KJOGOQg6sAbsSGnK8su/yCeXxfWA7bhTP+8J/3
         fLMfr3fQ2ec9lS7OsxKA+ADqoZNBDSAi5FsB5fohepjeZPFxv28GW4IYfZIm0BVoYtNV
         9YVg==
X-Gm-Message-State: AOJu0YwZ9heRLWWlME0ne/TH6wRLJDsAHL8LxDGFrbBUwF9zpjlqASep
	8BeXpkBfg1ne69AWmVc8YeDgafqAlXP6nKX//g7Q2JmdFdvgornSv1hgYID7N88RkEWYQ5DRrGg
	B9J2TIw5uojH87HWuTQUXZ+RNjWW5u6aZ60Z/nrXuF/A=
X-Received: by 2002:a1f:dfc4:0:b0:49a:1a56:945c with SMTP id w187-20020a1fdfc4000000b0049a1a56945cmr1838079vkg.13.1700639114798;
        Tue, 21 Nov 2023 23:45:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ1gSHsrpwaAVJzd400W01NjsKU1MUoUBj2HaraSiWfaAjANlamZmWJt/NyxUOwRMLgxyXI77dpXFIZs9w5r8=
X-Received: by 2002:a1f:dfc4:0:b0:49a:1a56:945c with SMTP id
 w187-20020a1fdfc4000000b0049a1a56945cmr1838067vkg.13.1700639114496; Tue, 21
 Nov 2023 23:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20231110163721.15292-1-emilne@redhat.com> <CAGtn9rmMLQfsocZvWJnnekRxfL2_s3oDYcUNTy3M0c2d8UYYfg@mail.gmail.com>
 <CAGtn9rkynCF1De25--d39D0o2Eh2QV4aDLOxaRYrw2m1ouu_4g@mail.gmail.com> <ZVzzW0P6CtataBLK@kbusch-mbp>
In-Reply-To: <ZVzzW0P6CtataBLK@kbusch-mbp>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Wed, 22 Nov 2023 08:45:02 +0100
Message-ID: <CAFL455kC=UuTV=sAxDYNPj9X4y=ex2ND41VXv6Wv0KLWfNcm3w@mail.gmail.com>
Subject: Re: [PATCH] nvme: check for valid data from from nvme_identify_ns()
 before using it
To: Keith Busch <kbusch@kernel.org>
Cc: Ewan Milne <emilne@redhat.com>, linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_234519_124746_24D99E1F 
X-CRM114-Status: UNSURE (   6.35  )
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

=C3=BAt 21. 11. 2023 v 19:14 odes=C3=ADlatel Keith Busch <kbusch@kernel.org=
> napsal:
> The concept sounds good, though you are leaking 'id' in the new error cas=
e.
>

We have the same problem in the nvme_ns_info_from_identify() function.

Maurizio


