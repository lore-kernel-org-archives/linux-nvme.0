Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDB4C47DAF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 13:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=L2iD/Cm+hcqKlFxwvJ4waBBacn
	czobRLyLWh4NqcZxl7m7N6CgLVe/jA+TIAlfqJNK0e5m2/JxSAfsV3CqSkn82NABf6sZBxIMIDoOC
	60bZZfsyylsfyBWBYvwHxMQS2NtdprWzAHewEKvr/P0P5a9VnGHRtUG2sxvhPca8OtPPHonYQd29j
	4/T6KAWgHrxY9NruAxx36plmUPjlh/+rieXTDRSlw1jIhPXgn6ELA5qn55WC1XedusNaqLIQyh/qk
	Z4EDO0+jV9rcHXjRaY2WMCmzto2c3f8+/nJTDO9U7CGecXgTf9WCb3VYIktx5yaldjKM7GNsN0skU
	JLDNtxmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRu0h-00CDoG-0Y;
	Mon, 22 Jan 2024 13:06:43 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRu0d-00CDnS-0i
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 13:06:41 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e544fac26so8071595e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 22 Jan 2024 05:06:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705928797; x=1706533597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=JFNKxUpDZC+cqFRyXeCzqya9udRLF6z1C4P87sDX44tvelsoLrGGug93qZtvBL6Atm
         wUPee2B6hfP+fpGuG6ljK/A03UMUbAo+bzjQ0/OZYOzoCidYeksFUWfQjw12uL0eSNxP
         jsDJkyafkV3a+/F81LnADeL/WJlxB+xfcQj3KCVOq4SrUA1oED1GSV8vqj/yJIkftzzD
         N2c7ESWVDqjEBALm4F8sONskg+mpUqX4lsaNs0iwVE9PvT7fT5lR1jkmVOFPcDc1/iPy
         qSTP74991606Pe6vpPe7YpiH5skAgpWp8U7zJFj+ykkzBe8IZ0s0VKk0j9OpPtnted8T
         4Aqg==
X-Gm-Message-State: AOJu0YwQ/o8J2EK6uglKhnCumyn7ab427sjYVSeHkllbQLrNnMz7scdu
	U8RYtSOK2qJM+m17f83am4cSGG1OWPloRFeGoD4xmpCYSdKygULL
X-Google-Smtp-Source: AGHT+IFjUNJ3gsHvzjZX7yxtP9zmNUYDtZZ0qXuyBj5R/iE6jtjNCRwGShr6wNU6Z16bY9cDUOLl7A==
X-Received: by 2002:a05:600c:3b90:b0:40e:b218:d45 with SMTP id n16-20020a05600c3b9000b0040eb2180d45mr501845wms.1.1705928797258;
        Mon, 22 Jan 2024 05:06:37 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b0040e3733a32bsm42602100wmb.41.2024.01.22.05.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 05:06:36 -0800 (PST)
Message-ID: <630c1893-8f91-44d2-8d8c-546bea1b2d15@grimberg.me>
Date: Mon, 22 Jan 2024 15:06:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] nvmet: compare mqes and sqsize only for IO SQ
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: israelr@nvidia.com, kch@nvidia.com, oren@nvidia.com
References: <20240104092549.25721-1-mgurtovoy@nvidia.com>
 <20240104092549.25721-3-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240104092549.25721-3-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_050639_255463_CEBDA19D 
X-CRM114-Status: UNSURE (   4.52  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

