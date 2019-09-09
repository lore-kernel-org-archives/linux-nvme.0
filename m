Return-Path: <SRS0=NvMH=XE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD7EC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 02:23:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E16B20863
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 02:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gL98t0jN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SSwNbOTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E16B20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PbHegINVjHdn3tgmwQ4xeVoDlyThHoJmHbI+WI8itqg=; b=gL98t0jNUd1XI6
	0fBU0vPJZmH8iyktEk1jHhPLhZ/hJ7i7gfBZ5tXtbirFvpiF9nP9+r0xHSukEUfs5PxtNnlERo8G2
	x3ApoGpH5+KoRTi47uPArUvKTMYtbCSFAKwSusQIeHsE2A9Lpv89lnP0nS+PthziSgHIOpPnOG3Fi
	UUcGTUTcz9TFbacIfA0e9A6fmLUbTVnaDf7u5rLayZL6EbEEe5sgVlsc+bSfAZB6VC+IlfW1iVWMd
	2P5jp7eya8iSbh7ySDWDlHsbT8mxiD9hSgkS7UR/dw/iL80ZF3WPQ3r7U/f3PgKWBgKucRAjgmJlR
	QVrLNM94OesCxBT4TyvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i79Kd-00050S-9j; Mon, 09 Sep 2019 02:23:07 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i79Ka-000504-4I
 for linux-nvme@lists.infradead.org; Mon, 09 Sep 2019 02:23:05 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x892ELu8057518;
 Mon, 9 Sep 2019 02:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=XXVt1NnzXfnxrwj5J+uXLqP0KDcdt2wtFr4yiRvxo4o=;
 b=SSwNbOTPDcm/VgfsFTi+ebqgQzyLmIbvbTwIeOxkcvZxJdTgM4Bd7+E9jlW/gRQJwaon
 p4pnuB5Jz5WegUGsYz0Kbj8woIddSX8YT8jP5cfXyqGgfe6HgZNVM0wvDhT5viFPaIvV
 xgRPcsmqM2+TlR7AWGjMErrNxrTj1JQoan4XTIvpBD6/CMB/peMxj/mxM3yoYdqkRMbP
 7GbpoACYrpxfQEkWlXpqcWuUjxHrM4dieSej2i50sdFcDfyOQ2LjxJRXDOLxwf+SLXkW
 Ri0XC3eUBp540wqj9oyYKjwlG5sTNQT4LCKfsWJfncVNUCTq5yvO9IsjNpMrtavw0neg oQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2uw1jxs79m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Sep 2019 02:22:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x892JCl2183534;
 Mon, 9 Sep 2019 02:22:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2uv3wkw2rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Sep 2019 02:22:54 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x892Mrdm014431;
 Mon, 9 Sep 2019 02:22:53 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 08 Sep 2019 19:22:53 -0700
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v4 2/3] block: don't remap ref tag for T10 PI type 0
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
 <1567956405-5585-2-git-send-email-maxg@mellanox.com>
Date: Sun, 08 Sep 2019 22:22:50 -0400
In-Reply-To: <1567956405-5585-2-git-send-email-maxg@mellanox.com> (Max
 Gurtovoy's message of "Sun, 8 Sep 2019 18:26:44 +0300")
Message-ID: <yq1ftl6i4xx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9374
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=781
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909090023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9374
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=861 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909090023
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190908_192304_257703_EC6C12FA 
X-CRM114-Status: GOOD (  10.16  )
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
Cc: axboe@kernel.dk, keith.busch@intel.com, sagi@grimberg.me,
 martin.petersen@oracle.com, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 shlomin@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Max,

> Only type 1 and type 2 have a reference tag by definition.

DIX Type 0 needs remapping so this assertion is not correct.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
