Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74113C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:14:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D44C20748
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kU/kScaS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="QbYmILsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D44C20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p9Y20uVrHg5bE1rTCwUmZcNEmTB6YksXDJgHwrZbdew=; b=kU/kScaS06mLRcpkeiFr73sVv
	rYYDAbxkwSmjaWXga9CcFGS7/E1lclt6oqQ4AlAvFQZ//UTljdfewKEXRQ6PEFnZTFdk+QODhak91
	e9pWfgbi9PDqFBH0ixlcWnmo4VffluSTBl7lnrdWAY2qrg0oTE1DbgPlx5xXta8bfhaF6v7pqt5iE
	H6+ZFQf8+Nhp4brVMfL4r8YNngybynFhzQZqJmGzT8Q1vXOqc5eRRs/s006CmHv8AccZamHiI/o/8
	5vK+nSZO0wyKIM954l+imkC3pzrDXxLwn01quMDpt1rlCeRfiasEAyOpiQEddhmxfr4yO6CAffkcM
	tD/SbBtpA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5G3X-0000rn-QU; Mon, 10 Aug 2020 22:14:11 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5G3V-0000rM-8D
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 22:14:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RGCPrLSqDJ2RfjoN5WcerxBI7jeV/Fa5ZwBmBDtqP14=; b=QbYmILslydBU+kDFP+3lMTO18v
 CFHMQk6yx87lK0v6mSafhuK0HKXX2K6IT3t5E3VV7mUoMQdmqjiFL3cJIxOrZYrShISPFTllfD0zT
 wNoxKvoFT27In2nFnd6WBJ2zLgX7eQOZxRlqRR7NQysRaRCVsTuoD2OiUX8yyzF22k2zYXmtGUrNE
 rFBeeRqUZO45ft5YypChHAPa2qYtwBWIJYT0a2PbaaEnpI3vhO36Faa7TaofOrgH6LfFS1Scnf8tw
 RO3RjVM8KLPN4Jw22V39tA9mH4DDTB/4LnKY3zyjljBvwXFW1Bud+seBpEeHqmtHIbJKjdK3VqOeP
 VSD1XwLA==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1k5G3S-0000lL-6C; Mon, 10 Aug 2020 16:14:07 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-9-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ec013b0e-e9ac-f6b1-3285-d281a81f74a0@deltatee.com>
Date: Mon, 10 Aug 2020 16:14:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810185456.7713-9-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
 chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 08/14] nvmet: use nvme write cmd group setting op_flag
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_181409_335029_993A8FC8 
X-CRM114-Status: GOOD (  21.02  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-10 12:54 p.m., Chaitanya Kulkarni wrote:
> The function nvme_is_write() only checks the last bit of the opcode to
> determine if command is a write command or not based on that it sets
> the bio->bi_opf for passthru bio with REQ_SYNC | REQ_IDLE.
> 
> The condition is true for nvme_cmd_write (opcode 0x01), but there are
> commands present in the NVMe command set and are part for NVM Write
> Command Group that doesn't have a last bit set. e.g.
> nvme_cmd_write_zeroes 0x08. With current implementation for these
> commands we will never set the REQ_SYNC for bio->bi_opf even though
> command is from NVMe write command set.
> 
> For passthru backend introduce nvmet_write_cmd_group() and use the
> commands from NVMe 1.4 spec write command group to set the REQ_SYNC
> flag for passthru bio and update nvmet_passthru_map_sg accordingly.
> Since these are low frequency commands annotate condition with
> unlikely respectively.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/passthru.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index 0b18038c44bb..5f06f4290c52 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -176,6 +176,29 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
>  	nvmet_passthru_req_done(rq, 0 /* this value is not used for request */);
>  }
>  
> +static inline bool nvmet_write_cmd_group(__u8 opcode)
> +{
> +	bool ret;
> +
> +	/* NVM Express Revision 1.4 Figure 462. */
> +	switch (opcode) {
> +	case nvme_admin_format_nvm:
> +	case nvme_admin_ns_attach:
> +	case nvme_admin_ns_mgmt:
> +	case nvme_admin_sanitize_nvm:
> +	case nvme_admin_security_send:

All of these admin commands are rejected as INVALID_OPCODE in
nvmet_parse_passthru_admin_cmd(). So adding them here seems confusing at
best.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
