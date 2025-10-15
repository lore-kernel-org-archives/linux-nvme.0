Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E50CCD185
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Oct 2025 04:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ud9N/7odVyBYvA9zzfQ9hnfzCKXCRCswR8cH0MRFnDE=; b=ja2HexeuMj5hFy6L8pwUTM5ywK
	8njjULR+OXvAwUXIFsIygEoTVeTKoCY+bR3nuNateYe87pBWq8cuJNfFwrtK9Cng5S+DhA1bkQ0Tp
	S/SiMdq5Df0H+81G9FBStkHo72THJog3MkwV1g3UeahMQ8Ln4fddX5kxMgM0PG1yr8vBOmcgMA+eZ
	Ly0040IOvrBm1zkASh36oTeN1lNDDq9Yr8+3rEWhmuoWCY7bM6LTFUMh3UH6Hc6CDvl5rZfU0T3jK
	9PQo0792uGr36FXtm4mFgNQZ3k6fOkFZQlWDa/DFZHLBWDWEVdgqeq9vhcmbS3s8Ly+jtHm0eNjQv
	kgsXIV7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8srt-00000000OpL-1aDz;
	Wed, 15 Oct 2025 04:12:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8srr-00000000OoY-1skA
	for linux-nvme@lists.infradead.org;
	Wed, 15 Oct 2025 04:12:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 914C5227A87; Wed, 15 Oct 2025 06:11:57 +0200 (CEST)
Date: Wed, 15 Oct 2025 06:11:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: libnvme API design
Message-ID: <20251015041157.GA6955@lst.de>
References: <9812534f-6a15-4126-a4c0-7b4ae39e327b@flourine.local> <20251010072658.GA17812@lst.de> <204cb4cc-33b4-40ce-8554-13436048f8d4@flourine.local> <20251013064700.GA2140@lst.de> <0fe148ad-e2c9-4aee-9d2f-5c6eaefddca3@flourine.local> <46cc3fe6-e00a-4496-8fac-bb7f0d550fc4@flourine.local> <20251014042011.GB30344@lst.de> <fd004033-5fd9-4533-97f5-c9e7462ef282@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd004033-5fd9-4533-97f5-c9e7462ef282@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251014_211203_654438_A2F7E75E 
X-CRM114-Status: GOOD (  11.26  )
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

On Tue, Oct 14, 2025 at 05:29:54PM +0200, Daniel Wagner wrote:
> The change is unit tested, so I think most obvious bugs are gone. On the
> callsite the change is straight forward:

This looks very nice!

