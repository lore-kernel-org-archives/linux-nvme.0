Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1055FC33CA1
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 03:25:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EACF206F0
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 03:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OGQ9HcSo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rI+IRs/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EACF206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SzBGceJfQhUu21yXzEPG+GwblTgnh55WJqCMdc6+ZJ4=; b=OGQ9HcSoRC5iWW
	gX0/HbgG9RYMwMjQam563HeypRF6btZGXV4q4Ro6LhXBmChgBjpph47PSQo33Z9tSNGAQ6KWkN2LH
	Zqo6EZIPpagoD2fGum97B2obFcQcqAS+PfIG0KuQCdZgwwcd7fYwxO+Ki4iPBGu1sCcl1DlS/eymz
	nQEmzshebU64YS9cQIS+L1YQSC3wqB+3cO5UGkovsriJYeyv5bx+8h/c05Yr6iOTCIhwtP+ejNA0X
	6udhQbZYA6cOCuyBBYVky63/bKBQgzF46jRmaPMty4/QQ+l+JO/R4LwYIboG3v86MaxpqOfmjBoIH
	2idQ3DVzACq7+pLTFvXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipORP-0007TX-2K; Thu, 09 Jan 2020 03:24:59 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipORM-0007T1-D0
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 03:24:57 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0093NKL7180582;
 Thu, 9 Jan 2020 03:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=eqD+qPA5hgOgf/JKXUXdG1yT7z5hJlXbfHnIMbAK/ZU=;
 b=rI+IRs/X7M1El9fBCLMJzLn8a0sVYbDRBsqLCEHKXVeJQAIhKqC1HAGbDFwTMPMxvFw6
 2UCRSTy9cQh6p0TtK20rCDMlEFicgL9glmzYR3JEvbDyDmIq80ow4cWLy0FJhKG3q6Dd
 H2IEArSu1txNIBM0toLfQUZPjEbFP3lWWJpm9lKxhYB9C6KBvAoKvy3mPUjV7g8R+wJu
 m8GOQcxoHUNaCaOCvwNQ+W9nJflprB0j99ZTgp4XgFrBJoj56ZI0zSPTGoKO8VeCxkwf
 uJZeCd3qN80ROV/jpHGHd582GF9CfAAn/Yd/4PDZ7tLAGgCHKITwqBqoD+VEuhW/g0b1 UA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2xaj4u84vk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Jan 2020 03:24:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0093NbRm135019;
 Thu, 9 Jan 2020 03:24:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2xdrx73yn0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Jan 2020 03:24:52 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0093Onud014606;
 Thu, 9 Jan 2020 03:24:49 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 08 Jan 2020 19:24:49 -0800
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 13/15] nvmet: Add metadata/T10-PI support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-15-maxg@mellanox.com>
Date: Wed, 08 Jan 2020 22:24:46 -0500
In-Reply-To: <20200106133736.123038-15-maxg@mellanox.com> (Max Gurtovoy's
 message of "Mon, 6 Jan 2020 15:37:34 +0200")
Message-ID: <yq1sgkpxqf5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001090031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001090031
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_192456_529322_A5D26D3F 
X-CRM114-Status: GOOD (  11.58  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me, martin.petersen@oracle.com,
 shlomin@mellanox.com, israelr@mellanox.com, vladimirk@mellanox.com,
 linux-nvme@lists.infradead.org, idanb@mellanox.com, oren@mellanox.com,
 kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Max,

> -	/* no limit on data transfer sizes for now */
> -	id->mdts = 0;
> +	/* Limit MDTS for metadata capable controllers (assume mpsmin is 4k) */
> +	id->mdts = ctrl->pi_support ? ilog2(NVMET_T10_PI_MAX_KB_SZ >> 2) : 0;

[...]

> +#define NVMET_T10_PI_MAX_KB_SZ 128

Where does this limit come from?

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
