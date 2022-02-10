Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52046C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 20:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IbvrqV7Ns0pnCdRPVhO1zP3XP3stFKuz5SRmYbLKOCg=; b=DEzDnYDez8ydPF/FfAjUkisMM9
	Yv6MtoMehdu2qFgDWKncHrhE4hc7nRHTYPQd49vEthvTdwaJzFeVVCwdsrrRPEdtp/D0mcHLMtfT+
	GfAKjvdNzP8c3TR048L2G8pXjKrzaAbc5cXWdfF+dhdUsYJ+W0h0FXcTn9n66xm9pgHypMm5pGmap
	qFiQTxbfNJoQCtYm57qkym5KeRMKB8FGvHP5c9mh/BNJBOZo0xiu1V6FwrprVjCun54hGJdEZPqOF
	hzl0fN4VRWbjUQioio9JQGzfiGvSWaJCdZ33Xf5q3L5dFD1TCqtch+6TPmVfTzA0uY++ZH8SimXwK
	BayrnfIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIGVj-004urQ-A6; Thu, 10 Feb 2022 20:57:51 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIGVg-004umS-0u
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 20:57:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 86784B82726;
 Thu, 10 Feb 2022 20:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FDAC004E1;
 Thu, 10 Feb 2022 20:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644526665;
 bh=A5PEWqAB8nEJetdzoluo85KfvBoStC8tNmDbk7Uzpqg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hufVHiJsscm5zO92YC600YUxG27rFjQ8A3MII79WCKTeqhCyViaoFNo88BErZ6cBj
 l/DEMuqlL53lZIMY0imsxqZbtIaKD2ZMdofLg/Hp1CxEA7JVbWlDoxwRLMr9QcvB0d
 ZrTLAqdaBEWZqbkpC7mM14uSmfVOAoR4JuNLYBg8q0moF75A9gRfdReFOh/gDB4yyc
 5z7iJlf7y4miA3gwFXvoudjcfRJmuQi4dCubYCzKJ34/pu+Gk7yjgmCLAswCU6bEEJ
 7iw1h1JKyudD2MoslVLb3esr8OMoZUQl6cAJ/I/ziS2FU9gl8nary9VBvdLQhzfK1i
 8WfW6acFVtOmw==
Date: Thu, 10 Feb 2022 12:57:42 -0800
From: Keith Busch <kbusch@kernel.org>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: Re: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Message-ID: <20220210205742.GA1658422@dhcp-10-100-145-180.wdc.com>
References: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_125748_255229_5F3F8552 
X-CRM114-Status: UNSURE (   9.12  )
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

On Fri, Feb 11, 2022 at 02:23:28AM +0530, Nitin Rawat wrote:
> Enable quick suspend quirks for Sc7280 platform, where power
> to nvme device is removed during suspend-resume process. This
> is done to avoid the failure dring resume.
> 
> This enables simple suspend path for this platform.

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

