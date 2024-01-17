Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC8FC47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 14:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6mzdpbDlotVPmn+y7NndiYDp8mziWqV4VC1alIMZzk8=; b=BOJG5+K97RyRLqJKyP74Ju1v10
	jZLNKs2p/bSg4XUTY6sU7XuGtySnPAjTlwhQNRRy0viiJG6o78hNlP54zfU+9i0nrSInRn1t+t0eC
	YJkQkv/eHwEg3g4FRgs/GCTZvd76hy581Sx2idpqycfZAqCIjPwkqF1z35525nDxb+hkHZBDmwGE6
	5LgSPrd7uPm5J1Cz4pPZmzGXgIfBEy/u7OT9ix/0DvS2uAQWQY7sDWi/O6gdr+JAWuGwLZtN1CIz6
	JcXLpcIboUgRtiLGv99H68mrU9CJudWI4IP9ArB7nJ09qFPJNqfWNxMAaoRHp6KdF2NyIxhrVt2zQ
	kun/B7ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ6Xd-00Grfh-2F;
	Wed, 17 Jan 2024 14:05:17 +0000
Received: from mail-oi1-f170.google.com ([209.85.167.170])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ6Xa-00Grcq-2M
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 14:05:16 +0000
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bd93839081so68691b6e.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 06:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705500313; x=1706105113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mzdpbDlotVPmn+y7NndiYDp8mziWqV4VC1alIMZzk8=;
        b=IGJrHfl3x897fuw8/gTaEDIcu7k16bx2OSzBIwG+7NgecSrsNjU4nEEfF+r30gBg8j
         6e23C8ykrTAfr5uJSyIXjMh8Usjk4z6MRI/cxIY1YlqNvApp+IgS6jGf/UmnDLC7czS7
         pw8M07lq1qUSgTvhUd3OvKaTCH2+QXPI5pnKz93zJpKnuPynX07BkPWxY2H1QhqRCacf
         ywHo7po2nWmUm8sfQDemu9kvccceRYZnJ7v5ax51DqUWhx/dfR9KL9xhfOHTY6q5Dysm
         LyCL4sIamXB2ZAXS3S34bLqt21Ss+XxRIeQWbctFTMyy85U5nHlL1iRCxrY7RkBMiXss
         MJCA==
X-Gm-Message-State: AOJu0Yy5r0p0d7hsiZxcMIWzo17okT1nfs74VpWXok2LvHf1IIcS590g
	Dyy5aZpFDN2sOTJax0M+los=
X-Google-Smtp-Source: AGHT+IHhkmuVqOijv5qMlj3gG/HIkFENkb62UVRxlti+PuUg86lWSTYG0FWGf2w6xW9dgUL0bNuJOA==
X-Received: by 2002:a05:6870:45a7:b0:206:b932:f155 with SMTP id y39-20020a05687045a700b00206b932f155mr16742835oao.5.1705500312702;
        Wed, 17 Jan 2024 06:05:12 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id pa25-20020a0568701d1900b002069e3bcbb5sm3537404oab.18.2024.01.17.06.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 06:05:12 -0800 (PST)
Message-ID: <15afc62d-5c99-44f8-9108-b70aea05f71a@grimberg.me>
Date: Wed, 17 Jan 2024 16:05:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-fc: remove repeated word from comment
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, james.smart@broadcom.com
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20240117044334.17224-1-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240117044334.17224-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_060514_802517_BD22AE27 
X-CRM114-Status: UNSURE (   4.26  )
X-CRM114-Notice: Please train this message.
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

OK,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

