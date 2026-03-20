Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84CA1093180
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 07:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GV7D7aLDAz+jr09SmDnQ6SyVHXGQs+r72j8/ONTXhJ4=; b=R7icMJipzC52SjzoGb7NAafD3L
	1DBiMKSum1XRj5cZy3tSmz+L6X5d8AJXzU8yTucsH2E5608DOgNLOsGFc8w6ucfmJQyiDZE84dycd
	VefYWFS3V3WdK3TlnqQxCOpYaCpKixEmzXw6T7WKBSJx1lXNhl2Z3gqNcVIVQ/1HxvVplWlzniPoT
	tzZ0wZ7W6cGCF11qNTPdWbFibdZyXxhnTKLCSaZnfpSXn+EkwsOpp4Cytio3JQEBzTas7l6UxfPvx
	A/XZw10VF6Nb7MZtE/YRy/Q/Yt8q668HPPCelzZ4TKtnpvizsFZMJxVSYXUVOr8cDnj6N/b9/N8RC
	4hlvZf5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Uc1-0000000CHvQ-3A9a;
	Fri, 20 Mar 2026 07:49:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Ubz-0000000CHuu-0Fw8
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 07:49:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2BDF76732A; Fri, 20 Mar 2026 08:49:36 +0100 (CET)
Date: Fri, 20 Mar 2026 08:49:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: yunje shin <yjshin0438@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, hare@suse.de, cleech@redhat.com,
	ioerts@kookmin.ac.kr, kbusch@kernel.org, kch@nvidia.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, stable@kernel.org
Subject: Re: [PATCH v2] nvmet: auth: validate dhchap id list lengths
Message-ID: <20260320074935.GA14616@lst.de>
References: <ec03d5ca-a26d-4427-823a-17c5709391f7@suse.de> <20260313052444.3865842-1-ioerts@kookmin.ac.kr> <20260317145137.GA6462@lst.de> <CAMX6_QFvhJwCp1v+YNC6BOTsV-7qCW1Q2pKZDOwkPychZOQuSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMX6_QFvhJwCp1v+YNC6BOTsV-7qCW1Q2pKZDOwkPychZOQuSQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_004939_242211_6762B9D5 
X-CRM114-Status: GOOD (  11.65  )
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

On Wed, Mar 18, 2026 at 01:55:13AM +0900, yunje shin wrote:
> Regarding the local variable — I understand the readability concern,
> but data->auth_protocol[0].dhchap is currently used without a local
> variable in 8 places in target/fabrics-cmd-auth.c (lines 42-44, 71,
> 75-76, 100-101) and 12 places in host/auth.c (lines 145-156).
> Adding one only for the bounds check felt inconsistent, so I kept
> the existing style. Happy to hear your thoughts on this.

Bonus points for fixing all of them up :)

