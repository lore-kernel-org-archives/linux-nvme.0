Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D761FC3ABDA
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 18:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yy274iXYl2usoU/p4TZ3ZM9p5xhmdQyfdSoFYA1q72k=; b=hM/Sxa1zYdw8bKwyl223Pjdwu/
	wKB6EL7sVtCytr/fdqIZPjL0xXjsj6ebirzx2eD/9muVUE4JJgmG+cfErmuq+b5DVXgw8NYcnF+fe
	VAMRjCBkO+6rV+mHxTeevAf5fJHLS/a0nyxSbPnYWxu2mvtquSVZMOzwl6ozMOk72j8cdv1D/oODE
	200AxR+uJ3UjM/1BPvQ5XsBDQodf/fOB0hS1hX05/dLQ3W9OL6z//5r3etEa9Q927XFkHtwnnBi5z
	n9fCB3gX0U2YjbwqScjcbeZkPxaJbB+QKgNkSdLa2aFUS39AAl9jL4v150rwk5XbOUdvJYbcfuSaz
	ZHIXE7Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFGvT-0000000G1zK-1Fep;
	Wed, 14 May 2025 18:33:55 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFGDK-0000000FwWm-0SM7
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 17:48:22 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-b1f2a3bf3c8so784257a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 14 May 2025 10:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747244896; x=1747849696; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yy274iXYl2usoU/p4TZ3ZM9p5xhmdQyfdSoFYA1q72k=;
        b=E3UQTfO5ejhyjskm2qiqh8nY2nBXveJnZSo6l0ssuZ6L7ngIAITZcafI5QUuOCFyN1
         /vwzV1CLJwetR7rDkcLAOX448iXYfLUAe3YJlArFUwDU/m54Zw2IamOuF1Bid0l1UxlG
         oecP8J1CcboQpJV+utzrWgfEjl3FRoak+PJvSTBBzgUfPhqyfK2TTv5T3hXl9lVY+jfJ
         113Rd9GjRtwE0niZ2sFMu5O7112PB3Jcs9ugejIKKbgTLWIlsb6CIRZuC3vjLWVmWe+6
         a/s96hm32FHgW45hYQAW36zqD2RX0Mgwelv4Bt3SZJc5outWcrnlPAtIKQOUa6FGnUdU
         pZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244896; x=1747849696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yy274iXYl2usoU/p4TZ3ZM9p5xhmdQyfdSoFYA1q72k=;
        b=Yeia8H/OPs4fVdaO+yrSEfGab8H1QQEIozxMHepHbNIYv3ArhIHR0B+7r4rObhQ5Is
         7lPSINSz2hG9Oa+4nYo/Q+sY/vYTGdwshGidslsTswidNboe8SxAh90V/HduSfIDmwHo
         ctKZKCq0LerlJq0pLUrC3vyJUNeOqQ/u2l+CKvP27On/9YnL5efT+sELyhTzmvMPZS4x
         IL5T3H9KbHaSxWiN3UFDkTqC1HihHHVmZRawFP1q3DylcDiPOjcR5Gb6s2PF81onmiSt
         73UDLY9+5rNk+FWpvd0TZCX+99gJwhf8xOZevq/MjYSATRFPsQkJuiIZ5gP8j95SYrO9
         t7jA==
X-Forwarded-Encrypted: i=1; AJvYcCWTWVHtjs9E5VvfVEQYQIBwpB2FERud4wLruCKSCBFkRoQYPEGHC+dv5JUJilu0mu2NYb2LGTmROJvM@lists.infradead.org
X-Gm-Message-State: AOJu0YzfgfMGYcDkfJ+J6/szk1RqihKB44eyWrindAtrGg0DuiRnaxV1
	esbVoYBtqoLKM6wrdbR0hTU+tI+YEBozVuURJGz91ks8AmdBqDYLiBH/2OrhiwdqkBdKl0hN+9/
	p5RlcCcBeOrLn2eZJ7WQQtPPXi51qI1+T4+qybA==
X-Gm-Gg: ASbGncs/qsYahJfLmL/pZSLCkf9Gy8WTfzuqKHBjW2QAKJ+C95tuJXyV5yk77rg7P/0
	X2FBhvDJXDx0BN5mYGbO7gK0/Ol7N/G1hKOvVWoE8rdw1WL8VxRWDoCyHOLyQRSSk0CTyb6rVBu
	kk8Tjsh1HX2wl0xay9G5XptaCjPamvjvQEK4jG/Er+oug=
X-Google-Smtp-Source: AGHT+IGYkiARNikLBRS+i6MGOR28Bib7wIIVDvK4aItjyiEfvFV9oQKb6U6yu3UXQKjRvb6MX32evwINLRlK4CwmTEA=
X-Received: by 2002:a17:902:d550:b0:224:88c:9253 with SMTP id
 d9443c01a7336-231980e9eb8mr24608655ad.6.1747244896538; Wed, 14 May 2025
 10:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250513070025.830930-1-hch@lst.de> <20250513070025.830930-6-hch@lst.de>
 <aCNf_rHaLdS-WTEO@kbusch-mbp>
In-Reply-To: <aCNf_rHaLdS-WTEO@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 14 May 2025 10:48:05 -0700
X-Gm-Features: AX0GCFvAcmnmdp9w_J7P82h3nSisL2EzvRXDRyoqEyLlay58ncp0kYOlxsFwqME
Message-ID: <CADUfDZpSnQ8JHDhw8-7zrBqfJmYgsM=skKTUTcavys=sWyhVTA@mail.gmail.com>
Subject: Re: [PATCH 5/7] nvme-pci: use a better encoding for small prp pool allocations
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_104818_230297_1CAD1A33 
X-CRM114-Status: GOOD (  17.25  )
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

On Tue, May 13, 2025 at 8:06=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Tue, May 13, 2025 at 09:00:21AM +0200, Christoph Hellwig wrote:
> > +static inline struct dma_pool *nvme_dma_pool(struct nvme_queue *nvmeq,
> > +             struct nvme_iod *iod)
> > +{
> > +     if (iod->flags & IOD_SMALL_DESCRIPTOR)
> > +             return nvmeq->descriptor_pools.small;
> > +     return nvmeq->descriptor_pools.large;
> > +}
>
> ...
>
> >               if (i =3D=3D NVME_CTRL_PAGE_SIZE >> 3) {
> >                       __le64 *old_prp_list =3D prp_list;
> > -                     prp_list =3D dma_pool_alloc(pool, GFP_ATOMIC, &pr=
p_dma);
> > +
> > +                     prp_list =3D dma_pool_alloc(nvme_dma_pool(nvmeq, =
iod),
> > +                                     GFP_ATOMIC, &prp_dma);
>
> You could assume nvmeq->descriptor_pools.large here. We'd never use the
> small pool if we've enough elements to chain lists, and it would skip
> the extra condition branch on each loop.

Right, and the existing code already assumes this branch is taken only
in the large case since iod->descriptors[0] is always set before the
loop but nr_descriptors is only initialized to 1 in the large case.

The existing approach of storing the struct dma_pool * in a local
variable seems fine to me and would avoid another pointer dereference
here.

Best,
Caleb

>
> The same optimization is done in the free side already, too.

