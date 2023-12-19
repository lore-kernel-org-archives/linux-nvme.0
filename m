Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E4DC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 17:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kJ10Gh7ulhitqnXT2yEVvnjDN9RIWqqdh2qKFApKlEc=; b=RaZ+auu5p3G2OWd7iIHlMB3kk5
	GM2U6j8kvb2JPYnt8/cFBAEciQDgMQPmVfYoRZ/CBdVL2BXBPO1xmQYrvqg4g219JQBY5khKM57lP
	rQDsuReiCHfmG3XCQJPcFWWyykq9Z/dEyVyNHaz+24+YXmXpaESOEcpzsTU58onptR1kS66dsGaTY
	RaCX7Kfyprl+ze5x7QkZXC4hTw/fvI1sFNw6e6BJBkXPUqYtoVXsyIjQXdKsgyAEsB3lAmrFcLvHA
	EOhxgtQAsaaZALXRaH+9FFHbejYrwJUw5W5xVZQcnRc3PhBudXXI+d4n96s34wM3uKtBRhFK1phzt
	oX0DkF7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFdnF-00Eudg-2Y;
	Tue, 19 Dec 2023 17:22:09 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFdnB-00EucU-1s
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 17:22:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 503D9CE1A16;
	Tue, 19 Dec 2023 17:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37487C433C8;
	Tue, 19 Dec 2023 17:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703006522;
	bh=DICvnCkLbB3Uf9YeoHOWUQtBWc6Mqf8gwPj5yqKyXFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvnhz2+MubFC9cKtpsaKHMnC3zXlFgcaqQgTuhHEubiQv/48ClwKYJIZDqAhU6xN/
	 zpHIxEHC3BMBVi6AaGlDI0xe4EF4TDhGoMii6qjnSqpiHL9adcFT032BAXsLKTgnBU
	 iePULSXwoTv8B19e47nnIgttQ4pxjik0JlWgQUVd0cJDRc0cwm/1IdGdNs5P3voNsl
	 IbC3jxxaqeRArSR9M4OoVvclPNq2w+z/wv+LVq6PKawHTFvYv9FAgvjtDXCXz1MLze
	 7CxNaZ/oawDUte97yTkQ9orfZOgGEL3RxQuQKTm6BIQEcPME7PeCNywd0EDzLXNWAR
	 QC+udywlhzjIA==
Date: Tue, 19 Dec 2023 10:21:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: axboe@kernel.dk, linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH V3] nvme-pci: fix sleeping function called from interrupt
 context
Message-ID: <ZYHRN4-zKkbsfjC2@kbusch-mbp>
References: <20231219164823.442687-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219164823.442687-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_092205_846121_8ACD9740 
X-CRM114-Status: UNSURE (   9.41  )
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

On Tue, Dec 19, 2023 at 05:48:23PM +0100, Maurizio Lombardi wrote:
> the nvme_handle_cqe() interrupt handler calls nvme_complete_async_event()
> but the latter may call nvme_auth_stop() which is a blocking function.
> Sleeping functions can't be called in interrupt context
> 
>  BUG: sleeping function called from invalid context
>  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/15
>   Call Trace:
>      <IRQ>
>       __cancel_work_timer+0x31e/0x460
>       ? nvme_change_ctrl_state+0xcf/0x3c0 [nvme_core]
>       ? nvme_change_ctrl_state+0xcf/0x3c0 [nvme_core]
>       nvme_complete_async_event+0x365/0x480 [nvme_core]
>       nvme_poll_cq+0x262/0xe50 [nvme]
> 
> Fix the bug by moving nvme_auth_stop() to fw_act_work
> (executed by the nvme_wq workqueue)
> 
> Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>

Looks good to me! I applied this for 6.7 since it's a "fix".

