Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DC9C369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 16:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u0rNpE262U3XB31JCWZzLp562dn5gNfdSqt4+Tx/wcs=; b=jWACjWYGmPt95q0mQAeA+HpSo0
	dHLMEIrlIEayoLPVDrg3jCR5YvL5rf3G4gAlrSNSZHh97ihbTURJLRc0wF0gVuBTkxo4HpzXhixgD
	FyDoWDAH93XQ5I1sjig0tYEW1i57IF16ZkWsMUJMmJQHhZCIajg4TSmeh+zbuW0eSqnp1g43GUrKa
	lur/tgs8n2EBRpknXz9TFvxxBgpPJSz0Xd6rZC0OEM1CtGNsqnDqdpIoXXMalSgfGqtDvCeLYTJlj
	PP0ai8DQSyhQVY2/WXlW90lOgC8Hdbq491hWtzRBKWsCb8Ihz8HEqZ9jhpY6F8JKTDDzCLFtpLykB
	xf+dGr0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Lsu-00000000Cwx-0DiM;
	Fri, 25 Apr 2025 16:26:40 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8KJH-0000000HTqH-1SK3
	for linux-nvme@bombadil.infradead.org;
	Fri, 25 Apr 2025 14:45:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u0rNpE262U3XB31JCWZzLp562dn5gNfdSqt4+Tx/wcs=; b=pGuXgLIMvlkXtcL0hZVRq7qPSt
	FH9s0zV8z0yXD5eawzaqy33Ylk+YXm6fgJcrBVQVPUwjj/VPrPtk8sbQYGUprkip+SVTr3PsQwRZv
	bqpMI14eexYpNZiJz5/2u+lbfYc62rXBCem18WBMN0FAwsKLi8EvgNW7VWnz5asXZvy1mgYaN8FZ9
	jzsjQOZYtpj8NZ8IBb/Lgat965NHgo5rM4c5qduQL/ebDLp2qUkWJ62k5oad8NKVBz15PSMOrSyL/
	xLVRqSy4BKL+K5sSgJyOyQLTeXZyvc3S+hMfJzZhzFnCG6oKDGr44Kh9SrpfFMc4WesOIeKuvBbZZ
	UJYI0+Hg==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u8KJE-0000000C5NB-1Xuy
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 14:45:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 55A3C68B05; Fri, 25 Apr 2025 16:45:40 +0200 (CEST)
Date: Fri, 25 Apr 2025 16:45:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
	jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
	gjoyce@ibm.com
Subject: Re: [RFC PATCHv2 2/3] nvme: introduce multipath_head_always module
 param
Message-ID: <20250425144540.GB12179@lst.de>
References: <20250425103319.1185884-1-nilay@linux.ibm.com> <20250425103319.1185884-3-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425103319.1185884-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_154544_768273_2B382C0D 
X-CRM114-Status: GOOD (  12.95  )
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

On Fri, Apr 25, 2025 at 04:03:09PM +0530, Nilay Shroff wrote:
> +static int multipath_param_set(const char *val, const struct kernel_param *kp)
> +{
> +	int ret;
> +
> +	ret = param_set_bool(val, kp);
> +	if (ret)
> +		return ret;
> +
> +	if (multipath_head_always && !*(bool *)kp->arg) {
> +		pr_err("Can't disable multipath when multipath_head_always is configured.\n");
> +		*(bool *)kp->arg = true;

This reads much nicer if you add a local bool * variable and avoid
all the casting, i.e.

	bool *arg = kp->arg;

	...

	if (multipath_head_always && !*kp->arg) {
		pr_err("Can't disable multipath when multipath_head_always is configured.\n");
		*arg = true;

> +static int multipath_head_always_set(const char *val,
> +		const struct kernel_param *kp)
> +{
> +	int ret;
> +
> +	ret = param_set_bool(val, kp);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (*(bool *)kp->arg)
> +		multipath = true;

Same here.


