Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6507BC5AE59
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Jun 2025 04:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iE+xlKBNvKX1/RIvHXYj8b+eWa3bftOA6KCZZXn9BFA=; b=gjTSlnJSVLolpkk1Eqs/cz6/AM
	pKXk+YHFXfjzW+N4v4J8+Vafl+N+yP608ZDO+Iws/XQNWnOW715kwrnD+IYJwrlxlHH7FF2TdU/q3
	YVyE+BWRkzWORWKNv8oC/vJY5KlJTE/9oSV0hqPaeWYcx5sg1Jdx42L41rBGlXUR4mSp54V4RpMkV
	t5/IbO0j92w/uP1IZidWXuI6VawQ9Z5ElLoNYggSySkBHnvwPOTZ1JuGikXL83aGMLkj22V8OsZbO
	pG/Xi66UnWw5gh+AYHlUgw3NlQ8sq/ZsO8w67V98EPdKsnjLxu4A4P7ghgAk9IluFUwl6XxlS69TO
	IZNdmMrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN2Dl-0000000Ehm8-0wvd;
	Thu, 05 Jun 2025 04:28:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN2Di-0000000EhkQ-1DNb
	for linux-nvme@lists.infradead.org;
	Thu, 05 Jun 2025 04:28:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4E62668AA6; Thu,  5 Jun 2025 06:28:36 +0200 (CEST)
Date: Thu, 5 Jun 2025 06:28:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: hch@lst.de, axboe@kernel.dk, chuck.lever@oracle.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	jaka@linux.ibm.com, jlayton@kernel.org, kbusch@kernel.org,
	kuba@kernel.org, kuniyu@amazon.com, linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
	pabeni@redhat.com, sfrench@samba.org, wenjia@linux.ibm.com,
	willemb@google.com
Subject: Re: [PATCH v2 net-next 6/7] socket: Replace most sock_create()
 calls with sock_create_kern().
Message-ID: <20250605042836.GB834@lst.de>
References: <20250603045021.GA8367@lst.de> <20250604182020.126258-1-kuni1840@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604182020.126258-1-kuni1840@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250604_212850_476656_9584A80B 
X-CRM114-Status: GOOD (  13.86  )
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

On Wed, Jun 04, 2025 at 11:20:17AM -0700, Kuniyuki Iwashima wrote:
> > So the simple scripted renaming was not worth it.  Maybe I misunderstand,
> > but based on the reading we should basically have about a handful
> > callers of the non-__kern variant left.  Or is it a lot more?
> 
> Yes, after this series, only 2 sock_create() left, one in sctp and
> another in core.

Sounds easy enough to rename then, and doing so is useful go guide
people away from it.

