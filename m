Return-Path: <SRS0=f2Gy=4C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF864C2BA83
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 13:54:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94757206ED
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 13:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XtfI1WbA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENholsOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94757206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dv3QAYTIcCURzs0N8LwLKAqw87Yu8msmN4yHVSNq8gY=; b=XtfI1WbAL3n8aPRw1/3IvKnGn
	FP8wo+K1kaICXz9PDIX5N5rKlGFnr5Huw57vEXxN5Z63+ko10Ls1gZYloJmUM4eviqmRZFEvP7Hih
	pVg0WTvk0jlNw51BnQRG7I5wkOHMdVM61TLri0WzG4KXp+3/gcHMNJTj63jvDYwfAS7iVnWE0s5CF
	aOeQQ5Hlr/CXgb0NBbFM4/RiQMZ6kA+GCcQyvXOIVE42hSrBBE+/6DLm7bJAbxjTIa2XOeV8SPVdx
	YUJ5tD3kRp/ODjcR4zGtLOueukHWVjdpcBUUrLkLA+W1GNTf6kbgUdfmaZOH96YPToFBkcdnjDSOf
	uzrJX4W5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2bQ2-0004NG-Vl; Fri, 14 Feb 2020 13:54:10 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2bQ0-0004Ma-Mf
 for linux-nvme@lists.infradead.org; Fri, 14 Feb 2020 13:54:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581688446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4pKDcVaMpAwwCLTlx+iVaXDiarL86px8Ij89ndfDcMU=;
 b=ENholsOvuS2rzDkcvWMIgUjOVNgKnQiCNpETX6t7L3U1B+DXwSyQtj8oQdGeMGY/YVojTe
 BuW0UkYa7j6oG4GGAjS+sqqA13KPEB/7pQq9WEaJ6iBcAZF15b7Z1L5JG9R+bh9JQcwvo/
 IfK+HAuwJFzPmXgb0k4NnXyzc82Jtq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-51tV01jtPI-X-a_H2Go_GA-1; Fri, 14 Feb 2020 08:54:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7DE4108443C;
 Fri, 14 Feb 2020 13:54:01 +0000 (UTC)
Received: from [10.3.116.39] (ovpn-116-39.phx2.redhat.com [10.3.116.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06BD78B547;
 Fri, 14 Feb 2020 13:53:57 +0000 (UTC)
Subject: Re: [PATCH] nvme: fix the parameter order for nvme_get_log in
 nvme_get_fw_slot_info
To: Yi Zhang <yi.zhang@redhat.com>, kbusch@kernel.org, hch@lst.de
References: <20200214104802.29209-1-yi.zhang@redhat.com>
From: David Milburn <dmilburn@redhat.com>
Message-ID: <d72e9d2f-6857-305f-54bb-2fb25448dc37@redhat.com>
Date: Fri, 14 Feb 2020 07:53:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200214104802.29209-1-yi.zhang@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 51tV01jtPI-X-a_H2Go_GA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200214_055408_964355_40A302DD 
X-CRM114-Status: GOOD (  18.89  )
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
Cc: sujith_pandel@dell.com, emilne@redhat.com, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

On 02/14/2020 04:48 AM, Yi Zhang wrote:
> nvme fw-activate operation will get bellow warning log,
> fix it by update the parameter order
> 
> [  113.231513] nvme nvme0: Get FW SLOT INFO log error
> 
> Fixes: 0e98719b0e4b ("nvme: simplify the API for getting log pages")
> Reported-by: Sujith Pandel <sujith_pandel@dell.com>
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 5dc32b72e7fa..641c07347e8d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3867,7 +3867,7 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
>   	if (!log)
>   		return;
>   
> -	if (nvme_get_log(ctrl, NVME_NSID_ALL, 0, NVME_LOG_FW_SLOT, log,
> +	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, log,
>   			sizeof(*log), 0))
>   		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
>   	kfree(log);
> 

The controller returns a status of "Invalid Log Page" from
nvme_get_log() on different devices.

Reviewed-by: David Milburn <dmilburn@redhat.com>

Thanks,
David


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
