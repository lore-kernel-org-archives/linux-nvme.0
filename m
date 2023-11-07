Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17E3C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 21:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E4AIIfQ2XOyOysDBTT2wa7o4CsNHTT/WlgwWYh1K0Dc=; b=UssDkArvx3W6mp8sMXjEShU6f3
	1kLfPm08sIOM0uEyV56yAtkH6k7vy90EIc5EHVJOmYoI5wGMcrGFU4HCOOlwVrvltWA+jaEI9jteF
	E2Aof7Kdgm6wKkk1xkFaepZZNiRWUQjXI+OWA0lExxYDbnbo+JsV1vscUiuaDcx+LGSYC4QWUWWJu
	imxmGOwdzYXHEWSsgt5CFag4tERRTzuswNB1s9eCUXIVOH+irX13mJvy3uOvYmrP6uyUK8w+PYKUE
	WiZcYOVdwodm/vNi3VjLOsiSHooJyjboGZBBC45gZ+yfIarJGOTj3NfnqVq2g38JeJSVe6fUfyQO3
	C5k1y7Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0U3j-002U3F-2n;
	Tue, 07 Nov 2023 21:56:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0U3h-002U2k-0S
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 21:56:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699394188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4AIIfQ2XOyOysDBTT2wa7o4CsNHTT/WlgwWYh1K0Dc=;
	b=OWARoDzkRh54j7yWjmpX78cbEYyXXP1Gke+TzdJDK3ssBuxMIBaHkxhd7GwxpgsnmYCWqs
	RqII/5l0nXjQI7o/h9HYaNdb19heiiFX9918qFKY3XNMgtauNfnddRh7Rf512UH0vIYwdJ
	PIeHgw9WOFQVfC9KW3sSYKocIXH6Td8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-YbchL1ZUMP2hXS9ZQMSEQQ-1; Tue, 07 Nov 2023 16:56:26 -0500
X-MC-Unique: YbchL1ZUMP2hXS9ZQMSEQQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-408508aa81cso40563135e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 07 Nov 2023 13:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699394185; x=1699998985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4AIIfQ2XOyOysDBTT2wa7o4CsNHTT/WlgwWYh1K0Dc=;
        b=F1RmuYPhygJ7d2GjCQRCiTwSAMIXK04OWOghQ5gCP5F88KZx1e4aeuP9w+uwjDgD+V
         Z7fQvzwQ9eueKeh10mGQV2LZDDeG8GhwKQ/zIEps9Ny/wB7cSzCtb5g9qA5ZnD0lZ+qY
         VbE2tYOT7gW0FzybsnTiS7dtLOM1l/BFD8TRUKSo76/jx7T6P3dysihoqlzbtr0XPiit
         gw4ljAuJAIBlUpo9tjJWGJOWS9SJjzobyNAiGhIK1Y24Lz+dcr1JY2UViG9GXBmSaEnY
         Mg9kTDImw1Q3t89evk6LA4NH7buzp/v7Gxmw5NasNj3J5A1F9Kc45tWhteL7pYVN8RLn
         U3DA==
X-Gm-Message-State: AOJu0YyCt9Gp+zavRXcNPJgOateY1aKNpoISFaR0wAJnfK7TAP69k3Nr
	uOTs4kNYrI9UQtWE2XtEhUBZjf8ZMegOjf67s5z+tokTNOERf5ITyZPHIpBEWGnYnpBMvlJZHLh
	rfzY0+B/LrQ7YqsdLxCWY7H5G52gpohzW5LWycLlKXV4=
X-Received: by 2002:a5d:64a6:0:b0:32f:c29e:583a with SMTP id m6-20020a5d64a6000000b0032fc29e583amr9880wrp.56.1699394185625;
        Tue, 07 Nov 2023 13:56:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXeKKQlTh8DzBqJLbb5l7WyncaK99O8ZQaUH8oc97FDZHE0XFNzQMiQini/fNNXkMlYBAw8zxgsWuhn5gnvN8=
X-Received: by 2002:a5d:64a6:0:b0:32f:c29e:583a with SMTP id
 m6-20020a5d64a6000000b0032fc29e583amr9872wrp.56.1699394185346; Tue, 07 Nov
 2023 13:56:25 -0800 (PST)
MIME-Version: 1.0
References: <20231107212331.9413-1-emilne@redhat.com> <e7b8ee83-c63d-4b65-b446-2bdbac0084e4@nvidia.com>
In-Reply-To: <e7b8ee83-c63d-4b65-b446-2bdbac0084e4@nvidia.com>
From: Ewan Milne <emilne@redhat.com>
Date: Tue, 7 Nov 2023 16:56:14 -0500
Message-ID: <CAGtn9rnEqs0OKeg52+UCwkvU2kiVkMKDXe-pxDUHn-77i5e9sQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] nvme: multipath: Implemented new iopolicy "queue-depth"
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "tsong@purestorage.com" <tsong@purestorage.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_135629_247423_47747B0F 
X-CRM114-Status: GOOD (  21.71  )
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

Yes, we have some graphs.  John M. presented them at ALPSS and there were
some earlier ones at LSF/MM.  I'll see if I can put up the latest set
for download.

The basic issue is that with round-robin, requests for most/all of the
tagset space
can end up on a path that is responding slowly, so we see a
significant imbalance
in path utilization.


-Ewan

On Tue, Nov 7, 2023 at 4:46=E2=80=AFPM Chaitanya Kulkarni <chaitanyak@nvidi=
a.com> wrote:
>
> On 11/7/23 13:23, Ewan D. Milne wrote:
> > The existing iopolicies are inefficient in some cases, such as
> > the presence of a path with high latency. The round-robin
> > policy would use that path equally with faster paths, which
> > results in sub-optimal performance.
>
> do you have performance numbers for such case ?
>
> > The queue-depth policy instead sends I/O requests down the path
> > with the least amount of requests in its request queue. Paths
> > with lower latency will clear requests more quickly and have less
> > requests in their queues compared to "bad" paths. The aim is to
> > use those paths the most to bring down overall latency.
> >
> > This implementation adds an atomic variable to the nvme_ctrl
> > struct to represent the queue depth. It is updated each time a
> > request specific to that controller starts or ends.
> >
> > [edm: patch developed by Thomas Song @ Pure Storage, fixed whitespace
> >        and compilation warnings, updated MODULE_PARM description, and
> >        fixed potential issue with ->current_path[] being used]
> >
> > Co-developed-by: Thomas Song <tsong@purestorage.com>
> > Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> > ---
> >
>
> any performance comparison that shows the difference ?
>
> -ck
>
>


