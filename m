Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5D4C02197
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2025 16:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Eck/FvI5aIJbfN/KAkdWoe29wLTqYc/POosy7xkzE8=; b=wT7l/sFJntCli2ygF4jG91xNQb
	2oR1Ao6UX8hmm56qLrn93H0m7z3poYC5eQ68ZC3DiJ/WXTGiM5YOZ5VYdj4z9MrvvSV2cy/TgEssQ
	e9l+y9bDvFAwGzmFuZuHDLTPeUrtRUGUZDaWrBcFBqJxfH9VZdnoKRUSHKLiN5caZRoodaBdFQLpM
	ExZGhdrrIUkneUl1Fs7x5urllE+e0cod3+XGMb8oP9eBBcZDaMU968oHpOv4qq0zgO977kP8Zz9sC
	A0Byl90sE7gQVP3yztaRSKkArdMnjJHUleM5/kUnqLxU3qGUOlPMiqRImuZlBabdYltWzxeEWGhX3
	Strt2Y3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfi61-00000003wV9-01fO;
	Wed, 05 Feb 2025 16:17:49 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfhtL-00000003tpH-3jb0;
	Wed, 05 Feb 2025 16:04:43 +0000
Date: Wed, 5 Feb 2025 08:04:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>
Cc: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@infradead.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Meneghini <jmeneghi@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] TP4129 KATO correctoins and clarification
Message-ID: <Z6OMGweV-wUI3iVn@infradead.org>
References: <63af907d-9cdd-4956-9978-4e77389b1716@suse.de>
 <Z5yYk7vHIhMfiPz1@infradead.org>
 <527f476b-18e3-43f9-98c3-d19a25a6488a@suse.de>
 <613065bf-ad13-489e-9d57-408684e85923@flourine.local>
 <PH0PR84MB1358752FEA88D5EF0971B27E98E82@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR84MB1358752FEA88D5EF0971B27E98E82@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
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

On Fri, Jan 31, 2025 at 06:48:20PM +0000, Ballard, Curtis C (HPE Storage) wrote:
> If there are specific aspects of TP4129 that are broken, I would be interested in learning more about them and how they are broken.

Serious Curtis, we've been through this a dozen times in the TWG.
It just adds another best effort timer that is not better than the
one that already is there.  But you guys insist on papering over it,
an there is no real reason for Linux to adopt that.  (despite the pages
long John rant).


