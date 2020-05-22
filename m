Return-Path: <SRS0=OKIn=7E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EDDC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2020 13:56:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3E7221EE
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2020 13:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F03YjISs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="irMAWLTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3E7221EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:
	References:Message-ID:From:Subject:To:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wyR8AEFa7fvx1Qsk+mzHxe47Z/wPg0cUu0PyBM5bNLI=; b=F03YjISsnBog4s
	yUf7GbMp61ud+vedlS7LLBp+UFNkMBhk1dRB4xt13fsQ8iXbDm4+FNQMrPrJFiQ9RTEp4Pf8LHT87
	8KEPbDcX3DLbOPgkeA0OriNQu/kRljqgPDtpXf7q22t52Sacz6PN6QqVAKIc02Ka0wwY4MLCoKO5P
	+k4F9qF7zpM3I4x38ez0vep3u/7TjUxGgec/sy1Ed5QcwaFu+QW/roBLMmEYRojNDN8gqMg9Hokr8
	Oit1yXLaBMSmZqYUP+IHBKTaY2UdKQG7HOV500Wo22XQPxdU8FBVJCqC+0b+kuSiRfxazP7iXLR4Q
	qba2+2S1CP+7s7wHNI7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jc7qe-0002qp-5n; Fri, 22 May 2020 13:36:28 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jc7qb-0002qE-R1
 for linux-nvme@lists.infradead.org; Fri, 22 May 2020 13:36:27 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MDNNTL158770;
 Fri, 22 May 2020 13:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=q4iEMKKBFsl3YsjEDz6MJCE6wc50DDr5Q/Qc07Ys0Bw=;
 b=irMAWLTWpYWfvNou3Ds23K9HMo0JjnDqsYnnAtRuiNE1Z5GTylcuZ9H4Hs/WF0y001zK
 oHWsOjU4u2rMRS18ow0XQJEcayPC33FC03wIyIIQOnwwgMUV65lAEthAcoWmHb3R4guK
 MeGVIqpaUhzV31u2ufZcg/OZpPRR60F29so4YfCfCXFbeN4WPjG6xk8E/ECmwIRML9Wh
 4ieQsZFy9uYxiCXM5ia76mxepJJjycI3wJZBP6DK/+RTygpfBv9pcbYiES5yrOxOuXBB
 uZAkVBBzLBMqV3PkTx33D8vp1bg4U/zsMUikPW2Vpwf2/E50PEcZVEsUh4k7FLX83eFA kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 3127krntfc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 May 2020 13:36:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MDSivM174067;
 Fri, 22 May 2020 13:36:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 313gj7gghx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2020 13:36:21 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04MDaKhJ008637;
 Fri, 22 May 2020 13:36:20 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 22 May 2020 06:36:20 -0700
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: Improve io_opt limit stacking
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ftbsp06e.fsf@ca-mkp.ca.oracle.com>
References: <20200514065819.1113949-1-damien.lemoal@wdc.com>
 <BY5PR04MB6900144BD2729172EBF5DF2EE7B40@BY5PR04MB6900.namprd04.prod.outlook.com>
 <yq1lflkp0b9.fsf@ca-mkp.ca.oracle.com>
Date: Fri, 22 May 2020 09:36:18 -0400
In-Reply-To: <yq1lflkp0b9.fsf@ca-mkp.ca.oracle.com> (Martin K. Petersen's
 message of "Fri, 22 May 2020 09:28:36 -0400")
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=1 mlxlogscore=901
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=1 mlxlogscore=924 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005220110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200522_063626_016478_BBF18929 
X-CRM114-Status: GOOD (  10.52  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Mike Snitzer <snitzer@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> +	if (t->io_opt & (t->physical_block_size - 1))
>>> +		t->io_opt = lcm(t->io_opt, t->physical_block_size);
>
>> Any comment on this patch ?  Note: the patch the patch "nvme: Fix
>> io_opt limit setting" is already queued for 5.8.
>
> Setting io_opt to the physical block size is not correct.

Oh, missed the lcm(). But I'm still concerned about twiddling io_opt to
a value different than the one reported by an underlying device.

Setting io_opt to something that's less than a full stripe width in a
RAID, for instance, doesn't produce the expected result. So I think I'd
prefer not to set io_opt at all if it isn't consistent across all the
stacked devices.

Let me chew on it for a bit...

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
