Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B05CC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 13:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kgbQA4VO8Brp7kqvGpioMnLbrB6/onwWX4pk06EK7Ws=; b=dF1xS+aIiaEpf11AJb5A2fzJCT
	EQ2rHWvhigpeEKfL7AYRbybyd9CH6xo4E6hGVvMgT8OSGsVsFjjAZvibwLrc2LvA1wU6vGz6PRWIP
	Gux01n2z1+0vSvCoPmrH0z0fKMzFA3y3seRAWVyOYAWUipe/Ag9gn31E9iDIIBHVO1QJeizYc2b5W
	qQsYPUiI3rlBjUnPvptT6THAuA6Ockj1+3g8hIZIYCNS0+0mvq6Jg2Yko6vuy0C03V/j6BQHqHEGY
	KJMwcnb6zGAKaFkaYQOwR/8rP9mHXGlknZ54MwKbpJOCblsW5PMsvg9eJoGyW6sTnYQvmWREj6jZ2
	X97P6zHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp9G0-00Gcm7-HP; Mon, 22 Nov 2021 13:21:16 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp9Fp-00Gcjl-Rv
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 13:21:10 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2111C1FD26;
 Mon, 22 Nov 2021 13:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637587264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kgbQA4VO8Brp7kqvGpioMnLbrB6/onwWX4pk06EK7Ws=;
 b=O/yVR1ocsSC+WMXRd2ios8z4zqPD+lN0sTjx9WmcgqxFLdnxeEoI1ekckQ9Y4ZMWK+MhHp
 zHhsYkvWZnfB6Wz5eRx61Ihf4gckZOzqp6Bi/2d5x+39Rc6Lrpy/qani15RYc+oOw/G/FI
 UiyVndizjjYmBWPJP1wLuopvItHOtPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637587264;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kgbQA4VO8Brp7kqvGpioMnLbrB6/onwWX4pk06EK7Ws=;
 b=swtzo2AHVGq/M+pQxc4oAOyfqiJAqObW2NfuXC23XRGRMtO4ux2Kt3mk6pdUE5dym99NgR
 LkOLLesXzpiWtXDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A8DC13C97;
 Mon, 22 Nov 2021 13:21:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ItpiFT+Zm2ECUgAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 22 Nov 2021 13:21:03 +0000
Subject: Re: [PATCH 10/12] nvmet: Implement basic In-Band Authentication
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herberg@gondor.apana.org.au>,
 David Miller <davem@davemloft.org>, linux-crypto@vger.kernel.org
References: <20211122074727.25988-1-hare@suse.de>
 <20211122074727.25988-11-hare@suse.de>
 <762ce404-9035-30ca-078d-eb0b36223e4c@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <313b19d2-ea54-ce1c-f9cb-3f1fb6743787@suse.de>
Date: Mon, 22 Nov 2021 14:21:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <762ce404-9035-30ca-078d-eb0b36223e4c@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_052106_074534_87A1D060 
X-CRM114-Status: GOOD (  15.80  )
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

On 11/22/21 12:59 PM, Sagi Grimberg wrote:
> 
>> +void nvmet_execute_auth_send(struct nvmet_req *req)
>> +{
>> +    struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +    struct nvmf_auth_dhchap_success2_data *data;
>> +    void *d;
>> +    u32 tl;
>> +    u16 status = 0;
>> +
>> +    if (req->cmd->auth_send.secp !=
>> NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
>> +        status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>> +        req->error_loc =
>> +            offsetof(struct nvmf_auth_send_command, secp);
>> +        goto done;
>> +    }
>> +    if (req->cmd->auth_send.spsp0 != 0x01) {
>> +        status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>> +        req->error_loc =
>> +            offsetof(struct nvmf_auth_send_command, spsp0);
>> +        goto done;
>> +    }
>> +    if (req->cmd->auth_send.spsp1 != 0x01) {
>> +        status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>> +        req->error_loc =
>> +            offsetof(struct nvmf_auth_send_command, spsp1);
>> +        goto done;
>> +    }
>> +    tl = le32_to_cpu(req->cmd->auth_send.tl);
>> +    if (!tl) {
>> +        status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>> +        req->error_loc =
>> +            offsetof(struct nvmf_auth_send_command, tl);
>> +        goto done;
>> +    }
>> +    if (!nvmet_check_transfer_len(req, tl)) {
>> +        pr_debug("%s: transfer length mismatch (%u)\n", __func__, tl);
>> +        return;
>> +    }
>> +
>> +    d = kmalloc(tl, GFP_KERNEL);
>> +    if (!d) {
>> +        status = NVME_SC_INTERNAL;
>> +        goto done;
>> +    }
>> +
>> +    status = nvmet_copy_from_sgl(req, 0, d, tl);
>> +    if (status) {
>> +        kfree(d);
>> +        goto done;
>> +    }
>> +
>> +    data = d;
>> +    pr_debug("%s: ctrl %d qid %d type %d id %d step %x\n", __func__,
>> +         ctrl->cntlid, req->sq->qid, data->auth_type, data->auth_id,
>> +         req->sq->dhchap_step);
>> +    if (data->auth_type != NVME_AUTH_COMMON_MESSAGES &&
>> +        data->auth_type != NVME_AUTH_DHCHAP_MESSAGES)
>> +        goto done_failure1;
>> +    if (data->auth_type == NVME_AUTH_COMMON_MESSAGES) {
>> +        if (data->auth_id == NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE) {
>> +            /* Restart negotiation */
>> +            pr_debug("%s: ctrl %d qid %d reset negotiation\n", __func__,
>> +                 ctrl->cntlid, req->sq->qid);
>> +            if (!req->sq->qid) {
>> +                status = nvmet_setup_auth(ctrl);
> 
> Aren't you leaking memory here?

I've checked, and I _think_ everything is in order.
Any particular concerns?
( 'd' is free at 'done_kfree', and we never exit without going through
it AFAICS).
Have I missed something?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)

