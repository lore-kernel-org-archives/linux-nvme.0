Return-Path: <SRS0=xptm=46=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3B2C1975A
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 00:38:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929672071C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 00:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aymnhJ1I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TECcM3pW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929672071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QxFDVJc941IBcscRzPP+YlshN0DvkdiEhSFfHd6em/I=; b=aymnhJ1IlDi/He
	rERO/blgKC0BTRfwOlPDO8gU7Z/ZBh5UxMMobLRt7WWjxCUbohnE6s6s2Yig3Db+ftcVn9e2Nvxh9
	pJjQ1+FquvMpGSIn1dXLzwGqLAInxaD6Ldvs1WwD0C3SbwWWUSsOvBt5E4NYQUE96CAtaSnP4Xg4f
	VWfDXqmy0MmOqUKOsr37uwMcIaAcsdmO73SUs3ZLROIAv0QOEDU5AdAZjAoKHo69OK9s4RtvoF696
	8oN+KxfWoBaBkLhj4kQCzKsktYatCWhS5wkoyIistfevZkp8lOhsf2UHKsfxvHWmgRypxTmx+0bFX
	wmEv2hTU2X8M76NI6GWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCYLe-0005t7-NT; Fri, 13 Mar 2020 00:38:46 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCYLc-0005sg-Br
 for linux-nvme@lists.infradead.org; Fri, 13 Mar 2020 00:38:45 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02D0Mwck168386;
 Fri, 13 Mar 2020 00:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=hP9mFZ8Sxu3J/EE4JbNN5uOrXQmbEtdEQRl+6NEGKTQ=;
 b=TECcM3pWqwkOo2PhaIJkxOT9Nt32xhMZdc5+LNPDjbjTlaemjskiGlzOz+C/UTPGiP59
 9AQtBEeRJS5DT+yvsSXahiWMhQxQvlRJs8TO3yOeTE2GGVCDFnT/wWVW8NroteMU8oyc
 pvWxCoXhHwBX0TRkUKB7w3o1PZyPqZYnHgUl0Fmlhyw7NsijzDcgQLTmU5mVEF7MPeLv
 n6FhxVG1Egatr43obuziFyMZ3rzc8kvZf1izZAtRCu1/V1ze5Lo6xrFvAGvcxy+Ir8H8
 no4vMo9nYigHYAtS8qCmDtSC6tg7vPHfQftLMzuNVFpDTkjgg0XGWKulCPFXgCLRNY+W Lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2yqtag98fj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 00:38:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02D0OJUY144781;
 Fri, 13 Mar 2020 00:38:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2yqta9uuut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 00:38:21 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02D0cET2003083;
 Fri, 13 Mar 2020 00:38:14 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 17:38:13 -0700
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v1] asm-generic: Provide generic {get, put}_unaligned_{l,
 b}e24()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
 <efe5daa3-8e37-101a-9203-676be33eb934@acm.org>
 <20200312162507.GF1922688@smile.fi.intel.com>
 <6d932620-3255-fbd8-7fc8-22e4b3068043@acm.org>
 <CAO+b5-rXUU9r-SrCWq2cYbBr5xFqyx4CUMb8xHZv2xYzEP6CyA@mail.gmail.com>
Date: Thu, 12 Mar 2020 20:38:10 -0400
In-Reply-To: <CAO+b5-rXUU9r-SrCWq2cYbBr5xFqyx4CUMb8xHZv2xYzEP6CyA@mail.gmail.com>
 (Bart Van Assche's message of "Thu, 12 Mar 2020 17:29:37 -0700")
Message-ID: <yq1v9n9nl71.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 adultscore=0
 mlxlogscore=623 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=687 phishscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200312_173844_489870_60CF3895 
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
Cc: linux-arch@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>,
 "linux-nvme @ lists . infradead . org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Arnd Bergmann <arnd@arndb.de>,
 Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Bart,

> Martin, can I send the second version of my patch series to you or do
> you perhaps prefer that I send it to another kernel maintainer? I'm
> considering to include the following patches:

Happy to take it.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
