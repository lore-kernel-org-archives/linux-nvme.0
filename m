Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAFED172AB
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 01:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VBoUmLCN52TtNBbpEuxtWOTLGroUGAbnpWZuwFniV6s=; b=Zu5BQi2JiqBRXd0Nuauam6x5WN
	pjQZtYpIBPEWi3ddBi9PXcVaA+AsQxWWlUTs/i1NTOXekQ/PvdmwTBM2MTJ+zLhwFrQbe/QT4bp79
	0mUexBhUEDaAmqQiD1dW5ET6RYTwuw6pkFK3h57O+hCDgNx+b/juCcGOPcD/HhEmsBfOeBIzNVsMv
	SFchbqic84UParjpyB/o0YzWW/tEra4rrcdTNGKKf/OV0uGhNh4AnHr8QEsLUWL2unNNxU8CbFx+T
	Rzp35eIzv+TQkiPJkTCmQI3qM+kUKpLD3jwGEnA+GM9mMhAWstIIM0bolMI2/Qt9Cxb+n0dOtSW3I
	NMsEsSbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmj1E-00000004JRq-2Ab9;
	Mon, 02 Feb 2026 01:46:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmj1C-00000004JRR-0pbt
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 01:46:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 77F3640790;
	Mon,  2 Feb 2026 01:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C243CC4CEF7;
	Mon,  2 Feb 2026 01:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769996780;
	bh=mEtcjx/Rh9K5sMQHHB2eXHLBQKobn1llQUzLZc/8KzI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=EBnwNml1FTyPW4lDYiuSrsPBx3e0caCyJcmPRXRw3IAl1BsxBvOsoXLZAP/U+rXQx
	 WCAhNjjDnmtb24gjSFYpYZZRbVWteCXWNBQvc7p6YiQ2UYTPcP4oDahTvvbjnkDf5q
	 0CfsAyko5Aa+YiCCc7VtzRbrGA7SKYdJDs/JfDTYdp2gRImPHPbhr6A9PwO2bvRR1v
	 V558wPm3Tfk2eXc5mXxwBxAtizAuas+pj2sG5bzp+G3n41wR4pOoAsny0d+Ueh48+Q
	 d4Mr+gOkzcW3sBbYuSbU23VJU4wownDwGyVJv1tgm4KewqbBMYCRm2952H7wahelou
	 +pr7Vb0iz7F4Q==
Message-ID: <7ec5f552-197f-48be-9898-9cc4233783fc@kernel.org>
Date: Mon, 2 Feb 2026 10:46:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM?BFP TOPIC] Block-layer device resets
To: Hannes Reinecke <hare@suse.de>, lsf-pc
 <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260201_174622_264219_5F2ABD3F 
X-CRM114-Status: GOOD (  15.47  )
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

On 2/2/26 02:06, Hannes Reinecke wrote:
> Hi all,
> 
> We are currently working on implementing cross-controller resets for
> NVMe, which requires to send a command to the target which then should
> terminate all commands on a given controller.
> While we could easily terminate the controller, the specification
> also requires us to terminate all outstanding commands.
> Which then recurses into my all-time favourite topic on how to
> abort outstanding commands from the fs/bio layer.
> 
> However, here we don't have to dissect/match to individual commands,
> but rather have to abort everything, which seems rather easier.s
> 
> So I would like to fathom whether such a thing is feasible/reasonable
> (I think so, obviously, and can think of several other use-cases, too,
> qemu springs to mind here ...) and discuss possible implementations
> (set 'req->deadline' to zero for all pending commands?).
> Or maybe we can do such a thing already and I'm just not aware of it...

Hmmm... Command timeouts ? E.g. if a controller is slow to respond (send
completions), the block layer timeout timer may trigger, which will call into
the low level device driver to force a reset. But before the reset actually
happens, completions may actually come back, and we do handle that race
correctly, well at least for scsi/ata.

Your scenario sound very similar to this: once you reset the controller,
whatever was pending will be silent and can be aborted or retried. So it does
sound like that should not be too difficult, no ? Generalize the timeout
processing or do something similar ?


-- 
Damien Le Moal
Western Digital Research

