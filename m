Return-Path: <SRS0=DVYa=NY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782A6C83028
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Sep 2021 17:36:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411FD610E7
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Sep 2021 17:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 411FD610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8sT6FqIkLB1RU17P3u7RTyCUmlR+admuhOSYGXEingA=; b=cvSu8et4kAvesu
	elMFf/sgYNh1uY56aMux7redYJjZiF+pge0ZYUHmE5Di8cRkejLPBHe2CDc+O2nfVnSEhpRnJ95J5
	0NiOT8sEfNOkJRd0ahkpLQrWfN1mhribEL8qKjkEg7M9Ustm6UYT06TNN8zSIDYG4lOAOEzVmOODV
	TJabcwDY1yO+HnMNHdPG5L2dx433N5ucyrII7qn7OqxARy2Ma8mXi00dQM93BsEaF/Byy34Uz6Pvl
	LAgbXzsBy7iQV2H8mtqAja4fSuEnCRX51n+wY/xUyZqTPt13kWcbRvWJM2SXyhQtYJ4Iq9Y50dLtb
	RSHSrTSjF7oyqqjuKh/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLqd6-00A80t-QG; Thu, 02 Sep 2021 17:36:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLqcw-00A7zj-7s
 for linux-nvme@lists.infradead.org; Thu, 02 Sep 2021 17:35:51 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16633610E7;
 Thu,  2 Sep 2021 17:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630604149;
 bh=nHZYj+5cKO4dz22eeEF5DFqyo0U/vnW3XpiTjjcEfSA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S2zVnhySV2YM0YJK/EfFsRt2uj4xEAQ1tw1fy6X+bSA6OUnSmhqQgWZVlZnf5WDdz
 5iIEACtxwnAzOTeUd1AOUIwHmxPfetrzoxt8yJB17XqHVVteM6Y6EriuiKPzZleBGu
 fNJ2ptSW8ELZbGsO31wN+aAqtEWNgoXQXwl2SOUre4plHzgrDr61NgRuwwpYRFYq2q
 7zoYWa/7rd7DxnKC0PnOjk2NpKoShiLkOodqYNKOarIpPiDfMfrTaht2eBtSRENYrb
 yGkR2ltqfb7zCH67fTQf/W4bs1jLPHZrmp+ne27fapYNZaSNFF08Q7XFXAU1pqyJCO
 3S8cbWymnR7wg==
Date: Thu, 2 Sep 2021 10:35:46 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Belanger, Martin" <Martin.Belanger@dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Problem cloning git://git.infradead.org/nvme.git
Message-ID: <20210902173546.GA200741@dhcp-10-100-145-180.wdc.com>
References: <SJ0PR19MB454438986DE447DAE1B5384EF2CE9@SJ0PR19MB4544.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SJ0PR19MB454438986DE447DAE1B5384EF2CE9@SJ0PR19MB4544.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210902_103550_333968_82DEFDBD 
X-CRM114-Status: GOOD (  12.76  )
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

On Thu, Sep 02, 2021 at 05:26:47PM +0000, Belanger, Martin wrote:
> I've been cloning git://git.infradead.org/nvme.git on different systems without any problems. However, there is one system where "git clone git://git.infradead.org/nvme.git" doesn't work. It simply times out. I suspect a protocol issue because I'm able to clone other repos using the https protocol (e.g. git clone https://github.com/torvalds/linux.git).
> 
> I have two questions:
> 1) Any suggestions as to what might be the issue?

If cloning is successful from other systems using the 'git://' url,
that probably means you need to configure GIT_PROXY_COMMAND for the one
that isn't successful (I do not have a readily available example to
share).

> 2) Is it possible to clone git://git.infradead.org/nvme.git using the https protocol? What's the URL?

https cloning is not provided on infradead.
 
> Internal Use - Confidential

You really should remove this footer from public mailing list posts.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
