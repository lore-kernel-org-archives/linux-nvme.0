Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF65C77B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 06:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Xzt1j6ymKpH3ZvHI7+JC4OJgTHqEU9sNQ1885pB0dw=; b=cxuEUcVXOJvwUIIVLavRgOOEAH
	F1QKpsLyUKrjqbSHyQtY8eq4BOqwH/MqmrvPEYTZ4rddgHOTnKR30mY/eb2t/xxlCzyFKB3U+ZHq1
	5jn1XA6ATUc2snLiDi4mtcpD2osTwHUta4NTfIrq0WU98+8beRU5df1OtJtHSCTgQerX5JsYMd3cb
	9JjxwZWsN2Ye8Had3XnhNsB2W7q1V8d0f1pOuksBn1v3LpocVy1/kAOjTeRxILw4eqSm45mbr58/K
	F0+rja/0uq5igQyHjZSlXQOmAK9j74A+jWogC0pLukhtTRzBw6WZrs+R/PI8FI68nv2DQE4NNnfH8
	aLY340zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJvK-00000007i2U-22UZ;
	Wed, 25 Jun 2025 06:47:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJnQ-00000007gh4-23Oh
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 06:39:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F0514227A87; Wed, 25 Jun 2025 08:39:42 +0200 (CEST)
Date: Wed, 25 Jun 2025 08:39:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: alan.adamson@oracle.com
Cc: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: fix atomic limits check
Message-ID: <20250625063942.GA9933@lst.de>
References: <20250616053627.GF1148@lst.de> <790a0419-4087-4181-b290-15db01ac1d34@oracle.com> <20250618053213.GA28614@lst.de> <9d0692b3-4d49-443f-b6f6-b13ec9a44f3b@oracle.com> <20250618171750.GA29321@lst.de> <89d34af5-6ad5-4579-8203-ac28d9432cf3@oracle.com> <20250623133309.GA27241@lst.de> <1802de7c-1f2b-4c84-9f99-a38625c3715f@oracle.com> <20250624131056.GA20362@lst.de> <9d050842-700c-4cea-a1e6-de3b3cded40b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d050842-700c-4cea-a1e6-de3b3cded40b@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_233948_667758_34F99D5F 
X-CRM114-Status: UNSURE (   8.12  )
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

Thanks.  We should only initialize awupf once per subsystem,
and the patch got this wrong.  I'm sending out a new version now.


