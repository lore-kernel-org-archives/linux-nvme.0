Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E29C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 16:48:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D9561100
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 16:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 78D9561100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sRJb87lewknRtk4I/R7PT6B9q4FKwqyHcmRupV7mCuU=; b=ZBixZ/ho9T/Zzc
	5Xanpt3HqAEKE0ZuYYtHh2eSZON5FOLRobighy5cAAayGQJ2gbJH+CB/pQhoLDtA2HQsHqSz4ynwV
	2jOw+GnkbIXuJNG08fsVaPhWNL70XwAEJlxWehibQW4tsEd3KPC4IHVZVrPKcXNn4/lgPoCxjnDiH
	AJKDm+hvyEa55C0xOyXToIoBIfsOo6Wm8cgq2XA54qbPCo9FX7pZbMCqNmwIO6ya44jB6hiebcH8z
	ru6kagcbu4u0mAR+61Oa+oH85jkeyvlq53B+o1XnX+GrdFtYPW0M+X/7Bc7eIAPLRR676rVtFr1yH
	tssl5S+cHLWWDnDAgVXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mONDR-00AOXC-CD; Thu, 09 Sep 2021 16:47:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mONDN-00AOWL-EF
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 16:47:54 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAD4361100;
 Thu,  9 Sep 2021 16:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631206073;
 bh=zPVI+0y+iff8HjAxOb6Tsiz91IjpG0pVTyxE6yycFgE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fwpZTCcDGX9pWgam9RZ7NCw01vIUHdcxqhETvGoICysDbqx9PoG4IYj4vOeC9kR9/
 MEUfi6FSRtF4qm3PEylWDwRDWcw6i9Ix7V1XeBvDxa7g3lt+SU3pRCEJYWJe77Lmwj
 LmZvdxkgeIf9Mn7It7MPLWppqFdtgk7YVJTI/l8wXTGhB3/hWeR4adXtUZXMXRhLmB
 /PjLQqRuw+xat2r6qR+9LBahS7zlNT1/Uw01CYfILTUEbo0cqj/avhYzOgu6bXRWmW
 hZg1YnRwBKyX5t/uTBr5YdZrTCppEt3GROpr4mgRmWAz5pCWNMOd0IN6vIy9DmYsdU
 OoGzckN+YpbjA==
Date: Thu, 9 Sep 2021 09:47:50 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH nvme-cli] fix path->nentry bugs
Message-ID: <20210909164750.GA2601661@dhcp-10-100-145-180.wdc.com>
References: <20210909145709.2079-1-chengjike.cheng@huawei.com>
 <1d6664de-7559-b828-e251-3c1e831f9446@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1d6664de-7559-b828-e251-3c1e831f9446@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_094753_548487_604F8A7D 
X-CRM114-Status: UNSURE (   8.49  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 09, 2021 at 04:19:05PM +0000, Chaitanya Kulkarni wrote:
> On 9/9/21 7:57 AM, chengjike wrote:
> > The "path->nentry" is initialized after it is added to the list in "nvme_subsystem_set_path_ns" function.
> > 
> 
> Overally long commit message, plz send.

I fixed it. Pushed to libnvme.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
