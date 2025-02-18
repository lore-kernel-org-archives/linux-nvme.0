Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873D6C021AD
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 17:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MREDDKhkSsDOa7xmYAOWCQtQ93NI2ABeBhuwuLH+9i8=; b=gAgOLH5E7BY8/+nDuVg8kXOSpb
	j+p2HRRE8QuAVKK+82Qutese5mK4wNYaUdBrnjNgrL91712vvHgyAiwBvhTxP8L0BBqJgrudfRYfR
	A5Ywm2m+WiyBj4dBut5m4FalmxfZiznJ2eh60LOWRLm9niYtGAbYIQCaGxvFb+Htwp4bAk3ZPJ9t5
	kCXFIYYpbCpplfkF16b2vhhcuC3x3Fd8gN8FUMb0utgtcuwdJteTeMdC6gpRaMlctCUovUitldm38
	/42o56m1z8GaR+WAfv6kK372uG7+Z1VTDbdVfScehRIAbVi0slhJkjtObSZ8RhNxeK4l+na8WUYRJ
	ON9XdPvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkR5X-0000000965G-2YWb;
	Tue, 18 Feb 2025 17:08:51 +0000
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkR2Q-000000095DT-1JBF;
	Tue, 18 Feb 2025 17:05:39 +0000
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D37411401C8;
	Tue, 18 Feb 2025 12:05:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 18 Feb 2025 12:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739898337; x=1739984737; bh=MREDDKhkSsDOa7xmYAOWCQtQ93NI2ABe
	BhuwuLH+9i8=; b=HB54p5z9Ijb9huJQnCofy6AS/yZlefV3fi4VBsAODeFFhaec
	VeFZ1StYrpK0jsFGMNCu66l+upbHTOsT+teY6tawr9J98Hok8WqlqGLTpt507CKJ
	YASzMTv2avNI3M2Hn8bLKrvTwkdE7nirG0SQFCMyv07tXf2W+PXyxOHiyODqYRoQ
	1g2aJlv9mKc9sVQAFuHXFwMXmoqjJIjdu1gdT2+NXrSqKHat+1SQH/CouzBCmT24
	5GHFIlCu0jOrR74Mv8R0yyPj3I/TzAoh3pn0lLPFT7W7Uvx+1FWx3Tuwkar+PYT3
	oyXBSmAsHWp6preQIdp/RUwrazVYYnWapZHDgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739898337; x=
	1739984737; bh=MREDDKhkSsDOa7xmYAOWCQtQ93NI2ABeBhuwuLH+9i8=; b=a
	OX2XuJuy7AU1JTyRJDZeDn5VVBjZijhfdgNhIdKGGYg+oHkzzJiLjSPEoHYXJlxz
	nNo6W+4u3F2hqcuxduwaHVF57B8xBSqEuFy1OwGdWzkWF7mwJ6aWJSU7kuO3XOpK
	mhcD9BXx4fA1DTDfDA6pRD32m3GFLb4rVTRB5Ai0D0RG+5eVtWE/uGwWgs6yGGWS
	Ft4eJj36Fze+smSYCKhM96nIe72gu9z8VwcuYyEm7Ahq5Ei5TkR2Wts4/3hgUwK/
	0yKxrGYodUmvVY0Pr804wCv1/V0bH9bYlAxzUB/15IxwxPOJOqvc3BFcEaq06WW2
	1OhStutsX5Sa/Y2ajakiA==
X-ME-Sender: <xms:4L20Z4xHOTR9y6Z7mbqODgvrCmocCuDSyYC2Yl5CVcQhwRg8tlwMJA>
    <xme:4L20Z8RasVdXpzQAVHU-bufABKTKtdTYKesP3L_Ylkv2Lhc-4phYu5fuEq3ICsD0s
    MPtZAcpPr98MZoBPoc>
X-ME-Received: <xmr:4L20Z6UVIEoT_gFfVOiBVe4MAtM75qQmGJCux7UbTM1qeNOrUjQ6oDpaEH2HtPSRsQ9mOTt8yCLGKRLU7JXBJp41QDmrrsgopQG-RRtfhKA2r3FWEcMNaoDLbEiRkyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepufhvvghnucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrd
    guvghvqeenucggtffrrghtthgvrhhnpeegieehffethffhffefhfehkeevleevieetfeeg
    keehhfeifffgheehieejheeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghrtghp
    thhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtggrnhesmh
    grrhgtrghnrdhsthdprhgtphhtthhopegrlhihshhsrgesrhhoshgvnhiifigvihhgrdhi
    ohdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    igsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgt
    phhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopehjsehjrghnnh
    gruhdrnhgvthdprhgtphhtthhopehlihhnrgesrghsrghhihhlihhnrgdrnhgvthdprhgt
    phhtthhopehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:4L20Z2jhGrJbzpEu8biPVN8bgJto24D0dFlv0d7hnUADVYnhlgzOTg>
    <xmx:4L20Z6AtGTTMkKx1gSRK9H0EVM2i50U9b1tM6xSQLIA1TXQ0agZAhA>
    <xmx:4L20Z3LJHB4EzDIH6skSaGmDPahUZI-6XnzJv8hGO5k8xoD91NVRJQ>
    <xmx:4L20ZxDD87IY1A0dBxrRxUQsENE_D5BGH3U-fGE9A5AAPb8BWXbzkQ>
    <xmx:4b20Z2yZG3TYCd8WlavFiZ7DKrHm5gNPwRAlXc4nDRwmoeMU4OIy1pJs>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 12:05:34 -0500 (EST)
From: Sven Peter <sven@svenpeter.dev>
To: Hector Martin <marcan@marcan.st>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Janne Grunau <j@jannau.net>,
	Asahi Lina <lina@asahilina.net>
Cc: Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: apple: rtkit: Pass the crashlog to the crashed() callback
Date: Tue, 18 Feb 2025 18:05:28 +0100
Message-Id: <173989828121.49947.17671473399449752322.b4-ty@svenpeter.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250202-rtkit-crashdump-v1-1-9d38615b4e12@asahilina.net>
References: <20250202-rtkit-crashdump-v1-1-9d38615b4e12@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_090538_420345_91EDAF9C 
X-CRM114-Status: UNSURE (   7.86  )
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


On Sun, 02 Feb 2025 22:48:47 +0900, Asahi Lina wrote:
> Client drivers might want a copy of the crashlog to stash into a
> devcoredump blob. Since device memory management can be very variable,
> the actual devcoredump implementation is left to client drivers. Pass
> the raw crashlog buffer to the client callback so it can use it if
> desired.
> 
> 
> [...]

Applied, thanks!

[1/1] soc: apple: rtkit: Pass the crashlog to the crashed() callback
      commit: bf8b4e49777d944f84cf7d47360fe80dd3f69d96

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>

