Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5F3C49EA1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Aug 2024 02:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ya0pAfJGG4q05qkQEcn+UVZpUgjhqxx51q/5N+xPXw=; b=z/8Ic8LClBuvVAidGSGAkCMIIV
	PobIkI7DSeX5ew+7XPNxLFHPXkBM0nb7i3KVjxlzUe2W5VhQdRlFQ547brchI/QG73nucJZYgz1F4
	vUNKi1CIq+cv418cnsNyO/7CQfIbgMXfBvQ5WUZzBqaPioFunSNDfCk6D/RVIdyBi+BqVZ0fVzKfa
	qAmEWw4HbqfZeVvGWm41k0MPcCE1pKsJ24WCNnTwuKkyeYfY2+bIPVjuIvonGxRSiNqMp8eaHP25N
	LlAWzC+lGbUL+CMKz3RXXlolA4qdT3f1efQf+5MGijMLh1mtH1d+SyozKKe+PH6yKbt1u9QgbKk8R
	81Xtl4LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbWH6-00000003bqD-2QMH;
	Wed, 07 Aug 2024 02:19:40 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbWH2-00000003bpd-3mwF
	for linux-nvme@lists.infradead.org;
	Wed, 07 Aug 2024 02:19:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id ABACACE0F93;
	Wed,  7 Aug 2024 02:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29172C32786;
	Wed,  7 Aug 2024 02:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722997173;
	bh=s/KE80zxCfrhm4TOyZIp2Z2Re7OaEk3ylzGQd5qPhUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ViH7bwtj5yAAOnht6NDorCObtiBCdjdUH8Y4jMvNqJQFf4aW/QDS4HNBbk4vPtm/b
	 NzcazOoKQxjp4x9Pk3EEUJvcbsHvAi1uU/frL1VS/Wwy0aez2C2tJZ8q2SXx9URc7Q
	 EU/TS8/mfA+A78pCtGYc36ppES/Q/qfuxajgw7igyOlIZQQMkuYkwLczbEFI42EX8P
	 QHScbmGCDeznLRr/s3JycoRi57Jcame43yY6KOECDTnEmFBeKRGeqoLWQ5uATXXbCO
	 zvYRB2jpExW81W0dI0V9I5bXUk/PU4MgDWcWf85dI2RVCG+vPzR6v4WvfvNsUqfuOu
	 /6oRVKyNKfBFQ==
Date: Tue, 6 Aug 2024 19:19:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Eric Robinson <eric.robinson@psmnv.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Disk Says It is Full But There's Nothing on It
Message-ID: <ZrLZs2ZpxcM1XcV_@kbusch-mbp>
References: <SJ0PR03MB65014AE3AD77A352D0C88855FABE2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <zsyfgzmoyvjgvywkbkgtxchpfei3pyfcaf2mzu4gltraf34ymx@vocftyxjmedn>
 <SJ0PR03MB65010C717291244293A88CAEFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <vqbcmbet5jfbhmjfuhr66om2ta5lw2octpynjdzyvk66ok47kd@oj7vhatyai3g>
 <SJ0PR03MB650188563CEBA3B2E6D2130BFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR03MB650188563CEBA3B2E6D2130BFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_191937_133478_F43947D6 
X-CRM114-Status: UNSURE (   9.28  )
X-CRM114-Notice: Please train this message.
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

On Tue, Aug 06, 2024 at 08:28:05PM +0000, Eric Robinson wrote:
> > someting bogus (nsze, ncap, nuse).
> 
> [root@store11b zpool0]# nvme id-ns /dev/nvme0n1
> NVME Identify Namespace 1:
> nsze    : 0x6fc400000
> ncap    : 0x6fc400000
> nuse    : 0x6fc400000
> nsfeat  : 0

Is this after a fresh format? If you've no data on here that you wish to
save, run something like

  # blkdiscard /dev/nvme0n1

or

  # nvme format /dev/nvme0n1 -f

and see if it changes. If it still doesn't change, then you need to
check with your vendor on the discrepency because nvme-cli is just the
messenger and faithfully shows what the device reports.

In my experience, about half of nvme devices always report nuse == nsze.
LBA allocation tracking is an optional feature that many devices don't
do, but since you apparently have the exact same model and firmware that
shows it implementing this option, that's just weird.

