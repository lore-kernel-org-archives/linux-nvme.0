Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC62C28B2B
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Aug 2022 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bGLQCQNckwCdP8iEIOEwSZYjsXf5Ofc7h1ayLQFobO0=; b=mR3RUX0xDd9QkIpayDSE4qcoif
	GMay++9NAgM97wTWst0bEP30lyGfVRzJJtSjq5UGbfNtfsmsUN2FjD2revt3GawSuZtkdv5ln418B
	5bCRp59o8KJgYCOA92do8Tkt2szu62g9oXyX7kjTKyUIshLn1Bo/lMFsddhY5jO4zquieCl4yhFw2
	2TukKZGd1patj5VY7XeSv0jqHHAMpFrTpgRdtzHZ+d9C9XAXyTp+4Qyo8cDN4C0D7EKqeV0iQ2T9i
	wXwmEZraazyNuAFGf0rc7mkrCyNtpi87BwXsjm+y9o231dyvu5GVm8V5UAa1jVk9F9NdtnnyJZhIU
	HJWfQnow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOJst-002lpp-Ni; Wed, 17 Aug 2022 14:19:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOJsr-002loO-1Y
	for linux-nvme@lists.infradead.org; Wed, 17 Aug 2022 14:19:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1908D61435;
	Wed, 17 Aug 2022 14:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7256C433D6;
	Wed, 17 Aug 2022 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660745937;
	bh=F30WPjdHzZcjMxtCTa9eRPGzNte6mq2vkatly6/A0F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AS9pB+9iZMoAiXwHeC7lPiXOdX5O6DD13HMJhOj8i7xKWikjFTDjc9Z6kmSlxtRmM
	 3QNrHNRrMmmpAGYMCwEsMIvn4jcijYOmDZbPs+q68UfMUjmcxvzy7EzkviEerZ9MZk
	 kUNYrWED0PgAJ6kYtLUODi8ztEtLvMLIZVfSW+bg4fR/XltX2KYOkjAL5+yB/2bJ9Z
	 gnRWS/lOMaS3OylkE0xSwJQSlVywoTXchl4aO+YDwb8ENnkZs4DIxbpoI5AibMau8o
	 JRrM+z0bYp6UIejEhRL6ZMmia9kikjBV28WlQqOGEBlDsObzOtLmAyqAblyz3bu+S3
	 D3E84XBpQJQ9g==
Date: Wed, 17 Aug 2022 08:18:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Message-ID: <Yvz4zquwplVKwwXK@kbusch-mbp.dhcp.thefacebook.com>
References: <20220816091808.23236-1-fmdefrancesco@gmail.com>
 <YvvpJbOT9iv6rnm2@kbusch-mbp.dhcp.thefacebook.com>
 <c11e62ae-3439-e3e3-adba-d7f5f951791c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c11e62ae-3439-e3e3-adba-d7f5f951791c@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_071901_189166_CC46BDD5 
X-CRM114-Status: GOOD (  13.44  )
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

On Wed, Aug 17, 2022 at 12:44:09PM +0300, Sagi Grimberg wrote:
> 
> > You should also remove the cmd's 'nr_mapped' field while you're at it,
> > otherwise you'll hit the WARN in nvmet_tcp_free_cmd_buffers().
> 
> Not remove nr_mapped because we use it to know the iovec entries, but
> we can just remove the WARN statement.

It's only used locally within nvmet_tcp_map_pdu_iovec() after this change, so
no need to carry it in struct nvmet_tcp_cmd anymore.

