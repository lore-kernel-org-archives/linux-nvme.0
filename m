Return-Path: <SRS0=7iC9=EJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD69BC2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 14:12:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406AA22243
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 14:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jp7Ov4ha";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bUsMUFuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406AA22243
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:MIME-Version:
	Cc:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1XQFFR5YUMVjpdZaKfILa4sp2wAlNdlEoNmt0oi3BzI=; b=Jp7Ov4haKhJSC+fjC752+qmr5
	3nHsQO/5t4NDj2v2xEf6Hg6rdozSQOLqdS0wsWQF/k+VmYqBUhd1TDnI304eTvgDHzfmC0jOtMiXq
	x33KlU+OmLK360oPWznnNGHPhJ9tXinltoE81bQaZZ1Bb4amEpYIuapigjOSmB33YxcbM4HOM9+ND
	DntKWAATO6KRCvdTltVSCiU/Wg/wCLlZCxk15kCJMeXeBtt7KFCQlslemi4Ig/hlK7pB2OExoV5Pn
	DxWZpLDtPldkjrUcY2S65E3fay0+MzIQ0ZUVgxrgeVH0SSYQyJjfUFSw24/lGE5M6ke0+/WQesmUw
	IazuWZmMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZx2Y-00024i-A8; Tue, 03 Nov 2020 14:12:02 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZx2Q-00022b-JW
 for linux-nvme@lists.infradead.org; Tue, 03 Nov 2020 14:11:56 +0000
Received: by mail-pf1-x442.google.com with SMTP id 13so14292204pfy.4
 for <linux-nvme@lists.infradead.org>; Tue, 03 Nov 2020 06:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=R4oJbJ8rxRsx3cqhIzGdgTgbb7zyU074m9Sgw3DscPg=;
 b=bUsMUFuQqK/6Y+rxHCfTqD3Jxm0Fo3lM2WfLeOlStUE+unb26k4/U0LY1iE51NrOmA
 0ijtV6fkNKJagGsv+F+NYQ30Hl2CgWuBsgtQ/jtTuboSJWo2h7Q1Kcl7+kv19OMKQlcl
 1KmuGMpnOGnZSt94Ytw4RSlmE/eOffGE8CMx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=R4oJbJ8rxRsx3cqhIzGdgTgbb7zyU074m9Sgw3DscPg=;
 b=umDk0JCgafRT0riYGwKBlC2Br2rXIqXI+FrGmjsNGX7GkHMNXMpDQtKYjQV9QCaZzt
 bnCMgz+wPI1cKm7iq22m43OAvVC7ytmklThxa0NTfqBc2OQLM8pOi+H+9uELTcE9Sufx
 YenFF7Lbs5Q3u606kJlxgAgH6KzBk8X1CeWrMAAgl5kf3KFk2vrtnVuxYjvZ/AWSyY2c
 HuARmDwbM8F/hamb5LJaXZspWmomyHGp8hZ77MgTMNhqg0unEFlun18VWRi+NhDfINhF
 a4q1mjt/twfcnofcYPWq7X7VdO0LTwaat+SfpOaDIoZa/z25yKcasdFSSJXjf2vWzLQS
 wGZg==
X-Gm-Message-State: AOAM5338G2jUnzIOfPzoHTjj/eJtNQVGjUQHT8cVFusrmBfZ0+LSw7j7
 UT9Hw9ogB53sIisZusgYJ7Xvpw==
X-Google-Smtp-Source: ABdhPJxhkjIbWLJTMlQ0uruUAv3HHc2ls5QDOKp2ji7SM6X9F6NS2YpfDb15M2AfKshIKjaegraWjw==
X-Received: by 2002:a17:90a:ab92:: with SMTP id
 n18mr3946495pjq.233.1604412712297; 
 Tue, 03 Nov 2020 06:11:52 -0800 (PST)
Received: from localhost.localdomain ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id t19sm3596691pgv.37.2020.11.03.06.11.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Nov 2020 06:11:51 -0800 (PST)
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v3 02/19] blkcg: Added a app identifier support for blkcg
Date: Tue,  3 Nov 2020 12:48:06 +0530
Message-Id: <1604387903-20006-3-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604387903-20006-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1604387903-20006-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201103_091154_755783_B1BAEC80 
X-CRM114-Status: GOOD (  19.93  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: pbonzini@redhat.com, jsmart2021@gmail.com, mkumar@redhat.com,
 emilne@redhat.com, Muneendra <muneendra.kumar@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7080100434588363025=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============7080100434588363025==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000cf0f7d05b33471ad"

--000000000000cf0f7d05b33471ad

This Patch added a unique application identifier i.e
app_id  knob to  blkcg which allows identification of traffic
sources at an individual cgroup based Applications
(ex:virtual machine (VM))level in both host and
fabric infrastructure.

Provided the interface blkcg_get_fc_appid to
grab the app identifier associated with a bio.

Provided the interface blkcg_set_fc_appid to
set the app identifier in a blkcgrp associated with cgroup id

Added a new config BLK_CGROUP_FC_APPID and moved the changes
under this config

Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>

---
v3:
Renamed the functions and app_id to more specific

Addressed the reference leaks in blkcg_set_app_identifier

Added a new config BLK_CGROUP_FC_APPID and moved the changes
under this config

Added blkcg_get_fc_appid,blkcg_set_fc_appid as inline functions

v2:
renamed app_identifier to app_id
removed the  sysfs interface blkio.app_identifie under
---
 block/Kconfig              |  9 ++++++
 include/linux/blk-cgroup.h | 65 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index bbad5e8bbffe..ed22df654ce5 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -144,6 +144,15 @@ config BLK_CGROUP_IOLATENCY
 
 	Note, this is an experimental interface and could be changed someday.
 
+config BLK_CGROUP_FC_APPID
+	bool "Enable support to track FC io Traffic across cgroup applications"
+	depends on BLK_CGROUP=y
+	help
+	Enabling this option enables the support to track FC io traffic across
+	cgroup applications.It enables the Fabric and the storage targets to
+	identify, monitor, and handle FC traffic based on vm tags by inserting
+	application specific identification into the FC frame.
+
 config BLK_CGROUP_IOCOST
 	bool "Enable support for cost model based cgroup IO controller"
 	depends on BLK_CGROUP=y
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index c8fc9792ac77..00ea1cfa3420 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -30,6 +30,8 @@
 
 /* Max limits for throttle policy */
 #define THROTL_IOPS_MAX		UINT_MAX
+#define APPID_LEN              128
+
 
 #ifdef CONFIG_BLK_CGROUP
 
@@ -55,6 +57,9 @@ struct blkcg {
 	struct blkcg_policy_data	*cpd[BLKCG_MAX_POLS];
 
 	struct list_head		all_blkcgs_node;
+#ifdef CONFIG_BLK_CGROUP_FC_APPID
+	char                            fc_app_id[APPID_LEN];
+#endif
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct list_head		cgwb_list;
 #endif
@@ -660,4 +665,64 @@ static inline void blk_cgroup_bio_start(struct bio *bio) { }
 
 #endif	/* CONFIG_BLOCK */
 #endif	/* CONFIG_BLK_CGROUP */
+
+#ifdef CONFIG_BLK_CGROUP_FC_APPID
+/*
+ * Sets the fc_app_id field associted to blkcg
+ * @buf: application identifier
+ * @id: cgrp id
+ * @len: size of appid
+ */
+static inline int blkcg_set_fc_appid(char *buf, u64 id, size_t len)
+{
+	struct cgroup *cgrp = NULL;
+	struct cgroup_subsys_state *css = NULL;
+	struct blkcg *blkcg = NULL;
+	int ret  = 0;
+
+	cgrp = cgroup_get_from_kernfs_id(id);
+	if (!cgrp)
+		return -ENOENT;
+	css = cgroup_get_e_css(cgrp, &io_cgrp_subsys);
+	if (!css) {
+		ret = -ENOENT;
+		goto out_cgrp_put;
+	}
+	blkcg = css_to_blkcg(css);
+	if (!blkcg) {
+		ret = -ENOENT;
+		goto out_put;
+	}
+	if (len > APPID_LEN) {
+		ret = -EINVAL;
+		goto out_put;
+	}
+	strlcpy(blkcg->fc_app_id, buf, len);
+out_put:
+	css_put(css);
+out_cgrp_put:
+	cgroup_put(cgrp);
+	return ret;
+}
+
+/**
+ * blkcg_get_fc_appid - grab the app identifier associated with a bio
+ * @bio: target bio
+ *
+ * This returns the app identifier associated with a bio,
+ * %NULL if not associated.
+ * Callers are expected to either handle %NULL or know association has been
+ * done prior to calling this.
+ */
+static inline char *blkcg_get_fc_appid(struct bio *bio)
+{
+	if (bio && bio->bi_blkg &&
+			strlen(bio->bi_blkg->blkcg->fc_app_id))
+		return bio->bi_blkg->blkcg->fc_app_id;
+	return NULL;
+}
+#else
+static inline int blkcg_set_fc_appid(char *buf, u64 id, size_t len) { return -EINVAL; }
+static inline char *blkcg_get_fc_appid(struct bio *bio) { return NULL; }
+#endif /*CONFIG_BLK_CGROUP_FC_APPID*/
 #endif	/* _BLK_CGROUP_H */
-- 
2.26.2


--000000000000cf0f7d05b33471ad
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
J/4V6ms/nIUi+/4vPYjckYUbRzkXm1/X0IyUfpp5cgdrFn9jBIk69fQGAUEhnVvwcXnHWotYxZFd
Xew5Fz0CAwEAAaOCAdMwggHPMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYI
KwYBBQUHMAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxz
aWduMnNoYTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5j
b20vZ3NwZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsG
AQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAA
MEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNp
Z24yc2hhMmczLmNybDAnBgNVHREEIDAegRxtdW5lZW5kcmEua3VtYXJAYnJvYWRjb20uY29tMBMG
A1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFGlygmIxZ5VEhXeRgMQENkmdewthMB0GA1Ud
DgQWBBR6On9cEmlB2VsuST951zNMSKtFBzANBgkqhkiG9w0BAQsFAAOCAQEAOGDBLQ17Ge8BVULh
hsKhgh5eDx0mNmRRdhvTJnxOTRX5QsOKvsJGOUbyrKjD3BTTcGmIUti9HmbqDe/3gRTbhu8LA508
LbMkW5lUoTb8ycBNOKLYhNE8UEOY8jRTUtMEhzT6NJDEE+1hb3kSGfArrrF3Z8pRYiUUhcpC5GKL
9KsxA+DECRfSGfXJJQSq6nEZUGKhz+dz5CV1s8UIZLe9HEEfyJO4eRP+Fw9X16cthAbY0kpVnAvT
/j45FAauY/h87uphdvSb5wC9v5w4VO0JKs0yNUjyWXg/RG+6JCvcViLFLAlRCLrcRcVaQwWZQ3YB
EpmWnHflnrBcah5Ozy137DGCAm8wggJrAgEBMG0wXTELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
b2JhbFNpZ24gbnYtc2ExMzAxBgNVBAMTKkdsb2JhbFNpZ24gUGVyc29uYWxTaWduIDIgQ0EgLSBT
SEEyNTYgLSBHMwIMX/krgFDQUQNyOf+1MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEi
BCDVXxlZ735kU7+pOJOOX514t2nHtfb6Fzxdu37CcPlRITAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMDExMDMxNDExNTJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEK
MAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEALE9NWlb8aGIn9Pjv
bVw0C9oDAjuLcXV5PAPExYzQCUv2gfKyDgQhIaLcACzCDNTu2cQ73jzsj6DpM9UABpSxPvAxh77T
N0A/YtKSFMEQGmzhyUguHW9vDgUrutu7Czo7D3HQQxHwNdQcjZKymMqlq9o1Uipte+KYUcPAHkdk
xmD62IhSKbE76+hP2PcNTvrtCiQlWxJVb52jnSi8TEVvTssVhSWMV1f2qE8tGADz7/c9ktyKVGSI
UooHgCYWNiFtw6cT29vdpwptEx1R2CgltIPVYGIMlPCWrvNfwh79+vdfn0mqeWi4ZfHYuYXCa7OP
90wQwcNQdMW4L4haET1Uvg==
--000000000000cf0f7d05b33471ad--


--===============7080100434588363025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============7080100434588363025==--

