Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262B4C7EE29
	for <linux-nvme@archiver.kernel.org>; Mon, 29 May 2023 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d7zi/I0o/rWo6T08QfiGwlU2/NixlBmcjEuiJ5YspwQ=; b=TRB8PVd8WazEZdURBoMYk1XVd0
	Vxt6f504sy8Rcf3zYryFjosELpf2EojNXGAi9dPvcY5PwePoi68Ln9UVoXgcDq0TtoXik28hBvMxf
	AlmoGe+uMOE595tGp7bkLPKYh8mprDuqT0mT1IFKu1dStC7O9c9BAW5PVb4rx/JDrks+0UByLbAWY
	UF8xvBr3sHBlbsmIE6F1GrjcbuL4HcVUlpNpkxQOVI6faiasPAFUIgIV0wj4mTOiqM7pbcOQEVxKy
	8SSjM8xnYx+X3VQfINk7wcxIioVxXEoxQ6eluJVhpFXVmtI+kgStwZw5VYFtk2A7lhpCpER68iK4S
	ukQknp/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3bOF-00AJmX-2x;
	Mon, 29 May 2023 11:50:19 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q3bOC-00AJkV-0p
	for linux-nvme@lists.infradead.org;
	Mon, 29 May 2023 11:50:18 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34T9pnlT021920
	for <linux-nvme@lists.infradead.org>; Mon, 29 May 2023 07:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=smtpout1;
 bh=d7zi/I0o/rWo6T08QfiGwlU2/NixlBmcjEuiJ5YspwQ=;
 b=ohmHv45OYy9R/OuCRvNPKhknqx0QosjwUC5x5cEL5y3otmWUVMupCerKHkh8BO68bxkb
 79GpCljvm3sRmJnSlZ6CILaIEGZAgnzEFxdhXMAH8p0zBYxUPTdleFdSnKXtXyw+iLVy
 z7IWTx3FRf840jX5gO9KyktKppLm8ENJMLG8FCDhZXOAk/aHcW/ARubyRo0SWCHvm5is
 Fmu0O8wF/H7vmRTmJaVEQN6g/mU17KRFVnOuA/VEfQ/DrW0Se+oZyABJ8lgIb2ihS6tE
 zJnB5OX+Jc2qzisc+FdMMhalK2Wga1OCOG2OIAkF/YQfViSenAys8QTbdI65XUexlQcO lA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3qucx354tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 29 May 2023 07:50:12 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34T71FXN032875
	for <linux-nvme@lists.infradead.org>; Mon, 29 May 2023 07:49:53 -0400
Received: from esaploutpc106.us.dell.com (smtp-outbound-pc1.dell.com [143.166.24.15])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3qvq9uu6t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Mon, 29 May 2023 07:49:52 -0400
X-LoopCount0: from 10.227.212.77
X-PREM-Routing: D-Outbound
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="191662533"
Received: from unknown (HELO drmcyc-pawel-baldysiak-1-00.cec.lab.emc.com) ([10.227.212.77])
  by esaploutpc106.us.dell.com with ESMTP; 29 May 2023 06:49:53 -0500
From: Pawel Baldysiak <pawel.baldysiak@dell.com>
To: bvanassche@acm.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org,
        linux-nvme@lists.infradead.org, sagi@grimberg.me,
        shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH] nvmet-rdma: Release connections synchronously
Date: Mon, 29 May 2023 07:49:51 -0400
Message-Id: <20230529114951.2006020-1-pawel.baldysiak@dell.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <55b907dd-5fe4-965c-7b0a-8cbce73b9b28@acm.org>
References: <55b907dd-5fe4-965c-7b0a-8cbce73b9b28@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_08,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=526 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305290102
X-Proofpoint-GUID: aVrozEb1v7Y0Q9u00lAVSwGtwNf3YzQ1
X-Proofpoint-ORIG-GUID: aVrozEb1v7Y0Q9u00lAVSwGtwNf3YzQ1
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=525 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305290102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230529_045016_365204_9DD723D6 
X-CRM114-Status: GOOD (  11.25  )
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

We hit original issue with rdma_destroy_id() hang,
still looking for fix. Once proposed fixes are applied -
we still run into mentioned hang related to nvmet_fatal_error_handler.
We can help with testing.

Thanks
Pawel

