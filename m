Return-Path: <SRS0=77Bv=24=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852F8C32771
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2020 03:33:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5911D2064C
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2020 03:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EA50uvDt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BL2c59YK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5911D2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=98hcwbT1x0yJeRp0wwPJdwe6JFijg/Da/getfd5JRak=; b=EA50uvDt1h1Nkk
	Y9TWXwC+SsY4/UvGL6fHojTAk9zTQeE0IdrWpYlif+I20hN1VNtefVkYDy4fbw5UJAY+0GKRRUpus
	fbLIb8pcvf9Q0aRmSVu1+9tKAtTJesqFPIbelGunUauQicmVYSCUlaG6I7nM63epSPFvE+mQSSu6E
	xMGLU0bvgfwJLhEe+ihBSrvbNAW3Xs6mitKQFfVGJKPgiW/yPPkAW0T2xTf1yu9IJL6asZSeVZK4B
	ft8AlZor2PfOO0lx8jkRoZCTvnA2dV57vR8XgpEaYRmLeaPbYswq4uKeP+9O2KSExeHqgWw2c6jy3
	S0IaF9kT2D8kyat+GeKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iofcJ-0006YP-Cb; Tue, 07 Jan 2020 03:33:15 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iofcD-0006Xq-HH
 for linux-nvme@lists.infradead.org; Tue, 07 Jan 2020 03:33:11 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0073U8Dt044508;
 Tue, 7 Jan 2020 03:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=n3hOFxO756b5o0zbvtzmSTUCQEAHulQgbhS1INkyH2Y=;
 b=BL2c59YKlqagCI5G8PPSwaI3ahdwNQVZCQw8l9Qy0hk5S+Mm+ILSWLBVAvzLvY5qjv/f
 dPdlc2hZfQauXDlAHeYBRWPbGNFfwCsqgM3tae+nQFfneR5+KFic6LEDV0ULl9DDIz8z
 B8a+8aFh4kkcxD+/fNcAwTSB9uR7peCDdTmQGVWD3ujL6KPBJKsDm6irMyKnfEn8hMgg
 H0q2n8pHkEQQnSXMglv+UZXICy0hkVdcnp+KrSGFMt1CeTusWomANmCvYeHbvqv+7O+L
 7/mt3LqDv8zwlRbdnjMmEGyslco1Zdd0dNml7S3LE0HUlwL2pu5BAcwgLnmyGUUCVEPd Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2xakbqjqxr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Jan 2020 03:33:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0073U4NP086406;
 Tue, 7 Jan 2020 03:33:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2xb47hhg1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Jan 2020 03:33:00 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0073WwDN031416;
 Tue, 7 Jan 2020 03:32:58 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Jan 2020 19:32:58 -0800
To: Balbir Singh <sblbir@amazon.com>
Subject: Re: [resend v1 1/5] block/genhd: Notify udev about capacity change
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200102075315.22652-1-sblbir@amazon.com>
 <20200102075315.22652-2-sblbir@amazon.com>
Date: Mon, 06 Jan 2020 22:32:55 -0500
In-Reply-To: <20200102075315.22652-2-sblbir@amazon.com> (Balbir Singh's
 message of "Thu, 2 Jan 2020 07:53:11 +0000")
Message-ID: <yq1ftgs2b6g.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=906
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=969 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200106_193309_709506_D4D008CF 
X-CRM114-Status: GOOD (  14.49  )
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
Cc: axboe@kernel.dk, Chaitanya.Kulkarni@wdc.com, mst@redhat.com,
 jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 ssomesh@amazon.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Hi Balbir,

> Allow block/genhd to notify user space (via udev) about disk size
> changes using a new helper disk_set_capacity(), which is a wrapper on
> top of set_capacity(). disk_set_capacity() will only notify via udev
> if the current capacity or the target capacity is not zero.

I know set_capacity() is called all over the place making it a bit of a
pain to audit. Is that the reason you introduced a new function instead
of just emitting the event in set_capacity()?

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
