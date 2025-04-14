Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18D4C3601E
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 02:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9nFYwNpwBQMxz1aDCo6bAzJwgnNGrWQkXHlMdt6ExwQ=; b=J/RBcDUXHTllZJpNOl8DMTrFSt
	RpZ8GG/l8o+usyu99By3AaBfjxKqzoHAAv6LQ68kxQ3njImPRgNOjrM+8s5qj2FjQTuWzvv6bgl6a
	mIvItwe6tgLdxOQh8/+YUUz7SJxB6XUjZY5zTt3ClCs7rD71g9Ddl4aKKIvPo+tBXQhw+xk/Npl/q
	OlsQIH4kDDVJNF5WTlfmt6cQTIr8zhM1cLuexrDlVWqxs8qzGS8vFfG+k8SKEngL7ytCTvPmhvvdK
	ige0ctI100lCn3Dq2SVXW5mOLnNm6Uffx4iwmXt9EZaATJCbJNgQw8xeIUXmlDicQn2iB9RZHS5Fn
	fUTMC1Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u49pt-00000000VOX-2ATK;
	Mon, 14 Apr 2025 02:46:13 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u49po-00000000VO6-3Ftc
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 02:46:12 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2295d78b45cso52856975ad.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Apr 2025 19:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1744598767; x=1745203567; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nFYwNpwBQMxz1aDCo6bAzJwgnNGrWQkXHlMdt6ExwQ=;
        b=oTpfrp8810jdRnVCVIO0VjmJvhG6kJi1MLDarh1JIiUEA1rC1J9N53Bb3o/EbpkYxv
         sVghqzuW9zl/nkLcjvsWitvSLFT03KP6ukQbsqYmSUMCa+EhQtuFkRM8t099PdvM6uJd
         SkeW9roI2KhSGYkxuVyChc2dvEgH97oW3tDb/nFIxys3FAhyPSqBapRcmqRwblfTkouy
         st9ypOTEKTmnuJU5e8RonCJ48f9nxYRuh69cD+s8czJtsZn2iKvLKQFqq4KE2jSuG+i7
         0MzJjYt5ilgCZUwUM3MCcZjpNrWqakPaaKMtPk+Z9mkmOJC8fVZP4yeGbrnS5mv2iWnj
         PCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744598767; x=1745203567;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nFYwNpwBQMxz1aDCo6bAzJwgnNGrWQkXHlMdt6ExwQ=;
        b=CdhSaBzv9M1svblIZpLj0jtLOgUXyJvhk4vChlixy1K60IqQZekSCjjdL7FNJtTU7O
         1zw+dQic1p8oWMHCQl0vn71aGZYj/u1VyG/RlG59/h4ZkCgpWTC0SP9VvsB9RHIyzqBS
         tKk03yPE7wIY/XCiRcl5SGz6h3KKMVf7zAlTipQo7XL1wF02H9r2z4nu7Inwv2E/Lqmg
         hvvY+ZAd3KdciF3d647f1Px7Gn8bx5oqv5CeFuH3AEnOHq3KEOarkrS+vCDiyyKg6Sxt
         fIip+JbvWoNI5vsV4YZaUFLDGbxlywA5w0X0iZ2qrUucZqKEzW8dvc5MtnGwB6T0E4Z1
         Tnhw==
X-Forwarded-Encrypted: i=1; AJvYcCXjSyypfaAw8GE/c1GsvF9FXyDEKbCy53nmz3HUMHnN83AacoUZvXyMGQ8LpyOorbYLK8Bde9GItYLO@lists.infradead.org
X-Gm-Message-State: AOJu0YwcGjovrUiFkgKBOYSXlkh9AFSP0IeodlJ+PgkbtH5dAohrzSO/
	yjTUtJ+je2zqdChnqU2lOYV+lxKBJR4udFaBAT/DWlHXQFuAJptPkAE2ZMV/FiY=
X-Gm-Gg: ASbGncurv83F6YWyhUCfSjbjdh7/fU7AtiD3BRBywHnHfYaBHKBMJza4DVfewPVZFsn
	nw3xNzHT5KkDBAuxesGNHO6C/EjdL19xXNzP8/WM1ACuLlggsNYGIeIX2gHrNciDrs0BhBVMcia
	4uI/AknZ6NCye7CA+KM4REIshLPEmrRJ5J6VNp16KovrDdZfnnH254b5sV3EdOFH5UlzJHDrYUe
	G538Kcq6Agu/Zhaz0fcDgrMR8pZBkj1ASckOnZcovXvY103HMrxkZOSHWbHnqbopieRE0Biz6pw
	YfOQ25fcE4YII/jKj990
X-Google-Smtp-Source: AGHT+IGE7b14KlJ6s49DnMEXqvwmb7DfAxaOxGGOn13cWsEvR1hYfLyFOrgNOUII30k2qK9sPjSkBA==
X-Received: by 2002:a17:902:db0d:b0:223:6180:1bf7 with SMTP id d9443c01a7336-22bea4ffb4cmr133197825ad.42.1744598766405;
        Sun, 13 Apr 2025 19:46:06 -0700 (PDT)
Received: from smtpclient.apple ([2001:df0:a640:1::4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccbf1esm88890735ad.251.2025.04.13.19.46.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Apr 2025 19:46:05 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Re: [PATCH 0/3] nvme: add support to delay retrying aborted requests
From: Jiewei Ke <jiewei@smartx.com>
In-Reply-To: <271b73e8-4864-46bd-a274-8fa85a537eac@grimberg.me>
Date: Mon, 14 Apr 2025 10:46:02 +0800
Cc: Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org,
 kbusch@kernel.org,
 axboe@kernel.dk,
 kaiqi.chen@smartx.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2EC8AEE9-CD85-45E0-9612-7CF3212B16C3@smartx.com>
References: <20250410122054.2526358-1-jiewei@smartx.com>
 <271b73e8-4864-46bd-a274-8fa85a537eac@grimberg.me>
To: Sagi Grimberg <sagi@grimberg.me>
X-Mailer: Apple Mail (2.3654.120.0.1.15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_194609_082860_E63612E3 
X-CRM114-Status: GOOD (  11.23  )
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

Hi Sagi,

Yes, the second patch, "[PATCH 2/3] nvme: add support to delay retrying =
aborted requests," aims
to address the same issue as Daniel's patch. However, there are some =
differences in the
implementation. I=E2=80=99ve listed these differences under Daniel=E2=80=99=
s patchset for further discussion, see [1],
and I welcome more input from others as well.

In addition, feel free to skip reviewing the first patch, "[PATCH 1/3] =
nvme: check IO queues liveness
during controller reconnection=E2=80=9D. It may not be necessary. =
Maurizio's patch [2] can resolve the issue
and also cover a broader range of scenarios.

[1] =
https://lore.kernel.org/linux-nvme/94ec166a-2025-4743-8e36-fd1e96c33d6e@gr=
imberg.me/T/#m727bfbd968d40ba007549ffa1445f6d8f92e51e4
[2] =
https://lore.kernel.org/linux-nvme/20250306160322.1370300-2-mlombard@redha=
t.com/T/#mb34c7bfec63dbccc207425af9a516ec308d202b1

Thanks,
Jiewei

> 2025=E5=B9=B44=E6=9C=8814=E6=97=A5 06:06=EF=BC=8CSagi Grimberg =
<sagi@grimberg.me> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hey,
>=20
> Is this relevant given the patchset from Daniel on implementing CQT?


