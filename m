Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD40AC001DB
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 10:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aWJnS+cZgmzDFgeZrvUFd6LVlJsReyvkOPaX8DBMJLM=; b=zHg+yGgAPsDngu698A2HSeOwpN
	Ms14TPdQIt+NIQhJpQ36LCurbGiGc0JOZ9b9y/wB2TKe4m9g7cpN890CzgYncqbvH8ubBMz/kEJ7T
	AcI1Txeb8mGNSW9d2Joh3J1DU5fZeAIobOyO5ViL8E8QwBp8O5A7tzz1OYVAEAYPeURL3q3KKfReC
	JDUXkfJEz6TX4t2EQVWS52wlyQGiam8EAdSJEC4CsJe940Kj5vTSQNcdq8KMRdMoBNv7bYUaRLtL9
	xW5it8EdLfVyh3wGRIs3EsRfdSGOzk3UmjsWIdxfWN0yWNDOHf7O/f1gAa3tt4xWTDx+ozG1DHHGf
	h6CjN1Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKPK-002QFi-1H;
	Tue, 08 Aug 2023 10:57:46 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKPI-002QEl-0f
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 10:57:45 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37866khx013149
	for <linux-nvme@lists.infradead.org>; Tue, 8 Aug 2023 06:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=smtpout1;
 bh=aWJnS+cZgmzDFgeZrvUFd6LVlJsReyvkOPaX8DBMJLM=;
 b=Q6x0J1UC9b7aZjJ3nybqU3XI3HMwjzbl0TQevHbZvQjbBM4irs8nfewsyrHf/QsELF8R
 NfLI4Hp4ogP7GV598GOrWZusVyEf476q6duvxl+QtYTNez9RwcceGuKp/pG9sFdDzNIL
 RO3ZyFF5oGyrgq0DQDIQciYFBVkSsiA5AKav/AGyULJehvJTmJ55A4OB/JRtXYpEVSts
 7CjA29a2KRyZNi5a4oGP1x4bRFRBa9gzU1VyU2jr2ZTxYreytDLEpse7WVp1Dumte0g6
 /x8rb26hv5KtSkKDbwoLRReX+UD5gEhzaJ/rL596SoFxQtGxbO0q4x3V2ozEcOE5Cpw/ Qg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3s9hg3jsn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 08 Aug 2023 06:57:41 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378AokFX013678
	for <linux-nvme@lists.infradead.org>; Tue, 8 Aug 2023 06:57:41 -0400
Received: from esaploutpc105.us.dell.com (smtp-outbound-pc1.dell.com [143.166.24.15])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3sbk5as415-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Tue, 08 Aug 2023 06:57:40 -0400
X-LoopCount0: from 10.227.212.77
X-PREM-Routing: D-Outbound
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="192768861"
Received: from unknown (HELO drmcyc-pawel-baldysiak-1-00.cec.lab.emc.com) ([10.227.212.77])
  by esaploutpc105.us.dell.com with ESMTP; 08 Aug 2023 05:57:40 -0500
From: Pawel Baldysiak <pawel.baldysiak@dell.com>
To: sagi@grimberg.me
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 09/14] nvme-tcp: control message handling for recvmsg()
Date: Tue,  8 Aug 2023 06:57:38 -0400
Message-Id: <20230808105738.3950615-1-pawel.baldysiak@dell.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <0c927b66-94cf-e2e1-ae7f-0c5dc4391c72@grimberg.me>
References: <0c927b66-94cf-e2e1-ae7f-0c5dc4391c72@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_09,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 adultscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=560
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080097
X-Proofpoint-ORIG-GUID: RHOZYFBNd0glFCdrzD7cHEUTEH3iPvw6
X-Proofpoint-GUID: RHOZYFBNd0glFCdrzD7cHEUTEH3iPvw6
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=578 impostorscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_035744_274461_C574EED8 
X-CRM114-Status: GOOD (  13.13  )
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

Hi all,

I'm testing this patchset and observe the issue with above.
It's not only about passing cbuf, but the check below.
When I would like to connect/discover without TLS, 
I got an error about unhandled TLS record.
tls_get_record_type() simply returns 0 for non-TLS,
so it breaks non-tls connections here.

Thanks
Pawel Baldysiak

