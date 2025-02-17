Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985E3C021A0
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 07:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ilcKjopp3Ixsk38sKct1Un6j+cqQNHWSl5QguoU7UI=; b=J2d6D6ZbooDYEbV8Q+aGQCbXS3
	CnffCakwLoLbauK9ZkzMq+hWJM5bJbgp7Y4iYacG3u+C1t3GN1iTqcOPE/i+lxTlCptsd/jLfzEs8
	ZmW84oQ4kGKJHWSDu/Yfr1pA9DIqUrgzVP77aqykjHKBfSylcO+gUXMJkJkBlcunj2/+WGH3vq2c3
	f3UYVbbJ7z0ojAbd42vhStzTOSEorxVeYDomegtSZrpXJ0usgkGe2jE/OdwJr1s042yZyYYqe4V/H
	OJYldwLyIB3SPuYAxUFwuAuDbIFsYzQ0Sjw4u62jq/yEfFyFGnRf4jzQ0sDzLT+7vYy+3q5QVvrh3
	xUfJznvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjvra-00000003efz-0ORW;
	Mon, 17 Feb 2025 07:48:22 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjvrY-00000003efV-1Wmf
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 07:48:21 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so26099165e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 16 Feb 2025 23:48:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739778498; x=1740383298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ilcKjopp3Ixsk38sKct1Un6j+cqQNHWSl5QguoU7UI=;
        b=iYl+MFqZ/oiP4y2ACveVW/F8/yv5sqbPptV+SCfuW5MJXeqSIf/eRqvQgOET5my+pT
         Tw7zAZMmQwzf9mDvVZhG8naE0lb9QYmlABrUgGdzX1u0wvcMz/oVaAhDvYfg/M8KhJnm
         SAXL+f+HqSinaKbgKSbySIHBj779cw10oyZBNtC43dxZXQd2YCup20Qo1o8kvMx3LmRK
         zb/uM/CyxXfac+hKTzdjDDq7EEZZCWB1cWxpNyHmtPlUN7SJB4uXZ+/MqRb7r0Q9gO6W
         kIaOB4F9ongY6uLAJVzxeqkxjprjaeRo9rMxbUPQKrY23iwH57W4xy/e9+zhQioJJA7n
         I0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCU0fiD4mS3wVCb9L4cgE9eS9n9JV4+i3HnGnvayjMxDqBEGEcSTCrYOdDUPudjr3o5SlTFLhivAIkou@lists.infradead.org
X-Gm-Message-State: AOJu0YzezY2eFdSG6EkelteBwDjpThqyuo5JSG385YUIY/XeD9l58NS+
	2TNGEB6slowjbErlSiLoNWdlMa4nyakyX/oM92OI7yGKU5z75xwirZKxkg==
X-Gm-Gg: ASbGncvIGQMlFWudLqTBgSxbGLj80dKWrS70s3Ya5vNl6pML4k9jWPDrXhyKvKbb6tE
	tmPZHdvV0D5nT05LaWfvIX0aMyj+fV2Qypj2YxuOyJe1G7YlwShFomuoWUUi4mHHeHT9SFAx5no
	HDYbXzmCPGBt1C67NH1OiGJvWJ1CYiuxCHKjT3zil5+kX67fqi8Zk8yiazurpsWLbPPT4ShAS4O
	NcDTRrPHQqCTIUSOPyZ5aZfj91Bj5HCi3x1PgffsY4PcltRbbp49ocPsYd94KYbmB2xNvYrEqjU
	n9HJ2VajypjbnJ5EaXeZBDiVAMmLt0fL1+5LNxCghXESyevB/4KgYNWs2g==
X-Google-Smtp-Source: AGHT+IFR5RnzmraN798hoOHn0hSbPgN/vDhFnVw8zC4cviVsHFRN0s+Uw+pmTSG3YzRd7aYlUw5FNw==
X-Received: by 2002:a05:600c:1c95:b0:439:5747:7f2d with SMTP id 5b1f17b1804b1-4396e74bf11mr66731455e9.21.1739778498442;
        Sun, 16 Feb 2025 23:48:18 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439892aaf13sm9581795e9.21.2025.02.16.23.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 23:48:18 -0800 (PST)
Message-ID: <d2edf651-1894-4b35-8385-41b1d75879cd@grimberg.me>
Date: Mon, 17 Feb 2025 09:48:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvmet: pci-epf: Do not uselessly write the CSTS
 register
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20250210002815.1744205-1-dlemoal@kernel.org>
 <20250210002815.1744205-3-dlemoal@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250210002815.1744205-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250216_234820_400496_7F55B066 
X-CRM114-Status: UNSURE (   5.12  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>**

