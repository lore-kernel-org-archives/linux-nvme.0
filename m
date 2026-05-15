Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7675CCD343F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 09:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UF2qS7mQl6upSPGIjY5JgSOHTtWCmzwimRmhCZdhQLQ=; b=tKK3AoAYY3bJV7io0vDAVAGPqz
	IVIEA7V1m8pGDj+VUDEqPlkfLFBpChataFYew/RVKp48KdIFzH4zAXjv5fj9OyyOwXaBvROajYKJH
	QIQ6Wj7qqaL1SENGsnNhu/TYhci+4p9pSGvZcuQtBjuf+K9NvhwNp07iaTx5glU8w9Eph4VMNpKEI
	34o2DkGdswoyhF/cofxyhvzCa/F318IHP0WnpPQJUy/Rgr2/NlPIo1lTN/+r0FajHb610V9/7mYL1
	t81q5tF7rXnOrJZQtAH2uJqY9z52v9KTgeAjUyQP8JcZpKNWegXCaNLxz6Sr3s3vyhnnYF6/+WB9L
	/7D+f/CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNotr-00000007tio-3uqB;
	Fri, 15 May 2026 09:32:07 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNotp-00000007tiL-2Rsi
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 09:32:06 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-67e9e343b22so11678656a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 15 May 2026 02:32:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778837524; cv=none;
        d=google.com; s=arc-20240605;
        b=FHu3bpLD06/ExN11nYtTWOWJaGYMy0haJn3utuoRQLhymATZJJaFZ5VVL21+rspHcn
         xwKiTo5uPRGsf2TUBdyQpWJbPNAtpea1mIjGS3TLQAh8aDKUyUXVvOVnMdeRJkSwcTfP
         4fOj82EdWygX+6Gk9BErNfu+P0g4T4QZzYst9M55qtRe0fSF2IoogV/JM2dudYImPwv3
         RGl48E/5YMrC0vUkTWou0/mCdyudS0xjOl5eDmihPCDimAbyMlAEfWnDEKzA3H3Q9Eo8
         iPB1+XtVZjLq+y5811B/QUhUWk0DekQEQ5VjoaH1FO/esJgIZQjwiayFvQA/SuCJHgCS
         2yQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UF2qS7mQl6upSPGIjY5JgSOHTtWCmzwimRmhCZdhQLQ=;
        fh=KuNUakIxEcD/tkhOUt5zQKPJK4c/UNPGjTQQg3xYlvo=;
        b=GS0h40SPSJNz8EmjzYGuxHsz7A8ig+IfAkeQlUrtCWT05w9mqFEIb8UTlZEGx4/vTK
         PC4/H240CHZXVt/77RDrBQSjmyypkXD3PgyuDUI2t01R9k/fgKh1G+3Gc6giRXKooDWz
         P6v3qRWsKU9VH4mHPccKARF+cEvjSpqZH9paYDL+DjPUGAnyTGmGcbESeFBFKjFwczR1
         NkG2pv0F5EoPAEJGYQ4uQBSbXJksXwjJ/deMCGMUt6myi7Ln/RL70QPIcCijRrG84x5m
         M+QIchrudne5tlpiPi9E5RtkR462vT36pjHA2M+UtZg+wUiApn9uWGkhI8v5NjVb7Euo
         CosA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778837524; x=1779442324; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UF2qS7mQl6upSPGIjY5JgSOHTtWCmzwimRmhCZdhQLQ=;
        b=i3Cyo+YCIj+GhoSvvW/WPqaQ+V/kZzD79ru2JmN+Tr1EdxSmHDcNLKgoDQVaJ3DFOP
         fgOprHDMfOv3j2nqYvk9vXmNGPkUWpDpH1dmQNXyFSQ6lbjRLhO27aMUjrtYs2OKfF3X
         PBMqCFRMJzBzrUFl6GoFIfCtUj7kjem0Lb0DBYyNCNIKx0+2rF3K8/7p3JsT3E5EFs7g
         B5349QK2lrtAAB2U/sSFMTqX20Nhg1m8URJnjN5Qx3yXIy730MPPseXeu0cWifa67mdJ
         6l7sA6xQZrK/OvTWh66Bz4d+Hm5ds7AxKBoramej0QFPYw5yFgmx5a2iFFc7/iz8Pcjt
         7JAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837524; x=1779442324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UF2qS7mQl6upSPGIjY5JgSOHTtWCmzwimRmhCZdhQLQ=;
        b=hTv4wGfed6TBH/IXwz3Zy5mWfzHp/gOXy0gX93Sw+/SefngktCimOd7iKFHv1N6ZoA
         /ZvCH1YV8XoyDzbFuh6pfz1Yf7/faFlyVluDYD1lZ5REKC3+yAKWcye0mMCD0sB9Fodj
         xhEge1YnLGkWWmej2RHWZqYCKPskx77eRflvR5XqAnpEKNVrmwJ5ocAFnBzn2ppz/c/o
         9xGftX3wFql5ROi9Ek5QkxFb4GHgVtalU1LF139VWzUUBsd+vmCo5PQnhSwzY4sQCKgY
         +A7vXsYRcqLeuv4dinVDBD1fxBugJGDXHfjHDcW1ZR5hglQlvebfcIRiV0fcIaAHrRzx
         gpUA==
X-Forwarded-Encrypted: i=1; AFNElJ+oh/AsDYeMVcif8/aB2GdExVoMPNa8nTEPaeuMs//3z0o3iBj4+2VfRk0gf3jV8LTtSBekn5UX1Tq9@lists.infradead.org
X-Gm-Message-State: AOJu0YzpxXONMyuLxjwjogpGi5oRAbcX/uT7lDMxVyp6eZ/myt1muNlo
	UCl96Ohv+BfqRGOp314F5iaZlW/rGlzYjryPEYblS8GCSK0C6FdsImh7Wh+GZpT9dAfSzu4M6Ho
	YX4LdZ8bMHIuh8CSKNEJse8dH7lVib7U=
X-Gm-Gg: Acq92OFjQYOELXYTbKa5VoXmg6lnKMcKM41q1wwKe3JH52z3rTm/naH7Tt/gnLvXvj1
	nemud0MwWzfQllQtLOUC1PQMamgWmJfc5zrWS7YPRslDLwitW3unxB+oXXeSRcJgUZVqj0RCz+y
	iIZJNjwFF5qfhDO8RY4eaVHXKO7icHDkFFfdaQ05idpUrQ/XbWj1ineiQsjlH63x5hOS3F3tdIZ
	fxOov2lgM3degy2KfnWh0P+N/qmOoOGdcWep+lpajKjh1HCfW5jYEKpihUXejnRhwvDMTUQK6l4
	ewNj+L5H
X-Received: by 2002:a17:907:960d:b0:bd3:2385:ee0b with SMTP id
 a640c23a62f3a-bd5177d4699mr171732266b.9.1778837523295; Fri, 15 May 2026
 02:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260418042835.420281-1-coshi036@gmail.com> <cb2c00e2-ba72-4d6d-b17f-ef5ae3b0633e@flourine.local>
In-Reply-To: <cb2c00e2-ba72-4d6d-b17f-ef5ae3b0633e@flourine.local>
From: Chao S <coshi036@gmail.com>
Date: Fri, 15 May 2026 05:31:50 -0400
X-Gm-Features: AVHnY4LvDsynoCBxPnHO6DxiWk0qBku6GN95ERBIBtFvs3Iay-LLmMnQNs3oxbg
Message-ID: <CACd_6n1ed0254wREakkNxLvOAM+iDkT5P9NO4-RFsGv87QyrSQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: core: reject invalid LBA data size from Identify Namespace
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, 
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_023205_649424_B97868A2 
X-CRM114-Status: GOOD (  12.13  )
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

Hi Daniel,

Thanks for the catch on the Fixes tag.

> This fixes tag is wrong. The above commit doesn't touch the code
> line in question.
> Probably a5b1cd61820e ("nvme: move a few things out of
> nvme_update_disk_info") is the better choice here.

Keith subsequently pointed out that ds has never been validated
upstream, so no single commit introduced a regression to fix.  I
dropped the Fixes tag entirely in v2 (and v3 keeps it dropped).

Thanks,
Chao

On Mon, Apr 20, 2026 at 8:22=E2=80=AFAM Daniel Wagner <dwagner@suse.de> wro=
te:
>
> On Sat, Apr 18, 2026 at 12:28:34AM -0400, Chao Shi wrote:
> > Fixes: 9419e71b8d67 ("nvme: move ns id info to struct nvme_ns_head")
>
> This fixes tag is wrong. The above commit doesn't touch the code line
> in question.
>
> Probably a5b1cd61820e ("nvme: move a few things out of
> nvme_update_disk_info") is the better choice here.

