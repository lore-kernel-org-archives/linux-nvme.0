Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7913DC624D3
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2026 11:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0j559ff+MKhCJSeNNUDAfuwSwdY5qog5jaECMNUrVgM=; b=mJYJwu9M4FnjQRqxL8pOehm9oc
	DReWK2CTI9GGefWUAs/2SgtjL0U9+4BGx3MfOxD85qPt6ZwsZqUhlqXHiJSWQf+ad7BlUZgaacq8k
	csPDiBgGJBaeBqF2c5pq6y2Isxw6TC0iKz2BAFRiO0hy31q2dNKt9+pPCy0Kz+iWh2Da+gN6TwPCM
	4DKBVJTzl2Sm7U874TtX3/DLs8R5/ELuCccQGpDsDjpS0Lh+XyRrakiE1s8xHJuPKaWfK4VGL5Y4R
	lTHWw9Xzcq6IG1eaVPL+SYspclsKQi4NRfo8vPLPcjxD8u8w6PlwwqJYmObRl9ryT8H/5HsUdJTms
	1oRacqEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2Rsa-00000001nLF-26eb;
	Fri, 04 Sep 2026 11:14:44 +0000
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2RsX-00000001nKO-1sfx
	for linux-nvme@lists.infradead.org;
	Fri, 04 Sep 2026 11:14:43 +0000
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-7f3ece23165so717793a34.0
        for <linux-nvme@lists.infradead.org>; Fri, 04 Sep 2026 04:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1788520480; x=1789125280; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0j559ff+MKhCJSeNNUDAfuwSwdY5qog5jaECMNUrVgM=;
        b=was2UI/bejxzcorBrrVAyU03NUFcNIx04ft3EQVrkrPxQL5BSWXqRUfhEC20J7LdnG
         Ab4w5ha97EZxVxdnioM90fJvpZ9uYARANV9GCBAYa/ITElM/8bg9Pt7uJe9uSVLQq5hG
         homGdL/ixuxp1SKemokVna7sYlnueDKn82Qtzd8BkhJEvfndpi1ZMtDH2o+IFA/OVgKJ
         zOr8taGbVtMwQXODfD3a2ZvyWhWoLXB9AUeAS+j430yukl4Dg0EMwfD6rqrd3jGeA1Uf
         l09Ktn0y0ReTMCeVGzbjdQ70p7CgxPJfh5kh6Dt1IY5fen+vfJ5h4VeD444/aQlM32VM
         cVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520480; x=1789125280;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0j559ff+MKhCJSeNNUDAfuwSwdY5qog5jaECMNUrVgM=;
        b=WLnIvZW4WlTEGzCOAajEaXSf8YbCQUc5An/JxoIe3QmSMSWk6il0h33fV1rMAmngDl
         qPDJITWMZv/4+EwJhpeubxaoIrYufP5pAiNIkjazFrtxw/9lx/qLkxezzEkwi3xbsjoD
         iGA0+D6oYsPHWU+cN8PVWvfHJITay+lSfOBCnCnS3jqVKAzoiVmM6rE5sM1xlzTAnirG
         5JbkWi44ITQg/b7rwVYydK79SBJv/ap6beffiE+AA0AwisyVvOMpKL/67ODrUg+KIOth
         wtK6O8FfKdqP8DLaHppEOtcnw7vt3zOQQKXt1Wlb+17eOAE84BfemDmIohb2z2DGnRui
         T/ng==
X-Gm-Message-State: AFuF++lMEa3sNl5A/BHBj/KqXT0dP9xg1aJtlHFF/mYqlSXV4RStwOlN
	v+HQb305z8G7F2dNIm7dC7KqfjpvyONnQ2sSFFJxXXAgsAe3mAUJBQqyFvTG7dQuWiA=
X-Gm-Gg: AYBFou0Hg5z8Pe/1vACV/bha5Se8V1fCBeorrkHOCFPt73IYQnlBQwkjvDznQFbRMoS
	zmhp+AJkSu+EotnALdiP9Liz31ArWMf46wrwIOugYNSjXGBsLw3Vc/jQooyVzDkpfjgeT6zbiKE
	TZhvMQAwQ7EQgaLPZO1zpgNUd0aSuMoQ1oW6L0MHIryUOUsl3KC8aVwrm7Y0BCvLcrb+jUjedqx
	R6m/v+fnglgqiCusFx/9rmc8C8UVamIKA4vSdEKiSHGVRfemWdELelqBMWkCBIeMbrJUd5eSv7p
	EQPO7IqHiPYCj5bkGx4GuwythxE6/7wdby8Txl+s/531ON9+R9YjUI+1gJXoncwNWoiG6kixl/A
	LVNvNOd4DGPVORp24NGqMTiZPnIyg+H0oKJ/31HBNRizKymVWFsSIyZjhBzkzcM6yArpX5Jssrh
	9SXY9Rp8pBEdCmILtDNyQo2h/rjFNoWmnI+mKxisgnI/pZDV6XZv0wXm0lKSESGIep18ob3Re3l
	ay02pRxj4ImjDQwaSMBkZyVocQDk4CoYDRaCIIZ3skC7GcWggk4RdWcnpiAcsCTVcFC
X-Received: by 2002:a05:6830:6d27:b0:7f4:e729:3560 with SMTP id 46e09a7af769-7fa1ddaa733mr4512562a34.5.1788520480194;
        Fri, 04 Sep 2026 04:14:40 -0700 (PDT)
Received: from ?IPV6:2603:8080:db00:1767::15c4? ([2603:8080:db00:1767::15c4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f4615a20sm2465942a34.1.2026.09.04.04.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 04:14:39 -0700 (PDT)
Message-ID: <01199740-73d0-45ca-a6ed-5c9d0179ce3e@kernel.dk>
Date: Fri, 4 Sep 2026 05:14:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 7.3
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <apnhXnr8bFqNl-o6@kbusch-mbp> <apnk9Uoj1X3PKM-k@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <apnk9Uoj1X3PKM-k@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_041441_741736_7D5C5B65 
X-CRM114-Status: GOOD (  15.30  )
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

On 9/3/26 3:21 PM, Keith Busch wrote:
> Terribly sorry, the previous message was from a stale tree with the
> wrong SHAs. This is the intended pull request:
> 
> The following changes since commit 326d49039c10b65522ac7277b19b9b5c42ed1aeb:
> 
>   nbd: add pre_defined_connections module parameter for pre-created devices (2026-08-15 20:01:20 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-7.3-2026-09-03
> 
> for you to fetch changes up to fd9beb8870736e1c6a0b2351d88a161aaeb2b326:
> 
>   nvme-tcp.h: drop kernel-doc comments, fix a few descriptions (2026-09-03 14:15:11 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 7.3
> 
>  - Harden the tcp host and target against malformed PDUs: reject C2HData
>    for a non-read command, bound an over-long PDU before copying it, and
>    reject unsolicited H2CData (Yehyeong, Shivam)
>  - Fix circular locking on TLS queues (Xixin)
>  - Fix a soft lockup when scanning sparse namespace ID space (Mohamed)
>  - Fix racy access to the FDP placement id array (Kanchan)
>  - RDMA host and target fixes for a double cleanup on the queue_rq
>    error path and a queue leak when the connect backlog is exceeded
>    (Xixin)
>  - Authentication fixes: drain the target's expiry work before the SQ
>    is freed, and release the DH-CHAP secret when parsing fails (Kazuki,
>    Xu Rao)
>  - Fix nvme-fc options double free when nvme_add_ctrl() fails (Niklas)
>  - Add missing SRCU grace period to nvme_alloc_ns() error path (Tristan)
>  - Skip zoned limits update when the zone info query failed (Chao)
>  - Reject enabling a target namespace with no device path (Seokgyu)
>  - Add opcode filtering for fault injection (Mohamed)
>  - Drop the kernel-doc comments from nvme-tcp.h (Randy)

Pulled, thanks.

-- 
Jens Axboe


