Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7107CD37B2
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 22:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=fSmg9UYdLPd2ysC80f0K5xoGzR
	vmHeNjpA++Ug7wqd/YLg4EWymQJh27UJoOv8BkZ33/+Are51WJMqIpn7BXUy878zCXwQLqPbjR7tV
	Yj7aWV/b9T/b6GkKKs52/dDoZtxqzt4YEf5nDK53SfF5lZfstD386+o54v4qbnUoxkWs8Hv9nmHrJ
	1xNrGGYzSv16n+3HDi5SBHfHf9m0vOKdtljy1x2HxvOpswcxfaqkTk5YidtLureIvNl+eot32dvY9
	6rWPsHkbQbhnu/BgC1QLd08+SughkK4zbDpfw1bUSxjDHPFuMpbJ5mmO39m6uPW/d71SSuLNWqgpm
	zMuhhQuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCLy-0000000Bj94-1d58;
	Sun, 10 May 2026 22:10:26 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCLt-0000000Bj8L-3t81
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 22:10:22 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so3338554f8f.2
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 15:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778451020; x=1779055820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=APpPp4p9BDBrrVFM5bkmW4e1ze8VFcCQpmgf94gXE4v2J1Y//s32D+qIR0wFcv+Mjh
         bWJQG9ORm03YTEcYbiwTMouZ/Zs/Vu1hAJu7cnWPogOgHqAB2bXYcyxWB5TMW6Iu8Bxy
         hUtkv+vFiUch3SinjNhA+NO1HuEpmTCK5G3Ois8GQowcTVN0ioDlruxj8aLokYLXbCRB
         IM+5d0JrvT9hWAzTaDWdkAhfQV1XbcuBR9jwpfP0Y13prFL1jaXE3aW3k5uZQFF8wvYo
         FIqbS9yg+jstVDo286N2YMrua5Jk/nRrbwI8vBXMuUHTe+CjICqsHUF18+znpTM2VEbF
         2v9w==
X-Forwarded-Encrypted: i=1; AFNElJ/27ofbR+bAA1ZqsNG66Y7KkDprCKkdvkDdCdk/aIhSM94g3fIo2mZmF0EknjcmLf0ExRsltydFvYIj@lists.infradead.org
X-Gm-Message-State: AOJu0YyTdcSQbYORtZ0AlR/kZPoBwFeCxINfWAjXCFj7UGpfGE0r2Ye3
	GzpBU8n93vDICd2bvBsXQbmBUEAFkTjscz3DJ6mwwCCAv0kJHktfVARL
X-Gm-Gg: Acq92OEeEXUl/1I1EibTxF3f2U7i8Sb1iADpB9YgDfkvoBvLxNZyNTDjTHXghMgKIg2
	2Pca/9UQIozAzEWNQFKPHW4suOF4jOozyNOIQ+thmz6zHvNkc/XLhQPjYkeyZm9Vco37FiSI33U
	toVVhl/blnkgKrdi3DpYTOBp0Cnz1YoQtPf9uLQ8qmswowirrB7hBLcIVOXBtgcGpBlgYpIaH0u
	iiGjsPeYQHF0gVQ4WJSd2gDQMas1RaMk+zbt5wbD6kDOiiMoPfbFu1pXqC0P4CKJWw9rB507lH5
	wUXBf+/Hd1tPeffp6WXSjTJv8HvB6Af1SBbmoFI18obEZ6+EToc2HEy/JUWyddqmhM2QXewG4uF
	0bCDOLWF+wO/4r/SCPe8I/tZC+P6QQXvjz+JuthurjttFuw7dRaPGlqolqo4eTGYkhYGlspmUTT
	wcFQrcHDAV94zMMv4hN9s=
X-Received: by 2002:a05:6000:381:b0:452:a209:560 with SMTP id ffacd0b85a97d-456a44f6b51mr10610899f8f.28.1778451019698;
        Sun, 10 May 2026 15:10:19 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6cd75sm19913738f8f.16.2026.05.10.15.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 15:10:19 -0700 (PDT)
Message-ID: <ef98f23c-0be8-4149-8e22-13822698db01@grimberg.me>
Date: Mon, 11 May 2026 01:10:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/9] nvme: add sysfs attribute to change admin timeout
 per nvme controller
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-3-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260508133335.98612-3-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_151021_962572_D364EFC1 
X-CRM114-Status: UNSURE (   3.88  )
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

