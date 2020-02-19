Return-Path: <SRS0=nRQ2=4H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF56C34047
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 15:02:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35FAB207FD
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 15:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oPuPpe47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FAB207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p5bMT476RwT4AxZmal00kQpEvUyzNh87DbLLlntXZ5I=; b=oPuPpe4788V+t2
	mX3bAATih/1VX6ZZIJvE13l6z2MVGCiGI49lJbGkyAsrwuYQmvLfgXfl1DmZduXNyKznngGSpEnng
	t1b8filXCBnxuTn8CS+3+sfGLT/W5PsuxcT/Yuj1MxKR7qNvoqg182b6k9yCuzZU7LOKnPVDOGmWs
	NZwhCvhX0uRmbPzY3dGM5N1mvxSevn2WctD7otRirA6xmyeAIHIgIw7J1K2UYXzpUBMi4QtaxdSee
	cUWMB/DzX+fmIEkY9fPYQLQBNsq6aEl+fO6lvaxaG9GjlB/hlDrGK9rwF1uhohkg+x9PPJxirtUw6
	WwwKU2W7uFlHxH6jDTPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4Qrl-0004Az-1M; Wed, 19 Feb 2020 15:02:21 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4Qri-0004Ag-5L
 for linux-nvme@lists.infradead.org; Wed, 19 Feb 2020 15:02:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CD0BE68B20; Wed, 19 Feb 2020 16:02:15 +0100 (CET)
Date: Wed, 19 Feb 2020 16:02:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2] nvme: code cleanup nvme_identify_ns_desc()
Message-ID: <20200219150215.GC17748@lst.de>
References: <20200215011303.4589-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200215011303.4589-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200219_070218_354391_B64E4E8E 
X-CRM114-Status: UNSURE (   9.68  )
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
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
> +				struct nvme_ns_id_desc *cur)
> +{
> +	const char *warn_str = "ctrl returned bogus length:";
> +	void *data = cur;
> +	int len;
> +
> +	switch (cur->nidt) {
> +	case NVME_NIDT_EUI64:
> +		if (cur->nidl != NVME_NIDT_EUI64_LEN) {
> +			dev_warn(ctrl->device, "%s %d for NVME_NIDT_EUI64\n",
> +				 warn_str, cur->nidl);
> +			return -1;
> +		}
> +		len = NVME_NIDT_EUI64_LEN;
> +		memcpy(ids->eui64, data + sizeof(*cur), len);
> +		break;
> +	case NVME_NIDT_NGUID:
> +		if (cur->nidl != NVME_NIDT_NGUID_LEN) {
> +			dev_warn(ctrl->device, "%s %d for NVME_NIDT_NGUID\n",
> +				 warn_str, cur->nidl);
> +			return -1;
> +		}
> +		len = NVME_NIDT_NGUID_LEN;
> +		memcpy(ids->nguid, data + sizeof(*cur), len);
> +		break;
> +	case NVME_NIDT_UUID:
> +		if (cur->nidl != NVME_NIDT_UUID_LEN) {
> +			dev_warn(ctrl->device, "%s %d for NVME_NIDT_UUID\n",
> +				 warn_str, cur->nidl);
> +			return -1;
> +		}
> +		len = NVME_NIDT_UUID_LEN;
> +		uuid_copy(&ids->uuid, data + sizeof(*cur));
> +		break;
> +	default:
> +		/* Skip unknown types */
> +		len = cur->nidl;
> +		break;
> +	}
> +
> +	return len;

Each of the cases could just return the length directly and thus avoid
the len variable.

> +}
> +
>  static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
> -		struct nvme_ns_ids *ids)
> +				  struct nvme_ns_ids *ids)

Gratious change from one common coding style to another.  And one that
I find more annoying as it needs more work for trivial things like
name changes for the identifiers..

> +		len = nvme_process_ns_desc(ctrl, ids, cur);
> +
> +		if (len < 0)
> +			goto free_data;

Gratious empty line above.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
