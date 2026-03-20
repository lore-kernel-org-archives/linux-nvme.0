Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DE71091937
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 00:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/oIKZiyv/PcbrVWXm60TvW/iKtw//CE0+Q8NBkuoF3I=; b=UdBHj5Uv30bagh4CqtDbrISM1t
	60toRsaGZGAARWGpgfn5hlkTgaXHnld15JYchOltF2YHWtZWOlPfxX12ptr8jpBjT0VCmo+e0PxS5
	X46qRWepwMUEaFlsLjfrfcX8ip8HRTC3dgRrA7csc6tdDJg2AcD/6kx+BXttG3DHWegk2embqbH1H
	UVxE2nyTkfSs1+soHTIkOBJEZ3ETzdgSFdGwWwqU8mYmmT7T7IQqIfcQ+R1BNI+TPqa/Guci1Bw9o
	hcFEmFuMRi8cPaD8n/NaSugal4+ciuRXmQ3rnPYB4x7w7r484Km/bbiwKcnlPbWIGQBrbyQsKHRNr
	RNXTrSGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Nbx-0000000Bpnv-1fqH;
	Fri, 20 Mar 2026 00:21:09 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Nbt-0000000Bpmg-3Ijz
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 00:21:08 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2b07069e2efso7928505ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 19 Mar 2026 17:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773966065; x=1774570865; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oIKZiyv/PcbrVWXm60TvW/iKtw//CE0+Q8NBkuoF3I=;
        b=hNBS1SbxWJ01eSkPHZCnh0OoK4jAH8aZI8aJ1cBBJ2f+g6PtQ1ufBgsMKOOcW2SoqR
         vZqHO8dXILCjalm+D1fKKJDn9VObVOCrQGn9vjt09icx5Sj+slHITJB5XM0siu2qmQua
         dPeyQYH/kkece1ficDFgzd7K6H6ZqNzHCgBVFpX07wq3I6ylsXYP4H3uFYg1YZFZN4zb
         yNXKSOw41kuhxzGYfnLEgPR/72GdJu4w7ScgtG7q3mpilOZXIRHDvWRsJFTEWxkDVpcq
         bM1ZMtKvsZ60sd2coV+0KWScONon8rRAevbEQS+Ge2jH7rDVN/mq5eIj3hcmNC9+3i9b
         G4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773966065; x=1774570865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/oIKZiyv/PcbrVWXm60TvW/iKtw//CE0+Q8NBkuoF3I=;
        b=I12Et2YP1GFUMmIJYWJZwGotorK6oNmIm2qcYUEb7iWEPf5GXHOJ3Ezhlu8qLsXN87
         l2LhS+IjmXfgegoul2ayd0Nb0jp2Zy9Ud6+VGPI1GyID5deKD776JpbZJjr1CTTukkDc
         R/E4B6J+qyniUocV67VZC3EIwd767EeAVJeC476D6vmN4CKzINhC95+QhHeYQxjPd0+9
         uPsgPPwCR9iqvnZLbqiMM2fxTFRrSYz3LigrTw4P8pp+eMZxLKoDNwJ010MsbUgNd1lA
         8hRjT1PwOFJGWlbXIQH6/MepT/3MIshkspN9tkv7rwjaQC7FaWKUXUDbExtmXiY9c9qp
         GDgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU315cpw1iXr2XxvKu7vVD0khe7SjoU94T10Bju39d7eRDs3T2SBvliGfD/cmempUPLM/qT+Sq66yNe@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3fpCnSskHOf3KrDb2dtwQlcT5cUalkDDZMcdqjTf331a5c7Iq
	8i46W3OdySPV/uC8rMKMQ3/6cNSZyqRLeM39RdaN5SFwSC8TCcywcwAx
X-Gm-Gg: ATEYQzxK516IKbVpLrj3cSOvPxvgkAJ5vtMsYvGhNNhGzEI+3XXSKgajbzCDz7iSiJl
	SaXqfAJptXU1u2cTjkou/jnxeZAevjtktHo1+eT/ZhTHqK3AShSLjd21DNmSEthO/dYoSX3t7rP
	8pno03AVRJzu1nfJasSXJHzbHbHzw5ptriK4D3alCpXMoCczMTAiQNl9yu7lqmwNl4G5ZCGNzps
	xcIrufsK5WwIac9hMD1C65EcC/m/sgufDgQsmQ6KUAb7QrSgEhIYq1qT+lryYC3Dpp06nW4hN4O
	yNPQ16TUpHwbo7eRcTSvjYdX72J7PWCCgGvPwV7+EXmJNgtF9DwQJGjRRRb6h2u9hguBhw5EKkd
	ah1qCTUJ5ppbZh83OtLSOB4sjL+AwMY2HZ12FnvAIPhji4H35RMd9k2HOpl6GmzSbGW+rUnYMRz
	5Fp4uBUIwSpDgWSYbW8vc3jET4Azd+cDq+OKDD675Vrg==
X-Received: by 2002:a05:6a20:728a:b0:398:4a1f:8a54 with SMTP id adf61e73a8af0-39bcea1ec6cmr1106337637.2.1773966064970;
        Thu, 19 Mar 2026 17:21:04 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a801701sm428255a12.4.2026.03.19.17.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 17:21:04 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: hare@suse.de,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	yjshin0438@gmail.com
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>,
	Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
Subject: [PATCH v4 2/2] nvme-auth: Don't propose NVME_AUTH_DHGROUP_NULL with SC_C
Date: Fri, 20 Mar 2026 10:20:45 +1000
Message-ID: <20260320002045.1927526-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320002045.1927526-1-alistair.francis@wdc.com>
References: <20260320002045.1927526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_172105_831553_8F3A7C41 
X-CRM114-Status: GOOD (  12.71  )
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

From: Alistair Francis <alistair.francis@wdc.com>

Section 8.3.4.5.2 of the NVMe 2.1 base spec states that

"""
The 00h identifier shall not be proposed in an AUTH_Negotiate message
that requests secure channel concatenation (i.e., with the SC_C field
set to a non-zero value).
"""

We need to ensure that we don't set the NVME_AUTH_DHGROUP_NULL idlist if
SC_C is set.

Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v4:
 - Split out header changes
v3:
 - Ensure chap->sc_c is set before the if statement
v2:
 - Use a macro for Diffie-Hellman Group Identifier List Offset
 - Use a pointer for data->auth_protocol[0].dhchap.idlist

 drivers/nvme/host/auth.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 405e7c03b1cf..5b936ebb4347 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -125,6 +125,8 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
 {
 	struct nvmf_auth_dhchap_negotiate_data *data = chap->buf;
 	size_t size = sizeof(*data) + sizeof(union nvmf_auth_protocol);
+	u8 dh_list_offset = NVME_AUTH_DHCHAP_MAX_DH_IDS;
+	u8 *idlist = data->auth_protocol[0].dhchap.idlist;
 
 	if (size > CHAP_BUF_SIZE) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
@@ -141,21 +143,22 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
 			data->sc_c = NVME_AUTH_SECP_NEWTLSPSK;
 	} else
 		data->sc_c = NVME_AUTH_SECP_NOSC;
+	chap->sc_c = data->sc_c;
 	data->napd = 1;
 	data->auth_protocol[0].dhchap.authid = NVME_AUTH_DHCHAP_AUTH_ID;
 	data->auth_protocol[0].dhchap.halen = 3;
-	data->auth_protocol[0].dhchap.dhlen = 6;
-	data->auth_protocol[0].dhchap.idlist[0] = NVME_AUTH_HASH_SHA256;
-	data->auth_protocol[0].dhchap.idlist[1] = NVME_AUTH_HASH_SHA384;
-	data->auth_protocol[0].dhchap.idlist[2] = NVME_AUTH_HASH_SHA512;
-	data->auth_protocol[0].dhchap.idlist[30] = NVME_AUTH_DHGROUP_NULL;
-	data->auth_protocol[0].dhchap.idlist[31] = NVME_AUTH_DHGROUP_2048;
-	data->auth_protocol[0].dhchap.idlist[32] = NVME_AUTH_DHGROUP_3072;
-	data->auth_protocol[0].dhchap.idlist[33] = NVME_AUTH_DHGROUP_4096;
-	data->auth_protocol[0].dhchap.idlist[34] = NVME_AUTH_DHGROUP_6144;
-	data->auth_protocol[0].dhchap.idlist[35] = NVME_AUTH_DHGROUP_8192;
-
-	chap->sc_c = data->sc_c;
+	idlist[0] = NVME_AUTH_HASH_SHA256;
+	idlist[1] = NVME_AUTH_HASH_SHA384;
+	idlist[2] = NVME_AUTH_HASH_SHA512;
+	if (chap->sc_c == NVME_AUTH_SECP_NOSC)
+		idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_NULL;
+	idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_2048;
+	idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_3072;
+	idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_4096;
+	idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_6144;
+	idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_8192;
+	data->auth_protocol[0].dhchap.dhlen =
+		dh_list_offset - NVME_AUTH_DHCHAP_MAX_DH_IDS;
 
 	return size;
 }
-- 
2.53.0


