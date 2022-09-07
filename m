Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533CEC54EE9
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 14:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BqYIXuls8awlN3OzteLK3sYQQU0ZRq2z2xemrKLY2t8=; b=Uud9dQu1hs074XsEAcUajPmwaJ
	rmkVWqLhji+yeZ54VsaoTcCHIqBLCRv6cXit/wa+0NK5b7wQYWugB5uCY3e3Vn/QTmfr0VYAeFxi9
	7VAvzIyCL7fcJdinpXisF0GLcFRoO/wz/KGwKXbr99wigAv8KvyzR4vYJkvZGdXg1Jr1h4s634gx0
	/aIjD7OPrQWUcdmC9grr0/3FtvsZVWgHaiG86FTvvv7WYXKOzQW1ZJ83nPMfublVfLmVI/pxYPerm
	fUFea0RotBQEWUogtdm00vUz5DgzausXHFVSbG2f3Qjz8PvB/3pkRkG8r5FDVIBuZqYyF64S8QrnL
	y6A0Bgnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVw1l-006sP6-1f; Wed, 07 Sep 2022 14:27:41 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVvyV-006pxk-Rj
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 14:24:21 +0000
Received: by mail-wr1-f46.google.com with SMTP id c11so16428119wrp.11
        for <linux-nvme@lists.infradead.org>; Wed, 07 Sep 2022 07:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BqYIXuls8awlN3OzteLK3sYQQU0ZRq2z2xemrKLY2t8=;
        b=BOzGZNyAH1wDeQRedV/y1gYgITxBQFCW4Frb42wtNHY+tfhOIeo3xtcQ+VNe1Ox712
         qCA+c9hKOhjfkJCqFWCBYibRmXiOy46PAYJsw/6f4RIILfy5s2RZ6uT6nv696rc7vkv1
         gj1hFQ0zf1LcmIO94YgpxMJk0vAzo2/SuY4OiyiM/1ukCcP7ZmcwOoh0vPIzSZHnKYH/
         /xBW3cO2hSFytOD0AglYhhT9O3ghPS+oNyLwl4rDrQGdTPfQU0AEcmpUCWhPmazo3Tqi
         PldvmkDX/xBhmhhaKUHk4HZKn5rA8pv9HmJELprc3KB1UbgDamJd5U92EyGpJjWXzq4a
         983g==
X-Gm-Message-State: ACgBeo0sM5tXVsOAa1a6FKrS1cbArkEvccYl4Ia9LbUIWyQjduK3quaF
	2jVOn6lXQPKvFAQpHluQwO6XaIM5u7M=
X-Google-Smtp-Source: AA6agR4ZXIcABD3qR6TUg4v1LyFV5sQOJqpBhjw8XWVuPZE3To+7S4+WDziUSN7n0qIxih32XT7gGA==
X-Received: by 2002:a05:6000:86:b0:228:db07:24bc with SMTP id m6-20020a056000008600b00228db0724bcmr2273989wrx.204.1662560656160;
        Wed, 07 Sep 2022 07:24:16 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h13-20020a5d504d000000b00228dbaea941sm6552486wrt.26.2022.09.07.07.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:24:15 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Martin Belanger <nitram_67@hotmail.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH libnvme 2/1] nvme: Add generic connect parameter support detection
Date: Wed,  7 Sep 2022 17:24:09 +0300
Message-Id: <20220907142411.101950-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907142411.101950-1-sagi@grimberg.me>
References: <20220907142411.101950-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_072419_933229_F3DBD59D 
X-CRM114-Status: GOOD (  17.35  )
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

When reading from the nvmf misc device, a concatenated string
of all the supported opts is returned. Add a helper that detects
if a parameter string exists in the output.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 src/libnvme.map    |  1 +
 src/nvme/fabrics.c | 32 ++++++++++++++++++++++++++++++++
 src/nvme/fabrics.h | 11 +++++++++++
 3 files changed, 44 insertions(+)

diff --git a/src/libnvme.map b/src/libnvme.map
index 79b8f88ecd3a..80fbe218cb9a 100644
--- a/src/libnvme.map
+++ b/src/libnvme.map
@@ -352,6 +352,7 @@ LIBNVME_1_0 {
 		nvmf_treq_str;
 		nvmf_trtype_str;
 		nvmf_update_config;
+		nvmf_check_param_support;
 	local:
 		*;
 };
diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index d5db5090e30b..678ca2af2561 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -526,6 +526,38 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
 	return 0;
 }
 
+int nvmf_check_param_support(const char *param, bool *supported)
+{
+	int ret = 0, fd, len;
+	char buf[0x1000];
+
+	fd = open(nvmf_dev, O_RDWR);
+	if (fd < 0) {
+		nvme_msg(NULL, LOG_ERR, "Failed to open %s: %s\n",
+			 nvmf_dev, strerror(errno));
+		return -ENVME_CONNECT_OPEN;
+	}
+
+	memset(buf, 0x0, sizeof(buf));
+	len = read(fd, buf, sizeof(buf) - 1);
+	if (len < 0) {
+		nvme_msg(NULL, LOG_ERR, "Failed to read from %s: %s\n",
+			 nvmf_dev, strerror(errno));
+		ret = -ENVME_CONNECT_READ;
+		goto out_close;
+	}
+	nvme_msg(NULL, LOG_DEBUG, "supported opts: '%.*s'\n", (int)strcspn(buf, "\n"), buf);
+	buf[len] = '\0';
+
+	if (strstr(buf, param) != NULL)
+		*supported = true;
+	else
+		*supported = false;
+out_close:
+	close(fd);
+	return ret;
+}
+
 static int __nvmf_add_ctrl(nvme_root_t r, const char *argstr)
 {
 	int ret, fd, len = strlen(argstr);
diff --git a/src/nvme/fabrics.h b/src/nvme/fabrics.h
index 9e099feeeb08..83353a65c5d7 100644
--- a/src/nvme/fabrics.h
+++ b/src/nvme/fabrics.h
@@ -270,4 +270,15 @@ bool nvmf_is_registration_supported(nvme_ctrl_t c);
  */
 int nvmf_register_ctrl(nvme_ctrl_t c, enum nvmf_dim_tas tas, __u32 *result);
 
+/**
+ * nvmf_check_param_support() - Check parameter support from the kernel
+ * @param:	Parameter string
+ * @supported:	Parameter Support indicator
+ *
+ * Read from the misc device the supported parameters and search the @param string
+ *
+ * Return: 0 on success to query; on failure errno is returned
+ */
+int nvmf_check_param_support(const char *param, bool *supported);
+
 #endif /* _LIBNVME_FABRICS_H */
-- 
2.34.1


