Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D40C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 19:57:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF1561131
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 19:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF1561131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s2BkSXfKh6A3WLnVwqKn2gkDpCT8yYSzFh01AtVIAEs=; b=PoMFbKWW+ZuUzJKH4ilHhWE0c
	pkNB28pW4dvvWtWK0ADa3QEJQBItqSYDiyPeiGKe8/8NqqiScYKHVk13dxxSC6EJdcqjN1sL35fzM
	y9i0ndnkepRh0YQu6KY7PowDL6Y2CQzBP1Mhx8txaNlz9QsO67oLaEd7l3+WxXpw/LZxfEhm2fziN
	e4nv6EI67soMDHWLwxRK3PfftAYjjbQfUEDug7eQ8J8xDf1V3go0QTx+YtAiuny7QI2F0AcSWVgkI
	PcnOek4e0TkvkMH2V6+7Kpg79sfKkXQkTxPAdg4vWnRmfKZ72tJhsKxiyOuZ4GoonRUdFAJWCgFQC
	CLgLRehbA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWlct-00DdhA-NZ; Wed, 14 Apr 2021 19:56:39 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWlcp-00DdgO-5c
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 19:56:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=pcFhRr5GzIlQsz6deU+cHCgM9kUmAQdSAcUp7aVQz2Q=; b=gtNYCKp90ln0U1lRsibv7YjzWe
 NQBZFX1elo3YRQwv77Ff1o9ANl4Xm1TNTYlD5nHrRxk1J6+KHshGP+dWdZ/UpI0kUSbNGXP7eDVmI
 3hsz//tnkHtmUpcOPy3Uvu/EKoL0qDkpbvIf+ctpwt5eD9OlrUxt6AlXj+OfTqjSpPImBPSbLXtPT
 CXM/TDm2eOIpalOWlNh3FVKmdfMIDPv6Eo72iG3I2JuYe8GeddMcx5B6Zf1YG2U7ExNZopXu+EpON
 bGenP33EvQqY37UGpOonhF0tvI44I9LsAvHqj2YQZD1edmZAmZF6J9i9NlBEMeT42ATYbLEym5+zc
 Z638+SNw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWlcl-0084QO-MA
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 19:56:33 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 399BF61131;
 Wed, 14 Apr 2021 19:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618430186;
 bh=LI96X0XkMCwvz1Urc3vTnyPK8ssCEaUpmo0GvnwB+ds=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jebVqtuu+ZLyMrTIl0YnQw8WuAzn9QMNzrlxgjH5qepnfMTEVGqs87Zckqnox7Cj1
 GNxsKUEcupv9Y7ML4gNN0GUNNRVaGU9ageX4Fo0JYLtDAh+mHndbdwkHPMT7iLMDJp
 p4/9f5ncM8qvz7d3JI9/1WzQNpCu6x0ce1phi0UOrHD+baI/wMGKtBahO+Iw6xY33L
 PX85wh0clo+XheQMz2twAfmjVdfls2I/PAJDupYPjF8//sHs+S7XdYkMQ6JHG2qFb7
 MvXteXnfNNGzNGjrB80iyD3Mz9g05U0PZdJOoyiJl3+GsILLFAN2PuEXsAG27y2fNY
 ofEIW/KDDri0Q==
Date: Wed, 14 Apr 2021 12:56:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Belanger, Martin" <Martin.Belanger@dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: How to submit a patch to linux-nvme
Message-ID: <20210414195624.GD2448507@dhcp-10-100-145-180.wdc.com>
References: <SJ0PR19MB45444DF2DD618E99148344DBF24E9@SJ0PR19MB4544.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SJ0PR19MB45444DF2DD618E99148344DBF24E9@SJ0PR19MB4544.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210414_125631_773215_8FCD2681 
X-CRM114-Status: GOOD (  18.25  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 14, 2021 at 07:16:42PM +0000, Belanger, Martin wrote:
> I would like to add a new functionality to the linux-nvme driver. I read the "submitting-patches" document (https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html), but I have a few questions.
> 
> The document recommends asking maintainers which tree to use. The file "linux/MAINTAINERS" shows that the tree "git://git.infradead.org/nvme.git" exists. Is that what I should use to make my changes or should I use the mainline tree "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"?

As long as your patch series is isolated to the nvme subsystem, you
should develop nvme patches against the nvme tree,
git.infradead.org/nvme.git, with the branch that targets the desired
kernel release.

Our branch naming convention is 'nvme-X.Y', where X.Y represent the
targeted kernel version (currently nvme-5.13).

New features should always be based on the newest kernel release target.
Bug fixes may target the current RC kernel if we're outside the merge
window.
 
The 'master' branch is not our development branch, so don't use that for
anything.

> It is my understanding that patches should be submitted to this email list. Is that the only thing I need to do, or should I also submit a pull request?

Don't send pull requests please. Just email the patches. There are
various tools that can facilitate the process, but 'git format-patch'
and 'git send-email' will ensure patches are sent correctly for mailing
list consumption.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
