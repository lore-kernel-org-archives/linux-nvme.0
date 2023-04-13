Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FF7C77B6C
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Apr 2023 07:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3shfDfvLnuLRDYyeNuvjXbc3ZrjEKZg0BPByvWXcow4=; b=UcFDiEPWAinyb6WuyWhwi6WsBY
	OxFyy1ClumBTmFsRKl10jgmRjJTqDofpsJCM/ifhXSdaf8i48QsnoufAhlpgjpVovn6+PYH+dK+/y
	B/eGvDKWlZNYFPdnqx0Fyb2CParq8x3DfYGG5SozMdtbvP7XFbfu/mdvFO/DLh/GQoL/qO1iLyqF7
	nf1tQ13CAfadIz3nwnYv/C/rlpkHXzrcuOc0kK0fSAvZ9HyVnMaZNtDPjRJwlVfqc79eRrIXG9qrH
	fT9RqiuBUY0EZbltSCb+tTOd4bXwnAj6yrS4vnBgZAgRc62VAMTXRegD0f+DJ7l66G1mSA+Tg0zlT
	MYwX4+wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmrKN-005Gwl-2A;
	Thu, 13 Apr 2023 07:25:07 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pmrKL-005GwE-2g;
	Thu, 13 Apr 2023 07:25:05 +0000
Date: Thu, 13 Apr 2023 00:25:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
Subject: Re: WTF is going on with the nvme-cli build
Message-ID: <ZDeuUe+NBLMTVzgj@infradead.org>
References: <ZDemsiJi5vXd6aia@infradead.org>
 <4jstzssirve7hiaimj6fm52rftqadwo2tmnjx62zq7lzkrjkfw@ooh4zluxlrrd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4jstzssirve7hiaimj6fm52rftqadwo2tmnjx62zq7lzkrjkfw@ooh4zluxlrrd>
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

On Thu, Apr 13, 2023 at 09:07:29AM +0200, Daniel Wagner wrote:
> Hi Christoph,
> 
> On Wed, Apr 12, 2023 at 11:52:34PM -0700, Christoph Hellwig wrote:
> > can you please urgently fix nvme-cli to have a sane build system
> > again?
> 
> Please, let's not be so drastic and I would argue all build system have their
> wards. We just need to figure out how to handle them.

No, the idea of downloading software over a network connection is just
completely fucke up and not acceptable.  

> 
> > Right now it tries to download random packages over the internet
> > instead of not building components or failing the configuration.
> 
> Which version are you using? I've recentely change the default behavior of the
> fallback mechanisme but might have missed something. Alternatively, it also
> possible to change the global default for this feature.

Latest git tree.

