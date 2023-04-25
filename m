Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C10BC77B7C
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Apr 2023 22:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pbH4kj0bQbkv4uQLgh9icTJLHnh4dmzOWQNJbwfShMc=; b=IkefIp5h0TQaYn2q0FJr1LNpZY
	GfY0lf/BZDO8XCaED98HDV5ZIIUp44OgmiaNnxlu1xXrhpvu4Ar3pwoWsuXEx+2XJeVkDNVzFHZQV
	lpW14nhxyqFkoYEJMkZa7E0B0w1Z05bH5VgpSJGurl4WMOygaLS4mQ6WX8rhjCxs5dNd1vykGaZz8
	O66gr3SwbwUJiJDqCfzrSzSXr6sJdzupB7XEsII6jlqlNe3iw/xQH/m9H7UKlwGNiuQMtpTPDGDOU
	hgra7KlIxn6aTggv4uwOw/uMIAVkgpKESFgrvWmW+Cgq5pYuoAhSzps4GkH2vTsadSFFXA2aV16m2
	3JZvdcqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prRJV-002LFi-0z;
	Tue, 25 Apr 2023 22:39:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prRJS-002LFJ-07
	for linux-nvme@lists.infradead.org;
	Tue, 25 Apr 2023 22:39:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9DBBF62856;
	Tue, 25 Apr 2023 22:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1E7C433D2;
	Tue, 25 Apr 2023 22:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682462345;
	bh=+KbQYreuBWZGdnYLBpWBEmXnrxzZCsmAHyaRTByu+Sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fkF46wo8cJe6a+o5JYXyRfN+20QQj5ZGKZcTpoXDPTMEwPURv4HOXwdlXREd18RTm
	 A5Az8cFDeQENE6iVJXE88Ik2sdcicIv2/4BJ7HPsTdxsXF/jojMWNaBcUOrsA3dP7j
	 qlbtOMfXTQIE+/veV6jSExlLcts/zIcEmsTj09Ja0RlDZhMshwpmf92Wtq9bvogzDT
	 zVVnkbRZxAFSBR9hEGNp9f/vYcO6xaulC7TbIHVzhx5Ijnw2JTmmBLP+MgbLSZGEpK
	 kqLAo1uEKAotivdYG/pJOCHWUQeGQUUAh8v9YpYgUBvqknDxeIZhKgl8h2L1P22R+J
	 RuKFgwzWb46Og==
Date: Tue, 25 Apr 2023 16:39:01 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org, hare@suse.de,
	axboe@kernel.dk, linux-block@vger.kernel.org, oren@nvidia.com,
	oevron@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH v2 2/2] nvme-multipath: fix path failover for integrity ns
Message-ID: <ZEhWhegPXHYSCJJo@kbusch-mbp.dhcp.thefacebook.com>
References: <20230424225442.18916-1-mgurtovoy@nvidia.com>
 <20230424225442.18916-3-mgurtovoy@nvidia.com>
 <yq1jzy0lnyl.fsf@ca-mkp.ca.oracle.com>
 <85974694-c544-be82-97ce-c318adacda49@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85974694-c544-be82-97ce-c318adacda49@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_153906_163299_A45C01BF 
X-CRM114-Status: GOOD (  31.80  )
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

On Tue, Apr 25, 2023 at 01:24:31PM +0300, Max Gurtovoy wrote:
> 
> 
> On 25/04/2023 5:12, Martin K. Petersen wrote:
> > 
> > Hi Max!
> > 
> > > In case the integrity capabilities of the failed path and the failover
> > > path don't match, we may run into NULL dereference. Free the integrity
> > > context during the path failover and let the block layer prepare it
> > > again if needed during bio_submit.
> > 
> > This assumes that the protection information is just an ephemeral
> > checksum. However, that is not always the case. The application may
> > store values in the application or storage tags which must be returned
> > on a subsequent read.
> 
> Interesting.
> 
> Maybe you can point me to this API that allow applications to store
> application tag in PI field ?

I think Martin might be considering kernel modules as apps since they can
access the integrity payload no problem. I know of at least one out-of-tree
module (ex: OpenCAS) that utilizes the apptag (not that upstream necessarily
should care about such modules..).

Outside that, passthrough ioctls and io_uring_cmd can access the fields. I
don't think those interfaces apply to what you're changing, though, since these
bypass the submit_bio() interface.
 
> I see that app_tag is 0 in Linux and we don't set the nvme_cmd->apptag to
> non zero value.
> It's been a while since I was working on this so I might be wrong here :).
> 
> I've noticed that in t10_pi_generate and ext_pi_crc64_generate we set it to
> 0 as well.
> 
> The way I see it now, and I might be wrong, is that the Linux kernel is not
> supporting application to store apptag values unless it's using some
> passthrough command.

If we're considering only in-tree usage, I think you're correct.

> > In addition, in some overseas markets (financial, government), PI is a
> > regulatory requirement. It would be really bad for us to expose a device
> > claiming PI support and then it turns out the protection isn't actually
> > always active.
> > 
> > DM multipathing doesn't allow mismatched integrity profiles. I don't
> > think NVMe should either.
> > 
> 
> AFAIU, the DM multipath is not a specification but a Linux implementation.
> NVMe multipathing follows a standard.

If we're talking about any of the nvme passthrough interfaces, which format
will the user space need to construct its command for? This seems confusing
since userspace doesn't have direct control over which path the command will be
dispatched on, so it won't know which format it needs to cater to, nor will it
have deterministic behavior.

