Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AEBC27C79
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jun 2024 08:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dnj2PmSySweOEd04AET7ybhp3My3IB+EVpj3szflUKg=; b=0CsFFiJEXw9BkHsTWpI+galPFG
	3vdcP080mQpUhKf8inG3dD3n+635PlD2s3/NnHU5k1991gGXHRNFZQcSE2ltqqPZtscuXYrTNi5vm
	uv4X18CNwznAUHpFVuOLgs2OSbQn7YFPXQWUJ1f5kKgUj81esjh4MOkzGixCnLl9iUcmAqIf+JC+V
	TBGPR1gY1NJ0Bpi1gqdMOYZMpjPKdaR6n/YESkK5Wj5w9B5fxFyMqt2MoRJMLbpSmFmcxpW2Rk4U/
	z+6VzpdBBUCvQEt22aj1JmgvKhgJ2ck6MbnDn/EhgKm4y9zpPe5Fg6sDoQtzBHRu0xrDIfGqkoPRW
	IMcayscQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKDCZ-00000004A83-1G3f;
	Thu, 20 Jun 2024 08:31:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKDCW-00000004A7O-28W3
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 08:31:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718872279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnj2PmSySweOEd04AET7ybhp3My3IB+EVpj3szflUKg=;
	b=TFk8s36jMy2DcNxIXe1cb4EYQkEMum7Bkd3/dRGbswh3ves3X9ddEMkMv3mlJjgOK/SyuY
	mvYIuPFTLXda84pvPWaF7qX+fGxclil4xjmlD5A86RIN/gEDEP/3y1kipg0/R9w3hs7mBl
	KUJ6d12ASfabSRvKT60q83RMBPh7Gyo=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-Mm5EBstMMgm3nT083v_1og-1; Thu, 20 Jun 2024 04:31:17 -0400
X-MC-Unique: Mm5EBstMMgm3nT083v_1og-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6f8f8b59250so741932a34.2
        for <linux-nvme@lists.infradead.org>; Thu, 20 Jun 2024 01:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718872277; x=1719477077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnj2PmSySweOEd04AET7ybhp3My3IB+EVpj3szflUKg=;
        b=W+pWKyR/b9EPtr+lHGD54NxuBWSAAuAs0vaoSLzgFpxAz/Di5MB9vw0O4aATlg6Zdb
         iQLKSRqUXyU0r/M62qnwTzHCRq6XypjJrRd9zqghyJoMgcUmbbSR83blXHXZXuQkSePP
         r3dC56sOaOeZQ/YmEdxAmwSc7re8PW5Zl3Nnj1mdaE1LgTlxLiYyulPnxtnlw4wK2BkL
         Hp2gpXE6zZpOf6+YS0rBL9QjUgDK168BTOfO/Kivd+SzrRY85YoyAfScA7F6701kBDo8
         +TOp63vASSba3thtJcnBPKoR7Wm7QCgaI3ZQJeCbL/S1K9hJMRTlrR2eb1WLDhTzRx8j
         rxzw==
X-Forwarded-Encrypted: i=1; AJvYcCUr5DdSlPRNMiNWkPcl+a7zMe6z/iOHEbkj78qr+mkaYCumuHbW5JU2oVTkXdbguFkvcCa/jy2DaoG814JvsVGZgcUlUp505eYPtFxAvqY=
X-Gm-Message-State: AOJu0YzgOnk2g8P7qtZGF/v7sUC26glRrwMHaol5R+jIwXAGbCSZh8xQ
	LLVjdVF4CGXJxw5jSYov9nX7Rj5tRn3H5OOBnDwy4fuFhH1OP/j6zFG8TZp90UFoVByU792P23A
	1iut/soWT7khINxGcq/bETYRVLtKBsEaYsitl676/WZcNRLYU7NGnk4sX7qy9f41CAZ9Ua+tTVA
	SMhLwa1oNxg65CQLhrYmPPiIvyumKntDOsJR2asd8=
X-Received: by 2002:a9d:7a47:0:b0:6f9:b609:5a0c with SMTP id 46e09a7af769-7007401bb22mr5569246a34.17.1718872277134;
        Thu, 20 Jun 2024 01:31:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhNn61usNFRq5rbLQgw+RkFA7vmuWMvlt9Vm0J5zpp7z6xkVXsVF+qZCFCflKbYqOoQZ+gEaiFxGlwywGRLp0=
X-Received: by 2002:a9d:7a47:0:b0:6f9:b609:5a0c with SMTP id
 46e09a7af769-7007401bb22mr5569232a34.17.1718872276827; Thu, 20 Jun 2024
 01:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240510163026.786898-1-mlombard@redhat.com> <20240510163026.786898-3-mlombard@redhat.com>
 <3d2dc04f-86ee-4802-98f7-fc948e813ac0@grimberg.me>
In-Reply-To: <3d2dc04f-86ee-4802-98f7-fc948e813ac0@grimberg.me>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Thu, 20 Jun 2024 10:31:06 +0200
Message-ID: <CAFL455=srQgXzME72mihwaRJ0P4nNfC7VWn8HLAEbdx6o6Jawg@mail.gmail.com>
Subject: Re: [PATCH 2/5] nvme-core: add a function to submit a cancel command
To: Sagi Grimberg <sagi@grimberg.me>
Cc: kbusch@meta.com, hare@kernel.org, emilne@redhat.com, jmeneghi@redhat.com, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_013124_646424_481215B4 
X-CRM114-Status: GOOD (  16.64  )
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

Hello Sagi,

ne 12. 5. 2024 v 16:06 odes=C3=ADlatel Sagi Grimberg <sagi@grimberg.me> nap=
sal:
> > +                                            BLK_MQ_REQ_NOWAIT |
> > +                                            BLK_MQ_REQ_RESERVED,
> > +                                            sqid - 1);
>
> I think we need to account for a new reserved commands that is now
> can be taken outside of connect. Should this be reserved at all?

That is true, I should add some reserved tags, and yes, they have to
be reserved because
blk_mq_alloc_request_hctx() enforces it to keep the low level allocator sim=
ple.

> meaning even if we account for it, there are potentially more and more
> requests that we'd want to cancel...

Yes, so the question is how many tags should be reserved for cancel command=
s.

I received a suggestion to make Cancel command work the following way:

- The first timeout on a specific I/O queue triggers a cancel in
"single command" mode, aborting the command
that timed out.
- If another command times out on the same I/O queue while the fist
cancel is still executing, send a second cancel command in
"multiple command" mode, aborting all of the outstanding commands on
the I/O queue.

but this could potentially require 2 * queue_count reserved tags, so
tens of reserved tags for a command that maybe will be seldom used;
also, the implementation will be more complex.

Another possibility is to just use Cancel in "single command" mode,
similarly to how the normal abort command works and limit it
with a variable in the nvme_ctrl structure, as we do with
"abort_limit" (it could be called "cancel_limit").
This would prevent us from exhausting the pool of reserved tags, thus
avoiding the problems like with commit de105068fead while keeping the
implementation very simple;
if we reach "cancel_limit" we can always fallback to a controller
reset. On the other hand, we would use only a subset of the features
Cancel has to offer.

Maurizio


