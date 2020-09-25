Return-Path: <SRS0=ggB5=DC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4893EC4727F
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 20:54:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E534D2086A
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 20:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H4Eq+Yte";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t0qzyxZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E534D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:References:Message-ID:
	From:Subject:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=K85kWULiOIDEJIT0LZpLbS+aMzU1rDOSRkWyiwjPfUo=; b=H4Eq+YteC4RVFun/8QPvzXEtw
	KIIIzhrskilFLm0GHSWNl4V1pbtFcUuNggXf/2/5mt1Ggqv8HMDwh9ihmKra0BSm6WRIy9myVMd93
	uzibBYzegFSsWLJVfaTkfQkDMH6AO2ZaS4prsnLspjNTffCnJui6uIQ/nU5Wh2gcZdYpVuj/SEP9a
	hpu/MwsYEJ3tz6PQCo4Si3Ee4Hvlo8GCphexI0NOYCiJJxbqAqHQx9xl1uF9CVoxZGZnU/t2zVzQ/
	yK/8qW3Q7g9yiPlrEHNL64I3zmDyjq0QnVvZet2YDpKKYt+lqc4SHGYzKzDtLsJE2AkmtjDgaS1pp
	ncYJGKjPA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLuji-0000Us-8m; Fri, 25 Sep 2020 20:54:34 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLujX-0000UI-9Q
 for linux-nvme@lists.infradead.org; Fri, 25 Sep 2020 20:54:24 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PKn2cc039197;
 Fri, 25 Sep 2020 20:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=KE/6frUW0qLJ4yGqJjxsOBztcMMvJKPi7N6S9765s1A=;
 b=t0qzyxZi0dl+YKzXtuDuHrMGqOKgH5fIMmpwIJWVMm/U3dTu+P1SS3kJTlx79mD5uwMC
 A2Edf31HXh7Zjrho5JXRQeOv1ImV1hVmEUYsbtNFLoJL4bYLIxAyhjP+J/0Zp7ifDQzk
 3Nx9/VbQNAqiGj7LS7WXYR2mfogIVEGEDnYRbjzFJkRbq3WNPTTAj2pLS3zagmxoYMTV
 iw0TWXITzP/XF5OpedI74kVNFQzbK4Xkz4lunnpJPRW1Rg6Stg2474URqb04tp+XNqiJ
 CwLxCCi7uoZ8T0Vakvb3aUzZrxZh3Nt0KvQ9mrqnvOxELTIQV/CUCoVWCkaNPXyc2d99 Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 33ndnuysne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Sep 2020 20:54:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PKoEmv040658;
 Fri, 25 Sep 2020 20:54:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 33r28yufem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2020 20:54:13 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08PKsBj6030876;
 Fri, 25 Sep 2020 20:54:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 25 Sep 2020 13:54:10 -0700
To: Coly Li <colyli@suse.de>
Subject: Re: [PATCH v8 6/7] scsi: libiscsi: use sendpage_ok() in
 iscsi_tcp_segment_map()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18scxinmw.fsf@ca-mkp.ca.oracle.com>
References: <20200925150119.112016-1-colyli@suse.de>
 <20200925150119.112016-7-colyli@suse.de>
Date: Fri, 25 Sep 2020 16:54:07 -0400
In-Reply-To: <20200925150119.112016-7-colyli@suse.de> (Coly Li's message of
 "Fri, 25 Sep 2020 23:01:18 +0800")
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=845
 suspectscore=1 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=1 bulkscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=827 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200925_165423_528512_D0330CB3 
X-CRM114-Status: GOOD (  19.71  )
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
Cc: Mike Christie <michaelc@cs.wisc.edu>, Vasily Averin <vvs@virtuozzo.com>,
 Cong Wang <amwang@redhat.com>, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Chris Leech <cleech@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Lee Duncan <lduncan@suse.com>, ceph-devel@vger.kernel.org,
 open-iscsi@googlegroups.com, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Coly,

> In iscsci driver, iscsi_tcp_segment_map() uses the following code to
> check whether the page should or not be handled by sendpage:
>     if (!recv && page_count(sg_page(sg)) >= 1 && !PageSlab(sg_page(sg)))
>
> The "page_count(sg_page(sg)) >= 1 && !PageSlab(sg_page(sg)" part is to
> make sure the page can be sent to network layer's zero copy path. This
> part is exactly what sendpage_ok() does.
>
> This patch uses  use sendpage_ok() in iscsi_tcp_segment_map() to replace
> the original open coded checks.

Looks fine to me.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
