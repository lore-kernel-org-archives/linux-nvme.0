Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6B9C369D7
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 06:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WCWk66zyPfZePbjJ8LwbQT1gioDez3btZNmAk+8q5YY=; b=CMmCpCq5n7za78f8sq7uBo1OrA
	I1mx83FXavl8vnRZgwvWM3wufxVf7g5g8vdX2v1npj1UjUmkxo9NFEFuPM22jzdn++39c1BmTL4cy
	NILfUubov1+cr11+9MvxaN2dLmEIV/LBsnS+m6RfafdLLkXzwWwY/Uk5IoPbf4ScOdYnG2CpAILs1
	3Jbvbo5jvaqk7/97lEwgqFjIUwQZIkyDzM56AYjpHZ4KHFsOnVIPwByEKxerpxOinLyEPXiWDbHco
	0CS1zMHSUzny+Q6zpdW/xxfZLQDzhfNzmePDewnwTIjrRGHQJmAZqvjvMwkhcrhsedcsWjgcWUpef
	KcOv/qTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u77Ft-00000005zSy-1tJI;
	Tue, 22 Apr 2025 06:37:17 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u77FN-00000005zLU-1Mis
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 06:36:46 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso2739287f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 21 Apr 2025 23:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1745303803; x=1745908603; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCWk66zyPfZePbjJ8LwbQT1gioDez3btZNmAk+8q5YY=;
        b=ZHn38Xg+rbbI3mZOkLIViKJJrb+CR2fDA31H7IEEKt5VIBGGh+DnHT9RkjI/n0+bVf
         LRn3mE9QjZG8jbWtoRiBRDSujD4rCmsv7uVkbWX+RgXqA7B9SB4JzYXl8N0YsJknUsfe
         F+YO4L8e6QWcj7b96GVFw+mdmTauSgPgKHdZKEsm8vMkQrvWUXB/xesuslsOmCxAnSOv
         FuzFP2t7wjlUQmPvs2glf5V7WcXOQ0GsMM2NUEA15EffbiqdqmBLyrlwI8OBAkfPToKT
         80TMFR/a6nphGJkOJYUJiJk1GG9abHgzHKrVq55if/irQuVjhDn+jprY7UqPeW1tf5rG
         5GQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745303803; x=1745908603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCWk66zyPfZePbjJ8LwbQT1gioDez3btZNmAk+8q5YY=;
        b=KfEjgiswP9dbBnRDQgTLhsAqizxz1dO3T+HATcEDRwYQ5g8cQMJEViGtfF38rf1E2Y
         cFX6+zH4tan9c2EPnScCYcKXIRIA1CAtC2BmWjzX5XUPrnWR0OzQGqISpZIbqx7EJR9C
         aFjc082+8OObX6JZnGGjUM+mIS3HJjwgI8M/s+9V6Ykqls0JygmcB4SOI59j0pFZLCyR
         t22lOE7ImEytQrGl4DeGVC26JVGP37pZB/N4LNHu+Ztiz7m0w0TJocmE/ebrRoV1pHM0
         Im7TC0qy6vmf4BuowknfsldBAqlxR1LYa6WiexghmHmaMuwkzXSyz7rMkS7l2vgjKJ8g
         MBfg==
X-Forwarded-Encrypted: i=1; AJvYcCXcy/mdngv5gxMUP1H7Oj417Vir25k8leF5D1myNe1UFSVOzfjfxX3Qo1jI/5ZouhpjeS+pGSWXZbSW@lists.infradead.org
X-Gm-Message-State: AOJu0YzVbC+kU3Vcth64/akxqkmBQXzsLYGs95NlsuUAwlDPG6D2FVE6
	hF2XEGveIMYkosxkJ+zW3j5NNpAeBW4LK5ZtkvWNC0g8/fSNG2gpaYu3ke4Atyw=
X-Gm-Gg: ASbGncvgBAvR8HQMleH/0Ze8K3gUS/m/g8VX5xjAQs1kPXEfdYYYr0LubcVgIi2l0yO
	7vGmufD41fwai2EZmZhH3hzhjdDmkFNt9O6p1N3REAvNMSXsNtEzoN77AQhrGilHjsgc09ZQ+WV
	u/Ck1KtzgYrs4Tip6gjjXXe6wEKv10E4T1rXY+QpA2hv8JdhziAwRI/nOVr8EcYZFLKaqLeioSM
	Tb1Ve21Gv6qL+Fzs5j+v3NnBZS9fM7OzBO3iSnt8jHNsm/V17m3bdWJvBLAKbpY+py1eSmphrh0
	7K6DD2vVZpdhN9pOkarzIeFT5tdSkN+/eamDZFIcGw==
X-Google-Smtp-Source: AGHT+IEcHXvi1Hm9/zAzhzfBnLuE8US8c0mBQ4Je3kxYL/vJ45G9HxCxXacQl/ww64L67Xp+jjmUFA==
X-Received: by 2002:a5d:47ab:0:b0:391:300f:7474 with SMTP id ffacd0b85a97d-39efba3cac9mr11006036f8f.18.1745303802675;
        Mon, 21 Apr 2025 23:36:42 -0700 (PDT)
Received: from somecomputer ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4930f1sm14253954f8f.61.2025.04.21.23.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 23:36:42 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 upstream@sigma-star.at
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "a.hindborg@kernel.org" <a.hindborg@kernel.org>,
 "leitao@debian.org" <leitao@debian.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
 "upstream+nvme@sigma-star.at" <upstream+nvme@sigma-star.at>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 2/2] nvmet: Restrict in-band config files to root
Date: Tue, 22 Apr 2025 08:36:41 +0200
Message-ID: <29921235.1r3eYUQgxm@anvil>
In-Reply-To: <cb7dc726-f12b-4cd7-a121-aebc9c510771@nvidia.com>
References: <20250420104726.2963750-1-richard@nod.at>
 <20250420104726.2963750-2-richard@nod.at>
 <cb7dc726-f12b-4cd7-a121-aebc9c510771@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_233645_652238_042C70ED 
X-CRM114-Status: GOOD (  10.51  )
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

On Dienstag, 22. April 2025 08:32 'Chaitanya Kulkarni' via upstream wrote:
> Patch looks good to me, can we do something like this and
> use in the rest of the patch ?
>=20
> #define NVMET_CFGFS_ATTR_DEF_PERM (S_IRUSR | S_IWUSR)
>=20
> or
>=20
> Create a helper on the top of CONFIGFS_ATTR_PERM to wrap
> permission into that for all the CONFIGFS_ATTR_PERM()

Sounds like you want to restrict read access to all nvmet configfs
files? My focus was only on files that contain secrets.
Applying this to all files increases the risk of breaking existing
userspace tooling.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y



