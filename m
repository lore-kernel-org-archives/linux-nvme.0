Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73435FF885A
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Apr 2026 00:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Zy2DJrRJGdFUsSTr714o7ATNF+h3r8jGyotdyT2gNt0=; b=c/L/B1io7TUsr3IszYsc1SJWqU
	j+rqHAp70W0l0HmZrheinFSP/s9R9VTQGdPFzXx4qfuppjYWFWOGVMyLGa3UwYIOyJuD/nsoXknOT
	lyIM5XjR1KetWPBvEQmQLOMMZUSVaZP+th6bPs6079aHgwR+cAFhscqE40TUxyeJdFkKaHtfRcx4T
	IXVHX5jbhvVbXAtLSOy3dQi0BvNQoSNV5FnMPz4BAKIMqKejApFGqH1Y2f2ZugCsUq0Z9lPPh5ScS
	rSArkNxe8Vur3gnwBJeKybKb7AnMaCvCdd1jmZC1SR7dOmUbW4n6DYZiA0ECRGoSXlxXYuRLM88nS
	opDHzWsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGneG-0000000F8iD-3diN;
	Sun, 26 Apr 2026 00:47:00 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGneA-0000000F8he-3F9O
	for linux-nvme@bombadil.infradead.org;
	Sun, 26 Apr 2026 00:46:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Zy2DJrRJGdFUsSTr714o7ATNF+h3r8jGyotdyT2gNt0=; b=rlRFL6HTN6Uikbhx9EZ/OEyagX
	wyGrCyVHAda/E5rVz1TLqfgZKhtonzmjqC2kLwejrmv2h9kN4l0sK3AXW03khsy/p6A1ZBXMUP38U
	6nN7TnGPbKWp4NrFebCFw26IOvQNc5XZoQhsrAbhxvjZuL2JNfLnWHW/keOxGovt+vH4T1Q7p3qck
	zzImYw1jm9AZF/7YGYcCRUMNDPtokdd28BAFrrVAt+qgbjnV4itZemlJPiCqryxDln0uBevIeaMl+
	IWZLqCBSIukbzQ8SVDIq5Clb8tgo1WZKfxR22JmsxuhgsLkxn+qpEWiP+2OJOBQT8zJjmOIK4GDCK
	q8N0TYLg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGne7-0000000HRp9-3JPy;
	Sun, 26 Apr 2026 00:46:51 +0000
Date: Sun, 26 Apr 2026 01:46:51 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Subject: [LSF/MM/BPF] Running BOF
Message-ID: <ae1gegHjBsgiMdXY@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

I'm going to go for a run each morning.  If you want to come
with me, meet in the Esplanade Zagreb hotel lobby around 6:45am
(this should get us back in plenty of time to get to breakfast).
I've plotted three routes, all based on routes described in
https://greatruns.com/location/zagreb-croatia/

Monday: https://connect.garmin.com/modern/course/453744315
Tuesday: https://connect.garmin.com/modern/course/453746189
Wednesday: https://connect.garmin.com/modern/course/453747068


