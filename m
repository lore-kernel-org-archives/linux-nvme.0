Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B131606A323
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZEQ/L1lO;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b6ibng1k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gAip8rR4cBji/1rtWgZvTXrvWISPk1WV5GHGd64KE98=; b=ZEQ/L1lOCPbOIa
	lWy2m0VC67IloBITik0mNvOvFQYhFJPCG/l7YMHP86RS6pYwOjXtN909eK6Men6e2lGuqrZnE6V7J
	dZbGi71d1pTgjl1Hncj+CYq5bW9zMmfkXo+w+RoAzx1uwyyUJU8QdfPLIZQGp+IX5maxcF/SN7y/e
	7KendEIt2y/7TY9LTpU1xYES3AO4VW0o7NXZlacsOoBYPjUYQ6hbXEgqckAVQBrvu2KdpAzFp0UaT
	g0r105tyC64LdJOgN+Y5u9oyJycNuigQtjtWNyEmwJs85CRqodAAL6yELtsfkfGhRcMt5htowc6Tw
	oO+oww9453B7wPbtrp6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRqul-0000000CogD-0t3W;
	Fri, 13 Nov 2026 13:01:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRquh-0000000Codj-1bsv
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 13:01:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794574912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAip8rR4cBji/1rtWgZvTXrvWISPk1WV5GHGd64KE98=;
	b=b6ibng1kNkusu997fAfWhxqmCQmbJ64MBrKWzzY+2mxeTap6UFrZcXESvXjEXHjD30d4vf
	UteFqURs4QA+Eft2sn3cxL2AT0QG9ESVyQw+A9rUOeZXC4+Hj8BxVFBadWeVyPuyeYR8uA
	BbuGKXnY9gmaEZtR3OEyAgkhCLeChYY=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-_Kzv791OO46Xn-hbH7cNnQ-1; Fri, 13 Nov 2026 08:01:50 -0500
X-MC-Unique: _Kzv791OO46Xn-hbH7cNnQ-1
X-Mimecast-MFC-AGG-ID: _Kzv791OO46Xn-hbH7cNnQ_1794574910
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-7170b84e158so1312865eaf.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 05:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574909; x=1795179709;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gAip8rR4cBji/1rtWgZvTXrvWISPk1WV5GHGd64KE98=;
        b=rBEEEPpsoLv3L4tFXr6xjRs/tn/MUTBwExdbAmVKRUH6kOw9qafSVmElgqY23mMJd6
         pZkk7oAXRiYv2RyS5BV1aSeZJ3xV/IN9SqrEz7R2wKEiA0o5ZyG6H/dOz9Mm5zQzZ6Wu
         Jxpqfuu58T7ZqHdGOEP5+X+btUEXCz4+gUdErkyLqPk0n0vhpWh+PXSiHuhhr4cRaHk6
         IywgJqBF6+OFhP0Ih+M8wDJF2T771hBNlZVoUIHYj/R9RsuN2ldcrqjKSPfkIma3ORqe
         IgCfCvTc/csnE2dCa4GhJHANo4qSOSC4qBhzi+z5x9qAQMFXAkpZRmZccY3nT8DrqeHR
         M95Q==
X-Forwarded-Encrypted: i=1; AL+hErGvR6chQ/TphVC9EHzKQPIC6nPsnzpwuW8ZdLaZRh68z0Dt3iUuK1If7twWGhoTEGPzvKZe6GIj3JSV@lists.infradead.org
X-Gm-Message-State: APuU4Z/arOpjKe94E6TRWgFYhB6QN7Lba/tBWpjMHPRkKozWOSXgwVwQ
	3qruLsiRpG7klVsK3xRhJV6fa3SSta9PEFHff5uDX3QKZhVhu5PdQm1sGKHyXadt8S3o70OrTc7
	05QDv15wYpOk1vbvjdh7FnTstRTIMfwHB4SEMn21Nv7BZBoKPklwmg5IzFBgT3VjpV4ZT9izCqm
	x8
X-Gm-Gg: AYBFou2RL51qSLoqt+KnKzA8XTb8m2X8TegtYAzOBulOkwbx3l41XJZlBn3c2MB3Qsk
	8OM+OLU8Wo3qwHT6lBetTEBKcWX4KFHuyDGyOkoeZeuQDsuxfDVglNwhoh/BFM5wd3yY97PCG7/
	yrtNeNKdjdtGvDEyMrrbljxtA53GwaKKhb222j9FQvwAIi4dEvvTab5dhg2a1nOon90PtqOsK0F
	5snnTseg4+8wN6wzeB5UKZzn9TTfpscwtr4XfoT5H6oNpqvm+Acz1pmTH9iV2gRovFNeXkXjuZe
	+JMykWUcwXEp8o68MXcNhhFx7PnZXFM2htGWG9yAXfSMUFpkwSndS5I1hPY/IJQICjrhtU0cJFk
	P2tRvjxpE+IbcaxspYv5tdaRB84OCX05s+OBB7Mi8c0ID3G5bsmrulZ8RIIuW8TB4rsL0IOFTjg
	aM5ovqJYWeCfAv5AwvWUu9Q2ITx3nRrOsWRl6jucRpcBxiO5Aflc2A+uIH22BCcqDk1wL+lTw=
X-Received: by 2002:a05:6820:418b:b0:716:d48a:ee91 with SMTP id 006d021491bc7-71ab4f5f7eamr1519040eaf.37.1794574909548;
        Fri, 13 Nov 2026 05:01:49 -0800 (PST)
X-Received: by 2002:a05:6214:5001:b0:91f:c42:206e with SMTP id 6a1803df08f44-91f2412d9e6mr33482616d6.11.1794574897608;
        Fri, 13 Nov 2026 05:01:37 -0800 (PST)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d70489sm19476226d6.21.2026.11.13.05.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:01:36 -0800 (PST)
Message-ID: <31da2c0ad81f8d6728f5ccbaedf23fb8148149a2.camel@redhat.com>
Subject: Re: [PATCH 0/2] nvme-fabrics: bound reconnect_delay and
 keep_alive_tmo
From: Laurence Oberman <loberman@redhat.com>
To: Martin George <martinus.gpy@gmail.com>, linux-nvme@lists.infradead.org, 
	hch@lst.de
Cc: kbusch@kernel.org, sagi@grimberg.me
Date: Fri, 13 Nov 2026 08:01:34 -0500
In-Reply-To: <20261113100951.17577-1-marting@netapp.com>
References: <20261113100951.17577-1-marting@netapp.com>
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RodQ4N3EV58hZbC3g9FTTjJVWFDrWiH5KdqwsnwnRVA_1794574910
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_050155_633019_847C9E0F 
X-CRM114-Status: GOOD (  12.32  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-11-13 at 15:39 +0530, Martin George wrote:
> reconnect_delay and keep_alive_tmo (kato) are accepted in seconds but
> later multiplied by HZ (and, for kato, by 1000) in 32-bit arithmetic,
> so=20
> large values overflow and yield bogus timers. Bound both at
> parse/store=20
> time so the conversions can't wrap.
>=20
> The target already does this for kato via NVMET_MAX_KATO, and the
> host=20
> recently fixed the same class for admin_timeout/io_timeout
> (4a5aeebf1a00)=20
> and partly for reconnect_delay (f92fe8dea19c).
>=20
> Martin George (2):
> =C2=A0 nvme-fabrics: bound reconnect_delay to avoid timer overflow
> =C2=A0 nvme-fabrics: bound keep_alive_tmo to avoid overflow
>=20
> =C2=A0drivers/nvme/host/fabrics.c | 4 ++--
> =C2=A0drivers/nvme/host/sysfs.c=C2=A0=C2=A0 | 2 +-
> =C2=A02 files changed, 3 insertions(+), 3 deletions(-)

For the series:

Looks good

Reviewed-by: Laurence Oberman <loberman@redhat.com>

One thought: fast_io_fail_tmo looks like the same class -- it's
scheduled as fast_io_fail_tmo * HZ in nvme_start_failfast_work() and
isn't upper-bounded in the parser or sysfs store. Might be worth
folding into this series.

Minor nit on 2/2: "1000 >=3D HZ" doesn't hold on every arch (alpha
allows HZ=3D1024/1200), though kato being unsigned keeps it safe here.


