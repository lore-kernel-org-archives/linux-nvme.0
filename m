Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B59EC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wT27mFnYXE4VsW5Hl1O04VlvM/CXAOVEONyhJydmpBI=; b=FYClKbpgTZEayZjFqA9V5uW3xu
	BjGssReKAET4HWPS2idjfYdck1WYUfssv43z6OXI6fuFawaPN+Vd8RLFYvF7hZ2DOYvtYzfJKsL4I
	Myrk6OOaahkRnNQNSxbJRJwTQ1nNHnu2VCqO2VGg5Szsg6cpTAX8jOeMIZNojbVBJL3KvccCfjkOT
	0OEQiyTbLXvOmuIa20hQziFACV8O9VDuu99R5vZZvNOlggy6wwC4xVqV5XthpZNRCDTZZNCwMFnLE
	KZo322xljJ8AP3ouFwLZF70/gAumj5Q462ckUsM/vFkPKqvkSVpol2bQw0B1zYt5GAWpTlzGL+Iqk
	rfc2Hi2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFb4B-00EML2-1k;
	Tue, 19 Dec 2023 14:27:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFb48-00EMK0-1R
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 14:27:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702996043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wT27mFnYXE4VsW5Hl1O04VlvM/CXAOVEONyhJydmpBI=;
	b=BhAUOkZYG51NfR+F90zWKyLDjQHN4v3BTYDEGoX5hz98ivGv3r4RIn22gYAwSCgYi8LH8V
	GrCm5eIbFPNrc717Vzjg35t0ipzDU+QKXU3vlQTcSyoSVBoU1Td4tEMfDHlua9RQ8VUEdF
	3+0dhiZ8Lxwx+TVZChaNyT50aZM/b8E=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-21v79EHbPC64GVUJny6cnQ-1; Tue, 19 Dec 2023 09:27:21 -0500
X-MC-Unique: 21v79EHbPC64GVUJny6cnQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6da4f217123so6082733a34.2
        for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 06:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702996040; x=1703600840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wT27mFnYXE4VsW5Hl1O04VlvM/CXAOVEONyhJydmpBI=;
        b=dIgqGz4+o1uboJweBVz/knWKkoXN5+7SDuyvp+AaYVTLLz/LGNGMru87tG8UNN5cJ5
         6zBI/GSFbz+Ysv9pSmNDUCC9Ke0/EJ2s4dWWu+O9m3PaEuvIH3pZQJJjUoqC8EZm03z7
         FM0OP3/SQVg2JimZuoSgRkHCQSVwJn9/fcGJhDfJyuCpHxB9xDFYdOqi0z78oQuio43I
         LfyZedJARmUKIH9Nki5DVRhzTz3W/GEujV2TWERiem5NTllKjPvZ6C6m63EoHEd7nUNC
         OHrPsdATw1bh/Fog+R4BoyOAXRGRjsEc76leOFUGZa+UOmELOCwAqGYsjQfZB9Rnz5L/
         dNCA==
X-Gm-Message-State: AOJu0YwffJGNgimm00aOHk9Luko/pgozhuRbFm1ze0KFYMQm0j41posh
	0B7jsj9yE6w3BLDcPNzpILj+1FwjJLKu6VmNkE67Dj3gd6uWy+WqNyVpwA1aEV8ldgrhAyCFpc8
	6NxmO34VbH5ngzAbPUvI6GBeLdfBtn99F3g7rvkd+3Gl11XhjI9SbTw==
X-Received: by 2002:a05:6830:1be7:b0:6db:a713:a855 with SMTP id k7-20020a0568301be700b006dba713a855mr159460otb.67.1702996040169;
        Tue, 19 Dec 2023 06:27:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUUI4fNasGHCeGcJIU102BgYPU61IfGIP+rZYVzniJAVyKBU8RLCbJ6UT7mMHfOdZtu7CK4vMqQoXQXWEusVA=
X-Received: by 2002:a05:6830:1be7:b0:6db:a713:a855 with SMTP id
 k7-20020a0568301be700b006dba713a855mr159451otb.67.1702996039955; Tue, 19 Dec
 2023 06:27:19 -0800 (PST)
MIME-Version: 1.0
References: <20231215143136.252497-1-mlombard@redhat.com> <ZXyMCcq7I0ZBNU-K@kbusch-mbp>
 <CAFL455nBx_tRj3QDVXwU2pReoryF3bVfMvD1O+4YHDZzWnzS2w@mail.gmail.com>
 <ZYCE0Tam0HOVfVI_@kbusch-mbp.dhcp.thefacebook.com> <ZYCH8Hsn4UI_7j3-@kbusch-mbp.dhcp.thefacebook.com>
 <ee662fd4-b33d-4d81-8e80-1b2655505e8d@grimberg.me>
In-Reply-To: <ee662fd4-b33d-4d81-8e80-1b2655505e8d@grimberg.me>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Tue, 19 Dec 2023 15:27:08 +0100
Message-ID: <CAFL455ms8TfpiS0-UR5ENtoiqAUfrubMhoQH7vZKU7Mrgn26fA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: fix sleeping function called from interrupt context
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	Yi Zhang <yi.zhang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_062724_555627_158D79C1 
X-CRM114-Status: UNSURE (   9.78  )
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

=C3=BAt 19. 12. 2023 v 14:54 odes=C3=ADlatel Sagi Grimberg <sagi@grimberg.m=
e> napsal:
> Exactly what I was thinking. However we should make
> nvme_handle_aen_notice() allowed to be called from an interrupt
> context even for fabrics, so we should move it out of there anyways.
>

I am going to submit a V2 patch today, I will simply move nvme_auth_stop ou=
t
so it will be possible to call nvme_handle_aen_notice() from interrupt cont=
ext

Maurizio


