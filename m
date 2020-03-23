Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C305BC10DCE
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 23:09:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F4420409
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 23:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LY7EoWX+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEBFfXqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F4420409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Zzngs94iktAwUjziplhSrkLzXksgeYzbHT5oRoiWOYs=; b=LY7EoWX+9+UnXtM9aPkvpGG//
	BjXrrvuVxOUYA+Nj6Z5XTW8iSyYPdbYH765PytnqBFqoOrC27MnkDXRKwVT6U12q6oaznPclbEQ2D
	g0FWT4YZ3I5hkLnsXxybGpe+rB5akdX/sQTVurcms62KiD6/jf9OdQ8mwj1x/notm0f9D4X5LykXu
	7MIBmjaIJ4lnyjNL1hd+90eTKHK1UHOyPcN4YWqaOCrVNmCBHW50l7QQvVu7xfhcYu3oo5cMGuR9+
	r+6o2iJN+3BK5zlNZLVGGBkwaLL1d70Uz5RNj6yH50VjXuhNQq1mEKjvDpinuAiapcC5iMW55qHEA
	y3NWI0B0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGWCE-0003Rx-M4; Mon, 23 Mar 2020 23:09:26 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGWCC-0003Rc-2r
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 23:09:25 +0000
Received: by mail-pl1-x644.google.com with SMTP id h11so6577886plk.7
 for <linux-nvme@lists.infradead.org>; Mon, 23 Mar 2020 16:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=srDYPq1sl5XiMrVTRNik2lXd48dAxRC5F99gwAgQsHo=;
 b=TEBFfXqZEMVAhTNH1rt7KDfVJOmBeB4x1ad9Sr9wUA2OJU8VdPPHOo7NyMQGJF8n3H
 ++fInsswuB8sYGavE7diMFgQLvKFXPgFqbd3msrORoFlkPSJXtCrQ5LU2HG7x1G6bg3A
 oZ3kwVg/WukNP+TvlYf8IxocWp7AlIIrto74UjojiJz4kjNR0N/v86lnnQd5FnOmeC5N
 WTpAfK7dIrwLJPrtujYM4ajAvtp+m20xhyx71z0O4toKPw+7Lq/RUcmw5IrJbNomxaPR
 8ilrpXiherwiUO0P+2QjFVlRGRKQmaY+G2KNUPT21Tatj+bKCCZimBcFqgh2o9Q1mZxE
 Msjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=srDYPq1sl5XiMrVTRNik2lXd48dAxRC5F99gwAgQsHo=;
 b=HbpZ334s/JUF+jbvYU2ked4xpqF0HPOWs8MwO3FANbx2IEisKbyGDaawWJxIa94twM
 h12ya7pldCxrzqU1TpLb7Sfcp1O271fLSC8ODnxy1bBUWdxE0KT3NlWFez+PM1u2WGZ0
 dhgl7dY6VKLUd3CzAXv6BK6tzEh4Mv9L3gtCXJBUVrDGKGv/Qwua4VL6JWz/MmeChQAV
 Cw+zaAMg/PdYxNDFsRwJ9Yo2/D6me36AHk9wgWNZx6V14hXgINaCchOoDerbFbA33VtB
 2l8OTY7Gtc0Efarj5324oF4K0mrThTI9zf/TxrLDOnq73SWokYH1/OK8ckH68/vowPzm
 wr1A==
X-Gm-Message-State: ANhLgQ1OVUqjB3upy0fP6adOpAA7Qf1AiwuvJdKV5AAt6lZfVcCtdjSo
 WCEuUKV3qmpTw3V48V9MiVHrpqRk
X-Google-Smtp-Source: ADFU+vtkHFvDdi+1CkUE0NUli2ocUDUWy1xWVqb305t7gwIeyj1OklV/SX0dh8VC03ZIo3vgyC6Oig==
X-Received: by 2002:a17:902:a407:: with SMTP id
 p7mr16673143plq.257.1585004963176; 
 Mon, 23 Mar 2020 16:09:23 -0700 (PDT)
Received: from ?IPv6:240b:10:2720:5510:a182:288:3ffa:432a?
 ([240b:10:2720:5510:a182:288:3ffa:432a])
 by smtp.gmail.com with ESMTPSA id x66sm13800214pgb.9.2020.03.23.16.09.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 16:09:22 -0700 (PDT)
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Tokunori Ikegami <ikegami.t@gmail.com>
Message-ID: <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
Date: Tue, 24 Mar 2020 08:09:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_160924_125447_E4F25357 
X-CRM114-Status: UNSURE (   9.99  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,
> The change looks okay, but why do we need such a large data length ?
>
> Do you have a use-case or performance numbers ?

We use the large data length to get log page by the NVMe admin command.
In the past it was able to get with the same length but failed currently 
with it.
So it seems that depended on the kernel version as caused by the version up.
Also I have confirmed that currently failed with the length 0x10000000 
256MB.

Regards,
Ikegami


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
