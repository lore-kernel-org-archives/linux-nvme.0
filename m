Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A58CCF9FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 11:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yadvVvoqf/TF+bLEteHmzwTdzyiEEoz5fktpC8e7H/o=; b=expaIsFNAQF/yxF+YRTnu840nd
	Ht2j8i1FkaisNT9ANzgTeCi36tvMlBAoX83XXvdz2f1lk4v1pvZtH1rg/EM9dNOw2dC+BkXzKiSiq
	8kySTuwKtAyC0/Wf8RpnAtZoDplEPUQUw9h51uRZr8Cksw1AZSQcGqoFcJYmYScnVBbj8dm4ixX3M
	4ix8W1PMRAFlH1wR+/tnOlIvrJPvMsfv9emHMYC8QRImLWJ25xDGMzdxf5dhdN4NAI5NvyP3LcEm2
	kQOZIwVegjmsYI+SbVcQ1Vcl8P0hT4+ywJFg3qkEHapmlV9DG/TG+kL0IY7PRtMoE6c5JUHcSAZUA
	mHeaKQkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFt11-00000009lZE-2wdu;
	Mon, 03 Nov 2025 11:46:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFt0z-00000009lYq-42uc
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 11:46:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 58815227A87; Mon,  3 Nov 2025 12:46:22 +0100 (CET)
Date: Mon, 3 Nov 2025 12:46:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-auth: use IS_REACHABLE for
 nvme_auth_extract_key() declaration
Message-ID: <20251103114621.GB15280@lst.de>
References: <20251102031742.69984-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102031742.69984-1-ckulkarnilinux@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_034626_140954_EE43323F 
X-CRM114-Status: UNSURE (   9.98  )
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

So with Keith' latest fixes the auth code should always be built
in if either the host or target code is built in.  Did this not
work, or is this for an older branch?


