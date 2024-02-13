Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DBAC48260
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 23:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b9B2FOtnxZ6GufOQDqdHDcOPnJGykOMN8pXxV+HOa5Q=; b=F0rq66HfvS2SF65GWfggS244UI
	3jhlpWnNTV2sQNzidubfZ8Ov5zuyfrhlUF8VIl8YPDgzN6hTzrnnf9upjX7fWTtgraakFnKDg3PyW
	YB/Da2jjogGAlIEjKFfUCkhHhTqb/aQJH6dTDMmfuQChk1zNFZOAJNVh7GxXyPuCjveGmRodajCCr
	ctnpTkTwAISgdQsvA5csa9pLmn7zVteztjaOWzIKXb8Ziq4dQvATz1XCmNTw8ypyyns4D3bi6AWk1
	u/O+fayRSTyZc+Gr41SospVVl4DpdoPZV/3Le6j0h1ndAvRlmsnJzFK6raAvdHiUQzUquHn2pKXCk
	cSXn3eVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra2Q6-0000000BHNO-3G1u;
	Tue, 13 Feb 2024 23:42:34 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra2Q4-0000000BHMS-0PGU
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 23:42:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4564DCE1F68;
	Tue, 13 Feb 2024 23:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27025C433C7;
	Tue, 13 Feb 2024 23:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707867749;
	bh=MZcWu6UlgLo3niir6ekTJcQ2Co3h8dVShLrgF8+1iDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nk+WUmsh0NaEPusbnExO83O6IqMExUMQEO0TZ4GkbFxP0S2baudpkxUx8mokSBJbh
	 CFYaEa0MQjBBJmmueI03tlbCzHzA7DgBW5SAU+fw+DnzHYTTPSY3s4nrnHP90wJUWT
	 iFooFVunfzq9h+VLAlUDGM1iU86vNBWACLXl+CJygc09ojmaQBnNsXl4pzKdxvhKcP
	 mQlCXFSUW01gI5OseWoFAx1pQiALn6yt98LdibA2OeAnoUkhDhVbr2lwZj77tl32D0
	 +lNJX8Uk87xEWvpK+USmORpQQIcKI9Q646orGCcKRW+3W7FvP7maqnz/4AP4mLbTBi
	 58guiSwvtheVg==
Date: Tue, 13 Feb 2024 16:42:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH V2] nvmet: remove superfluous initialization
Message-ID: <Zcv-Yqd6nDFYs00-@kbusch-mbp>
References: <20240213075824.29789-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213075824.29789-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_154232_326975_AC525E1A 
X-CRM114-Status: UNSURE (   6.74  )
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

On Mon, Feb 12, 2024 at 11:58:24PM -0800, Chaitanya Kulkarni wrote:
> Remove superfluous initialization of status variable in
> nvmet_execute_admin_connect() and nvmet_execute_io_connect(), since it
> will get overwritten by nvmet_copy_from_sgl().
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Applied to nvme-6.8, thanks.

