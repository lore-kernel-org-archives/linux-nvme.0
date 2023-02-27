Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EC9C64ED6
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Feb 2023 16:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MbLJSnheR9X4hWEVD6Ap92AKiWgtCko6X7SCs5AOr+A=; b=M9QW1pNn+4/4s0MOU1cwpWtLXt
	wGU5Uc7sZsSBi+7mHNRM/JeB9c9q9AwH2IE5b2+B9qmyrNnoKcVtudwWmUxOvG/vsW5Rm5aMU3rKb
	I5q4QizopNXpw87/vTlksoG5h3L7R2r4yU7IRleulgU6+Ye3f1graG8je94HqqQfG8Zng9XnMzBK+
	O/6S2gcFD+eDmZdbr7oQ32jFWu9bYVMovE6vdO6iMRqZtf3QauPX22EgqP+22YQ53C8rY8O3Lhcv3
	wIj9hSv3YMbL3XkHitgE6eY7YifXlms7I8Mocw4Up02PLLlhFLN+cxzkLqRw+4BZa5bLR0tRHyIEu
	7dnZyDjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWg2P-00AIzI-7p; Mon, 27 Feb 2023 16:07:41 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWg2M-00AIyi-KQ
	for linux-nvme@lists.infradead.org; Mon, 27 Feb 2023 16:07:39 +0000
Received: by mail-pj1-x1033.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so10621868pjb.1
        for <linux-nvme@lists.infradead.org>; Mon, 27 Feb 2023 08:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MbLJSnheR9X4hWEVD6Ap92AKiWgtCko6X7SCs5AOr+A=;
        b=P+2xDc36bW1/uK/tBio0WOi16W76i/UfL2+UA6WPHuf6R0YdCZza++iDQ7Igis1MQ1
         zmPhDXpeE4McfQ+FvdjlEgQsb1l12wEmASs519pdy2hpANHJnGjrBGBRg9BBsrtQT2gf
         YZOmPsnR9hVIJAyBlPzbSZl3a14j8Pu8f0CxZN8KrA3YaeiGo9tvjZ1OVtAgl1kdbfqg
         p49Olb3novCApvhwRV4enIvbEAMdCY0UsTP6muwJk58Yi5MIDqMG98fAKl25nEiFEwm+
         +TPiYcSFkZCVgf4cx/mYJN9XZ+IbKGCvvbRqbbdBa5E4ioXfU0FPzMFw4V8oGY9vjT8D
         kO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbLJSnheR9X4hWEVD6Ap92AKiWgtCko6X7SCs5AOr+A=;
        b=uCSUZORZHlzPvcFg2ffT9JnxRyupIaCQ2811X+B7Qu9Gw/nRGreBhtY5Te8awZjEWR
         N85ARpR1kyi/AeVnLlnoLohHIeRBmzdDiZbVbReTmAN7H1RzEhORrP5na9WgPxrGykeO
         O5DD7MaD6rdZbnaKa72easzojFiE/oPmWQqCsEFXE2BMpphzdzBGbeuayO/JYOMEVPq7
         KNR0usUM8UJjn+HIj8JxEdwvzVcE3UUWDx94sdzPeR11BRFFyWfOGwjqiMVJmKWV2k5Z
         VKyolysd8xxqOHk4y2i6bPCQQxwGAffA9AmRUAoH9g2hc2YCwCZ2iUui6rvj1D2BNOLI
         xbIw==
X-Gm-Message-State: AO0yUKWevbwERUmV2QYPiqO+w5WEfaF3UE7+PcM9oxfW5s3nJ2GL+t0k
	5ertYLwr683dhvaIJuWETQih0opXcrsiK4/aPzE8s381O19E0Kpw
X-Google-Smtp-Source: AK7set8CRVoakHDcMwXiDe9cfyrY/5ZhV+BcZ7hJhg/P5EJzx7S2NksoJ8aTlh607VjvdOwZ/Yp01F890SjJfsd42WM=
X-Received: by 2002:a17:902:6b43:b0:19c:c2dc:6f38 with SMTP id
 g3-20020a1709026b4300b0019cc2dc6f38mr4640715plt.1.1677514054723; Mon, 27 Feb
 2023 08:07:34 -0800 (PST)
MIME-Version: 1.0
References: <Y/lmo9yfA1w0+Bp2@archlinux>
In-Reply-To: <Y/lmo9yfA1w0+Bp2@archlinux>
From: irvin cote <irvincoteg@gmail.com>
Date: Mon, 27 Feb 2023 13:07:38 -0300
Message-ID: <CALL+9ejc+wPgG6x3CZgqwwU7P-f7mT=5U6RoZGBuiumr+P59Lw@mail.gmail.com>
Subject: Fwd: [PATCH] nvme-pci: fixing memory leak in probe teardown path
To: hch@lst.de
Cc: kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230227_080738_704384_8556ECC5 
X-CRM114-Status: GOOD (  10.08  )
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

---------- Forwarded message ---------
From: Irvin Cote <irvincoteg@gmail.com>
Date: Fri, 24 Feb 2023 at 22:38
Subject: [PATCH] nvme-pci: fixing memory leak in probe teardown path
To: <kbusch@kernel.org>
Cc: <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>


In case the nvme_probe teardown path is triggered the ctrl ref count
does not reach 0 thus creating a memory leak upon failure of nvme_probe

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5b95c94ee40f..0b61caf6be67 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3072,6 +3072,7 @@ static int nvme_probe(struct pci_dev *pdev,
const struct pci_device_id *id)
 out_dev_unmap:
        nvme_dev_unmap(dev);
 out_uninit_ctrl:
+       nvme_put_ctrl(&dev->ctrl);
        nvme_uninit_ctrl(&dev->ctrl);
        return result;
 }
--
2.37.2

