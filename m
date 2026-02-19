Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152E5E9A04A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 14:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lIUfsf8JaxJ48qmG5xnIYm98ylX2DhnMOAxi5mf81Yg=; b=oqNBi9IsHT9qfeJAdLRXZJ/JfJ
	UfayFPOnudUUMZG1KYv3B/dj7dxbCPP2+297HuNqgD9icAWAYuzdXey6MB96fqSQaqwWElgwKrTAc
	jJm7YNOrklC0TkE5srYwqmnl09FYVmgxI2Zg0OnCRKX9PUGwQixs6fT9nmE8RfTJcRUn6hfGxeE01
	JSFT7xmPFLATRXFfHng8a6imf3KPRT0jZhUsk6+xKsBRBy/O0oVPpmwdoq/4pDIuPTrF9I30sAZ5x
	LgAr7ndK78a170HrFzZb0G3frKF4As6WUCeFOIaclTewbaSP5PaAff1ug32LiDT+6U6jw+CS0ktmQ
	FT1VWxtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt55K-0000000BSfY-1wJV;
	Thu, 19 Feb 2026 14:32:54 +0000
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt55G-0000000BSdy-3rhJ
	for linux-nvme@lists.infradead.org;
	Thu, 19 Feb 2026 14:32:53 +0000
Received: from macsyma.thunk.org (pool-173-48-113-47.bstnma.fios.verizon.net [173.48.113.47])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61JEWgXE019467
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 09:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1771511565; bh=lIUfsf8JaxJ48qmG5xnIYm98ylX2DhnMOAxi5mf81Yg=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=DEZWVjL0xyfCBeyRW70yV9z+bT8dLBgE3Cr2B2R1FFbqVgTk3+cS79TVtarhMc2s9
	 y5zx36b7cGwjDDPIU1AWw8XobSbXIgAzVzvztzBkdZqcjFJNDQPiWezYsxlg+1EFp+
	 NAQuCoBvWIlevFLqB2dNFE6pFxImmljumqGA8fl4UQfqVke3xPXcQf6GsSGCmPKXmt
	 V4E5dQmrjeAAtwvTwwEDK9wAdOUwO6AYyEr05M2XZ20V4BpFkVWhICt9JfAkvDB29L
	 FNzhu9oZiB2WhB/N+ewidJlIJbLrRavHs4WbMGzOC0EMfOLieSFtmPS+RU1fyX5p0t
	 0rIcr3WomJl+Q==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id A4E16591BA5C; Thu, 19 Feb 2026 09:32:42 -0500 (EST)
Date: Thu, 19 Feb 2026 09:32:42 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Hannes Reinecke <hare@suse.de>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Memory fragmentation with large block sizes
Message-ID: <20260219143242.GC69183@macsyma-wired.lan>
References: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_063251_261825_2C1F51C1 
X-CRM114-Status: GOOD (  19.70  )
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

On Thu, Feb 19, 2026 at 10:54:48AM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> I (together with the Czech Technical University) did some experiments trying
> to measure memory fragmentation with large block sizes.
> Testbed used was an nvme setup talking to a nvmet storage over
> the network.
> 
> Doing so raised some challenges:
> 
> - How do you _generate_ memory fragmentation? The MM subsystem is
>   precisely geared up to avoid it, so you would need to come up
>   with some idea how to defeat it. With the help from Willy I managed
>   to come up with something, but I really would like to discuss
>   what would be the best option here.

I'm trying to understand the goal of the experiment.  I'm guessing
that the goal was to see how much memory fragmentation would result
from using large block sizes with the control being to use, say, 4k
blocks.  Is that correct?

So I guess the question here is what are realstic workloads that
people would have in real world situations, so we can do the A-B
experiments to see what using LBS result in?

> - What is acceptable memory fragmentation? Are we good enough if the
>   measured fragmentation does not grow during the test runs?

I can think of two possible metrics.  The first is whether it results
in degradation of performance given certain real world workloads.

The second is whether given a particular memory pressure, the memory
fragmentation results in more jobs getting OOM killed.

	      	      	      	   	   - Ted

