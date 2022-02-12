Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47432C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Feb 2022 06:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BSxTTSuJCPzNLp1nhK1TzG94P4swssSa4brDzIjNLrg=; b=lK4iyhHI+3n9vu8B/tV280rxTS
	ZXBFWm1ByeE6rphOvrB3pEMF+3zqGdYkbzsu0YYZmCKXl+NwU0OwGMLsms/7vGW9kpQN0eovc/Bem
	UFXPkyrzdqgxMOmUUbHeXe4nMxJcTFMa4/3DeB+sMr9L6LXzwSm++TbZ8hT5HQ/f4VdB8gGqK1uC8
	orS966vALR2ZGE4rmOmfGzBPgdvf0wStLsfwDlPW7vAeUqOCPC8QEbUDoJsuLKALHMLgq9eHm9Z2u
	Q7clueQPrWWZNwUNm6h0YdexfbN2PyKYPWAbrRjFcjnjcOsOvG3avkBOY3nTmjvaxEFvahZ4X9Xl6
	eh0M15Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIlzO-009V6i-Ug; Sat, 12 Feb 2022 06:34:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIlzL-009V61-Qw
 for linux-nvme@lists.infradead.org; Sat, 12 Feb 2022 06:34:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3803D68AFE; Sat, 12 Feb 2022 07:34:23 +0100 (CET)
Date: Sat, 12 Feb 2022 07:34:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Uday Shankar <ushankar@purestorage.com>
Cc: linux-nvme@lists.infradead.org,
 Prabhath Sajeepa <psajeepa@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Native multipath across multiple subsystem NQNs
Message-ID: <20220212063422.GA16561@lst.de>
References: <20220211220714.GA370236@dev-ushankar.dev.purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211220714.GA370236@dev-ushankar.dev.purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220211_223432_042801_9B4DD80B 
X-CRM114-Status: UNSURE (   9.02  )
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

The answer is neither.  The fact that NVMe with ANA required namespaces
to be be attached to the same subsystem is good and important.
TPE 4034 is retrograde and completely broken in this respect and should
have never been ratifier.  Please fix your storage system to export
virtual subsystems like everyone else and don't break the nice NVMe
architecture.

