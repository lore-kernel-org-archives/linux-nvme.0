Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A651EC25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 09:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dHYWo7AJN0rfRJomVFtwPdttTjiBmVaCckk3YlGRqWI=; b=HdJujoV4bc61QSkQOaPl+cFwUw
	SpvpU4ZriP4GgLlOEq0TgtAoc2S7Bxw+uhu2lpifezn1tALTpCcbHwHd8A4V0yVzSr9eaRiPVkygl
	LRcdIiXikGnRp1v8BJkTNoT3JE9R62dGVnu9RyAkxqc9kLtY6pl9s0O+loB4580UX0rHRPYkSLWZV
	o01Omj3oVt2wKRlJrCydOJoLQbXIkkK5Wfssqlfff1RX9ZbT+EhD73/HhxSeBFVSsNavQ6UH/a+H4
	qNFO/J6F83div3nZEBsZT11Y4tkbDQqCvUVzfu+Gaxl3N1CXnaAqBGLuLEVC2DoDHIMAJinWZgAe4
	AVLDZ3rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA57Y-00000005lPL-0SnB;
	Thu, 23 May 2024 09:52:24 +0000
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA57U-00000005lNw-0KhW
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 09:52:23 +0000
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3c9d0671dfaso3275046b6e.2
        for <linux-nvme@lists.infradead.org>; Thu, 23 May 2024 02:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kayoway.com; s=google; t=1716457936; x=1717062736; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dHYWo7AJN0rfRJomVFtwPdttTjiBmVaCckk3YlGRqWI=;
        b=nWIbfSqeIlibTVn1nDtZu0goZn2q2IizNgJdCWvtPTMW8jg2aHNL1d2+JHtLyk7Rbn
         o+iaPthQ/nZ5EbwVaiOqc1kbTduhWCFUdid3NIJEHL3zmOg81VDz2jXXjzGI1gHo40Re
         rvJaAZgTWrPVq49g+YbFyjAL4bV86aRK31Ylg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716457936; x=1717062736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHYWo7AJN0rfRJomVFtwPdttTjiBmVaCckk3YlGRqWI=;
        b=HIyWrq997VmmEjgcGJwfkKoq2NzwEI0K4KkPUYs/1e1j8VpbszQgaD/innUmNIzvoR
         mtt3+bm8So66eZKvFOdJF7P+m/kRhjdqdPAkg3C3Ho9+f5wsCV6/Ecid2VScmrej7hMp
         Qj41LesEEMKAnfSrms5ESB/st35jWKtnqMb2JNfQJHJbGsbXM/9R/xFeYxU4/Wd2OuEK
         5lyAP4oH7nF12Qs5mrx8u0O4zB2j7Gh8t4aaCJ7Kd3DctQC+SCh2PZf5HXNtOgqAn6p4
         OUUQIdH6xJ8EmVGwpJGb64F3rPZ+MkErVQZsjUzf5z0Yr1bGHXEplFa1cxY5KMrDtuq8
         c2FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGIv14vRPBtKkQZYeFbikElAGxEy6aNRaGNJNqBo7w6H4PSzfzW8ETnTBYNTokmKjk9ObAnmHYKnbRj0aH5sMgksMF8b9Z1WoXLxURItU=
X-Gm-Message-State: AOJu0YxwDwSeJzqr63WoamSeCyNWWtKNqJRwmC88wlwVds4XcZ4Vhwa1
	NQ354DikUk+s0HJa2EhO5CgKoFIvJziyJJzSU314paT7EkfWnM8HFvzFl+Ni8lxO8mhUNwcPshL
	e7oE1PdEwXWC+OpEqJYmxgYHFIwDppbu0uo4uxA==
X-Google-Smtp-Source: AGHT+IFRXfCJRZvMDw5c4colM68ONfkymcK5y53t/D8wFReqHs5pcT6wU5DrZ4L6cvhH7XW2WC/04S9gVfKsMsrbeV4=
X-Received: by 2002:a05:6870:ec91:b0:24c:4c82:4f15 with SMTP id
 586e51a60fabf-24c68b808f9mr5248818fac.24.1716457936055; Thu, 23 May 2024
 02:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240522155614.191849-1-dev@kayoway.com> <Zk4ulsDpokA-1RfB@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Zk4ulsDpokA-1RfB@kbusch-mbp.dhcp.thefacebook.com>
From: Jason Nader <dev@kayoway.com>
Date: Thu, 23 May 2024 18:52:05 +0900
Message-ID: <CAGvJ23pgwN9qZp5sOi1w6YMVM3d-=D5N3B7KE3+Rx1h5dG1AKw@mail.gmail.com>
Subject: Re: [PATCH 0/1] nvme-pci: add quirks for Lexar NM790
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_025221_015517_6ABE4052 
X-CRM114-Status: UNSURE (   8.09  )
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

On Thu, 23 May 2024 at 02:42, Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, May 23, 2024 at 12:56:13AM +0900, Jason Nader wrote:
> namespace descriptors.
>
>   nvme id-ctrl /dev/nvme1 | grep subnqn

Output below:
```
subnqn    :
```

