Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE3CD13590
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 06:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RWbVeDQibiRGrGF1sGsSz+HuOH9X89Swrib0axHXrYA=; b=JSUi0i3pswzwaRqwZwoEFR4eTB
	ZnTkATIPFrdrOAdhyOmcapES1y7eJkNgnjZESnoegqdb4S0W6opuxnNnxnq5KIckTZAJopGs3ZHCj
	AhbU8mSY7y1fu6TpAqOOTJg26PAkdX++GI673bgZ3Y5xqGwUOSbM4vFz0VTcUlnHKo/yjWvfS9Ypo
	wSfpVXblH2uuOSEBtU8UTy1knD/5rVDKcAcBPyXmWKMm3wzrUawnFl/hZvNI1v/kfn/fV4Rr2uwvh
	4TqsmLZvQ5dP9wVPlPKT9hNYiwN0FQDC7fO/I10IfPdZrAUw0jE9iXDCNIRmoGHxGaIy+AB5XKSey
	zoWwB49Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5g4K-0000000DPZH-3wcm;
	Tue, 29 Oct 2024 06:51:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5g4F-0000000DPXg-26GA
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 06:51:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730184661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWbVeDQibiRGrGF1sGsSz+HuOH9X89Swrib0axHXrYA=;
	b=dwXDXxmwLuhQFmkkkQaZ3WV7UlxM8sMhmF6Ymu9YvWvIxVRrQpA1318S4X+NEBKsq0KbYl
	Xt6lhl/bSjoEO7mnDaz2WbZP9hcBaWyWodnroOz1Hpur0lT+2zF6Vx31pxCou2Qu5zULrJ
	VTSFZZd25Vdn7bos9B9U+QVYWohlrJ0=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-TTFUQhquOlGzvEkIhUu5SQ-1; Tue, 29 Oct 2024 02:49:06 -0400
X-MC-Unique: TTFUQhquOlGzvEkIhUu5SQ-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-84fdac552dcso1910260241.3
        for <linux-nvme@lists.infradead.org>; Mon, 28 Oct 2024 23:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730184546; x=1730789346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWbVeDQibiRGrGF1sGsSz+HuOH9X89Swrib0axHXrYA=;
        b=JNvJUYNqHEHDnfXF6QnjmEukeQURbTlOVHOHsqc8SJYsBQIvBtQuelGWYjGZ/Cgxmf
         Na0ldoT/9cUpU2uAihKpmbQ9mvGjX60RT6W4evXtWpCKM/lVOBmIKIy+dg65GhcvMDx+
         KztQeTq/k/qPB6NnWsdSnOhR7YCvQdl77zGNZGvEcV8Sd4QG2R0A/sjHlIV6ywwsU7Hg
         EgoahKjlPNDF863TiQjNkTFA8wsHu8PSLyLbEHycyOED2aKYyVVP+jukmWC5YAsCEW91
         3SSwjjWXrRB+q3jwkDvzE5E8sk2R8pqaNMVkgpghtDYzBuTC5ax6HSInpKf1PbZUK1CK
         Yr5A==
X-Gm-Message-State: AOJu0YwfrYBWXbuAeLezDU19yBVJY+1V/urs8N1CeDfMUWD7+GE9fYi0
	xYNan27L9BXBX5g8+U06GUypIFGck1TXs2nKdMA+GCnYT5X3/pz6lg327ZpSM5zrYZ0W1L9JRzC
	yjbTGv3YWxRvohv64LhRZTbx+GTbxMQ8NxrKDyab49p+eBwWPs+htCGbxzVHaYQtMulggCGWi85
	ug8uY25pFFn8XeYW8E8ktny2m/rauWAP8gfAZYzS0=
X-Received: by 2002:a05:6102:3707:b0:4a5:c0e2:c42d with SMTP id ada2fe7eead31-4a8cfb45762mr9180414137.8.1730184546280;
        Mon, 28 Oct 2024 23:49:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGyqHjUq16O+NDw4Rec3l0KTk9hs6Iwak9YboGmcUomxRcaIDl0XVpypvg4nLO6LJxwAEWoNJ6R7W3ACkTFq8=
X-Received: by 2002:a05:6102:3707:b0:4a5:c0e2:c42d with SMTP id
 ada2fe7eead31-4a8cfb45762mr9180401137.8.1730184546028; Mon, 28 Oct 2024
 23:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241027170209.440776-1-nilay@linux.ibm.com> <20241027170209.440776-2-nilay@linux.ibm.com>
In-Reply-To: <20241027170209.440776-2-nilay@linux.ibm.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 29 Oct 2024 14:48:55 +0800
Message-ID: <CAFj5m9Ka-EL34DbDCm4kMYoWXfQ6GhMRPJykywE4RztbB3zXYg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Revert "nvme: make keep-alive synchronous operation"
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de, 
	sagi@grimberg.me, axboe@fb.com, chaitanyak@nvidia.com, dlemoal@kernel.org, 
	gjoyce@linux.ibm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_235103_764522_822823D9 
X-CRM114-Status: GOOD (  13.36  )
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

On Mon, Oct 28, 2024 at 1:03=E2=80=AFAM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
> This reverts commit d06923670b5a5f609603d4a9fee4dec02d38de9c.
> This reverts commit 599d9f3a10eec69ef28a90161763e4bd7c9c02bf.
>
> It was realized that the fix implemented to avoid the race
> condition between keep alive task and the fabric shutdown code
> path in the commit d06923670b5ia ("nvme: make keep-alive
> synchronous operation") is not optimal.

I saw you have discussed it a while, but it is still better to describe
the reason in the commit log.

>
> We also found that the above race condition is regression caused
> due to the changes implemented in commit a54a93d0e359 ("nvme: move
> stopping keep-alive into nvme_uninit_ctrl()"). So we decided to

Can you explain a bit why commit a54a93d0e359 is a regression?
And what is the race condition?

Without providing the context info, it is hard to review the change.

Thanks,


