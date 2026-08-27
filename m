Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA27C61DC2
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 08:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xtynvZadmT9n7iXGBfDWjegw1818rbUL1ZR1absKuqg=; b=YGPpjiOX8tygsSFLqZdeexwisG
	rdzbpCXGeGR+9BkQzn8uw13IVWx/y1CGg2SDSZARDZI+VaaHEjb4TSRfQ7oVLwt36Zq4rbevN6ruo
	t0Ga7J/dzq8GvASCVIWZqKEwiXWGrEeJ6prcdg/sRQ4I6tXayMzydntwkiNi4rOTpUT1yBao2YyIe
	NHUYvs7pPm37vAUMaAiyU3u5nOtTUp+6oRH/IK5dqKAleqrheIklDLdheBNqjRGlJ8PXBqxr1/EBI
	kuGyN74kKxQvdGD/PNGbC+yMYWZaRpjFeazpzDbLpvlomy1aCOKc73s/SeHUnAs2J9j+4oryX9Wjm
	PS9nY9Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzV1u-00000003al5-0bUn;
	Thu, 27 Aug 2026 08:00:10 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzV1r-00000003akl-12yJ
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 08:00:08 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-396b3d0df94so301019a91.1
        for <linux-nvme@lists.infradead.org>; Thu, 27 Aug 2026 01:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787817605; x=1788422405; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xtynvZadmT9n7iXGBfDWjegw1818rbUL1ZR1absKuqg=;
        b=m/TMsw0vJibSXQ3X4eIxGVQhMsvTmKTW0kBdmGaEPYaESVnP/vI7+5DAt3MQIPHWbD
         NTSus0K7XXB6dW2eYd/oES1+E1jjVpAcDobDmKaqVZlD25Vi+loiuGGXc/wqvZBEaNXl
         hTQYRVG1EMeKC5GDVcgI294+ob/q5KNEQEvOExafsH4kRiWgUQEDB6ACZBlPc6y6ek9N
         b0O75DGu1KpTV/qRHfzy9XhhyNofO3k2z4OVQBUS/u0EpmK4SnM5qsX/+2brs7aUSFvA
         mHXLp193agAE4DjEhDXyLguMbHsvfELTxgU+A3PvtC6VzMMSBMvaC1OuVUybe2deLpaz
         7wIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787817605; x=1788422405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xtynvZadmT9n7iXGBfDWjegw1818rbUL1ZR1absKuqg=;
        b=Y/sMeLUrbrzomTPwmigiNaS0crwUzbTtVEUmBkfsJOqNjm8L/GuVVeUfh9BLGP0mI9
         bauLJ7BU3kQbQdhWxNo+9Z6I/zC0zEV8MV3axU570X+OpsX2FkIqENwDjOe7/RbRJqQL
         Ip14H1Kd7ZdBpREXvkZRAg4ni6IdJrR/UH4OKHx085dtAJ2mxbDDIjEsLKZh7dVG+4vR
         nXijCWZzhyVefpodLL+KV2udiBuMYh033DW30FC+ksdW8hEdR+mUKqJ2qS6ocRGcHKwT
         RexjLolI/cPCACEyifRP7BzjAhq44lvTlyFw9O6NT+JB3jSMASzgTm+yPnxWCQB5smHc
         nzkA==
X-Gm-Message-State: AFuF++nSUuAVIQYKHWv5w6RhPSel6wWSmfyDd6dhYQZJwnDdGniVw9Jg
	BzFV9cVcMTkV4x2z+4yRu3RG7/VRCHg1XN7D7mJVuW18NuJhHLQJUUrkFbAO7iiGxZQC+Q==
X-Gm-Gg: AR+sD13k3rfJTC1rlHouSHSkQeXHpBJYEYZ/7PqAbH/125Hlm9eHKcNFcW9hXCRBOQz
	O24zie6QpYkmMzkTZ44N0apkoNyHiUGH0b2V6p1pyDl7OVvZecKLfAkwpjb0H6RAfoZZSUGsQEz
	QZ0N3RYApeFFEzVMov2POcnUKddDJdnr51WUCqdIrDArqrO3conuSDfQwXGiUSzVaSyeLnjrItN
	2/b35l6MAWEv7oC4Zk2zql4kzf5pwg9YFVlx51HrkThpoqxtgqYplGv/PXjtXQwKQKVXxc5srCX
	DAnKRX0UrP0EsvBo1XSp/1V1U8KxjGCqjsl0OdD10nSylPEHJP7ZdnJ1M/hdLZQDEdcXYgr0TZO
	bjWE4Fe+iCP51bCuftgKL79+tfe9ro/1xyIRes/tmU9Ape/G8BgZ/HDK4+uqt75ByUEBkza/HW9
	IeEwHz9AwDBU0BJiQR1g7BeV6mKtM/2THsxwqzzU8H7xOav4K9oQqgv0YwWfh2vBPLVE2gjivYI
	Y68N8EwShLM5XURmPcez5pru8+HCLcGKEZc8eZs9iPqmckwMOKL35Coe4PUUbBw2USCrjrIBgcf
	t8DO53OzNYv+kAKh2QbdJVMI
X-Received: by 2002:a17:90b:3890:b0:395:bbfe:fc6f with SMTP id 98e67ed59e1d1-3966d401db6mr25766414a91.3.1787817605188;
        Thu, 27 Aug 2026 01:00:05 -0700 (PDT)
Received: from myserver ([14.51.250.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd9085sm1678619a91.12.2026.08.27.01.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 01:00:04 -0700 (PDT)
From: Seokgyu Choi <tjrrb0313@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	syzbot+f613f9f010ec98eb9d86@syzkaller.appspotmail.com,
	Seokgyu Choi <tjrrb0313@gmail.com>
Subject: [PATCH] nvmet: reject namespace enable without device path
Date: Thu, 27 Aug 2026 07:52:21 +0000
Message-ID: <20260827075221.312935-1-tjrrb0313@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_010007_355808_9689D04F 
X-CRM114-Status: GOOD (  10.58  )
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

A newly allocated namespace has a NULL device_path until userspace
configures the device_path attribute.

If buffered_io is enabled before device_path is configured,
nvmet_bdev_ns_enable() returns -ENOTBLK and nvmet_ns_enable() falls
back to nvmet_file_ns_enable(). The latter passes the NULL
device_path to filp_open(), causing a NULL pointer dereference in
getname_kernel().

Reject namespace enable when device_path has not been configured.

Reported-by: syzbot+f613f9f010ec98eb9d86@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f613f9f010ec98eb9d86
Signed-off-by: Seokgyu Choi <tjrrb0313@gmail.com>
---
 drivers/nvme/target/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d74c01c98f19..336013139ef6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -591,6 +591,11 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ns->enabled)
 		goto out_unlock;
 
+	if (!ns->device_path) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	ret = nvmet_bdev_ns_enable(ns);
 	if (ret == -ENOTBLK)
 		ret = nvmet_file_ns_enable(ns);
-- 
2.53.0


