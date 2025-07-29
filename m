Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF7CC87FC9
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 07:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ltNpeYsaYiriqRttnjOxFTsDxOzsiWp+Zzreeo3S004=; b=NG3YMor4vq9UDC9TAEz/wVR9T+
	XosIQmNNKfhXBgtWLEMN7FMW+jcw/IprQyOyZ7ARceRHrC7mc9hhxZP7SBU144CaSNqCKCjjsi/rT
	ZqppXbNdRTSjXL98SM9TCfgjHGF9HcDQJiBIRtgruVnMuFBnJNAh6qqknT6KTZ4QFzYW31/kg1DBD
	L03A5WF5d7nAAOFZEi+++Ec/Nm0YTfuPmTMG1Lw0pDWWKUPIFjtE4FEK2Ua+0p14HY4R6WsA4SBbh
	+FepSqPAARRDDVtWubtJlBV9QYxMizi0mN1YqMktkhYtdQBrVY+9PkGUueS++YgeGPLpp7mbsHIQT
	XNR8fnoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugezL-0000000G9Ro-1ffU;
	Tue, 29 Jul 2025 07:43:07 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugaIv-0000000FmuX-3ULI
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 02:43:03 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-23ffa7b3b30so20765645ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 28 Jul 2025 19:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753756981; x=1754361781; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ltNpeYsaYiriqRttnjOxFTsDxOzsiWp+Zzreeo3S004=;
        b=FF281YIAPmaxwBgyTpCIygGpAS8QC4iMBJUxVRM29ftpRD1eX1jXEY7WHu8HobmsZD
         qipOnWtTx71Vl59sq3nnMjreZnOHmh5Z2aBAEAVCwFK6zyPJdYQqg5cAp2xtNSHCNwfY
         LKorVk11mWXFKT5CAG8LS3481yPTEBelyY9Ox5h5r52Vr+X/Pueq1+gMB1/nVa2reDaU
         nB/TQlkmqwNcoqB8VT1Qhpj+LMMVsCGPGIZuvbPkIDJgE1wnMIMi9NMLGdSg+C7Bs5oB
         XzYRJG3NB8egtyUwr22NGXJT/rULLeMxTayc49DOjfhowMspIOmJdKVtUzNwP/d0f52F
         TAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756981; x=1754361781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltNpeYsaYiriqRttnjOxFTsDxOzsiWp+Zzreeo3S004=;
        b=phs1T2W9opP9FKNqP2nT0M7Bh6R9IcgEWew5+6jibG+2YlySHSuTZlfDOZHi6N/fXv
         ZLBc4dhb6TporFdUxIk1+6i7aoyUnti7xMrVBujcKuG5XhXtIwqvtM4fPD7YnMMFlFVP
         8RRbBRK0Q8ChZPESGR/GzIOUxcD2XRpE6x7sLe39CNNub80ozTrS/S3hDJl36GdgBz0u
         rTKRGZVt7DyJqQ/WfU1LhLGdnVdRhVIWTLE9cYPQVAhYz9Jmav8iM9LbgmKhGNezuiuE
         MwWQXlrBPkpx9Zlb7ygC7ulVfnMoAxIKhtJx1EqmumhmxXvEJ7E0/gyLRsc64LaZb3CO
         XVNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdg4Ek5yzZyvjaPLMYnSJnTBzyA+TAR7mgDJDxXoVOsjgpvVdLUdoAbpQslxr0v3+WOyR5VfM60w4J@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7Ss1Z5DqMIKOGxLP3Kn06qrB7zAPycKgOUB4cnPqwFzftbXf+
	kJW1+qbWLdxN9BmQqfK54si0aRYeYDNOU+QL5meggyY2vhE0PqzskVHO
X-Gm-Gg: ASbGncufvY6MLH6P9cgMVnbleqmfWIEDzXsFDWlQoQzOkHGycIDLZro7aTQrftAzRPX
	xIlDjUdmQYtoN/mHpwLwb/GOAiM1C6lsbb+u1MpYT3Spyng0x9h3Cx1aG+JMV86Ivvx9Omuyuzr
	l67kfXPa4vf1EChae7uNWa1R8GB8+oJY6iAsr4/wnwDeCnZ03ExjVe73W4xapZtAigZes9KkrA0
	Y4wFWwMKij9LdAdCx2yvcZlklHYytNOKbpOrtePk/wEWymzenxqCyKcnESxOy98NiOxlT1jsv09
	lG4AFgINAL9RWybqIlrI+0EfsfQtWk83e20c2phHPTSZDblkHPd/WgDLKDlVs2UJ9A3KJDzyy0U
	Nf6uUry2wO/UM1Rzs33Dvrq9vGg==
X-Google-Smtp-Source: AGHT+IFokfUWEoK1BlXtNlneBLUYXrht2yshaZ90k+I2IvTHjwBEMdVrmYfxeQvJuKnXo6G4WVr5+w==
X-Received: by 2002:a17:903:234c:b0:234:d399:f948 with SMTP id d9443c01a7336-23fb3126f99mr175232585ad.33.1753756980621;
        Mon, 28 Jul 2025 19:43:00 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fecd9ed12sm51327855ad.8.2025.07.28.19.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 19:43:00 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: alistair.francis@wdc.com,
	dlemoal@kernel.org,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC 0/4] net/tls: add support for the record size limit extension
Date: Tue, 29 Jul 2025 12:41:47 +1000
Message-ID: <20250729024150.222513-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250728_194301_871862_CAB86A0A 
X-CRM114-Status: GOOD (  11.92  )
X-Mailman-Approved-At: Tue, 29 Jul 2025 00:43:06 -0700
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

During a tls handshake, an endpoint may specify a maximum record size limit. As
specified by [1]. which allows peers to negotiate a maximum plaintext record
size during the TLS handshake. If a TLS endpoint receives a record larger
than its advertised limit, it must send a fatal "record_overflow" alert [1].
Currently, this limit is not visble to the kernel, particularly in the case
where userspace handles the handshake (tlshd/gnutls).

This series in conjunction with the respective userspace changes for tlshd [2]
and gnutls [3], adds support for the kernel the receive the negotiated record
size limit through the existing netlink communication layer, and use this
value to limit outgoing records to the size specified.

[1] https://www.rfc-editor.org/rfc/rfc8449
[2] https://github.com/oracle/ktls-utils/pull/112
[3] https://gitlab.com/gnutls/gnutls/-/merge_requests/1989

Wilfred Mallawa (4):
  net/handshake: get negotiated tls record size limit
  net/tls/tls_sw: use the record size limit specified
  nvme/host/tcp: set max record size in the tls context
  nvme/target/tcp: set max record size in the tls context

 Documentation/netlink/specs/handshake.yaml |  3 +++
 Documentation/networking/tls-handshake.rst |  8 +++++++-
 drivers/nvme/host/tcp.c                    | 18 +++++++++++++++++-
 drivers/nvme/target/tcp.c                  | 16 +++++++++++++++-
 include/net/handshake.h                    |  4 +++-
 include/net/tls.h                          |  1 +
 include/uapi/linux/handshake.h             |  1 +
 net/handshake/genl.c                       |  5 +++--
 net/handshake/tlshd.c                      | 15 +++++++++++++--
 net/sunrpc/svcsock.c                       |  4 +++-
 net/sunrpc/xprtsock.c                      |  4 +++-
 net/tls/tls_sw.c                           | 10 +++++++++-
 12 files changed, 78 insertions(+), 11 deletions(-)

-- 
2.50.1


