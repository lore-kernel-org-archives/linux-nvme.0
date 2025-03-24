Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C047DC3600C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 17:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YGbQAwYC/qXzJVLkpejFk7xs3lICNMf5WqGsg+WnFMI=; b=E9yf0hVIYUjNjspei3Bf0LJ2Kf
	qxbkc2KUh3aeptVJdbibAmSCVv4KYwWJJf7WiMYDeAthGxxATuMkJ8v8SbH3pDgFN84D2OsnEJCwO
	TgqlJCHJdlBe1jHEnILONZshD8+CtSVoxex5E4sAr6l80uCJGr7YRdBFJ3rpa06L6jlzD0cigSxAo
	TEmldiUSQEXR1fwaoXTsYvmtVQe8MCcbxYC6dJFld15Lx/1OxWI3Chx/ALKgqADIf1P4Cu3MtYp4I
	vXWav4Zsix7fYiPjeATSfW2wgIinZgKeRXOUF76z5RKtkLUkerxepC3aYobD709UI3Pa478NFr9R+
	/eFnq9UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twlvd-00000003rIE-2tkT;
	Mon, 24 Mar 2025 17:49:37 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twlvb-00000003rG5-0Fis
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 17:49:36 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-300fefb8e06so8427673a91.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Mar 2025 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742838574; x=1743443374; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGbQAwYC/qXzJVLkpejFk7xs3lICNMf5WqGsg+WnFMI=;
        b=evM1ruDKM5Go8UCy5qAG1X6uUqRr2py3MgTZgii07x6qIQQ6tnNARmPGsyxX0ks69G
         t53HTctGZbaS6AsTzIGpmozUFTmUUwmKs71dZb1vTTNluIjSo2ufjAgZuZkjNaUy5/CB
         G3g6tqk5FhetevPyexJPWkprF6LzS5rrt/xtqomK+WQZ8nlKs5c0oqgotHONeDdvvyjv
         S1T0JBvLhZ5EpwT8tkEamg8oOZIVS98KTVRP3W+TYXqw8OKlt6pS+KXfAK/k19qCESt1
         sZH8qNd57rkI/k3OQk3wgTAM5Ki4hlDurIesqAF+FRaKbytsQeKbMBFY7KVfjUou7JSE
         47Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838574; x=1743443374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGbQAwYC/qXzJVLkpejFk7xs3lICNMf5WqGsg+WnFMI=;
        b=GP0QGQEiZ7aBipBzHVhlWy8G7V96679/IS2+S1LwHX5gwZKYYEBWmqqNpSnfBySSUk
         vj4IuZDZrhyCEOCTXhBMfC3Z0zN5v8yO75WFPUuWcEyHk8vvXGiS+6DI+l+/nYT+FLa3
         8F3Q+6cLUqXTSgBguBy5SCLbKRBB527Q9ciirKpqzPhzSAgj0X1/azRUKaWDlIDWX7om
         daOL0MgZX1x48WJfHsGz+xNqDQEi6cJ6iwFxr7sM3HRtLKIGnCKKdCzKDgCoEOPj5/pA
         iilbe51rlLKbMrI+KdPJSXLyWnKx74DBa/F/+HV4EHcUAdXabMHJ9y0t7RYrTe/poyZc
         ayZA==
X-Forwarded-Encrypted: i=1; AJvYcCUH/Db2OUNIO5gGiKd2lkWQpIovwt10Sah3CE7ruUEob2cGtwcRi/uWi7hH6+Hb9Pg+6PQ0XEvrStBA@lists.infradead.org
X-Gm-Message-State: AOJu0YwbSQ3VnC7IxM7w+Hk9kGRZy0S7xcppdmf65f5sRSYQj9oyw3sg
	mXNRmUrdIeHgJ9mN10NlcWlhib8LVnUZnDiNUababUJXgxLP4b99zDB0+OEUtYw=
X-Gm-Gg: ASbGncsFyxcoE55VAhESjarx/3mx48+ZdLdWI6ZTXp0FO70OzyBkh4/754se/yeBHCo
	mw8WMnq8E7DdKYnTn7w2w5Z0/StyeUUMGHR9jmLk6CLzlJCWdthZNM2eFHds67tl3ByS+eu8Uo0
	Z/ktRPh2MNcqJaRNjbqKoua27jOQR80dsPmD94h5zMscAMU5+LPZBMBbXKPYHpKbQU48yBY0Cmy
	KIXIxs/NpQlvQItgZdQNQKBQn6Ef/P9oJ/GZ/WMTEQtvvtgz8JhJbXs1nJNzCsI2FZwnRzEauxD
	s0oLMRbFdSlvl62uNmr670hJYwsGavLSG/sOK8KDnchAgppyNsI=
X-Google-Smtp-Source: AGHT+IFSis3qpdLEBYFKAL4qcOoGMbvAJXOq+PxPYOsX78q8bD6vStLlrP+A0BFOH0+WadEkOtNfpg==
X-Received: by 2002:a17:90b:388e:b0:2fe:afa7:eaf8 with SMTP id 98e67ed59e1d1-3030fe8bd20mr16478776a91.13.1742838573932;
        Mon, 24 Mar 2025 10:49:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8900:32c0::e120])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-301bf576c7dsm12505821a91.3.2025.03.24.10.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:49:33 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	randyj@purestorage.com,
	adailey@purestorage.com,
	jrani@purestorage.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com
Subject: [RFC PATCH v1 2/7] nvmef: Add nvmef_req_hold_timeout_ms() to calculate kato request hold time
Date: Mon, 24 Mar 2025 10:48:55 -0700
Message-ID: <20250324174909.3919131-3-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324174909.3919131-1-mkhalfella@purestorage.com>
References: <20250324174909.3919131-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_104935_112218_BDF5DA87 
X-CRM114-Status: GOOD (  12.09  )
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

nvme request hold timeout is the time sufficient for target controller
to learn about loss of connectivity to initiator and quiesce inflight
nvme commands.

The timeout has two components:

- KATO timeout is the time sufficient for target to learn about the
  connection loss to the target. It depends on whether command based or
  traffic based keepalive is used. As per TP4129 the timeout is supposed
  to be 3 x KATO for traffic based keepalive and 2 * KATO for command
  based keepalive.

- CQT is the time needed by target controller to quiesce in flight nvme
  commands after the controller learns about connection loss.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fabrics.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 21d75dc4a3a0..483823d430d0 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -214,6 +214,13 @@ static inline unsigned int nvmf_nr_io_queues(struct nvmf_ctrl_options *opts)
 		min(opts->nr_poll_queues, num_online_cpus());
 }
 
+static inline unsigned int nvmef_req_hold_timeout_ms(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
+		return 3 * ctrl->kato * 1000 + ctrl->cqt;
+	return 2 * ctrl->kato * 1000 + ctrl->cqt;
+}
+
 int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
-- 
2.48.1


