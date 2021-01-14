Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D787C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 17:36:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6223623B52
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 17:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6223623B52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=H6xjZ9t/FdnmPggnHF72eoKPqVDcvQHheKPDPBZOivo=; b=zyR/glm6LLuLD0m+McN6mhmXM
	ZU0km+kzOk9m8DifgrkERZ+EF/HGb7ck4zfeoTUD+rQ4IHlbvOL4AZbBFbGPIFdp6hXKw71+FRq9r
	TqR5XN3783jh8Bwa0npF7gakx7Go9i01m2nyeeKF6LL2bQ6usGcOFGxWOZ45q2bjlwdLVD4COpuMO
	nZvV+ivzjYr1FTnnjAiuwJeJ5kmouuCgbSW7luQ6XKgYT+VQX2y2FC2iCArtIQMpH4QRdYhbYm9V1
	f14cuGCy7rIKPX+bK8l/3QAOEfldn9u/652RdKf3gMWq48JzlR8I7H5+qa3ODllQk4IitnPrK1GHE
	Jz1645Tgg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l06Xe-0003Tt-AA; Thu, 14 Jan 2021 17:36:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l06Xc-0003TX-17
 for linux-nvme@merlin.infradead.org; Thu, 14 Jan 2021 17:36:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=UGg+Kzjb3FyDqM1yXwG91DvOA61e3CR2q6rmErCaQGM=; b=isYY38ta7zBXqBUCciyTgXiPAY
 j8mU0cppFDMy94FvNVqgceAe60IKXxFXP6r3BPiHTKBVOvA8YQNphedKC/OqN1QZnjlpot/0awiBZ
 g21Oq6hN0fzCReg+3cwX9iLT7zTC7FfenGkzTRV3Y0shQab0peoFiLK2BrzfusExYtdlSamCgxQqf
 cS9B/69Z07jC7QnIh3xoXcYWTjH9wzwGc+xTzjXsWpk+J65AB+kVTa7TM2jIvjgRef+ANPsm6BZn4
 7k5uupZmfLI9B7JNDSvCqPnVUXsie1pp2kln+JFnYPpthfZWYfknLY+o0QnTitx40GU16+Ied+48L
 9CFb28Ow==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1l06XC-007rE5-BB; Thu, 14 Jan 2021 17:35:50 +0000
Date: Thu, 14 Jan 2021 17:35:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: fabrics connect cmd with a non-zero reserved value
Message-ID: <20210114173546.GA1872345@infradead.org>
References: <SN6PR1901MB202957C808A7D493E252D873EED00@SN6PR1901MB2029.namprd19.prod.outlook.com>
 <6e271be1-088b-5a23-0eec-23578f707c28@grimberg.me>
 <69465d48-5a63-5c49-50aa-39c4f921ed4a@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69465d48-5a63-5c49-50aa-39c4f921ed4a@grimberg.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: "Anner, Ran" <Ran.Anner@dell.com>, "Grupi, Elad" <Elad.Grupi@dell.com>,
 Frederick.Knight@netapp.com,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Engel,
 Amit" <Amit.Engel@dell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 13, 2021 at 05:10:05PM -0800, Sagi Grimberg wrote:
> OK, now I see the issue.
> 
> This appears to me this would be an issue with the spec. As the connect
> data (like any command payload) is coming in the form of an sgl.

Reserved fields in host to controller data structure may be checked,
but may also not.  So we can verify anyting we think is to bogus to
pass, but there is not requirement for the controller to check every
reserved field or bit.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
