Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37C8C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 03:08:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819D7205CB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 03:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tm1r3pA/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ojYGVVpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819D7205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eMI7DqJC2CG35Uwhj0efVP3gVWxVtltowIUzzHS0Jkg=; b=Tm1r3pA/uJ313u
	mF2e5izlVw49tiGIjJFYArp0NuaQSoAeui0l+JRxcsacx9RZNqI/fPHY1oBW+/1sM/182HTWO/N0W
	NNEugv0dOM+N2YL5qKW9T/m1F4D+LAmkeeUs8VsqbJkGbBlF5xaOE3km7MvAZ+FpGc5JzmcVpYW4t
	hoRhhnnlFmrnUbTAbHQUkD/HHSzWizXJ7yW65F2d1bdjKbIsxx2mUeKd4f7ONe2ZYaUXX3g2SuqLH
	VOiAzEoYdMnPZ0pWNTvjIYmiGQxBbNWMmiTfBZVZgIz2ni1Mffz0YaTLW4xkmK5DLdC7BDlewvw/z
	DeM7XI+neFl40pdSRxFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ4Ei-0006Ag-J0; Thu, 14 May 2020 03:08:40 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ4Ef-0006AC-Jf
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 03:08:38 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04E37bpn095179;
 Thu, 14 May 2020 03:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=KPqgzf8TJG20Qym9vowo2tVQIn45H4CeSEpC5IVS5z8=;
 b=ojYGVVpfd4j77TgY9wvoi88W/yt0gJTixGVga4a/Noie7Vmz8FJkFRsboZkDIOxLe1Eu
 jeBctK9AOSW3q7YtcHI7Z+5wr11r28N6XJXvu+c87xc9ZY4PD5VK5R52DrIiGwYlIeYi
 7bakjdA6t8NrgWpTE6qCfPwAst0d06MaU6uCMaYTVEok6YItUvxM6DtfQ7yeAN9iO9vc
 AH4HPrwM8taOmhd+iL9LKv3wZRisUSeFFGCnhk/2s1IADhFWHXc/jOdOG0uYuo5XyDby
 iy5OVLVNSPo9sDZoeaaUinV4RVTDFzpSElTKtHD2H2g89oJ93Jc5ADCkcg5w5BAUgFDp gA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 3100xwqym4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 May 2020 03:08:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04E32cx4019089;
 Thu, 14 May 2020 03:06:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 310vjr65xa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 May 2020 03:06:31 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04E36Ulo016063;
 Thu, 14 May 2020 03:06:30 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 May 2020 20:06:29 -0700
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH 10/16] nvmet: add metadata characteristics for a namespace
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-11-maxg@mellanox.com>
 <65a7ec19-425f-f3ad-191c-333eac46a81b@broadcom.com>
Date: Wed, 13 May 2020 23:06:26 -0400
In-Reply-To: <65a7ec19-425f-f3ad-191c-333eac46a81b@broadcom.com> (James
 Smart's message of "Wed, 13 May 2020 12:25:02 -0700")
Message-ID: <yq1mu6bw6z1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 cotscore=-2147483648 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_200837_782544_B275363C 
X-CRM114-Status: GOOD (  14.29  )
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

> I assume, all bdevs that support an integrity profile will report a
> blocksize that does not contain the integrity data ?

They must.

> And we're going to fail as badly now as before if the bdev didn't have
> a power-of-2 blocksize, or supported metadata (a blk-integrity buffer)
> and metadata_size isn't set ?

We do not support logical block sizes that are not powers of two.

The whole point of PI was to keep the logical block size at 512 despite
520 bytes going over the wire per block. And the point of DIX was to
accommodate sending and receiving the PI portion without having to
change the I/O path to accommodate non-powers-of-two.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
