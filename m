Return-Path: <SRS0=tSwM=QE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27665C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 16:13:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D68608FB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 16:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7D68608FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wTA1ZkRpxf4CSm+JnHBA2saxjcW6mD7x/S65ivDUxGA=; b=LQjvhmO+G/k0L8pb8uAgD7ybMm
	0ysUubLX/AmOURoRRgetQW2F7/aPC+RiXLLSs2SDfKJljIuHd8YQaaPJjPp8cflRCFmHicW9lwqNG
	uPwWOYevxXFMt7blS7d98IXcZNLGaC1dtckFC8Aw1FPjWbWuiRdplRVvm9J5pAo3/LhIoWasqbeqb
	8Am5ocWk8gdnbRkrAP/eC5W0HRi8DkEHaep/vOKNVEUqwF/SGgZ8Tr1ffbW0v81T16V6ZujLu8cEB
	z05xLtc+85XcZlWd1wGfM6cJTBufmQi2oP8upSEWfY4xQWlpUONuN6OLsrQdAfF8I08B4psOA0hnN
	jd/Ka4Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnNYU-005gc8-DO; Wed, 17 Nov 2021 16:13:02 +0000
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnNKY-005a7e-N6
 for linux-nvme@lists.infradead.org; Wed, 17 Nov 2021 15:58:40 +0000
Received: by mail-il1-x134.google.com with SMTP id j28so3283672ila.1
 for <linux-nvme@lists.infradead.org>; Wed, 17 Nov 2021 07:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=wTA1ZkRpxf4CSm+JnHBA2saxjcW6mD7x/S65ivDUxGA=;
 b=sBbfs7dMA4vSgpPZnHtaaD9Kk53aFCZknJTNAXlwT+/FMthrGz3kmYTLINYy+JLHQ+
 lcDHPTizmfaIFHywsGm6b92ryhUsSPZaPGB5cyC7eHdtFC3JSRmkB/9xS6vNmSuLkdvV
 Xqjprwu2MmoJv4n+5whTAKmmyZ5Ki6Jco1YsxF05JVhqlSKhGubVd9X31Hn0Y3U3hgTu
 0OIeHEsvFKDwYIYJsjU3lAhxMuyeAlvjYCgyu5vOCMVlZN8N1T/aDyb83XJd2fEfS3yD
 1XQqRDMutA1EFKJWIpfEXBzuiozLvXZzuExrpX6XXaLYlzXzQtBkTWzkNFfgHwbnDh8o
 EmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wTA1ZkRpxf4CSm+JnHBA2saxjcW6mD7x/S65ivDUxGA=;
 b=f87exnonRwTe0/XMKbVkS4nBoGY140s0KGhv4WlFx2FWsUwL1EYqOaUJ/2tK+XoCy0
 ahCd7ZeLDQYnlQvw6TDu6IAzHddRUfmPWzNQVL7O8QUC6vwIcZ5Sc1sMfafqA4Q9feVj
 gm8FSIHA9tCEcdRgOcmlEP72l1iPu4pEkbs6Cvv3ESFww9Ce0o7DWnQQH6TlgkHoOoA5
 rGIlB4x93fe8iC5uGWTt66MQk3D3P40ImcbYpZGZUBzUjea7I5sJPnAUSmd/+2/+T2GF
 9y2Hc2nXMd3E6fi2iVZO7pXWSoQV9alYjEv/BiILDYs/sXFjgtpGi1mjnN7GXQTrajlE
 uF0w==
X-Gm-Message-State: AOAM533HEL8Lqn8ZRDXiraEmN1ewfL4XRy/zD1x2QQoV9F0kON//dBrk
 H2dTkWKH173krm52znQOfCHgI1Z0SYz/N6ZU
X-Google-Smtp-Source: ABdhPJxalLmanKSCAq9ReDqiBN0pEZL4NAx3KWXg5JnQU5yNco474SWjuUg55oCdWLELUoWiIroEWg==
X-Received: by 2002:a92:c245:: with SMTP id k5mr10843070ilo.280.1637164717327; 
 Wed, 17 Nov 2021 07:58:37 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id c22sm103287ioz.15.2021.11.17.07.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Nov 2021 07:58:37 -0800 (PST)
Subject: Re: [regression] nvme pci sysfs remove operation hang during fio test
 observed on 5.16.0-rc1
To: Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs97spcWGFjz4JPzaRuzHnRGZkKP6HWMSPkbKLS9EmWMJA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9095c05e-659f-dd4c-95f9-617026216550@kernel.dk>
Date: Wed, 17 Nov 2021 08:58:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs97spcWGFjz4JPzaRuzHnRGZkKP6HWMSPkbKLS9EmWMJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_075838_834796_A517F9CB 
X-CRM114-Status: GOOD (  10.54  )
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

On 11/17/21 8:57 AM, Yi Zhang wrote:
> Hello
> 
> I found this regression issue on 5.16.0-rc1, pls check it and let me
> know if you need any test/debug info for it, thanks.

Pull in block-5.16 and it should be fixed.

-- 
Jens Axboe


