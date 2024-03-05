Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E65AC54E41
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 13:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IlVgX44R65PkQMZQ9beF+VlRKBmaGhNPco+GYuCp2vI=; b=d3PptJl9UzBCwS
	XmzE+uOA7cqOO2krjyABjta4ozlzdHG7byEdpBmF4fBxM81L+1S0KmeSRrs8ajH4PommlhfeElhgF
	C7ToQTkMed6Z4HzSElxzC2+n+SE7Eg02lDneYTRMw3qJDV4fCxjlMg0km+E/i6BCV0gtU/jfcIHsi
	xJOjsqf/z8p7ulzDtfDthkFywObtGB1fKgfI4CmxKv9TDW/1N320RY+Xo+w1I40f7xyp7GsxQVpvJ
	mPWfiNCX+29ROpkOHrNOlaHjykaXBY6lod5Fh/GC/KhQv/xp2YMVadAHtX9GRmaujq1x8QQAs4vkg
	X2tAPzuNiQR6x4UgrNFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhUeT-0000000DhTo-14pX;
	Tue, 05 Mar 2024 13:16:13 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhUeP-0000000DhSg-2vLu
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 13:16:11 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6e5c81ccfb9so2835764b3a.3
        for <linux-nvme@lists.infradead.org>; Tue, 05 Mar 2024 05:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709644567; x=1710249367;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IlVgX44R65PkQMZQ9beF+VlRKBmaGhNPco+GYuCp2vI=;
        b=dxvwn7tL5YJuEOuLmzcj+34AOP2OTUA7BOjsg6fklcNdS5YjP8RVG/k6hRj2YoEmea
         BHys5VAPzxSuhdUgeLyvVyIwrf+upaWedUWUI+YRJPo80y+Fs0MwcTlQa/0ZcSQQ5cbW
         PpgKmOU82T/+igb328njvmtQ7hfIFpQeXGEIMzENOMKCrdRvk4ODSx896/m1ZGsOz4lb
         cEY6g7kCw7/TA3YMa1RhD/wdE9IBHptB5AhxBEGHKDR8KsHWwN57+S+LSg9VPrBMJJQp
         /nFMtosAk2peObqEs6HTmNKxPmw2AxuISWFHYDBmjRblwrSje1XXb1hGSH0uYrCeUZvh
         Pmiw==
X-Gm-Message-State: AOJu0YzVCtYrOmhWCulp0Q8xhKoV/8p0tOSLEQY5Llb8xYWxAPDzXcYp
	qc20AWr+53dm5kb2jgNPDAkko6v44+HW1pwmhA+k7t3RXTXkvxB0
X-Google-Smtp-Source: AGHT+IEYoKkZLHyXa2G+6BzBxGBU+sy/JkPIG76Xwt7x3+dLYKcpYdRDHPgMRFY4V7tWdPsVDWRSkA==
X-Received: by 2002:a05:6a00:238f:b0:6e6:27d5:4182 with SMTP id f15-20020a056a00238f00b006e627d54182mr5235576pfc.9.1709644567518;
        Tue, 05 Mar 2024 05:16:07 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id x7-20020a626307000000b006e624f5c866sm3504674pfb.145.2024.03.05.05.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:16:07 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709644565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IlVgX44R65PkQMZQ9beF+VlRKBmaGhNPco+GYuCp2vI=;
	b=YNVtc2UtO7pVpo3uW0AxjiN0Alhbu3UO0QMI/Gv3xagVMJdPVSPO19PY2MQfTbvUdM4fEO
	+glmj5naNaI7XrvtTX6SAeZVjCQyyPXekYm59ujGt8DfEaurumImSa6j8gbogeSxwwsnWA
	UCOKKW49gv6fIbeqZvdxwI9JtYQ35Kp7xrCnUFjBwOuSonZaGlWtHjhQmvG2bCCRu4XYA2
	cb6b1Hgcth29N2MQ9PCY+IcieSqJwMpnzSxCD/1vUXfSSoPDPgLYghCnTAS0nbj0gcy+1o
	6txeqFTWgl9+fLiEv6Y0lBJBYaOq75f7zW4U+HHyphLayw/zKE6WF2oht2+UGg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/3] nvme: constify struct class usage
Date: Tue, 05 Mar 2024 10:15:55 -0300
Message-Id: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAsb52UC/x3MQQqAIBBA0avErBPUCqKrRIRNYw2UhUMRhHdPW
 r7F/y8IRSaBrngh0s3CR8gwZQG4urCQ4jkbrLa1rnSjcHMiI27kwnWqcO+k0BhP84TV1FrI4Rn
 J8/NP+yGlDzF/c0tkAAAA
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=8XNq4Q5n6PPg3j924WkY2krkAvgW/p/prb34aDD/L0g=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5xsR+QBdfjwxESwx+GwAh/Mhmi9UlsDoNCQyv
 iscKwq6RfSJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecbEQAKCRDJC4p8Y4ZY
 phgfD/0TpHpD3XBqsjJO0k5Vtvt/kA3emstwrh+ablwvZDNxMk25pHr+hqfZl3YJhbE9B5Yu1l1
 KjxEScP/7EAGaPiDDcemeD0rLSUnnVKRPeBd0bRngWOwCCL6fdW6jgM13dnsNUhkY/ZU34SjVdH
 yKofPj1Qzlp9RES9KFqGqeyFIGL90V9buRT9iLdEYp5904LwM95CwwAEg+91wIV522q19pTpyW/
 uSBA5zEikf9ZaJ/mI9WXjdUUPc1gRRwtiEMRmTNd63rfTCHqbymzcEiPAJEcaQG6QB78uPssEGN
 9VcaigIBCa9pQXtc1Tgn9Wh3UiRBDdHWXGj/gf1eTy5h5EVtXZw0+p5MX6HjgQgWyNUncVbdDJ/
 kMjv5c9YgrSA845rxLiXBdUCDFYhg4NFk12q0ohu1JUQaHa/hMXywLL5SBODnkFJV0qTMUIKQSM
 BKEAbQ1vPgE051XGtEZBRyD8INPoNPwhSBfjZ0xkPSHgjvBxB5ubERtHzN/s7Xw9O3RZCiKRdFH
 Kf5bqrbwM8W35G1rL4+tfJLx0tcrhq/Sz7VZ3fk7waXICikdvSOwtwqZ0YvbtsbPSTS2IMOZiN2
 pgKGkNNpW3Xn/fE03Hoy/zPnWTdMb2VbuQhdsEpInVQ89rP5LHE7a7fQKPNUx3iAcnP04XuqSQj
 5i6aCqUw5JtGe2w==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_051609_895002_D3A0549F 
X-CRM114-Status: UNSURE (   8.75  )
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

This is a simple and straight forward cleanup series that aims to make the
class structures in nvme constant. This has been possible since 2023 [1].

[1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Ricardo B. Marliere (3):
      nvme: core: constify struct class usage
      nvme: fabrics: make nvmf_class constant
      nvme: fcloop: make fcloop_class constant

 drivers/nvme/host/core.c     | 53 +++++++++++++++++++++++---------------------
 drivers/nvme/host/fabrics.c  | 20 +++++++++--------
 drivers/nvme/target/fcloop.c | 17 +++++++-------
 3 files changed, 48 insertions(+), 42 deletions(-)
---
base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66
change-id: 20240305-class_cleanup-nvme-c11fedbc3b82

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


