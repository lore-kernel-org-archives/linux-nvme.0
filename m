Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B5360A260F
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=H7LrUFzH;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=CdvWmS31
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=d5uxBhNS/GnIJw/zYouuj3Fh1xUn/nB9F/ugzp6g0YM=; b=H7LrUFzH2+YEFm
	lYvKEcLH3FlHDm7xGcXuLrLkxUhYa7AMjN8CStFHD0HNjxMB4bKw0bgVhndRN6WFgS05JVtDM7bkE
	Cyb3ArGIDTF0BmtL8AOORXiSrg9/gDtHtPNOL3fjMBq2lAosOU0smHEyjaJJwuNYCXV3DnI56CTSt
	j6wGSp0k8h0CF/RlXAc0KPSbg7K5MpEhMA344YEBVSUWhYX7GjDAaEtSip68ZxYJxVDCBeRWvYmk5
	iIQR6E4AGUsBBejCapmR/AenQRmaxC1QvsWp0rl0uhuRwSWiC+UQZFVLw1fwYf+8RIfHGeOE2/sCY
	DLgcf1RFlMJomfUZz5Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45R-0000000F9jw-18Cl;
	Sat, 14 Nov 2026 03:05:53 +0000
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45O-0000000F9f1-0k52
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:05:51 +0000
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-15ea896ddc8so2288669c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 19:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794625549; x=1795230349; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5uxBhNS/GnIJw/zYouuj3Fh1xUn/nB9F/ugzp6g0YM=;
        b=CdvWmS31bP15cnjcFz2YvUt1goO4irthDIV0EmlzyPRJ9JAvwibJXU+HeaX2wFluwd
         JJSwLfJsiDx26w79oW8Sf5Z1MkIUuSqg9w//Hj1BefsnbSfNEGiesz+AgNkcWVnkZ7oq
         ZvvlbShAR1329blSkZ/4zJ8m5TZ+UEm4L+qLIuuhraSViO+VIXK/GUoY9etTdvFfVVyT
         bm/lwyM0SrlIt4FRXuHrP8oTkaOEPJr/uHelE5BSPdR2pF0dROL8W0h8KL6XBb+j/vL1
         h3jREu24UvgFBfMunKldQZl2FrvMj9cR6dZtPmoTDtO0egaciEgWpbrHBvbgYo3k1g5h
         rQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625549; x=1795230349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d5uxBhNS/GnIJw/zYouuj3Fh1xUn/nB9F/ugzp6g0YM=;
        b=JhtGgPGf6RYgcAArFzA+wIVWz1PWHdDRoKqXPCAwRuklRsvrU266P0UxZWTrhSaZmw
         fgkkZwQUM8AG6DWGQC0VtHQt63ElUs0gwfOTlHKnowNMTwQTihSsDBVN1KxiW8QT/box
         +EvpOo9fMxekV1cA25Kq5OfZ9g4FJqt7nB6hacvRQ9LdLo/b45rIsrIOlL0qI59wzQ+9
         bzMqK7C9tx5ibWh6scR4/yS9M8+cvi7aNypRfrv9st31urdb3CD5HfqKThxlxqCdyAv+
         tdmL8dZv32VX5NgjVVzPBwpl3Wq50KWRg+Cs5gQvOZQMMuV9UE+rNAq5t0herld9CjYk
         nykQ==
X-Forwarded-Encrypted: i=1; AL+hErEuuv/nKyeBfjme2LNTdLJhu/E15q8v8SoUnsmmmLtrAIwOxdGBtgY6Zk1x774qC9wo+wF02w+xXDPb@lists.infradead.org
X-Gm-Message-State: APuU4Z8atGDd8FMzxpv0cEKOPI9eMC5pCPpliXWxcM/tBSNs1yuR4ujW
	jpHSx131Eu1hTW1ZEZ4f3JnI/dMxbgTH9ThEjMAh7Yd4+jbCdbSVcSyEjkyEf6m3R7dOsrgkIpU
	pSzmG
X-Gm-Gg: AYBFou3WwbEKUvI91Ep/pi57Fa8roI/lsmeUIi54XQcOSCBYmlZpUigvIRNRE/Nvp5N
	o2kRJSz/DTov3Uzq6NrYYIDfHbNwbylM4BQM85XhHAajfDMTcZ0LsaeZNwgoyVIohMsGxxH5X61
	7Qj3JO0bHNXX0xxoaWOY6Qdm+FdiDVshSdLb3vyntb5ccASJYIZwqbKvSB3fKxKYUv4fybn7jFQ
	4Bc6mK+Qw8gL7VMZllWR+hifF+2xQa17cyj4xZi4vW+h48jPJmjRmRo+D2uOSHahFd953vyeXlX
	awbilSOJJ9GpuZ9fHPa3gsEQz74so2wJuGdy/RUQRtBE6d3p5To9cHG1mktz12fNZ3Kdk1MsbYj
	4NNNhr/CRRbxw5k2q8nfpOLPRBAp6PB2SnTbjmE6J+wGk5aO2EEni+1W8hTC+yqyF+uXFu+31a4
	CSgg52VR8F9XfgNV6tT8NCohonniM5N+TZtU2RHt2ZMv2cFVAVnkBQe1dhbsPbW5eu05CppLCpK
	k4ok0FUZdu8ig7vprQEpZlh/ol5PD3jkQKAW+z8/rOZfHcM6NxT/8HUHhkYFrIOosLmGK3dHYtl
	55OmeZL05t4s5kDM0txs9WlfxnKv1jVnbpsOzJNrj9OV2KcraANTJjUAPTDNxk7+LQOQJ5nan8A
	=
X-Received: by 2002:a05:701a:815a:20b0:14a:8cff:fbb8 with SMTP id a92af1059eb24-1b5030bd61fmr3897546c88.28.1794625548645;
        Fri, 13 Nov 2026 19:05:48 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b50316e008sm10829382c88.6.2026.11.13.19.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:05:48 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v7 01/17] nvmet: Rapid Path Failure Recovery set controller identify fields
Date: Fri, 13 Nov 2026 19:04:15 -0800
Message-ID: <20261114030454.2836543-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114030454.2836543-1-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_190550_232654_D991A43D 
X-CRM114-Status: GOOD (  15.63  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TP8028 Rapid Path Failure Recovery defined new fields in controller
identify response. The newly defined fields are:

- CIU (Controller Instance Uniquifier): is an 8bit non-zero value that
  is assigned a random value when controller is first created. The value
  will be incremented when RDY bit in CSTS register is asserted.
- CIRN (Controller Instance Random Number): is 64bit random value that
  gets generated when controller is created. CIRN is regenerated every
  time RDY bit in CSTS register is asserted.
- CCRL (Cross-Controller Reset Limit): is an 8bit value that defines the
  maximum number of in-progress controller reset operations. CCRL is
  hardcoded to 4 because TP8028 recommended a value no less than 4.

These fields are set for non-discovery subsystems only.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/admin-cmd.c |  5 +++++
 drivers/nvme/target/core.c      |  9 +++++++++
 drivers/nvme/target/nvmet.h     |  2 ++
 include/linux/nvme.h            | 10 ++++++++--
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f12d83098644..5710ae53eb83 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -702,6 +702,11 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->mdts = nvmet_ctrl_mdts(req);
 	id->cntlid = cpu_to_le16(ctrl->cntlid);
 	id->ver = cpu_to_le32(ctrl->subsys->ver);
+	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		id->ciu = ctrl->ciu;
+		id->cirn = cpu_to_le64(ctrl->cirn);
+		id->ccrl = NVMF_CCR_LIMIT;
+	}
 
 	/* XXX: figure out what to do about RTD3R/RTD3 */
 	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index cc1955bc8c84..9c9ad4d9b292 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1429,6 +1429,10 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 		return;
 	}
 
+	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		ctrl->ciu = ((u8)(ctrl->ciu + 1)) ? : 1;
+		ctrl->cirn = get_random_u64() ? : 1;
+	}
 	ctrl->csts = NVME_CSTS_RDY;
 
 	/*
@@ -1729,6 +1733,11 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	}
 	ctrl->cntlid = ret;
 
+	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		ctrl->ciu = get_random_u8() ? : 1;
+		ctrl->cirn = get_random_u64() ? : 1;
+	}
+
 	ret = nvmet_ctrl_init_pr(ctrl);
 	if (ret)
 		goto init_pr_fail;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 2c2460ef5e2b..fba4d320f907 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -274,7 +274,9 @@ struct nvmet_ctrl {
 	uuid_t			hostid;
 	u16			cntlid;
 	u16			max_qid;
+	u8			ciu;
 	u32			kato;
+	u64			cirn;
 	bool			tbkas;
 
 	struct nvmet_port	*port;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 6248711784b3..a3c1b1713b4f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -21,6 +21,8 @@
 #define NVMF_TRADDR_SIZE	256
 #define NVMF_TSAS_SIZE		256
 
+#define NVMF_CCR_LIMIT		4
+
 #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
 
 #define NVME_NSID_ALL		0xffffffff
@@ -328,7 +330,10 @@ struct nvme_id_ctrl {
 	__le16			crdt1;
 	__le16			crdt2;
 	__le16			crdt3;
-	__u8			rsvd134[122];
+	__u8			rsvd134[1];
+	__u8			ciu;
+	__le64			cirn;
+	__u8			rsvd144[112];
 	__le16			oacs;
 	__u8			acl;
 	__u8			aerl;
@@ -389,7 +394,8 @@ struct nvme_id_ctrl {
 	__u8			msdbd;
 	__u8			rsvd1804[2];
 	__u8			dctype;
-	__u8			rsvd1807[241];
+	__u8			ccrl;
+	__u8			rsvd1808[240];
 	struct nvme_id_power_state	psd[32];
 	__u8			vs[1024];
 };
-- 
2.56.0


