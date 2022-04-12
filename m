Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EAAC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sTf6CaGQuz/ihS5YBLGCrpGWdQ9cB/ENckuVFevj9p4=; b=bOs/XRoOE8XShrcgQ72vBQuRj0
	86la77T2JXd2yDlhRH1YYxTjzRIHUYrSRiL4LERAPdwqL/CYSS9rlWooXZQm2HZ+ZnUxSlwzfcsSi
	fPLtb1oUmSvvnepKUG3orm2f4WaNm7kdwj/YG9KTLMjkOKHgHT7GDCwhIIK2G5bb/MvNJA9In58Yd
	/d2q3qGY0PfsSEoRXWkWwhdRLerhrmoz1N9tAYs9sk0ZsZXgxoP3rHCW6ZLfwUGntvo4+AXZgJneh
	sXM7XvmGB+h1bWAxkqGzofADbuvBOGJETgBmAVF2OtGVs58vC0IENRvOBHITHOGYcoAfBimdOffWx
	KBruHDbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neHJx-00EkgG-O1; Tue, 12 Apr 2022 14:16:41 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neHJv-00EkfW-1s
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 14:16:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3BA5AB81B79;
 Tue, 12 Apr 2022 14:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA54C385A5;
 Tue, 12 Apr 2022 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649772996;
 bh=cykPs+aQyrwL9sxpGfAIzyI0hp5mEQxhDbdaztWK5Nk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kq9mBer5RSGhRvYrEZ+vd0a5N3sTjrSlA+m2N1vV6shHPmTPboArlkxLTSDL1mx2x
 Eifr73BcEncSkKn0m7czO77sOZNv5tpEMrzCKrel96XTgGnLQPfgN/iAQmu8DRnb4/
 YOqk7SN8SALuyBBOLvu9pKxLpZWNvhKg7W1HKpNzLvenwV2WF4wb/HI9tQCwuyop2X
 o97x3v/OYO5V3mZwbAKPZ0vbaOXYUTPM5AVSSxEJ1CO5VUUTBMzwq0tMPZDNeDWoGE
 Ko+iHOXMao9m0Hdfl1M76kJIY07gWihUz1VhpBRWP8d7UXv8p6Tu3dYMxWuCgL1SGl
 SRjjAI1nmd+oA==
Date: Tue, 12 Apr 2022 08:16:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Luis Chamberlain <mcgrof@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvme: add a quirk to disable namespace identifiers
Message-ID: <YlWJwGCRemelp3Ab@kbusch-mbp.dhcp.thefacebook.com>
References: <20220412061126.244414-1-hch@lst.de>
 <20220412061126.244414-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412061126.244414-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_071639_244866_C8685C18 
X-CRM114-Status: GOOD (  14.73  )
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

On Tue, Apr 12, 2022 at 08:11:24AM +0200, Christoph Hellwig wrote:
> @@ -1282,6 +1282,8 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
>  
>  	switch (cur->nidt) {
>  	case NVME_NIDT_EUI64:
> +		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
> +			return NVME_NIDT_EUI64_LEN;
>  		if (cur->nidl != NVME_NIDT_EUI64_LEN) {
>  			dev_warn(ctrl->device, "%s %d for NVME_NIDT_EUI64\n",
>  				 warn_str, cur->nidl);

Shouldn't we still verify that cur->nidl is accurate rather than assume the
length? If it is the wrong length, then we have a corrupt descriptor list and
should abort the process.

