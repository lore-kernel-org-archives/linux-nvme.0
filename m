Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD12DD29DE4
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jan 2026 07:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vBfIBVzM18lbiTFX2YkmtCPjzcMyPLF2x6f01J7O+vU=; b=llypwFWOTtj2SM6F8obVUXJ8Wd
	iASnmv3SXgQJ8Iv/wLLTeuUBSB1bkVp1dhRp4DG3xvEsBBh2pDg9D1St4U5GEaCf0sJ1OyDLhV1bt
	kPespb679LEL12EZ8LZhJcIArSPAhvq10KrGGbv3DXTv0VViABfvGleHFW+bHs/mYNpfKEXTZ26Lz
	Xmy7uVpi3IPyh16RAifvagQCGoay1JjrtB+5M5OiJYbRDyIf9o5avGKWUkQvx+35+nRKRArPZEDuw
	iAJLyugLQzdXukEigx4dimkeGvIOWt0GEWUPvVr9ggu/btwmaaTop8xdZ0bpWRkdrzX/T3LmG7XYI
	EaMeswoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfYry-00000006fIx-0Uxm;
	Tue, 13 Jan 2026 07:31:14 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfYrt-00000006fGy-0eVe
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jan 2026 07:31:12 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-7b75e366866so1565269b3a.2
        for <linux-nvme@lists.infradead.org>; Mon, 12 Jan 2026 23:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768289468; x=1768894268; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vBfIBVzM18lbiTFX2YkmtCPjzcMyPLF2x6f01J7O+vU=;
        b=Y7SHEXACoT4qLIT0skQ3AQFs9RqF1ayY9jK+dF/d8MC5aDAe2d9YjdKciN0QdVH+kB
         HXwZ7VnWyAZssIn0GRNm7gKaoQQ6PW+GPiFMvnbe5KhlohFFJrBBTy51szhPHPBQ2gJq
         KEnV2tb14/Z23udzFO5rkjSPaL1xV9MNiRVegguv9NA1NacBMA+IO8ZRy1KK3bxcMW/o
         V2Co70Jt3hLqYPMZzf3wSRPlUOTVWyLgYV7MKWSbux+JJzlG9hajEwjcQ/sD7UD3s8bE
         8ZUO1whsDTkIbYrOy+m3LmTWd5aydcaQooJhaSfNc/JDrIIkUZlg277AJOW/F31F9/w8
         ++Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768289468; x=1768894268;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBfIBVzM18lbiTFX2YkmtCPjzcMyPLF2x6f01J7O+vU=;
        b=KrucHE1J/E23TvsmJx1ZO+EyICqj2v6eon1IWSAl/zOxX+wWsRbN3LZXQuCw5GtHtk
         Atut0AgAIbVd6kUgdDTi+Xdp+HRQs5qmoW+HjcLD4qPztENKMyLse6r+NmkceWKcJkYN
         8vV/QaLpbkl3w1s2/ik1+tcneiWjc3Px9Tf1EqRMh+y1589FTjWgClIKy5oekPORNK6f
         2V4TcNHXg/K44kwcQZf/sRt1gUByR02Bs61Z2zED2X7E8kGeXp4egXtAxfxIsAqBNqt1
         l7sQ72gDpv1ivv6fC0YQj/vxK5LSRrAC0hbwn9fDkTF+qgn85NpPAFafimXmuzTx3lpM
         u9Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXfC0xx75J3k2BEojZ1ktM15/KhYNvFgIrHYyDf3pw41SB86u4WXlw8aoKEPb8THPN2esHV8E9wN2B3@lists.infradead.org
X-Gm-Message-State: AOJu0Yzj+HOF0yPOMyRCXS48gy+fSxpdxMkmAIrYD9uSDOHAedhZfJaZ
	y6Yzyz7AQZEEXRL/07cK+z3G8GCktRSzI5/wLzBBBhx83B1ebwnAylXKrp4Q3A==
X-Gm-Gg: AY/fxX6r+4FcRXhwvXFBMGZWD5TnSwVxipCpAFBiKRxoUgkzlB1AneBET8Vy08MI/We
	AVqJ7LLtEyMNh+lvo8SmXQe0eVhCAOjJY0QgaNjlf6hapzkoHxW7qAioVjUhdPSyATHh7ez7gfa
	BiddXixwhrs+aM/5FyPIlSoRJIB9gcW8qKqwH7v3Y8e0d2cYJutFujxcGQEOo5OVAbae6YmNsxK
	74Mo81kv1SDTlbsJTNSdvZDHRNImz/8mYlinlG7fpZO5afBEDHv4ytryG3CwtYIc4WO3vpcwskf
	phXeYQ9PPJQPaXLmA4gicpuQzR5UucwUycB3BcoFIPKwl4s5yTOyUR/TLBOyqhd6rNNDZVjZXQL
	tdLOkFMjvqvobFtbXGh+20Ru88t4BrlDHjL5ahs8condbRXIfABR8hEkjiWyf8NqOtkCGRxIp+T
	c2QaC/IOg+1sl2sgACorsWre2V8UfbWhDKRmE=
X-Google-Smtp-Source: AGHT+IHa00/G/vBRWy2G+OgSLqZgVlEGdvVT9a8VNW19qOsKj7Z4nYi52d/lqX13GAXKKm23lxhZ8g==
X-Received: by 2002:a05:6a00:bc93:b0:81e:5a6e:340 with SMTP id d2e1a72fcca58-81e5a6e0706mr9219123b3a.26.1768289467983;
        Mon, 12 Jan 2026 23:31:07 -0800 (PST)
Received: from [10.0.2.15] ([202.3.121.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81efe4a95c7sm9319033b3a.37.2026.01.12.23.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 23:31:07 -0800 (PST)
Message-ID: <910130bf81348f14a0162288c5977ac00f3bf2b4.camel@gmail.com>
Subject: Re: [PATCH 2/2] nvme: add iopolicy field in JSON output
From: Martin George <martinus.gpy@gmail.com>
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: wagi@kernel.org
Date: Tue, 13 Jan 2026 13:01:05 +0530
In-Reply-To: <20260112111731.1631091-3-nilay@linux.ibm.com>
References: <20260112111731.1631091-1-nilay@linux.ibm.com>
	 <20260112111731.1631091-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_233111_468860_C159ABC2 
X-CRM114-Status: GOOD (  12.74  )
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

On Mon, 2026-01-12 at 16:46 +0530, Nilay Shroff wrote:
> Commit d0b4c6cf0006 (=E2=80=9Cnvme: extend show-topology command to add
> support for multipath=E2=80=9D) extended the show-topology command output
> and added the iopolicy field to the subsystem header in the text
> output even when show-topology command is executed in non-verbose
> mode.
>=20
> However, the iopolicy field was not included in the JSON output,
> (for non-verbose output) resulting in an inconsistency between the
> text and JSON formats. This change fixes that by adding the iopolicy
> field to the JSON output when the show-topology command is executed
> with the JSON output format.
>=20
> Fixes: d0b4c6cf0006 ("nvme: extend show-topology command to add
> support for multipath")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---

Reviewed-by: Martin George <marting@netapp.com>

-Martin

