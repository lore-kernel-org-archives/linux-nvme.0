Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C44D111A8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 21:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zMDFtu2jkOmGbSYiqP5yRdfGOKCIAOSNXSqV1vwG0h4=; b=DRWUB+Ye4ZsDZuFVX5WWUPy07O
	1UQ57nOcVykvV0eAUZNCP2Xr3M+Vd7hdX1JEaInV6oQVxVnvbmJsZfT9a+6KLX2YYdFv3+fmjVBk3
	kVXIyIMlVCUWQSOus+2fEwS0NX62YPvACvVbBveA6IEGoKQAgBkTHUVfexQpmyvuOdmb82wzaAGRe
	fmRbOrddAArC4Iyvt4ebVt6WyrBKWxMcGOwAztQ+zAY9Vo4bjwaDxNbP4uXd1EqgDjxaS60uqb04d
	ZnYn+YpI4gKIXjH+JMa9fDeMNE33iJHrGUt3OUdErBGzCAoW0/fmqZaSGLLzNqz5AJlt9TLfoC+4W
	rTF6JIeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpME-00000002bAn-2Udm;
	Sun, 30 Nov 2025 21:53:26 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpMB-00000002bAJ-3Xbd
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 21:53:24 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47790b080e4so15953605e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 13:53:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764539602; x=1765144402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMDFtu2jkOmGbSYiqP5yRdfGOKCIAOSNXSqV1vwG0h4=;
        b=iVKONaSEA3ekBb3fpWvSLxNr1BkWTE8Vu1rqBRADiA38eTgGPc7a6fJ8j6cvMkW7LY
         uA/tt9H/Jj0PUWAi5V/4Z9jzJtvjujC8GybmY4PUwS8eFUMUgDk+t1fnn4ysFwaZymiI
         J/LsrzgvFSL4qa365Wvh82O5WQSWP6V8amyQJDVJCPQi6QFg9bM4Z8X5+l515BP0GfGR
         r7PognFm7kt+BYYlVqJTYYS0903lCI+n2+C7R3thKWg0UMlFpSnTatT1kIR2FTTdsQG9
         vQ+2w5Z3znNJr2snyZvuSmAWaB0O+Pta8ZHC4qe+nf7OLqfu9LD8/wsBkiLmVBELANcX
         FXYA==
X-Forwarded-Encrypted: i=1; AJvYcCWFk8MKYb598SbHXTFi+/B9NJTkNpCYbsFIhBjl58yjna1yWWtEnLB1isP12+79+jUgHvRcgwq11x9q@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9KTaryPUgLmwSw/91zWrYuhxzRK+SxBGy94vFpiNqeOOUF2GQ
	Xl8Y89tflrMca0EqLY2jNpTGT9VI6B48f7MqFK9b0AhMTJMc/jbSR/pO9Azu+w==
X-Gm-Gg: ASbGncv0sVlvzstRpx1oBtP2CDz0TmKU+tZYvEP+T7Sm3j3SPOvq6KqjLIuHfKCrFLG
	eAgaPo2P6ls8C00xofRgEee6sE5MZrIdwDxqcu1dwakXd8fMrDnmtB8B1i0VdotHo1kSpRGTrXC
	129nbWeRPWnlKKaex2jMOzrClLQlH40aF4CWfrTtSPzjH4R3sxFRR0HQXGadrP+Q3wcmhJtbnoG
	Pg0W8MKRw/0QJ1rS6YKWE9/E/hjhj92IOLaznkhejNa/KKqWEcGeL+kO6kSSs5gDYh3C+cJtiec
	NECdhxqSTBv3H8H3DqrZ2zul8oUpCPUKiwlvHfoLu34Vkb+I4WbLDsE+V9wRPd0VXmDmTsWWF7S
	up64kjxS3X0k/dgE4NPv4HziPpxYi3Fibt/YJ4TyvIYLqYaMONbiWEblWKds8rv56hEp6XPv1MJ
	1KY0Yjd4lJ3BFDhbtjC90RaGtxBxyUMc4Mox4OWfON
X-Google-Smtp-Source: AGHT+IFhv+UO2jwTXnkpgz1gC1hUA2tlzKzXIMq47Ur0O0wywpeZGw8m0Ls7dieqWoAL2I2qa51dGw==
X-Received: by 2002:a05:600c:1d1b:b0:477:9671:3a42 with SMTP id 5b1f17b1804b1-477c1133e4bmr353106255e9.35.1764539601750;
        Sun, 30 Nov 2025 13:53:21 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791164d4f3sm208342565e9.13.2025.11.30.13.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 13:53:21 -0800 (PST)
Message-ID: <76f11024-341a-4aff-a7b6-e268d2fe04ad@grimberg.me>
Date: Sun, 30 Nov 2025 23:53:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] nvmet-auth: parse dhchap key from configfs attribute
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-6-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250528140517.3284-6-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_135323_895568_A80BC6E2 
X-CRM114-Status: UNSURE (   9.27  )
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



On 28/05/2025 17:05, Hannes Reinecke wrote:
> When writing a new dhchap key to the 'dhchap_secret' attribute
> we should be parsing it directly and only use the pointer to the
> inserted key. This avoids having to pass around a pointer with the
> actual key material.

Hannes, is this an intermediate phase? one that will be replaced by a 
keyring?
If so, its good to indicate this in the patch description.

