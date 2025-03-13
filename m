Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E7CC28B2E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 06:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ngmbof2S9RZPBSBrnNDQb5ldQ1rp4J9dBDlRzgSfWo4=; b=JPdt18Hb6PfnFppztGw2Woeu3v
	FGBzTmbawvdHEnPsjtt0a0rjVa/ih+T4eW/DdZzCiDLLNppDSVaF0eG7QIvarT0fhQLRjB2FCwtHX
	Dfp9VbEgjowenOvtCmgk6t727yhnEQEYBh5yb8UEygcp1+Zp5uwsNNrmXxr6bZCg4AGPzDtcjzjub
	PmE54k8kekc3EdpiLMyO1uZFzB6iskCKHTlXdseF0VQuW76JF4R0tUxppuuvXV6bJvDf2ruaDOB/A
	qXdJcKP5jizCmkuMzLXCext1Mw4gTK9JsQFeYQzllFTyaKQLIuF5iensSkPu91IonmkBm9YxYYdTS
	AanAMvFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tscB0-0000000AEPG-2fVB;
	Thu, 13 Mar 2025 06:36:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tscAy-0000000AEOr-2pW6
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 06:36:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 86F3968D07; Thu, 13 Mar 2025 07:36:12 +0100 (CET)
Date: Thu, 13 Mar 2025 07:36:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: chaitanyak@nvidia.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	joao.m.martins@oracle.com, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, kwankhede@nvidia.com,
	alex.williamson@redhat.com, mlevitsk@redhat.com
Subject: Re: [PATCH RFC 01/11] nvmet: Remove duplicate uuid_copy
Message-ID: <20250313063612.GA9967@lst.de>
References: <20250313052222.178524-1-michael.christie@oracle.com> <20250313052222.178524-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313052222.178524-2-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_233616_918392_733D3D9A 
X-CRM114-Status: GOOD (  10.15  )
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

On Thu, Mar 13, 2025 at 12:18:02AM -0500, Mike Christie wrote:
> We do uuid_copy twice in nvmet_alloc_ctrl so this patch deletes one
> of the calls.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you send this separately for inclusion?


