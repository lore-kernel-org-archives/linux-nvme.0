Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1701EC6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 16:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fv+JMGiWCaXjJjZ5exh44P8rLpNsNz5pXzaelStwd3k=; b=NpIZfcim1dRAmfvmuccRJlE4Jl
	c4Z3Bb6ikYFBmeLVikuf8fwRxQhNOfzETcOK/QdZovre5A7Zkpo/jOJNyyNi275iMX8I1Dd38PP+B
	Uc6DlnsOHe364D8M3zGzZnM9ISk2o3e7M9byBluayTux9zitx1Mc3fZF8Fsd+NZ4BIZdiUyIJ/muY
	H9hS2272SDhQ1EHlfV6p5UMNjs/IliJPS+h8cUtRCN30qcQVNJGR0Fwiw0AGuNN9PEYhPuHLH8oUQ
	gVM11PzsAbNlJo3UzY8kRDa9hyzQ1lE+vhk23DT9cs0e5ozXOGo+8pD8nW4QofujZaNUbtXJ6h40f
	6rEAe8GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peesf-00D56i-37;
	Tue, 21 Mar 2023 16:30:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peesc-00D55j-1I
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 16:30:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679416230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fv+JMGiWCaXjJjZ5exh44P8rLpNsNz5pXzaelStwd3k=;
	b=GZ8snMnzVOB8l5OH9j0AcPBFVn67PKtGMDYkNrbadijsccS7g4cTeNo9X9KzNUqzBoXhAN
	WuaBJMBN3TgqYhpkzdjpg3tj9vRBMXz3D7LukFxKC/FgNbnxZXP/53AGTgA8i4ldDbha2B
	BufRLPpxPnD5ceVV8mMgagC96+dyWJk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-sSelBJ1IPEmLD2UNQTC3Gg-1; Tue, 21 Mar 2023 12:30:28 -0400
X-MC-Unique: sSelBJ1IPEmLD2UNQTC3Gg-1
Received: by mail-lj1-f198.google.com with SMTP id bg40-20020a05651c0ba800b0029a7c925073so3374279ljb.2
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 09:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679416227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fv+JMGiWCaXjJjZ5exh44P8rLpNsNz5pXzaelStwd3k=;
        b=jndJ4pt38ALY9m/snHCsatrolmJGYpY3lOmApdZcO1/oTed/VCoF9zQmYYHvLj55H4
         jRiBW5l7PjtIysixTuDAiRZJvqmOqNKl0CzcQmvQUAwaH92wIHrqfVOP0CwebL/E5/QX
         2KOptciT7ocCpLr8wgTI1cuuejxtvz7vjeqELkCuXPf//vNiPfA4sz/XWvK5MOBjI0ha
         KrpKaCNIY0WMI4m5K86EsBI8FDu1ighP01rk2mk6GXD794NiREy4R6QomYMx0qkhxcM6
         sFVAgvMSb95p7ZPkKUFoFtZHPldNZWNdq6FxJVLJgPoUlJH4XcLVAfy8TN2vKBXfaCSm
         gwJQ==
X-Gm-Message-State: AO0yUKUsVbPPEMgjztbIlbGJBNxE4rQ+2W9884mQysXUL/qc4VKFaz6x
	iUYzTpQNZxTQFTnRl78eiWf9ldK35HleRRHWxAL2Lex2ZVbsF1o7QKGGeFXa4owY2BD8lqzalof
	VijISTG4WayYXW3Vhft/19tPT5OG2NL/eoOopnRjvobwvr6DT5Io=
X-Received: by 2002:a2e:2412:0:b0:29a:9053:ed21 with SMTP id k18-20020a2e2412000000b0029a9053ed21mr1072013ljk.8.1679416227271;
        Tue, 21 Mar 2023 09:30:27 -0700 (PDT)
X-Google-Smtp-Source: AK7set/PHT6JiE7cfbbWmsKaZzWvI/8VZVWJmAxmoiNfLgxciMsJeIMWgf4Nj98k9sC1ZHgb+TqjMo0C6v+dE1l0/KI=
X-Received: by 2002:a2e:2412:0:b0:29a:9053:ed21 with SMTP id
 k18-20020a2e2412000000b0029a9053ed21mr1072006ljk.8.1679416226969; Tue, 21 Mar
 2023 09:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230320220947.3244247-1-cleech@redhat.com> <20230320220947.3244247-2-cleech@redhat.com>
 <f3b47746-624c-2b8f-2d26-1f6d15ef90f4@grimberg.me>
In-Reply-To: <f3b47746-624c-2b8f-2d26-1f6d15ef90f4@grimberg.me>
From: Chris Leech <cleech@redhat.com>
Date: Tue, 21 Mar 2023 09:30:15 -0700
Message-ID: <CAPnfmX+3ESF+-3XcrjzjbnuPhHA=W9RhuqnRkaxW4mkerpNCuQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme-tcp: fence TCP socket on transport error
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, John Meneghini <jmeneghi@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_093034_535640_45EA04B4 
X-CRM114-Status: GOOD (  12.92  )
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

On Tue, Mar 21, 2023 at 1:30=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
> > +     if (!queue->rd_enabled) {
> > +             /* io_work or polling happening after receive error
> > +              * waiting on error recovery
> > +              */
> > +             return -EFAULT;
> > +     }
>
> I think we can drop the comment, the code is somewhat self-explanatory,
> if read is not enabled, we shouldn't try and read from the socket.
>
>         if (!queue->rd_enabled)
>                 return -EFAULT;

Sure, and as it's an error check in the data path I'll add an unlikely hint=
.

- Chris


