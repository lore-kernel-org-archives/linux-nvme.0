Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAF9C7619A
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Apr 2023 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/h4riIgDWBKwpeYRfLAjdtpUtw8FEeOuIot7+9SJR7s=; b=t2DZxsrIQzR6SFkwMH/AEPNU0p
	ASny/MpQnrQJPuN14U86sjMJF9p9oCb6Behj0nyfKVM08jHwAAgK4KURp2bQjCEEnyFaMr8+Jm2wQ
	pp9Wr9RCBsB4Jxc8346cXh1b2S/UxWDr9lINpKcOZKT+tk5KtFUXosNE9o8Orpc8YcM7dKCBqnDCj
	gD5Bo8O9ZXytIEXmGn891R6yAdeCYTYi3GJfnuaFdCkSwcW+dTPGUljnxxiJWEv2U5K5BfsIndSpT
	Rnh3J0lcS9XPtpDstWFADAoF6JO9FtBo34MnnC3Jv/OvmB1u819fNhij551pjD96J045LBgcGbCi/
	zP40l2Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pk4jt-004myF-0P;
	Wed, 05 Apr 2023 15:07:57 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pk4jr-004mwk-0y;
	Wed, 05 Apr 2023 15:07:55 +0000
Date: Wed, 5 Apr 2023 08:07:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: alan.adamson@oracle.com
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, hch@lst.de
Subject: Re: [RFC v3 1/1] nvme: add passthrough error logging opt-in
Message-ID: <ZC2OyyPMeu8d06th@infradead.org>
References: <20230331221823.2806192-1-alan.adamson@oracle.com>
 <20230331221823.2806192-2-alan.adamson@oracle.com>
 <40dba1f3-8307-ca1a-ad6f-c80df87e0344@grimberg.me>
 <ca72677d-932d-29f6-5260-0b0d05fd6584@oracle.com>
 <132431e1-6c77-4e4d-1d48-fbb0bd4dc5b6@grimberg.me>
 <935faecc-e000-3d7a-71ed-7517b1f4c299@oracle.com>
 <588e5542-9076-d1fe-c1cf-ba60ef3dd1d5@grimberg.me>
 <c1aa9b1b-5a10-8dcb-9a9a-fce1ff8a5097@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1aa9b1b-5a10-8dcb-9a9a-fce1ff8a5097@oracle.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Apr 04, 2023 at 09:20:40AM -0700, alan.adamson@oracle.com wrote:
> For namespace errors (read, write, etc), passthrough initiated or not,
> shouldn't they always be logged?

We could start with that.  If we see complaints we can add the
per-namespace attribute.

