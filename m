Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D76C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 02:59:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9203205ED
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 02:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j2UbXKfQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fQADzbmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9203205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/ws380vZt/+EIUqbAJSYAstuojlNC4/jKHtHSvqo3WI=; b=j2UbXKfQnpbYmF
	gXgptCbcLjKUiwBSCpojrTttvt0x4DSHnmchXMXyVa/uTj8ikAUXTBR4i1zyryapB+Y4puNeLo5FO
	ohSJoYCYMHyitJ2511N/Vo2625SOgRTl9WpuZhH5XuZlU01Zl6+r+88uFTdJx8Ts0DGWmTI8b5sZf
	AXD+VfnZvYASy9C0o9jR6ymAZuwMFuG9IC5Z9ndZrbaeBLE29KQUiXXCMSNblxfkRP96b36CkA28y
	ndJP5W8G+u+1qs1RROuPyuQkfXBrl6Sf92y4H6HCMAPqgWgtekWqLXWeK8cwwYHoEenqqVBmNlAC9
	mMeYP27CIl0dIwVWgsbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ45Y-0007pD-S3; Thu, 14 May 2020 02:59:12 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ45V-0007oq-RV
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 02:59:11 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04E2rAMt071819;
 Thu, 14 May 2020 02:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=7KIt3XARGHWnw2HHma1/zZeWQI1arxD+eKipkks+hBQ=;
 b=fQADzbmIJ8oRlDVOk+kfq2QZ6u9vEFCTp9iBSGGkDmYn4L0OSy+1aUnlKLn3X0le81IA
 Zl5qOee0E6lGfLEmmzYDf0KKW+hid6Zh9QAwTRohrJCqk4DgtShX0UIEdgueZKXscG2o
 1pO+wTKyWaawjS2bLlfkJz1Sq429B27KCZAuSYJ63QcOBfCqx4UgPI9w0Go6f9KyQVLQ
 Ogs2ivVPyNbWraw5TO/1Q+lxOxLRCmg6cCpla4DjCi71AlHDPqTdQTB2St0sirSwYxR6
 UcIWy2320x6wunJnR4reaTYEs6fi4jraq3BXu9y1hPQZyugTFKUw6MuntScnZwCc/y40 0A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 3100xwqxr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 May 2020 02:59:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04E2s3sk032882;
 Thu, 14 May 2020 02:57:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 3100yftwwx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 May 2020 02:57:03 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04E2v2Vc021536;
 Thu, 14 May 2020 02:57:02 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 May 2020 19:57:01 -0700
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH 06/16] nvme: enforce extended LBA format for fabrics
 metadata
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-7-maxg@mellanox.com>
 <33e04c87-f41a-e5a4-05f0-807d52bb78ff@broadcom.com>
Date: Wed, 13 May 2020 22:56:58 -0400
In-Reply-To: <33e04c87-f41a-e5a4-05f0-807d52bb78ff@broadcom.com> (James
 Smart's message of "Wed, 13 May 2020 12:03:54 -0700")
Message-ID: <yq1v9kzw7et.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 cotscore=-2147483648 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140024
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_195910_020319_9A3DF7D6 
X-CRM114-Status: GOOD (  12.44  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, idanb@mellanox.com, israelr@mellanox.com,
 vladimirk@mellanox.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, Max Gurtovoy <maxg@mellanox.com>,
 nitzanc@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


James,

> This is ok. Later patches will should deal with no block-layer
> integrity buffer, but having the transport port auto-generate/strip
> interleaved pi data, as we will want to protect during transmission on
> the wire, not just PRACT=1 it.

Yeah. Whether the integrity is supplied by the block layer is a per-I/O
property. Revalidation should record capabilities, not enforce any
particular set of I/O properties.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
