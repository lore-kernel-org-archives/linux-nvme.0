Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E657BC64ED6
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Feb 2023 17:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bpWRWjGn6JuSvVOGi9NWXZ3QRJCeA4tEXBSBmVH1KPg=; b=qfYPUBGtWBbE57bYVvf2K9bg4O
	Da9hvlpyBn/BgNBG2Ee2AKonDPQ5KA3XuEfiTB7LWtghlLN698LYX31AWTd44KzPe5g8mVGKQCRXx
	bcknSOM3YUsNmzSnRBEfl4S9AYgQ1M7RqkoMA8VZxv7j89Efews7SspnfMU3tGKbc/QiJ3AdNGBnv
	DyP9uQyG+cG4kCi1K/3Q5muI1xnhM8nkqp2O9ghFZ1Vi5tZfcpgxHktNKU+xozZ2KBc74Jhy1ZmGE
	djagUzSbtkKppSTNHjL7IlAQHX7+Rq2y8Ruald3/aFbSe8mvqgvpZQ2CWYoKQuI0hTo2bRhZSe/kN
	o8vdLOTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWhYY-00AXQh-Kh; Mon, 27 Feb 2023 17:44:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWhYW-00AXOz-8o
	for linux-nvme@lists.infradead.org; Mon, 27 Feb 2023 17:44:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 993B760EE0;
	Mon, 27 Feb 2023 17:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27632C433EF;
	Mon, 27 Feb 2023 17:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677519895;
	bh=/SOVKtkDSxDxmC89ievuT6HH6QX3NhvtmNmaObVIk6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jl/ZvmRNcuW9+rhUypdYi2dd6xgmzzP8r0oObXLU2Q1eoo7mwD99uKgALcAAA4Tun
	 Fk/PDUeywnsaN8TPspId/XjmpLG/58C0sJDU+dK7+BkkmMiyZ+i44ADEyb0jECmntA
	 3OoHn3Fq2GFb8E+Mn0e+rPx+MDJF/6k7RRLtUyY+K6h4IcVeHQubyAgubUUZ8of773
	 fd796yjYxhBxia1AV4TL0MAYDaqg0eF8A2Kxbv6f8MPpagrTAXCKiGZOqCAtJgEkFR
	 UUFAg+ElDgXuSxAcV+n9azzcUCItmLn8lPlzcJ3iT68A68AQlcqYpg4RMxYAhihhxi
	 bIB6CF9CB0Z+Q==
Date: Mon, 27 Feb 2023 10:44:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"dgilbert@interlog.com" <dgilbert@interlog.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"lsf-pc@lists.linuxfoundation.org" <lsf-pc@lists.linuxfoundation.org>
Subject: Re: [LSF/MM/BPF BOF] Userspace command abouts
Message-ID: <Y/zsE9i7012Ivwe1@kbusch-mbp.dhcp.thefacebook.com>
References: <ad837a26-948a-c690-cd9e-4dfffb5f990d@grimberg.me>
 <57d8dff9-2fdb-8198-6cdc-7265797a704a@interlog.com>
 <23526cf9-d912-59a7-4742-6003d6ccfd45@grimberg.me>
 <Y/Yscr82hqdKl1Hw@kbusch-mbp.dhcp.thefacebook.com>
 <561afa67-04d0-c675-6bbb-048313da152b@grimberg.me>
 <73b4dd39-9ce8-9b55-8a1d-06865f3bde32@nvidia.com>
 <Y/lpmrwuehnsWmmR@kbusch-mbp.dhcp.thefacebook.com>
 <0fe59301-65e6-d8a9-033e-0243ad59c56b@opensource.wdc.com>
 <316431ed-1727-7e80-2090-84ac5b334f74@grimberg.me>
 <3ea301b1-c808-ce08-8ec8-3a631b385fb9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ea301b1-c808-ce08-8ec8-3a631b385fb9@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230227_094456_369979_D5D6B1DE 
X-CRM114-Status: GOOD (  17.79  )
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

On Mon, Feb 27, 2023 at 06:28:41PM +0100, Hannes Reinecke wrote:
> On 2/27/23 17:33, Sagi Grimberg wrote:
> > 
> > I'm not up to speed on how CDL is defined, but I'm unclear how CDL at
> > the queue level would cause the host to open more queues?

Because each CDL class would need its own submission queue in that scheme. They
can all share a single completion queue, so this scheme doesn't necassarily
increase the number of interrupt vectors.

> > Another question, does CDL have any relationship with NVMe "Time Limited
> > Error Recovery"? where the host can set a feature for timeout and
> > indicate if the controller should respect it per command?
> > 
> > While this is not a full-blown every queue/command has its own timeout,
> > it could address the original use-case given by Hannes. And it's already
> > there.
> I guess that is the NVMe version of CDLs; can you give me a reference for
> it?

They're not the same. TLER starts timing after a command experiences a
recoverable error, where CDL is an end-to-end timing for all commands.

