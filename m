Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DBFC54E58
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 23:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nZ1NiGSQ071EQIlkO+d2E1vpEXQOeqkJAG3gjE33Eb4=; b=IOsOUdIg30HsZQnU46mFRG59rR
	kUyXE/3wwMz3/3wtfmlU2WqRzA4IpiJSIkD0ZDPEOF3iw3GzqeB04ZLlL6V/+ObrmwhvMWDPhVOYT
	5D+A5fpSLdslljGJ0JgdqH5JVyb/tpoi1byzZs+mY9ANtY20Lt/Sf9qs7H124csi9OITCe72A3xYl
	kRIrnnBRPKjOXo6IHo3HplcXjYyFJ0QBNrYxUVK8PuV3ZnhakR9kdO6Prrf77kmRDZ4k++LSVZVN4
	HCNUdX4x6ZeHshCciBRU6C46RvYljZWiXOrBn/5YwyJr63HT3vbp3bsS4dWaNmeWpetWfgHR/GdG3
	wBCoa4+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmMFX-0000000AWPf-2CV3;
	Mon, 18 Mar 2024 23:18:35 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmMFV-0000000AWOy-3TcS;
	Mon, 18 Mar 2024 23:18:33 +0000
Date: Mon, 18 Mar 2024 16:18:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
	axboe@fb.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Gregory Joyce <gjoyce@ibm.com>
Subject: Re: [Bug Report] nvme-cli fails re-formatting NVMe namespace
Message-ID: <ZfjLyfptPVT7wa0_@infradead.org>
References: <7a3b35dd-7365-4427-95a0-929b28c64e73@linux.ibm.com>
 <Zfekbf0V5Dpsk_nf@infradead.org>
 <1a37aea5-616c-445c-a166-e2dc6fa5b8f5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a37aea5-616c-445c-a166-e2dc6fa5b8f5@linux.ibm.com>
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

On Mon, Mar 18, 2024 at 10:26:23AM +0530, Nilay Shroff wrote:
> I have just tested the above patch and it's working well as expected.
> Now I don't see any issue formatting NVMe disk with the block-size of 512.
> I think we should commit the above changes.

Unfortunately I think it's going to break splitting the bios for real
multipath setups where the capabilities between the controllers are not
identical, i.e. another symptom of the problem of what limits we should
actually inherit.

I'll go backto the drawing board and will send out another patch.

