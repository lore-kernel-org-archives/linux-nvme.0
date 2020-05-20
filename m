Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACCCC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 18:02:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C74204EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 18:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tPvy3nwX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WxpKNf6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C74204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IDXXzL3LXb8foG3XncrDE1bzL/mMupn4B7kNDx1fDKk=; b=tPvy3nwXufIVjL
	h8rSBW8G+7yC2CnfIQPyKoecEwrW6bsMjb7ZG0pABDozgH0nwm+1pzJrEF6n/9QmFKYEr6aLHN8gk
	rn6TgNEnh09PtqvR2yPqh22ussQ5vARg/FYx9RG1+Jtu6L6XTwP3/OFRtEQYfVw/JEnDhvWX86/yd
	NICgy69WayBJAa6JtG+ocuI4KSOyLNBOXRRKXisl0mzrWG6AstXWZTZE+pXUzd4eJ+WvJVwVAyJC+
	cP4Q+KGp6p+BUmH/0H6pGB4dr45R0VDTBaS+Da3ANRgLJ78HLPvku9U7mcv5C96BetxZFiJTSOVnz
	i0EdSnWvNtjOImGiRF3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbT2m-0007OT-Mv; Wed, 20 May 2020 18:02:16 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbT2j-0007Ns-Hq
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 18:02:15 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KHvZ4s147937;
 Wed, 20 May 2020 18:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=x0q5aO3BPnhWdWRBIqTYx6twaVymK8ux5mLrRro0/Zo=;
 b=WxpKNf6O+fw2d9H7Qlse3rZ669bgEfW3n6/Xm+rTEacB8PbBOUfrVWrqrHdHr+hiA6TV
 J8/ARmhVxuKIQh5yGoN3n+pfqL88HVCRA+XsOUuR9239h7QWx2kvlB2Iwf9tPjXmjnTq
 p1WNmGeu8n+fEGOXw0fV4I+Vh56R9FhAYm1N6hoN/ROISu7upCLETTnu4kX8QF6r52bQ
 gVzH5J8gAHymgGfcIM2ZfbsZZws9p5USEQ4po9wJS1BKOG6RJpqEGU6fhCFmULM6CKk6
 ny68E3/aXHl88ArPk9gGzXBKEsjpi34oWXqt3qsbBDAPGnbIy7kVVqosxX5bTJ7GjW+W aA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 3127krcmj2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 May 2020 18:02:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KHr8Y7098827;
 Wed, 20 May 2020 18:02:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 312t38angy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2020 18:02:01 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04KI1x8K003262;
 Wed, 20 May 2020 18:02:00 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 20 May 2020 11:01:59 -0700
Date: Wed, 20 May 2020 21:01:51 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH resend] scsi: lpfc: Fix a use after free in
 lpfc_nvme_unsol_ls_handler()
Message-ID: <20200520180151.GE30374@kadam>
References: <yq1y2purqt1.fsf@oracle.com> <20200515101903.GJ3041@kadam>
 <20200520165557.GA9700@infradead.org>
 <20200520172433.GD30374@kadam>
 <20200520172844.GA21006@infradead.org>
 <yq1y2pmtsv7.fsf@ca-mkp.ca.oracle.com>
 <20200520173752.GA13546@infradead.org>
 <yq1sgfutsjd.fsf@ca-mkp.ca.oracle.com>
 <20200520174800.GA13253@infradead.org>
 <4693662b-60de-388e-d67f-722eabbba475@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4693662b-60de-388e-d67f-722eabbba475@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200145
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_110213_774654_0FD19C33 
X-CRM114-Status: GOOD (  14.76  )
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
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, kernel-janitors@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 20, 2020 at 10:51:48AM -0700, James Smart wrote:
> On 5/20/2020 10:48 AM, Christoph Hellwig wrote:
> > On Wed, May 20, 2020 at 01:39:55PM -0400, Martin K. Petersen wrote:
> > > Christoph,
> > > 
> > > > I'll pick it up.  Can you give me an ACK for it to show Jens you are
> > > > ok with that?
> > > Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
> > Thanks,
> > 
> > applied to nvme-5.8.
> 
> Guess you didn't see Dan's response - we had replied, and Dick rejected it.
> Dick has created a new patch that I'll be posting shortly.

Gar....  I'm sorry I have two mail boxes, one for kernel-janitors and
one for my own email address.  I guess his email never made it to the
lists.  I did get it on my other email box though.

regards,
dan carpenter


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
