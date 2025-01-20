Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C1EC02181
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jan 2025 16:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4wpnomT5QBU7SLdC6q8LZHFoRzA0TKt2BnVFF5D/DDw=; b=lTgbA4LyrRqx7fc10JSjMnLSSY
	ujSzfTPqD36XsSDAb2yQchP7QyUh49nURnJxl50rL2H4V2RUcuyZ0s3+5UOFjDLMf0K9qwLhuKGwZ
	tDdXIWhpwHdcO0HLePN6hqvDrlgDQ0NOk85TUHfBdrJL1cuy4ERYdEOIfLIkQKNF0SVwCURH0698A
	SOHMiKJZ92/JL57rWoyobM6IrpTIfcaAo2NkQp0fqW4QZYYNgjke8/LOzlAidp9EuxiF9FHEImTfL
	LeWqRNCc03qqOzoJksVTzr/KuwXjMCoJhCo3TdJOtIKFp/t4R7+SN0V32mbXdllIuRwl3idvc5XPd
	uLpeY91A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZv5v-000000064Ab-0XNF;
	Mon, 20 Jan 2025 16:57:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZv5s-0000000649M-21Y0
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jan 2025 16:57:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737392261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wpnomT5QBU7SLdC6q8LZHFoRzA0TKt2BnVFF5D/DDw=;
	b=LS69pWWugic3Abv4cEwHfvKuSGXbvg8+APjuyZtk6hnhPTqtEcfk+2zy5jqkb+UWMUALCi
	p7pUr/2mZwI1x8X2WuRfsimrQ/84SJ1BDhWwCwxQnsHOYFFaoxueFqb12yXV/GD/45VBJC
	ESxnZoS2xN6V3WeT46F+UB7qG1RHPqk=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-ZBDNOgTMPGat13DeEKiUZg-1; Mon, 20 Jan 2025 11:57:40 -0500
X-MC-Unique: ZBDNOgTMPGat13DeEKiUZg-1
X-Mimecast-MFC-AGG-ID: ZBDNOgTMPGat13DeEKiUZg
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e5505f613e5so14021902276.0
        for <linux-nvme@lists.infradead.org>; Mon, 20 Jan 2025 08:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737392259; x=1737997059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wpnomT5QBU7SLdC6q8LZHFoRzA0TKt2BnVFF5D/DDw=;
        b=JCccFtVn+FbQKS4xhuGvFQn3Rv0Vw4sVWXPTfRzZIOqqrqsTOMuLrRW0VMshNhEwsq
         OLDz/uSYWqCtZaTd7OaZVRnEWFMJ4yivrX2eY4R3mKcaDepgMN3nk12gzTnlte4jw2vg
         l4y5NhAaiLIM9zJPuw5k5DungS4PSjJ5CCSo5C+EgGWuMrxvocyr0n4DIUMnnQTbDQ+k
         3h8yxoW22uAxEhmuWMT4a3hIoWik8yMwIkTePMybPZmeI6Dr3KDE1TG8UrwFrBII3ADW
         5j+yOLaoMRyq3zc/ze3shSyFmIguihVadJCCTNLUlsQGkeuFTSiqjtm+ezx7sBWTqFOt
         OE3w==
X-Gm-Message-State: AOJu0Yz5bHdQjfCHf6IbIftwxOUZP0iaZceV8NHMwnlgoEZudpGtY2tt
	UgOP22LUG++RonK2nominSZ81RJdkeMWfgtvWxcSN4Mbd7HktdBzYGXvmXkC2TsuIkXFJePMi+w
	PmWLlQGOM8K84zDUnvkLas5E4uVBudgW1MYAivcdNzcwtGIf+IOe3yuEtYZgsbcHSnfuPBluNXp
	tDKJkDnVupJjegDDk6qG4ZwD0j61+VzIk4Pyw/L9U=
X-Gm-Gg: ASbGncvfr2dO+pGRABqRcE4YD7evOWrtlAeyxafMN6OpAbmvA0uGnIFo6pEL4+RYTac
	UjNcIDHY8wxckk+5eH0whIU/3s5o4JD1eteNIcmno7nXswikW8vo=
X-Received: by 2002:a05:6902:2702:b0:e57:3da6:a1dd with SMTP id 3f1490d57ef6-e57b0c833d3mr10007610276.23.1737392259610;
        Mon, 20 Jan 2025 08:57:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUVGQ5I9iWacAXKx6eZeH77ygd0ObieIw1SFWg6fk0jzQEaTWDAk8QBQIlc/kyc4VfPeaCigObnDk59adb+3k=
X-Received: by 2002:a05:6902:2702:b0:e57:3da6:a1dd with SMTP id
 3f1490d57ef6-e57b0c833d3mr10007596276.23.1737392259378; Mon, 20 Jan 2025
 08:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20250116201527.9252-1-kch@nvidia.com>
In-Reply-To: <20250116201527.9252-1-kch@nvidia.com>
From: Ewan Milne <emilne@redhat.com>
Date: Mon, 20 Jan 2025 11:57:27 -0500
X-Gm-Features: AbW1kvbranbR8fBKwlqBi2Junqcd7g2_tPQQ4IytGnBX0JSghRgJsvpvw_EaQBc
Message-ID: <CAGtn9rkEmr642V4851WSmKsfcs=qOSogZ-vGXkQfoVaXLFMXWQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-core: decode the error on add disk()
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de, 
	sagi@grimberg.me
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6axr3uo3HMdgTZrpmQ7rzubPRlxOHiFxlMG8LK6_GjQ_1737392259
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250120_085744_599984_B0C9C112 
X-CRM114-Status: GOOD (  10.06  )
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

On Thu, Jan 16, 2025 at 3:19=E2=80=AFPM Chaitanya Kulkarni <kch@nvidia.com>=
 wrote:
>
> While debugging the problem, it is important to know that what exact
> error returned by device_add_disk() along side the disk name. Print
> the error along with disk name when device_add_disk() fails when
> allocating the namespace.

This is fine as far as it goes.  Looking at the code around namespace scann=
ing
there appear to be several other places where an error is silently handled =
and
the namespace won't show up.  e.g. if nvme_get_effects_log() -> nvme_get_lo=
g()
fails in nvme_alloc_ns_head().  That is beyond the intent of this one
patch though.

Reviewed-by: Ewan D. Milne <emilne@redhat.com>


