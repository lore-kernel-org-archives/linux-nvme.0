Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1A6C25B10
	for <linux-nvme@archiver.kernel.org>; Mon, 13 May 2024 07:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c2aBVyXOGbrF9auKs6ByOQwcNRs+3jorXoRoVF5GtPk=; b=olVwtJlRRdmKrEOda/v6UZIufZ
	jOmJMqcqdZgS2n8rkCCtF2jJNmsTajMO1KlYWDDexE61a+n9OomFiOyfMfrCtsxUv9tP+cHG1Ol9q
	P4PJv/QRrcguf98FsdTL1nQqV7FFe+T+yyco8F5Ry+7LAnwxjeWMruOS2DGYoqk7V4Oyih1dGKRjH
	9CAzY1232RAm4cz2nGUptYmpmoQICcz3ZUzpS8oHfYAXNZN1WnUVPpJSIdadIhB/NRSkiLozjwO0Q
	SSAotlFh3yYPcJR2SZf49uZB7Q+HHJo2X1q3+d2bznrwNKMBzX2mzekCham5uxF1Z6WJkakO47iDY
	aF4WxQgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6QXj-0000000C7wK-1m1Y;
	Mon, 13 May 2024 07:56:19 +0000
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6QXf-0000000C7uR-3qyC
	for linux-nvme@lists.infradead.org;
	Mon, 13 May 2024 07:56:18 +0000
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so4265987e87.1
        for <linux-nvme@lists.infradead.org>; Mon, 13 May 2024 00:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1715586973; x=1716191773; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2aBVyXOGbrF9auKs6ByOQwcNRs+3jorXoRoVF5GtPk=;
        b=cyrMuSd/AZqSeeTeKwcF+P8D8i9q+vSldkuArmiDmEjb6m2ru9qonU+3pa4oToxEri
         pxnWDx+7U9HIdPD14ntyGRzeu87qaVRcT9dBXfVSc1IMpj2eiWCHOuP7qSYvXlrVpP7o
         /Tl58ItNrj0sFtZ09VOFMkClxmATuxbI4QEtHKrrETOw2UoUhkvuIPL/QH6wtpSMYEZk
         zLVHgcb14j5d/zLwsGkiK/SZruapYQ/XNxDeuscvCUJloLLgT7rcFGCfo/reSPNVJGst
         h8IMPEHR5QGES61V/pek6EcbJlaBKs4kifLV/7uR1di3FkQhdRkqI1AOmv8lumJhfqLg
         29TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715586973; x=1716191773;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2aBVyXOGbrF9auKs6ByOQwcNRs+3jorXoRoVF5GtPk=;
        b=jFBaFDOb+4Lm6smAvnp3H0GeiO8w3u7abXg13p5kvtjkvXhgIHnYsW9pp3mzPwoLYC
         blGxkj/+tJlKFJRMDOy2xhIKzyRSFy5iL6XLvimuQu1CxfQOj0cOR6fz2E/u3Usmqgbm
         fBHCJvUe4/eMaul1+LnZL43i8S7pXe81YgBqaDRoWleYRvsH1IDcCqOfwq4q7Qooy03l
         7IO7gaSHCOflSxEgirT5qF3oV/tPYSVt8iVdy3M0Ta6B2kvJGdBQLzB4ooFGcON0Y5r3
         f1bRFGDN697AS2ys9G9BB2PLwKCnoMSbaKcyVrs1gVtF4hHr0glEpMo8W3ZPues96Ja7
         TCJg==
X-Forwarded-Encrypted: i=1; AJvYcCVQQy3jWrUGRleTVqmj35jIMC8THYtkHjC7SjfHu6fT1Oe3IMwdOBbNFYN2SAxn+8a1FPZfjuNHSbdlC8DHw+1iaVmxJXov9oe2A0qp9a4=
X-Gm-Message-State: AOJu0YwarF9xO31NBnjIj+vwBno8BM+Ir/1maaoScAWR38F1IfRX25CL
	xq+LbSda9+jsoBcmF2CB06DZjJr8ZznqHjjlFD8aZlkhYMEyM8+SL/rQY7PqP14=
X-Google-Smtp-Source: AGHT+IH9NQ81vMx06YFNFVIVRfcKDZxFq6dwLJk8OwUfJ0OF9CcoN8SGQZ8xcNVh3StW6pzPJZEhJg==
X-Received: by 2002:a05:6512:1105:b0:51c:dc6:a1cf with SMTP id 2adb3069b0e04-5220fc734ecmr6493470e87.34.1715586973191;
        Mon, 13 May 2024 00:56:13 -0700 (PDT)
Received: from smtpclient.apple ([2a00:1370:81a4:8e0a:5846:8eb8:305d:fbad])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52202d30a39sm1475729e87.178.2024.05.13.00.56.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2024 00:56:12 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.8\))
Subject: Re: [PATCH] nvme: enable FDP support
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20240510134015.29717-1-joshi.k@samsung.com>
Date: Mon, 13 May 2024 10:56:00 +0300
Cc: Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org,
 =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
 Bart Van Assche <bvanassche@acm.org>,
 david@fromorbit.com,
 gost.dev@samsung.com,
 Hui Qi <hui81.qi@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>
Content-Transfer-Encoding: 7bit
Message-Id: <CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>
References: <CGME20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41@epcas5p2.samsung.com>
 <20240510134015.29717-1-joshi.k@samsung.com>
To: Kanchan Joshi <joshi.k@samsung.com>
X-Mailer: Apple Mail (2.3696.120.41.1.8)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240513_005616_325336_0B93E16B 
X-CRM114-Status: GOOD (  17.09  )
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



> On May 10, 2024, at 4:40 PM, Kanchan Joshi <joshi.k@samsung.com> wrote:
> 
> Flexible Data Placement (FDP), as ratified in TP 4146a, allows the host
> to control the placement of logical blocks so as to reduce the SSD WAF.
> 
> Userspace can send the data lifetime information using the write hints.
> The SCSI driver (sd) can already pass this information to the SCSI
> devices. This patch does the same for NVMe.
> 
> Fetches the placement-identifiers (plids) if the device supports FDP.
> And map the incoming write-hints to plids.
> 


Great! Thanks for sharing  the patch.

Do  we have documentation that explains how, for example, kernel-space
file system can work with block layer to employ FDP?

Do  we have FDP support in QEMU already if there is no access to real
device for testing?

Thanks,
Slava.


