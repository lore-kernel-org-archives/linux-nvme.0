Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75675C4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 14:49:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED6A60F8F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 14:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0ED6A60F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1ccXKVrwFy41C10ktsL4LpUJGm6B9JQpQgX407fF+Jw=; b=Ja2H9dvBW9gN+6
	n/l+pY+wfXRs16lyo8oeA1rE9atTPbbOZ1SEcYuEOx+CsP7paqT38bmid7UnTKIWqACm0cwrX1oFV
	JhoP1k1OuWo03ZogQAtgT6XpkCvk09xrqTyfotCqE2VPHbg5iCLRYAJ0eA1NHnLn2wJ5K3KeP1Twm
	W2m1iwvAbSfBxHvo3mXGvsWVP8VwzENLxD4opgpmOv93njnugtE3vH1Cd+eCyT8nb4auuxd1sAMjq
	SRqXlVuDvwwIM3rr5nUJ8oxAnm8CwviB7z3K9wwBgHRQlONW2VUOVu4i7EZJcO1rRhZofft7I12Oo
	tuiQ2a3ZrckQYumNrPng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mD6a5-000xdf-EU; Mon, 09 Aug 2021 14:48:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mD6a1-000xbY-NX
 for linux-nvme@lists.infradead.org; Mon, 09 Aug 2021 14:48:42 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BB0261019;
 Mon,  9 Aug 2021 14:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628520517;
 bh=YxGCosx6Qb/6ycNVS5XOq21l25CWneiWuwCydT/I3yM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fGgf9GjXj/Eyx5aiLslzwJ+L5BcMtEuA/9tabFCezKBMI0Iinr0pjR5LUlPFTJOS2
 fJEFBLemVb/22LxuFilXPfFINrYEJGMKcuO1sgbhmchJz59VIdkUBoL9PKpUTdruoC
 MElzXk9kwIZV3Q4zQZ0tUF83bXmjjuW+vC6syMetG1yymMe6UJEVFRu/0KQofnxc2W
 4R8DjJ4sS38eaARjCv4SYLhy9a6T/zuBVMHHMyaqmfFJW/5kLcgeM7KajAb63ePW06
 RXgTZ0yepUGFgyjKyM1HtdJvKWxivu4ba1RZIy+b5dycI0tQ8lx4cI/nmDesL+jOGW
 9CYEg1CS8rm4A==
Date: Mon, 9 Aug 2021 07:48:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sathyavathi M <sathya.m@samsung.com>
Cc: linux-nvme@lists.infradead.org, jg123.choi@samsung.com
Subject: Re: [PATCH] Formatted LBA SIZE[FLBAS]
Message-ID: <20210809144835.GA2583375@dhcp-10-100-145-180.wdc.com>
References: <CGME20210803061146epcas5p4c8970e93f59edec1d2293f8c6b4d4cb9@epcas5p4.samsung.com>
 <1627968552-32502-1-git-send-email-sathya.m@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1627968552-32502-1-git-send-email-sathya.m@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210809_074841_825177_5FF9E64C 
X-CRM114-Status: GOOD (  10.95  )
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

On Tue, Aug 03, 2021 at 10:59:12AM +0530, Sathyavathi M wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 11779be..49cca79 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1683,6 +1683,9 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
>  {
>  	struct nvme_ctrl *ctrl = ns->ctrl;
> +	unsigned ls_lbaf = id->flbas & NVME_NS_FLBAS_LBA_LSMASK;
> +	unsigned ms_lbaf = (id->flbas & NVME_NS_FLBAS_LBA_MSMASK) >> 1;
> +	unsigned lbaf = ms_lbaf | ls_lbaf;

I don't think you tested this. In addition to what Niklas mentioned, the
above is useless without informing the controller the host supports the
extended LBA format. You have to enable that in the Host Behavior
Support feature LBAFEE field.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
