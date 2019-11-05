Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D58CA9ED0
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 06:15:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC011206BA
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 06:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Itobo0h5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tg6feTvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC011206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bnz2EQKoY+Glx8JelMNMnKdLRFv2sHenoqaZvuxYmhk=; b=Ito
	bo0h5h/XfI6XGAeAe+gO7jWVpSBTo56yNmn75aLwe9t/jXDRdw6YHgbBD5BdS8XTlz6ui3We9TlES
	itp0mVMs7Ey2yM/yws/FPjFb+v96UueIRvN83r9EV8wLV/NN63RlGeb7wv3cXFBg3G5FoXSSrhYzA
	IaprX0uhoR/SLzKhGXEv1tJoq8kmqJIgpdHGjUp1lF9673tLy15sZzK1I7P/VM9Yi75wczIV4VfSH
	NnWzMzWLkMKQed9tdq98+25dogj0GO2M1r79deEhGbkYRmDagthEeYtBgxmH1wmoCAqHsQTvWIVnw
	/IQhxUP+d4r/M8tKs0ozT+A7fC53p6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRs87-00010A-3X; Tue, 05 Nov 2019 06:15:51 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRs80-0000z9-M6
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 06:15:47 +0000
Received: by mail-pl1-x644.google.com with SMTP id y24so8830098plr.12
 for <linux-nvme@lists.infradead.org>; Mon, 04 Nov 2019 22:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=aa3OA21J9JwZAlnC/lO7pQLgsSx0S9mISTEt24LrqMA=;
 b=tg6feTvsWhoUI6T3VhdPE7fPEDlz70rjIHNogtukLJgyq0FbR8IRr/wW7doMjp2B6f
 /6Rrj0kusQT2+oSBaXxAUTN/7XIksAKLaLCm4wlgxmHSurV1DUfXXcYkyx9oilShye0X
 T2KzM5WFY9461Ikl0Z9mHQkylCaLIGAlVKUAkeaMe4XDO8cfZu64IWTctqZEJLUahTZQ
 BAproY6ehLLKfo6XAcUaON3o4/meN3F6GmXYP8LjsRERo+sqnSUvwniIMRdZdMp6EuCb
 30JP/lV3quBsaUPs88fBAHMgsE0IgDFrMB/yoArneQUGvJ7/m2hyqdbKzt3nrwJuUjd6
 BI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=aa3OA21J9JwZAlnC/lO7pQLgsSx0S9mISTEt24LrqMA=;
 b=Ck9EgSR8BrS3NO9i0J2bX/PL7n4DDcPozvHcRDnxmEn3+bLexm3l9erB02d267yyJ2
 x/+pURwhun6JLi+scfDwzz1E6UeGpQpBQdZuOHr/5ZMWFK+O5509IBZdUB+7Sr8EBWYh
 oD5OIFUyh5em8vrSqjLDhpq7DHCr96wzdOshh1OWbigDyo18Uk6bcmtEMICNUavm7FLJ
 71exq9B4MTNzWRpFtaOkwSic28lFBu2NSIGIwmENm0/zdo4hpeDvr8wBeXRGSfyNJJxw
 sXUx3CgBzzbKsIBoSlEhoCbIqtdlpJeR4N2MkvHGkF5qB310Evm7FgulKDA5ulW0brhZ
 U7sw==
X-Gm-Message-State: APjAAAWoA9HeuZ6JyblXqrwjgXcf3NfMEIpxKffwqeapSzo6cJsqliPz
 Ky96PNoh+tFsge/Ku9LCjZl4Rj588vC3Gw==
X-Google-Smtp-Source: APXvYqycIJAQSd+NQR7rAmS9mG6bFN3PSXYm7zzBy9Xt8XqurYVXHrpgLG1q+jsvmUWwjpYS5q6+RA==
X-Received: by 2002:a17:902:d917:: with SMTP id
 c23mr23237443plz.199.1572934542419; 
 Mon, 04 Nov 2019 22:15:42 -0800 (PST)
Received: from localhost.localdomain (c-73-48-141-28.hsd1.ca.comcast.net.
 [73.48.141.28])
 by smtp.googlemail.com with ESMTPSA id c12sm21419613pfp.67.2019.11.04.22.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 22:15:41 -0800 (PST)
From: Charles Machalow <csm10495@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: change nvme_passthru_cmd64 to explicitly mark rsvd
Date: Mon,  4 Nov 2019 22:15:10 -0800
Message-Id: <20191105061510.22233-1-csm10495@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191104_221546_480131_C7EA24B3 
X-CRM114-Status: GOOD (  10.17  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, csm10495@gmail.com,
 linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 marta.rybczynska@kalray.eu, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Changing nvme_passthru_cmd64 to add a field: rsvd2. This field is an explicit
marker for the padding space added on certain platforms as a result of the
enlargement of the result field from 32 bit to 64 bits in size.
---
 include/uapi/linux/nvme_ioctl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index e168dc59e..d99b5a772 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -63,6 +63,7 @@ struct nvme_passthru_cmd64 {
 	__u32	cdw14;
 	__u32	cdw15;
 	__u32	timeout_ms;
+	__u32   rsvd2;
 	__u64	result;
 };
 
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
