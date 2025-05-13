Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66150C3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 21:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OoJGXyW94J2XfBzKy8zCv7r/XXS+wVnkB3U9+mAKAk8=; b=yYtFRkf4l1e3EooRARxanrFuRf
	5DwRT53pg1DBQeSOu8JBcw1UxW3n3TSWKsXADhZ8hkSsMINJhKo5swTm5Kb4iYjopRDe+yeO1DUPn
	kfz0Km7xhHC/FI48WQCUDfB/qkerOMjYQMtJl17aktjfHDI4kDVD2uYD1mG7xZrYXNR3KJJAFYJlf
	lWsXYX4jLGrJa3k5APnQRHWL0HJmFPFe/CcyO9zDbO63qLQyfsj9LilVkVaVQRaomRE1DLbwqYNL9
	ZonWgHvDXAi93COiYXQ305bJMtpBxNLxCDnzOg1S5Hix83jrj2O8GI1ZACbSJ8xzHAq1fBUbAFJRc
	s6hlfxUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uExMO-0000000DZa9-12fe;
	Tue, 13 May 2025 21:40:24 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uExMM-0000000DZZo-2EGl
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 21:40:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AEA9B5C1024;
	Tue, 13 May 2025 21:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB97C4CEEB;
	Tue, 13 May 2025 21:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747172419;
	bh=QfJ0N0PQ/BWcSw0Db0PnnO9MzicDFrplFsD4HUF2UWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KtaaJFv4gAh/lM3yT000IHrfjiew5Lg7QckUjmVYuvW2dqluxfCiTIaytjZsNkFbr
	 YdHUXgIMgx6/XvUCNYykR16TC8SIvklnQgxTpetniENNFc/3G6JXBtora2Ke/1zjeW
	 QiU5y9ozoruSccWdf0OL0mmTCUbw8kWWjdcE63hU6JOrwhNjKKdHuNlQIyhmhxbExV
	 vmKXRfm3dwiCZiYanwFk0OOG+T4TLI++ggiy+SidtFVnNmvmzznv39m/ke7nN0E4ZN
	 20qQiA1IQYzuDGEhZaFm2nPlCIReyY0P6/OQEiWo/7K5kX75xp3xYGcwM+MfjrP0VE
	 0WA0i15zdowtg==
Date: Tue, 13 May 2025 14:40:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Sagi Grimberg
 <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C
 computation
Message-ID: <20250513144018.18770280@kernel.org>
In-Reply-To: <20250511004110.145171-1-ebiggers@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_144022_638026_B4610E86 
X-CRM114-Status: UNSURE (   6.86  )
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

On Sat, 10 May 2025 17:41:00 -0700 Eric Biggers wrote:
> I'm proposing that this series be taken through net-next for 6.16, but
> patch 9 could use an ack from the NVME maintainers.

And patch 4 from RDMA. Please repost once those were collected and with
the benchmarks you shared on Andrew's request. From networking PoV this
looks good.
-- 
pw-bot: defer

