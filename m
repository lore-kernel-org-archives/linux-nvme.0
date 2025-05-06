Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF97C3ABBE
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 17:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nwZo3vS66EatPpWKcNBFiFt6i1hah0QeRGJTjdHslY4=; b=SQjgP+DmjULCnSvB/duGoiy7E3
	hYA/RV9A692tjMQ6kQ1oVqKZm4ftEt8a9ovnvipOo6rNKui/vtDELw6Uqtjl7S50PS8/HpTfxB9GB
	dwDANqGI3dda14mxxvI4cwXH/N7iy/1URd3fT4RR3hVHBuA3ZFjATvrs79yBcQw8KH3eDjqUpkMgB
	D68Og/MKUacl+fajc7WeGzUC8I0c8Re2UPXo843ne4lzvXv+8qBPaI+yLcfbpQO2EZFWwLCaW/t1l
	8EggvM0etgP8FGoZp6CUUTq3BerViqanw56fX0yOywLQx2cyX1ioFIQL1iFuUoofkOn3B6rhLgF44
	xw9Lkh9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCML2-0000000CsyM-2aXh;
	Tue, 06 May 2025 17:44:16 +0000
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIev-0000000CCBy-0hLU
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 13:48:37 +0000
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3d96d16b375so29768355ab.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746539311; x=1747144111; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwZo3vS66EatPpWKcNBFiFt6i1hah0QeRGJTjdHslY4=;
        b=eFKc03yS+NF7KnxgOfBZo9g7wxWSAdE8CQn72DdQW3+/t1Mifq0aPGczHtMOCInbJl
         cWP1HzU87fvuwFhYJqLU7ivgLEpsG31WZpr9Y7OZOvHZoVZ8+V8Zu/bN5VSQ+SQeBvMB
         WgSylDf2qorUSKC2nJIUBQTSxo5M0RCkCzbNkg1zgE5xkNEEwbObjOoBLuB9AJnTLR9q
         sV2B3MO6HItoBh+NlMhWQcZFXxXc9zL8MuIou8d5CyhCRFVv5R06gI89EjYhnBCiT1IJ
         jl5Dq1yCcPk3HrRtyrSYRlZYNtm11oEBoMQyGjO4E30D05IDitvT1wgcudmFeoN5QkVQ
         KdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746539311; x=1747144111;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwZo3vS66EatPpWKcNBFiFt6i1hah0QeRGJTjdHslY4=;
        b=L5ydW+4Guvp3IHGUOwtubujrYXzW8wUCz3pdO7YVKY399i3NoZi6MC/tBB4sTp96u5
         C+Kq8S7WewUnpM4U/pWd2qvogP1ukLANGmL2XSFSCOAkokhcUV1sQcpA/YSbusXHy3L6
         5a02CU6FFQ4L35dO9CgdXJt3m1zZYAGn8n+nxAC7rPA2C+MdAyfrsvCsFdCkj05R90ed
         BVID11+hqIbeib04B/rsTjX+akghrjCValgSBYUxtnzl5r75SF9tpmGjppalHLFqKqAu
         NM9bXJG2v/b3mlTgnGR51UxepgvyjBZHCOLJyQsOuDsSvhekjSuuh7vGR8M2PEXqtzGF
         UsrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcnQMccBp3sGzfgfwBLcyPg9VJrXgICOefOyF2bEqcXYioQP6GGepBul9WTQxQ+/TjSTc/xzle8nwe@lists.infradead.org
X-Gm-Message-State: AOJu0YxjFvPcco++RNRW5bs5vI0aiRfUbIhL6XtrXD9RJABH0Qnq7hWj
	FCVzcoxwBxrcQUCrSfuv9kxNmUYTo8QgesKSka6QTOjdmPdhhENyD4IUO6X7kpc=
X-Gm-Gg: ASbGncvSsZgrj9+QZEEypDDoHaiUEsBUyiMdwGd6Ch9yba1mxQoQU7/yRL/dpB0wrws
	1rLXoUbIPHnFhLFLso47rn04/Obm4K49UXYOt+dLA7IlmYVdnS5BmTnxbcP2OrgN1KwIbd7H0Ip
	BqKGGvMDklc32EI+XDhtVwZZ/qD7SaatZOxo2jtn49APnbFd4gyLnsYFvWgQMncMxegqIu4QR4B
	0lcYAAC/SYiJrvFW98e5WIkeOC2Iq3vXll/p6IoO/xvEmsTor6xhZTazXm5TyC6ZFYpbwly4q8j
	KsOYx0KhzDlRRlg57fX3nroH0A3KOjY=
X-Google-Smtp-Source: AGHT+IG7WE7HRobsTLuIHeNzb6EgLlDBqw2C/DFW2yv8E33HAfisJnBRcMgTyQ4uXgsmnCPMeMlQDQ==
X-Received: by 2002:a05:6e02:1fe6:b0:3d4:6ff4:261e with SMTP id e9e14a558f8ab-3da6cd50eb1mr34812345ab.0.1746539311539;
        Tue, 06 May 2025 06:48:31 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975f58be3sm25930915ab.58.2025.05.06.06.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:48:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: kbusch@kernel.org, hch@lst.de, asml.silence@gmail.com, 
 Kanchan Joshi <joshi.k@samsung.com>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20250506121732.8211-1-joshi.k@samsung.com>
References: <CGME20250506122633epcas5p21d2c989313f38dea82162fff7b9856e7@epcas5p2.samsung.com>
 <20250506121732.8211-1-joshi.k@samsung.com>
Subject: Re: [PATCH v16 00/11] Block write streams with nvme fdp
Message-Id: <174653931017.1466231.2831663960512265480.b4-ty@kernel.dk>
Date: Tue, 06 May 2025 07:48:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_064833_208620_F8F4197F 
X-CRM114-Status: UNSURE (   8.50  )
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


On Tue, 06 May 2025 17:47:21 +0530, Kanchan Joshi wrote:
> The series enables FDP support for block IO.
> The patches
> - Add ki_write_stream in kiocb (patch 1), and bi_write_stream in bio (patch 2).
> - Introduce two new queue limits - max_write_streams and
>   write_stream_granularity (patch 3, 4)
> - Pass write stream (either from kiocb, or from inode write hints)
>   for block device (patch 5)
> - Per I/O write stream interface in io_uring (patch 6)
> - Register nvme fdp via write stream queue limits (patch 10, 11)
> 
> [...]

Applied, thanks!

[01/11] fs: add a write stream field to the kiocb
        commit: 732f25a2895a8c1c54fb56544f0b1e23770ef4d7
[02/11] block: add a bi_write_stream field
        commit: 5006f85ea23ea0bda9a8e31fdda126f4fca48f20
[03/11] block: introduce max_write_streams queue limit
        commit: d2f526ba27d29c442542f7c5df0a86ef0b576716
[04/11] block: introduce a write_stream_granularity queue limit
        commit: c23acfac10786ac5062a0615e23e68b913ac8da0
[05/11] block: expose write streams for block device nodes
        commit: c27683da6406031d47a65b344d04a40736490d95
[06/11] io_uring: enable per-io write streams
        commit: 02040353f4fedb823f011f27962325f328d0689f
[07/11] nvme: add a nvme_get_log_lsi helper
        commit: d4f8359eaecf0f8b0a9f631e6652b60ae61f3016
[08/11] nvme: pass a void pointer to nvme_get/set_features for the result
        commit: 7a044d34b1e21fc4e04d4e48dae1dc3795621570
[09/11] nvme: add FDP definitions
        commit: ee203d3d86113559b77b1723e0d10909ebbd66ad
[10/11] nvme: register fdp parameters with the block layer
        commit: 30b5f20bb2ddab013035399e5c7e6577da49320a
[11/11] nvme: use fdp streams if write stream is provided
        commit: 38e8397dde6338c76593ddb17ccf3118fc3f5203

Best regards,
-- 
Jens Axboe




