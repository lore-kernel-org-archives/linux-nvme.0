Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E89C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 21:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w46DC8YN9duxBwG2YgIa6Ci61zEPZOW8KSibI4u+8p8=; b=MILWdruqxdhLbpbwf04MZSEc9t
	IJIjN4Pt+RRIzrGpPVe5RUl17TwouXin2/4Is+JZS8lRSwtXGdZySEIhuiupzkgxWBd5Yc0eyUaEh
	Mg+fsogH/fLTcmdzw5HAUVwG8mvrLi1ykWZ8LqoeS3fmDY784CvrVGvi2pZW17U0OdvsSoSexa8Wy
	opViYMLQW62DZYt5f2VcjufBNOzamcUCNf4GIg58LcCRUTK7T1rorTm0gNGUxU/ap7pb3JOrUXD2R
	zj5CYwaWPjR/ZkWvJ4lNnaTsKEAfH37xsad6g6mNdG5uCMj6NIc6PUY6OpclSjztGKhO/T/47AKhr
	n6TAOVQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKmRF-0093yO-3B;
	Tue, 02 Jan 2024 21:36:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKmRB-0093w7-2o
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 21:36:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 29E1560FC7;
	Tue,  2 Jan 2024 21:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C407C433C7;
	Tue,  2 Jan 2024 21:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704231396;
	bh=Y/FAnlTeyM2Xak6UDGcz83Fgsz/8jnzDWhO+CSAZJSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFKJmZHffvOTMBvfWzMx6DhC/Ec8ApPnJf2M1zKEPj3tuDpb345FETIwvSAealVqG
	 szM2gg7njcYaqhUllG6sYu+1Ci+omh24VYjRASjdGMjtuL4HTDmy9IW2N0Y1dlj0sT
	 UxL3S/Htekcy342qd13ktMAywvATxNkUpQBzw8WDs581mjkvUMFWbXM+JBLHSkaFCg
	 ePtqvQodPzj3cHALtuON1Xot4byYdqTfybksOu5vqG/ox2gJN5sBmSlgRDMxhBV5pF
	 xsmdmRHBcwzsVnGH/MQLiegW+s3wIjpcINOjNN4qJoYLbzZlqCEI9MtdK1gSxiAeOu
	 4gELKKKomBozw==
Date: Tue, 2 Jan 2024 14:36:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: nvme discard limits fix and tidy ups
Message-ID: <ZZSB4vVNLBicDhBC@kbusch-mbp.dhcp.thefacebook.com>
References: <20231226085844.203878-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226085844.203878-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_133638_019598_BA408774 
X-CRM114-Status: GOOD (  10.48  )
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

On Tue, Dec 26, 2023 at 08:58:40AM +0000, Christoph Hellwig wrote:
> Hi all,
> 
> this series contains a fix that makes sure that the discard limits
> are properly calculated based on the LBA size for each namespaces,
> and also tidies up some code around that.

Applied to nvme-6.8.

