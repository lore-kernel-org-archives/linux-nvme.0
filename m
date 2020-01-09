Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53801C33C9E
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 03:14:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225ED2067D
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 03:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FdXAn4Io";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EUtLUt0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225ED2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hdDa0XdMCfy+gedlDcQphGQrcFe660OHY9FbRBOuYWE=; b=FdXAn4Io0jctlb
	Z8cn2ZIPKHQJVR1NeGeIz0Y7tmg9wT6b7rlw3KcTx9aQFEFEoPzk80bVzWNxOFLmQmp6tSaIr7aWk
	aI4U6mnEmXizyODSze4kMjEEqmYbY2L60bdbNl/FDzDPe3sus6Lfo0H07GFO4qV34d8ZddfPsbScS
	F6afH58MI3rUI/VFYMX1rJww7WIJT+Rq/rU28xG+hOIMrE4kcdT8+UFU6HOa93lEQ1tYcWjV0hByZ
	gF9sGcv5hgzWKB+w4cayXxz96+UatOzGNEh86LIoSoUyWug66i1OrviCISs0yILqDbc0ZqjPoc2Wh
	JSL1fxrNiYC7hIjKqN4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipOGq-0000zU-CN; Thu, 09 Jan 2020 03:14:04 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipOGn-0000z4-IG
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 03:14:02 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0093Dw9c151071;
 Thu, 9 Jan 2020 03:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=/t9VcqnaU7ULYh5QUvDsMhPmLYu02AhW59USkM0yFqM=;
 b=EUtLUt0usJzWWpeJohcKVLLn3qha7WUzP7dcv0hYSnAu6VvPTul0vEji2BTzVhGYnzt4
 GksRRhXge426KrcVKhLvcnydIKQxNyQ3nZJQd/ud8+MGvRaqq8v1b6D2XVxmR7QMZF39
 RKVDewPwOKADj00bpFjNX7JBMyewHPoh8zcnGowpZT40d8JZVooPv2FCoU4DDx4v0lS8
 ZOcjKBJskBKG7mb9bzcF6cmBplzgCgI8QRyDSucVqR1oUllIzWP7lduLmrzV1TWguSg3
 5W11dk+Ds8pHCAcjGGC7FIAh/PZH/viBKGUnzm9u00e6fcgzC4wdnK9vBF671aoqNGNQ eQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2xajnq80y7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Jan 2020 03:13:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00934Mwa182059;
 Thu, 9 Jan 2020 03:11:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2xdj4prjn1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Jan 2020 03:11:57 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0093Bsju014569;
 Thu, 9 Jan 2020 03:11:55 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 08 Jan 2020 19:11:54 -0800
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 01/15] nvme: Introduce namespace features flag
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-3-maxg@mellanox.com>
Date: Wed, 08 Jan 2020 22:11:51 -0500
In-Reply-To: <20200106133736.123038-3-maxg@mellanox.com> (Max Gurtovoy's
 message of "Mon, 6 Jan 2020 15:37:22 +0200")
Message-ID: <yq1imllz5l4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=761
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001090028
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=823 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001090029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_191401_691329_CB61C5E8 
X-CRM114-Status: GOOD (  11.65  )
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

> +#define NVME_NS_DIX_SUPPORTED	(1 << 1)
> +#define NVME_NS_DIF_SUPPORTED	(1 << 2)

Not so keen on the DIF/DIX terminology in this context.

DIF as a term was obsoleted long ago in T10. The proper term is
Protection Information which you also use throughout these changes. We
have lots of DIF references in the kernel for hysterical raisins. But
let's not create new ones.

DIX is a spec I wrote to describe how controllers could exchange T10
Protection Information with a host. It's specific to SCSI and although
DIX is referenced in the NVMe spec, it would not be accurate to describe
the NVMe features using the term DIX.

So I'm in agreement with Keith that this should be named using more
descriptive terms such as NVME_NS_PI, NVME_NS_CONTIGUOUS_PI,
NVME_NS_SEPARATE_PI, or similar.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
