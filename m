Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10E0C3ABAC
	for <linux-nvme@archiver.kernel.org>; Fri,  2 May 2025 13:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fw+2fgqJXUvfDafZCmkw7YHyRvYA12vaOFaX55khMis=; b=zCtVIwaIyWnZWGOKi1cF4Ln/1f
	Ra3q6uecjy10of2HHkV+jAnxp6tIVPyxUzwd8XvYrA/lC1UTHxV9Bc3M+u9XbE2JnuVNPBpGg4Aai
	IFw4fnfzNHeEgnyujwZFuqZhiMfGCmj7PC9u+/GNqnq7cSs2gl7ivshzkIGh0+NXD9paiTTmJ3Ce/
	GVvvjSveB+AVgzAoG51GsIA4kTq6f8mfl1OF7/PTtNyM2+PzJxRW7Sudg+FtQvWq7BUMXcjyEes77
	JP4vMxxbfBbYlqeUH/tSXyhE0TCUHBzZsiSyAeBCwnrWECDcI+DJNiLhBaUAZwRCBm1RYmKew+Okl
	CzDUk+KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAqpk-000000026vW-3x0C;
	Fri, 02 May 2025 13:53:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAqpC-000000026uA-0YfU
	for linux-nvme@lists.infradead.org;
	Fri, 02 May 2025 13:53:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746193989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fw+2fgqJXUvfDafZCmkw7YHyRvYA12vaOFaX55khMis=;
	b=i7PkFuZATudKsNWmAKXRuq3+FSx3urb7lV80XbMzgTU73Eoq8SuNLBDYWnLYSDNjl4XdDs
	M6BGw6nGMvljcSWXhLlZdH/rQyLoVLzPVBluQ//f8qJ436xlc/zF0ZjGJrmIfEm8+ACJ1I
	8OT4AgoA3FMOKUtfbqO/nhvJMEulUDQ=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-0NooPpP5Pp6QTKqnj8jGOA-1; Fri, 02 May 2025 09:53:08 -0400
X-MC-Unique: 0NooPpP5Pp6QTKqnj8jGOA-1
X-Mimecast-MFC-AGG-ID: 0NooPpP5Pp6QTKqnj8jGOA_1746193987
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-400b3a7e434so1536646b6e.0
        for <linux-nvme@lists.infradead.org>; Fri, 02 May 2025 06:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746193987; x=1746798787;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fw+2fgqJXUvfDafZCmkw7YHyRvYA12vaOFaX55khMis=;
        b=uKTHbRlOtLMkiQB1Eq3nP5M/NAhsllMaT02Pzd03Y0tihXTo55mADO0+PMg2RSc+4x
         mdQnYsdjCdJcmCkFZm0qllXIeoJEr7S866YC8tGuZ60ynunavq/fZOSbI3Qa1ENOlvjw
         jOQjxXBB5kq9v2cmFh7BoRKHRR5U0WtY1Ek35XaNDv9EQ1zqhOXXTudsMjOnbEuhYRjr
         3lV6pz+9/cn+9WDqLOrX3OaU7pSQ0I0EfoZbjft2p8DghWbpUsvAtxrR8JDYZQ6e3v29
         45Q1PzbGvNyGF3NG9sdEeh++t9oCSyJjNoJ0ZZv1D/sUVIL7C8RRsDxK7BfzvOqLd6e0
         wGGg==
X-Gm-Message-State: AOJu0Yy1lzHqThVQEww64Kv1C4gpTyggg4IHmxsHE9a4vqFsC8pPBcAv
	xBbtD/P0ediq1AeUw1iCRkUzXY5Avnw/qFAXn/0sT9pdw8XptCkrr8QA3lLD9Zi38EUjswMb4oD
	HHeJjR9tovtAAZgW7/K6d10b0URQEXn/3/oIXcGaTicDOnUN/6Df/d3daILLSOjUx
X-Gm-Gg: ASbGncs5ElIs53p1bq5fHjdDOUTV1o2BmPBKMvkL13wnr/1AdaSNenlJ9jygrOSjLMW
	bFXN5VDnYj1K2ShlirY+QXnctvRVrsfwknri9rKYV0Qn2LTflUEGuK7uVCHBWC0/06UDZ1Plp+m
	h3jSeW60vCazFGMCPaVduoT6V2WJ30K0wJBxkaxRuIPUwfzZIl5WD8LH49aUraMhc1CzT/aWe3O
	Rdu2holq6Hji8k7t6YGl+JoNJc8ye/tJkOaHx+O/awb80V26Bl7O0pPEJ4a/nZ6Nomy6E/DGhMR
	e4do1uc2hhSl5AwepB4Mlxfb8EpKc7dfrwHX2+IjslARv2Uea+peqkcTOiUv5A==
X-Received: by 2002:a05:6808:6a96:b0:401:e610:3c56 with SMTP id 5614622812f47-4034138833dmr1703554b6e.13.1746193987352;
        Fri, 02 May 2025 06:53:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9J3Rm/9OufCsJh+twRbuyVXmrf1LSGsq8nqx7UvZL7sv6WsC9sRIHvSPGFbm63n3+VyPuoA==
X-Received: by 2002:a05:6808:6a96:b0:401:e610:3c56 with SMTP id 5614622812f47-4034138833dmr1703548b6e.13.1746193987037;
        Fri, 02 May 2025 06:53:07 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4033dc61752sm565808b6e.40.2025.05.02.06.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 06:53:04 -0700 (PDT)
Message-ID: <5356546913f4961efba282b0e12ac4344beea027.camel@redhat.com>
Subject: Re: Samsung  PM1733 MZXL53T2HBLS-00AH3 and duplicate id's may need
 a quirk
From: Laurence Oberman <loberman@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, "Lombardi, Maurizio"
	 <mlombard@redhat.com>, bgurney@redhat.com
Date: Fri, 02 May 2025 09:53:03 -0400
In-Reply-To: <aBSnz1r3NsoUya4b@infradead.org>
References: <b368dde2186500caf71464bc966cf22953c5124a.camel@redhat.com>
	 <aBSnz1r3NsoUya4b@infradead.org>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MDYLKnrLnjKwGYh5JPNE5bM1pAgGNI2lrAlU_xaKuE8_1746193987
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_065310_239469_62787244 
X-CRM114-Status: UNSURE (   8.78  )
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

On Fri, 2025-05-02 at 04:09 -0700, Christoph Hellwig wrote:
> Please ask the vendor (or OEM) for a fix instead.=C2=A0 This is gravely
> broken behavior.
>=20
>=20

Thank you Christoph
I made the vendor aware that they need to fix this.

Regards
Laurence


