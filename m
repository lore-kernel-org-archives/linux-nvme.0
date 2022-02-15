Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8C8C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 18:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jnq7NN62m+7x1ZR3hypbWsWnsRVHVGm4UCfrf0i0iRQ=; b=ArabqKMf7NLxskvE4RQJ2GQbZD
	7TLoEA4qiJTSIhxhLpp5QTBguZTceCE5SvfmUCR4rGm03Axby93oby/jsLsVzt0ZbU2AXWfEsXFzF
	wS5desEdx9DbUsL1umuGN2SuYoY+oiDYSDNtzpTX5O0mqGRC19vlIQPCopfPagjzMiDeTHtLVY/nO
	99MjjxdGWlOslp9/8Wbxidt8AGDXSCD7TWs8LEK0BH4bEnZUqSUuy25dil7e4o/9v+wS87EZNyBPb
	NhqK9aBF+NpAEpnrRgWb54J22OOPd8pBRUfG8226GaZD0dEikf5MhoW/jR/vY8bcGccU1do9dr1Ub
	FpaeCIpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nK2ht-00478Y-BJ; Tue, 15 Feb 2022 18:37:45 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nK2hq-00477X-CD
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 18:37:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 13959B8124E;
 Tue, 15 Feb 2022 18:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61905C340EB;
 Tue, 15 Feb 2022 18:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644950259;
 bh=OcH25pAoM6QlZ8Tu9w6WMLIWNlbc+MXzuq/6DmyyeA4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qHaBJgbV6HoMz4VpSW1jdcnIYOyhReO9VFx59cPN7QfFhrsojkItt6CLycC8QJl1+
 BC1tUqt5Jr/TBG27kmQ4eYHhnhGOyxEZ9fLYxYaWlhxLg7QfZA4Ig/V0s8KggtYXSG
 NXK0PdARi+AsS4l8kFeKUPxr6IxR6VkXXikhvuSraRfCiMs2R/zf+/fgcO1EOke4E/
 8Xwz/Sj2ryZrkL2bOn7KUeDBBubql0NlQZGtb28sRl1VmXIchMLJ6OhOF4NuPxiLg0
 98oyNHjSNuYyr+6CNKogQG/0tAITeacShnnF5+ECTk1GJjAik/63RKi0F3o7QIr/G6
 2UT0wrvAIHXcA==
Date: Tue, 15 Feb 2022 10:37:36 -0800
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: remove nssa from struct nvme_ctrl
Message-ID: <20220215183736.GA1934598@dhcp-10-100-145-180.wdc.com>
References: <20220215153719.1934484-1-kbusch@kernel.org>
 <8e48a72e-8d52-2395-4889-6ec6a493c3d6@nvidia.com>
 <0c105b7f-c24b-ed24-1dcd-e9d22be13b1e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c105b7f-c24b-ed24-1dcd-e9d22be13b1e@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_103742_595955_9A0942D7 
X-CRM114-Status: GOOD (  15.43  )
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

On Tue, Feb 15, 2022 at 05:09:44PM +0000, Chaitanya Kulkarni wrote:
> On 2/15/22 09:03, Chaitanya Kulkarni wrote:
> > On 2/15/22 07:37, Keith Busch wrote:
> >> The reported number of streams is not used outside the function that
> >> gets it, so no need to stash it in the controller structure. Use a local
> >> variable instead.
> >>
> >> Signed-off-by: Keith Busch <kbusch@kernel.org>
> >> ---
> >>
> > 
> > Looks good, can we make this feature configurable from KConfig ?
> > 
> 
> right question is should we make optional features configurable ?

I don't see why. What benefit does the driver stand to gain from
conditionally compiling such capabilities?

