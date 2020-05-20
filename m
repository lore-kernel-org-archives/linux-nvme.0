Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F90C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:48:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D453020708
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IkqB6Hcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D453020708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1Kaf1M3r6em2LsPC2NEARENsl2J+WNahsiO7/fUwPgw=; b=IkqB6HcfY/WGeY
	b5pqYW3ItBtcJSPgM1+nHpicNNnETPtSc3ka/2yc/pa4nfZQSaxOgRuEGTLqmQv62skHCPQFMj7By
	8RQB+FlvSBWqcVjz6QX3t9+QnCJ9X0KmzdBV9WTnc9qtOtgxMr0aiekuK/DM/Y/IGnpyfFVWG2quH
	zlcfzZa+fevZ8vaNfFFK78ZLTUeWUxzI7dYmjTXlOdARXv6L1ltjQ5NMJZLSU08FmMw52Ulj/gli0
	CD1aIvmLgh6KMYPBLSF6aS+QI/RwehJiGEBPdSmQLChpNP538VikxCv6ZsItW36TrCP12yYjXvKPy
	3XUnLuk3eow74rhaktJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbSoz-0003TR-MU; Wed, 20 May 2020 17:48:01 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jbSoy-0003T7-LL; Wed, 20 May 2020 17:48:00 +0000
Date: Wed, 20 May 2020 10:48:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH resend] scsi: lpfc: Fix a use after free in
 lpfc_nvme_unsol_ls_handler()
Message-ID: <20200520174800.GA13253@infradead.org>
References: <yq1y2purqt1.fsf@oracle.com> <20200515101903.GJ3041@kadam>
 <20200520165557.GA9700@infradead.org>
 <20200520172433.GD30374@kadam>
 <20200520172844.GA21006@infradead.org>
 <yq1y2pmtsv7.fsf@ca-mkp.ca.oracle.com>
 <20200520173752.GA13546@infradead.org>
 <yq1sgfutsjd.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <yq1sgfutsjd.fsf@ca-mkp.ca.oracle.com>
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
 linux-scsi@vger.kernel.org, "James E.J. Bottomley" <jejb@linux.ibm.com>,
 kernel-janitors@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 20, 2020 at 01:39:55PM -0400, Martin K. Petersen wrote:
> 
> Christoph,
> 
> > I'll pick it up.  Can you give me an ACK for it to show Jens you are
> > ok with that?
> 
> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

Thanks,

applied to nvme-5.8.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
