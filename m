Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D69CC43334
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Jul 2022 11:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=1Gi/IhpbcZ9I9I/FSbwgoz0FIk
	EG8kuiPkiPN0JVfsyWsU5ySUeE9w1+yE7B0frr07dgsbS/Tie8MHDFowjSJ+NBweasYZPDWVjjWkm
	Eka/21O5+zJ0LtAR5C7nNkpzc2GIaWzfmEbLDVfLK5Uu7i3mTNiRi9++YM0k3ThN4JDRF9wZRMDxX
	vIZzodR+jn0nNtiT18AdLoLS/rm57PZYVdvhOAgshsi7t7jZ/cwbF5IJt8b5Gz0EhJmNpsjXIPFEG
	107+ANVQcf8FjNpbIj1mnrearHP8o/+Wxt+h6fq1hv75jW4UhXoIken15mZt1KH3pQxs2ROIU3Liw
	MCnJVJtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAUlF-00BUnc-QF; Sun, 10 Jul 2022 11:06:01 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAUlD-00BUn0-Pb
	for linux-nvme@lists.infradead.org; Sun, 10 Jul 2022 11:06:00 +0000
Received: by mail-wr1-f44.google.com with SMTP id n10so3702295wrc.4
        for <linux-nvme@lists.infradead.org>; Sun, 10 Jul 2022 04:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=BlqrU5vlECvBx6EAo2MBZ9sLl3xLCoCFu5Yw1/XbX005B/sq9hJMVJqBAPTgwuLOnL
         m9/EaYJli05wwj36tUosiDBXwx4xVJLJKJ5BrinogPz5+Z7ImVmNQQCEA1XcmGihXXa9
         0dA1TYmT8HEWpSW/kY7govgTHkkxXD5KqPZEg0PmEk9EJYu901UTNp1C0BAZW8V7pawy
         gY1+/tnvh4JIyCmfSuJFvNjkestWt7bFoynfsaV7NEJ2TWt6CtCSJlGzgThQu9HcH4PQ
         Zho1M6erlKX9xA7/Y5vpc8WuGiZhJhKJ/Ge3t5K73zd4jQt9U/cxnq8OB35PGolfOT9l
         J08Q==
X-Gm-Message-State: AJIora9ExxHFve7suBCJfkaiSNhZXwn7dylK9YatLaGTYdaqmNwGxkmP
	KPoTBwf0d+qm4oHLQyg/xYY=
X-Google-Smtp-Source: AGRyM1u+PGxkFcyW8m+dCjA1pNcnOfaanInQpj4ytHLVEh8Nd+dpVRyp1kjnHUABKhLQQqgIXTexsw==
X-Received: by 2002:a05:6000:81d:b0:21d:a495:6e3 with SMTP id bt29-20020a056000081d00b0021da49506e3mr1645634wrb.502.1657451157976;
        Sun, 10 Jul 2022 04:05:57 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n3-20020a7bcbc3000000b003a05621dc53sm3665002wmi.29.2022.07.10.04.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 04:05:57 -0700 (PDT)
Message-ID: <4d76a508-4d53-f44e-109e-f4ac26fb508b@grimberg.me>
Date: Sun, 10 Jul 2022 14:05:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] nvme-pci: use nvme core helper to cancel requests in
 tagset
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <1657249477-88304-1-git-send-email-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1657249477-88304-1-git-send-email-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220710_040559_858291_BBB2A5BC 
X-CRM114-Status: UNSURE (   5.78  )
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

