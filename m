Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0954AC6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 00:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x/S9RR4epsEUIdsT/oBr2P4qOhAyQVUOU0a3FKzJ6Mo=; b=AJMlu/jJMczoJf7lFltVKMh1Ay
	N0w7I5zJPqcMOc7crNBGPETQPx6/XXHCJwEiwzXFbCb4+4c8DqmUQHbWDHe4RlKcc8u6CElxASQKz
	JfHDo8fefKsmmm4RGMb2VF2QJIHoHTvr88xNLhac3oU/1PWsFY9EpemS8JulQbDoslzAtywxcJCta
	uO4DsQNi8Am34RlAIinOKbpT0bMRJdoeYnzGbgflVBXe4vPlKHpL0E9UrKMzuQG1d/oZ+JnlPkl1E
	ricj9A9B16t1bg4G61FbRIjObEUhZB0qDirMPQFaWTpeHJJqRcKvqLag2yfdx2a57U6YbRRwwxh6a
	0wRjkd7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgxee-00CkdR-31;
	Tue, 28 Mar 2023 00:57:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgxec-00Ckcj-19
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 00:57:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id ABE7668AA6; Tue, 28 Mar 2023 02:57:35 +0200 (CEST)
Date: Tue, 28 Mar 2023 02:57:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, p.raghav@samsung.com, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [RFC v2 2/3] nvme: add error logging opt-in
Message-ID: <20230328005735.GC21497@lst.de>
References: <20230323230316.2914077-1-alan.adamson@oracle.com> <20230323230316.2914077-3-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323230316.2914077-3-alan.adamson@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_175738_539060_D1373BE1 
X-CRM114-Status: GOOD (  12.47  )
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

On Thu, Mar 23, 2023 at 04:03:15PM -0700, Alan Adamson wrote:
> Commit d7ac8dca938c ("nvme: quiet user passthrough command errors") disabled error
> logging for user passthrough commands.  This commit adds the ability to opt-in
> to passthrough error logging.
> 
> To enable passthrough error logging:
>         echo 1 > /sys/kernel/debug/nvme0/error-logging
> 
> To disable passthrough error logging:
>         echo 0 > /sys/kernel/debug/nvme0/error-logging
> 
> By default, passthrough error logging will remain disabled.
> 
> CONFIG_NVME_ERROR_LOGGING_DEBUG_FS needs to be enabled to
> to enable passthrough error logging.

Any reason to do this in debugfs vs sysfs which is someting
that we can a handle too much more easily?

Also why do we need a config option for a trivial mount of code?


