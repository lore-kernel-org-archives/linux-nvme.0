Return-Path: <SRS0=oO1v=DX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BE2C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 21:28:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E5A214DB
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 21:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hJ4hW5EP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c0Mzs3+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E5A214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=zorP/nVSF5dab0H2uezKUd5LliYPG2d72al/2POcHZM=; b=hJ4
	hW5EPMRy3qXge4saJYXxqB8uCZ7IgEbzLo3YN/L345FPielXSs3zCYXII3jWzkwzU97jVtsnGb8fo
	y094/nbqZ9UjNZYiyiUXjS101gYEYKx3ekkquwpZ8mtxN5jyiGlI+YS5VugjE8Vrv8XqjT4ThTJky
	BPzehi7N2Eev8FWzxqh6Jeaa8vssq/CNjIE3HIOEFALyJkmEjs3XoqY49ca9l7kqAfM/iUMosyW/6
	v0kFjmNgWOfm56jDrmUGxvcCNbswiN1YQ5mhlbRg+QxgzgcW3dO4nx/SaRg2djzlmhN2ldQ3gZQ5j
	LNIRNEq1rTC+gAcBb1oIhyaSfcp9dXA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTXHP-00089c-Sv; Fri, 16 Oct 2020 21:28:51 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTXHL-00087t-AN
 for linux-nvme@lists.infradead.org; Fri, 16 Oct 2020 21:28:49 +0000
Received: by mail-ej1-x643.google.com with SMTP id t25so5194048ejd.13
 for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2020 14:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=F8OecQapqfNHig3GAD75ZV5P3w7yGRWy3bteheO3qvw=;
 b=c0Mzs3+HpX6bqFj5DPPRhVIrtRIIIhOFhMi3gdXEciDiF+ZZF0L6Rc2ahCMNbUBOYj
 +IhvYeLJOyFkC1q3bGXDt3p6A/h5TfAldk3MLSbqdQdac6msWGIQCpq2ay+QNxMHxb/a
 xwF1pgrWSs6pbWwtQrchbByoKF9jo29Pzdk6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
 bh=F8OecQapqfNHig3GAD75ZV5P3w7yGRWy3bteheO3qvw=;
 b=gh99XMHaezCjHzMZcG7fXr5bNHdcHF8xsxtSDH4hcYT3uFS/GFMRCbFAy46gWnvdLt
 voAvSXB61ikc7UaMsJpjh9F2mv7mzwPI7dBJc/ttaOoJhf80Y1k7hiXqqK+a4k5AFAeW
 EEQtdvZBzaM0UEgsFBzn+ExNhwYtYwBihEOA/Rk7d3A8Qw/gtVIU+QFsEcXHkwmNZgzN
 cV+E+lh5JnTq4cO/NnLvsG/e2eYkku6BP60kPSMRmo5W2QzLkT1UajIV1pJJQzV1x7O4
 o2Yv6Vo1Wtilwzm8sp+YSTlKXXF2/0Il9kLhpzMJMYtsxrE8pZLHabJASEux5B7nDTye
 gUtQ==
X-Gm-Message-State: AOAM532+OmMhs40Xjdlyz8qw48Pl0hkOX0DpD4+wsEcsMKsislZikTN+
 Rfhdje3Lo6PN0FwXFF0QPx2KUFVuLZgNJ0BFq0GuzebrF0OBflKf94/sya+2YHO8jrrRqHGOJa4
 i/B+PK05BY1gUqg10l54qwBekpKqKbfiZ3CtKLhye4By0M8LkFUFGrFDV9PBrqG7ohtlTLg7Wri
 8qNpKh2ICC
X-Google-Smtp-Source: ABdhPJwGo257J5s8Ytts8Di8UvvAE+lrBDWiZFk/6RfciBbUrMjpGXF3w6O5wE8nALQpnFUSaZcBig==
X-Received: by 2002:a17:906:1c8f:: with SMTP id
 g15mr5701301ejh.179.1602883725347; 
 Fri, 16 Oct 2020 14:28:45 -0700 (PDT)
Received: from localhost.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id j3sm361121edh.25.2020.10.16.14.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 14:28:44 -0700 (PDT)
From: James Smart <james.smart@broadcom.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-fcloop: add sysfs attribute to inject command drop
Date: Fri, 16 Oct 2020 14:28:38 -0700
Message-Id: <20201016212838.49298-1-james.smart@broadcom.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201016_172847_379244_7F6F5929 
X-CRM114-Status: GOOD (  19.42  )
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
Cc: James Smart <james.smart@broadcom.com>
Content-Type: multipart/mixed; boundary="===============5812299022504476950=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============5812299022504476950==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000018733d05b1d0739a"

--00000000000018733d05b1d0739a
Content-Transfer-Encoding: 8bit

Add sysfs attribute to specify parameters for dropping a command.
The attribute takes a string of
  <opcode>:<starting a what instance>:<number of times>
Opcode is formatted as lower 8 bits are opcode. If a fabrics opcode,
a bit above bits 7:0 will be set.

Once set, each sqe is looked at. If the opcode matches the running
instance count is updated. If the instance count is in the range of
where to drop (based on starting and # of times), then drop the
command by not passing it to the target layer.

Signed-off-by: James Smart <james.smart@broadcom.com>
---
 drivers/nvme/target/fcloop.c | 81 +++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 3da067a8311e..ae46c8402f67 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -564,6 +564,50 @@ fcloop_call_host_done(struct nvmefc_fcp_req *fcpreq,
 	fcloop_tfcp_req_put(tfcp_req);
 }
 
+static bool drop_fabric_opcode;
+#define DROP_OPCODE_MASK	0x00FF
+/* fabrics opcode will have a bit set above 1st byte */
+static int drop_opcode = -1;
+static int drop_instance;
+static int drop_amount;
+static int drop_current_cnt;
+
+/*
+ * Routine to parse io and determine if the io is to be dropped.
+ * Returns:
+ *  0 if io is not obstructed
+ *  1 if io was dropped
+ */
+int check_for_drop(struct fcloop_fcpreq *tfcp_req)
+{
+	struct nvmefc_fcp_req *fcpreq = tfcp_req->fcpreq;
+	struct nvme_fc_cmd_iu *cmdiu = fcpreq->cmdaddr;
+	struct nvme_command *sqe = &cmdiu->sqe;
+
+	if (drop_opcode == -1)
+		return 0;
+
+	pr_info("%s: seq opcd x%02x fctype x%02x: drop F %s op x%02x "
+		"inst %d start %d amt %d\n",
+		__func__, sqe->common.opcode, sqe->fabrics.fctype,
+		drop_fabric_opcode ? "y" : "n",
+		drop_opcode, drop_current_cnt, drop_instance, drop_amount);
+
+	if ((drop_fabric_opcode &&
+	     (sqe->common.opcode != nvme_fabrics_command ||
+	      sqe->fabrics.fctype != drop_opcode)) ||
+	    (!drop_fabric_opcode && sqe->common.opcode != drop_opcode))
+		return 0;
+
+	if (++drop_current_cnt >= drop_instance) {
+		if (drop_current_cnt >= drop_instance + drop_amount)
+			drop_opcode = -1;
+		return 1;
+	}
+
+	return 0;
+}
+
 static void
 fcloop_fcp_recv_work(struct work_struct *work)
 {
@@ -590,10 +634,14 @@ fcloop_fcp_recv_work(struct work_struct *work)
 
 	if (unlikely(aborted))
 		ret = -ECANCELED;
-	else
-		ret = nvmet_fc_rcv_fcp_req(tfcp_req->tport->targetport,
+	else {
+		if (likely(!check_for_drop(tfcp_req)))
+			ret = nvmet_fc_rcv_fcp_req(tfcp_req->tport->targetport,
 				&tfcp_req->tgt_fcp_req,
 				fcpreq->cmdaddr, fcpreq->cmdlen);
+		else
+			pr_info("%s: dropped command ********\n", __func__);
+	}
 	if (ret)
 		fcloop_call_host_done(fcpreq, tfcp_req, ret);
 
@@ -1449,6 +1497,33 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
 	return ret ? ret : count;
 }
 
+static ssize_t
+fcloop_set_cmd_drop(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	int opcode, starting, amount;
+
+	if (sscanf(buf, "%x:%d:%d", &opcode, &starting, &amount) != 3)
+		return -EBADRQC;
+
+	drop_current_cnt = 0;
+	drop_fabric_opcode = (opcode & ~DROP_OPCODE_MASK) ? true : false;
+	drop_opcode = (opcode & DROP_OPCODE_MASK);
+	drop_instance = starting;
+	/* the check to drop routine uses instance + count to know when
+	 * to end. Thus, if dropping 1 instance, count should be 0.
+	 * so subtract 1 from the count.
+	 */
+	drop_amount = amount - 1;
+
+	pr_info("%s: DROP: Starting at instance %d of%s opcode x%x drop +%d "
+		"instances\n",
+		__func__, drop_instance, drop_fabric_opcode ? " fabric" : "",
+		drop_opcode, drop_amount);
+
+	return count;
+}
+
 
 static DEVICE_ATTR(add_local_port, 0200, NULL, fcloop_create_local_port);
 static DEVICE_ATTR(del_local_port, 0200, NULL, fcloop_delete_local_port);
@@ -1456,6 +1531,7 @@ static DEVICE_ATTR(add_remote_port, 0200, NULL, fcloop_create_remote_port);
 static DEVICE_ATTR(del_remote_port, 0200, NULL, fcloop_delete_remote_port);
 static DEVICE_ATTR(add_target_port, 0200, NULL, fcloop_create_target_port);
 static DEVICE_ATTR(del_target_port, 0200, NULL, fcloop_delete_target_port);
+static DEVICE_ATTR(set_cmd_drop, 0200, NULL, fcloop_set_cmd_drop);
 
 static struct attribute *fcloop_dev_attrs[] = {
 	&dev_attr_add_local_port.attr,
@@ -1464,6 +1540,7 @@ static struct attribute *fcloop_dev_attrs[] = {
 	&dev_attr_del_remote_port.attr,
 	&dev_attr_add_target_port.attr,
 	&dev_attr_del_target_port.attr,
+	&dev_attr_set_cmd_drop.attr,
 	NULL
 };
 
-- 
2.26.2


--00000000000018733d05b1d0739a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
AanDaJF6fE9TEzbfn5AWgVgHkbqS3VY3Gq05xkLhRugDQ60IGwT29K1B+wGfcujKSaalhQIDAQAB
o4IBzzCCAcswDgYDVR0PAQH/BAQDAgWgMIGeBggrBgEFBQcBAQSBkTCBjjBNBggrBgEFBQcwAoZB
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NwZXJzb25hbHNpZ24yc2hhMmcz
b2NzcC5jcnQwPQYIKwYBBQUHMAGGMWh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9nc3BlcnNv
bmFsc2lnbjJzaGEyZzMwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwRAYDVR0fBD0w
OzA5oDegNYYzaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc3BlcnNvbmFsc2lnbjJzaGEyZzMu
Y3JsMCMGA1UdEQQcMBqBGGphbWVzLnNtYXJ0QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUUXCHNA1n5KXj
CXL1nHkJ8oKX5wYwDQYJKoZIhvcNAQELBQADggEBAGQDKmIdULu06w+bE15XZJOwlarihiP2PHos
/4bNU3NRgy/tCQbTpJJr3L7LU9ldcPam9qQsErGZKmb5ypUjVdmS5n5M7KN42mnfLs/p7+lOOY5q
ZwPZfsjYiUuaCWDGMvVpuBgJtdADOE1v24vgyyLZjtCbvSUzsgKKda3/Z/iwLFCRrIogixS1L6Vg
2JU2wwirL0Sy5S1DREQmTMAuHL+M9Qwbl+uh/AprkVqaSYuvUzWFwBVgafOl2XgGdn8r6ubxSZhX
9SybOi1fAXGcISX8GzOd85ygu/3dFqvMyCBpNke4vdweIll52KZIMyWji3y2PKJYfgqO+bxo7BAa
ROYxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMCDH5i
rbJ+nCPBux48wjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg9FJ0y98nAPS0BE2k
NwMyyHc55aWZIQq6OjFWdbtmO9UwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjAxMDE2MjEyODQ1WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFGUl/Q0NSdiHcRP2SkNo9ZK8TpCmaNxN6Qp
oiEecO9FjB3KWjxig8/VqGbWXgnm/QQFzi9RHxVEZKzDCiNEWJdj/9i36T/fMwxGCOLih2epVIhK
MOmJHCYyrI4I1VmggEvfNEsoQwc0+vG+o9HkecGPIx9bBurgt38hyL7UZmepMRQHSaaTmnkuSquC
TBA3gJ7m6LLEUhdEkt+pcB9wtpy95H+nOgoWlja67onplDgGwFRj6NffGaGjmW9GvArhbKcdo0CI
rONEOUA2HoYSrd3ehaBWGnZuSTc4PyhC/feuNfOrnXUVnF1XuMg1oZkWIrYE7vwwbdYC1S94+7Ry
Jd0=
--00000000000018733d05b1d0739a--


--===============5812299022504476950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============5812299022504476950==--

