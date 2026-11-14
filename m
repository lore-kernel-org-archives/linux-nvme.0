Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF3606A886
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 05:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lwSDmQDS;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GciBR8ny
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=bMIC1kskP5GdqBrbGoext4Aqt+LqpqVvPyut75h6qnQ=; b=lwSDmQDSLLG1s4YPhdgyftmPk+
	e9h9rvCWv9YGzfxJOkDJ6bW/ievKObtBn/QAqlIQPvpGZRVGbPx+3DfBmnX+iYQ/7xhK9Va0soM4S
	04PO3GQdQxkyFiusOpqB5smxCHxSBAaBluDGB7QaYVqnx82KMtYBJNuQGIiGMWlVfvnzQvdfBj3Pa
	QQjQuGapzct7Zxrwko9Vm9ZdoKfCNMmCgHBF2VWKqLB25lOD2zzqip1HXABdz/N3ixOqIp1sGhrcK
	TKFOLPBx3zmisenmoKMLI31FbA4y/GdJImyI+vCJ7Cc7c1r1x3mIJPj7D7hK8aSvDwnUnexWygqhJ
	P+b1jH/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS6Ks-0000000FUyF-1Nrf;
	Sat, 14 Nov 2026 05:29:58 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS6Kq-0000000FUxs-11TI
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 05:29:57 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2ed0e2015aaso9183855ad.3
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 21:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794634195; x=1795238995; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bMIC1kskP5GdqBrbGoext4Aqt+LqpqVvPyut75h6qnQ=;
        b=GciBR8nyY+2zBlvM6WxjtZJbIEgnhANu6ZobOU9y2W3AqqtkauGn7DuqNC1mOPDTZ/
         9UW6G+G4AV6jWnPZLD4KsPVOW4iA7cdAe7LlHe9jjMQTn8RpbddQlLZtpHewzDYldOYO
         YUuM9CJ/oOzDhLyh77fI8YJk5i1oCjjXasJ8qRBd2hEhWC6f33tu3Ud0To1BTmlQ/SRk
         OhEfeeqKpWI43ebA9y0Pg08XwKomaSiIhADvqAT6pJ5MwI/MPC9hPZTcTrD3sMUvuK4U
         +6yy6pRw89nP4uZKTERkPXGgAWjrv6wORHDtFl/hQPEmu5hzSofVL4lup5ooZxLxyQwh
         kXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794634195; x=1795238995;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bMIC1kskP5GdqBrbGoext4Aqt+LqpqVvPyut75h6qnQ=;
        b=zLUQxxYAoUxv/F7O+Zy20INgpSshV655q//lmeFci4n/GwPHBHWkVz8wd7+cfCo0bG
         YDjVPqXndaJN1BMjAMda9i04z4pOnV+tv1+Vn1cIiHo2fxZX1XtdLfXSCTUeJxtuYof6
         LULWdDqn48LeKk0spr6O24J8qF5Cj7cLzk+axdsg4csVQ8qimxGQMwuPJmAIEtyEaCzY
         W5E2hTL666GM0/SYP+QufYxxrZZhMbEg+QazaB4STXVQ+09InOY6BM2JGQ2AwMzBRJ7b
         YZENmVOUZtWAkyaBVzQC85UkvKVW5HzCXeCnrvKrMV1inpJMXhw4TwWC6mSE1N9og04s
         geLQ==
X-Forwarded-Encrypted: i=1; AL+hErEGQ5I03WYdBLPqEa+1RSjxza4Zhj/jjotAeNuNi5poRbxy5dwsIzJaY15027PhL8uspVNiY4ZaO8GI@lists.infradead.org
X-Gm-Message-State: APuU4Z8BU/xXaJ4ZlAcONLMow/N7Ugj4t8KJC2tkeCReT9Myf4cq0h/W
	d2pR2+wGoeW+Gp9ssubfDkS5+kZgGpe0QLIl68bmKrWMdgYLGEYa3TIc
X-Gm-Gg: AYBFou0sWYMPO0BZ7wjh9nuyoBWv6VrAs6G8c7DD+XVD1iD8ph5fW6yAm2tmRg1zhgW
	TpEScjzDR5BZALgTpmF8hwpWv+P8ANCeUWoJHGmaqH8sqGulmauO3Fw4ywRpBHFrZNSDmq7JB48
	pTX4WiNARjEO+EemFIJwQFEsrknMh1zVroJpM6NeFJDj/oxKu8lL9Kaw4anHnXh3vPi0tCMQbLT
	ngUqZfJZA+ySu54QHg4ZFU+FGi0n/ZJzwqEOuBjJtqkRzSZFjQEnhNXlrD0KhHpIIbiqLU7ckmL
	OGPx9/iErnS6Z25tB0BAVaWpwo00YmqSNr48Y2rqj04zIFFtTlnN56rnDfPINeg+P8Iriqz44HK
	dbJnX3Mk4+sMX5JQGQ5B50vx8tsBiaXqpvm4Fi1UERF8n2B3FkyrrDpPU5kDfK03+6iqeXycY9S
	SE2sdPB/9eNkwQwzug3TRkEKu1xTGckho904SCUALo1PMpYB66sjSpNRWE0K2t52EDSoomk0e+H
	skOZ5JSuKGzyQWpnnP3Dk+GurcqrsGDAmU4PbxMvqLIk3iaHIZD3ufeS5tamqL878l01LNTNT4K
	Nv7vXuCpSwBOj9hFks2A7T1xlRnjxuam4z859KJoIrobFJqHXaFIWSeSfRDnbrdIxFrsNMqa9hT
	jrU3m9YV7nI/xSQrBLm31ZXq52wt7GWV3/jcVmWtNubv6FjwxSFAcGCg=
X-Received: by 2002:a17:902:ccc7:b0:2e9:6c15:6b2f with SMTP id d9443c01a7336-2ee0dc93a16mr44755005ad.25.1794634195250;
        Fri, 13 Nov 2026 21:29:55 -0800 (PST)
Received: from 1.0.0.127.in-addr.arpa ([2001:f40:90e:5ed4:d53:b5f5:a144:fe4f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f874871sm17760225ad.54.2026.11.13.21.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:29:54 -0800 (PST)
From: Izaac Chong <izaacchong934@gmail.com>
Subject: [PATCH v2 0/2] configfs: fix use-after-free races in
 configfs_symlink()
Date: Sat, 14 Nov 2026 13:29:45 +0800
Message-Id: <20261114-configfs-symlink-uaf-v2-0-48c9cf068a91@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/4WNSw6CMBRFt0Le2BpLSv2M3Idh0C88hdb0AZEQ9
 m7BBZg7Osm99yxALqEjuBULJDchYQwZykMBplWhcQxtZihPpeScC2Zi8Nh4YjT3HYYXG5VnprI
 XobVU17OEPH0n5/Gz3z7qH9Oon84M29fWaJGGmObdO/Gt90cxcZYjhOSVUNpadW96hd3RxB7qd
 V2/Zii3tcoAAAA=
X-Change-ID: 20261114-configfs-symlink-uaf-c5d84bb6a976
To: Breno Leitao <leitao@debian.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 syzbot+b0996ac2197dd7420c3e@syzkaller.appspotmail.com, 
 linux-nvme@lists.infradead.org, Izaac Chong <izaacchong934@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794634191; l=1520;
 i=izaacchong934@gmail.com; s=20261114; h=from:subject:message-id;
 bh=9HaOXwSMwzKzPRbmaH7JW1q/kvKxDa6hssIZEkktu2c=;
 b=rW8QB5s2N3tYg5kXg2dxxatXuShumKYKJNvd+OxMHLlUDbvc2euh1vEI8+phoHZm58K7gwdjg
 uNpq5iNyl2uCPKSjn74kj+SFs1Dd4UJBYL4ncLs+sYnGvpszhu6ID77
X-Developer-Key: i=izaacchong934@gmail.com; a=ed25519;
 pk=IFfOWcK2ZRkDtCqaNggolAwpvIidYMt3Oar3NEnvqzY=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_212956_288980_67FB6F24 
X-CRM114-Status: UNSURE (   7.30  )
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

configfs_symlink() drops the parent directory's lock while it resolves
the link target. Two races in that window are fixed here:

1/2 fixes a use-after-free when the parent is a default group whose
    containing object is freed by a concurrent rmdir (syzbot,
    nvmet_port_subsys_allow_link).
2/2 pins the target against rmdir before ->allow_link(), so drivers
    that walk the target's ->ci_parent do not see it unlinked
    (NULL deref in uvcg_streaming_header_allow_link). Found by Sashiko
    review of v1.

Changes in v2:
- Add patch 2/2. Patch 1/2 is unchanged.

Testing (QEMU + KASAN, v7.4-rc2): the syzbot
reproducer crashes without 1/2; a UVC symlink-vs-rmdir reproducer
crashes without 2/2 (with 1/2 applied). With both patches, both
reproducers plus an nvmet target-side race run clean, normal
link/unlink/rmdir still work, and rmdir of a linked target still
returns -EBUSY. syzbot #syz test is currently disabled.

Not tested: lockdep was off; LIO (target_fabric_mappedlun_link) was not
exercised.

---
Izaac Chong (2):
      configfs: fix use-after-free of default group in configfs_symlink()
      configfs: pin symlink target against rmdir before ->allow_link()

 fs/configfs/symlink.c | 66 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 20 deletions(-)
---
base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
change-id: 20261114-configfs-symlink-uaf-c5d84bb6a976

Best regards,
--  
Izaac Chong <izaacchong934@gmail.com>


