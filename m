Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4B810A62EC
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2026 14:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RqVqDCoVZ3UVUvBjXL8ALS4wpv/ZTlX+ITsrwTuD52U=; b=H5isH6YcBNOlJaRLUc0OvZII3l
	GQADrJxqW7r+Gno+5tl3v8QXpmcK/ks0dio/h393Rbuw9/b2uzn564oVR2fS8gLmcHUiJ8TfNPsJI
	+SbdvwQSOCWnta5I+0wmwBR0Z5m77YYMUT5EH68HoBQzYKfEO24izo4JpCezAAhsR+DdJUxCsrA/O
	acyunm9m+SOWbjq+4I4h7JB9W5kCPsXsA4w49nfVoMxwublwur8Ihsr094Dwb7yryknnr9166gu+c
	SWcJ796dHp67GAuZWtaycxdLpOh0NX25AoQClI8nkTM8Tij84iAxCvmMlflWQtKUYV6bTA7Ld1Wt1
	KCGikFAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5lhc-00000005e26-1I2M;
	Thu, 26 Mar 2026 14:28:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5lhZ-00000005e0p-3rGP;
	Thu, 26 Mar 2026 14:28:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CBAAB441EC;
	Thu, 26 Mar 2026 14:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFCBC116C6;
	Thu, 26 Mar 2026 14:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774535328;
	bh=9qmbprKUMbqPiWVN+/bZb7MOWCpDyMug8liR6R/yc+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VCEyCUb4Sbe57pTItGWDihVwE3k84WC8IH+5WEC7oSc5qBrt9ukC6VkCwE5EyJHHp
	 Rc3K1H4UaO4J24Qa1z5epnSPdtb+OKCRgphqP4KPPbYWZxkHUfcWPr9/pj3Q/iHrDv
	 tfqYeUI5VuZv3xmcsWa8mXkGDrePxWlIdxMcvVwtXFe1Bz89xBqT2mgOE1W4d2ULgB
	 xn/rCjUrG0wjZroIrAesNjXwfyvfR7HdXRTnMMEPcOYdRtnfaLGUD/Cp+e1QhSPRtH
	 2YaaDiWIydJe90eiAi+QqorJqXCLNqFmg5FNbvfA8SRNROCdI2/A+/IE854RFxv5Va
	 dTxYw77Ec+9jQ==
Date: Thu, 26 Mar 2026 08:28:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: =?utf-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
Cc: "hch@lst.de" <hch@lst.de>, Justin Tee <justintee8345@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sven@kernel.org" <sven@kernel.org>, "j@jannau.net" <j@jannau.net>,
	"neal@gompa.dev" <neal@gompa.dev>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"justin.tee@broadcom.com" <justin.tee@broadcom.com>,
	"nareshgottumukkala83@gmail.com" <nareshgottumukkala83@gmail.com>,
	"paul.ely@broadcom.com" <paul.ely@broadcom.com>,
	James Smart <james.smart@broadcom.com>,
	"kch@nvidia.com" <kch@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?7J207J2A7IiY?= <euns212.lee@samsung.com>,
	=?utf-8?B?7Lm47LCs?= <joshi.k@samsung.com>
Subject: Re: [PATCH v5] nvme: Skip trace complete_rq on host path error
Message-ID: <acVCnozG1WKPkq1L@kbusch-mbp>
References: <20260326061443.GA23850@lst.de>
 <acQxjZMOqj74yIJf@kbusch-mbp>
 <20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p4>
 <945a3e98-ee75-453c-ae80-f3c9e3e57e58@gmail.com>
 <20260325063333epcms2p60954532c1b65a1665bad6dcdcfd7d62c@epcms2p6>
 <CABPRKS8-x6Tfr90inpz1fR0=8a5HD=mkujtfLJ1h9ikEUjTvxg@mail.gmail.com>
 <20260326014429epcms2p135ffd3c2b2fface6423d045e9614c262@epcms2p1>
 <CGME20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p5>
 <20260326065152epcms2p51a18d3bbecb6eb6dc2ddba09651e5152@epcms2p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326065152epcms2p51a18d3bbecb6eb6dc2ddba09651e5152@epcms2p5>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260326_072850_015097_22DCD552 
X-CRM114-Status: GOOD (  12.76  )
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

On Thu, Mar 26, 2026 at 03:51:52PM +0900, 전민식 wrote:
>  {
>  	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
>  
> -	trace_nvme_complete_rq(req);
> +	/*
> +	 * The idea for these trace events was to match up commands
> +	 * dispatched to hardware with the hardware's posted response.
> +	 * So skip tracing for undispatched commands.
> +	 */
> +	if (nvme_req(req)->status != NVME_SC_HOST_PATH_ERROR)
> +		trace_nvme_complete_rq(req);
> +

Well, how do we know a controller doesnn't actually return that status
code? I was just suggesting to skip the trace for the condition we never
dispatched the command. An added bonus is we don't need a mostly
unnecessary 'if' check on every IO.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5ebcaa2f859c..0dcccdca2965e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -454,11 +454,10 @@ void nvme_end_req(struct request *req)
 	blk_mq_end_request(req, status);
 }
 
-void nvme_complete_rq(struct request *req)
+static void __nvme_complete_rq(struct request *req)
 {
 	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
 
-	trace_nvme_complete_rq(req);
 	nvme_cleanup_cmd(req);
 
 	/*
@@ -493,6 +492,12 @@ void nvme_complete_rq(struct request *req)
 		return;
 	}
 }
+
+void nvme_complete_rq(struct request *req)
+{
+	trace_nvme_complete_rq(req);
+	__nvme_complete_rq(req);
+}
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
 void nvme_complete_batch_req(struct request *req)
@@ -513,7 +518,7 @@ blk_status_t nvme_host_path_error(struct request *req)
 {
 	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
 	blk_mq_set_request_complete(req);
-	nvme_complete_rq(req);
+	__nvme_complete_rq(req);
 	return BLK_STS_OK;
 }
 EXPORT_SYMBOL_GPL(nvme_host_path_error);
--

