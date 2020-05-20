Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA66C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:35:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C2A20709
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="orVnSS0l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H5gtbT8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C2A20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:
	References:Message-ID:From:Subject:To:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hahn90KEDSf/+RGLa8fO4SP4zFek4+4GlO0k8KOqSJw=; b=orVnSS0lOLnhnw
	pnKLgK5SgpHggYDA2DsLLdMMoer+j7pzIpQh2G21FPBjGrj9hhK2boTox2ElkWePWEG9uR0DwFfav
	TDqdCVZmHh8DpTeohOtajhEZzta8KX/2r5XDytQv4M4htX5New3I12xjZzz4l+bkshJUrsQaIvjDA
	6isuvQ98CSKJuT2m7t7ufvACU03x3PQhq6T10XsB8ThurjJb+21wKWU0ZRsIzyFnAztvZmgV4UPyb
	43dTgL92c6yWCfoHM8HYiJiB+oRvXW9VkkS7ZHZiE3gZGTK1jYjtFYWgE302g9q8mE2bQKWsypaZ9
	/CM809Ha9OjED/7nJcEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbSdF-0003Fy-0Y; Wed, 20 May 2020 17:35:53 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbSdB-0003F5-Uy
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 17:35:51 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KHWCaM066620;
 Wed, 20 May 2020 17:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=pV/Weg8O5vP+N+LAiNcPtl1rbBn2XFyBc5t8ofB/WUM=;
 b=H5gtbT8d0llZuhB9P7kl+Z662GFbXMeX85ihfKzc8Hu0Kkt3XNt92fyTfiQHz9ya71o2
 ApTR3JdrrnIUSP/wowoqqlpmuwXworUbxy+E/8GOqG+Ti8FPNGigQyEi84EFyHbEyIF8
 6CvmuT/X3RPqVKuhdtB1EhLnV8Jyu8tb+k5QjawA67pJ5LmHQPpWG2EtyM8bDEkSP0iR
 DwtEHvvxGMTob4jg+vO2w7gb18fEhuO/kiTXoqaNJSH+AWmBS6c9JzjFuxub1x5cFA2z
 FM3sribcNOU+HguefYviDeRALxs2y//4nZ/BFgef4OK6lFW83+D6SRWU8FLigfNhVqIu Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 31284m4f1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 May 2020 17:35:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KHXEE6028657;
 Wed, 20 May 2020 17:33:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 312t3887t9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2020 17:33:21 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04KHXFoc018563;
 Wed, 20 May 2020 17:33:15 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 20 May 2020 10:33:14 -0700
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH resend] scsi: lpfc: Fix a use after free in
 lpfc_nvme_unsol_ls_handler()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y2pmtsv7.fsf@ca-mkp.ca.oracle.com>
References: <yq1y2purqt1.fsf@oracle.com> <20200515101903.GJ3041@kadam>
 <20200520165557.GA9700@infradead.org> <20200520172433.GD30374@kadam>
 <20200520172844.GA21006@infradead.org>
Date: Wed, 20 May 2020 13:33:12 -0400
In-Reply-To: <20200520172844.GA21006@infradead.org> (Christoph Hellwig's
 message of "Wed, 20 May 2020 10:28:44 -0700")
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=860
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=1 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=884
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005200142
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_103550_088780_2468201C 
X-CRM114-Status: GOOD (  11.97  )
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
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Christoph,

> On Wed, May 20, 2020 at 08:24:33PM +0300, Dan Carpenter wrote:
>> On Wed, May 20, 2020 at 09:55:57AM -0700, Christoph Hellwig wrote:
>> > James, can you review this patch?
>> 
>> He already reviewed it in a different thread.  I copied his R-b tag.
>
> James, should this go into the nvme or scsi tree?

The offending patch is in the nvme tree so I think you should take
it. Otherwise I'll pick it up in 5.8/scsi-fixes.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
