Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C8C606A333
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lx40V+X+;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fbrFqt8g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=VcgZxHiwFf2ecV5iYQdNZeXK0E+odRcZXDutLNZLfIk=; b=lx40V+X+41SHld22BHSBRlUl8G
	uk3rZj1FlqJ2rlVXKp1GSY3UphbGW7okzBjS5Vd1LqR4MGz4c7ufdNZRtke9EqHhVHGbaEDtNrMkG
	TIfEWdW1oo96Yu+NONuu1tJwok5GRD/f+xMDfRqnDmsdjW7WjlAZOVfZUIvWX6PVwJzoblXNXbnuv
	k+3bnvG+QLVPn8Lnf+7hDH1sLfaGfxOUpjE2sijE6iy04PnZA5HKRTNBbQ324ZKFL4G+bqGnS75nz
	pjv/v8Llo820wQQBdmSds7ZwGdtM6S+7h8MIqpwT91xe1F1ZANRPGrlFZksyHfWTKQ2cNQAsurj88
	58JbMoPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoEX-0000000CJE9-0CHi;
	Fri, 13 Nov 2026 10:10:13 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoET-0000000CJDS-2UtU
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:10:11 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1095202a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794564608; x=1795169408; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VcgZxHiwFf2ecV5iYQdNZeXK0E+odRcZXDutLNZLfIk=;
        b=fbrFqt8gjd+qvgSmnGNtnx66Ou6n0Y5I3iF8SiE0+CdD6x+mDusZdJjwrtxzAzwhq/
         PBwavzSFZZDkIYgxsKtSrYQ33gr2Z8mBqG1x2Zo0Ymivr9zdVZG1axa2RJwmx37ymVeN
         gVn3PwNPn2Jzmi/g2TIdI6geIv02YizCKsq47u7FuP21eNMrNw9atJPoaQLCKtqvhjIn
         ASoHNhypXA3GPHlLpYFwXdkuP7wExp7quwE1XrYE+zq+AM1j4cQAEN9sc8To6XkglbMa
         K0q+iKvzqsVDTQGczPZYy5H2WrLJdsYu7U18TyU4oDSN5/W5oi/AagORyD8CsfKGQClg
         ZIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564608; x=1795169408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VcgZxHiwFf2ecV5iYQdNZeXK0E+odRcZXDutLNZLfIk=;
        b=Cd1Nrl6Wx9UGFSp9lyeelMfTwHxuh4bhvCpLTW8Py5UOn3BHyMRARvCq0bsuRrre8O
         uPxhZ5ZQWfLSj+Og5jPY3WbEbqUClz7/Z0ECYjIk4Dv1rpizxCm9vHCVlaJjtctGDlRX
         hZ1d6ZcvofxYWhBbSsOkZhM9IvZxcl3iZEf+C5mtzyyd0oYiDO7u2fohNE219hmoBWTp
         r3klFScPcEWqALnnTCJCN6M0eciDt3n3Ui5FwfyHS2FB+0+vzw3PDnmzvsyF/LNBFhwV
         dqdVd4olakckbYBAzfe0vzgWwXJmIL++sqoYhfBKgICpGOeKYtwCcpERQztWHmHdPH4/
         2IBQ==
X-Gm-Message-State: APuU4Z8wqhuzC7eHvrJxtIsfTqk+sMf3pCk2jnQNuPuSOVnE+TllmfCY
	4uS7v+cD4O8aWjiSj52bmQo6lltqF87nKiy1WToJ4xkYfZQDMEd+2zIFFZT23cmU
X-Gm-Gg: AYBFou0nLsn2OjC20v3DeoFnr6vwNE6KGy/qF7r9FWFusbFVsY+DughFGZ0TjDPHoWV
	GdLR5FDTwpVyVfvACDP9eylFHkUT0j36xsLsZNUqZjcMpFS6yYVXH38FIj/vCRNxeFNsoAreF6w
	QHSPycFjHwMImE4SiqcqmohhN1072lgJhjakAShUgSLtGtUEalOLZNKxUGhQrsGYrhWpHxhq34x
	rrSADUh76kzkxC5l9i5pKvcYJvvFVa98Q82SxRw5Wqd42NHT8QIRjS6mM24WwYVtpukjVNMRIJ3
	o/uuM94mDlrtXBo2Ok+QCXaawiG7xBCXI3ZB2CEKGPElWZp4GYtS3FvWNlyGhCDFGuAipYG2HSf
	ewB05QwQDypjo2Ni3DQBNxMsrAyPYtQS/hJQQMqDlmQWU/a/aHzilED6JV0Rvp+FyR7XVzOr8Og
	LSR6cVE88OXJ1Njmm9GuK2tv7yZisJE3UdPaCEgYzLyg0hvU12vVw9zMCd04AAIqbarJ4RKUg3d
	b+lmZKMHt35rtWiIZ3kYU79S/rbYvgb2z3TGMIar5UYpoOKeBjKkRnJUl5S8ObxbQHK5gut9ti/
	IhCe6NQVW7OwpdBCqaGdFsVGafBgTaw=
X-Received: by 2002:a17:90b:3ec4:b0:3ab:c80:9370 with SMTP id 98e67ed59e1d1-3b1b09e5ed0mr1692917a91.20.1794564608307;
        Fri, 13 Nov 2026 02:10:08 -0800 (PST)
Received: from Ubuntu.netapp.com ([136.226.244.207])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec3af2dsm3826016a91.9.2026.11.13.02.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:10:07 -0800 (PST)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Cc: kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH 0/2] nvme-fabrics: bound reconnect_delay and keep_alive_tmo
Date: Fri, 13 Nov 2026 15:39:49 +0530
Message-ID: <20261113100951.17577-1-marting@netapp.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_021009_704059_A8F9A801 
X-CRM114-Status: UNSURE (   8.87  )
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

reconnect_delay and keep_alive_tmo (kato) are accepted in seconds but 
later multiplied by HZ (and, for kato, by 1000) in 32-bit arithmetic, so 
large values overflow and yield bogus timers. Bound both at parse/store 
time so the conversions can't wrap.

The target already does this for kato via NVMET_MAX_KATO, and the host 
recently fixed the same class for admin_timeout/io_timeout (4a5aeebf1a00) 
and partly for reconnect_delay (f92fe8dea19c).

Martin George (2):
  nvme-fabrics: bound reconnect_delay to avoid timer overflow
  nvme-fabrics: bound keep_alive_tmo to avoid overflow

 drivers/nvme/host/fabrics.c | 4 ++--
 drivers/nvme/host/sysfs.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.53.0


