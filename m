Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C71DC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 09:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Ed+R4pIrGJSEaBC6IMxP1iv7iR
	QHHEFiFNk1k1egz1K45NIdZKfvRjr2XqlnQf7u2cFVdd8YQRl3iNgVbpsnq58yuOStZYTm4cNzR1g
	sIfa1Bg1yH4AZbt6Th24SwsfrN+c06P2/q9X155WmPNVgLZ54QoOcVekcAHfGQbg6Jkeb8uIXfaUK
	32WzGPujLhTvtq6xMI6GD5LF1aCfrJltmITPtFDNKnS8snIkOHexCdMCcqkknbzgJluX8rqVK3tRL
	pPGGr2kOr4IrjabCe5TJH2vTaMYdDO7yEUX1djwoidbnJx1w5mpyTNtA0z3RvbcU5+QLaSr5V85wG
	XasETz8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFY9G-000UOE-OD; Thu, 03 Feb 2022 09:11:26 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFY9E-000UNp-EN
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 09:11:25 +0000
Received: by mail-wr1-f52.google.com with SMTP id e8so3760433wrc.0
 for <linux-nvme@lists.infradead.org>; Thu, 03 Feb 2022 01:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=rXucTCcXfMVG/JLLNB7YWL0BZnjtiT/Fgg/XWLMvDXqvfBtFHy/ies1bUhqKvZpNOT
 a7zWrI//BtM+4fW31n1Hdpm/fGa6tQSFCQvZHuWK8j3obXuuVedYpFEKBZDysnbrnwvW
 ZtHFyRMXy593In/LReNGJyMXonDyP/0ydIo3dR+x0oV9HwaYPEPkQe2rzsZGFnmUg8BY
 MHczgaE3oOk3H0QwySMuWZJhram4HgcBqd6zlrlz6Oni2RsVwmxrnZjVuaCvrha/xfxh
 yspTH2iYVFZTk9dww334insC9rvgc0i11Oep3picMWBwHBZQujXkpuZbcPeucuQ6jvY8
 xUvQ==
X-Gm-Message-State: AOAM530lfgagwZK07MD5p20qBXnTJ5jx7o11JD8WH6F637JD5p0TTDyN
 rru/akukNDyBM2rPsQzTfRs=
X-Google-Smtp-Source: ABdhPJzflbz8AVFUQ/QQJ8J0EPHVy3wj+ASZC5rS1xfCLbZlVjhHx+NLEtqyHCP+TaOWQmMHG3LKWQ==
X-Received: by 2002:a5d:5888:: with SMTP id n8mr28971641wrf.224.1643879482270; 
 Thu, 03 Feb 2022 01:11:22 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id f13sm20713956wri.44.2022.02.03.01.11.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Feb 2022 01:11:21 -0800 (PST)
Message-ID: <9d565a32-b577-1406-7536-10a961d6c8cd@grimberg.me>
Date: Thu, 3 Feb 2022 11:11:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] nvme: send uevent on connection up
Content-Language: en-US
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 stuart_hayes@dell.com, charles_rose@dell.com,
 Martin Belanger <martin.belanger@dell.com>
References: <20220202213451.33599-1-nitram_67@hotmail.com>
 <BL0PR13MB42913A07097FA13CD1B0B1089C279@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BL0PR13MB42913A07097FA13CD1B0B1089C279@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_011124_517861_6E57267C 
X-CRM114-Status: UNSURE (   6.41  )
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

