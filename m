Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CC6C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 12:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vrgN9MnjJ7oOBLsvkAJh1j/JC1H7TGyytBcA28Fy8jE=; b=hRhdb7QprekHMWdQGkO9S5/ydr
	T8ni0JmTG/hjLgHM24hOFh7NhZ437u22RvQf9bLvjIj0HEjaiobIR/12tJ4NRwBDFnTMNrobblcog
	hye1ThLFbP79bNfm4ILCRHlLOMubCa1rhy4zpf95ELvTGNegt+d7V8iZbia65+h8TubX7jYxp3dMe
	waqLky/uuf03TvIzaJheuEHymDuO3zb1AZiKVfE2X20MC16lCgp+xhavIJIPFpMjN6Sul4KoHWpO7
	Ni9ftUKfhfa4clgoJlX6+gPSB6M1k8tOx4JvjPF7ZT5wudx2/bpm0M7wxGz7rWczWx/r/XKXjXV8V
	OJOH6r0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp8FH-00GIXj-AK; Mon, 22 Nov 2021 12:16:27 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp7yx-00GCnz-Cb
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 11:59:36 +0000
Received: by mail-wr1-f45.google.com with SMTP id d27so32246889wrb.6
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 03:59:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vrgN9MnjJ7oOBLsvkAJh1j/JC1H7TGyytBcA28Fy8jE=;
 b=6t5/QHVeISr6j61iUdx+FfTmNxiTc3WnTYJJfkNNsFTUWHCItoCXeIicEyUl70rpAo
 2+1PFUr+tqagKML/WwNDuOPl9isE5ChQBTKJAzvq3jtWwotS++oV+8R+zoPvLEqxvat6
 M8T4yysdvRU2PdS2b4Cz2ujshfGIEdXHTtAcora1rf8Ufh3zcOklWzG2KwW7/KRpevPf
 nfecEVX2+FW36+F/2mxBD6UYTldhbruMcP74hibKRNwMlv++KyV87FtVpBFEyUmHJg65
 04t9XhJtxIpKv4f75Y5TWDGruQ8S2xop+lkqQqsFy+adwXJ/ua1gcWyQnEp3SkJ3b+tW
 wakg==
X-Gm-Message-State: AOAM533wYEjRzu+qpDyR/4gCwkyHIAqGp82CJ1n3WWXvaQrmwSPEbAQw
 NMC/did1gTDc8qSw4JT0Ja8=
X-Google-Smtp-Source: ABdhPJwXHavACABjx7ayc+48465bS9rRR2AF/hZPypUThIgONS0oEzAYtzI8JXW1+StP3/ge1C2mTw==
X-Received: by 2002:adf:d1e3:: with SMTP id g3mr38818829wrd.300.1637582373420; 
 Mon, 22 Nov 2021 03:59:33 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id d9sm8536969wre.52.2021.11.22.03.59.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 03:59:33 -0800 (PST)
Subject: Re: [PATCH 10/12] nvmet: Implement basic In-Band Authentication
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herberg@gondor.apana.org.au>,
 David Miller <davem@davemloft.org>, linux-crypto@vger.kernel.org
References: <20211122074727.25988-1-hare@suse.de>
 <20211122074727.25988-11-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <762ce404-9035-30ca-078d-eb0b36223e4c@grimberg.me>
Date: Mon, 22 Nov 2021 13:59:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122074727.25988-11-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_035935_484679_FB803A85 
X-CRM114-Status: GOOD (  14.66  )
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


> +void nvmet_execute_auth_send(struct nvmet_req *req)
> +{
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	struct nvmf_auth_dhchap_success2_data *data;
> +	void *d;
> +	u32 tl;
> +	u16 status = 0;
> +
> +	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		req->error_loc =
> +			offsetof(struct nvmf_auth_send_command, secp);
> +		goto done;
> +	}
> +	if (req->cmd->auth_send.spsp0 != 0x01) {
> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		req->error_loc =
> +			offsetof(struct nvmf_auth_send_command, spsp0);
> +		goto done;
> +	}
> +	if (req->cmd->auth_send.spsp1 != 0x01) {
> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		req->error_loc =
> +			offsetof(struct nvmf_auth_send_command, spsp1);
> +		goto done;
> +	}
> +	tl = le32_to_cpu(req->cmd->auth_send.tl);
> +	if (!tl) {
> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		req->error_loc =
> +			offsetof(struct nvmf_auth_send_command, tl);
> +		goto done;
> +	}
> +	if (!nvmet_check_transfer_len(req, tl)) {
> +		pr_debug("%s: transfer length mismatch (%u)\n", __func__, tl);
> +		return;
> +	}
> +
> +	d = kmalloc(tl, GFP_KERNEL);
> +	if (!d) {
> +		status = NVME_SC_INTERNAL;
> +		goto done;
> +	}
> +
> +	status = nvmet_copy_from_sgl(req, 0, d, tl);
> +	if (status) {
> +		kfree(d);
> +		goto done;
> +	}
> +
> +	data = d;
> +	pr_debug("%s: ctrl %d qid %d type %d id %d step %x\n", __func__,
> +		 ctrl->cntlid, req->sq->qid, data->auth_type, data->auth_id,
> +		 req->sq->dhchap_step);
> +	if (data->auth_type != NVME_AUTH_COMMON_MESSAGES &&
> +	    data->auth_type != NVME_AUTH_DHCHAP_MESSAGES)
> +		goto done_failure1;
> +	if (data->auth_type == NVME_AUTH_COMMON_MESSAGES) {
> +		if (data->auth_id == NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE) {
> +			/* Restart negotiation */
> +			pr_debug("%s: ctrl %d qid %d reset negotiation\n", __func__,
> +				 ctrl->cntlid, req->sq->qid);
> +			if (!req->sq->qid) {
> +				status = nvmet_setup_auth(ctrl);

Aren't you leaking memory here?

