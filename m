Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D9CC1747C
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 13:45:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04AC21928
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 13:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r5rW+Llq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGEcsm2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04AC21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YPIA8WLeziNBBDxf5xZZqmU6l+/zmNnUsSD1zWzlYFU=; b=r5rW+Llq5YEE+T
	tD33wPYp3QdN7pqS0aFgAR6ZxQWIBF102GAWnFN7MUYEox41h0aNGD42/bqsRST+jOY2X3smbUm5j
	tg1lNitnkJSTCt1Q+uPE4h94WArk7PScgaGRzm0Iqwg6UxHOlbJHe9hyQ8vxKGsPGWAdWmeYqTh0L
	C2q4Z5gKosfuNQ+9NxHSIW1KYHiSN8MsSoXRCw0wQJOTzMkYbaFltmzvP0b1OVwCzapJgIY4b7VOK
	rug9nas2hxf8QRY+oQQ0gmCUQx2aDqyM4LT4EBJymow5soRzrr5lUR2Kanza0ewcAm11ShrHfZeYU
	njd+F4RTwzmaLeKu4v1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRz9O-0008O9-Mv; Tue, 05 Nov 2019 13:45:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRz9M-0008NM-5J
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 13:45:37 +0000
Received: from keith-busch (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D3EFB2190F;
 Tue,  5 Nov 2019 13:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572961535;
 bh=GjRxlpikeyeDN/rw0LpxxFgvOKipCcO5gvhIUekvdio=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZGEcsm2twiDy2NzK66eT8rTAYZvHHim/Ay9YGysBUMfpawkJ+ulzqGvF2JtlHiz8n
 UIknuNTv/KLglD/3WsyBA1K7beD7iaApdMOOYjuSksQ+IGc/bTEScyrSrlQVg+nzCu
 ir9gpSkHrnMPFslMZBU0QX08zknJVWeeXQGf58tc=
Date: Tue, 5 Nov 2019 06:45:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Marta Rybczynska <mrybczyn@kalray.eu>
Subject: Re: [PATCH 4/4] nvme-cli: ioctl: support 64-bit ioctls
Message-ID: <20191105134530.GA2462@keith-busch>
References: <436860210.90381688.1572941457980.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <436860210.90381688.1572941457980.JavaMail.zimbra@kalray.eu>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_054536_241288_0CEFF9F0 
X-CRM114-Status: UNSURE (   9.00  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <keith.busch@intel.com>,
 linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 05, 2019 at 09:10:57AM +0100, Marta Rybczynska wrote:
> @@ -600,9 +618,30 @@ static void nvme_to_passthru_cmd(struct nvme_passthru_cmd *pcmd,
>  	pcmd->cdw15 = le32_to_cpu(ncmd->common.cdw10[5]);
>  }

You're working off of some non-public fork, and a broken one at that.
See below.

> +static void nvme_to_passthru_cmd64(struct nvme_passthru_cmd64 *pcmd,
> +				   const struct nvme_command *ncmd)
> +{

User space has no business using a 'struct nvme_command'. That's for
kernel use only.

> +	assert(sizeof(*ncmd) < sizeof(*pcmd));
> +	memset(pcmd, 0, sizeof(*pcmd));
> +	pcmd->opcode = ncmd->common.opcode;
> +	pcmd->flags = ncmd->common.flags;
> +	pcmd->rsvd1 = ncmd->common.command_id;
> +	pcmd->nsid = le32_to_cpu(ncmd->common.nsid);
> +	pcmd->cdw2 = le32_to_cpu(ncmd->common.cdw2[0]);
> +	pcmd->cdw3 = le32_to_cpu(ncmd->common.cdw2[1]);
> +	/* Skip metadata and addr */
> +	pcmd->cdw10 = le32_to_cpu(ncmd->common.cdw10[0]);
> +	pcmd->cdw11 = le32_to_cpu(ncmd->common.cdw10[1]);
> +	pcmd->cdw12 = le32_to_cpu(ncmd->common.cdw10[2]);
> +	pcmd->cdw13 = le32_to_cpu(ncmd->common.cdw10[3]);
> +	pcmd->cdw14 = le32_to_cpu(ncmd->common.cdw10[4]);
> +	pcmd->cdw15 = le32_to_cpu(ncmd->common.cdw10[5]);
> +}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
