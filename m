Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A261C36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 10:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A74XNfDM5OjA/hYv6kgh37c3O4SacrEaQjfG/9Kw6XA=; b=VCFWa8yXV4PvLPKnNUEuVIS5lN
	9bA7FpenP+M+fXbZ2TPwzepnTfb/rB+D8J297v1hvYI3hImHEy/I6WbvBJyyEi2NvrG7LWmmQw7Ml
	MczC4ppotbUBKebi6jrVaBifmC2I1Dji0+HN6SfIQpqWIsYo1SuGeqOep6aSswFMPysiWli+I9vbY
	RNPV5gEOUL/aPEuLx0mCbPAzZPHH9Asx94A85LnClTIu5H7ay7zzbN0NdgAc0o0dbPwbXfGR0Dq9N
	ST9bdRvSWFmXAYWLFja79+J52PQbSx6Nbau6xZv5C5c0oqLkk2xq7N2A8Oh1qb58uucoEYW0Omy1V
	7JfN80xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Svq-00000006snL-2gPz;
	Wed, 09 Apr 2025 10:45:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Svn-00000006smZ-3B7t
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 10:45:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 73F6B68AA6; Wed,  9 Apr 2025 12:45:15 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:45:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, kbusch@kernel.org, hare@suse.de,
	sagi@grimberg.me, jmeneghi@redhat.com, axboe@kernel.dk,
	gjoyce@ibm.com
Subject: Re: [RFC PATCH 2/2] nvme-multipath: remove multipath module param
Message-ID: <20250409104515.GB5359@lst.de>
References: <20250321063901.747605-1-nilay@linux.ibm.com> <20250321063901.747605-3-nilay@linux.ibm.com> <20250407144555.GB12216@lst.de> <f05dd764-9299-4c20-998a-f3b1d45bacf8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f05dd764-9299-4c20-998a-f3b1d45bacf8@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_034519_957747_642F28E3 
X-CRM114-Status: GOOD (  12.60  )
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

On Tue, Apr 08, 2025 at 08:05:20PM +0530, Nilay Shroff wrote:
> Okay, we can add an option to avoid making this behavior "the default".
> So do you recommend adding a module option for opting in this behavior 
> change or something else?

I guess a module option as default makes sense.  I'd still love to figure
out a way to have per-controller options of some kind as e.g. this
option make very little sense for thunderbolt-attached external devices.

But unfortunately I'm a bit lost what a good interface for that would be.


