Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6C8C742A7
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Mar 2023 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IQFizYAyQ2vyOexGWuq7CGqIpn8DEfHHmvmPgoJDXnU=; b=OzKtJa7Wesl85td5kPuv2x0ba5
	iyCw92Yh4hzpFkkYEAvMHIz+7gmsQaabCRovj4TQYkEqwc02TB6VR34cU8AoXoOSRlCdy126vRaZd
	PNySqM+3yH6xMgEF8+aT8C4iOtf6d4WBYBxQoyEd+U4V9RFC8gcaHjCRvodTYBhA+l6rrKOcvtqst
	s1L8/cmuM1EynQf7aMuri8PjkNUE2i5OJUYzwkpITIkpVEX2IjWh/H9s6WAQTkc9odf9Q9YgLnexL
	IsXnoh2nPaSN/S+wLVnqeaxBw9/RDD5ps2p+WlD+BzRCI/R0gmz7A+/fdxzUJetWZoow32m3qqqm6
	lw4+pb6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paHNh-00AZr8-67; Thu, 09 Mar 2023 14:36:33 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paHIm-00AXmI-6D
	for linux-nvme@lists.infradead.org; Thu, 09 Mar 2023 14:31:29 +0000
Received: by mail-pj1-x102e.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so2207399pjz.1
        for <linux-nvme@lists.infradead.org>; Thu, 09 Mar 2023 06:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678372283;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQFizYAyQ2vyOexGWuq7CGqIpn8DEfHHmvmPgoJDXnU=;
        b=IfO9A/gUhaYrnqzqfsMcyAM2raz5QBhCbyP9OWxdEV6pOebE6XxI80UQLliOAfWApk
         bZhNk2kV7Lw9XHsYPQyP9jf+FszqRDV4xbvNuOt7+W2vDSySavWYGULstoI8ohnP/Wkp
         Mp6X5GADrVO0Wa2/LwpBJI6HTQzBHA6FRHXdfINqQRoqT59CFvB1nj+pRd1Akq7rf4cw
         Cmuh6hCSgBzX8ZZIg1b+kML46LGXzIX33qRNkzWMGMnrfjVqQPbgiTxTkMi7gq69lZw9
         gx5VS2VNjtcVL70uvgTbsc9E+vwbnBy4k/9w92bTOwpI9jx8doAWka0EJ5n3984EiR8C
         hunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678372283;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQFizYAyQ2vyOexGWuq7CGqIpn8DEfHHmvmPgoJDXnU=;
        b=MJDxExsa2DUpKwTUnNblh9qJyTNRfxyxDAD6JdSShNUMexDpXXhJhy35xMQ5u5JXYM
         L2lx24FALdzgAyR7nhptz0L0awEJD5SWYGfn+Vmscvl+G5xAWjwhkI3krzAFxNsIdPOa
         ysc+7X+mmnflNsf9D08hsbCs0OxrwiVhQ4DZ5rN6My8a8OBxUFsCsS30z1k+uV14HIlw
         QjKSnkMFb9f8T2IH/QQkhFDsnYJXyg/BmMjQDQmVEW30lWHdxEbx/sT+OSKJhzJ50wE9
         GGfEndsyBV0DQY7rAYk21c0U6u9n+/c5chga0nPyRmnsXJLLbm1s4c0PrOxh0tpqg5l8
         6kvw==
X-Gm-Message-State: AO0yUKVQYkgOf02bX/CGx8uRSFJuHIbfQNzP9C6eXhrU8voJ9gy5iKzy
	qxfSAryeFgI5U3u6lOMVw7G69DbyJ/o=
X-Google-Smtp-Source: AK7set9JkBlaBxhBkoeua7xbSpeianxW4ii7NP/Kc1OXy8GXZLi09KIXknRqyo9fhytZj7khYV+f5A==
X-Received: by 2002:a05:6a20:244f:b0:ce:c109:2d58 with SMTP id t15-20020a056a20244f00b000cec1092d58mr23184628pzc.10.1678372283451;
        Thu, 09 Mar 2023 06:31:23 -0800 (PST)
Received: from minwoo-desktop ([1.237.94.73])
        by smtp.gmail.com with ESMTPSA id k5-20020a635a45000000b004d4547cc0f7sm10864902pgm.18.2023.03.09.06.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 06:31:23 -0800 (PST)
Date: Thu, 9 Mar 2023 23:31:18 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvme-trace: show more opcode names
Message-ID: <ZAnttt3/8EYeMn5f@minwoo-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_063128_296928_A37726FD 
X-CRM114-Status: GOOD (  10.00  )
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

We have more commands to show in the trace. Sync up.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 include/linux/nvme.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 4fad4aa245fb..779507ac750b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -812,6 +812,7 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_compare),		\
 		nvme_opcode_name(nvme_cmd_write_zeroes),	\
 		nvme_opcode_name(nvme_cmd_dsm),			\
+		nvme_opcode_name(nvme_cmd_verify),		\
 		nvme_opcode_name(nvme_cmd_resv_register),	\
 		nvme_opcode_name(nvme_cmd_resv_report),		\
 		nvme_opcode_name(nvme_cmd_resv_acquire),	\
@@ -1144,10 +1145,14 @@ enum nvme_admin_opcode {
 		nvme_admin_opcode_name(nvme_admin_ns_mgmt),		\
 		nvme_admin_opcode_name(nvme_admin_activate_fw),		\
 		nvme_admin_opcode_name(nvme_admin_download_fw),		\
+		nvme_admin_opcode_name(nvme_admin_dev_self_test),	\
 		nvme_admin_opcode_name(nvme_admin_ns_attach),		\
 		nvme_admin_opcode_name(nvme_admin_keep_alive),		\
 		nvme_admin_opcode_name(nvme_admin_directive_send),	\
 		nvme_admin_opcode_name(nvme_admin_directive_recv),	\
+		nvme_admin_opcode_name(nvme_admin_virtual_mgmt),	\
+		nvme_admin_opcode_name(nvme_admin_nvme_mi_send),	\
+		nvme_admin_opcode_name(nvme_admin_nvme_mi_recv),	\
 		nvme_admin_opcode_name(nvme_admin_dbbuf),		\
 		nvme_admin_opcode_name(nvme_admin_format_nvm),		\
 		nvme_admin_opcode_name(nvme_admin_security_send),	\
-- 
2.34.1


