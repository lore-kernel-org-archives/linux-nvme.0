Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF3FC4828D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 19:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T0OuNGLRF05OKJz38bFXjramee4jIHZcWQFvCNYxaZc=; b=GnxY3q8tUer+jRDRb7J/S3Tqfd
	uQLcAYSqI+n5Q7SgHzZI0i1QyPP6uu+VYJyDyebfcyX/Rkp55m+2CR2UHwQUQRHi61GqbcYfiUpz+
	elbCrhcJ1EuLE5g6vhhQcRFXTAR4jXA5kRpElBd67//H5L5d6XXOGrz1jTaMEJS+2HKATF6mwLRDz
	Z7pPiPVVFj2LA5m22pTJt2kW3hRosjQUYzD+Tu/xwNITgQBq+cBShbIDCsWifquO854blc/NqOCO3
	Z5JvPoKj84JpCVMiYo7fzev4sh345kQ6naMn6uhLmHc26EqvoSux3fopc9BHjeGjcjmNfAQr6cG26
	cyK/HCoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXR1y-00000008fkY-4B8H;
	Tue, 06 Feb 2024 19:22:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXR1w-00000008fkA-15At
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 19:22:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5A7FD61628;
	Tue,  6 Feb 2024 19:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5B3C433F1;
	Tue,  6 Feb 2024 19:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707247371;
	bh=jVV0CP0FliUSGdBrGlooYVmXbC4mj/PMikc4Dao6qR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqpYUSnfgzky2tauWjCiKs2wtAODdZJvwiEBQpORZgUg5vznECJbsAZAV8hilPOxb
	 lo4a6Zs55r5Y4bUcn1gImPQSrSfWIAaSpFOORHiP/Qlg080Yc4xyj77oXsnNz6o/Xt
	 4sWG0pTxDBFPWqE7Vj8ldNl4TxF9iOOq8CTiJluiSGwd3HhVAejfM4r+GTPdQEN1Zc
	 8MVqWMWrPmFsKj2hOSXOtluEQnY/bheiZOqrACjh+WgHUeFr7L8adHJie08/2tjTLD
	 E9EI9fBwrqP6IB51z9p5XuIac1/q2mt3GRT94yxMii7nq1OC1a+vVzB6Bqm2VLE95o
	 XVO+/oqp9t1vg==
Date: Tue, 6 Feb 2024 11:22:49 -0800
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/12] nvmet-fc: use RCU list iterator for assoc_list
Message-ID: <ZcKHCXtXWVCdi9Ae@kbusch-mbp.mynextlight.net>
References: <20240131085112.21668-1-dwagner@suse.de>
 <20240131085112.21668-13-dwagner@suse.de>
 <b19e0b0f-6b1c-4126-931b-d7b0d01fb3da@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b19e0b0f-6b1c-4126-931b-d7b0d01fb3da@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_112252_360158_65193BDD 
X-CRM114-Status: GOOD (  11.89  )
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

On Tue, Feb 06, 2024 at 02:51:24PM +0900, Hannes Reinecke wrote:
> On 1/31/24 16:51, Daniel Wagner wrote:
> > +		rcu_read_lock();
> > +		if (!nvmet_fc_assoc_exits(tgtport, ran)) {
> >   			assoc->association_id = ran;
> >   			list_add_tail_rcu(&assoc->a_list, &tgtport->assoc_list);
> > +			done = true;
> >   		}
> > +		rcu_read_unlock();
> >   		spin_unlock_irqrestore(&tgtport->lock, flags);
> 
> Odd. You already take the tgtport lock, so there really is no point in using
> rcu_read_lock() here.

That's a interesting point, but I think it's harmless since there's no
rcu sync within the read section.

  https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html#Guaranteed%20Read-to-Write%20Upgrade

That said, the rcu_read_lock() seems like it should be moved to
nvmet_fc_assoc_exits() since that's the only part reading rcu protected
structures.

