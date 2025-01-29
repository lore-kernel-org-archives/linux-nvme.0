Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA85C0218D
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 18:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OSlNHR1EAFdfppnREJKE2Z8y/ZMc3r1QCpgm1/GWVZU=; b=nyTc/ArJ600nQQg1DXDiMskQDO
	P1SLAk8LHkG2nKtOO8JqtF+6wUQZD8eFqiEqPACwFyOfhF0bM/rjvRNj/2rSASYi7urQWagMjJSnD
	870lEsXSoKNPRG6D8FJ45fjYe8VURA34k2RZ+afTWzwh1JTibGgxE6yFtU54e1KvaG+rCwMlLJkyV
	rLvv/o1ZIp2nuZZRsXHpfKs9T/U0njtI/OnTfwuTzG+/be7798QCY1Z/RiA5mAiUiPLidAMpGNKsP
	esZi7/GHn+Mnm8BC3o2wKRBnyD2FHP6918mMK7faWRucLl4vOtwnfV2TphXfFrKYgv97NIrI3+Vhb
	YGRYCW8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdCyH-00000007cvB-03If;
	Wed, 29 Jan 2025 18:39:29 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdCyE-00000007cun-2lUi
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jan 2025 18:39:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6566BA41B3A;
	Wed, 29 Jan 2025 18:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D088C4CED1;
	Wed, 29 Jan 2025 18:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738175964;
	bh=inaXZEkG5qTCLCyeiXKTHQhfKOCqT5k0FMO8Ol4EZ+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iIZ+NEVDyjE1YJe7CwGx1Ygfu6g1cMwv9niAOvE6oZs34VQWisZncgQreB9O/qiKL
	 3AfHkcFPH/efQeNQNajKZsT8t9Ewb20fIzrkANYOrktm2n9mda6+TrdxpVF1oqxcTe
	 BZi8nsTO+TFuqS+VG6QclmoFxJv2JEtb0lgBVaA5Cp+qy8SBZIfYhQvb7g7DB//qOE
	 tvFMA+o60FeCFJNmSLpRKnbG6MIGZ+gX+klNAeRI+voiWIM7jLu28PyMN+r3IC1/Y+
	 7jC8ouR0ZzkOU2bkZTBPFg0WP0v2aKsjugN1ZzDMqBRDlAeN4LH+cLsuSV4hNcuuL8
	 EbMuNi5J6DIIw==
Date: Wed, 29 Jan 2025 11:39:22 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] nvme-fc: use ctrl state getter
Message-ID: <Z5p12hWxmdIadNIX@kbusch-mbp>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
 <20250128-nvme-misc-fixes-v1-2-40c586581171@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-nvme-misc-fixes-v1-2-40c586581171@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_103926_766411_1CB4A9A4 
X-CRM114-Status: GOOD (  10.49  )
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

On Tue, Jan 28, 2025 at 05:34:47PM +0100, Daniel Wagner wrote:
> Do not access the state variable directly, instead use proper
> synchronization so not stale data is read.
> 
> Fixes: e6e7f7ac03e4 ("nvme: ensure reset state check ordering")

Thanks, applied to nvme-6.14.

