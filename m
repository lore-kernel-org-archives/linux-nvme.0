Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A32CCD4F26
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 06:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pbs15Ausyq1qpfYtEbOJ6kLxWbA9FkB8Ymy6S9nhvqQ=; b=eqWDctxlWDOhAPM4zBdeeCPO++
	Uj49EDSvR91SxHU/yXBORpK+zxjBnet3TlrHm0SaeRba6cUcm/lrZE4SsB0aYhB/cAfUUG/MM/lwm
	Bz2VaLZnl3PqMU3Co5hYHjfEbH27ctBYhSMNf8KUH8MO8M5JCme4QRgDOZmfbiRCygT3vF0FROVgg
	sJUr9umFslQAZfFolG2QLagMLTomzKHPBVKWKVbvof0jSGrAdFnfO4hE7a5sM6Pkaur2sVR7Xg9wC
	oVl8BiGfu+CjBpecuGWawbd1vyxFFzvi2ohHUqmp2H/gJkw7R75tD6zCmuGAgt5/pAekZVgNOqsFx
	LdO44Ukg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0NN-0000000Acml-0EZo;
	Fri, 26 Jun 2026 06:49:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0NL-0000000AcmQ-0gHX
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 06:49:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7520E68B05; Fri, 26 Jun 2026 08:49:16 +0200 (CEST)
Date: Fri, 26 Jun 2026 08:49:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 14/17] nvme: fix Clang context analysis warning in
 rdma.c
Message-ID: <20260626064916.GC11106@lst.de>
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-15-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614131541.2017845-15-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_234919_358347_3563144F 
X-CRM114-Status: GOOD (  11.58  )
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

On Sun, Jun 14, 2026 at 06:45:29PM +0530, Nilay Shroff wrote:
> After adding Clang lock context annotations in rdma.c, Clang reports
> the following warning when context analysis is enabled:
> 
> drivers/nvme/host/rdma.c:972:24: warning: passing pointer to variable 'list' requires holding mutex 'nvme_rdma_ctrl_mutex'
> 	  [-Wthread-safety-pointer]
>   972 |         if (list_empty(&ctrl->list))
> 	  |                               ^
> 
> The warning is triggered because ctrl->list is annotated as being
> protected by nvme_rdma_ctrl_mutex, but list_empty(&ctrl->list) is
> invoked without holding that mutex.

Does switching to list_empty_careful fix this?  If not, does
list_empty_careful need annotations to make this work?


