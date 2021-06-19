Return-Path: <SRS0=NYfD=LN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A2DC2B9F4
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Jun 2021 07:43:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97165611AC
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Jun 2021 07:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97165611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=qq.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Subject:Cc:To:From:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RvnKpkmfvQ8lEkRbBJXHLbhY3hHq4gyl5Rjed2pPVv0=; b=ZVR0hKAbhMoN35
	6fEEn33NLSRP8k+diZsez5uN0wuorDQ+5pADXoaOC2NrhxozDoARyAjVttWkoGM401SC9EuEdLfQ+
	ktLBhnvI/OiAKwuOS6Dw94HPLvS78tVy0O3baN7/ty1XUCmmYqPwKKl8FYV1/DJyjSW4FqrT9TkRU
	OvGxVKeDpM6wzBxdzGE/cBlOoJfMoY06LJjVO5EWPuEr2ZuISO0ZlyQe+i6QrkvAtVR5WVHOCU2U/
	D+PPtMv4nM4469Ix/xprSWlpigfNhCgK9vEYyR+YfjTAwmnZUg0E1Vuk8TcUYOGli0+Wv5TKEH+W4
	nhn+2ispJB0hO8FzQ0IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1luVcu-00GbKe-GH; Sat, 19 Jun 2021 07:42:48 +0000
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1luVcp-00GbIu-9L
 for linux-nvme@lists.infradead.org; Sat, 19 Jun 2021 07:42:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1624088548; bh=I1KDk3LdbzC49kOVBelzEAqUaV01/ki5LLXc4ElHiOo=;
 h=From:To:Cc:Subject:Date;
 b=x0OiFE8mg/mSPwvDc/BGbuTY6mWlS4gJMTWgzKZ3DE56agPcOPzqiqtnUv9KWy8rV
 +1kprgiFsiO30dmysqVqjiKd2MMd29qyXhtXmfHS0SMOCSGhqUlFLCVMItkXvC25TP
 SND2ZL1Gc5LZ6KuxIzCsm2w+Lu1DG3cGwVz0U8xM=
Received: from localhost.localdomain ([101.86.6.66])
 by newxmesmtplogicsvrszc9.qq.com (NewEsmtp) with SMTP
 id A9588A48; Sat, 19 Jun 2021 15:42:21 +0800
X-QQ-mid: xmsmtpt1624088541t2o039bm3
Message-ID: <tencent_B28F4F86583B12ADE15402FA0EBA8CE87806@qq.com>
X-QQ-XMAILINFO: OUyBsK7uGFiXYYUXT3LeUdq9lFsqNKOORiDTmMfS+btDycMfAZ/RK46V1qMLJv
 pkf4d2hTTQVSfLwCu5AlVZk1C6pwvRevU0BEMjfpJBLRhSf+V/WkyPFDmGRDqDy6fKkByS9lidPm
 vKnHl7OEOwyOx4ne1+eEgmObDx8ZMxLp9FxGCvscPIXnNVdyXuc8a/0MbNws0xLku8uXb5k1Q/6m
 RFZ4hZAHDG0/WL8CP1GhEqGLzDaAcaiPCq0baKaic7Kr1Ax15e1ESqCXnDAeUqUq1WwAbqOEme13
 Htl/q/qU6zTfYlfV0+VTDdU19wNARcDNv/fgbj2QGDvjExUEE/A6eJ9QestP67O/M8x/XR60FPXo
 Keb5tDzzmofPexeuqd6gFUa4J6n5LlXIFHT2N/2GXk6LYpYRmD+Jj4hBHOyifCAcGMs1OBNUUocz
 AiYz6ybef1lhAILV3av58qtydO1ZjgUn2WnHoCUtCxOBJUzcCMFNTV6AD2lxqlCyb5zGqV+vq8Ph
 tn5N+xyeFhBJ0EDiusOOEwTKP4gZC3b8rWndnz6xAB3/ho+gw9O5SL1X7uBo/dt1EtDfs2huMp07
 BzNxFg8CKIdsmmT/o95Y1xntUqsmlSfjZvhDmUFuaQdL3m4rWW5+dfthCrx6dXf/EI1jCUy0i9ox
 j2+Vb+iCpYk378Uwfwv1evcJUqJeDgxhd7FEp/x1DFUrPV+MnQ+8Wy2uLBExAH+eDDZLbob87Y90
 ADKUXammW49wICmTo3LbON4XXH3tltKIWRiANoCK75iX7+ongfyobio8jqymeaQnDwCU+yXvhiI2
 ESqTK7tfBKGrelKPZxO8C+N2+Spm6qEbcis2KMm6/i00WqGCiH32GXzty9vgDm+OYMu+z0LWNo4L
 6uT1x3lIeh
From: "Ming.Li" <mingli199x@qq.com>
To: axboe@fb.com,
	linux-nvme@lists.infradead.org
Cc: mingli199x@qq.com
Subject: [PATCH] remove all blanks in front of goto label
Date: Sat, 19 Jun 2021 15:40:18 +0800
X-OQ-MSGID: <20210619074018.22666-1-mingli199x@qq.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210619_004244_163864_DFE2CDD0 
X-CRM114-Status: UNSURE (   8.96  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

There is a format style mistake. Some blanks in front of goto label.

Signed-off-by: Ming.Li <mingli199x@qq.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc..bf3deda1561e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2780,7 +2780,7 @@ static int nvme_dev_map(struct nvme_dev *dev)
 		goto release;
 
 	return 0;
-  release:
+release:
 	pci_release_mem_regions(pdev);
 	return -ENODEV;
 }
-- 
2.24.3 (Apple Git-128)


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
