Return-Path: <SRS0=OKIn=7E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F77C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2020 07:33:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EAE2206DD
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2020 07:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ITKLytdE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zr8ftTxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EAE2206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b/yK5jGsuKQtJqmmcGn0xnIkZKMJclqWE4O5vOvINYw=; b=ITKLytdEO9dm7w
	vYKyXbptdNU5uRSYRD88Hz14BRTBJo/6WrUa4VlZ+gEYOe5o26mwmHZJN6CbJaj83TKXA1P5fO42Z
	IQYESUXB1l8TX921eBxLBQY4h9ed0d6GkgQfjv+7JVz0QFO05l7ZL1LqhUJjnaC03DKHLshIxcjEV
	dkagDL0jSQhYYgGyeuTYWlMnZ8jKf9RArkN/sx+s25MsKQsJ8q8p8w/WipJ4QRYDO1ujeS36SRU1w
	EnF41Us3jvrkjLEPf+eCoAKbz1qBU0A9fA9y1r98Ezs15Z7+cdJjITMLcHxOPLH4f5ex/F/QdXJ/c
	XbM5jCVVoXsDvSBDdopQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jc2Ax-000279-ES; Fri, 22 May 2020 07:33:03 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jc2Au-00026f-EK
 for linux-nvme@lists.infradead.org; Fri, 22 May 2020 07:33:01 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04M7RiMI099138;
 Fri, 22 May 2020 07:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=FHKudRAmfJMTmkL5lBhr9gMRqVNot+ZGcY+gLOKSPWQ=;
 b=zr8ftTxmN8djMVNxsfauxHijqmQZJ27JNYNzSbiwZV1H4No0xKEXcoTBytv3PDJSvcrp
 /Nyramp0bw+dLsKfAey75XBoOuEv6PhQEYKJ3fSf3n1UF81MxbM2guQfVP9qMNYBHSff
 0IBWTd1TSwN4MLhOwVoRqfipf6RiOQW0ZCK7XL0FAcRfHgkHtQjUaJ+5Ssh5CBYpXINY
 19VERK0I4Y44f8lhzUIpFleEzhe1ducy/y6uezF+0Px3K3Lqe7sK49O1DZqJJPuH2L+p
 jIo5SWG9s0WsYzgwXQcbaKu7YC1xheaXy9TBqY2v9S5VpftJZIi8oHvInJOIZ0c/DQKw 9g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 31501rjt8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 May 2020 07:31:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04M7TICY165649;
 Fri, 22 May 2020 07:29:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 315023u8fy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2020 07:29:24 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04M7TJnm022187;
 Fri, 22 May 2020 07:29:19 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 22 May 2020 00:29:18 -0700
Date: Fri, 22 May 2020 10:29:11 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH 0/3] lpfc: Fix errors in LS receive refactoring
Message-ID: <20200522072911.GA22511@kadam>
References: <20200520185929.48779-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200520185929.48779-1-jsmart2021@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005220060
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200522_003300_569362_76B196AF 
X-CRM114-Status: GOOD (  14.74  )
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
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 jejb@linux.ibm.com, kernel-janitors@vger.kernel.org,
 linux-nvme@lists.infradead.org, hch@infradead.org, paul.ely@broadcom.com,
 hare@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 20, 2020 at 11:59:26AM -0700, James Smart wrote:
> A prior patch set refactored lpfc to create common routines for NVME LS
> handling for use by both the initiator and target paths.  The refactoring
> introduced several errors spotted by additional testing and static checker
> reporting.
> 
> This patch set corrects those errors.
> 
> The patches should enter via the nvme tree, as the lpfc modifications were
> in support of nvme-fc transport api deltas merged via the nvme tree.
> 
> -- james

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
