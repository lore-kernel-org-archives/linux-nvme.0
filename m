Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31943C35242
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 17:54:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA6C20578
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 17:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tuIO2/wP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URZXOhGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA6C20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=t4tg1ezNUPZrMSAxQA9RhySHJeMxnuQYEMhKFfIlHqQ=; b=tuIO2/wP5/l+an46cmeJCkv5S
	E+4yE7EnSlnVwD1e1WMsm+CBZVdleyJxawOzDGgx/Bv5Zu8HIcmabF7gq7CRAgg7Iu97t7T7W3lu+
	TpX3seIc2Rq7tcYxTtd0fZ8MHt/OLzyOzR8nKpp0it4BJHVEdjqBemurEUzdzekgreRXMSpTrAqvd
	uYABti/hiFpW5rZE/ypWHsd4NyIOv1Uiw4n6saHdedQln4Ce07R0tFYsT//moeHIs/+MmmhP0XL/8
	xZ8zqIFVu1ivNcDN9WUeee0Rl4MRZn7uXJRIA7P0c/M5+FNl2tHQ40qyU2REgA+tjj02pa0a4hogf
	vGI42J1vQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1Zjy-0003xh-Ja; Tue, 11 Feb 2020 17:54:30 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1Zgd-0001Dw-Go
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 17:51:05 +0000
Received: by mail-wm1-x342.google.com with SMTP id t14so4712509wmi.5
 for <linux-nvme@lists.infradead.org>; Tue, 11 Feb 2020 09:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MN5sKfTiG7ig08rXYRMdP4PWGX5zNXkIcrTojsMv9jw=;
 b=URZXOhGbbPt1Qj9XMqnnLTXqLvN4v7jhDVZ4w0Ig1Io2YBlTZiu2qdGI5oP7hX08z2
 WdumR1vYVV9XqowQaFVwhM8sJzPXVlRSi1bFYBKTwABCFkeQBTLhZ4hg0Coz5wWekx4s
 78QYmCRzdwoo8nLm3AhwZgNgBF5aHnq7Uuc5Zzn172UDv1G2sxf/sS1ZIFj4JB4tLd23
 FyGZlfa8hfGI3c5MymsS5mlQ2aQZA/ropwrEtILxw6em8hWYcFB6p2Wu5CuWG2IyqXU2
 SRn0jD3sCTlndRVIdBnCBfDzbWw518PLr/D6/JVcnEOx4O1CJuaKeLHUTn+8cBwYVsBG
 DaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MN5sKfTiG7ig08rXYRMdP4PWGX5zNXkIcrTojsMv9jw=;
 b=jPDhiAZhzP+1cdfx6ipir9J1c/nqWiyGpXaI7zG7mfIwrc+pSAUeB7yxKp4d4kHa8l
 rVMgNPxqYokX9f/5yPN+hP4Ir2rMM4uFYv2TKEJgxFs3cIGFaDiZvs32PAoju2eYPlFJ
 weBNSiltC3c5Gl2S+5F7TTgKOTxDsRxG4GPMc5y0ERq3VxSqogbdgUNONIrVFA6YDDcJ
 UZjEDRh5dUHCSyYdMJTzGaVQ0gyDSXmQoLfEoAHEyzZ9XWhObyC/r4N1qE8pJS8Sp3O8
 LD4QRlL6lNMNdFwGFU1kfGzdz3hnocrGjEQJURtGQYgqMcH3UrH84M9dowUreiiQWp3I
 PItQ==
X-Gm-Message-State: APjAAAWAL5qIORf/JTOFYto892ffa10IOHlKy4SPEe05CndQf3FYD0V7
 eXIMIjYSJfSJGe+8yP5lsnM=
X-Google-Smtp-Source: APXvYqz+Is5vIfoqhcK3Xdbx5Vn0mZb7GDQG7eRX5BpnsmEpA8h6R+ZWYRJSWG9Xe0uHBwQh5nCE7w==
X-Received: by 2002:a7b:c932:: with SMTP id h18mr6750991wml.171.1581443461882; 
 Tue, 11 Feb 2020 09:51:01 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id z4sm5967969wrt.47.2020.02.11.09.50.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 09:51:01 -0800 (PST)
Subject: Re: [PATCH 1/2] nvme: move keep alive processing to nvme-wq
To: Keith Busch <kbusch@kernel.org>
References: <20200206191342.10190-1-jsmart2021@gmail.com>
 <20200206191342.10190-2-jsmart2021@gmail.com>
 <20200211030037.GA20916@redsun51.ssa.fujisawa.hgst.com>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <19893b35-3bcc-e96c-496d-a6cf85d29bda@gmail.com>
Date: Tue, 11 Feb 2020 09:50:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200211030037.GA20916@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_095103_568284_335BE247 
X-CRM114-Status: GOOD (  13.95  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Nigel Kirkland <nigel.kirkland@broadcom.com>, maxg@mellanox.com,
 mark.wunderlich@intel.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/10/2020 7:00 PM, Keith Busch wrote:
> On Thu, Feb 06, 2020 at 11:13:41AM -0800, James Smart wrote:
>> Delayed keep alive work is queued on system workqueue and may be cancelled
>> via nvme_stop_keep_alive from nvme-reset-wq, nvme-fc-wq or nvme-wq.
>>
>> Check_flush_dependency detects mismatched attributes between the work-queue
>> context used to cancel the keep alive work and system-wq. Specifically
>> system-wq does not have the WQ_MEM_RECLAIM flag, whereas the contexts used
>> to cancel keep alive work have WQ_MEM_RECLAIM flag.
>>
>> Example warning:
>>
>>    workqueue: WQ_MEM_RECLAIM nvme-reset-wq:nvme_fc_reset_ctrl_work [nvme_fc]
>> 	is flushing !WQ_MEM_RECLAIM events:nvme_keep_alive_work [nvme_core]
>>
>> To avoid the flags mismatch, move keep alive work to nvme-wq.
>>
>> Signed-off-by: Nigel Kirkland <nigel.kirkland@broadcom.com>
>> Signed-off-by: James Smart <jsmart2021@gmail.com>
> 
> Hi James,
> 
> I'd like to include this in the next 5.6-rc pull, but just want to
> clarify attribution: the author should be the first sign-off, so
> should I amend the author to Nigel or move his sign-off below yours?
> 
> Thanks,
> Keith
> 

either of us as author is fine. so just pull it and have Nigel be author.

-- james


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
