Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1ADC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5FE+HUPcA2hbnwP/Iy7TUAQJS4DjeZwWQXCyrj84bfg=; b=qc558I+q9O77Qsw0aVTW5bjMYe
	fE+Y9rAAM4v5ussO6VDgg39p/v6+ZRODzU1+WYeGGUPya6Za0T/revzd6bmhR/U4evMZEMRphxTH7
	yyBdv9PodL08vIsiquO1Z4gftAivpXjMcWazLNiGKmBLPzmA0dviPGZEsNQnJUjOPaZxp5KhDlfmP
	IbOH7oLjyKH2ALNaAtBFzbEXMHqJPNCy2+FE3Kq1T7+5Am7uvgv6j5a7k3Hc7XAbys8RihRfersba
	slqbxexiKM6yckdZb1insX4dOmTrNtAg6qs1UnJ+4fEoyoAfP1fHnkJVsNDZhHxH4FSeStQyvZ3X6
	eW8gyrUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4ljk-0027Yt-28; Mon, 12 Dec 2022 16:33:04 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4ljh-0027YR-2J
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 16:33:03 +0000
Received: by mail-ed1-x529.google.com with SMTP id i9so785440edj.4
        for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 08:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5FE+HUPcA2hbnwP/Iy7TUAQJS4DjeZwWQXCyrj84bfg=;
        b=h+jj3PNQ7yn4XGT78kQUPdUQuAduQQF4I+lcXESxNoU0ovHSNcdqhKyY6jeEynfsDl
         RgXa0LsEA5h1lTiK5UskdDDvBCTgYeS9HDCKJtGUyRf56KbZ4nzhfTgsAWliXuqsGGoy
         ChJI6YK1ZviOJ+m/Ajug4LNxqvFckghb9/cOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5FE+HUPcA2hbnwP/Iy7TUAQJS4DjeZwWQXCyrj84bfg=;
        b=FPg+Gt3qOJuRp+XtesFXzOfiAvkQOtWjnLPKRFAMRURHbev71SVYPIcPL4Imh7N7m+
         J2Kv5x/sotVX4AJ1+WBMwFEVRFaQdR5ViNWZ8CyyxpBctSl4bn/6enev4eRDWJ9Bt20Y
         /gtS6ngfbNQ5/lE4KBuAsi8rlq0kmWKlxHxv5EjBRXit5d9D/uAe1NbsKF5BUSjgJWqm
         NgOs+2x2dWPDJr8SFvITNXGRbkr2xPUKml2vNKbtnCRhtR5JCmdGK3TSorxVd4aOiv/B
         oh/4xiS/+aPsylgJqI3dHkZQg9nk//li3ukPU0HrV3LoOSZAjrzd8umie8fXfFJyoOvh
         eHfw==
X-Gm-Message-State: ANoB5pmFD6M3exvXwfgSSIeAIgMkrkyU+YuG4phRhznFFtL9oOE8zPfJ
	rS4ap8dG7SQIBTlFAI6zwAi8Lr0kpsvz9O4mDybDbDWjiWnwzzhb
X-Google-Smtp-Source: AA0mqf7EwR+QDk0I9nQ/EFCwhia3bEat4hQIoHbSKNEECfYFD/4eV2ywMXCjpiGeOcH3czFV2HOV+eBsMKm1u8fBc5c=
X-Received: by 2002:a05:6402:203b:b0:464:1297:8412 with SMTP id
 ay27-20020a056402203b00b0046412978412mr4923612edb.50.1670862776490; Mon, 12
 Dec 2022 08:32:56 -0800 (PST)
MIME-Version: 1.0
References: <1670855159-3182917-1-git-send-email-amit.engel@dell.com> <1670855159-3182917-2-git-send-email-amit.engel@dell.com>
In-Reply-To: <1670855159-3182917-2-git-send-email-amit.engel@dell.com>
From: Caleb Sander <csander@purestorage.com>
Date: Mon, 12 Dec 2022 08:32:45 -0800
Message-ID: <CADUfDZo88Z5Es4CF+X0LMOJChsRCXK23xzo9xQfd-pAdMFATNA@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: add nvme_opcode_str function for all nvme cmd types
To: amit.engel@dell.com
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_083301_326457_AD8579AF 
X-CRM114-Status: UNSURE (   6.67  )
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

On Mon, Dec 12, 2022 at 6:33 AM <amit.engel@dell.com> wrote:
>
> +const unsigned char *nvme_get_fabrics_opcode_str(u8 opcode) {
> +       if (opcode < ARRAY_SIZE(nvme_admin_ops) && nvme_fabrics_ops[opcode])
> +               return nvme_fabrics_ops[opcode];

Why bounds-check opcode against nvme_admin_ops but access nvme_fabrics_ops?

