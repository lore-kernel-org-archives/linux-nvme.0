Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601FAC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 19:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K7oU2I2NHhsb+yMgUXi2apn528ykK5iPHHy2ratZxTk=; b=S/zQMLKv9iy8KutWPkozIefhU5
	k+oBxeMKoilwcIIE8DnLXrb/13wJKXsRlnfZr4PbCZNcIAJgIJ3fJH8iTGYakvxEQ/s2mMNnzmQSZ
	/YPqRj46MbtH5U1cVE4Ky6450dKajNB95Ig2SWEF4zYIw7yF2GC18pgSMEMnudKn1rzN/lKPEMnnr
	llJI9hTgEKu2GJP70ORz/wjXae+INFQ27QZcej0vXzDYLtKg/nMnt+iXumaoylPk5St5un2JmMd1q
	gFwn4Kz1AE8A8Td6Frft7rw5bgxv332CijfpbB8Pls2TvKE7iDk1wXLrbUrSWIwyTQx+qhd/Fzjnr
	kYQRgzqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0Res-002GTE-0R;
	Tue, 07 Nov 2023 19:22:42 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0Rep-002GRg-2g
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 19:22:40 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7JH9K5013721;
	Tue, 7 Nov 2023 19:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=K7oU2I2NHhsb+yMgUXi2apn528ykK5iPHHy2ratZxTk=;
 b=q4RyGOGmC9YRcABMuYTA/WevAKMeC66q9NJteZTxWLMkeDfSl7kKQHC+y6aDzKeBeQXm
 87aCmqTm3+pRckbpiamhhs0BX0EIzJUqCDagaFuC4Y975ccUQylOGy5HpI69KxtdsDN8
 K+WkOv/kX6RenJMYckoxzza7b1suT/qLvuNlqC2wnNvNLqrelAd0kBlKaPC0q/rIEH/U
 zjsKCng5MRJXVwqBI1Q92TaJ9j+pvmhEjgAh13OMbZCw3XZcV2iqh2JsxxPM5wczcfPP
 ZaWqMK0VeaksmT6zo8FrW0yZAefe0GUZsKaOSG5J4TmbhbM3fahJDf4ovwR1AJYNqHst Zw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7u8sr5g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 19:22:25 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7HQ2VY025607;
	Tue, 7 Nov 2023 19:22:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u619nk18k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 19:22:24 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A7JMNwG40960516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Nov 2023 19:22:23 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0E4F58056;
	Tue,  7 Nov 2023 19:22:23 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C7205803F;
	Tue,  7 Nov 2023 19:22:23 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Nov 2023 19:22:23 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 07 Nov 2023 13:22:23 -0600
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Christoph Hellwig
 <hch@infradead.org>, linux-nvme@lists.infradead.org,
        Wenxiong
 <wenxiong@us.ibm.com>
Subject: Re: Saw I/O errors while delete/create/attach a namespace on nvme
 device.
In-Reply-To: <ZUpVOYvgmFzXEK0y@kbusch-mbp.dhcp.thefacebook.com>
References: <ee222a8c6574d754d7e6355591e1a06a@linux.ibm.com>
 <ZUn70pL+YV0adqd0@infradead.org>
 <299987e5-ffb8-461c-9228-cad7e17cc542@nvidia.com>
 <dd07dbc043e38a7a4dcaee0b6d2835ec@linux.ibm.com>
 <ZUpVOYvgmFzXEK0y@kbusch-mbp.dhcp.thefacebook.com>
Message-ID: <01dd34b45a53d876f6609b3417802cdc@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AfLEW8-jUq2p_M4ONKh63UYqTXivmvvK
X-Proofpoint-ORIG-GUID: AfLEW8-jUq2p_M4ONKh63UYqTXivmvvK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_10,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=902 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070159
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_112239_876013_89AC2DE8 
X-CRM114-Status: GOOD (  12.98  )
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

On 2023-11-07 09:18, Keith Busch wrote:

Hi Keith,

> If you drop all open references to /dev/nvme0n1, then the handle should
> get deleted, and a manual rescan after that should get your new
> namespace visible.

Should we call nvme_ns_scan(*ctrl, nsid) again if nguid/uuid/eui64/csi 
are changed when recreating a namespace? Customers don't need to run 
ns-attach/ns-rescan manually in user space.

Thanks!
Wendy

