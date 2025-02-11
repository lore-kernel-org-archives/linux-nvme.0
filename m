Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB367C0219B
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2025 18:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=idU4M1eBTyORkzLLKsL5gMIZbBkj9wGw9TueyObtiRQ=; b=l5HC0i32s8iLdjhZbjZ2yU761l
	JAnLT3xlS9MQcQwNEWLMnHV5iXXVWxvKHUEVCaUpYlUAOz1OxtaIiDqBq2KoVmm9/AdneqGwBAxvr
	H8XPswrliKVVvEHNPAIZk//4AgHYGCXKCrVATJBtGTCHwhOlmx6um4k5QY1ZJ2szQ5o9RvfOfR0+Q
	MdW3kQ/KBkQiTmoYbwCiE2Yu+RmqYs0KRNsL7WqmfrwHgoxLDqFnL6ixtrDzePZWJ5gwPlMGnj3uW
	LVRW6OoFLQ9mFcsIap8ddg7xC9ECRqAxCBbMotQvSZ89jT3HHDSJZlzKSfrb97+nIL5sssc+Cb3Ui
	74eyfVHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thvBj-00000004sZx-15J7;
	Tue, 11 Feb 2025 18:40:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thuxe-00000004q5q-1nIh;
	Tue, 11 Feb 2025 18:26:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=idU4M1eBTyORkzLLKsL5gMIZbBkj9wGw9TueyObtiRQ=; b=hfQgGmMp+udMpnacQklpUs0/9S
	JUh0Ltxu8jZXsr/lla04/YR5J07fd3jK3IATe5ZhyW4JWUh4djgBP9RN9un+jw0UQkiS5EdwjendU
	BOki+zXOjQhT2FvFep1fdRUz5zN8qDzC+qo8O6D1qClBVECIyqAchdR3PmjX3+T2pxiM8A2hhNUBW
	FsUZiDZEvJfQaldlTAL6dgMDGChArA7jR1os3asM+p3/aRcwgPwMNltUUJp77Kx64S+LL7vBl75BP
	eUPjPx7z4io91rZcNWzaGuQL06ehmzUAy+SUZoMcE65O1ALL1LgIYwS+E6yB63VbkKTuNwUfLejLT
	7V11U2aw==;
Received: from out-175.mta0.migadu.com ([91.218.175.175])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thuxb-00000000g0L-2OPI;
	Tue, 11 Feb 2025 18:26:17 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739298365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idU4M1eBTyORkzLLKsL5gMIZbBkj9wGw9TueyObtiRQ=;
	b=q+ID/jn3SpGNrR3SUWLvrQ/iBKesO0BAR+scpPxJHyo9U/bLZNkvoR2wiqgrU+mdMJ59Na
	ZUmbuwm6PpcvJpQiobs9PpT+ICpa/ekPnGCRK4cZR1ZTM/cAWkGJtZM5/XDrY+xTv7067X
	p394CHAcjdF+ANORjQqm2ezYVyDNpDFeWjcdAB222DbzxUURiXEfNTN1R0wKqkK6Thitz0
	eAlSRpJgJFmlXOFLhIq1rdOE/ePv0ASsLZQJ0cQ/JkqXWXoB4BlH3HmbLgFYNw/BXiD9g1
	MIFYBBCpKuXtXfOxGpSpuEIocoAUvjIpgFZWaGHuaWleU7pCkeinxcGtGmmNxA==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Tue, 11 Feb 2025 13:25:58 -0500
Subject: [PATCH 2/3] apple-nvme: Release power domains when probe fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-nvme-fixes-v1-2-6958b3aa49fe@rosenzweig.io>
References: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io>
In-Reply-To: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Developer-Signature: v=1; a=openpgp-sha256; l=854; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=8vBQ/v44cM9RurlOEJqS9G0+SOpYh3VTVvP62muKOs8=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnq5Y3JoRTpZggfiWVdYcP0iyVHDJ//MLZ5GLPN
 83hIsPuBMeJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ6uWNwAKCRD+/lBaCvVY
 DUD4D/0Sx7sJnd8ickbkui6NuiZpuL2EOI7nalgwVj2PqptKMNPmymjt6QlI0ip1HudADNTfCHW
 dIyn21enlKeH2lViS94Gb+1EjYNnPGJp96OUvz7ub2LIeNG/SMwfbTSd9Gt1hBXI4CvRk36xk3g
 FQemoR5vedw+A4sgDRv1Q5j0x397vsGBcHvJcU/jRD6In3AUXAP7buEaUFYQ9ZB69JILR2oUk1/
 rc7vMmQLascmkAXlMR7OhCGbpLpR2o3F9FnUf6H6nJ7oi8QaGWe1o8LEd3m4qP5yEoOGzGEq4oK
 W6b02fzoeE793G73RvH07TZJpAzMxYCJO923p1hD3RSjmsdTmyjtubBKi5eYWPZRGezx+tm7nhm
 0ULV7N7OZPrk20ZkiFktC8QPl5Lwz/Jwm0qoYSW7XY9OXiWkprnvcinsP122X9KTXmsEaqOpoG2
 vxYCzsr5FK08P97nSpdRIX0vvPTSCrETIOmV7YH6VyCp/5atF80JB2ioeRLDOHLrJyJRqc0RkFi
 1J5237GfZdT1fZgLx5dQi+eha80Tqw9lm5P9ctCyfLA8ERvz/Yhh2Qct6wc2rqrTl5pIKt0oo/E
 Z68lO22qqvvp94ftRBHIIcbMMVj03htBaRcJnRFMYeAGlX3/Z9pmWQM5EYRG2H2BvP04jy1afFa
 sMW2SrdBa7ltplA==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250211_182615_760834_BA91EB37 
X-CRM114-Status: UNSURE (   8.80  )
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

From: Hector Martin <marcan@marcan.st>

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/nvme/host/apple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 5e1c01a67ee81a36faa3da2f86a3a24fefcdfd6f..a060f69558e76970bfba046cca5127243e8a51b7 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1528,6 +1528,7 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 
 	return anv;
 put_dev:
+	apple_nvme_detach_genpd(anv);
 	put_device(anv->dev);
 	return ERR_PTR(ret);
 }
@@ -1561,6 +1562,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
 	nvme_uninit_ctrl(&anv->ctrl);
 out_put_ctrl:
 	nvme_put_ctrl(&anv->ctrl);
+	apple_nvme_detach_genpd(anv);
 	return ret;
 }
 

-- 
2.48.1


