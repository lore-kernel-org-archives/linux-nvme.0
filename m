Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E88C77B7C
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Apr 2023 21:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ly78T6XL/qN2ig9JJ0aLlFTyVd0uh9cdGf4RqlrNODs=; b=g9CgDTyiNHu3qHXVMMdknSS/tv
	jrnwZP3oAllTZU3hGby75+OYcSxDcKNiCOOztRlYLHLMnsJYFcZGTv/+Ss9tTdqfrbZ12+CbC3dxg
	BqD9dCExHWbI8Z5y+1TwVQhUKu/jhZSbhmFbXj62YX0XafADH0xTsdChTWQfxhQsuojvt/f/9XjsW
	e0rNFxU35opJunwynZmaMSR98hXOp5TmG9XhHO2ykR3jUWMOQQcZrb2BXdOgmBKSbgSw4sXpSm+7e
	QqF7sMzbe0rBfDIIRZP+mogwXCwKPI4xEadFZkRnq67qxzbtUgKr0CtbLt+2DPjRN19k7uSPwt3n5
	1aezgU/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prQ4V-002ESc-0o;
	Tue, 25 Apr 2023 21:19:35 +0000
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prQ4T-002ERf-0y
	for linux-nvme@lists.infradead.org;
	Tue, 25 Apr 2023 21:19:34 +0000
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-38ded2d8bcaso3619303b6e.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Apr 2023 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682457570; x=1685049570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ly78T6XL/qN2ig9JJ0aLlFTyVd0uh9cdGf4RqlrNODs=;
        b=ZM7RDD3z95b9ZlzRUSarP0S1D9LGojSmXqflKaKHH/QlMMK9FDDjEUWyXieUbSMX5J
         K7oA9K3tS1LnNkI2m9tAmzFLZdNDAPZTYbxABHHLaOTwglqOCbK0IU4FSB1W8dB8hAXP
         G6sBE/avutXhjpPbMM2eaRtJnhGtqR81nfY19IARng1poeGUX3zAmSpNkhtUDb7GOxkr
         sq3z04gMWlPzx1xtU3H1a1F5HkrO4ri9oI825Fmy7pcGuOcnhjGeQHJO/tfhdQfArIpY
         4FooutLuZOuLfLJuGEUU6ahXRQN1+hDAXTijvR6pBivynW9rB2q7MAy76UPlm53qKsBI
         wFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682457570; x=1685049570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ly78T6XL/qN2ig9JJ0aLlFTyVd0uh9cdGf4RqlrNODs=;
        b=IcXkURjrjHAX6zWpHwaN4mQiG8Kf09ZvJCx88+GLhIS8/MycIvskdwkkUahlTf6+U+
         q03X/DiChvLISP9qyaJ51KqDyg2TkCO8RQWSFFKZzf+cLU9b9uyy2t4+d4UJJazrlgc7
         aXTEa9nNZqAFdNNmj7+X5zNxzY0iNN5h7hjZLw25IjfLNuNNBBzW2Mp7Tyl4qqB0iQC9
         tfX9tVtFtPi8vS2HiLAKtFry1c1336YQ3EFHYCqPbHz/p3wt+Bw7ZRQb8pi3IEKEm66t
         dSA4AOk3Ylj6igVT1+y6aj4qAy6+mBaWfS8XHTsmmrXsq4Cpx0Qab2b/Wae/u0lt4Pqr
         oYmg==
X-Gm-Message-State: AAQBX9dwTzMG08ZPz/T5KpWmmXb3aRR33G+pXcyOa5PXnHRD5XKqVoUZ
	PTkFUyx5+ueuHzkBoDOqB9o=
X-Google-Smtp-Source: AKy350asTKjf8TRAi/s2WFcsZLDHjLQ7RlZPBaaUz5FWZ760+mbobVB/PlABGJojFkagGWfZ6dPjDw==
X-Received: by 2002:a05:6808:2a81:b0:38e:19f2:7041 with SMTP id fc1-20020a0568082a8100b0038e19f27041mr7809899oib.1.1682457570197;
        Tue, 25 Apr 2023 14:19:30 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.195.153.187])
        by smtp.gmail.com with ESMTPSA id u2-20020a05687036c200b00177c314a358sm5945357oak.22.2023.04.25.14.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 14:19:29 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH 2/3] nvme-pci: Adjusting ctrl deref count
Date: Tue, 25 Apr 2023 18:18:35 -0300
Message-Id: <20230425211836.14283-3-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425211836.14283-1-irvincoteg@gmail.com>
References: <20230425211836.14283-1-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_141933_342531_5A76B1F4 
X-CRM114-Status: GOOD (  11.40  )
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

If there is a failure in nvme_init_ctrl
the dereference counting is not properly
handled and the code exits with a non-zero
ctrl ref-count. This is because nvme_init_ctrl
takes two refs but only accounts for one deref
in its teardown path. Instead of adding another deref
there in the core layer, we take care of it here and
we make sure that it is the last thing we do so that
all teardown logic executes before the release of
the controller as the two have some identical instructions.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cd7873de3121..65e4b9f1b632 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2975,6 +2975,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	kfree(dev->queues);
 out_free_dev:
 	kfree(dev);
+	nvme_put_ctrl(&dev->ctrl);
 	return ERR_PTR(ret);
 }
 
-- 
2.39.2


