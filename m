Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6737AC2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 21:19:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AED611CE
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 21:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AED611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j1aru7w+GPpjtBPQxw2lwnJmDTUx7rLUE2yn/cEp4uA=; b=CuZTOSsrRqt/Uf
	v00XHq7Siq2+ey5yWdAe0H432/qR2yrnzB2YU4kd2e667qPl4i940LBl4fQSHW7U1dw8XfZ1TtniA
	qhhbQPjQd7hn++OLGc+F88tBeHRwqNQlIBD+tVIYXqGq33hOTjSveZgcoKQ5bz0UjdWUt2JUowREO
	kLb6s+O2bzK65pPTG3hYz8VTYczIQHl13vZcjbGOiZYEbIiTtEenUMciyXV6J3WztVRo/665B5DEY
	ar2J3ZjI/bsS1uwRHQdwDcSBKzHDkyG8hFpMNX3a8WflAjxva/oOUkGUt05trZ+bPu3iIWallGhu1
	PtPNnW3ZkYNogdHB+uTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lstyu-00GCp8-PC; Mon, 14 Jun 2021 21:18:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lstyl-00GCoq-BA
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 21:18:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B54361166;
 Mon, 14 Jun 2021 21:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623705522;
 bh=Lw93FAoT4SoaPz8EpIA8xc9e7Mag8nyPVn7H1ueCj+Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Jcf9sw7GVn0swfj/U+588dDeEZCU9ynBO7tdTjnW4i33VJxA6hUBtsUioVa72G4cB
 X7Xh7sBIIz7HYkFoP/neBwECr7aQgsRHwpWunsxw/e1QqRM41dPu4Wjl06QtKMloZa
 mibqSwY+NozpANXlceIjNSeGvHPzvjh3Cynehjc02CXs8ec8gSeaJpITVlSlsgdJ5a
 D74Kk3qRsxMgvdJ2aKHSfd2qdzFto36BQc6+3l1TIEy7HNSlJTTllslUrwRTuAsica
 2rZH0O42nVxW2A25sBvAolba89gUG6Vi/qmKQT10yiZasx8yYZCW6HJS2c/MqNG2Qh
 0yyHpKviA/Bpg==
Date: Mon, 14 Jun 2021 14:18:40 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvmet: use U32_MAX value to report NN
Message-ID: <20210614211840.GA646237@dhcp-10-100-145-180.wdc.com>
References: <20210614194712.622-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210614194712.622-1-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210614_141843_423789_4F5D3012 
X-CRM114-Status: UNSURE (   7.49  )
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

On Mon, Jun 14, 2021 at 12:47:12PM -0700, Chaitanya Kulkarni wrote:
> @@ -393,7 +393,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>  	/* no enforcement soft-limit for maxcmd - pick arbitrary high value */
>  	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
>  
> -	id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
> +	id->nn = cpu_to_le32(U32_MAX);

The NN field has to have the highest valid NSID, and FFFFFFFFh is not
valid. That's reserved for the broadcast.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
