Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B01F9EDC9
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 13:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yAOboUJ/4deZaI2kxLEwGdVNjJvERJfqYNCMKTju7ws=; b=p/qAUip3xVO1Ua1JA2cxdTZIx1
	Jt3CXzIAqbsxgBFMWAe1BfTZzoNYR/FafQtFSquEyMk8Q7dT6Qw2uxy+MGlMoqZtWyx56ImaOrMJt
	XM5l9TKWJgrfwF1FgPYgN8cXt+flHEZg0/2KfW+eyZPaeWfA/4dwfdNdMw61Bqvnr1ciVOX9KrTZW
	dkKiS8w1IpHEguYpVnP1h+C1ZtqIPjjn1j9wLAVRMXeumNIxd9hBN7+MZF0mV8FLjspJZMXqvcYKM
	pKf3AvbhtkAWvCdYNEdRnQEyvPRPezel+um2JWqbrxj5L+x9PctV4JDht35xxPSmOo2m8LMCez8vj
	679VxqEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFXMc-0000000AGcJ-4BGI;
	Wed, 22 Apr 2026 13:11:34 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFXMV-0000000AGbO-1GDP
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 13:11:33 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so29785135ad.3
        for <linux-nvme@lists.infradead.org>; Wed, 22 Apr 2026 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776863486; x=1777468286; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAOboUJ/4deZaI2kxLEwGdVNjJvERJfqYNCMKTju7ws=;
        b=foKicO8TGLnS5ZhFxt3UjhBC8hkTTn/XPTS/g8fZ0fQ+3QH9RmDlUBKSDa+GHh/n4u
         ZqrYJYh4056/XGDb/2mEMSq8IsvVT/7XWNe219g53GmWChyOGK3DgGpdR9gvDwMc5e8+
         12Sn0N5CU2/8Mxnc8bD2nBN4UUlYOCASW9NLZrop+x2YRJLF09F3xNvYOOCQGpbna7Qs
         0CAt2sd5viBGLlay+0J4TdWWGCZYzoBHexTGAo5KS9Rwxrg4M2HKxyXIttbTVOEf2ys3
         NeUZ0jyJz6NT2+qqrt1tnSAdk1A4XPORJixpLl4LTn6od2O7zQU9m72qEkXAzK2gA9Y3
         UKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863486; x=1777468286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAOboUJ/4deZaI2kxLEwGdVNjJvERJfqYNCMKTju7ws=;
        b=Aib4YpZ7ejw7SX3oJ6sXDX1NDsXK2pa9FlRIX0Xe1HTp8PJJRRK/O1GYJx3lMjniHa
         DkGJjyz22PaHOjOQTJrIox/tvmLXk005nBtjXvhtGd81rpRP+1uoFMuhW1U2l79sl8RG
         kp4UJg2NrGVxb3Kg1qEFtVFOzAqKUkGchALSJ1olTZDHs4Mgc/3m289rP4LklPLFjpJJ
         eKTgY7LVwhPxwHSMiiU+UCr6HSntKMg0VRnO9rTt6CwhMgvYllw7GrmAEdXHTrkrCHB3
         k8UNv2SvsT7gpcHIg43TYDXBMd15sbtgFWxbvtCpcUevb6l+wqDkBRFGLpt2I/r4DUhG
         u21g==
X-Gm-Message-State: AOJu0YwoXH0ynVw3DoNwTVp/cNMFjU3PQuMxLT04hwkPqJmRHTFJlKsW
	bRGH9M2oQuIMkMl0ii5xBrNSjIBhx6ol+y6z8EX4c7J4UOw8e6SKXX54e2zHEg==
X-Gm-Gg: AeBDievFdLUuxPed74MkcGaKQU5esnWWpuxEdO2dbfK3T9abA+69PoFHwGYKuXErY9M
	rYGVefhJnTfV4M+PZmAiB8aVNlZW3ONhy1+sAK0JYCUCWf2VkiSoWF8WOxEcZJspLPmVN4bYisz
	IeuoxkfkiPEy4Lqp0kuElxaj0fKxT2eWkychZiJtwWgx6ioOP/eB95C7Mp8Eqwd84A0LJ65Mgay
	gRc8KqKbxlvGo2mjfugTUD5POxZF9svuscceWIXsXfKbeTJBA77yCt8C6jItwxyxrVK2gZcpv3Z
	JQmOuoK1amZea3eIDFrlWVXr46pX6+AyWhxKuDwVRZz7Zv5XUjRForop+ECQ/PpyU45y6bJ5wJ+
	ly5thL3FxLJlNQ8sZYXiDZW4EYavjF1GrG60jmSuoE4rhd6mIqrZ2dzo5gxe3vzkxFBw3KPmnBy
	tfCNw3VAYA3H4MLT8G2Bm2DMZoVL3mQzTq/hSicgykxm7THpLjuPtqqhM0FQUwbYg9yG2lRpLlt
	7N6kDk8C/n3Pwb7xg==
X-Received: by 2002:a17:903:3883:b0:2b2:539b:d29a with SMTP id d9443c01a7336-2b5f9f1cae4mr226078775ad.23.1776863485899;
        Wed, 22 Apr 2026 06:11:25 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:5cdd:bd85:7f37:6252? ([240b:10:2720:5500:5cdd:bd85:7f37:6252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cdc6sm162008715ad.46.2026.04.22.06.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 06:11:25 -0700 (PDT)
Message-ID: <f7318109-8c0d-419a-8b02-cc416ea9df71@gmail.com>
Date: Wed, 22 Apr 2026 22:11:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: delete unnecessary empty lines
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org
References: <20260418071217.13866-1-ikegami.t@gmail.com>
 <aehj4EER-v3Wmupp@infradead.org>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <aehj4EER-v3Wmupp@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_061127_373492_7EF9CA98 
X-CRM114-Status: UNSURE (   8.84  )
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

On 2026/04/22 15:00, Christoph Hellwig wrote:
> What drives this?  Like most subsystems we usually only take cleanups
> together with fixes in the same area.

I checked the scan_work implementation then just found these unnecessary 
empty lines.
Also I sent the patch after checking the scan_work below also so I will 
send the both commits as v2 at same time later.
   [PATCH] nvme: set NCC and NIC effects for NS mgmt and attach

> The more important fix here would the incorrect indentation for
> the continuation of the condition above.

Okay will do fix the incorrect indentation.


