Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234A7C47088
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Dec 2022 09:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=K/84WGFnKQ7IKzTRz8Gk/a+woHrZ+NiTyywhiD18Xt8=; b=py0fmwjA0a4JF0zj0Cu4yc1cOd
	NGeDog8z1+7wwjALMQYm1Y1Ix0QrUmS2qLhKVXA7346OqKPFwrQd8qZjPtKzmcw9WJa/MM7vbd65n
	8K4VfeIbhGCtlUusfmzlXbZWQ2i9qEM/0cogN/x35T/QutBP9ig0FO7L8FBI3YlhfQhRZpPgpFmio
	coHVf2HoRAmg5UpIENzvnptr6pJLtk3UU6ax3gLBJ22fs9BGXVrRorxi8RzEse3rVHsst7eL6Y/w2
	vEp8dBIY4fiuiS1Xtm1oZMsVDltoJ/QCuj5LqtAL5HHYNFIFM3YgFi9AfyRChNFAJfT6Fyz/8tE7O
	FsvTMdog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p12oM-00FD1O-E4; Fri, 02 Dec 2022 09:58:26 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p12oJ-00FCwh-8B
	for linux-nvme@lists.infradead.org; Fri, 02 Dec 2022 09:58:24 +0000
Received: by mail-wm1-x333.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so6093754wmb.2
        for <linux-nvme@lists.infradead.org>; Fri, 02 Dec 2022 01:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/84WGFnKQ7IKzTRz8Gk/a+woHrZ+NiTyywhiD18Xt8=;
        b=MnAAdU+M2XkOQz1DkNSgNycPjxT3QIfsA325YYNwty0OyO7n7w8wkqnwoQzarg8LjW
         tn9W1gpJVmVBXPqK8wZpJiuf7aWyIZ6RotmqbezqkuPh37Y6Hcx1OAiwpApRe+yKk/bL
         BznkEjXHXmPvSc1m3MVB3fr8bRsW9ibWwVBisqFqhqgwIXGj9cl81kRAP1aZhoP4A84G
         MTvw/emh3JiUDdgzR2vyJfzf5qgHTUwYBrL/uXqa6Z5Uag891jBcDUouyDX/pXVFf+J3
         Uouy38OvMT/gAEUFz8N2s2a3cpX3DwifONoSlubQVucHUhyBD7UKzWfSvlTNsGZJeE6E
         nN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/84WGFnKQ7IKzTRz8Gk/a+woHrZ+NiTyywhiD18Xt8=;
        b=jouo6YU9teCH7mPw9xMa2DRcy/suIIUGwzca4pixK2KYfWXk7R4DTGNFICpPYy3q5t
         rsCcxEYBqEO6C/rz3/6gLhrSUHi+kn8bEZH4uPxs3Ub4eGmWrjwjQFhRfd+dFXbRqOCY
         V3XtLea25oGiSRkewPOWTiVgOJ14J8PC364PlCAmVzDxnBtJUIf9nVmQQWnU1NOckUeA
         Ed16KSGHpBPs8KUsFuwIYLh+xZvkm7b2Muhp0sqI+HbTb/kS/JP5XeTogSOQoH54xpag
         X3AI5+7pLa+vlfuJTD2bHYjBLL7UWWzorzXViyTZo9dfHaXP/yqtuw5Yf9Ocz9zBlC92
         wl3A==
X-Gm-Message-State: ANoB5pkRU/E70JdZX3THTUM3s1RbapAdL38BlXIPy+zHPVo2MyPC/zlS
	/G7jIWaWCMVwFejn4fNKiY5Jq7uycwQ=
X-Google-Smtp-Source: AA0mqf5blCc3XJxPZzrbA/QNRoCHFP32IJdmreXNkmo4BGykE6JYHV4WDCqvwTrgnZ59JANIBRyNrg==
X-Received: by 2002:a05:600c:2284:b0:3d0:88b4:9cee with SMTP id 4-20020a05600c228400b003d088b49ceemr909750wmf.203.1669975098906;
        Fri, 02 Dec 2022 01:58:18 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003c6cd82596esm13901355wmq.43.2022.12.02.01.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 01:58:18 -0800 (PST)
Date: Fri, 2 Dec 2022 12:58:14 +0300
From: Dan Carpenter <error27@gmail.com>
To: christophe.jaillet@wanadoo.fr
Cc: linux-nvme@lists.infradead.org
Subject: [bug report] nvme-fc: improve memory usage in nvme_fc_rcv_ls_req()
Message-ID: <Y4nMNk+XvcAQDrmt@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221202_015823_331706_1AAAE989 
X-CRM114-Status: UNSURE (   6.72  )
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

Hello Christophe JAILLET,

The patch cf3d00840170: "nvme-fc: improve memory usage in
nvme_fc_rcv_ls_req()" from Oct 2, 2022, leads to the following Smatch
static checker warning:

drivers/nvme/host/fc.c:1757 nvme_fc_rcv_ls_req() error: potential null dereference 'lsop'.  (kzalloc returns null)
drivers/nvme/host/fc.c:1759 nvme_fc_rcv_ls_req() warn: variable dereferenced before check 'lsop' (see line 1757)

drivers/nvme/host/fc.c
    1747         if (lsreqbuf_len > sizeof(union nvmefc_ls_requests)) {
    1748                 dev_info(lport->dev,
    1749                         "RCV %s LS failed: payload too large\n",
    1750                         (w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
    1751                                 nvmefc_ls_names[w0->ls_cmd] : "");
    1752                 ret = -E2BIG;
    1753                 goto out_put;
    1754         }
    1755 
    1756         lsop = kzalloc(sizeof(*lsop), GFP_KERNEL);
--> 1757         lsop->rqstbuf = kzalloc(sizeof(*lsop->rqstbuf), GFP_KERNEL);
                 ^^^^^^^^^^^^^

    1758         lsop->rspbuf = kzalloc(sizeof(*lsop->rspbuf), GFP_KERNEL);
    1759         if (!lsop || !lsop->rqstbuf || !lsop->rspbuf) {
                      ^^^^

    1760                 dev_info(lport->dev,
    1761                         "RCV %s LS failed: No memory\n",
    1762                         (w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
    1763                                 nvmefc_ls_names[w0->ls_cmd] : "");
    1764                 ret = -ENOMEM;
    1765                 goto out_free;
    1766         }
    1767 

regards,
dan carpenter

