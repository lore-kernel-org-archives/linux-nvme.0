Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FEBD59D96
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 21:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GC6IvZWZUQnXXYpx6jpGvClGW8GwD7o+6Enl7mwIwho=; b=KDcl/TxSYp3yUKERFH/wtpzN3u
	tFFXo6uxMKgnA4Vz77G0kEuPJcKlyF0HKFO8hfta88TZ1ii0aWFIk3Wv7Z9t04VpbHWKgvqXAfK4U
	dO0zpwt00aHwIO2oEtUczAhKuS8dheWa+DKrh4gg09eOlxdX3fotofiUx88M/WLTwxxYe+blxDvfi
	dg45Dm9qLzcPK341Qi92kVz6kQJEWP98tj3K7RXObh/Nve/dcaxfiGJbIUswhGIeRRV7rjBChWfqD
	5ssxcb/5UnaxkfXCcLRlNwsUluoLzj6Qr5yNk8pPzWKDq/l5iPOy/YZ57KMrJiOaOdDevZByn5vE9
	KYGTp79g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUAO0-0000000160b-3BtB;
	Fri, 12 Dec 2025 21:09:12 +0000
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUANu-00000001602-0Am2
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 21:09:11 +0000
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-8b144ec3aa8so152952085a.2
        for <linux-nvme@lists.infradead.org>; Fri, 12 Dec 2025 13:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765573744; x=1766178544; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GC6IvZWZUQnXXYpx6jpGvClGW8GwD7o+6Enl7mwIwho=;
        b=D70/h36//EZIsYVLbjWf9Qy8AWX19B4jFacE7S2SfJT3MzrLsG4Ow6jgyLZrnrC1hd
         9AHlda/CZMQ5hA9Qo9zpcY5mK2iJ5rp2ZN+H8Mz7zNQMYj+5NlHQNKuitXY3YjE2GJip
         OO0a40xMPe0nyJHa2ljg0BgUVc0WJn7KKOc+YlmLnuHwuFx4bq8TQHbOW4XyyIOGV62p
         GNqyFI0U4lPU+uvDiv0iFD1eK50s58Fr5gUsdeAAOSGXU83lgrCQyd36OhbqObHH7cMu
         KOvqOF3lYxcHw2BiFKZyS1SxCFY0SZxj2UJkDq2ENIyN/lL1hwr8wwQf6RCoJU6VC6YB
         1C9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765573744; x=1766178544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GC6IvZWZUQnXXYpx6jpGvClGW8GwD7o+6Enl7mwIwho=;
        b=caXT3Q8eBG/xCE0XoTp64RY8RKIf6HtrzT6se2grEvAs5IyFkuBJPfsYsmD/OpN+6x
         HzYDg9ZKao4MXyi35R3l+0RDEGetRZIXzK5ePnv0vWj+KX+GlTiAHdh8OyFJZ8ksvCDU
         XU1AEMyOPvrbgd9W4yIXUYcF9bVNQzuylgR37o9MsFofQmVzWZoULbbHwHvkMxyKeMYJ
         dkvobRc7E9UQ1IVBHKSfToKcHImahkEUvJaqmz29yEWH70+BpoMc0uCm2iDNLBaTPY6I
         asa/2s02Unn8GfnYzrc9srfcXYc7/DoearEhqIsLgCAe44XzanxQ4t+CKiTpd3ucl4ad
         JzdA==
X-Gm-Message-State: AOJu0YwHLbGLWL6j+z5NzBXGJgBWo1xOo8md3+UySEoHjR3asWwfGnl5
	Q8tvxKzEn7u6Ry1Rus9cLgCm1plaihPLRCf3lSGLEl+GUq+w+17IGcuJKdEBuiFY
X-Gm-Gg: AY/fxX6ckmd/vSH2STx66KCsEwBWJPQd0WReBZTNfamJweIr2C2ZiCz7yKzJ4suRpvI
	LNAZJTHiHhB71km1cSJjMbaiJ3B8ooHIhIQHfZSxXrsMBrwTkblyfMVvuQtikwT0oI85kSD3vx+
	6C6++fItRWNFXw3pmuxZW2VqG5UO5dDMvB9zMh2R1rCZ8pZYF3CrE9UKfo2DZvtAk5R6AlFLdOT
	Xksf24ZdvvMFahzs3cuaD7R4jQd8aGAyjZ1448Sk3Z0XBRNhH0B5+Hml5EBffTB1iDcOHZOc5Bt
	ykHrzHzpJBD/ssHkULd/B2/AXuxF9EAeAVeiF63hlMVWnRb9X1Pj4FCdytLN2efgL+sY+pi33v9
	K/2hWpq14SjylsNUk4bSV+nMFixjzuOSMO0pX4lJD4CqELDZNQBDj5S+L52Z8BEkV1b5LL3S9GD
	e68xAlFWgvVTznSW/kfax/8D1Kyycw3iK0WF5Ezf5Mg6zTx9MqSvxkEc/28UA=
X-Google-Smtp-Source: AGHT+IHojb/6JlhvtbPcOtoxIiuj02Gvcn2jApJ2FcRBvq7e9/WMDjxAmhgDh+dF4MbQSDf5e0T8cg==
X-Received: by 2002:a05:620a:1786:b0:8b2:df32:b8fd with SMTP id af79cd13be357-8bb3a6222bcmr451119285a.0.1765573744246;
        Fri, 12 Dec 2025 13:09:04 -0800 (PST)
Received: from rc-szhan197-01.ad.syr.edu (its-crushnat.syr.edu. [128.230.103.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5d3f637sm550577085a.39.2025.12.12.13.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 13:09:03 -0800 (PST)
From: Shivam <kumar.shivam43666@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk,
	sagi@grimberg.me,
	kch@nvidia.com,
	hch@lst.de,
	kbusch@kernel.org,
	gregkh@linuxfoundation.org,
	Shivam <skumar47@syr.edu>
Subject: [PATCH v2] nvme-tcp: fix NULL pointer dereferences in nvmet_tcp_build_pdu_iovec
Date: Fri, 12 Dec 2025 16:08:50 -0500
Message-Id: <20251212210850.1025123-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d5fbb80b-ed25-476c-a53a-2d9ce98a58ff@kernel.dk>
References: <d5fbb80b-ed25-476c-a53a-2d9ce98a58ff@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_130906_088352_444ED467 
X-CRM114-Status: GOOD (  11.01  )
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

From: Shivam <skumar47@syr.edu>

The CVE-2023-6356 patch added ttag bounds checking and data_offset
validation in nvmet_tcp_handle_h2c_data_pdu(), but it did not validate
whether the command's data structures (cmd->req.sg and cmd->iov) have
been properly initialized before processing H2C_DATA PDUs.

The nvmet_tcp_build_pdu_iovec() function dereferences these pointers
without NULL checks. This can be triggered by sending an H2C_DATA PDU
immediately after the ICREQ/ICRESP handshake, before sending a CONNECT
command or NVMe write command.

Attack vectors that trigger NULL pointer dereferences:
1. H2C_DATA PDU sent before CONNECT → both pointers NULL
2. H2C_DATA PDU for READ command → cmd->req.sg allocated, cmd->iov NULL
3. H2C_DATA PDU for uninitialized command slot → both pointers NULL

The fix validates both cmd->req.sg and cmd->iov before calling
nvmet_tcp_build_pdu_iovec(). Both checks are required because:
- Uninitialized commands: both NULL
- READ commands: cmd->req.sg allocated, cmd->iov NULL
- WRITE commands: both allocated

Reported-by: Shivam Kumar <skumar47@syr.edu>
Signed-off-by: Shivam Kumar <skumar47@syr.edu>
---
 drivers/nvme/target/tcp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 15416ff0eac4..d5966d007ba3 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -982,6 +982,18 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		pr_err("H2CData PDU len %u is invalid\n", cmd->pdu_len);
 		goto err_proto;
 	}
+       /*
+	* Ensure command data structures are initialized. We must check both
+	* cmd->req.sg and cmd->iov because they can have different NULL states:
+	* - Uninitialized commands: both NULL
+	* - READ commands: cmd->req.sg allocated, cmd->iov NULL
+	* - WRITE commands: both allocated
+	*/
+	if (unlikely(!cmd->req.sg || !cmd->iov)) {
+		pr_err("queue %d: H2CData PDU received for invalid command state (ttag %u)\n",
+			queue->idx, data->ttag);
+		goto err_proto;
+	}
 	cmd->pdu_recv = 0;
 	nvmet_tcp_build_pdu_iovec(cmd);
 	queue->cmd = cmd;
-- 
2.34.1


