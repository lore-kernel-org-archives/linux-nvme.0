Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0EFC9830E
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2026 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QGtfJj/2QVyXwkVd2oEpGeaL7AqDn5it/MaukwH5TUI=; b=zTa8qcnCg7ktiDaEBfogdgb9em
	WP9ajQ4XrQ6Zkul7+TlyLvrzq6w7qMH86Zl/a0zQSdlFOC0NZ7xKT1JRRKn+wv/8F0EXmuu8U+9yF
	GNML71+KhtPSE8bBCtCAH28/1hzC9RiODc/hTXEGMnnZljLhXM3rqPDtfMLwh64dB+YdXIjoB8R8o
	CNH5Z8K32qmy5L/1/D6DlhsP5WsLLLV+4zY8aII81mnoZ2dZ4eSdqGW3OGfVjJbz39tjYB8AeBewv
	kiUG1iaTbYKjCxkW0JbKYX+9dblM5qI+zMY9VNLvWHZt3EDGHE6JTGmj5mtSqz6uWPyIdJneZ4JGv
	QxPDJqeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA2X5-0000000D1eb-3DLH;
	Fri, 25 Sep 2026 09:47:55 +0000
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA2Wo-0000000D1U6-1Gp4;
	Fri, 25 Sep 2026 09:47:39 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 75709EC0170;
	Fri, 25 Sep 2026 05:47:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 25 Sep 2026 05:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790329657;
	 x=1790416057; bh=QGtfJj/2QVyXwkVd2oEpGeaL7AqDn5it/MaukwH5TUI=; b=
	AEgwzEKP5JCGD5R+lkXXu306gIanG/9WIgHg1vdm/OUfBjv56Pq5saBWKy7g4d77
	n+cx7JAxSgJ8C8hO9lnS6PUBPm+j6qlqI4+h+EvMN/tPYUonmWelSbW3ujxPIeCS
	e1vvfHVCCSnORnVcJO0JdJGt5ywXsfc2h9j5JHCWJfeYCAO1th1dKAgI8CtEB9xL
	Nco2o/WBB0PBFX2VwNGHQM4nI/7YGECs+6pzYWjrcalwHKinRJML/EIOyFszeTJL
	rnLhfhPskA776+wbz5cprAPY5nCVpj7T1CTbHuX8qlpscC5Bgrm4p49a98w8B+2J
	X8Wd6fRGiSjJW9VO/Uf5wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790329657; x=
	1790416057; bh=QGtfJj/2QVyXwkVd2oEpGeaL7AqDn5it/MaukwH5TUI=; b=F
	S9A4EhCYsBYKQpHJtrqloMttM8ae3nnFJ12HeHywygh7vksgcKIXTrrJyraKkXeZ
	w27R65qMQM+iqyvoGHG1e4uk4u8yGy2PLtuDDlelromhC3MJUebg1omokPIiBn1Z
	lnblZ0PvD+fMpQU8lVvBUNcXgeFh1IwEkoQZt4jq/+aWHTpL9OM7/BG5kLHk2opD
	AlMEmoQsEj7QCQGg1PvBtjKrBQkRhuPDDtJyX5uuMWgvV6pNNQaMXezytRtJfYRh
	WyfCh4n2/1s317GPvuBn4F9tcJjzWt7+TTC8FlTSVru+9jEEs+EMWUfRzAwcIH3F
	EABpotXpEc5iHBh/pjm+g==
X-ME-Sender: <xms:OUO2asMbDY7BYYOVaPiiCS2CGUq_NHP9SJ_AaXjw2VEElJHd_M7g7g>
    <xme:OUO2aqCapbQD8Lzo3jKEhNOPd6pV8RPGc1PZgFVrmp-hWgupxtAyLikeTlcP4CJkf
    LOS6PBeYR9YyWPoIQEz3MN883HC00oJ_RnNBa0oQnuGsCVS1wK4Tegb>
X-ME-Received: <xmr:OUO2aq-3uAhdEUkakfgFQGNNUECMLyYxMCE8SLSYDi0lj_ScEtJ0X1hmO8u2hks7A6krtsw>
X-ME-Proxy-Cause: dmFkZTEbJhpSeMD7LDnpXCsQixag+cvxD3bFoso28WtgwG8J22LA5vwA2EmaCBywrGkNVk
    fJMjIB1Awjw+5D30C7m+Dp9Vxht3KEjZe6Lqrn96FVDODdxJTXUrAFR/eapVtvwXhviQS/
    JjIqmjL9odLytU7DATY/m+docx/hb3FWUj64crzCk+tps7ekg8phg3zCMXxYaP0Ob+waHV
    cSSktW8VoIuVmdCIqemuf0fMDG7R4dEOgW1ZWVrHKk37AKRJ6VGIvRwRezkqZ1pcO4AQYm
    oPUZAjyu+mKYQUVO4Gg0cdt3FfSRHd0FcPgbe7x6n5fIfG3GTyJW626LUIjETbYg6L0Hf9
    L7WC4e3p3kgxDcS0qluWtHix4lEm+ABtP2b1v70MG9FvESBXEK/uyUOfBRiwlfOtzdm05m
    cJJjMzp1GQcQ46LAVya07PF7mgmDkFO8mVNnz1/jG9UjAhgohkC75h/Ig96rnJLovJnPq4
    5EDsrUsZv+bAcxxmbVYf2ZjuGT5SBLJH3RaJGNxoZAjpl0n/Pe2No4Jma8CBGyuVXQ/du+
    mAEHY0pLDMUUHmtMFdiKGGifDoAEfNz1mpB6rcKuTRwwjXBDGDxUa4p5vKSWleFFf94FnX
    R8BUBzFNvt6937KJiME3v5zP62YswBbpDN3Zi7KyGJKFDDsrCnh0W+eTn7bw
X-ME-Proxy: <xmx:OUO2arEjEI3GwCuT4xaq3ehBdDaEsmaWVvRXJs44VWP3nJbUGbf0hQ>
    <xmx:OUO2ahJG1nP0MXfV6E9blaajtCXljHtqiaB4fo-XFvdKInABhXhUcw>
    <xmx:OUO2aueymaeoD7XAxxHF00lqa1AxvEdnQyTqt3FV_5B-1MSY0ZTpnA>
    <xmx:OUO2auW6T02t3fYY6odaTn7yac7zNAYAFWP_4-mkFu9xxvM6tn5zFg>
    <xmx:OUO2ailSZv2BsMq8Z9wZOANF3LnFemu_Xjm-8czTTXojdAOPrWqk7O0h>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 05:47:36 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 25 Sep 2026 10:22:49 +0200
Subject: [PATCH 2/7] dt-bindings: mailbox: Add Apple M3 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-apple-m3-nvme-v1-2-5e832e2f4aa9@jannau.net>
References: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
In-Reply-To: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, iommu@lists.linux.dev, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=j@jannau.net;
 h=from:subject:message-id; bh=VHauq/A2zwlPP8nlOXF4CzWsLsS2GlAVhYD21ZZ6fzM=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxtzlqr/j2dW5bDv06h9NTmvd9bVro6u3dKTZiqOjP9p
 nHqS7+cjoksDGJcDJZiiixJ2i87GFbXKMbUPgiDmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 jXSMdYwYuDgFYKovbWZk2DrXWiDKb2ld47rS6RuPt9i+2Pvyu3x7UG1B45uzkn/XLmf4px9zx/L
 tH9PNh75rZl58P/Wo65qQ2cIL1ocvW8H25+mRG9wA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_024738_440690_7CA2B0AB 
X-CRM114-Status: UNSURE (   8.46  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The ASC mailbox on Apple M3, M3 Pro and M3 Max/Ultra is compatible to
the mailbox on M1 ("apple,asc-mailbox-v4"). Add their per-SoC
compatibles "apple,t8122-asc-mailbox", "apple,t6030-asc-mailbox" and
"apple,t6031-asc-mailbox" to its dt-bindings.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
index 28985cc62c25..9a6dfb0b2f28 100644
--- a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -30,8 +30,11 @@ properties:
           - enum:
               - apple,t8103-asc-mailbox
               - apple,t8112-asc-mailbox
+              - apple,t8122-asc-mailbox
               - apple,t6000-asc-mailbox
               - apple,t6020-asc-mailbox
+              - apple,t6030-asc-mailbox
+              - apple,t6031-asc-mailbox
           - const: apple,asc-mailbox-v4
 
       - description:

-- 
2.55.0


