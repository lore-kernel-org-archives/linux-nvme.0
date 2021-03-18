Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1349FC433E9
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 13:09:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C121964EED
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 13:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C121964EED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cCJfz88z4b0Tf4kfqHd3fMlqm0D7npZDJ+3YSGKVSHI=; b=X12I7V5atgx8CXRBLTx5o7DYm
	/rljCFc1CLD/NaITlbOjakgVjs9y8Y1XSJoGEM0/AQ+jCCaBbRKfWQORySamMibgNlUPrj+75Ykwh
	Ys/WjZ+h+dMuoI9L2K2y5DovX6/nQv/vGpENsiaR5feVvgtXU2HuHWlvynPLwdI3+FNFKc5JwgcJB
	ep9raJyuMH2Fb8XanAOlfo9s/Jb314FqcnMFRPOhik63DUNVR6nKa78WCs80z4suhD4QsDwVwd3G6
	gtOh/nokFdRz7OYwBLTKOi07r/WouNE6U+357jVKEv2tx/dBqJKeirwJWXFygCqM3gfKGQToKubPQ
	mIvyGXc6Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMsP9-005K6J-9Q; Thu, 18 Mar 2021 13:09:35 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMsNt-005JYl-FY
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 13:08:23 +0000
Received: by mail-pg1-x533.google.com with SMTP id u19so1394568pgh.10
 for <linux-nvme@lists.infradead.org>; Thu, 18 Mar 2021 06:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y2o9ANfuMs3TrmcdxsV7oOkUp5tOtdtkkLZgkfIPJPc=;
 b=EO6/my8kQyqe4dQPPixFhiW7qY0CVU1s281nLJ0q86tRmwwpqJup47xLMFEuOINOpo
 bLr3jeU7UMgV1WxMXyLECzRGQhIAfWAPyXQCwCTSeyDYT7XhuowoNzrOT7JOVSXAmHni
 Ow7MI7eEciLJ0WUsAeuSVb2pexVXCaz4fVERTuPmLexCF8jTV+cD3kQ5o8nKmd9zC0qy
 4z3A1Q+K0Pvtlfp9vvM1rB2I2QR1IZ9K6LYJa8cJCBmhJsZE+JoT9dOLmij5axQv4A1A
 VW8SZdQa4p+5iW+YqRtgZNSC7mHnQLOWjNgaGwCK8y+UUHu6U02/fV76Ydfwej/MpNCn
 rCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y2o9ANfuMs3TrmcdxsV7oOkUp5tOtdtkkLZgkfIPJPc=;
 b=Mc4I2RGEHNeD7FL89ytT1so+/ewpXVFW4oOU06vCm9TaLRSQl/qNMBloLRe6gXP29g
 kIDsAjHYe4+4lLcIeKMQgHYlayngJQIXXxhgKJLlHB5Zzf36sTZatY0xQmoiZLNJLU+V
 AVv24gIG0JcuDizMSullXKapTypZ0MzXFh9YgN+gyByFRSVlMTXtJXLf7OuhgGXFOwez
 MJ78ZXMNkKL9mpVdiNLfvooW2FlQgg+B+7HrrUghNezJTdXIl12VTTtDqvqStpihnxJM
 c9BEdeQ698Q6TbEqMoNTUy/ZzLWSi0ppizxtEC6qKi/CvURjpbTdhkVZxJJsnyqCnNXq
 yH2Q==
X-Gm-Message-State: AOAM533aRKWuMdo17ooBUNf8w3LNItKrmLdFLDCHb6erjIO1A58J/4LP
 5PngJ0ppEC1vAxHLuSIpnYU=
X-Google-Smtp-Source: ABdhPJyQpcAGLloxv8bLNLjgkn6aL4/vPxNrjzpk5jlzXx+TGP4/vRQ+U8wlRaOAsdFuF3nib6SUnw==
X-Received: by 2002:a62:3706:0:b029:211:3d70:a55a with SMTP id
 e6-20020a6237060000b02902113d70a55amr1428475pfa.16.1616072896132; 
 Thu, 18 Mar 2021 06:08:16 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id z27sm2433106pff.111.2021.03.18.06.08.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Mar 2021 06:08:15 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: elad.grupi@dell.com
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	houpu.main@gmail.com
Subject: RE: [PATCH] nvmet-tcp: fix a segmentation fault during io parsing
 error
Date: Thu, 18 Mar 2021 21:08:04 +0800
Message-Id: <20210318130804.78329-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210318082834.16093-1-elad.grupi@dell.com>
References: <20210318082834.16093-1-elad.grupi@dell.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_130818_677016_7AF182A2 
X-CRM114-Status: UNSURE (   6.93  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I would like to verify this fix with latest 5.4 stable and upstream kernel.
Will tell you the result later.

Thanks,
Hou

[...]

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
