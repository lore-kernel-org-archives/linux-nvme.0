Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F39CC67861
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nmzGjCfhoTBwGlT/qWPnC50wEjM32v4tIptLAxzsVlA=; b=1J8FJbOAAwFj1Eb6kGtgW7AdjI
	KLGu+1jJU/dvjo5mjv44ngD9xPzh8XiXcfHS9zlj9Es+liywtpRofWhF7Ix/bFE+SddwRKQzdL6E3
	2JAlISegWmS9F/+3YkviA5C07HCQSmYv4cluLID9YRrf4Ti4BlUfk3G4TWH/WK+Z/CWVCZzzwoZ6g
	ifZhFxkyZVDnYSMYXhb3Amas/mPjtT49uAv6uwQf5sWjopzWKdp42X7Ii/LpK5SUcY9sKeBc/2TWt
	EELZyQxEYvi4nnUgFWM1+x6neDgk+BDNItEqul1M9aE4W0yuuICmhYz9xuS/uxhTYcEO0aXLqJ7gJ
	iTZLx9wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtmGe-0000000FGne-1PJR;
	Mon, 08 Apr 2024 10:30:24 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtmGb-0000000FGmd-28BX
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 10:30:22 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438ARUcX014693;
	Mon, 8 Apr 2024 10:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nmzGjCfhoTBwGlT/qWPnC50wEjM32v4tIptLAxzsVlA=;
 b=f9m8L1TD+sIrsI4qSI3cpBOMKh2P71+Fnfzv99HYV8nS+J0BduAWzy2Y6MPjuulzu5FU
 Z3+q72wyBga/I72qmkDvZ96WjLiEf4zNEILsRueWwsB32/68aG/8mp/wZWbee/57WdLR
 Yz2C7cxA2WLOPJrx8G+ZN5NNiX63fuXPkaeU3nFuXaZj5swMy2dYz0R2OK+/a5hL6ekB
 JFxS3fr8wOXx+TL2mUYFHRZ/log5JjF+1gimasED4001szsuADbmHkVjTDaCcJUUqmRK
 Gxi+D9aYJcMfH4eV1Y2lJpISbnDU+nDG0Tc3s4fd4BCVE9fWMfV/q4k3b/IBN1XmvgVN 3Q== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xceuar088-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 10:30:18 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 438A6XEE016996;
	Mon, 8 Apr 2024 10:30:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbke273se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 10:30:17 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 438AUEop22545060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Apr 2024 10:30:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E9F15805C;
	Mon,  8 Apr 2024 10:30:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F048758070;
	Mon,  8 Apr 2024 10:30:11 +0000 (GMT)
Received: from [9.109.198.231] (unknown [9.109.198.231])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Apr 2024 10:30:11 +0000 (GMT)
Message-ID: <5f26a2ca-1413-4f33-abf3-7b977adfc7de@linux.ibm.com>
Date: Mon, 8 Apr 2024 16:00:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Fix EEH failure on ppc after subsystem reset
Content-Language: en-US
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, axboe@fb.com,
        hch@lst.de, gjoyce@ibm.com
References: <20240408102329.442335-1-nilay@linux.ibm.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240408102329.442335-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HVqDhS1jS9kz32CmqoxEvdOJyj4s4UMr
X-Proofpoint-ORIG-GUID: HVqDhS1jS9kz32CmqoxEvdOJyj4s4UMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_09,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=599 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404080081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_033021_613567_7A977DE4 
X-CRM114-Status: UNSURE (   9.84  )
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

Please ignore this message. I was supposed to send PATCHv2. Click sent before updating patch version.
Sorry for the inconvenience...

Thanks,
--Nilay


