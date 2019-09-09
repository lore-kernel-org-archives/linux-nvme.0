Return-Path: <SRS0=NvMH=XE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55242C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 02:49:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8EF2086D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 02:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZN1rX0vN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IS9Lj8bR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8EF2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+QuXQu9PCmuOi2Oxa8kmwVqBH46JrjPB3VF6gW22fJA=; b=ZN1rX0vNh09Md6
	lkwdceLLLYn1vZ9otx2Bahgqg6mmBXEWVy8lpDXo28fWL+TR6Dj3yeMyrFjDqAm5JuzTbNCqUhNOF
	l/0MFTYztgIobLeBpUathAcCmmuoacC8k3MppsySMQJmIcoFOkEUeslGuvJnbxmFmU3twSuYj0wk5
	mIOGAPDThGNTv9s2cvupF3VZoICH4kS5zt6eyrC0GF8ouEsvM+T1R2dTjIUm1zKMWlkCR9Xu0Kvqe
	mI8ahKYBdzaZK/qvLX38gdPGi/k1/t6C4dJ/u2OGzaNxyr6PjyV4Yh/Ge/zgSW8WpHtD5rTAtP3WV
	SjlNR/oHirF2c/c55tKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i79jz-0006lf-P3; Mon, 09 Sep 2019 02:49:19 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i79jw-0006lJ-Uk
 for linux-nvme@lists.infradead.org; Mon, 09 Sep 2019 02:49:18 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x892iUCM114038;
 Mon, 9 Sep 2019 02:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=4MN8jJzoNciSq/uZgMjvZeXOoEJlNQnAC2ubMM68AYY=;
 b=IS9Lj8bRziQ/xr52QlYlkf4YZpEEB7Xig0vdOjhSyYJC1aoEcARJDpX2A418aNoN4LkU
 7VF4HWud9m5DRByR6ngLJ9DVZdwdqKQll6oswKKZnEeZ60TePchkz2W01M7NjCMYfcRM
 l3o9YfC6FIi4YBSYLI8/4iHmTkuxdR73+F+QDYX22iHPGlg3tmcCItVKdF+114PfKkTQ
 UCTbQZ6ScKueXRY9kdbzN5YxaI3sMqLQoluZRZ5bmV3YbIFT7tOyID915pHS/S/5gowC
 YKKNEMGI2SWjp4Yf4RJB4082ayASgn60GWnVnticXnLR7Y9Ri3imfrF8Fi7jOsr/PP5z 7g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2uw1jk19d1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Sep 2019 02:49:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x892mol9033636;
 Mon, 9 Sep 2019 02:49:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2uv3wkwpv8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Sep 2019 02:49:04 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x892n3gm012458;
 Mon, 9 Sep 2019 02:49:03 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 08 Sep 2019 19:49:03 -0700
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 2/3] block: don't remap ref tag for T10 PI type 0
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
 <1567956405-5585-2-git-send-email-maxg@mellanox.com>
 <yq1ftl6i4xx.fsf@oracle.com> <20190909023601.GA6772@keith-busch>
Date: Sun, 08 Sep 2019 22:49:00 -0400
In-Reply-To: <20190909023601.GA6772@keith-busch> (Keith Busch's message of
 "Sun, 8 Sep 2019 20:36:02 -0600")
Message-ID: <yq136h6i3qb.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9374
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=753
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909090029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9374
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=816 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909090029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190908_194917_082558_CD0CE663 
X-CRM114-Status: GOOD (  13.69  )
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
 "Martin K. Petersen" <martin.petersen@oracle.com>, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, keith.busch@intel.com, shlomin@mellanox.com,
 Max Gurtovoy <maxg@mellanox.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Keith,

> At least for nvme, type 0 means you have meta data but not for
> protection information,

Yeah, NVMe does not support DIX Type 0.

> so remapping the place the where reference tag exists for other PI
> types corrupts the metadata.

But the device shouldn't have an integrity profile in that case (see
previous mail about why keying off of the protection_type is a problem).

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
