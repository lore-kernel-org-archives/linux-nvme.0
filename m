Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3390C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 13:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XrUMCxqWKQXX3N6qvIULjnppmd8jXdYOlmSrvUrOd48=; b=qZ/5aoNXVZ8+MxMzkPEYlxfze7
	5IHQhzGuDAsKLnImfEgQAm9yiG4/wbB3n3H1Eaea8yGjraFFvtAYdpkUvtEExxgN27yQXhvRgoixj
	dLqKVU7q3l38Kmqp4Jy7ONT3c4fKzUv9FWH+qqoWQFlXlWZLCRY3kR3jAgKHlQjeid9nGCfXu+Hvf
	kr4RZyu8dtPOP1L+Hgmz0UE4sd8dffxD4MtXAHslFQOKUSqtrQno/QySuQ/g+cndko+fcXQbRNgRK
	99yp2GS1Uk2x6VUA5D6f0oTyBKbRibtu0c0kne0fk/86rTVSgBmkRMQLDeC22ilH2rxgEighVu+pT
	CkWP/LGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk4KG-0076j0-BA; Thu, 28 Apr 2022 13:36:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk4Dk-0073b4-LB
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 13:30:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9791260DED;
 Thu, 28 Apr 2022 13:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAA0C385A9;
 Thu, 28 Apr 2022 13:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651152610;
 bh=RZM7IVv9AUrXeGejIGAsR9z4q0NsP3Di7THp/r3pNig=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=iZuiJwjQ1whNlb0lnJFp5QXAZldrShPmn4lpoao9tuXVXrgLEFHTdAVbI2xLbsOFC
 FCis7paFu01IdpNIweeLZg9Wdc2PPLbyyhhMt7KyPp2GYiyXQ7DIWtIqiWebq+wk0s
 kJtnE670kLm9vFCfEeax17CEMhLO+hRDPMTHCnfe9+RotEZilWEJsmbe5hqzhTvPJj
 myb8JYbGIMQmLtNgNiD90Eb5wlf9aj5ZzVWtAItWZfB34Hw0uy9ik9FOR5RigxMMik
 CB4oXTQyuFiKWbD5TMZc0KzqRqt56Yje278br6A71jETYhgLQXGvv8tHBzTfiLDzCQ
 UlHgBbJDN6tdg==
Date: Thu, 28 Apr 2022 06:30:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <chuck.lever@oracle.com>,
 netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ak@tempesta-tech.com, borisp@nvidia.com,
 simo@redhat.com
Subject: Re: [PATCH RFC 4/5] net/tls: Add support for PF_TLSH (a TLS
 handshake listener)
Message-ID: <20220428063009.0a63a7f9@kernel.org>
In-Reply-To: <23f497ab-08e3-3a25-26d9-56d94ee92cde@suse.de>
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030059051.5073.16723746870370826608.stgit@oracle-102.nfsv4.dev>
 <20220425101459.15484d17@kernel.org>
 <66077b73-c1a4-d2ae-c8e4-3e19e9053171@suse.de>
 <1fca2eda-83e4-fe39-13c8-0e5e7553689b@grimberg.me>
 <20220426080247.19bbb64e@kernel.org>
 <40bc060f-f359-081d-9ba7-fae531cf2cd6@suse.de>
 <20220426170334.3781cd0e@kernel.org>
 <23f497ab-08e3-3a25-26d9-56d94ee92cde@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_063012_841550_9DBF8EF4 
X-CRM114-Status: UNSURE (   9.54  )
X-CRM114-Notice: Please train this message.
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

On Thu, 28 Apr 2022 09:26:41 +0200 Hannes Reinecke wrote:
> The whole thing started off with the problem on _how_ sockets could be 
> passed between kernel and userspace and vice versa.
> While there is fd passing between processes via AF_UNIX, there is no 
> such mechanism between kernel and userspace.

Noob question - the kernel <> user space FD sharing is just 
not implemented yet, or somehow fundamentally hard because kernel 
fds are "special"?

