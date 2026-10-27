Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B65606A33D
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=x5uzow4z;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UjnNbwB8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=U6+MMyHahueBZCqpgQMBjs1Bb3xnMtdVSZFfFSUtdls=; b=x5uzow4zw7fhQU
	mwDw8c9iVlIdjn/qfZMoBsQ7H2Q2YGy11WhWHpsHzGBFtCJSOsDWw4P0YH1h9rwte3lpAWJem4eT7
	XjUItLFiaIkAdAlJqulB8p1+cGNPLMDq2uL/ppIWKaIyXZPpHwId1NMYuJMjF5osMfqIw5E+jxrq+
	vpsud7Wgh/2XRXhTg6OkIIzwAVSsWL/w2Ka5+VQaJefEjBvcjW+41BO7X2xmRUQC0go2wvelO1D08
	Az6weFtzo3Z91SUDGKBmxdsBRUcR+EGPb0iJEwL4KEq0/pn3NREUuJs22xElegrir8s73FuzrlnBX
	nxL1vXbevZv1Cl+pRreg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLigt-000000056vy-3WAJ;
	Tue, 27 Oct 2026 15:02:20 +0000
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLign-000000056te-43VA
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 15:02:16 +0000
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-18cdcfc05ffso5254262c88.1
        for <linux-nvme@lists.infradead.org>; Tue, 27 Oct 2026 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793113333; x=1793718133; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U6+MMyHahueBZCqpgQMBjs1Bb3xnMtdVSZFfFSUtdls=;
        b=UjnNbwB85nsjRNG3eDKCYMB/eziw8DjcKHbVCgWREfcnzUFQqK3ACg1LSQ6s1nigVZ
         tKyWHmQvUohB0qhivzhhnI+HZvFxhXnOGcADYY/MJU/gxGXi8FApramHT6YRFoZiql5Q
         ojbF/Zj0NxpwHbKQYFbdJ3WpL33kx8tTN9m+5zmSYB6T2OUDwPEw9eZ6u9UGmMWxNuZi
         oqiZxIWIvX1qN+g2wOcs1UoJwJWOdsfNn7vjpBCqWk0yy1/+7VHqE91DAFrvOytKK14c
         56ub6/enNa8yG1sXpj7tlP/KqLbqsLxmBnzIHWmdLqT8CdgR+kCx5+BzlN1pVojchfKn
         6f7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793113333; x=1793718133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U6+MMyHahueBZCqpgQMBjs1Bb3xnMtdVSZFfFSUtdls=;
        b=VVEuNGO1ny8adxG8IojX4DQC+gusFD9LTiWv7wwPv73KIyF5lRQIo5O1U9qKpmDXua
         dn5ekJb8XkWIvzf6q15QYvPDeXNxh6uusYc1or4Opp2mpmHitGjONhtt02H5ANYIpZY7
         UbbTf8L5GeH8nEO3ELJ9xgotrpiBmXMdXmHHQaWgFWSJ1oxvw11vCHAu4W7dLeJzWNeH
         QpYrbF6zuMBSks7rs4HoUGLgl5JaJNaZv1/NXplP+SwY7Hvw6V8T7qPuCHTcdUv2AZas
         BizE8mqH62aqGhjXxat66xU5KIbLZ8I4VGQNMQSz61FJ4hsk4QZsvu4aB5tzypxd+tzA
         zCmQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgVBD1NwNeo62UfwdHJuO0j26yPgAeDgSqZqjDI6pURLkkpPMPhDsMVvQZ1wrEHlVRY2DlNcFknlbs@lists.infradead.org
X-Gm-Message-State: AFq9FYI+LcMUrnWf0oTjzsLwQC61AGt+fk6Lts70ai3XIWbqzg4h3B6t
	VlU86Y8edIUzxr2qs7bryJ9BpClgQQBVb4SPEvx9neEb6kUOQcQg3T/a
X-Gm-Gg: AYBFou0dxOTPGE6FNOsYy8AWGsjgPPoJAkx0NZOm+++KjiKK2+qXYhXUX5P5C6Rcugq
	E+CAFrgSAo1uagIzOoQcSFTfQy6wCWqmoWcnCQrzowumOAnUV/jLJ8BOCcyy7c0Dk621XDpJdTO
	CNkq0A0wQq/CeRxdpP61mBN4jUscu5THeUhjIObkeOPQatHcRtSI4R8fAeLO4CZb9Rzs4CSRgqA
	LwmzbhmQUZhkcw9AblTvGe+jV78tzm6U4BM9xukQAjsYxtoLmWp51sSBaGIBgshJ/hglauI6aYH
	2HdqHO+nrSLkbyzhdrMeNUCNoHTdYviWleZ1e42JVokqTzug8efBTELIDFgFWiiAw/C026a4YTY
	5Q/nbboXy7arKmYNpuaSVqkkHsqIBrhE4I1G3k1WtJrTrgHd/AA6YCzyvcnpaSqXlMZSAsGCPIz
	q5zoiURlFpvPCI+bHQ9R+lP9aWNhroo2siIrpD7Woksn/gVeI3XILlBxv1BFYHVfsXNm+A+NzsL
	owP53NvKthM5BiJu5K/JPTOCQGPxxGaJoBWfXX1T9YYY7tX5d1eEWwXWiGXblzXPh8Qr46n+ErG
	XbE=
X-Received: by 2002:a05:7022:3b8b:b0:169:9f67:a91b with SMTP id a92af1059eb24-1993505df87mr17132954c88.12.1793113331041;
        Tue, 27 Oct 2026 08:02:11 -0700 (PDT)
Received: from localhost.localdomain ([103.177.252.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm30581952c88.8.2026.10.27.08.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:02:10 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: hare@suse.de
Cc: axboe@kernel.dk,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	sreekuttan2156239@gmail.com
Subject: Re: [PATCH] nvme: auth: validate DHCHAP secret before stopping authentication
Date: Tue, 27 Oct 2026 15:01:20 +0000
Message-ID: <20261027150120.3387-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <0632ec1e-dcd3-42f9-bd0c-a809a6f6db09@suse.de>
References: <0632ec1e-dcd3-42f9-bd0c-a809a6f6db09@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_080214_200192_2520449B 
X-CRM114-Status: UNSURE (   6.88  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hannes,

Just following up on this discussion. Have you had a chance to think about which behavior would be preferable here?

Thanks,
Sreeraj

