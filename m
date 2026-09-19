Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED80C982D8
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Sep 2026 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J7n75dlxtos3+ITb9g8BdRmQ8irhbat1c12Yu0oiLPQ=; b=rsO3Fgt/QVs/NjM02XfTjV+hNJ
	YcyYLCB/a+rX41npzECybkHU9cRJn6glrnfNw40t5LfxUmfXMGgW3716gLOTdnbYo3jhiNByckQIq
	2hSBESAsEOKb77stE4abIYMEnc6+nXCqUyBsTLT1/BJF+s9MXJdGjCbgshYtQGz6vDG4G/FDH7RVX
	yLySx7rpO1NdA8KE1lbMG2HmK3LbMUOY09KmzCWc6QFlaCtIDf0b/TdiK543XNiWKxFw1GBrabNNw
	+lJmBRQ4753/O9vFuJaeswtU/SGjMPfs5nv8djapSmVUSXMSsQVnNhr8PbsL5ehNuWu8Klq9FMbLA
	pe9u60yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7wDj-0000000GNzQ-2JLi;
	Sat, 19 Sep 2026 14:39:15 +0000
Received: from mail-vs2-f40.google.com ([74.125.227.40])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7wDh-0000000GNyy-3SF8
	for linux-nvme@lists.infradead.org;
	Sat, 19 Sep 2026 14:39:14 +0000
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7a0477a4a01so539325137.2
        for <linux-nvme@lists.infradead.org>; Sat, 19 Sep 2026 07:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789828752; x=1790433552;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J7n75dlxtos3+ITb9g8BdRmQ8irhbat1c12Yu0oiLPQ=;
        b=T2usUkUIFlsg9kXLJP9+LL3UH3aivPtpSGigy1m7Hf8ve3EzShE3NhRUUMYM9NAiRv
         CezLUNg6TCaN8E46EmCYVlD9VfQnE0UzNlRuDY4ce1YdTAYf2/MUGHt/VlOfjfh8rJ3r
         2fdl1tW1R5EW+TUpJCSTWH+hJJ1PAPk2PHsE+AUHrrG+xFbvbfrsgJZd+65ol5/2NwYi
         bms1CusC3iTNQe2dMNHZOkIIYLc4JGjEF9g8vynx0AIQrGoed/GMPFNO+lFhKWjDvbCi
         u7HarWRmEtHmfAzA8GyADDXHvqtJQwlOOsF8LvnHm4wNa2qBjGIZHdEC1T1nM7rLmP1M
         PICQ==
X-Forwarded-Encrypted: i=1; AKwUvBwCIUf6ZHbV9wRJa9hYIGMsru0HIJcBqcm5xYYkMF7Tqam5z4oKibr6brIGNZtINASW2ktkv7Sg86br@lists.infradead.org
X-Gm-Message-State: AFuF++lqv4mHVeAXmyn0wZNKEiAOpE2jyCO8rPJaFBjPdACCc3cmp3id
	je++BRXbGZsMW937YfuZ6fY6jbGINAA6Sc8QZHQEGBD6YIzGXKjbr8oTAPMTSNuYER4=
X-Gm-Gg: AYBFou3Q8z7Ta5ZGsuvAaAcQN9vRye+XcSgXewSXq6haplE0WX7D6qzWZSdMuTruuTb
	RILcUqiChhcPF+oOg3iDvYEU9jRMB57A8o1+6apzj3KMTMNcupJUafLtt3AQ4p0QaMssb3t7/Un
	+9RVlbFYDoZGLz/NboXZwQj5C2KWtuiJfS0CzHdUVUc2c3b5Ws4AzK4OkNgbNtHs6bboeuy/yIx
	xlcBsbhNms6IaXOQ8dhyOazHRfoBVOAlNZrpd4GpaqiCozgrq5Kis0KtiYKTVErmwxBeFgqArKX
	BUizbKOmTikrZwmK1poKOYRZupZ44JGPalf4uKbpufefzB2sQeoYVZSdbFwOFGo4pjfOMdbZt1v
	Hc8YDpfULidUz4sMQYlfa9MrUCAAbQO2hLJNQEpKCX87+q+FdX7D2oMOzM1Kfd0mEe+HudCsRF4
	XSq9x+XPjbog88UdI2rbCRGZceW7vCf48LZUB3ZItZ0XR6Z0dYRrQgntBJ/uKxqCYvTfwuy5AWd
	OwnbeB5Upr8mn5jSvw05v/eKY0dsH1K8Geq3HGkZLfhPNIx4/Zs7Xk=
X-Received: by 2002:a05:6102:5e86:b0:7a7:195a:1b29 with SMTP id ada2fe7eead31-7a7195a1f70mr420888137.35.1789828752044;
        Sat, 19 Sep 2026 07:39:12 -0700 (PDT)
Received: from [100.96.0.25] (corp-190-12-36-222.uio.puntonet.ec. [190.12.36.222])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-984b4ed2880sm2969614241.0.2026.09.19.07.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:39:11 -0700 (PDT)
From: Ing. Alfonso Kuen Arroyo <gerencia@idkmanager.com>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Maurizio Lombardi <mlombard@arkamax.eu>, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvmet-tcp: report a bounded MDTS instead of "no limit"
Date: Sat, 19 Sep 2026 09:39:10 -0500
Message-ID: <178982875024.43804.2680537645505838340@idkmanager.com>
In-Reply-To: <DLJ4T2GRQSA7.1NN9YA9M8XUDK@arkamax.eu>
References: DL41D2NGEUHW.2UUHTZ6LLM9X7@arkamax.eu,
 178978683646.43804.6940923486189370705@idkmanager.com,
 DLJ4POIDTYXQ.2AOJP9BJAWEOX@arkamax.eu <DLJ4T2GRQSA7.1NN9YA9M8XUDK@arkamax.eu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260919_073913_869369_C28A2BCF 
X-CRM114-Status: GOOD (  17.75  )
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

On Sat Sep 19, 2026, Maurizio Lombardi wrote:
> Yes, but your patch sets NVMET_TCP_MAX_MDTS to 8, which means 1MiB, not
> 4MiB, so a 2MiB command should be rejected, even if it's under the
> MAXH2CDATA limit of 4MiB; or am I missing something?

You are not missing anything - I mixed the two numbers up in my previous
mail. The patch advertises MDTS = 8, i.e. 2^8 * 4 KiB = 1 MiB, the same
value nvmet-rdma reports, not the 4 MiB of NVMET_TCP_MAXH2CDATA. So with
the patch a 2 MiB command does exceed the advertised MDTS, and today the
target would still serve it: nothing in nvmet compares a command's
transfer length against MDTS, the only rejection is the 4 MiB bound in
nvmet_tcp_map_data(). Sorry for the confusion.

> And indeed this is what's missing, because the specification
> explicitely says that "if a command is submitted that exceeds [MDTS],
> then the command is aborted with a status code of Invalid Field in
> Command."
>
> Maybe it can be added separatedly with a dedicated patch.

Agreed on both counts. The enforcement belongs in the core rather than in
a transport - a transfer-length check against nvmet_ctrl_mdts() when the
request is initialised, returning NVME_SC_INVALID_FIELD | NVME_STATUS_DNR -
so that every transport with a get_mdts gets it for free. It is a separate
change with its own blast radius (it turns a currently-served oversized
command into a failed one for non-compliant hosts), so I would rather keep
this patch as the "advertise what we can serve" step and send the
enforcement as a follow-up on top of it. I can prepare that follow-up if
you and the maintainers think it is the right direction; otherwise I am
happy to leave it to whoever prefers to shape it.

Alfonso

