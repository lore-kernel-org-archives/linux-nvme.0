Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7053AC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 15:50:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E972164E22
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 15:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E972164E22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5mP0QHksneY9Xu4xRrPFlL8ua2cM0sOvKD+qoOSz8vo=; b=Oq9JYDfqXQI65RTijIzxkzvQ6
	0zQEuTcMnNt5BKfrGCLCfBaZDSoBgcJhYoHzySFMTaQ9yFukBd/03Ke3nph7tp/HT5gLfEVQxiK+J
	sSOrjtqGh1j5+c5Jm3kFQffzZLt0cdT12PVUTKDBrXRmYiHhDF0eYkvPuIStWUqbffwd+9PNPWBhu
	ktreoSudqYcvOBVbTKYe5X9PGpBhWNy61v2uvM0QT2xrYZLgdjQ6TYtLsokBeA1EeAZlimXKFnttg
	MG5cjA0jGMn5t26wk/9DZZinwFDGHaXSrOJOQABdrhxqzl/xse3YtTVN1+wTNrC6AQD27yOur7Hj1
	Ak2HuLuJQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKNZc-009VRh-GB; Thu, 11 Mar 2021 15:50:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKNZY-009VQn-4Y
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 15:50:01 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96C9764E22;
 Thu, 11 Mar 2021 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615477798;
 bh=RVdvtTqFvcTL7USK4q3ry8acSMA8juTax1dfPhJ3Hkw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Nrfl6ktFIoGIcylobsAhPc5zdMgn4e48MhLlWC+hcipmXVd3U/+4wH5svExadv/Jp
 SOp0XoKwDKq0PE+jGhEGdzHPLo6roYBLRhMgBuWyRt/VbAkTgP5Iczf9RAu9bqO2/2
 Frq02vr2bpUU9GOUaLKxZsq6rMWYjzt7dc0oU+Q44ybsguskZAvfS93zX3SLv3iC9O
 cPXehoBQ/oCTRaz4WirILXYEOrIpb/gNWpGf6sZjT3tr0ayLKbA+BPHMoChJP4OM7H
 5FEeqg7eQFerJt4CVBPSd3Y98MuvgpTUpojOZxnW82zUFHZiMg2uMWpI/Omn36H2D+
 +kgZVmwkh88HA==
Date: Fri, 12 Mar 2021 00:49:52 +0900
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de
Subject: Re: [PATCH] nvme: implement non-mdts command limits
Message-ID: <20210311154952.GB27105@redsun51.ssa.fujisawa.hgst.com>
References: <20210310195726.3377288-1-kbusch@kernel.org>
 <YEmv3nNynyBHggoz@apples.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YEmv3nNynyBHggoz@apples.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_155000_385046_E141241B 
X-CRM114-Status: UNSURE (   7.38  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 11, 2021 at 06:51:26AM +0100, Klaus Jensen wrote:
> On Mar 10 11:57, Keith Busch wrote:
> > +	if (id->dmrsl)
> > +		ctrl->max_discard_sectors = le32_to_cpu(id->dmrsl);
> 
> Since DMRSL is in terms of LBAs, should this use nvme_lba_to_sect?

We need a namespace for that, but we only have a controller for this
Identify.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
