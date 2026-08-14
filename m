Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3DCC5CFC1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2026 19:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8qt39tWaDTPOV680UZL11ems19BuKoQqgDcx36aFXLs=; b=WuI4m7uAlwS4WKnU2eihHRvI9D
	DOnrx8anPAHEJWawGToGR/87hhxMaMIuWZFuhqDwGXM3tv+ZOhiwlkR7R9Oe8Q/iyTNKliCTG95Eq
	3roln2lQdxvMl3QvV7pkif+XqKMHy4JL4tsM9x7O6oZW9vhoCZQoeQtN9oTMd7awNIMMROSQWKCYf
	BUc2Q72Rz9L5pqa/5aOTUevvPlJ9W7LgFh8IJFNMcZU8tCUbM9LwpkRn6hkXptdK4m49fcodAC1FJ
	MLSCk4f9rQqAFYKBuKJd6swOojtvxLqzTlqTeDMua+TdmC7f/ZV8e9x1zUYUvEdfJH/DhT+i9en+H
	hKW8NYlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuxtF-0000000378G-3tFk;
	Fri, 14 Aug 2026 19:48:29 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuxtD-0000000377c-19Il
	for linux-nvme@lists.infradead.org;
	Fri, 14 Aug 2026 19:48:28 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-526f963372aso9445681cf.1
        for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2026 12:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786736906; x=1787341706; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8qt39tWaDTPOV680UZL11ems19BuKoQqgDcx36aFXLs=;
        b=l7wvt3q16ezQzK87VMCLWVTdBEkoSDK/tZ5tSA+xVj9eJCXpkWef4TAYPSAwi/lXem
         w4WIv0ecd+dzgp4qQapUD+uo8YO3Zl8wyuyb3A/o1epuHpL7EidngMmPPHqtm+eC8pYv
         wePACC0Fax9NRyn4hQv6tzmU0BOnMvngLKGkQKZobgX1MZk1zvJB/vLZno7xdhh1x6Zs
         FEIePXWVXZSsPZtDUpuEjnpGJu2MrV7J9LbmpD7DANdjQG2Wh4FO+XP0OSwNJfGsMgpB
         p/GuXyWUy3p4bVHCAfxySeWATCN8VnpJasEw84xo2Fg1nRvSvli3V0OsTfVtxM1o/K6m
         kDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786736906; x=1787341706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8qt39tWaDTPOV680UZL11ems19BuKoQqgDcx36aFXLs=;
        b=lN7EYdK52CwICJ22TN7rmzY6CU8XQZVx0hvVIPBUFCnOTtMDSIHei0g8IL60i+fuhC
         ljam2zOObpu37/yEFSyDEZDc/h8RPbJnJbIkxk3ozy2jb36NWZBefSKWEpxAMZNyKmwe
         jIdTUraJMEd2AjlN4AO9CVtNytDKGtp/b+vqtaiiNzTEQ9+Wc7BrN+BcGAb1ehlhFV46
         KwvpK4EDkoTfztdHW8onLLx6JeosnHaC39LqEiy4TgMtnN826jhiXIGr0I8iiWuUgfu7
         vV5XBpiUxn9BnwchLEbVBu9sQG0vdtA8Kk/btG2/CG3fwIcg2KemxMLQoiR92vQtb4zN
         uCTA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7IpA9BoUImJ/sqbGMakz7sGzFmnSBwGiGyFIINLCVxJUjcs+aXQsn9RUm2bDcOSFCIdHRaxMHWnM5@lists.infradead.org
X-Gm-Message-State: AOJu0Yzh6KdAeTRSMd/+DpYhVJB36HmeRVtPwLLdLwvMlc13G7wbuTlo
	V2Q9j4pPPJictzeHIfYVbYL7AD3sCB2Oa51HNdMpOJ8T2QEIOkmnbSaH
X-Gm-Gg: AR+sD13Y8OYSPRKe170XPcAr9LMlKjAAcPJ1JvNprxfeHD3KC98le+8/ujhTCpnURKF
	frdM1kzCFb+MxrmXSG9x7WQII/cGjic5YeCIFwCbFHQLwXUo1BpQLNRzliPTXc1UNLLbwDxm8zA
	ti48n0VfS0a/vx7AMmvlfZ27NcGK858iR+DSK8+2fndEJzxpAyrrBclTh/VPQtAMUU9SMkjG33/
	PalHLn43ybxRFsnuNBvE+XwMv4agZdHNhLoDqvq7AfQpCveIIoLgAvu7Ic5XUqiHe9v4O6CqnSX
	AnJy9CZObzYoEgHmRLt6ANZRR+kaiYLmrY7KmHiNQCwcLhcb7lUMc7Veus4qDh2yuOpPtcZGKgm
	QjoLvkNn6OuaxmzO96sTCvYUgbmrg+lB5ZTyLv7M8ctCNyAhoVx0OzIuESB29zjCF0FF1ibj3Is
	A45BPOC4akRLCTr8gdO18qQXTIK7oJFicqTtGEkImo8t2qlJThg4pcG81oJ+D9nYK9Gvpzyb39g
	jWj3uKHYMbxJ5OOGKZhDqht7A==
X-Received: by 2002:ac8:5ccf:0:b0:528:22:8c61 with SMTP id d75a77b69052e-52d854f3ce2mr103561651cf.38.1786736905868;
        Fri, 14 Aug 2026 12:48:25 -0700 (PDT)
Received: from shivam-EliteMini-Series.syr.edu ([128.230.213.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce1ea65fsm340247485a.30.2026.08.14.12.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:48:25 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: security@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	kumar.shivam43666@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-tcp: fix out-of-bounds write when receiving an over-long PDU
Date: Fri, 14 Aug 2026 15:48:11 -0400
Message-ID: <20260814194811.1581041-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081459-handoff-wildly-eeb5@gregkh>
References: <2026081459-handoff-wildly-eeb5@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_124827_326676_1D8A54A0 
X-CRM114-Status: GOOD (  13.73  )
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

nvmet_tcp_try_recv_pdu() reads a PDU header into the fixed 128-byte
queue->pdu union, then computes the remaining payload length as

	queue->left = hdr->hlen - queue->offset + hdgst;

and reads that many more bytes into &queue->pdu + queue->offset, without
ever bounding the result against sizeof(queue->pdu).

A struct nvme_tcp_icreq_pdu is itself 128 bytes, exactly the size of the
union. Once a header digest has been negotiated (hdgst = 4), a second
ICReq passes the hlen == nvmet_tcp_pdu_size() check but yields
queue->left = 128 - 8 + 4 = 124, so bytes 8..132 are written into the
128-byte buffer -- 4 bytes past its end, over queue->hdr_digest and
queue->data_digest. Those bytes are attacker-controlled (an ICReq
carries no digest), and the duplicate ICReq is only rejected later,
after the overflow. A remote unauthenticated host can thus corrupt
kernel memory adjacent to the receive buffer.

Reject any PDU whose declared length would read past the end of
queue->pdu before the second recv.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/nvme/target/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 75a276d73be3..c9c98b8eb149 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1229,6 +1229,8 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 		}
 
 		queue->left = hdr->hlen - queue->offset + hdgst;
+		if (queue->left > sizeof(queue->pdu) - queue->offset)
+			return -EPROTO;
 		goto recv;
 	}
 
-- 
2.53.0


