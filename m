Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14581C77B6E
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 06:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6f8fFLgiqlaPGs+9DZG/t2Z/JNFe7fonZ+RZmkWgs74=; b=KsjcBAHS7R9Tw5SWtKkqjdrQxX
	JvIc/ek7cx/fYM8e3+2/2Z/ZlZRYJOoup7OmQwfywN+CKGXvQkodfSmBVGY4IOviIaQtbFG/CU928
	8PmXLQrsVGBCI5H6qXcaQRbQs0TWCl9Ez2QA2O/xt80k/oDggwwDYlRWHfemgIWcm6tILW6ZOBEQJ
	xKY7GPB0tgonxp369kCIAcMQw7vI7e4pU/4qNoqThZmLVBP9yaDVXHLRYAOCV9N735rd1Ku5nUrpM
	OxOhIcxx63lRGnoKSw9AqDhpg8MSLTa9K6O7k4wVKnKuoZ6DMXhHgqnq+Df9v3CZSSiPc5toxSwXk
	52obj2og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmUHZ-00215a-2n;
	Wed, 12 Apr 2023 06:48:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmUHW-002144-0K
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 06:48:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E75E568AA6; Wed, 12 Apr 2023 08:48:31 +0200 (CEST)
Date: Wed, 12 Apr 2023 08:48:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] nvme: host: hwmon: constify pointers to
 hwmon_channel_info
Message-ID: <20230412064831.GA20380@lst.de>
References: <20230407145845.79557-1-krzysztof.kozlowski@linaro.org> <20230411060900.GD18527@lst.de> <20230411061012.GA18624@lst.de> <0d4d27e6-02e0-09e3-8e99-18b40880961c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d4d27e6-02e0-09e3-8e99-18b40880961c@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_234838_282120_8352A601 
X-CRM114-Status: GOOD (  18.48  )
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

On Tue, Apr 11, 2023 at 08:11:41AM +0200, Krzysztof Kozlowski wrote:
> The dependency was described in the patch. Guenter also provided
> a stable branch with the dependency:

Ok.  See below for the version with the whitespace and Subject fix I'd like
to see.  With that:

Acked-by: Christoph Hellwig <hch@lst.de>

---
From 882410442b1bb5730f3eec29d8dc9ccda5e92cdb Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 7 Apr 2023 16:58:45 +0200
Subject: nvme-hwmon: constify pointers to hwmon_channel_info

Statically allocated array of pointed to hwmon_channel_info can be made
const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/nvme/host/hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 9e6e56c20ec993..6aa153f3178a60 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -185,7 +185,7 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 	return 0;
 }
 
-static const struct hwmon_channel_info *nvme_hwmon_info[] = {
+static const struct hwmon_channel_info *const nvme_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
-- 
2.39.2


