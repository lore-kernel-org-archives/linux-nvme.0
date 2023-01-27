Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE46C61D97
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jan 2023 16:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GMDvP74R1D9Dqpn08yM0tvniSSKvtvXb2SB2YAb+9m0=; b=VqexG9SW6CrOnvYjAZ0ulW2VmL
	COzezPnNoDWXYEprH5UqlNkfhyqwWbEKUOJuxM/S7wJCYYNWDniRIKSKK9spNIBo3X68/lARY+Fhn
	EZjLutjJKP7MKTOhAzj0u7lI/xhedsbhc0HMmsjkpUcSEr4Ytyj2oIzRjhmgfz0MQlusoKjmoNHHe
	XG0LjCF8ewFEE4Lc1TpGEbteQke/FrcYEW6Avexl9Y5OjxzmtVnJuNZ4ecRuruL+veh9spjjXKvyH
	ATWs7FfdWz2EhYQd2fy6Ny5ZWo2AtmayYCqr+n8MdBSDuT0Las9Wg1GE2qK6To4VcBJXBic6GUiav
	ie5a+dYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLS1n-00FqB1-Bh; Fri, 27 Jan 2023 16:56:39 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLS1g-00Fq9B-Qs
	for linux-nvme@lists.infradead.org; Fri, 27 Jan 2023 16:56:35 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30RApncU012493
	for <linux-nvme@lists.infradead.org>; Fri, 27 Jan 2023 08:56:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=GMDvP74R1D9Dqpn08yM0tvniSSKvtvXb2SB2YAb+9m0=;
 b=db9ysrLfHa4rLVdDNggQcHbxMvvBguPOhZZUMAT/NjSAQa2c9qjtxEc4bBwmZTPM5CTc
 74wbzYtSS8CRULqmFSUeFknZGsEnp3lEftOE7B5Wpz6ELw53949qdyZtsu9WvNFXa8z6
 wgbV63ev+XxBfbD1/3IQC8AzMhh2V93zfJTizEBqUFpkEv0VIyC4s0tz9vnjlD3yp8eD
 /VFqWZMMX9OmT++bRNgjnunxc+dATpnYi8bW+5XIoQVOuWOTwPQmYkqUzf3w8yn6bUzd
 vcTuhbB16JrCYWpydYWfeuY35RxUzybqBkGd2eZzwLMZtadYCRcMGPsnQ0SdX7RPlKXG Ng== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3nbw4a0fdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 27 Jan 2023 08:56:28 -0800
Received: from twshared26225.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 27 Jan 2023 08:56:27 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 5653AFF7BD28; Fri, 27 Jan 2023 08:56:21 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [RESEND PATCHv3 0/2] nvme effects handling updates
Date: Fri, 27 Jan 2023 08:56:18 -0800
Message-ID: <20230127165620.3487918-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0_5930ISf_LQqQd9xXynAsCaRspORJE5
X-Proofpoint-GUID: 0_5930ISf_LQqQd9xXynAsCaRspORJE5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_10,2023-01-27_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230127_085633_065030_2F318AE3 
X-CRM114-Status: GOOD (  11.34  )
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

From: Keith Busch <kbusch@kernel.org>

Resending due to errors in the previous email.

Version 3 fixes the memory leak from not including the default log page
in the tracked xarray.

I've included the Send Receive filtering patch in this series now since
it depends on the first patch.

This series also depends on nvme-6.2 branch that includes the recent
commit "nvme: fix passthrough csi check".

Keith Busch (2):
  nvme: always initialize known command effects
  nvme: mask CSE effects for security receive

 drivers/nvme/host/core.c | 101 ++++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 39 deletions(-)

--=20
2.30.2


