Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEE6C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 22:21:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F370C206D8
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 22:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gdkHu7Hh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q+V+vcDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F370C206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z4sblJRj3qOu3lQhtUrN3zWkyr3yWOFlJ0IbSO/gGMk=; b=gdkHu7HhYmQl6c
	IDJ/9z+odDzJvz66dRvUTvnG0wr75vzAYQWxIpj5KyW+w9/gmLS0kmUQT/lpYj3QPbzeb6pWera1T
	aqyIxJ/yyhLYhbyuijZ6X7Su/96rSVSrYTR7MMf5lYBZaOsk4rhbRIGjsrrUEOhKx+PKMcpdAbbbO
	w0LcV2fPOhSfdJUzV+qJM0BEwyPAP/ghLAOJS8w3az2lpw9PqpQEJdPI2XBFPaaGr0bjxcdhXc8Rs
	krVi1napoQLK0MfxCO5Qqk3LTqvqSvGN0kip8ELymScZTmKVXFZK0+Eq8x5JGCq5pv1Xi2H+DZU0w
	b66nueyDgml3rUZWdymA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZMDr-00083m-C7; Thu, 14 May 2020 22:20:59 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZMDo-00083N-Ow
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 22:20:58 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EMDPaj188743;
 Thu, 14 May 2020 22:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=iXu1nAFus4sTDwZffcA0m9B08Spv91nPDCqcGwihypw=;
 b=q+V+vcDxWOfUqLFY4dRflM0pbKUmHivvaaYcOFJgK6eM/H88f0og65w03PyOdqT0w4A7
 x+cb4XGkw6UECz8elS+sx91a3LfmP7ojHfO8yhP6W+K0Yvrk+mrOE9FHH3gp6GW6Oac1
 vHKSu8muKTggqwjPVvpl6f5KIKrocK6cuhSFk/CPxnwSbylUifT3JPMiUZvaTP+vUb0C
 eOyNkX7KsboJg02cQU8sKdnNFtDAvWxlSc/qvCWn+dVoCWS24IFHNyRNvuEJRIjGasfv
 jSessfw/438JEhTx0nvOuxalbtue6LJhwGTi4xgHLi5827jYNeF/+WX7Pv+nXsWGYdLn aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 3100xwwetw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 May 2020 22:20:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EM8hOp067934;
 Thu, 14 May 2020 22:20:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 310vju293d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 May 2020 22:20:51 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04EMKo5H002141;
 Thu, 14 May 2020 22:20:50 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 14 May 2020 15:20:49 -0700
To: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v2] nvme: Fix io_opt limit setting
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200514055626.1111729-1-damien.lemoal@wdc.com>
Date: Thu, 14 May 2020 18:20:47 -0400
In-Reply-To: <20200514055626.1111729-1-damien.lemoal@wdc.com> (Damien Le
 Moal's message of "Thu, 14 May 2020 14:56:26 +0900")
Message-ID: <yq1y2putayo.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=971 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140194
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 cotscore=-2147483648 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140194
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200514_152056_893877_C38F9E5B 
X-CRM114-Status: GOOD (  12.80  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Damien,

> Fix this by not setting the optimal IO size queue limit if the
> namespace does not report an optimal write size value.

I'm also OK with this approach.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
