Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21FEC83F03
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jul 2025 13:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f0LwhhSKAS9rq9688GXK8zhFORyfbElYWA+ly5rGBPU=; b=jMwk8Ya5qadFvZoTThveck0y/6
	nvKwOpjUTOJ73kE922yxXpxb7F/0stf26PQpm+baNkF2U4J09Oz4hQ24M2xK5JtgRq8yvMOBqyO/1
	UtgSbdKCSTCdq50UNqJvVkZMfTHe6OXlZz/dukUe4sY+/1FdSHZ12MDPxCRYHhaBAssoeFwA1V3UJ
	HgqAXGwu67c1vhjKAgxNQcLC5j8Q5DrvfLdyQND56OtY0oFoWGqRpqniW0ZTB2p3rUxKxcRQvn717
	A+eOS1vKvuQshh4jG0pQdukx7zUJdex63oeaTcXOzDG4yCxYcMJLCo5RBsqa+eGVIh97lw15C6zyS
	ZaVL7u/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXgua-0000000EatW-43Sb;
	Fri, 04 Jul 2025 13:57:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXgcb-0000000EXYN-1CuE
	for linux-nvme@lists.infradead.org;
	Fri, 04 Jul 2025 13:38:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751636311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f0LwhhSKAS9rq9688GXK8zhFORyfbElYWA+ly5rGBPU=;
	b=Rge8RnIaIBNnQ6IG8nN0p+tbxUX5z1emj7fYIzG33ymiber2ijWcJLUch4UEM/6Xb3nfhb
	d/eB4es+iqE0S1wNS5qD3rttlgUaVzCzn5Rxbmf/Q4qiHo+Lxa1jLSTE/LErfVT6QAYgHx
	haq0kzowfIT7tiGh4USGTgIvuJywzTs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150---zOuifBOLivvrTNVtOYWw-1; Fri, 04 Jul 2025 09:38:29 -0400
X-MC-Unique: --zOuifBOLivvrTNVtOYWw-1
X-Mimecast-MFC-AGG-ID: --zOuifBOLivvrTNVtOYWw_1751636308
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-32b3ba8088fso5094061fa.1
        for <linux-nvme@lists.infradead.org>; Fri, 04 Jul 2025 06:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751636308; x=1752241108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0LwhhSKAS9rq9688GXK8zhFORyfbElYWA+ly5rGBPU=;
        b=jXPJ7k7DWHp5sY/LRT+j7fTtVxgx1oV3YATb0kwWRr0tcKOd6p4XjEDD0mEwq+9iNV
         JffzxjwxZXyFDtLSMsa5y3R8kPhFCLoUoMMrl/TsmRoD9L6wLObeVpjVI55CCaK1r1yt
         51gjSGF25hzbo0Q12HZAzvL9IFERT05JJwhQmXDhf9g1etLRhcYs5rmWLulL8Qkb5MSX
         b8KZDXmnUusujp4Y10KpL2+KAU013eUI2AKDPh3a11x32JXUJZUYli7Su3Q3a0E+Qbd9
         tbQE4RUNhMmOPxYDMWUIRPbpehpRFEP6DldAjq4hHB9BBJB+TmPu6acKIEdH1V3ilmCU
         fIHA==
X-Forwarded-Encrypted: i=1; AJvYcCXNp3ghy9+Pwi4nqDUTbRWjpZijSPE6j1CGc6+FVaCTJj4WQHUQcEqzBR7Edw6id4PqZcbT6BLbnv/u@lists.infradead.org
X-Gm-Message-State: AOJu0YyBmjFr+3vmkLdVV6E+7BynvvlqEqrOwXAYRgu72NJWzGZiiSX9
	HrHQBKEU+LDV3zcC2qqqF052NX9VEHCfx3sgnHYKR0C1R+a0sOxqEpoZv1KW/XVCvF7Z1kRpTMz
	azh/MpByBfk5mTSQXVJAKOJVsHtFpJf8fav0r886Cwtgdy1MbyhhSTlpyccwgdPhs+ukoyAkZqo
	QdLkkLa9+tLpHcNkFIHmsQvgNZK/LLwp0UqK5/s6IxKX4=
X-Gm-Gg: ASbGncv1Xft8nyqO2kuIQyd4ENKkFa5aaFzHX8/qihmJF4lvhIEdmL8w0t5B5nZVpdg
	JnqMUK9yb7JO0V7q84NpWzC0asVsjkT9Cn63T99gbHzlIvp3Od+7XhBVZycTuH/2jWSN21I7xAo
	MJWA==
X-Received: by 2002:a2e:a01c:0:b0:32b:56b3:d35e with SMTP id 38308e7fff4ca-32e5f602f69mr4968841fa.20.1751636307989;
        Fri, 04 Jul 2025 06:38:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTOeLA4a8sWQdDmY2XwyBSkX+j6bk0YsxJsmNYE69UtQ1grt4HLkEvANqOSyCUqmP6VBgFXQtwwI2iq9F+sGg=
X-Received: by 2002:a2e:a01c:0:b0:32b:56b3:d35e with SMTP id
 38308e7fff4ca-32e5f602f69mr4968731fa.20.1751636307512; Fri, 04 Jul 2025
 06:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com> <20250703114656.GE17686@lst.de>
In-Reply-To: <20250703114656.GE17686@lst.de>
From: David Jeffery <djeffery@redhat.com>
Date: Fri, 4 Jul 2025 09:38:15 -0400
X-Gm-Features: Ac12FXxwOEfJeSt_DtU3lzqNkoWZYOv_HS6yyS3Ns8ZeN5Ywx-N5Uhun672eW6M
Message-ID: <CA+-xHTH2rxWwAao0EuNbhubqA2mrXOTZ7r1p-hcTieieomx75g@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] shut down devices asynchronously
To: Christoph Hellwig <hch@lst.de>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Martin Belanger <Martin.Belanger@dell.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, Nathan Chancellor <nathan@kernel.org>, 
	Jan Kiszka <jan.kiszka@seimens.com>, Bert Karwatzki <spasswolf@web.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cpWV5aVOPfZ2I5pftyPhjCE1VyqTpiYH2zkX25UkHjs_1751636308
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_063833_394166_2379F347 
X-CRM114-Status: GOOD (  16.04  )
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

On Thu, Jul 3, 2025 at 7:47=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Wed, Jun 25, 2025 at 03:18:48PM -0500, Stuart Hayes wrote:
> > Address resource and timing issues when spawning a unique async thread
> > for every device during shutdown:
> >   * Make the asynchronous threads able to shut down multiple devices,
> >     instead of spawning a unique thread for every device.
> >   * Modify core kernel async code with a custom wake function so it
> >     doesn't wake up threads waiting to synchronize every time the cooki=
e
> >     changes
>
> Given all these thread spawning issues, why can't we just go back
> to the approach that kicks off shutdown asynchronously and then waits
> for it without spawning all these threads?
>

The async subsystem fix is something that should be fixed regardless
of async shutdown. Async shutdown's use just exposed its thundering
herd behavior which is easily fixed.

Reducing the threads is just good optimization. Doing every callback
in its own thread adds extra overhead which isn't needed to maintain
ordering and async shutdown gains, and combining sync devices into a
thread where reasonable didn't add that much complexity to the code.

The older non-thread approaches were unpopular with how they still
added plenty of complexity to the shutdown logic while pushing either
ugly splits or their own thread creation down into the individual
shutdown routines of drivers.

David Jeffery


