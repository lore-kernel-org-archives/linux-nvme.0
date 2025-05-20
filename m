Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5F0C54E90
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 19:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aNSgnmBffik7BHojAceKoM32139dQCfSwPr8l2pvx1Y=; b=IxiNUaY8+/7isV2/0/V2r2+Zpt
	ZYgWpFBo5M7Ti5IsMf1oV5YV/Oi0uKUQ28smJ6wnDvyADqiGMGNIJ/sgao3m+JeRuJOOf1QQhbPPM
	Q72cXuGE2wu+xc8GVwI7DsR3NT1WisgrQ38DRuK7durXMVr/ZIWZECaEewFVqvn9DqcaA7OV5QfKa
	S1WGOhyw8TG4Ko7E6w6w8ySxcysA04NxusMI4hMMNk9MJNDvC79dzphYC4H8lKAKpHDJfOB+88eXG
	7rgamy3jERJ6wOYrrv3M+RmSQq7bXH5j1tSRArfNlqGwzQZDVSlVP21OJ5BIzlxVWpAutjNtTQh/6
	a21ZoQ1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHSmK-0000000Dwym-0ygO;
	Tue, 20 May 2025 19:37:32 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHSU4-0000000Dudq-108T
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 19:18:41 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-231b7b21535so4237525ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 20 May 2025 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747768719; x=1748373519; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNSgnmBffik7BHojAceKoM32139dQCfSwPr8l2pvx1Y=;
        b=Pl3leLgN+MuFhVa80yVK7xBPfHl743UycFmLoRUbAg+y+j50gqFlkryBcUkSFRyvBw
         p/dv344M6gNzzhlM9WR+IRnQTnk+mWBqXB6/vM/hXW3BBXfQwI6YD7xYWJZbgUw6NKA3
         zetACaVweN+UqeYB6UpKbIOZ9/ISlBCquNaneKB+RuXne8mroYyzbmNQh3WnvUjiMgkz
         YM+Xw45wCf8hvObWqqXWmW/OUuh9e2Rz+uZG3X+aUdeWpRLR0xBeqmC1605CbeLfBroH
         a4msOUrc+0JtX8wZHltOAQKOMzkNSZb7uLqAP9VoG0MPwt7qDVr9ZBLvz778ZkZw3o/o
         F4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747768719; x=1748373519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNSgnmBffik7BHojAceKoM32139dQCfSwPr8l2pvx1Y=;
        b=ZXT0vUOrkllQWzhqs7/RRk+6TcQwJymJiUFJ1pzmHfAGC9xfyDgezJaV5N05pGkxOg
         LIRLYcBUTyam1MaTs1fakN2qs+f4rumf8dv+BYpMvplIiU3NmoOdO2KOn+iRvf/Vj9IW
         Hbxt1oOnAQKT5cORwDChXd15EDdQ63m1BTmgGlwJ0St7/wTSZbe/QaRGUW74Ae8NnKei
         dubKkXO3fa/NPmK80oc3rBZQfYELXDjbai8OxQGzlCQOxeUI0+AnCtfHTnKWsza/IhGE
         A5PFQTgTmyS6V/tCvdOgLLymc+ii/HqFs6mhgo31cJczrF+p+JUskjXktwWv89FqZXHy
         WLpw==
X-Forwarded-Encrypted: i=1; AJvYcCXHJGlo/+5w67hJ8cxTngAKFWi+c3r8n2i1zHtqjySo8by9ulOiiEnRqqfh8b8TWvIY82hrs1ScPMzY@lists.infradead.org
X-Gm-Message-State: AOJu0Yxq8ronTQN/lfzAXy6MplAZzic5URW01uGjjgWJhwLYxWCC5Sw1
	TGWERI2tJ8WkdN6YQpemrhE9PtpCYf7spD+EdXdocwAy4APywZslIuevX30E35RraHivK4/+jby
	Od3h8vllvUrJxVdV7PGscFrBIuxU6rZcLe0NBje5nJQ==
X-Gm-Gg: ASbGncv8/zL8s2XnBZtkxtx2a8V+pm34szolE3yhgo+DU9ADFlreipENCsaHDGDcmYP
	9alIRYDN4YwX1Klcp8u12nwdcF31I6rdHfIWDS1yjHZb3Jr8pO5nar1gHwBewGE3dY2d/+u19c1
	+x8TjpM7vK/uSg6Tuv+8q82W92769fiv8=
X-Google-Smtp-Source: AGHT+IErvSCAp3+7uLokFc1jwKDX3TvH26MQ6slfj7kEIt8uF1vCU4mol5UcIza1Hji7iHOcCc9Li44KKdXxW0sZSGc=
X-Received: by 2002:a17:902:dacc:b0:223:5525:622f with SMTP id
 d9443c01a7336-231d43882f0mr85047155ad.1.1747768719306; Tue, 20 May 2025
 12:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <8c7e05a68a041c5129c4659f574bed6bdc7602f1.1747754487.git.asml.silence@gmail.com>
In-Reply-To: <8c7e05a68a041c5129c4659f574bed6bdc7602f1.1747754487.git.asml.silence@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 20 May 2025 12:18:28 -0700
X-Gm-Features: AX0GCFubDk0vQ3QGKw_v2miMUvy-N6S8WSMf7dXgtxsth_AVpw9vzjS60UvFxhs
Message-ID: <CADUfDZoOVO22Ebdyy4up1eTXFNsd1QtwqbzZwJdkz9CMVr3sCg@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme: enable vectored registered bufs for passthrough cmds
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
	Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_121840_302798_C2592F6F 
X-CRM114-Status: GOOD (  10.00  )
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

On Tue, May 20, 2025 at 8:30=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> nvme already supports registered buffers for non-vectored io_uring
> passthrough commands, enable it for the vectored mode as well. It takes
> an iovec, each entry of which should contain a range within the same
> registered buffer specificied in sqe->buf_index.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

