Return-Path: <SRS0=sv4i=OC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33511C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 18:50:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A5361026
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 18:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D7A5361026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4HqeSAudxwJ3BQyxrwY1ABFONGCpMrRBZNUG/ofrvgM=; b=qFoQI3pgu09z1F
	N+vMg/L3YOIfvsmjjYAB4W9VieQrzyWpfhBaNUsAW2y/onBQgiyHLDC56Hk/hz+xuWws61QvDMjmw
	m31cidSsAMWrgjge6Ah93mbghhGyKJu4DElTSbOKJfLLRnFESckoFYvkbIP267VbH6+H0dKC5+77T
	I41aRpEWXbsvL/PoKiXtJsUQG2fWH8gRtG+KwmgVvNGpz5TxiWYrSgp23r0FJ+jJWs6ujJsfsAiGj
	bWwutyV56AmlxxpvQIen5AWys/sOVpJjVdu4WfnsOphNngDS6G8psDnhJ9ufXdUHxNeHhOub0fHWO
	F9Ta96eFRaQDdbVg7jZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPUYd-00GxC6-Ry; Sun, 12 Sep 2021 18:50:27 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPUYb-00GxBO-9k
 for linux-nvme@lists.infradead.org; Sun, 12 Sep 2021 18:50:26 +0000
Received: by mail-wm1-x330.google.com with SMTP id
 m25-20020a7bcb99000000b002e751bcb5dbso5040156wmi.5
 for <linux-nvme@lists.infradead.org>; Sun, 12 Sep 2021 11:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kFHCkvQZ1cHoH8S4xIHrewTLe5e5pOA3+HbcRuywdLk=;
 b=YDk17YyPowQS6Mrfrix2FK3CnFAJie+zU/DvGnJ38L0iwfGBwmhVPvEoUleDNTYzV2
 ZvoeJHcDf4j7kmIslNBjZscfrsJ95cdl//3iyAjYaokiSQ+XTp6TYE6XKGXZBz9pYtKW
 ImT9xdIGrx7YidoYOrb7PtmcgVB2u3X3SOiPEI6W+p2k4xGkUF6l6Fwa+9RJgUPC+V7Q
 +PK66wMaB6NHf15ucStvNrq0NgImkW4+e18H96kFCTHDURh3n5OhTUKpU5pOPXKYrzGE
 QPpyVLjr+qAl2eraTHwkGegwrt36EzXA/09PMN02WDORXFpnmQyUGD6Rf/27e+FKJkiC
 TwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kFHCkvQZ1cHoH8S4xIHrewTLe5e5pOA3+HbcRuywdLk=;
 b=x6sJq+GmzKpVZafFRmkEmBoh7FGXiiE0uwwPcoY4v398FbE10w63mM3RMMkNRJDHi6
 C1QsDn1wLdO+ZqNmQpZqf6Wva7eHlONBRhWqzwKwwibWlbtuwYKZY1pLmkJc69rJgn+1
 Ea23apYkvJCvJw7V8ktXpokwLxkibbptuqquk92uwF9bZXvnxDbmMNNYQWuu9YAPZsxL
 H1FrlfxkEwmqRa+5R16jb/qrGT4BD8UF1mjF258hnCKplVRgzAyNE3SLZEKXZt/VIrDQ
 iqVhUJq+tYgqy5l1OQpPkA5cSOw0kqmEuASMHnh0btIxW0NkYLmiQysY1TJaL9r3qyJN
 kLYg==
X-Gm-Message-State: AOAM530kG+sV6m/CsoD9omkhligcpwsx81sGAzIrBJ7cfGGLQpPRv83Y
 iUZjNoiGdGDi2dMNTekiaKIjN5umIN4=
X-Google-Smtp-Source: ABdhPJyxo/XGg1JPvf35DtZ5kYcgzHVLHRllLy7TljLgL95OY7D8qMAq7ilcKGkwMoEzaAaK+Qdbug==
X-Received: by 2002:a1c:447:: with SMTP id 68mr7613980wme.137.1631472621798;
 Sun, 12 Sep 2021 11:50:21 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id c3sm5464395wrd.34.2021.09.12.11.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Sep 2021 11:50:21 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: RE: [PATCH 0/3] nvme/mpath: fix missed namespaces in ana state update
Date: Sun, 12 Sep 2021 12:49:40 -0600
Message-Id: <20210912184940.13174-1-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210912010731.471859-1-anton@lightbitslabs.com>
References: <20210912010731.471859-1-anton@lightbitslabs.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210912_115025_383070_843C9D36 
X-CRM114-Status: UNSURE (   6.75  )
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

Please, ignore this thread - will resend with correct formatting.

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
