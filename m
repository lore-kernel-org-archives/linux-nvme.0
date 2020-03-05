Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A6DC3F2D1
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 09:51:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D9621556
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 09:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZEE8vvu+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jlnPB6Ez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D9621556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eFLWWPlv6yE8a/iFWOAXBznx5X01E5PA0HCtaC4Uvwg=; b=ZEE8vvu+uUX2hs
	yCuBXbNzFBlvdX9RRp90vT4KgsGZE5eAWqX7l7J2jXKpFDddeY4TZMqX3maUpzh13cfVA2tHoiJLK
	WQO6pSWx6BzzCXarNIEVo+zuwIX+bWdKPq5f1OPOHQCy1HRl4PQ9p+a8SZSijg6uUffTXg5hgnv3O
	4RhSolXqT1YnPdTtmztzKJTcDI34SJfVxCgYC+TeAV4PE8XDJ95sTFxTAtBG8SZCBjsoYpiREqmpR
	deUJpIaJVh0MDpq1v2m6uNbrChBxa7bhlfFLrh2S6Bn5Q1kpt9ZZ09wlTtOw2JrpIC7RVaIJsk0fD
	1rPbhSXh2nmpsNwlqIng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9nA0-0007mp-EF; Thu, 05 Mar 2020 09:51:20 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9n9x-0007mC-Nf
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 09:51:19 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0259m6C6059645;
 Thu, 5 Mar 2020 09:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=yYYkV0R9yX6j3o30Kqir1XXMC7aR1HAwVpUsfmRqSNc=;
 b=jlnPB6Ez2vYonpM3B0XtYePMEWs9FOxfCgMLUmx86j+dRztlFL+B6k8v4RxOnzDSQEKQ
 lH1L9FoCJWcErqjFPTeQVGYB5GiY2g9fzbjoxAtbSHJxU6pFTQNSENFZG/sFyNqDfXXN
 xaU1geRu3pNI1oYKfCeJZ8z3jJ4JBOOU5ncCGtGdrmkGk7lqIMVMCPnQxz4hoo4N2rz0
 X9zOuxL73bVdaXEPxpOjAX7iPAuuaf9CmwlY10jEJ7bb0Fkb49vOE+op7YGvKs4Dd8EB
 X3Bj8dHyo2lw3wTLy0HQq3JaxxYG9iOsAPBCn4xv57Xuwvoyqmf3ZvrDpzjGSQuOu2eJ mQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2yffwr40w3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Mar 2020 09:51:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0259md2e180600;
 Thu, 5 Mar 2020 09:51:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2yg1pa3qpt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Mar 2020 09:51:02 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0259oxeK021166;
 Thu, 5 Mar 2020 09:51:00 GMT
Received: from [10.0.0.251] (/24.5.189.83)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 05 Mar 2020 01:50:59 -0800
Subject: Re: [PATCHv2 2/3] nvme-pci: Remove two-pass completions
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
References: <20200304181246.481835-1-kbusch@kernel.org>
 <20200304181246.481835-3-kbusch@kernel.org>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <b25de82c-115f-50d3-6752-f4f91a5623ae@oracle.com>
Date: Thu, 5 Mar 2020 01:50:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304181246.481835-3-kbusch@kernel.org>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003050061
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200305_015117_855644_7CDD1ECF 
X-CRM114-Status: GOOD (  14.56  )
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
Cc: bijan.mottahedeh@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Keith,

On 3/4/20 10:12 AM, Keith Busch wrote:
> Completion handling had been done in two steps: find all new completions
> under a lock, then handle those completions outside the lock. This was
> done to make the locked section as short as possible so that other
> threads using the same lock wait less time.
> 
> The driver no longer shares locks during completion, and is in fact
> lockless for interrupt driven queues, so the optimization no longer

About "no longer shares locks", would you mind share is it a specific nvme
driver commit, or the transition from sq to mq?

Thank you very much!

Dongli Zhang

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
