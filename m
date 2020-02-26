Return-Path: <SRS0=MxcY=4O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6EAC4BA24
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 23:28:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5597A20658
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 23:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kos3A6jD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5597A20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Tp8LyFgwOS0v72y5XZ5KhwC8bCE4tUPo9fGWWU7RrOY=; b=Kos3A6jDsG6ZRS1YsiOzol3uU
	5oK5xN3rVjTkya2g1bdYnGfhNZSlcseffgojvHQUJWtrW6A1WPu2mxJgcosnFZ59nqjbzOfr+yBsM
	htzLjXOSWbbMg0oaNJc/5K4WawZYsXBd+97DQ6rJWpX88VlxGqLQkBiMx2cCM3aFd/A26+AE343OB
	Yy/HS59FnryIFY1eM2dVILZ59LcyOm6AAHaATsHri5kBJf9nY9mhV3kuxd/DqJ921MfrRGVBLAcow
	BE8f2iWXxKg2RmMKl2giv+Hkai2ZhhuHwcBqgYR+MnZqw7mjJGKJSy/KBn4NO4vFl6DWLln9svQPo
	/jLJAwjoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j766C-0001PY-82; Wed, 26 Feb 2020 23:28:16 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j7669-0001P7-C9
 for linux-nvme@lists.infradead.org; Wed, 26 Feb 2020 23:28:14 +0000
Received: by mail-oi1-f196.google.com with SMTP id b18so1414943oie.2
 for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2020 15:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RyN8wdyx5UTXqhX47LF5ataeVQFJ6brgByOTBGpOppg=;
 b=hOQ5BMMu7uRsF/HrOM/3FUk13MW1sryrLAgHNc1u38MhPqS8geUtY4XeCmY/uMMb+M
 HCuHRl0xhDgDwglovrvQ1rjHLB43l3mWKh6R/uRTaQ/iYSVb/q2JG36J7TxMAC6TPNLk
 HFyr3EyXYZkgXAcFep8/v9UwJ5hBVeLthL/GZcrkfvQ3UUO9TfQi3hyWgvzcTWmgKpzt
 RiQ5IrWtd3ZizEeCXroaONNxS9jQkhyqHZquDd6dCEE7knsN8h+uQ92d1nP51nf6VFS6
 wfvC5zeSWfLazvIzenVg+tJte/9tZrakrr1TgF3DT/WMROUEHTYoMHBuz3Xe8Tg0ITAm
 5fGA==
X-Gm-Message-State: APjAAAVMFQqiXu/ecy7AlQ3KC+1pnclb+QqQz+Fh4oCmI33jYPGQ9Pr8
 7ATfLW2As0pJlrQZ8fcfqHk=
X-Google-Smtp-Source: APXvYqywzEAMuKK6yzb4V86yyPuzG2G22fxxXo68hGxc4vPFA1gUkbMBOPBA/0AWAh7A8BF3/Y2ufQ==
X-Received: by 2002:a54:468a:: with SMTP id k10mr1239874oic.3.1582759692462;
 Wed, 26 Feb 2020 15:28:12 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id n22sm1325231otj.36.2020.02.26.15.28.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Feb 2020 15:28:11 -0800 (PST)
Subject: Re: [PATCH v11 7/9] nvmet-passthru: Add passthru code to process
 commands
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20200220203652.26734-1-logang@deltatee.com>
 <20200220203652.26734-8-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <becbf34c-e22e-3c48-41df-f23fee2da658@grimberg.me>
Date: Wed, 26 Feb 2020 15:28:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220203652.26734-8-logang@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200226_152813_414973_40D96823 
X-CRM114-Status: GOOD (  17.60  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> +u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
> +{
> +	/*
> +	 * Passthru all vendor specific commands
> +	 */
> +	if (req->cmd->common.opcode >= nvme_admin_vendor_start)
> +		return nvmet_setup_passthru_command(req);
> +
> +	switch (req->cmd->common.opcode) {
> +	case nvme_admin_async_event:
> +		req->execute = nvmet_execute_async_event;
> +		return NVME_SC_SUCCESS;
> +	case nvme_admin_keep_alive:
> +		/*
> +		 * Most PCIe ctrls don't support keep alive cmd, we route keep
> +		 * alive to the non-passthru mode. In future please change this
> +		 * code when PCIe ctrls with keep alive support available.
> +		 */
> +		req->execute = nvmet_execute_keep_alive;
> +		return NVME_SC_SUCCESS;
> +	case nvme_admin_set_features:
> +		switch (le32_to_cpu(req->cmd->features.fid)) {
> +		case NVME_FEAT_ASYNC_EVENT:
> +		case NVME_FEAT_KATO:
> +		case NVME_FEAT_NUM_QUEUES:
> +			req->execute = nvmet_execute_set_features;
> +			return NVME_SC_SUCCESS;
> +		default:
> +			return nvmet_setup_passthru_command(req);
> +		}

This looks questionable... There are tons of features that doesn't
make sense here like hmb, temperature stuff, irq stuff, timestamps,
reservations etc... passing-through these will have confusing
semantics.. Maybe white-list what actually makes sense to passthru?

> +		break;
> +	case nvme_admin_get_features:
> +		switch (le32_to_cpu(req->cmd->features.fid)) {
> +		case NVME_FEAT_ASYNC_EVENT:
> +		case NVME_FEAT_KATO:
> +		case NVME_FEAT_NUM_QUEUES:
> +			req->execute = nvmet_execute_get_features;
> +			return NVME_SC_SUCCESS;
> +		default:
> +			return nvmet_setup_passthru_command(req);
> +		}

Same here.

> +		break;
> +	case nvme_admin_identify:
> +		switch (req->cmd->identify.cns) {
> +		case NVME_ID_CNS_CTRL:
> +			req->execute = nvmet_passthru_execute_cmd;
> +			req->p.end_req = nvmet_passthru_override_id_ctrl;
> +			return NVME_SC_SUCCESS;
> +		case NVME_ID_CNS_NS:
> +			req->execute = nvmet_passthru_execute_cmd;
> +			req->p.end_req = nvmet_passthru_override_id_ns;
> +			return NVME_SC_SUCCESS;

Aren't you missing NVME_ID_CNS_NS_DESC_LIST? and
NVME_ID_CNS_NS_ACTIVE_LIST?

> +		default:
> +			return nvmet_setup_passthru_command(req);
> +		}

Also here, all the namespace management stuff has questionable
semantics in my mind...

> +	case nvme_admin_get_log_page:
> +		return nvmet_setup_passthru_command(req);
> +	default:
> +		/* By default, blacklist all admin commands */
> +		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
> +	}
> +}
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 3d5189f46cb1..e29f4b8145fa 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -858,6 +858,7 @@ enum nvme_admin_opcode {
>   	nvme_admin_security_recv	= 0x82,
>   	nvme_admin_sanitize_nvm		= 0x84,
>   	nvme_admin_get_lba_status	= 0x86,
> +	nvme_admin_vendor_start		= 0xC0,
>   };
>   
>   #define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
> 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
