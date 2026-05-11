Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745C2CD4840
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Gk/049HuZZMwQEzwfSanqQ7jIxf61M3kb036EnbUcw=; b=zsT2Rr0CGpICq53y9HNF40GlBk
	lkfk2rdFUUVAayaJfQe8MMCbsagkaEBR7AKBVeHl1rCpItp8GzH14qCLMCRZvJIWjI/k3QQRFU+vu
	k1XxgHZi5i2ul+VOjSkHYz35a4zAddDMnnT4tdLPxJX8zbm9jgBAsH1ezezTns6uVlQ1itx4gGrLZ
	c+wiDywAl5dIWJ3vLF6CrLN96MxGXevSocbWkbOEgTA14vlVIOFcXOwIXbke14eB2lKlOyE42Wqd1
	tBTON1DrMQIcvn/kt7l/FLdCR2Z4UrBOzQgizqAvbrbtbNcxRWVoo+eC8sXo3bUPTqwKAi2G54IWo
	sfABmfaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMU8w-0000000EJT3-0QJ7;
	Mon, 11 May 2026 17:10:10 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMU8u-0000000EJSc-28Z9
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 17:10:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8E85A60103;
	Mon, 11 May 2026 17:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C2AC2BCB0;
	Mon, 11 May 2026 17:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778519407;
	bh=X1FHCqMi+Xmi/cTk9Bk8tQ+tzfTdzkBP3qLcNhbUU6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CC4IloU+ATXZKukqDS22vOKENDEJQB3grTQZpe1Relt4q0yugZR6lM6XzE2U3u3Kx
	 DGFfdh3pbVKD4bHW9AISRdKMuvZDyXPYm15Xkg/+eWdnr/KKSqneotFUloZDfiHHGB
	 ndrgSgiEuj45QoOhNYhFdXttm8QQ5TJiI2AFiXGnIQy5uSlxSexGbC6JNoM1T3uJwM
	 J3sw8dVLf4F7ANFeR2Twa1igtJzXDoUgrqtAxIzU1HgqmuVH1ZTq9w1Vmcog5LosD8
	 yousnFz4mTVhbdb6uuIeXP7ZNs40rOGpirOgBxM3ORAO3eLbL0QBysyoCE/tRbOha5
	 Jn0Z3m6U8m+uQ==
Date: Mon, 11 May 2026 11:10:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Maurizio Lombardi <mlombard@redhat.com>, mheyne@amazon.de,
	emilne@redhat.com, jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org, dwagner@suse.de,
	mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH V4 3/9] nvme: fix race condition between connected uevent
 and STARTED_ONCE flag
Message-ID: <agINbJ65S8w8cycB@kbusch-mbp>
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-4-mlombard@redhat.com>
 <3512fbae-ddf5-458d-9286-214b1d89afa8@grimberg.me>
 <20260511080746.GC29677@lst.de>
 <8074044d-291b-4ac4-acda-f27e94f3243b@grimberg.me>
 <agHxJrEzw08glN1x@kbusch-mbp>
 <DIFYPQP2Z8D5.QSBMLF4V9FNX@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIFYPQP2Z8D5.QSBMLF4V9FNX@arkamax.eu>
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

On Mon, May 11, 2026 at 05:45:36PM +0200, Maurizio Lombardi wrote:
> On Mon May 11, 2026 at 5:09 PM CEST, Keith Busch wrote:
> > On Mon, May 11, 2026 at 03:54:04PM +0300, Sagi Grimberg wrote:
> >> 
> >> > On Mon, May 11, 2026 at 01:10:34AM +0300, Sagi Grimberg wrote:
> >> > > This should even go as a separate patch:
> >> > You mean a stadalone fix?  Because it already is a separate patch.
> >> 
> >> Yes, this is a race condition fix that can go separately.
> >
> > Sure thing, I've applied patch 3/9 to nvme-7.1 as a separate bug fix.
> 
> Oh, that was way faster than I expected.
> 
> The issue is that, in explaining the rationale behind PATCH 3, I
> mentioned in its commit message the admin_timeout sysfs attribute
> introduced by this patchset.
> 
> You may want to remove that reference if you plan to merge patch 3
> indipendently of the rest of this patchset.
> 
> In the vanilla kernel, the only sysfs attribute that could be affected by
> this race condition is nvme_sysfs_delete().

Ah, thanks. I got to this one quicker because I had some free time for
patch maintenance. I'll fix up the message.

