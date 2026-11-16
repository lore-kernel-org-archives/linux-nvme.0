Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384CA606A32C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FmTJhd4T;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fUevHugf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=uHbg2HzLCA2EqXujQVGgAMakXQXDDTDr0qqnRFlDbJ8=; b=FmTJhd4TMgbtC9MsJADb2bWaOH
	8iX5AwkJHkQUNFFkMsHKgLz5PB+p2cHiky3LmLCmFfLB18nY8qTUD4O1clQfHZ1PmI5KMueUan0Yc
	SzjmcAXYWDDZW94w9QNOGcp9WDnnMy18hov8MNBsb0MrfOs5ndDqnocVGuQm8VKBCerQ0jaTWp41D
	NOBV3lTIisf6qpQLUP0MBaNIYJzxhA2tjRaazyANRc0EkkW8FiejbknerPqIEM5V2jrT7tiYoh99R
	KJgSiZbRicqtsXcYpt21NBw1YnkJX8NDeeVAmnrC7mrfS1k4M6kyv4fftGs1zGZhnaO5wCsp+XzVk
	x5oViPbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xStYD-00000001t24-2JI5;
	Mon, 16 Nov 2026 10:03:01 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xStYA-00000001t0Q-2SaW
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 10:02:59 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-3b0d09df973so3837233a91.0
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 02:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794823377; x=1795428177; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uHbg2HzLCA2EqXujQVGgAMakXQXDDTDr0qqnRFlDbJ8=;
        b=fUevHugf788VjmKfZYWFFVm/mE3XDQXc5a8MFvlNtRBy2v06gI2CSQkTl8nq0VsBdg
         +H9LxrMGYYcSK7TcKYRY35c8PxIOPVcA5fNbHSFO+GBqvMBBQ7aIowEGmZzfS2PsacUi
         g48cuANkeyA/pjbj6KR2JGmWG6ULJKvVcxY3shZ/sIHA23qS3CX+MEqFx1XRvm59vA4T
         4IRVh700BXGF7gixNcS05u7nMuDJhm4zJgzdcbKOTfv2L8vzP4qkm47fXe92nwpw7S/L
         DPhbtvRT7NPlQArbFIKuthkyXms22swSw5rG4OiCBMs6wDt2sEgVaT/QgSZ8F8DftMmI
         Opzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794823377; x=1795428177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uHbg2HzLCA2EqXujQVGgAMakXQXDDTDr0qqnRFlDbJ8=;
        b=XzeLi08RY+ThVoReMtat6Pi5//IQAy5yM2IR3+3tfkb4xp1Nj+nVJjrLOVSKttHCXz
         PJ/dCAg5hBYdaJM+mDQ0rTOAHJOVwwjfmzINR27N225HfTAKxfPTK05gepfK5mMAkqPn
         0uQ2FJNhiiqfCH0g9ADPdUO9Uvblw3zNLW9BXSKM7+9TBrla9UvFw3k8FwmPz782Et2r
         Es2fBQUYOJcpN6XSB5PFvpXBfQA4J1nKrmjbgSefJGY0efDEXPRMQXmUcTj8e0BFRs12
         gIYuAnRBBE3zlMVOAjw+u537Kru6aqpPYwm4RyjZQGK8jPujUrjQNjqTDgsXmbcgc8/H
         Nu1g==
X-Gm-Message-State: APuU4Z+b2hpzfBK4DoFTjvaDt0z/nMn/L13MYm1rnKvmNpE6BCeV2y27
	Qg9d/hQGwQU8DTBvxdwvNFGZn+SD/2deBW6OSDl5e6zNBGiuC43Br8DExvX54/54
X-Gm-Gg: AZFdTZfjHAD3S5aT+Liw3my1Uv1TGNxUZeTbVmFv+ElyTosn6cIXrlaBYPNHyssMqfS
	JrmuqfzOEQp66iPGacZAywbq4W7vtHGBJ5Rdlu+eABJK1WEP7EJHkrAfoIcL5lbQv8kWS6isB9N
	Bb5k03x/eiHSHBKy6In4orlsSJQJ5vg+ch2wmhbrinJVubd7JSUYBB/ncDxQjrUQ9H2PiFn58hy
	/eQUeFhxm9XTV8Hb3EGovmIhlQKeS3zVph0i1YdT5MqGE+9d6YHSsg02qErlA2282mssQ+w4W91
	UpnL2y9/PWgxuEf3miBXn63z95IyZwqXtyk4tiuzdcRi/IKE92PBUiWGHemmntCft4o9EDpVPxh
	2LBSdvxfl8WMOD/FVh1jP+a62TCnizR3sezU1VAfxmwGbwmuaM0xQp1AFtVAuQgCXQMri+CtHfp
	9h6+lUTFnqsYOU9PKMG9hpMN1y9nU9bGyecGIogH0/H9X6kdl0gGDbJ3Gm4I7Sps0uuKb6G80JS
	JBpFbYU2GFbvuvhExgwLuQcoA49RRE7MpDRTXR2Zm+pJ/nmRAkAMzFd9CJ9YNJ8mhfKD1jvJ8/L
	6h0SFiAu8uWFwqhrOtjnAiPPw4dow7P6AXJKN83rG4/nZHTo/Q==
X-Received: by 2002:a17:90b:4c44:b0:3ac:7f4c:a68c with SMTP id 98e67ed59e1d1-3b1b0a437b2mr10028717a91.49.1794823377092;
        Mon, 16 Nov 2026 02:02:57 -0800 (PST)
Received: from Ubuntu.netapp.com ([136.226.244.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7d994dsm33804245ad.33.2026.11.16.02.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:02:56 -0800 (PST)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hare@kernel.org
Subject: [PATCH 0/2] nvme: use kfree_sensitive() for DH-HMAC-CHAP secrets
Date: Mon, 16 Nov 2026 15:32:42 +0530
Message-ID: <20261116100244.7824-1-marting@netapp.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_020258_641505_529B50E0 
X-CRM114-Status: UNSURE (   8.60  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The host side stores the raw DH-HMAC-CHAP secret ("DHHC-1:...") but frees 
it with plain kfree() in a few places, leaving the secret in freed slab 
until the memory is reused. Switch those kfrees to kfree_sensitive() so 
the contents are wiped on free.

This is a hardening-only series; it fixes no functional bug and changes 
no behaviour.

Martin George (2):
  nvme-sysfs: use kfree_sensitive() for DH-HMAC-CHAP secrets
  nvme-fabrics: use kfree_sensitive() for the old DH-HMAC-CHAP secret

 drivers/nvme/host/fabrics.c |  4 ++--
 drivers/nvme/host/sysfs.c   | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.53.0


