Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC03C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yIQ6rivW5SQdDctz6C3Myxo8bBkbSYz2AwyKMRwfTbk=; b=aPs8gKa85GxCVNqWcLXRkN+fNX
	3qSjaUzoVV6FAKBjsUNEXbnDRPmDXp0XHLtz51yYXboLEw97GsA2xWPm9g7IdXv56YrTGzhU40WfP
	IFN13XlSodpy4pKLwCQZ8/BvPdCy1PnE6eihaL+Z3utBXEpHv1i70Vx4F+V++HxtD6rfQmVgozPpb
	CKecCKn2euEeDhKcIisiAIw6J5R0/QF9MA6jszOPsFR/LOODXFE2BAsDAKZ8sC0IyckmBb0ntKOpZ
	mT3uI3m2s6+dGYi9WAc3qb/HfTgJ3E3ymk7ITc5Qcn3KZFR0kcTrWCTrozm3SnzcCdCiTnWcdgeMs
	l6KZil6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGN43-003huj-0B;
	Thu, 21 Dec 2023 17:42:31 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGN40-003huM-15
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 17:42:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 87B1961A11;
	Thu, 21 Dec 2023 17:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD99C433C7;
	Thu, 21 Dec 2023 17:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703180545;
	bh=g+4pmvX+qrS+nipEi02hGyi+QkgWp2LmQ4Zpkkcxa5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0Kr6IWjCyA6huKEQSxdNKGJnWsgS2f9Lb3YNUUqcDfN9IHwScZBxjqhrFdJ+yKX7
	 SmQe7lwbRSdnNqRA30G8s7i7tBCPjwntsuAhWfEzuHa0wfgf7LuSCuGx4nLvW07cI/
	 6L7SX+WpdGSHXPCgmTrAF2ZyCMK6hrOCgwbY0cVj4WzON1qKKISmcdeb2pRkNzwTCL
	 TWj68Le1T6GdFntg1riuUZK9mSXzKBCp7kF6HLuxeFL8BrFj9d83j5/vPdmNaEOm8G
	 de1bJhnqOQoahYvaWvWytTtRTIv/rrrvRSuD7TRAPVtYegjR3BKfXy/138uAyNi6u8
	 V3VTIPKFRmaEQ==
Date: Thu, 21 Dec 2023 10:42:22 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: sagi@grimberg.me, zahavi.alon@gmail.com, hch@lst.de,
	chaitanyak@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvmet-tcp: Fix a kernel panic when host sends an
 invalid H2C PDU length
Message-ID: <ZYR4_ifqRtrwgwVt@kbusch-mbp>
References: <20231221163154.605669-1-mlombard@redhat.com>
 <20231221163154.605669-2-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221163154.605669-2-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_094228_442464_A4F98B5D 
X-CRM114-Status: GOOD (  10.87  )
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

On Thu, Dec 21, 2023 at 05:31:53PM +0100, Maurizio Lombardi wrote:
> @@ -1002,6 +1003,13 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
>  	}
>  
>  	cmd->pdu_len = le32_to_cpu(data->data_length);
> +	if (unlikely(cmd->pdu_len == 0 ||
> +		     cmd->pdu_len > NVMET_TCP_MAXH2CDATA)) {
> +		pr_err("H2CData PDU len out of range\n");

Please add the 'pdu_len' to the pr_err since that info sounds useful to
knowing which type of target error we're dealing with.

Otherwise looks good!

Reviewed-by: Keith Busch <kbusch@kernel.org>

> +		/* FIXME: use proper transport errors */
> +		nvmet_tcp_fatal_error(queue);
> +		return -EPROTO;
> +	}
>  	cmd->pdu_recv = 0;
>  	nvmet_tcp_build_pdu_iovec(cmd);
>  	queue->cmd = cmd;

