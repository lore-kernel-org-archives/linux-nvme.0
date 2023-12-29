Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E554CC46CD4
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Dec 2023 08:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OfvH7AWX59Ms5JPy4x+Ke3bCDj01NX0JuiH6a1g+MrM=; b=Itxzbj5K1NixCOJZckANm6uiFG
	2QORoksgIb6UtaxgZATpS+JmF3hrlNAy1uQkZTLAoeD1LntVSMF4o7wARE75GNGIHNzmtuDsiYQOx
	/SubVjKmI0YAAQLrIM7yTfLG3ui1M0O/YZpqkXhnV2qt04fL76rIhJhpRwE8D5jO+8t/zd4eCQJ1O
	29IvNRtN2QeKTreRAZdBZXAIekfiJn3pa2WDB27xSJ8Z+4rPT5SADOoqP4lJXh84hxv8kFolXTiuX
	fwVe3XTUMyBlmgM9qBoK/HqKCOTzIdFt+WbYmV0jBI6eTFPbAet7Uj0I4uO2lLbHhSCoHtwvI5aQM
	N6R9PdHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJ8b7-000U5Y-11;
	Fri, 29 Dec 2023 08:52:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJ8b1-000U3S-2z
	for linux-nvme@lists.infradead.org;
	Fri, 29 Dec 2023 08:52:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703839916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OfvH7AWX59Ms5JPy4x+Ke3bCDj01NX0JuiH6a1g+MrM=;
	b=eSoLf3jV8LU8I/3Q5qsZ6qN7B4NiUJZ1kdrwOGXdjSNWeSnDk8ok1M1bBdHlLgTIikJ8N/
	7KGfWXyN8gPmejITMM8j/sBakz97yBbnZ037ZLxLpWIY0tdUyK68XqccLO/GfiFgfaELQ3
	4v8n6rUzrjl7SEErmgCvVY5D7+Tfrmo=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-nxrCrP7wP6O2Mi8pCw2vTA-1; Fri, 29 Dec 2023 03:51:54 -0500
X-MC-Unique: nxrCrP7wP6O2Mi8pCw2vTA-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4b73b65c0dbso518300e0c.1
        for <linux-nvme@lists.infradead.org>; Fri, 29 Dec 2023 00:51:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703839914; x=1704444714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfvH7AWX59Ms5JPy4x+Ke3bCDj01NX0JuiH6a1g+MrM=;
        b=QzVTcZ4vsT06A1HHh4V6WTM37pIPi69vOEBpN/BQQkTs1SXyqzyraXtUmWMGALYrkW
         apBjEWMcNuPntt8+hsdEHVsbcfj/n+z3Iraev45K5Xr751Qyp7hkivY4+y0EpKldkOPf
         KyqFcYANpv6CNsJXoYMSuI/a3OBvxuSLOAZoQPn1kMh3e4nAD/nK5OieBjIDQSZd8+jS
         0k40q8RDDMhSKQfIJ0Y/25dSL9NfLeIvCh+ygr7b8akRz9Mz5dU7G28P6qRjOaww0XYq
         M1ry/GAr77OdQD8icMIFhft4oebv5fXSG3PHqvxlBPvDds429vEClIaLYAAiBaQtvhRW
         8VvA==
X-Gm-Message-State: AOJu0YwG+XS1tJbqVBflJzPUjzzPto1tV7lC99naN8f4cs4HUGIKlYyi
	P+/Opvyz4pG+J9f3+ZPiiZonr9FNhu7LQDkxm0GoCRlvlbGpdWDNdE02rAdutHvScf5LrV+hIn6
	3CcwA6+xVxHvLirianLhG2EMW/4McUPUznc2Wjq70eRG9NdGxdmc=
X-Received: by 2002:a05:6122:32d2:b0:4b6:e467:ec9a with SMTP id ck18-20020a05612232d200b004b6e467ec9amr5631798vkb.16.1703839914213;
        Fri, 29 Dec 2023 00:51:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMa6GhGCE6jgGJCmbe2QhTrSz9hBIiDzjywRpj68EXD+0Rhh207hSllzFixmvHfjH1tqjQZuXA459EvJ3cEhw=
X-Received: by 2002:a05:6122:32d2:b0:4b6:e467:ec9a with SMTP id
 ck18-20020a05612232d200b004b6e467ec9amr5631791vkb.16.1703839913977; Fri, 29
 Dec 2023 00:51:53 -0800 (PST)
MIME-Version: 1.0
References: <20231222151750.655751-1-mlombard@redhat.com> <20231222151750.655751-3-mlombard@redhat.com>
 <a2274654-bc7e-4a8c-a7f0-33da8a2147c7@grimberg.me>
In-Reply-To: <a2274654-bc7e-4a8c-a7f0-33da8a2147c7@grimberg.me>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Fri, 29 Dec 2023 09:51:42 +0100
Message-ID: <CAFL455mL42m80_qD9DBFLbAKi1Wi80rydM7v1-=dw1tfE575PQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] nvmet-tcp: fix a crash in nvmet_req_complete()
To: Sagi Grimberg <sagi@grimberg.me>
Cc: zahavi.alon@gmail.com, hch@lst.de, chaitanyak@nvidia.com, 
	linux-nvme@lists.infradead.org, kbusch@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231229_005200_043581_C1CAD792 
X-CRM114-Status: GOOD (  21.86  )
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

po 25. 12. 2023 v 11:28 odes=C3=ADlatel Sagi Grimberg <sagi@grimberg.me> na=
psal:
>
>
> > in nvmet_tcp_handle_h2c_data_pdu(), if the host sends a data_offset
> > different from rbytes_done, the driver ends up calling nvmet_req_comple=
te()
> > passing a status error.
> > The problem is that at this point cmd->req is not yet initialized,
> > the kernel will crash after dereferencing a NULL pointer.
> >
> > Fix the bug by replacing the call to nvmet_req_complete() with
> > nvmet_tcp_fatal_error().
>
> This is indeed a bug. However nvmet attempts to gracefully fail
> a particular nvme command when there is a recoverable error (see
> nvmet_tcp_handle_req_failure).
>
> In the case where the length is arbitrarily long, then it really
> doesn't make sense for nvmet to just accept it and throw it away,
> but if this is an offset error, maybe it is...
>
> I'm not hard set on this, but it would be beneficial to have
> allow some graceful cmd failure here...

But doesn't the nvme over fabric specification explicitly say that
those offset and size errors in H2C PDUs should
be treated as fatal transport errors (See
NVMe-over-Fabrics-1.1a-2021.07.12, page 69) ?
What is really missing here is setting the Fatal Error Status field in
the C2HTermReq PDU, that's
why I left the FIXME tag in the comment.

> Perhaps you can share
> more about what was causing this error?
>

Nothing actually, but someone could write a simple program that
sends invalid packets (syzkaller, for example) and easily make the
target's kernel crash.

Maurizio


