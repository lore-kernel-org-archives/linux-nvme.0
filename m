Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D40C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ZCSZmVvUmVjSHnTT3jccpdt6fseuRczjAFEuiIrTbg=; b=jFE5wkbl30Z55N3d87z5JOVi74
	CejUHsL7ZEo+tj7K6rIK7zEKq7khPhBrV5I+6hbONQiIcmLm2ruiRBYPFpOYSXxbC+sYn9D/onL1S
	fTo0r2G14RoSIC4iTklp/KxnPSzTLzjm87CIVv+9/e6xLtpohA0zWpLXAT9Rf3U6Ooy+WnRb4b+7G
	oHb3+2xhL8YS3G3WZspabfHZ8s3HfDIU2U4otCkIAvc/kJLcEq1xND7UjvUwvFsy+z2SFx4OUMnrt
	9saKrYYLXegfqVEKMgVa5SJwWPVJxyzNufKWYGxB+6DRgzxbOZ+/LlEoPEe842smcxXn4HSyGHWTO
	1ROFKiTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD5Dp-00FysR-JH; Thu, 27 Jan 2022 13:53:57 +0000
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD5Dn-00Fyra-65
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 13:53:56 +0000
Received: by mail-il1-x12f.google.com with SMTP id i14so2495128ila.11
 for <linux-nvme@lists.infradead.org>; Thu, 27 Jan 2022 05:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5ZCSZmVvUmVjSHnTT3jccpdt6fseuRczjAFEuiIrTbg=;
 b=04NEnHqAgj9kJJcOE7ZLFomq6hubS8cMJGe2CxhxR/FlQot8GzWARFDD7+8FkwdiH1
 +Ypaql6IWkE8hhUMMXnX8DPgUfmgKc9i66/JhLgoaNlZklng31rQ2plZqa5HAPV21WyI
 Kq8Rt92LQ8OFPpgDlaA7K77zbppmDZkIfJZDkkzEHErH7YjduDYc/KCbtolDEYMMN6hH
 c0nteeCflYdW0Vk2UuZ2mfGQ4AyfNJveYYsqaAT7AZ2toMQ77pOdRkbF8BdxeCLv25WA
 leMP+l8KVwpeD7FXeTj/CX52VCm6uIM+6k8sbwiRsIEOrFMCKRkkpwvOJmDjelirZ0eR
 ldUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5ZCSZmVvUmVjSHnTT3jccpdt6fseuRczjAFEuiIrTbg=;
 b=eTEWxF+fY2Ap35DSOtmXmiTJuglDE5tT4elEcfHZ2e8eeLZrd78vKqP0PI/V7tkzUi
 g1yLwWEJZLR/AM2qG2zxAuF0Lkii0wWb42yqx/S6khp1E7SKno1kXavjZf+M/qkwxKQY
 4CwUkSmeG/bbWLxHHK+aak1pTEdZtQd2Bm37/4y8ARRVUeF4NTGLeU1CfuAmZpHYyjbk
 5tUr22eY+DWcJ/ojJUvkOcxA9kFKn4KtlACuetpnLzh3+GCEZpqHYumnF9mJqigqxtRL
 vLbVN9eiOjlnFarQtGJ3iKEo5CszdSJEUwJJYS8Fk+tr7/pPMN1ZnLJCdmBJ7BXgrIDp
 mNow==
X-Gm-Message-State: AOAM530WhWw8ScRfXxRgsnHl6WYu1m3B9Dn4RDEqzccadwJk45Ja4X6C
 O4SjOt/NvmZa6erMlf64wES93sYSMhCnVA==
X-Google-Smtp-Source: ABdhPJx1KhHIIH8AnrvN5wIqBozU/p1pu/n4owTzdUnt58ZOw7SmxtKE8xFfaimeEpkPg4dE9xtTOg==
X-Received: by 2002:a05:6e02:2163:: with SMTP id
 s3mr2375976ilv.252.1643291630561; 
 Thu, 27 Jan 2022 05:53:50 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id q4sm1567032ilv.5.2022.01.27.05.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jan 2022 05:53:49 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.17
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YfJHeoRZIPt2t3aP@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e58dd4de-3079-cc0f-d18d-b7c86df0a3c1@kernel.dk>
Date: Thu, 27 Jan 2022 06:53:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YfJHeoRZIPt2t3aP@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_055355_237144_2AE29979 
X-CRM114-Status: GOOD (  10.91  )
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

On 1/27/22 12:19 AM, Christoph Hellwig wrote:
> The following changes since commit 83114df32ae779df57e0af99a8ba6c3968b2ba3d:
> 
>   block: fix memory leak in disk_register_independent_access_ranges (2022-01-23 09:13:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.17-2022-01-27

Pulled, thanks.

-- 
Jens Axboe


