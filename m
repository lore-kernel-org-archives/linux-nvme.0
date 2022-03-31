Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B487C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Mar 2022 21:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dwiDsf+zvdH7oRjbZrvdnL3TUrOGM2biKjLq4Z3n0to=; b=s0zaqeo7mNt/uj/+azB0rlUsI9
	RdxvQPZMf0Pr6s/tpdTfsAd0Da9KWJ0+33yIjZMm8Q0y7NOFsQmAHIiO9s3cWKNQdrabiwsVpSbxm
	laZ0qGs2GwI6MYorZ/W+YWAwtEb6jO6BVY+6b0E+KdxpkeXEgJ+PYKz26qYsR1oQWlWQIF5mWFfWo
	OKXpmQnrmHS5IUzEdLJGHAIFxh3e7yreSvW3Enu2FKqXZSwu7JV1yOEYH/O8Vw6eMZQ1G4zQmVuhb
	fydr1+TdPAwl9GOfstTR2o7eDbPdPXwdi4NrYYL+j3CQKbZxVqWth49SD/clhrG99n4S/X8ltUrcg
	k9jnm/Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1na2cS-003kaT-4q; Thu, 31 Mar 2022 21:46:16 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1na2cK-003kXL-B3
 for linux-nvme@lists.infradead.org; Thu, 31 Mar 2022 21:46:10 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VKVP6J032352; 
 Thu, 31 Mar 2022 21:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=dwiDsf+zvdH7oRjbZrvdnL3TUrOGM2biKjLq4Z3n0to=;
 b=BTr75ZVpMNUo8Wvs2EsiTCTZf86INcUFhHvgjte+JtRd/khY6pYvVHpEBVLH3XdNbr8y
 TN+9tHjPTJSzYq67924uT1L9USiipsuYOEy+gBT5efdl8XmdDyfxCp5KjiuTXfoEgN1+
 5Dy13bXsqC7GaJo3C969yhZKrAcNuvQrciAg4BDUbXd+B/NOExVMKQtKHJfoX/Avi/VB
 7gZB1Vp4OXnpp1hXGY3Rskz/Fo2EDRjd2LrOg230gI/ZSNKwj8BemF5P70p3d8SuiZZN
 VrudY7Uo3mbRFNO5HGSqRsfPzEovuYhSGykfex/uqBx+otssHNbIfd8SACMCpdKoQSUH Aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctwtsx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Mar 2022 21:45:58 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 22VLfLtG013724; Thu, 31 Mar 2022 21:45:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3f1s95cux9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Mar 2022 21:45:58 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22VLjvTi025801;
 Thu, 31 Mar 2022 21:45:57 GMT
Received: from dhcp-10-65-129-122.vpn.oracle.com
 (dhcp-10-65-129-122.vpn.oracle.com [10.65.129.122])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3f1s95cuwy-1; Thu, 31 Mar 2022 21:45:57 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: alan.adamson@oracle.com, linux-nvme@lists.infradead.org, osandov@fb.com
Subject: Issues running nvme-tcp/rdma passthru blktests
Date: Thu, 31 Mar 2022 14:45:25 -0700
Message-Id: <20220331214526.95529-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OY9R3DFYrKbNPG64zwoMNfwPmmh_fpkK
X-Proofpoint-GUID: OY9R3DFYrKbNPG64zwoMNfwPmmh_fpkK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220331_144608_416841_692593AC 
X-CRM114-Status: UNSURE (   9.56  )
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

When executing blktest nvme tests with tcp and rdma, and with 
CONFIG_NVME_TARGET_PASSTHRU enabled, tests nvme/034-037 did not
complete.

This was because the nvme/rc helper for setting up passthru targets
hardcoded trtype to "loop" which resulted in the nvme connect to
fail.

The following patch resolves this.

Alan


