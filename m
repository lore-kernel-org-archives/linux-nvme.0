Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C45C83F18
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jul 2025 22:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ekQqIbapukARd6gBzz7yly3iOSMb8FIqVO9iq42DlP0=; b=Ykun6u48VRWCkQnOEskuGwPMu/
	INajK4r+YTGLBf7QQeCRXoNntuhMSbnPHxfZADe4IjF3ZKWADzbBFCUSdet6ME+4pdmCpvw5Lxb5z
	Os/e4Ff1EB0cP4yVvmVKyC4uM00oTZKyG6apEXlKH9X8ek209ruDBX2yv9dGTbuoih5bnz72YQVnJ
	Jwm5F1rgEKf6t6Q9mnPUuHV8LMNg3VAba+cGHcBw2qZEZ3VT5hKZzdRo9Vt0ICG48g9aCIpudCg8E
	h73T1CogTyc68MGrEsG0j+XhpKwzne/uMqH5vElVu0LiWgofPzQVetgeqmyDs/deljvQl84B06i/k
	zlIVyNGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZdjv-0000000ABW9-1YgT;
	Wed, 09 Jul 2025 22:58:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZd1g-0000000A2fI-2aI7
	for linux-nvme@lists.infradead.org;
	Wed, 09 Jul 2025 22:12:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 673A25C5E38;
	Wed,  9 Jul 2025 22:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D674C4CEEF;
	Wed,  9 Jul 2025 22:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752099147;
	bh=ekQqIbapukARd6gBzz7yly3iOSMb8FIqVO9iq42DlP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2tAKGY6+QYmIv65ILc2CTZPHoOtM+FaxmjiryXozPOV3E9UP1b3CFN3O5Wsl+4Uv
	 +4eyf7w0p3tNA2K2s/yszWCxhcnLeTMf/YYk3S+GkotJKFe8IqxuhT4v2qoMd6xbta
	 ERP5gs7s16SStlct+Oa/sdebbKJMHjRPYUj5yCX1FmA+K3rHgmd98QC+8jaBcb/o/d
	 XCSkmBuh9bqZ5VC/r3a2e+UvOhl4FYyiBiQqtvlCZSOHEF0AAO+xxKKZd5dlf5dhEo
	 8xQvrVozM3WmuQhYFusZMwhV/3hJUZSIvQR8wjBJgG1/NrAWkBN3k5SfA5PTZTcxOT
	 bV+4vvAynJQag==
Date: Wed, 9 Jul 2025 16:12:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bryan Gurney <bgurney@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	axboe@kernel.dk, james.smart@broadcom.com,
	dick.kennedy@broadcom.com, njavali@marvell.com,
	linux-scsi@vger.kernel.org, hare@suse.de, jmeneghi@redhat.com
Subject: Re: [PATCH v8 7/8] nvme: sysfs: emit the marginal path state in
 show_state()
Message-ID: <aG7pSA6TOAANYrru@kbusch-mbp>
References: <20250709211919.49100-1-bgurney@redhat.com>
 <20250709211919.49100-8-bgurney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709211919.49100-8-bgurney@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250709_151228_694277_50439E1E 
X-CRM114-Status: UNSURE (   8.38  )
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

On Wed, Jul 09, 2025 at 05:19:18PM -0400, Bryan Gurney wrote:
> If a controller has received a link integrity or congestion event, and
> has the NVME_CTRL_MARGINAL flag set, emit "marginal" in the state
> instead of "live", to identify the marginal paths.

IMO, this attribute looks more aligned to report in the ana_state
instead of overriding the controller's state.

