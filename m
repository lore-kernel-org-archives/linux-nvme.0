Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20962C25B78
	for <linux-nvme@archiver.kernel.org>; Tue, 28 May 2024 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E72VNMMRl+RXlZGqXeXEuaM3f+4RjpoNFOHOndOAu2Q=; b=I++jLp/5S1BDdu8btrc17QAuXJ
	HSRQ3fPcBlSoJC6/95NkInL3i5dqnwdOSkK01bwaKPxjQJP9yVuo4PgB/36rB4TZHl31XcPFhH9bH
	i8Hu+zcA27mFsjEAShJta/SaO/put3srdgST8mWyC1hc4VvAuym7eWeB98qs/yY82trYFW94AAri8
	CiShu7LzcZemZkVL9UXodZSjpE2qzULCGlHq5YA82QZcYxmffJZaqLqOn3xBdOyvRjoYNnMd8FtNH
	3hyqTby4T1faa7bWGdt6j/Gqq09PVROUPPXQJ6QsDpZab17wVeltXetzja81dEiIxCeux1MEnicm9
	DQ29+Ngw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sC0PI-00000001W3d-1jNK;
	Tue, 28 May 2024 17:14:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sC0PF-00000001W1t-2HIp
	for linux-nvme@lists.infradead.org;
	Tue, 28 May 2024 17:14:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D1144621DA;
	Tue, 28 May 2024 17:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4BEC3277B;
	Tue, 28 May 2024 17:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716916475;
	bh=No/Gi/HpeH76ZsRrL+raF7fkOmQhMOhRCJh5D9IGl7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBLY/I5yg3N6WLrDNCXfsjfVqBMCV8Qkk0A2ecwLVCLbVEeBHCjXgG8/653XV0LHn
	 EHKeCvc+k+WILh1rBrgtHhNoAVCJSsbxeOBYD1xaFnAfyPd4pkvsTyYJ9M/gKKbsOE
	 Yy7nTKXbulaebxDqi8r+xQX16N/DY7ExUJkQjSXIhlN9ZhF0rIroKeFEZMV1k0XaUW
	 M2or5F2qh8T2owvEHcOLvnDTYKIeuJhXS/f1nNcuh4gU2dPF6xsj1q5C9HF530iqZp
	 ouq8CL9xkLtOHTHk/B6PFndmg6biHER3nEzP59BNZJf1jkhIWPlELFboDf2LdPDxAc
	 pufgVWKL/OLMw==
Date: Tue, 28 May 2024 11:14:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: fix a possible leak when destroy a ctrl during qp
 establishment
Message-ID: <ZlYQ-A_FSLvYi3Bl@kbusch-mbp.dhcp.thefacebook.com>
References: <20240527193852.252090-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527193852.252090-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_101437_644331_3B834FEB 
X-CRM114-Status: GOOD (  15.79  )
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

On Mon, May 27, 2024 at 10:38:52PM +0300, Sagi Grimberg wrote:
> In nvmet_sq_destroy we capture sq->ctrl early and if it is non-NULL we
> know that a ctrl was allocated (in the admin connect request handler)
> and we need to release pending AERs, clear ctrl->sqs and sq->ctrl
> (for nvme-loop primarily), and drop the final reference on the ctrl.
> 
> However, a small window is possible where nvmet_sq_destroy starts (as
> a result of the client giving up and disconnecting) concurrently with
> the nvme admin connect cmd (which may be in an early stage). But *before*
> kill_and_confirm of sq->ref (i.e. the admin connect managed to get an sq
> live reference). In this case, sq->ctrl was allocated however after it was
> captured in a local variable in nvmet_sq_destroy.
> This prevented the final reference drop on the ctrl.
> 
> Solve this by re-capturing the sq->ctrl after all inflight request has
> completed, where for sure sq->ctrl reference is final, and move forward
> based on that.
> 
> This issue was observed in an environment with many hosts connecting
> multiple ctrls simoutanuosly, creating a delay in allocating a ctrl
> leading up to this race window.

Thanks, applied to nvme-6.10.

