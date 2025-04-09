Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76323C36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 10:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DLswlPmfy4MIO2NadEBUVN8JK5dq/KvfsxOee0QgePQ=; b=uYbvh+ddmRnw72nG0UBpUohY92
	aAGSJXC87llukgs6ul2dkVdVU1VVBRiO4nic4jTQB+ODn01Scq58gWnfE3Qm65Y3hJwFep0LkOwHm
	pygaiJR+GVWBUnUIcDlPEBkn3f5BZ5560ugb9pgvDOr3zmG9SD2P1/QzGD7xDKH49yVm3aGSDQQla
	ZyKcSQYG31+n3icI+ENsQY3HBKI5WfBGdMBL7veSX8EdF9r0jOSKhXsMWBd3UWmWqFc72aEbo3dRy
	0oh08ng/6yfE7NCH1yjzbzFoo+Jo2/7I60Q6Mg4VJyr2c/spyPCPT4bsCgPK6k6c3ImKC6bXPVM/2
	uevGlT5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2SQS-00000006nnb-0eP7;
	Wed, 09 Apr 2025 10:12:56 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2RGC-00000006eTX-1bBS;
	Wed, 09 Apr 2025 08:58:16 +0000
Date: Wed, 9 Apr 2025 01:58:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>
Cc: Richard Weinberger <richard@nod.at>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	Daniel Wagner <wagi@monom.org>
Subject: Re: nvmetcli creates tilde directories
Message-ID: <Z_Y2qHCEFDnRRpyy@infradead.org>
References: <1957517818.260072969.1744184635348.JavaMail.zimbra@nod.at>
 <D91YFPG2AMZG.1QFEKLMBO5J9Q@bsdbackstore.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D91YFPG2AMZG.1QFEKLMBO5J9Q@bsdbackstore.eu>
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

On Wed, Apr 09, 2025 at 10:11:24AM +0200, Maurizio Lombardi wrote:
> On Wed Apr 9, 2025 at 9:43 AM CEST, Richard Weinberger wrote:
> > Hi!
> >
> > After playing with nvmetcli, I noticed that my home directory was sprinkled
> > with directories named "~".
> > It seems like configshell used by nvmetcli does not resolve "~" to my home directory.
> 
> Is this a regression? Which version of configshell is Tumbleweed
> running?
> 
> There were some large changes to configshell upstream recently so I am
> wondering if something has been broken.

FYI, I recently had a ~ directory show up in my home directory as well,
but didn't manage to track it down.  I've not used nvmetcli on that
system, but did use targetcli so configshell would be involved as well.
This is on a debian unstable system using configshell-fb 1:2.0.0-1.


