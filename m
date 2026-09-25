Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB49C9830E
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2026 09:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZKds3jhyvr2c1oIlOBbIUjibttuUK3PnIKQuStdp9cM=; b=KHenfU0tX3XG9L843dI1zTvHqF
	VuCtGGpRT7ixe3YNtB/39rDrvnS4/KzAALcKJchZhCb07WaudmVO1j+6UK6+mW0SM4oW+U2lz+1z7
	MmEagFhYodvJYmj8Q5SoZrp1u7l8/HiOPSbsas1KWpaeFglhyQ16DYnk3TF6V7JNqaSzs9TJLRUN9
	0V5ASpYaFKTlgdmnZTxWz33SvtSLeEyKQdl2eWXDtGA9ELoS8vDAjGAhQfZWNsFhk/EhjwtyebxGX
	N4twHZ6BYMMnujRA8ZbaM1FDGf77ZH+An/eUnoRmjqivRLDtfDy7Y10gMM+imfRLM+Qw1Ewg2NYxu
	yaxJ73Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA2XC-0000000D1kt-1dKL;
	Fri, 25 Sep 2026 09:48:02 +0000
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA2Wu-0000000D1WE-3CJc;
	Fri, 25 Sep 2026 09:47:45 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 02A35EC0120;
	Fri, 25 Sep 2026 05:47:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 25 Sep 2026 05:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790329663;
	 x=1790416063; bh=ZKds3jhyvr2c1oIlOBbIUjibttuUK3PnIKQuStdp9cM=; b=
	ZO/yHssmVZfy3NIClHX9L7N8oZG+lVfNv9ohGehaj+M1YI4DpvtNy0eHiabGjTj5
	Y82yZhPYemoFOPUEzbKzXV2zQE0IVyVi+csGwL7xIkmZU4CQJdzAkPO/QxR4DQ4Y
	D0ztmJDiRrost9aSqCWFazuNsNEGSXVAPNyYJ5bzly0h4M7DVCHQuE2jKKUBVbHY
	99V9r0V3O7Nwvo1UeWYBVbbS35DW1Kbw8F8HtaH3Kf/jOM/vXqeN62zVPit5F/RH
	UNAgnWdHwqvHxnxpGb4Z4qhFLLWY5MWadtWod23kNDTeE3amyHqzztbyKXy3HVvy
	HZxgWmidVJukwnibGJ3htA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790329663; x=
	1790416063; bh=ZKds3jhyvr2c1oIlOBbIUjibttuUK3PnIKQuStdp9cM=; b=J
	CvfJIRHfppFDHrsy6Tcls5YUeVR+BtsCbJLgz8ea3A4s0TqCtXnUBTAsGjAGpVqH
	1PxzzZJrJa9jA9FOCH4Z1d5fFxArCk8+PY2BaUpodZq7VCJkQzMn+dyrfD5V4Bqe
	gAAtMn0nE276WQgm6g5BXVMKuX/rjgaanE5Lfo+gxOOUtPPrn3NBbIMQWkE1eu5L
	elR8moT54gs0gvY95ISCmkPJtTwiYqVIoi6r+AGH1PtKj/knJRExQxBoPyfiivI6
	kOz/lqVEzpum/+98a1ULLY1oDrmY8mR5n3fb+V5a5NddchUyS8efj1SOWVwagDbQ
	vyGwsZ9oUNujUUbg/HSJQ==
X-ME-Sender: <xms:P0O2at_8R697OUyKFBysvfzFZ1zFneMaDP_LzsdbqrfQyG1M1nLO7Q>
    <xme:P0O2aoybxo7NCvh4n8fQFI8G9MR1M6Wvjh-Pibf99VTe4tTjNq207meCRNmKgtD1W
    738xY5I4D1zftd_CsJWL58GmE5V-maJZnW8ZnA5HInImsTlb-pDXmAH>
X-ME-Received: <xmr:P0O2aiskKhHmUE71-9pN-zbZ7KN8LUxQyzwhXb3jtDYFV4mN5xwnqrPo7FtLmNFktUGCZH0>
X-ME-Proxy-Cause: dmFkZTFQRNgAgioZIU4NTnAZzHVH36NSAZTQ7iz3L3ABJ5sfwezucZ0ckZGmH2NBmgJgD7
    DN11+Ml5ivhbNuehjt1LKgSMsZHcywAdxibkNH4Kga9zat1WfmAwzTx0EFnYSewxXBTcuR
    TWE8CqCZXpxKRVbygh8B1D1gTnKvA1U71y03O31HooTNYqybm4TYij5RPCIUTviNeUYIJB
    iTsQeyUc0bNfSKUAa25Ko49AntFGafBIVM+522RaCs5/WgtP9P7vc7O7KQlTsQr0I/iKiG
    7xgqQBcKXOa192Yiyt0OaEFJRMKqtNor8hj+mUNDg4uM6GMTAM5mgorTwokU7R2JbH6mnx
    0j1TFnDsWDtM/72ZCzHJR17lzO4DSv7srSINzRdygL3Ss0cstAVZtOjlwIgS6L4sq8Tv76
    0BNeHvQIoPAfowvE5CWrnEXNyaEX+wBlZ97097U2k5i+BU6yzvFJeo1HsVqZrWGmKjbS2b
    OvU4ee62ElUHtXibc3mBiWOKjSQEguu4Ki/o22Ghf9hflCiwMB3yTeMR3QgIhfHRP3iwpf
    jQwojrOWBbqlPfoXbQPRPVdiPL5YFnWmrW95B58YTBjUuWhMwnETd2xb1YpwLqYqwNKBYv
    jjlaIHt1qy9mVpePriniHTw+8LBsQN13yXkoZ5qBz+SrYc8cizFokkLAzraw
X-ME-Proxy: <xmx:P0O2an28IpeLmVZIM0VEBXpsI19mMskbYHHRXo6PoqhcNOlQFlEA8Q>
    <xmx:P0O2au6cGDf2aENNaLiQHswHyHK4W3QsMNDhxdiIcKhyphiWnnVbEA>
    <xmx:P0O2apNWsj-ttIjn74Kkdu1mbmyVKFrM_PDXwI24_ZZ0Srqh4s3pZg>
    <xmx:P0O2aiHzaT0KqEAOqM8ueGq7QpJHyCpGTbrYU9GKYsoZbBzwJ57SFQ>
    <xmx:P0O2aqVA9smWiw7MD_FfljQXgv2W0pUdz3rkwUMX9N903RQ9WbKrtrKT>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 05:47:43 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 25 Sep 2026 10:22:51 +0200
Subject: [PATCH 4/7] dt-bindings: nvme: apple,nvme-ans: Add Apple M3
 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-apple-m3-nvme-v1-4-5e832e2f4aa9@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427; i=j@jannau.net;
 h=from:subject:message-id; bh=j6a5quoDbZWNbFaX0hWTw5YXeszrdTDrQRilyskDtCQ=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxtztoq68+7PTl7+X78miU6f/nfGdu/NbpR6dK2fkfbV
 q3++aeYOiayMIhxMViKKbIkab/sYFhdoxhT+yAMZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx1jFi4OIUgKlWlGH4Z8T+6EDQSw3no3nC5c8+e7Wa/Z/knLZq3p63E1id4h5372dkOJCovox
 h0/9w31tzjTneCkfq8q7LNPRQZpVwnKTA1TeBFQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_024744_906883_10623941 
X-CRM114-Status: UNSURE (   9.73  )
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

The ANS NVMe on Apple M3, M3 Pro and M3 Max/Ultra is compatible with
with the NVMe on M1. Add their per-SoC compatibles
"apple,t8122-nvme-ans2", "apple,t6030-nvme-ans2" and
"apple,t6031-nvme-ans2" to its dt-bindings.
The NVMe on M3 Max/Ultra uses 3 power-domains so add it to the
power-domains conditional to change 'minItems'.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
index 4c0b1f90aff8..10ca8cc5f52a 100644
--- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
+++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
@@ -14,7 +14,11 @@ properties:
     oneOf:
       - const: apple,t8015-nvme-ans2
       - items:
-          - const: apple,t6020-nvme-ans2
+          - enum:
+              - apple,t6020-nvme-ans2
+              - apple,t6030-nvme-ans2
+              - apple,t6031-nvme-ans2
+              - apple,t8122-nvme-ans2
           - const: apple,t8103-nvme-ans2
       - items:
           - enum:
@@ -75,6 +79,7 @@ if:
         enum:
           - apple,t6000-nvme-ans2
           - apple,t6020-nvme-ans2
+          - apple,t6031-nvme-ans2
 then:
   properties:
     power-domains:

-- 
2.55.0


