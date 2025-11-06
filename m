Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA36CCFA05
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Nov 2025 19:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hQGB0foqm24G6hL3Wvf/9muUhNscV02/xTCy0qjTl+I=; b=4a5Nh8LXxnek/UeuiAkBFVNrLQ
	6jRIE1++yHzv0iPSSmWQb0eD20oo1sQiZ5XrSYSW9I3C7hN+04HzG/LtfJ4xQgr9X0rks1U1/xkgE
	b4xMpM3OsU95NqeUKGe/DK9fePAczWto6LOqJtCAMIiyrcSWOHqBVWy4TJUNlt4HDyMRMlaaI2ESM
	6rOPjhiiwHnVQQE3NjKtqmQ2YqBqvZbSXKzQ+wnhU1QSB8agkb4Tbnjnh1kE1RRKS0jTiqY6S0TZZ
	y6+vOYnd+2c6BYI462dcYsvj3CLGi2F3nR1Vkevjgp+5v/ILNiH/TQR1CrB8GG9dneoNfiv+nTpCD
	CP4MKy5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH5jz-0000000GAYh-1qGq;
	Thu, 06 Nov 2025 19:33:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH5jt-0000000GAYD-3ZeM
	for linux-nvme@lists.infradead.org;
	Thu, 06 Nov 2025 19:33:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762457624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQGB0foqm24G6hL3Wvf/9muUhNscV02/xTCy0qjTl+I=;
	b=R6UxQHjF1cluH0JPsxsqKKTm87xYxY7AotBvRA5NIhKEAdEN4JPi1DzWpZcmD32b/HgpGq
	DKwFc/6FEupMGzg75dGMA0xy6XjRwOxm1s9Cykl8vYEgKGge0KVEFsaaHHx5lIDdicGi9P
	nX+wOvW89p7lT9n7Z8d3mTZwbIFvvf8=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-DOzGW7eaPY26XYqhOEdb3A-1; Thu, 06 Nov 2025 14:33:42 -0500
X-MC-Unique: DOzGW7eaPY26XYqhOEdb3A-1
X-Mimecast-MFC-AGG-ID: DOzGW7eaPY26XYqhOEdb3A_1762457622
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63e1eca302eso19383d50.1
        for <linux-nvme@lists.infradead.org>; Thu, 06 Nov 2025 11:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457622; x=1763062422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hQGB0foqm24G6hL3Wvf/9muUhNscV02/xTCy0qjTl+I=;
        b=uHij/08ZoTeHw0nji71q9OEWYZ5bVK5FK6vFjhdVBC7AWyJDC5FL0GtGso8OQbyDf/
         icvTw7NUXDBwBTNb+Pu3BWOjKFivqdr/N7xbT+pX3+TEfsyfwAJLVTgc3oUsoZ+yVK0f
         wN7dc3dLD3qtBrIjhBNEIuHLlrvJ6t4z3lFCxwijMd9qvuaJNJgA19WNRVbbnCtnXbiJ
         cMe8I5HiqkpoMwWGhBUDSxmEIa6B5ZYrbxWAOiU3yBmSYGOsrxC/1hi/HUBxfJHYoEou
         hx6k6wARl7qLPUMeofgd9GJrRrZOSJSuS28NM7XqY8RboqScXRnVeRsWaA4pIXtCQg+h
         QK/g==
X-Forwarded-Encrypted: i=1; AJvYcCVrNJgxqwHQ8LW5LzuG7Y3kRPls2yU383WIP34lRJ4JwkCgNelLUHUK6bs5MYuiUSqrCCqfSYRitKvD@lists.infradead.org
X-Gm-Message-State: AOJu0YwoMWbgYzlCeNQNnRVdXNI5FHWXgIZ8JVf3KaNqonf+s5v/sWsc
	yRHSBhiIKwem0TaSMcLpYCkA2VQLCcddvcH5G2chtYYEChLJ6WRk16VthlwknWlOGAPl0V2DslW
	WIsA+X2nAQii3FsLxlKpDoT/CVQS/TFlW77OHVZOpk2qS0I0vy1KEqsOvMY7yLdKEn7sIwui8BG
	ik8pdKrxHUSsT/U7bH6kKRb8vXdvso5KHqFXqDr+d3bLs=
X-Gm-Gg: ASbGncvlvg0lQpnuoVnilnaLYxICV2k+nv0IOdvwUjosQNiY83aKmRN/phhd8/alPMw
	gB04svaCHcss+4DqmjNSMEaXsScHE9sTy6Ewm04U7hpnws+LlYVUxmjIGJnVj++gIoMNjHEwubD
	HKuL9meWb1dkwy1WVkDn7oW5XcVdSAt/0pCyAUlPWUjKKK1cILkAo4pQ==
X-Received: by 2002:a05:690e:429c:20b0:63f:b4ee:792c with SMTP id 956f58d0204a3-640c41931eemr463783d50.19.1762457622116;
        Thu, 06 Nov 2025 11:33:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNoLHMvH10aPy1A+/y80jq7bHXknYCorhA61DmU5QFKCw0zwEwK/L+vFYFpchppZVzqU9Gn/HeJuxTFJZIxhU=
X-Received: by 2002:a05:690e:429c:20b0:63f:b4ee:792c with SMTP id
 956f58d0204a3-640c41931eemr463764d50.19.1762457621800; Thu, 06 Nov 2025
 11:33:41 -0800 (PST)
MIME-Version: 1.0
References: <20251104225939.3641605-1-kbusch@meta.com> <CAGtn9rnm-V4Ejm9kRkvV91XAO98XF7jv9Y7Kjr611BbffikkEg@mail.gmail.com>
 <aQvRDndEfTf3LMab@kbusch-mbp>
In-Reply-To: <aQvRDndEfTf3LMab@kbusch-mbp>
From: Ewan Milne <emilne@redhat.com>
Date: Thu, 6 Nov 2025 14:33:30 -0500
X-Gm-Features: AWmQ_bkfMfYAC2XGOlMd2GKRpHBbbM2Z3C0j1CSI2siJi90Vft9fw_FJ_07yK3c
Message-ID: <CAGtn9rnuRFjA8H79Mn2Q4mRBXJOv7GPpYLYHm-mmDqubPQ-s6Q@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix admin request_queue lifetime
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de, 
	ming.lei@redhat.com, chaitanyak@nvidia.com, 
	Casey Chen <cachen@purestorage.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PR3oIdtXh_WYsA-om6ckNh8jYMVUId8eWPJN4GKzkZg_1762457622
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_113346_310853_7B84623D 
X-CRM114-Status: GOOD (  21.03  )
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

On Wed, Nov 5, 2025 at 5:35=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Wed, Nov 05, 2025 at 04:31:13PM -0500, Ewan Milne wrote:
> > On Tue, Nov 4, 2025 at 6:00=E2=80=AFPM Keith Busch <kbusch@meta.com> wr=
ote:
> > >
> > > From: Keith Busch <kbusch@kernel.org>
> > >
> > > The namespaces can access the controller's admin request_queue, and
> > > stale references on the namespaces may exist. Ensure the request_queu=
e
> > > is active by moving the controller's 'put' after all references on th=
e
> > > controller have been released to ensure no one is trying to access th=
e
> > > request_queue. This fixes a reported use-after-free bug:
> > >
> >
> > OK, so I get that this fixes the use-after-free, and don't let my
> > comments hold up
> > acceptance of the patch.  But can you explain why this actually helps?
> > nvme_alloc_admin_tag_set() allocates the admin_q as part of the admin t=
agset
> > initiailization, and doesn't this change keep the lifetime of the
> > admin_q past when
> > the admin tagset is deallocated?  So where do we detect that?
>
> We still call blk_mq_destroy_queue() prior to calling
> blk_mq_free_tag_set(). The queue has exited the tagset and set to dying;
> no one can "enter" the queue after that, so that tagset can be safely
> freed even if people are holding references on that dying queue.
>

OK, thanks.  I think it wise to include Chaitanya's null pointer check also=
.

Reviewed-by: Ewan D. Milne <emilne@redhat.com>


