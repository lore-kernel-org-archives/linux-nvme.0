Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8836AE77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 11:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZomPYaMcK3rQi4UZcPVUqjb0fNVLuJ00YN/NwI4LVXY=; b=omJSlp0FxGTptu
	KdLnIdJKRd2wyo2vrDyvepfd0oeMfNpJdrKiwg43JOz1VS8RUD4QV9gVp/r/GfKjXKIG9r9ZJjyqU
	H4EGsjFwD5ni+3W2wFZWvvHdiuDhjZ7tmktAVjCUzUVXDbJswqmsz7y2VInJryXX1eNz+1ruZSoon
	ZeAEBvhRbzeFQ3XNy4kacoTV1I+3zQFes2uYM44RCXY9cBZMg02st2dAa22PNyE9IjfnTzDu9HiDe
	7SJAukflTCJGp+i7zkbx0wR8zkTGJqpuccMm4mgfkW6iLDvFaFa9VJbmLOhvMG1fW2LO2kGYFFBjf
	HgtA8z/MEm3EgDftSEyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV7ky-00000004YCQ-3u9r;
	Tue, 07 Jan 2025 11:28:20 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV7jv-00000004Y0m-42cu
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 11:27:20 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so8456513f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 07 Jan 2025 03:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736249233; x=1736854033;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZomPYaMcK3rQi4UZcPVUqjb0fNVLuJ00YN/NwI4LVXY=;
        b=TG3Uigr9VxnFBR57PTHT8AQ/7aOjVqPQda4zFGEKWXfc8bRXQbSbc/zhO1rqyVkZts
         j1F2jIFqMNpqnNidbIvO6ra9wBRpc3Wxozh6TXCPH6anGyWwDaZoEbAOupCSTa3zIHZb
         PxGYsvXMti1S1xI7PD3T5ZGSwNXAxdn6FdOtZwVQ3TxwZ4DS7ZHPanCKuEjQVXCkO2gN
         IYue2HDFplaZZt6CdgPNF/ahcKN3eyAhDU9f1vwB+M58l9/10CpQF3JCSe4WI/3HyhYS
         Kq9TwK6Vr0P9CwuuSqfoZQBAxNKSuAZujThS9TyUOm1f523Ko7RI8g1NMgrsafANFMkF
         M3Tg==
X-Gm-Message-State: AOJu0YzBsPWyf4OmBCirQA79Tb5hMEJcrgWFP6Lrc9UxY+5EFjthtl/y
	O2ztvqToYKsR7I9PoKw1h+krPanGwrxfRoV2e9CCHRIVB/3IAWsCmVDkcQ==
X-Gm-Gg: ASbGncsFR/w7cAYUrqC4NRqe2rT0i+eK1JRE29GPqYmrKyn2dg8KXK00JnTqrRhIWiK
	qTbz6QNq81RjVCS2uhPwENdOjwiq3Rjduvi5WpoHF2G9rdZ+qW/aMp6jKfddyYAOepZoiXi0Zhk
	ykOAaBpf2+fGZxcA/YL5ONsSEe5zkoCFfaKmizlwuPfD/SXXdMWGsKbLqtKiWMXE3i4YyFVygYr
	BTfX/8AN84ICzh/zMoiK4sYLNA+H9V/EeCwP5HtVpGGwfF3oYDI4EEjVUqcPf7ifJAUyF/gbiyi
	GMtBwV519WJjDuCmKWrfPipudFpYqa9/h1Ed
X-Google-Smtp-Source: AGHT+IErGIvxbqBFCRgzrEGbDRm3I/37Hq085R8L9pOAO+IYrb5bItW3m/RI1jBygcH1K2tcACsGZQ==
X-Received: by 2002:a05:6000:2c2:b0:385:e30a:394b with SMTP id ffacd0b85a97d-38a221ea33cmr47421891f8f.16.1736249233276;
        Tue, 07 Jan 2025 03:27:13 -0800 (PST)
Received: from vastdata-ubuntu2.vstd.int (CBL217-132-142-53.bb.netvision.net.il. [217.132.142.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6c42sm628845745e9.9.2025.01.07.03.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 03:27:12 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH nvme-cli] make: fix make rpm target
Date: Tue,  7 Jan 2025 13:27:11 +0200
Message-ID: <20250107112711.192068-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_032715_999215_6E073069 
X-CRM114-Status: UNSURE (   8.38  )
X-CRM114-Notice: Please train this message.
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
Reply-To: sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Not specifying 70-nvmf-keys.rules as a known spec file results in this
error from make rpm:
error: Installed (but unpackaged) file(s) found:
   /usr/local/%{_udevrulesdir}/70-nvmf-keys.rules

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 nvme.spec.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nvme.spec.in b/nvme.spec.in
index 43fc9303f353..551c9b7f19e1 100644
--- a/nvme.spec.in
+++ b/nvme.spec.in
@@ -32,6 +32,7 @@ touch %{buildroot}@SYSCONFDIR@/nvme/hostid
 %ghost @SYSCONFDIR@/nvme/config.json
 @UDEVRULESDIR@/65-persistent-net-nbft.rules
 @UDEVRULESDIR@/70-nvmf-autoconnect.rules
+@UDEVRULESDIR@/70-nvmf-keys.rules
 @UDEVRULESDIR@/71-nvmf-netapp.rules
 @DRACUTRILESDIR@/70-nvmf-autoconnect.conf
 @SYSTEMDDIR@/nvmf-connect@.service
-- 
2.43.0


