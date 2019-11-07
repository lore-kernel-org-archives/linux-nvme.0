Return-Path: <SRS0=ACpZ=Y7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB63FC6194
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2019 02:43:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C0382187F
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2019 02:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sMsYId/G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GwD0sMpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0382187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AC1REmqhYz8ZO7TZFuiiplhXzw4mnl0TLpprkehRjzQ=; b=sMsYId/G6oPv+h
	yjgT7T4nx6abCL5p2vJm3JzVoXrzAFxJG4b6knVirzWKBrLm+wDgsoQuEtW+HgXwWE4CzQHD3w206
	s/vXgDVQ9FSHjw7G2qtfF2TPHliIMW4eIy/6a8I1gxsPoLpeLW0zXauL1Au18QaBt0gRYbtFLHUGm
	CHmCIc0NwIgMLDfGbLLt17PC4huZIl//nZfe/oDjuAwc9x+leEV7e6onzSYvoi7ybxNVyycgkswwc
	11D4Ix0u71aDhL1R4en/vJf9OxYBWWDc0BWr4zRfH7hQmhXT4CxBeP9ODTI5M8TTSbhvOWnFHwYcW
	yjP0b1426iNBJ8xRfLOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iSXlY-0000jT-4S; Thu, 07 Nov 2019 02:43:20 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iSXlV-0000j9-Ko
 for linux-nvme@lists.infradead.org; Thu, 07 Nov 2019 02:43:18 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA72cvNM009718;
 Thu, 7 Nov 2019 02:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=0lM0U/zPeGXbscxepGmDkxIO04CqTRa2+IGYaBw6LuE=;
 b=GwD0sMpjbQYwC73szXD3Jov70qJtI//1ZfQTMLsY1XekOBmHMDjzd4N0z72iKCGKcs/S
 x9Bfd93CwcKV8QFaAXRIssXtYJvAin6WSZ2D9AvdpUeUbf13A9OWLtGG0yNzIXCBqT/P
 tw0WVkaH+CjwLyzR5hhbz/USXU+ORhi8gNqgv2ao7lytYevFCK70MoBcIjaMnC+zfy6E
 t0xoZ7V6XGnLJ+ddVg3xB4dBDYzfwdS12q/RVvX38uGsIkn68UmJawp1RW6z4zq59bs7
 E2ppKMkYNVIkoQtAwbfr9ic4VGdJa0a+jRdsvBlpoGaxFvlRY3UEUrQJcE4zHlO7ycab jQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2w41w0txgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2019 02:43:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA72cdAJ071490;
 Thu, 7 Nov 2019 02:43:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2w41wg05vq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2019 02:43:11 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA72hA7L018651;
 Thu, 7 Nov 2019 02:43:10 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 06 Nov 2019 18:43:10 -0800
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 06/15] block: Introduce BIP_NOMAP_INTEGRITY bip_flag
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-8-maxg@mellanox.com>
Date: Wed, 06 Nov 2019 21:43:07 -0500
In-Reply-To: <20191105162026.183901-8-maxg@mellanox.com> (Max Gurtovoy's
 message of "Tue, 5 Nov 2019 18:20:17 +0200")
Message-ID: <yq1y2wsxv7o.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=542
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=644 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070027
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191106_184317_814304_A8A749D1 
X-CRM114-Status: GOOD (  13.05  )
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
Cc: sagi@grimberg.me, vladimirk@mellanox.com, shlomin@mellanox.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, idanb@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Max,

> It means that reftag shouldn't be remapped. This flag will be used in
> case some other layer did the reftag remapping (e.g. in NVMe/RDMA the
> initiator controller performs the remapping so target side shouldn't
> map it again).

This is what BIP_MAPPED_INTEGRITY was meant for. Why do you need a
second flag?

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
