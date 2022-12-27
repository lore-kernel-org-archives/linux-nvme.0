Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F29C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Dec 2022 16:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OZET99rY5ID51nbHPaTMeAZlJRD81wvFC1CkrlPZeqo=; b=X8Bpfr6fvhJIevBBncTk1ZPHaf
	SpbnsUX4HATsCcLIUiRNamlfUKE72du77W5j+r5TqiB7DFvD7vWBDnvWZdCFb35r2JyKUPYv8H4OA
	NqQLKiCtQxGo1IEJDcPIX7qy0NQx5Ku3BrauDPyJl5/y16BdVgReVqAoz9SCDhXtlbnZo4MyzTW5a
	LVZzfKxGGROPnJPE8OBJ9kBQqd3ftEqYz3YWW9qHWU491+mkveuDQbdoH7durTwiTZrMkTfeqpWye
	67ugGz/YW3GlRv+bWdbGmrjdRDi0Zu9kEtWt/6iNgrLMbq1MgW5ePgvOrDNvef+5y1Cxa6wh0Ni3p
	xM6U/1Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pADHG-00Eh5Y-9W; Tue, 27 Dec 2022 16:58:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pADH9-00Eh0v-Bi
	for linux-nvme@lists.infradead.org; Tue, 27 Dec 2022 16:58:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBA286732D; Tue, 27 Dec 2022 17:57:54 +0100 (CET)
Date: Tue, 27 Dec 2022 17:57:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/6] nvme: also return I/O command effects from
 nvme_command_effects
Message-ID: <20221227165754.GA7716@lst.de>
References: <20221223071814.43564-1-hch@lst.de> <20221223071814.43564-6-hch@lst.de> <74cdb20e-2f38-f001-0b82-cca2b3046df9@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74cdb20e-2f38-f001-0b82-cca2b3046df9@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221227_085803_566960_A842C4E6 
X-CRM114-Status: GOOD (  18.08  )
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

On Sun, Dec 25, 2022 at 12:26:35PM +0200, Sagi Grimberg wrote:
>> +		if (ns->head->ids.csi == NVME_CAP_CSS_NVM)
>> +			effects |= nvme_known_nvm_effects(opcode);
>>   		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
>>   			dev_warn_once(ctrl->device,
>> -				"IO command:%02x has unhandled effects:%08x\n",
>> +				"IO command:%02x has unusual effects:%08x\n",
>>   				opcode, effects);
>> -		return 0;
>> -	}
>>   -	if (ctrl->effects)
>> -		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
>> -	effects |= nvme_known_admin_effects(opcode);
>> +		/*
>> +		 * NVME_CMD_EFFECTS_CSE_MASK causes a freeze all I/O queues,
>> +		 * which would deadlock when done on an I/O command.  Note that
>> +		 * We already warn about an unusual effect above.
>> +		 */
>
> I think it would be helpful to warn that we are masking it out? The
> warning above does not directly relate to the cse mask, but rather anthing 
> outside of NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC ?

Well, all these effects are unusual for I/O commands, and all the
effects really are hints to the host.  But if you think we can do
better, can you send an incremental fixup?  We'll need to get
these fixes in ASAP to fix the gapping security hole, or just
revert the unprivileged passthrough for 6.2.

