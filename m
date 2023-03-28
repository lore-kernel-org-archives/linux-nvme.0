Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911C0C76195
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 00:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cIepwOHBgwv0tyosBeIQQ6m3Xi3f46TVUufbYg0gJOI=; b=hnpU++ivH+3edLMpRD9Wg0N0av
	F06v1sZdPwdM9RTbsUXIzvt306GTkVc577QjCkGa6W8b4iXrwh3opntg4nXLGJ1AGcnJ8JmZt4TGd
	FMoO127kDnPtuKNs2kTxlMr+mM2YNB99XbRRdbpjTKm2rJIZ/l9Bwy2XtaHs7eVdHNYEYNrcU4JI0
	EuL5h+ah6Rp2ij0d4Ubg9GDq0/RJj5kKuGkcgFMumvQ53LFkzgYbUxyeK7wCmkvvIIMEQBfmtYXNl
	JMv83lLRStRwKcuX/foxRMxXv4RblxI2dh3sNLbJb9zwKBBhulOiRIK4fZYdgi1ieCzPOIBQD+RHf
	aZahXaDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgxdP-00CkU5-0t;
	Tue, 28 Mar 2023 00:56:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgxdM-00CkTQ-1l
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 00:56:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DAE4268AA6; Tue, 28 Mar 2023 02:56:17 +0200 (CEST)
Date: Tue, 28 Mar 2023 02:56:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, p.raghav@samsung.com, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [RFC v2 1/3] nvme: move fault injector to nvme-debugfs.c
Message-ID: <20230328005617.GB21497@lst.de>
References: <20230323230316.2914077-1-alan.adamson@oracle.com> <20230323230316.2914077-2-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323230316.2914077-2-alan.adamson@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_175620_727000_045589A5 
X-CRM114-Status: GOOD (  12.90  )
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

On Thu, Mar 23, 2023 at 04:03:14PM -0700, Alan Adamson wrote:
> Move the nvme fault injector code associated with debugfs into
> nvme-debugfs.c (new file) so all nvme debugfs associated can
> reside in a common place.
> 
> CONFIG_NVME_FAULT_INJECTION_DEBUG_FS needs to be enabled to
> be able to use fault injection.

It feels a bit pointless to me to have a separate file for what
even with the next patch is way under 100 lines of code.

Keith, Sagi, any opinion?

