Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D7CC27C4F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 20:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CcSQlruAv/ZGhVVQvhK6aS9XvyJeBVVASckuSR3sDqU=; b=kzqaQ3QmysCgYqr5ejD8/5DSIi
	5o+dOBdlbUwaBvYr2ouQSIhjWGon6hmXZjMkegT3bM+qlU78fry0meV9fQ3cPXYtxPSMd8eD3yA/f
	r3qLrmAwUiK4w64kpUKxYFcjgR+0CGRZLefLST06c66Axt8M31bftn5edKywvLJluSI15og0Blldq
	3d7OjaOucRCyu2FP8N+dfpp2WFotejg5YiVfR3VFsWQHK9ANbo6KEWG1he7upMAIht0UfwgnFyU3x
	UFx+8lCeJYEvriVMf+LNB8h/jPw+jTVpUZ7HfTZdjETwnIOJVNMsur+Xkx07LSgOZADHJhQzLtTFt
	uI70oHSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHqvv-00000000PDS-1k9u;
	Thu, 13 Jun 2024 20:20:31 +0000
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHqvr-00000000PBe-3aZz
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 20:20:30 +0000
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6f97fc3f2c4so39347a34.3
        for <linux-nvme@lists.infradead.org>; Thu, 13 Jun 2024 13:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718310025; x=1718914825; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CcSQlruAv/ZGhVVQvhK6aS9XvyJeBVVASckuSR3sDqU=;
        b=15snn0XPn5aFnYyxHIqSH5jAZTHYhjNtj5vMOxFZ1aNkpbJBjfR8jEBMkGTa456nJ1
         Z/eZthfNP2qOH3CCievaJagsMky8gK7hAlNJ0b11G4kHOMVBIeXc30gmyLf+mNe6hkx7
         NWpsifoZhH+FxhiRt+ydYtF5DGgXZU20MnvuBR7jfmF68aPf+m4HURds5NvifTmduX2R
         0Tifl7LwbszW3lSLmNb3cFFn3pAQhh3KXhRFPeUd6G99sGD4gyXLw6khnPllTF46LdpW
         SycCD57VVJpCzphEDsCAcAny1sPAoY6Mn8JUVakqmGzcKZXj13Np4boJcVKFnGLiVgH3
         BkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718310025; x=1718914825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcSQlruAv/ZGhVVQvhK6aS9XvyJeBVVASckuSR3sDqU=;
        b=q5jwr4EYlUkfIHamyLAZ3hJwCaLdl68XVcl5Zku9yBjBz8I9MnXX4PI8xUgfrmi9c1
         JAA64ZZOhKHfH9x/bJ1wzsYFyUTDDxqKOXmzTIgCw54bpVyll21P9o7iSR5rmKMTP4xN
         ZS1moZN0jlpK4MVfBO84EMQgtSfGckBtRXaMnstPhoDq+opzFX1djchB+tXYQGWwty/r
         G+8802lnNel92iwBK4RBvttTZUUEHdwZAKEvmDrMpSVeTZizG/RIlWRm+3krWy+Kp4TY
         9MW5BzFjFDSODpw6+pDYlViDpNkZVqjk4ZtVKYK/DXtJnbFZ6Zvi1ttr8DQplsn+GMo1
         BEpg==
X-Forwarded-Encrypted: i=1; AJvYcCV3gFWw7OteZaJaX2sdescGhi3MF8DvOC4JYIKiKlQjGvbDJhOY5FBoOPaUC0JtSipUOCI+T6x+YCYzrlby0RqwyBoT3HwDT1gAMUYe6yk=
X-Gm-Message-State: AOJu0YywUnGJo+sN6WnZUfcIA+rwkR8XSjE0ZWJOuKsW8tZWB8Kc3dbT
	EWHtr4bcAzJw8wJ7wQj+amXZHFpP1grDt7N3Eg1PTqjXu4vX63RfBDhaDvxo8wXMy2+3V/vVQiG
	i
X-Google-Smtp-Source: AGHT+IFqEfySnhz+4z800Tn01GwY4H2hJp0SN10f+OA25wrvWSEIJXlrVX3UnXtd7s3h5KPhKIcTcA==
X-Received: by 2002:a9d:75d7:0:b0:6f9:dc1b:9fd2 with SMTP id 46e09a7af769-6fb93b03706mr864890a34.2.1718310024684;
        Thu, 13 Jun 2024 13:20:24 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b1b0b22sm331952a34.22.2024.06.13.13.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 13:20:23 -0700 (PDT)
Message-ID: <0ee63c99-764d-4f2c-a62c-1c89625c8496@kernel.dk>
Date: Thu, 13 Jun 2024 14:20:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme fixes for Linux 6.10
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <ZmtCG9l7m2lTYErI@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZmtCG9l7m2lTYErI@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_132028_014269_26E694E9 
X-CRM114-Status: GOOD (  10.15  )
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

On 6/13/24 1:01 PM, Keith Busch wrote:
> The following changes since commit b1a1fdd7096dd2d67911b07f8118ff113d815db4:
> 
>   nvme: fix nvme_pr_* status code parsing (2024-05-31 13:50:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.10-2024-06-13
> 
> for you to fetch changes up to ff0ffe5b7c3c12c6e0cca16652905963ae817b44:
> 
>   nvme: fix namespace removal list (2024-06-13 11:47:40 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.10
> 
>  - Discard double free on error conditions (Chunguang)
>  - Target Fixes (Daniel)
>  - Namespace detachment regression fix (Keith)

Pulled, thanks Keith.

-- 
Jens Axboe



