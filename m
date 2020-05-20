Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECCFC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:27:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0432075F
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ODsNcJ6c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wT/MbRNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0432075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bceEiF2stXgVMlgVyfeXqlPsG6qTr0g7o8gcFIRl+uA=; b=ODsNcJ6cwJQNut
	Xhmqsxt+UyMIywTJZ+xwa77TpDL8sR4VsAL9YnLrDvtWMuIx8EWQNAgkHsQFPhylK8QlGgvg514pe
	F9yFd6S+7W7XXHaWiXInyAwc1XbYwuxabf76o+x9lCiQGt+cuLhRN1a0afMRxEZ8gCeDJMtsJ5fxX
	9aeTAwAvjgePgJoQ0Lly5XFva9LlDXv06AE4OE9Hj7jazvE4c358a4LmXKZrsx2dgHA+Zt0EMp36i
	YdMVY42F+EN7I0zFzfrRnjN5g9tVJabBOOh4BtqgUrC7nDbILgnlmHTOZ+3u5+hddwTlh4x0JeNae
	MKhmVDvIg5xLXqvVZjMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbSUw-0004es-36; Wed, 20 May 2020 17:27:18 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbSUt-0004eU-VR
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 17:27:17 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KHLmlw057334;
 Wed, 20 May 2020 17:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=8E10J9hyMeSWQhnzgnLeIdPpQQ8bIsX6JlzvTTdcxkY=;
 b=wT/MbRNNtw/kkvehr5QzzEVLr2YZOw8D34nsR43XiDanl1UPhLkn3Zt8SeVrzIZxOWGE
 k/BwE/mve5sZJi2hKXlK53NonKI8O1ZhLO+OU64WMIeGTfl0V9nlnX97LIYrcQ90Squ2
 Sx/VgvNRkI2PWr8fUV9N/SJpe9oksmRhgHCA0Q3G1nEIXABVr/eq0RI/RS3XEAJibafM
 u4GZC2sVB+EUbppZaAqUvZJVpjPXNZIQOFvmWZL/sAn+DnpvInHyPS6EBa8WXP0FzbZa
 lKItjfYySNdTQpk3cozyoUf2XQlT+wCpoaU7y+NF8Kii79zfJTmjcU7m0fK/+e5KuZm9 QQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 31284m4dnc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 May 2020 17:26:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KHN9mi180259;
 Wed, 20 May 2020 17:24:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 312t387gg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2020 17:24:43 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04KHOf9B027223;
 Wed, 20 May 2020 17:24:41 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 20 May 2020 10:24:41 -0700
Date: Wed, 20 May 2020 20:24:33 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH resend] scsi: lpfc: Fix a use after free in
 lpfc_nvme_unsol_ls_handler()
Message-ID: <20200520172433.GD30374@kadam>
References: <yq1y2purqt1.fsf@oracle.com> <20200515101903.GJ3041@kadam>
 <20200520165557.GA9700@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200520165557.GA9700@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=968
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005200140
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_102716_103491_628AD64E 
X-CRM114-Status: GOOD (  11.93  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Dick Kennedy <dick.kennedy@broadcom.com>,
 linux-scsi@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, kernel-janitors@vger.kernel.org,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 20, 2020 at 09:55:57AM -0700, Christoph Hellwig wrote:
> James, can you review this patch?

He already reviewed it in a different thread.  I copied his R-b tag.

regards,
dan carpenter

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
