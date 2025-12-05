Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8BBD2CE13
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Dec 2025 03:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fpnFzk+vhiY4qzmA4ZfX68n3sftixlxbV4paCYhzxzo=; b=aO7OzDdZocNloxVmI9Y2gyMbBk
	LQsUWtdqG0qyZ/3xMNobpeLuJfULH6723XlAlU/Z6mc+160EOpkp66Dzm2bBDDudxRycmzD5hUYqD
	WXBzVqibxvigVxeUXsYLSsqzBeUHQDDFMIhyu/UUJhfzfcd9kBcMNOQP0ZoZX9sUQpnMlWqIN6AxN
	jCXg49XLlQAkdjwFq2R7tBtUrsN05ekIJlMNEX6PGjfRzcay9zzg29JX9oq/Eys4gknDXVbMFz2Qi
	AF263BJJJ7/bptbKljGFY8EzfBOyImtu5WWcK5C5h808gVKYTGaXiJX61quVQ1G6quoZp1FLa6s+V
	f6fKKqxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRMS0-00000008xix-1eMG;
	Fri, 05 Dec 2025 03:25:44 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRMRx-00000008xic-45Jl
	for linux-nvme@lists.infradead.org;
	Fri, 05 Dec 2025 03:25:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 43291402F1;
	Fri,  5 Dec 2025 03:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F8FC4CEFB;
	Fri,  5 Dec 2025 03:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764905141;
	bh=hC2Za6rEA5NMLq+7LbWtCXgd18IHs02iZBNlBkEi4CQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+bRANmljLYh9n97Q82nRvXKlR40A9PP7b4flBSKGMxGsFJieC04DgOAipAtCMTGQ
	 RNZYGH9QGHyQxwcJmwarUUbHiyMFJilz7EZA3qhrfRRS5xPCDQVHFPCsADa92noxJP
	 2NPaIJbHFkmaMlh2z0F9S5anKiQlDAX/91ns3hU/azEOP5KyybtoS5fkVSIC4/Rgz5
	 iV1Y7En68GEbcU3nPBhUitNkHE2uCaKb90Hu8bA7la/BB4NeS8BMGIwl9F/ve1YsHs
	 4nlbAo74SknwRTJkVgpuWUGmF00JxIVRZCDXl//CI4E6PuejIIMEocHqzHujSl6Xad
	 bHo5umWIh+Uxw==
Date: Thu, 4 Dec 2025 20:25:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL v2] nvme updates for Linux 6.19
Message-ID: <aTJQslM569DYXXkJ@kbusch-mbp>
References: <aTIQ78l7TLpOGPWA@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTIQ78l7TLpOGPWA@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_192542_056536_D85EB6F7 
X-CRM114-Status: GOOD (  17.19  )
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

Correcting email typo.

On Thu, Dec 04, 2025 at 03:53:35PM -0700, Keith Busch wrote:
> Resending due to missing Sign-off-by tags in the previous revision.
> 
> The following changes since commit d211a2803551c8ffdf0b97d129388f7d9cc129b5:
> 
>   block/rnbd: correct all kernel-doc complaints (2025-12-01 07:19:50 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.19-2025-12-04
> 
> for you to fetch changes up to 13989207ee29c40501e719512e8dc90768325895:
> 
>   nvme-fabrics: add ENOKEY to no retry criteria for authentication failures (2025-12-04 14:46:17 -0800)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.19
> 
>  - Subsystem usage cleanups (Max)
>  - Endpoint device fixes (Shin'ichiro)
>  - Debug statements (Gerd)
>  - FC fabrics cleanups and fixes (Daniel)
>  - Consistent alloc API usages (Israel)
>  - Code comment updates (Chu)
>  - Authentication retry fix (Justin)
> 
> ----------------------------------------------------------------
> Chu Guangqing (1):
>       nvme: fix typo error in nvme target
> 
> Daniel Wagner (5):
>       nvme-fc: don't hold rport lock when putting ctrl
>       nvme-fc: check all request and response have been processed
>       nvmet-fcloop: check all request and response have been processed
>       nvmet-fcloop: remove unused lsdir member.
>       nvmet-fc: use pr_* print macros instead of dev_*
> 
> Gerd Bayer (2):
>       nvme-pci: print error message on failure in nvme_probe
>       nvme-pci: add debug message on fail to read CSTS
> 
> Israel Rukshin (3):
>       nvmet-rdma: use kvcalloc for commands and responses arrays
>       nvmet-tcp: use kvcalloc for commands array
>       nvme-auth: use kvfree() for memory allocated with kvcalloc()
> 
> Justin Tee (1):
>       nvme-fabrics: add ENOKEY to no retry criteria for authentication failures
> 
> Max Gurtovoy (2):
>       nvmet: add sanity checks when freeing subsystem
>       nvmet: remove redundant subsysnqn field from ctrl
> 
> Shin'ichiro Kawasaki (2):
>       nvmet: pci-epf: move DMA initialization to EPC init callback
>       nvmet: pci-epf: fix DMA channel debug print
> 
>  drivers/nvme/host/auth.c        |  2 +-
>  drivers/nvme/host/fabrics.c     |  2 +-
>  drivers/nvme/host/fc.c          |  8 ++++++--
>  drivers/nvme/host/pci.c         |  2 ++
>  drivers/nvme/target/admin-cmd.c |  2 +-
>  drivers/nvme/target/auth.c      | 18 ++++++++++--------
>  drivers/nvme/target/core.c      |  5 +++--
>  drivers/nvme/target/fc.c        | 48 +++++++++++++++++++++---------------------------
>  drivers/nvme/target/fcloop.c    |  9 ++++++---
>  drivers/nvme/target/nvmet.h     |  1 -
>  drivers/nvme/target/passthru.c  |  2 +-
>  drivers/nvme/target/pci-epf.c   | 14 ++++++++------
>  drivers/nvme/target/rdma.c      | 12 ++++++------
>  drivers/nvme/target/tcp.c       |  6 +++---
>  14 files changed, 69 insertions(+), 62 deletions(-)
> 

