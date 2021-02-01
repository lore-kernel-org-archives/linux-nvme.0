Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AC9C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 18:06:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478BA64DAE
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 18:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478BA64DAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v3KbKPp+3QD+1hcNyarDApeJZOOp50rTJ8VSKaM7lfk=; b=fl5ythvcAmF0Axc727PsDN030
	bDi3r+QiWWT1dC9eI3wF9aoPEuV0owYVgBojBSkRa88NWWyc2UlHjPiOBbL7psCicir3IBNg6psM/
	P+t04cVF7NqZq+hAgirSdjwdnNHfZLMJItf91RvDyxT0MZB9NpzyfVvhwZhMJHsN1O4ce0MOeuBok
	YpS81d+uoIYNmlNG0wr5cnVxlYEIg8dilEyxgSFLx0Xeu3fhdJ3K6rMMDSTpW6vgUwvZpTeXGIxk/
	jNylNmw+RFDgEWgFaPzl43bJTEiW3HC8f3EunexDYfolLxTsM8/1h1DWybxoQV5jMF7pc3EFAevkj
	eYY1cKFAg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6dav-00020W-I2; Mon, 01 Feb 2021 18:06:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6dat-0001zw-5o
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 18:06:36 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E613064DAE;
 Mon,  1 Feb 2021 18:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612202794;
 bh=jBixFA9Yju8fU3gC8qCP8B/CoWgq7ulAIUcKuzXChRY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uWfbzSsA7GdKf5jF9OlHncmGFckbPS8A7qub8UwSUlYOd3zTkNUY3ZPmSQb+cWn/v
 KVh6ZAKdTzXaIX6pfWcqyZoARSP+txju4gA6GgHmqQkLNKF3YuiK5saeev2rbVIl5A
 hP0dF1WHnDFBya6tHnQ1Jv6DzlATNrcgQc+T3dCvgCk+IRymNFaJCQDgvLSaZzOVyT
 MnZaZMIeCwGayvR+TxkkAUr21gPL5ZAExqRlP3P5LrH+ZnndN7fsI2N0hFgfLQvv3U
 u2dDpAGHOc+JL6m2/n3vJKOYOLy2t7UBuGkYnk+38TNza+M2NAA4gWkmI6zFs+M2nU
 r8Mh/IUlDZmdQ==
Date: Mon, 1 Feb 2021 10:06:31 -0800
From: Keith Busch <kbusch@kernel.org>
To: "Belanger, Martin" <Martin.Belanger@dell.com>
Subject: Re: How to submit bugs for the nvme kernel modules?
Message-ID: <20210201180631.GB2127465@dhcp-10-100-145-180.wdc.com>
References: <SJ0PR19MB45442FC3EA568AD0D5FFFE9BF2B69@SJ0PR19MB4544.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SJ0PR19MB45442FC3EA568AD0D5FFFE9BF2B69@SJ0PR19MB4544.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_130635_318043_182E9597 
X-CRM114-Status: GOOD (  12.68  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 01, 2021 at 05:53:48PM +0000, Belanger, Martin wrote:
> Hi,
> 
> How does one submit a bug against the nvme kernel modules. I found the
> GitHub for the user space nvme utilities
> (https://github.com/linux-nvme/), but I assume that's not the right
> place to file bugs against the kernel modules (or is it?).

You can send nvme kernel bug reports to this mailing list. Some people
also use https://bugzilla.kernel.org/.

The github link you found is just for user space tools and is not used
for kernel issues.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
