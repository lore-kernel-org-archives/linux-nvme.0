Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AB3CDB465
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 05:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DBtY5HuG7QenGjZBfPC00JFUs3GIR9s3NdWsLzbZZ6E=; b=qpUDAGlBS6cP5lZczA0zcLL1c/
	yVaBTtpYNeyvjfyQY8TGRWQFnfPEVcHLjP66Qq3SeDtnqy+s9UeK72Fl1GF4DNdL43WGIVJrmELA/
	aUGu9ZZi2WJbaRYWMZA0QevLq/Da0lMtEP9ORO1xWvLI2euRQLdP4/RbkjBhduM4/lsb1TPywrXeg
	wQQReGxiDrhDBWFjUb09FRGFuoniXLbUVOd6sEfp8ZmcVlRWWBQUq/hD20e8TroDMCE1zk13H3W09
	FeS4xBnpgAgQEc3Z3/fWngQIBYbSPwvnCdzg/jwWncOYpr2h1geh1DAtppmSB9q6+yMWzHpr8s0db
	CMGZO1DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLuG-00GOu3-1T;
	Thu, 19 Oct 2023 05:49:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLuD-00GOtE-1r
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 05:49:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BB92867373; Thu, 19 Oct 2023 07:49:10 +0200 (CEST)
Date: Thu, 19 Oct 2023 07:49:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	joshiiitr@gmail.com
Subject: Re: [PATCH 2/2] nvme: fine-granular CAP_SYS_ADMIN for nvme
 io/admin commands
Message-ID: <20231019054910.GH14346@lst.de>
References: <20231018183003.41174-1-joshi.k@samsung.com> <CGME20231018183629epcas5p4e11e71226c3990c304765c14c7defe6d@epcas5p4.samsung.com> <20231018183003.41174-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018183003.41174-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_224913_789041_4DA260B3 
X-CRM114-Status: GOOD (  11.45  )
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

On Thu, Oct 19, 2023 at 12:00:03AM +0530, Kanchan Joshi wrote:
> Passthrough commands are guarded by heavy-handed CAP_SYS_ADMIN checks
> that neglects the file-mode completely.
> 
> Add a fine-granular policy that considers file-mode and various other
> parameters for any approval/denial. Also enable few admin commands that
> are necssary to get the information required to form the i/o commands.
> The policy is implemented in a new helper 'nvme_cmd_allowed'.
> 
> I/O commands needing data-transfers are sent only via SGL.

This looks mostly good to me, but we should not even send the command
if we know SGLs aren't supported.


