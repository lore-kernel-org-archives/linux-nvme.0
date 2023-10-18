Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B470CDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 22:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2bSQ7qSQqMVz/tkx7lIyl6/3Dlp40FjkhjBtPKLDoWc=; b=JtOJrRAov1Xh6nQsdueDMIta3z
	zsoZxpwVo4PLQ9wXz0AHvsEZuztHk+iiOc8dYDDJzi+8r1Kl7PFlrg2gh2Oudr+j/eu1x3JbJiYWZ
	cGV7GR1tIeXSuCQm+LZZaiK0QxE+NpWWs+sCCUQru7eVwguf6KIMdAoj8S6LssVaUmcrM3s/6w2pJ
	GQLcSHhOuIZR1CeWm+UErd5j3Mvq2kqFTrV7fs4Ov+fbbuiK04f1JFI8Ysxc8ffhfUr8ol+1c5/xb
	Dxb4jVRpal2LfW5SpzB8GkJreI9g1FRKWNRmsoUt5ugHOWhpOIErxIXH2NIFQxDYP0PAGHeFklvAP
	so3zYVcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtFLU-00FqyB-0e;
	Wed, 18 Oct 2023 22:48:56 +0000
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtFLR-00Fqxk-08
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 22:48:55 +0000
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7d1816bccso112154787b3.1
        for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 15:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697669330; x=1698274130; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2bSQ7qSQqMVz/tkx7lIyl6/3Dlp40FjkhjBtPKLDoWc=;
        b=oV6pPD5SCeO2yRoKtJyqmJ+wKr7WyimVR6yN5piQPC+i4bc1dl/9FHxehD8sqlHe+J
         qX47p7NFXbqdkB41/orrhjH3g4Oulm/zQWX93Q9cINvt48/L9E4riZgvdEVb+GVuPIPP
         60EU04W3x3PmogXQ/MVOgfsvTnTc1TSsyzMhkpCJXUU/CsVfECNFXzFfZDJaPSxp6zTv
         EyicfeZwjNgL6VsLhXl4I1YBzwPvm+VIe8wVCGoYB5xlaLx8R7JCm7Wy3OJKG2XPNegu
         vHTD+hgLhT9ODclaVyhAFXKAJGiOMkMDm/Lc0rhv2QJuj4qggx8KHR9xdFKKEjN1f7eq
         AApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697669330; x=1698274130;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bSQ7qSQqMVz/tkx7lIyl6/3Dlp40FjkhjBtPKLDoWc=;
        b=OoWioyVhTTNh8wPtLgQ/uEOX/qxoenkaW5V7GaHgTgXSRzcumvywnFjCUFpxEWzDV5
         yORWn4gD1f7o1TVMWNcqvLyk57u3SMk/k8r4J2Dr90M0GsJmYb9lyfKN06f+e0cpx/AU
         KsA33R7ocbZegQ0YUMJ9/UKmB71G/uAPv4DJ2y6SasEOlezTertYkhTGcgVnI5QFV6jm
         RY1Dh9MIn+HNYZsS3Xf1ivh3BjA3viVHsLyrDwvJKXjFWTFZ1ie0ajYM5tb7oXZGMM5n
         DmEZ7yg4jLJvP8fFHlcoWqtzWuasXwdnEXWBeNrn61Zqf02Vuk+fh9PLXEg+0EKak8MT
         GPHQ==
X-Gm-Message-State: AOJu0YySxaCdt7ZQwLmjwUsnfNNGGhiacaQaskq6FwRJmYazZ3tDTzHa
	8LGQIClYkDzdX2InIKKkFTQCZ9+r3qLiItpmtQ==
X-Google-Smtp-Source: AGHT+IGqdbWqQ7PEH4cUhxYJPzQti8rdqGeesI2OpR3f/9GfHYGXO/4kPNJHLV8sRzDs+qy+E+CBZAMToF2ahSILCA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:5217:0:b0:57a:118a:f31 with SMTP
 id g23-20020a815217000000b0057a118a0f31mr15075ywb.7.1697669330350; Wed, 18
 Oct 2023 15:48:50 -0700 (PDT)
Date: Wed, 18 Oct 2023 22:48:49 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANBgMGUC/x3NMQ6DMAxA0asgz7VEDFRpr1IxhGDAQwOyUdQKc
 Xcixrf8f4CxChu8qwOUs5isqcA9KohLSDOjjMVANTWudh5t1xS3P44qmdUw5S/jstqOUxhUomH E1j2p84Goe3kopU15kt99+fTneQF0i0XsdQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697669329; l=2668;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=eTZl8RLmSTRi1g6HBFXiHkDVcGwMrh/QN3Blnb4tlGM=; b=NqNL716tMxkz9di1bgPcw2w6eC4c776nurW+wFygYEOGZYbyCCVOYleoxDFKohV9u1XrQ7RvN
 UxB6tgf9Ik5CsmgFtVwMYknNxVzD3Jah1eF23yTnA5oMSFhciN+z9AP
X-Mailer: b4 0.12.3
Message-ID: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
Subject: [PATCH] nvme-fabrics: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_154853_082643_AF608AB7 
X-CRM114-Status: GOOD (  15.70  )
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

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect both data->subsysnqn and data->hostnqn to be NUL-terminated
based on their usage with format specifier ("%s"):
fabrics.c:
322: dev_err(ctrl->device,
323:   "%s, subsysnqn \"%s\"\n",
324:   inv_data, data->subsysnqn);
...
349: dev_err(ctrl->device,
350: 	 "Connect for subsystem %s is not allowed, hostnqn: %s\n",
351: 	 data->subsysnqn, data->hostnqn);

Moreover, there's no need to NUL-pad since `data` is zero-allocated
already in fabrics.c:
383: data = kzalloc(sizeof(*data), GFP_KERNEL);
... therefore any further NUL-padding is rendered useless.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

I opted not to switch NVMF_NQN_SIZE to sizeof(data->xyz) because the
size is defined as:
|       /* NQN names in commands fields specified one size */
|       #define NVMF_NQN_FIELD_LEN	256

... while NVMF_NQN_SIZE is defined as:
|       /* However the max length of a qualified name is another size */
|       #define NVMF_NQN_SIZE		223

Since 223 seems pretty magic, I'm not going to touch it.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/nvme/host/fabrics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 8175d49f2909..57aad3ce311a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -386,8 +386,8 @@ static struct nvmf_connect_data *nvmf_connect_data_prep(struct nvme_ctrl *ctrl,
 
 	uuid_copy(&data->hostid, &ctrl->opts->host->id);
 	data->cntlid = cpu_to_le16(cntlid);
-	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
-	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
+	strscpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
+	strscpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
 	return data;
 }

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231018-strncpy-drivers-nvme-host-fabrics-c-416258a22598

Best regards,
--
Justin Stitt <justinstitt@google.com>


