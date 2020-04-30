Return-Path: <SRS0=L5xI=6O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDDEC83001
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2020 06:39:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D8172173E
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2020 06:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="azzuQyLF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xs9Ttt4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8172173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=jZLVwuP8OQ/zboEGsE8he6VGBi20W4dmTH0eHMoXi2g=; b=azzuQyLFztdj5mGKP722cNpxvX
	bnWwGgeVKOj6iEEXqsU3wz4ORsvI+LZmeF462m7uM4ExwQVR/1LG+GRwCw8V8FuT2Gx6S2bB2Mz0I
	f/dwlN/eq+tlNMncdAixQ9WIXgsp9vXKwnDfxLEM9ELQajV+NTW1i6frArYbZx4Ygi3gFwZKiUKLW
	N+MvYwtLEJECGfk+Rg7jFIzaipG3glTgaWg547rYZn8MGN/GCre2E/WbdzxAGB00GhTCtOc4evcrZ
	Umsxk7v+SuobMBDq1WiWXQ65BQUnyivmQ8QuRBzmP1wolvONhzPamucKo7Q352vS+eYeMiRPSUv13
	0dzdebrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jU2qg-0005Y4-Jo; Thu, 30 Apr 2020 06:39:06 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jU2qd-0005XI-Rz
 for linux-nvme@lists.infradead.org; Thu, 30 Apr 2020 06:39:05 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03U6crf1118730;
 Thu, 30 Apr 2020 06:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GgygKgCEgTDDVJeazAEi3STD8bm5LlpQnw1YpF4Otg4=;
 b=xs9Ttt4dZf4XZdv0c6aN7U+VAYLxGiRTTbsec7OHJ0YuzuvirUrlS1YvHWqq4B7N2u/8
 fxk5PDA75jv0BEOjnZYPNJukSsrY/aNmmcKm/H0aBSjMDt7FLwvnbysP8wEvNwNmjMto
 OFuDfRvuwCkxmwbT6GpjK+lQRmbSLaLE1OZ/f+njtdkREL97O+cWDYwdJpveKIRXjglp
 MQt3k2O8LY/QgnENk0e25MSUkTDpMLuJxmh6OeG+5uUuImubIZiJuIkIk1J8pohiJdEX
 +QvXXBXtfd7mC2z6q/I3HXLF6zVxkFMH8TPIaA8w3Wa3kLIpYW/QQHI0qFG0xH/U+BDY QQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 30nucg9k89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2020 06:38:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03U6S86R054022;
 Thu, 30 Apr 2020 06:36:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 30mxrwttym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2020 06:36:54 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03U6aqgb029056;
 Thu, 30 Apr 2020 06:36:52 GMT
Received: from [10.159.241.183] (/10.159.241.183)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 29 Apr 2020 23:36:52 -0700
Subject: Re: [PATCH 2/3] nvme-pci: remove cached shadow doorbell offsets
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
References: <20200427235243.2268765-1-kbusch@kernel.org>
 <20200427235243.2268765-2-kbusch@kernel.org>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <16621645-8183-33d7-14d1-8d4c9375e55c@oracle.com>
Date: Wed, 29 Apr 2020 23:36:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427235243.2268765-2-kbusch@kernel.org>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9606
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004300051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9606
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200429_233903_992373_4FE340E2 
X-CRM114-Status: GOOD (  12.04  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Keith,

On 4/27/20 4:52 PM, Keith Busch wrote:
> Real nvme hardware doesn't support the shadow doorbell feature. Remove

I used to test with nvme emulated by qemu and NVME_CTRL_OACS_DBBUF_SUPP is not
set yet.

Would you please share which emulator would support NVME_CTRL_OACS_DBBUF_SUPP?

Thank you very much!

Dongli Zhang

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
