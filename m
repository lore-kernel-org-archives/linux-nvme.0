Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574411093187
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 08:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+ddPzmShYfEe601fsG4Yrd9UcZ9rqDy+7z39mg8d99Y=; b=vVIQHpUZ2Hee7g4zQKwyU+0C4y
	QDaBmW8hWUCYyEWxgH2fd5RsYjF6YfgxOd6Pj911fyxaFdBpBdgkTHr1lbwMLza523RsGbMnnIpsg
	gJtGP30zt70f6S1LhGOi+XaTx5bpR3Qj3Btt/Md5xdt9960Wpxbjk55AJ4RncoQ7/B4QRS3dF7/Rh
	NZdmSfCYQa3YdLTlQOBH3f8SKz4jO8vm/7psLP4BWAjOZ1wI0sVu0mrtG74ZoQLcagtNAfqeHfnvZ
	KgnaPrg5egBu2Kw8JSMC5yKveAF19Aa0WFk5yVOGNr3SN58oxY1Y5prH/avwB0VjOT1ZhoJAIFH3U
	jKRNHHUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3UsS-0000000CJNb-2g9G;
	Fri, 20 Mar 2026 08:06:40 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3UsQ-0000000CJN1-0sah
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 08:06:39 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-82c20f1e890so46676b3a.3
        for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2026 01:06:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773993997; cv=none;
        d=google.com; s=arc-20240605;
        b=RqviXSOQEtgXRSr+keUN9YwPLGPWb7V9aP3cOXRVzYTZ3kOeBprHs9y59I3bnkCVro
         9wktIAExvEGaS+nBr0GJcGOEkIhjD73qA+/0UDzQBc7TYn0sMXy/naNOMpvIs/RueJix
         1UnOJgP7ftFc1CXUHAPd/XqPf/5hJMlLgk1QJMOUgSuaWkryQeJwYLVcInobTLLjgk4l
         zZ3aKq6saHCJqIZbTI9JoOId7J2C2nZdM292AjOO76QJ13XhWw5aXusOVHtuKg4yeQgf
         n4b6mcWAMGfTa0bVJESN/X7EVxAoldPZqq++9m9LBHpHK8Kd7FlIcRDTioUHQTfAJwRX
         c2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+ddPzmShYfEe601fsG4Yrd9UcZ9rqDy+7z39mg8d99Y=;
        fh=gtKryYvAirunkW5A4Fbx0dfN2Pa7a281T01xT5vDsbg=;
        b=LKDpNHB+svMXIq8MTFqXleBl9pEncUGlgJmPvhcpZQxsU/UoWgM94uL+80M1k81ygM
         hnhQkts8xGQE04llGfZPAwqr2HGPgimZIXN/w0pLfhKvaljbfhHEZy/m1d7ccUBxLsf1
         2EwdclCrF9kou16e0mk2RhvLn96geTbDyhvHKPoqWUACVPqdCdQgrRc88m5inbpIKdPz
         wh2AP22rzAUW5WhnEvjW46UmFjbHXrdftTQG0KDL+HcTYsEsF5T4V1IH/2xy0Ad9O/ds
         3VjNA4lOqcBoDoO8zZrVRoeZYIrlrgceiY9WhPeSgWM6jgvh280tGJ47eFLKq+xIt6TO
         1t5w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773993997; x=1774598797; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ddPzmShYfEe601fsG4Yrd9UcZ9rqDy+7z39mg8d99Y=;
        b=Zyb+wRok3NsZB8M15gOJ6k7NDnWSVYrPxoVqma8QTjN12TnIVOJFc7BaFjv5pZY8ny
         qDMxGMln5orpqaUxj6E1GldYpzdm+zKAa4EiNFPbJpJ8rQY56SoZoduNh1scTRxcPbLS
         ++3V5W0ir0VVFodIxKpnzfKaclA7NWDSUNCRDvqzMoI+8G5V6Bh21Xw+0ZtFGdxZmZMk
         4LQCcykmp1iVNBk9GctZsg9RJMNkTKqwjJbqBTBy0OyXNkFNb63wRGSMWwt96R5Ot9uH
         NX3KBq/rhB6P03jCr/4vsRduEqGjwBrZx0SVIw5Jv6Fn2RXQ6+X8N2r+jaO+4KdU6jC9
         bD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773993997; x=1774598797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ddPzmShYfEe601fsG4Yrd9UcZ9rqDy+7z39mg8d99Y=;
        b=AtBZKEdtfbzz2MMkSIMNiZbAUegLk4FKfeESn+32TUIulDxtbpgHjX0vnic2gQR1Qu
         ob9BGqscEyH5wnWe8BD6637rvN1M34yNwgGdaGHandMQ9fW2RT8StRRbN6jA1D4m6AVj
         3fmI5xQ5LRRbvEQ4dG4iYSJeulzhQ4YdOs3gfKAXL19ch4fIwWV1CbRFdkr6Rau7tD+L
         no3pNJigQ4v6pW6mQ5fQ7wwWY8S8lDC7QBA2Br/SrJhKaIDpfIs9I1YAak+XA+J7JNUG
         HEbEGFIy6kC6OgZ0sVpCSYF4l1gIEkX4oFKLYXJbHN2UWQ8dG17F43KKoJjZ1HOzxYnX
         h3FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJBbDHgtFmLsIRrIprX7en++nDWuydCiaNEN5n6qY3YNKwVI3AFcFWNdk8GfxA2vYLyce5eFr/ffsW@lists.infradead.org
X-Gm-Message-State: AOJu0YwfxxAb4ADOzF0zXdx7fuXbKz0VAGb66Fjl8vODuITXC7iahOUp
	zZBbuoc+3Bnyexgjj/ndcezgnkqieLCjM3xYOpsK53j+evA/zDMs2GDnE+Svwv45rRAO2GImNj1
	7WcwpNzVAwh1CoaLQ/TGSaMrJzts5xic=
X-Gm-Gg: ATEYQzx/UD51EZF4VVbIy8QzPtf/s/gw1TtYWFrbusat7vxzTVMzckIsZrBnJGve8Fy
	8a0FGIg/qs6cEV5P6kAkc2GUEFXjEok6na6PrR1l4rE3NsOijd9W0Q3Ney+vM/bHOItknP7mNY/
	+dbyrTIy4nbig3/dQ6xETBbb2eaN8KB1TZPWd82ODACpNNAbg0N0+JWbOUYlCLHhv/jpojVsy/Z
	klp7jg5gtSHUDh53LLc1/vhfv3hlcUzuBJSzyKPEYEzReXYa8yverURABwt+yQuVnxaiRoqtxfN
	ccqyYWg=
X-Received: by 2002:a05:6a21:33a1:b0:39b:bdba:7da1 with SMTP id
 adf61e73a8af0-39bcebbd0edmr2397787637.43.1773993996789; Fri, 20 Mar 2026
 01:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260320002045.1927526-1-alistair.francis@wdc.com>
In-Reply-To: <20260320002045.1927526-1-alistair.francis@wdc.com>
From: yunje shin <yjshin0438@gmail.com>
Date: Fri, 20 Mar 2026 17:06:25 +0900
X-Gm-Features: AaiRm50-mgE9FbQoxsfaFykiuQh_wTeQv2647GS1B63mtlDnZG_oZZzZqaLVOew
Message-ID: <CAMX6_QGYqBZDxvObAwvCEMoU-iUA4koyn6LSb+TTB=vEyLksDQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] nvme: Add the DHCHAP maximum HD IDs
To: alistair23@gmail.com
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_010638_247230_A04A2692 
X-CRM114-Status: GOOD (  15.04  )
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

On Fri, Mar 20, 2026 at 9:21=E2=80=AFAM <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> In preperation for using DHCHAP length in upcoming host and target
> patches let's add the hash and diffie-hellman ID length macros.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v4:
>  - New patch
>
>  include/linux/nvme.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 655d194f8e72..b9d3dbe2564d 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -2332,4 +2332,8 @@ enum nvme_pr_change_ptpl {
>
>  #define NVME_PR_IGNORE_KEY (1 << 3)
>
> +/* Section 8.3.4.5.2 of the NVMe 2.1 */
> +#define NVME_AUTH_DHCHAP_MAX_HASH_IDS 30
> +#define NVME_AUTH_DHCHAP_MAX_DH_IDS 30
> +
>  #endif /* _LINUX_NVME_H */
> --
> 2.53.0
>

Looks good to me.

Reviewed-by: Yunje Shin <ioerts@kookmin.ac.kr>

