Return-Path: <SRS0=sv4i=OC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJ_ALL_CAPS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA96C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 18:53:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93AA960F25
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 18:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 93AA960F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4HqeSAudxwJ3BQyxrwY1ABFONGCpMrRBZNUG/ofrvgM=; b=E+HP9RgVcLYxJj
	MM459ygXpcl2XA+JDNPvg/aTHcgfLLFFw9qEqD/x9RE8vIqbMnVtoa/iTJuR6sdfJJDisHyog3UmM
	xzF4aeVu/yywFvN3SM1PP3ibjQ3Lbpc3cpmowqsgRP0h53q8W2ZrwToj4W4f7HK0RQEMJ5lBPITtC
	haYkOgvayHMqIp09ze13WKy4ZLotoqWPQ68IhbNEMh8IEBMz99d4brRkBhmaFEwA+gTJfojro/FEk
	fpdxqbq59fmlV9qpQYGmIawDSvINjwNKN7n2khfK4ZudvwDMVqLDdAVdrENmE0I+1DuHrWVMWDl9U
	hlbwAme8NUDZx21tudeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPUb4-00GxT5-Jx; Sun, 12 Sep 2021 18:52:58 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPUb1-00GxSQ-LG
 for linux-nvme@lists.infradead.org; Sun, 12 Sep 2021 18:52:56 +0000
Received: by mail-wr1-x42e.google.com with SMTP id w29so10366269wra.8
 for <linux-nvme@lists.infradead.org>; Sun, 12 Sep 2021 11:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kFHCkvQZ1cHoH8S4xIHrewTLe5e5pOA3+HbcRuywdLk=;
 b=U94f4Dcso0qk1yzL0bXAW2UN6iVi/H8snl75Qs/kUHXF12dkcfU0WYZE/G3svIX1jY
 vNlGzRrPCYgBXgY5sfym8MzJ/Eboj6P8flbCmU8LL9wTaF2ZbuWW5n5Oq58bys2V6mIg
 LPfAbiNuJrKtgIlGzDmk8nHG17I3mamrkDmhf/jpnUjrhR7WHGjsn+Hh3iAj+tNgqgXc
 SfYmaLFYXoS5VNyZLXnqvXHwvCBJsGHhW/E/K13J+upHExqsoxfI2ddz4kmzy7CiPgmo
 2Jno1YX5yfvrLCY7MUBxpcwjhIwJYVUg7rR91EcFIvrM54vduDHCwLM8O+2wJHI+g0s1
 Xfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kFHCkvQZ1cHoH8S4xIHrewTLe5e5pOA3+HbcRuywdLk=;
 b=ipm4fpqzTlhR7fC4E3wxYnBUOcSzQIt2SnV1fKgCa4ds2wtJBX+id0dTPNgre6Frzp
 AZLAi3Wb4u09LyhtIZshy8RQ+1mIiRaoRXbQbJIk4LNbX9S0SGchS8AhznXrrJJU81Fj
 NNe5xLvVi4YXNjnEShvM2KqCdlNrau0amEcB7NFHXWKW/RQjBf8SX53P6ULhPwQtAWhl
 mY2hmg+33ir7v32jGZv9NYmywA7qDenBgKjJLXfyq+iJo2tb8eZ0rmgGR54M8COfGyQh
 gSQsvy0fKKc7luATaeDmKWCmuiuShvZ4deEbaGUDPE1UP4uIQeOADphkF3OYDRrzUwv+
 i7sA==
X-Gm-Message-State: AOAM531VIV1jDMVzOdD3PqJeewVXSdI22wd/tEy33bG2ljRUnmqb2nOI
 e2KtZcZFZVqPTNfSR83JEz9DFVVivic=
X-Google-Smtp-Source: ABdhPJxrVsYzGxnIFgkqLWVXbsZ/+QfuBnYf7FnG6RzMMXsUzgdbL5YpskpfxS/9CXuDnD98lSUSaQ==
X-Received: by 2002:adf:b745:: with SMTP id n5mr8769152wre.338.1631472773996; 
 Sun, 12 Sep 2021 11:52:53 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id s14sm4599279wmc.25.2021.09.12.11.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Sep 2021 11:52:53 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: PLEASE, IGNORE THIS THREAD - BAD FORMATTING
Date: Sun, 12 Sep 2021 12:52:39 -0600
Message-Id: <20210912185239.13303-1-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210912010731.471859-1-anton@lightbitslabs.com>
References: <20210912010731.471859-1-anton@lightbitslabs.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210912_115255_729908_31B8EE08 
X-CRM114-Status: UNSURE (   5.65  )
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
