Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD143C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 16:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L7WT2PZP9lCaY2OiXLy2iEOGPpGUZCS/JZbi4PID7Dc=; b=TN1/IyCe3zUbVfwhjGXjpB8zAv
	IXDANLnA2ZiJAEqNQPeSyIJryIFzOgV9jz/CUdGNGzq2+FaOvSEKvOXsVNtqzOprYIg4GiP8kFQpy
	xqsgXrmGBb/CFAOlx3AyvmE/oG9DdwuA6oHHHdDC8UZbcTdebQKzfbhTebHMJWyiw+BYpYq3JuXQX
	EZ/AKMwEoIUhT6NXNnw6EbWtQoeQFk2vSUlbRtxVQy9XmCwdN4sSiim+h7a08TmjZ1Q4wofZZal9V
	rZyEJnIBVdvMTN8vWhUy/VB6IurjZGEK8YRbLuIuXYB1HMIcI5T6FirGLxCuNBxiTUrBuCOjlUZlt
	N+RGYwSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noSxg-0039Mf-47; Tue, 10 May 2022 16:43:48 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noSxJ-00394s-Dp
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 16:43:26 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AF0bhF024483;
 Tue, 10 May 2022 16:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=L7WT2PZP9lCaY2OiXLy2iEOGPpGUZCS/JZbi4PID7Dc=;
 b=M8bhntWCC6PDHsuYIlTZIUyuBrnj1bfVqGCi+F1ODHznsG3mg8reMk+38yEtnjV3Eubv
 TXvxXT89dpXdH2VW0Wh0/ryF4v/Zgb9cT+14zu8HK1MyNe5AXPdWWnSm4GP3fI4xo/yB
 jrJ5DwxTAt0a+t5dLDtSF/ualCsQd4I3SAWCbTQBy62NLKMywfWbohnAA5D8sv/u/cx8
 B6JhXHlSSpRZICCt28eDx7lA9rJEz8usgW185ElG7EjC/gm53+S6C3oeB9fOUWi50BI9
 cWirqiujAn1cZ/j3oRU2e72TT7glBYRP+94dQHPQ6fuS6ekpkQdkzHr7gh/e3ofqLvWl gA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfj2fd54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 May 2022 16:43:18 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24AGPdiB036801; Tue, 10 May 2022 16:43:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3fwf738sjs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 May 2022 16:43:17 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24AGhHnR030233;
 Tue, 10 May 2022 16:43:17 GMT
Received: from dhcp-10-39-195-127.vpn.oracle.com
 (dhcp-10-39-195-127.vpn.oracle.com [10.39.195.127])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3fwf738sj7-1; Tue, 10 May 2022 16:43:16 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: alan.adamson@oracle.com, linux-nvme@lists.infradead.org, osandov@fb.com
Subject: tests/nvme: add tests for error logging
Date: Tue, 10 May 2022 12:43:03 -0400
Message-Id: <20220510164304.86178-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gmfs7kvyFJEcD1PR6o1Rphby7qcF59GC
X-Proofpoint-GUID: gmfs7kvyFJEcD1PR6o1Rphby7qcF59GC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_094325_617627_2560539A 
X-CRM114-Status: GOOD (  12.63  )
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

Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
run with or without NVME_VERBOSE_ERRORS configured.

These test verify the functionality delivered by the follow:
        commit bd83fe6f2cd2 ("nvme: add verbose error logging")

V2 - Update from suggestions from shinichiro.kawasaki@wdc.com


Alan Adamson (1):
  tests/nvme: add tests for error logging

 tests/nvme/039     | 185 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |   7 ++
 2 files changed, 192 insertions(+)
 create mode 100755 tests/nvme/039
 create mode 100644 tests/nvme/039.out

-- 
2.27.0


