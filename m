Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D49CC55ABE
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 14:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=; b=g+j8hrc5vH7Ec05IUrcpZv84Xr
	3DcyUqH4Z819JoiBXtvzxNtCjs9B9XNpR/IMwnzA6/TPM0OiOEsULV8wIIT6m3YYgE4WfdqqqfmOt
	vYpUnFi4jJPBeUcvTAGO31aUFahIikLFS1wm8CeYLi3g780yNmKhSgNyHV8yGndANBziX/TmJX8vG
	yjaaAhusMzBgmONltMdocY0EWGrbZmsyz2OgzdybSVgz9NIsj2CHjElxOOIOiZu5lBxH+X4sIWAfe
	CQQA/g0/y3XrJqhm9QlgNTCWSd7R7xKqou/hmwl4//2j3hH6jE0Jgtp43Zd14QY3ap35s0iWAtobv
	hWGEmkUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtR45-0000000EfjE-19LV;
	Fri, 20 Feb 2026 14:01:05 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtR43-0000000EfiT-0Jao
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 14:01:04 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-b8871718b00so341096566b.3
        for <linux-nvme@lists.infradead.org>; Fri, 20 Feb 2026 06:01:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771596061; cv=none;
        d=google.com; s=arc-20240605;
        b=Kud9pC67XpOfiGIQbV4JGnVTqTGXd4KcpEDGFN5pocmLdKbG9Mkntud1J6oUDLpHWG
         Z3bJxnDCnQqhWsnyUWpLobR4pVvIDi9dTsss7kS+MUTWICN6jR+unOVuOb2FSThWzy2m
         O75lzu6bVM2j+Q+XacA8LPmPZWQk6RG0iCOcqrGXQ7rYjr1CfqkfEpLMgj99Krv9uysW
         ITWvpf83jCRpEGyTmkFRoDXRR1nG9bYgQqbIaHaqSL04Q6tqbtHiDy10Cad30B1mO8rg
         vdNnWmmoG34DipxlSy9tsKAqJk/TWf1GsBZk9Ur6aaZNQnNQNfnuGvLzT3UmIbgJ8rYu
         BcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=grtWhA6ep5JZFylxdppWe+wlhVueeiBwFfuRMZQ5W98=;
        b=AjmHHOBAFMn/Y8AB4BR7bXpDiWnXm1dKxD1+opkwoBZ4skklsjtVIKxTOiZ+mecpNC
         ZQAaKPjUliZfqAZFSWxzSIYUdukPggkM3m5MWvZ/+i6YETp0Fx3LQaix4aC5xTiqfhr5
         WS/zF9fcpWWTKBGhbUBqzqwKqCnY1mN+TZ9eZXCeUfp3dYoBw3jLmiy4TOgrbetDsQDD
         RHvXfVFmRn9mKTJQbT9oLj2T755z2p9YMcbQLOg47FQ0LpP0gqSCPh1vt+uWdlQWCGdJ
         xebC3VIe1rd/GZcX/n8VPwxkFLcyjtDCSmJ4LfrgUbzPFPadSDAfDr0Jagqh/RASasPM
         3tAQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771596061; x=1772200861; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=nG4nnYHKTJS+Bt8K3RD8/a8/j8ZqFrjg34n8VMY9Kq4HqDDOCN4PsgQxFamEfl5Joh
         paz+0v0TPdE4yFLqK39rW3mii4/McRVg2eMo/gG5JCCvbv4XT71Z1U+R32dJ7oKW9x0U
         2Rce10RdsjylvNfiXw2jLQZMS67UJBhAjAqaHe1rBdkj/tiigu7l1Wu7wtsG8kNgmw8G
         a7wCjj9JxKlhtNtF0FWRpF5AXYnHWsr78raLkfKlC9a6BdEh8Tw0p4wSELD4SHOj3qjj
         Q9WbQ+EwZBZhyK5Tn9y65HzQqkKqm7LMxcbS5srFVh742QZPdEI3INFn/zbbIZWjjC4J
         2ihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771596061; x=1772200861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=vFkuQVvDKGnWZHkrjYawjSxncCUOm/kmfCyz64dLbDdjN5vdZEw6HHGtYN7gItkPG3
         lZvIxUuw1C4gz8MuNnYrz4ZGTUzAwbQ1qYJcIkZ3TOkJsyFyVdHpoHy3XFhctXOuIduh
         YbXLAR/nOmFXwExcab/Qi4e8r6NYgckKMpidFcPcqj/bzr983TBPiHWPFg5c+v4NzN6h
         YJghRXs7/qZhfjUaWQ8ppJPHPdBxEjqGcGL6bnSoAsO6zpfByHxfLEUMeN4UvqwRlIJU
         YdOD+UDf0GkmBhmMDrduVzlCwrDgxEZ4YsjtoBWxaNwovebJysylUCUTgwq08nZ3AAy9
         8ijQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMHWHrM9EwKqXP5TUpFE3O1nETzKq1RN680wApIAwsFe9DSQeNCSLqIrcfI8XeHeeIV1qoX+a3vfIP@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4wgB9CN6i4N2muxNxPQcyZ7RsHTVpyTjYa8nJJ9e5NUh0ZZGl
	TZUiPpg02UD7JHbMa6CeBf/x3c0w/Y7X3a8zVXOleOLwwpTlobCDHqPp5lkuicuGnviI7wNLhw7
	t/Jpmk0FyPz9zs+hlOMOfchGX/LEZww==
X-Gm-Gg: AZuq6aK4lrSQl5vkDgRWNMUsX5v+MuHbjRgMwyoqV2LBsE53j6C7YIeCBmxd1oaGAJf
	QvhHF6Mn65lzxpkuoz016m3LYM4dacz8ff6QXSqiEpfTMfQx5J7RiRsJU/z/9mI+NvKBIXB0pI7
	8/XibNLmCxxhSxIWnMGQ8e/yMB2D7Y3/za1rPThZLHLdx0VK9BV1z0+ccEXLWscAFZhkp5KA91D
	nVVvLdClneW9fhlzeDAM+7sa9Nu8e5dLSkZT3P8Hg+9OSxM2y3KdEJ4ILLMSwVpU6XKBgwlNtBn
	KyiJhhDLNazIltVe5vZenZ3vR/H+70FUlxOv6Im5hL6hXeObz2CtbW0tHK4R4alwvgVlBg==
X-Received: by 2002:a17:906:2083:b0:b90:771b:ceb7 with SMTP id
 a640c23a62f3a-b90771bd354mr75534866b.27.1771596060364; Fri, 20 Feb 2026
 06:01:00 -0800 (PST)
MIME-Version: 1.0
References: <20260219172228.429479-1-csander@purestorage.com>
In-Reply-To: <20260219172228.429479-1-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 20 Feb 2026 19:30:23 +0530
X-Gm-Features: AaiRm52mvs-aOVGGrqp8lgGC97YH_yfaGgyVC_GHRYK1kiT8xDbzNAyi-S50V3g
Message-ID: <CACzX3AuPPOZdidqoDE0TvPChEXcNpKRFGgX6FZskOnr6f=eXuQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_060103_142907_6290345A 
X-CRM114-Status: UNSURE (   7.71  )
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

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

