Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ECC10BA45E
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2026 00:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+voUH76g/Pq9YBKjG67uJM4aaUaY9JLa+bj+ayVk72U=; b=ornJgfFGAjCVNLD9lmnCPipWOD
	UFsJ+f3XavpxKGaQdENXk8R/jkfkuTwV2EcJaOjnBWrzISFXQ+FQZoz1XbOt/9fP94zcOcfnNbxZd
	fsdSdTy6lTQsSVnyNjAkId5EAjBIStfoEfloS6WBPqqkn6dVLAabnR+e3g6IwJdZFAShEXwebAeBI
	P55dJe4kOikTY/J5Jg/TiklEvpQDUwJA5m03/duKgBMz9qXbOVEE2oDQ4t+DVlk2Q13Y38vGayYS+
	WCXt5Xj3TQbDW2NUbyXZAytQomThKbrisJOkp8XN35HozFsqJdKNL9ZTa3QEVX+2/0D8LGQz2VhQR
	q0mXi0oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoL-00000008Npf-0IO3;
	Sat, 28 Mar 2026 00:45:57 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoI-00000008NoQ-07id
	for linux-nvme@lists.infradead.org;
	Sat, 28 Mar 2026 00:45:55 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so1065986a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 17:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774658753; x=1775263553; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+voUH76g/Pq9YBKjG67uJM4aaUaY9JLa+bj+ayVk72U=;
        b=CcOR9SOG5dEX8fmMkcQKCbl3YaJHnZZjxzQ3C9uhaVpAdamAFOgdbP/MEUE0tgk0th
         m/smgC49qabbTT2IvrKHkP1OLPFjhZMivDcpR5qxk4Ku02vsAu+TPcqKMhaV78qE92W5
         NsKJqZnJf9JxgdmhRfZeWvTzUuRVJo48SBZD+IMuhWh3l2SlWPF0rrNacqFPZwwPWKxC
         KsD1YSjnsA9Bs7O4OvD1kfVEGUNmF/7QaMGm3pmxAb/kSWLrIj58kALBWkBTKpLmrKvt
         aKpymHLTfZ0F3U6xgEkK+A+1bGVXCARzwDRSFe3uw4h48DnJP1QpiAT2pz3wmGwcgcAD
         d2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774658753; x=1775263553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+voUH76g/Pq9YBKjG67uJM4aaUaY9JLa+bj+ayVk72U=;
        b=qNTcsCF7jskP3VpuwLhlV1xteuouk9U1jUq7GJTKuCamkX4rKMk6/V1JHOMrxnojk2
         R69f27BelNrw3bOURcRtUbIevDo4M9fRhqRRBHn6KlrXsP8vhMpj1/plkSkhOzVCV7t9
         YspBIQbjxJqY2+Kb3U2xd1oQcMVIZR51EeOyVjEbc+EzzuNjS5/KmE15dzvtzf7yEM8D
         qOWLaLpfABaxqe3lYx1oqL4g3UuKdteWE88a++YLXkBvpODWc1kt2uG7GW/GrMKXlUkA
         ffCdR/4XfkrL4euv+b+b9nMg7vWaCyXQW1Q4Kz3xm9R+KIQ1R3uHH7LberIN8tJmMgSD
         ZW1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX26sHPh7elMVSgy0OjjwfpvG7TjNQL98qm2QV/8asmktXvWAUez1Sg7aXsIaCUIBS6oaBlY3YySLTW@lists.infradead.org
X-Gm-Message-State: AOJu0Yx62tSb97GvXiVpX8YUGLVvwCBjHBFKeSgX+S9gXTbbFcQxdHUa
	8GvksFPEd5/zPzYlhjoRX4sM7XI0rRUZGqp4/0slcazJ2bH2XQpAR1Nj1mOTMNw6agU=
X-Gm-Gg: ATEYQzwOazOfioi7OGMVUlB4yvdLhaPkmsK1nJeXmrS7KN3ttRd2imvMxEgLOfWgOOP
	Lr0JTGX/D4DxeM35ss/VDGi4sRmzs5shwkHb5wKMtslz5/YwFBbT4Qk81rgOHx8x5LIE25LjkZo
	rFs2DGWCzf/wesMklu4HT6erEcE0JjYA34Z5wNcfqvXX5YvpjJuuW2erjBdWnAFZ4omXPd/Bbvg
	eNSu6VRC0z6jvvvgh/QEmgO6JbXwiBcQm5GV6+aeM+pzHvhy9HCiw1xBjWtrpSme8ttdIcIH35b
	aCmgMQA2Ah8zvaYrXEs17MQ0BKwksc/3qjk9X6CHFtuRuVDnID3wIlTlzBbtpo8PVZD1kkKPmdx
	+SJigM/XU0p2XTu3G3gT02cwGrionvHtao1ngWaQ7vCBbkk8OCXZhXgz2X1d0acPjWQjSha35lJ
	f1cRltjuY=
X-Received: by 2002:a17:902:f710:b0:2b0:5b9d:4559 with SMTP id d9443c01a7336-2b0cdc764camr45037225ad.6.1774658752845;
        Fri, 27 Mar 2026 17:45:52 -0700 (PDT)
Received: from ceto ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b242683064sm5342705ad.33.2026.03.27.17.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:45:52 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v4 02/15] nvmet/debugfs: Export controller CIU and CIRN via debugfs
Date: Fri, 27 Mar 2026 17:43:33 -0700
Message-ID: <20260328004518.1729186-3-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328004518.1729186-1-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_174554_068014_FDF5E90F 
X-CRM114-Status: GOOD (  10.41  )
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

Export ctrl->ciu and ctrl->cirn as debugfs files under controller
debugfs directory.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/debugfs.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index 5dcbd5aa86e1..1300adf6c1fb 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -152,6 +152,23 @@ static int nvmet_ctrl_tls_concat_show(struct seq_file *m, void *p)
 }
 NVMET_DEBUGFS_ATTR(nvmet_ctrl_tls_concat);
 #endif
+static int nvmet_ctrl_instance_ciu_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+
+	seq_printf(m, "%02x\n", ctrl->ciu);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_ctrl_instance_ciu);
+
+static int nvmet_ctrl_instance_cirn_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+
+	seq_printf(m, "%016llx\n", ctrl->cirn);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_ctrl_instance_cirn);
 
 int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 {
@@ -184,6 +201,10 @@ int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 	debugfs_create_file("tls_key", S_IRUSR, ctrl->debugfs_dir, ctrl,
 			    &nvmet_ctrl_tls_key_fops);
 #endif
+	debugfs_create_file("ciu", S_IRUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_instance_ciu_fops);
+	debugfs_create_file("cirn", S_IRUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_instance_cirn_fops);
 	return 0;
 }
 
-- 
2.52.0


